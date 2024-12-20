//
//  CircularSlider.swift
//
//
//  Created by John Kousherian on 2024-11-15.
//

import SwiftUI

public struct CircularSlider<Value: BinaryFloatingPoint, Label: View>: CircularSliderConfigurable where Value.Stride: BinaryFloatingPoint {

	public var value: Binding<Value>
	public var bounds: ClosedRange<Value>
	public var step: Value.Stride
	public var label: () -> Label

	public var radius: CGFloat = 100
	public var thumbRadius: CGFloat = 11
	public var thumbColor: Color = .white

#if os(iOS)
	public var trackColor: Color = Color(.systemGray5)
#else
	public var trackColor: Color = Color.gray
#endif

	public var progressColor: AdaptiveStyle?
	public var lineWidth: CGFloat = 5
	public var showTicks: Bool = false
	public var tickCount: Int = 0
	public var tickSize: CGSize = .zero
	public var tickColor: Color = .clear
	public var accessibilityLabel: String = ""
	public var accessibilityValue: String = ""
	public var accessibilityHint: String = ""

#if os(iOS)
	public var feedbackGenerator: UIImpactFeedbackGenerator?
#endif

	private var angle: Double {
		angleDegrees(forValue: value.wrappedValue)
	}

	public init(
		value: Binding<Value>,
		in bounds: ClosedRange<Value>,
		step: Value.Stride,
		@ViewBuilder label: @escaping () -> Label
	) {
		self.value = value
		self.step = step
		self.label = label

		// Adjust bounds to include the initial value if necessary
		let lowerBound = min(bounds.lowerBound, value.wrappedValue)
		let upperBound = max(bounds.upperBound, value.wrappedValue)
		self.bounds = lowerBound...upperBound

		// Warning for step >= upperBound - lowerBound
		if step >= Value.Stride(self.bounds.range) {
			assertionFailure("Step must be less than the range of bounds.")
		}

		self.accessibilityValue = "\(Int(value.wrappedValue)) percent"
	}

	public var body: some View {
		ZStack {
			trackCircleView

			if showTicks {
				ticksView
			}

			progressCircleView

			thumbView

			label()
		}
		.accessibilityElement()
		.accessibilityLabel(accessibilityLabel)
		.accessibilityHint(accessibilityHint)
		.accessibilityValue(accessibilityValue)
		.accessibilityAdjustableAction(adjustValue(for:))
		.onAppear {
#if os(iOS)
			feedbackGenerator?.prepare()
#endif
		}
	}
}

// MARK: Views

private extension CircularSlider {
	var trackCircleView: some View {
		Circle()
			.stroke(trackColor, style: StrokeStyle(lineWidth: lineWidth - 0.5, lineCap: .butt))
			.frame(width: radius * 2, height: radius * 2)
	}

	var ticksView: some View {
		ForEach(0..<tickCount, id: \.self) { index in
			Rectangle()
				.fill(tickColor)
				.frame(width: tickSize.width, height: tickSize.height)
				.offset(y: -radius)
				.rotationEffect(.degrees(Double(index) / Double(tickCount) * 360))
		}
	}

	var progressCircleView: some View {
		Circle()
			.trim(from: 0.0, to: CGFloat(percentage(ofValue: value.wrappedValue)))
			.stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
			.foregroundStyle(progressFill)
			.frame(width: radius * 2, height: radius * 2)
			.rotationEffect(.degrees(-90))
	}

	var thumbView: some View {
		Circle()
			.fill(thumbColor)
			.shadow(color: Color.black.opacity(0.25), radius: 2)
			.frame(width: thumbRadius * 2.5, height: thumbRadius * 2.5)
			.offset(y: -radius)
			.rotationEffect(Angle.degrees(angle))
			.gesture(
				DragGesture(minimumDistance: 0.0)
					.onChanged { gesture in
						handleDrag(at: gesture.location)
					}
			)
	}
}

// MARK: Helpers

private extension CircularSlider {
	/// Updates the slider's value and angle based on the touch location.
	func handleDrag(at location: CGPoint) {
		let vector = CGVector(dx: location.x, dy: location.y)
		let newAngle = atan2(vector.dy, vector.dx) + .pi / 2.0
		let fixedAngle = normalizeAngle(newAngle)
		let newValue = value(fromAngleRadians: fixedAngle)

		let snappedValue = snappedValue(newValue)

		if shouldUpdateValue(to: snappedValue) {
			value.wrappedValue = snappedValue
#if os(iOS)
			feedbackGenerator?.impactOccurred()
#endif
		}
	}

	/// Normalizes an angle in radians to be within 0 to 2π.
	/// - Parameter angle: The angle in radians.
	/// - Returns: The normalized angle in radians between 0 and 2π.
	func normalizeAngle(_ angle: CGFloat) -> CGFloat {
		let twoPi = 2.0 * .pi
		let normalizedAngle = angle.truncatingRemainder(dividingBy: twoPi)
		return normalizedAngle >= 0 ? normalizedAngle : normalizedAngle + twoPi
	}

	/// Snaps the new value to the nearest step increment.
	func snappedValue(_ value: Value) -> Value {
		let stepValue = Value(step)
		return (value / stepValue).rounded() * stepValue
	}

	/// Determines if the new value is significantly different from the current value.
	func shouldUpdateValue(to value: Value) -> Bool {
		let currentValueAsPercentage = percentage(ofValue: self.value.wrappedValue)
		let diff = abs(value - self.value.wrappedValue)
		let diffThreshold = 0.15 * bounds.range

		if diff > diffThreshold {
			if currentValueAsPercentage > 0.9 {
				self.value.wrappedValue = bounds.upperBound
				return false
			} else if currentValueAsPercentage < 0.1 {
				self.value.wrappedValue = bounds.lowerBound
				return false
			}
		}

		return value != self.value.wrappedValue
	}

	/// Converts an angle in radians to the corresponding slider value.
	func value(fromAngleRadians angle: Double) -> Value {
		let angleAsPercentage = angle / (2.0 * .pi)
		let newValue = Value(angleAsPercentage) * bounds.range + bounds.lowerBound
		return newValue
	}

	/// Converts a value to the corresponding angle in degrees.
	func angleDegrees(forValue value: Value) -> Double {
		return 360 * percentage(ofValue: value)
	}

	/// Calculates the percentage of the value within the bounds.
	func percentage(ofValue value: Value) -> Double {
		let range = Double(bounds.range)
		let adjustedValue = Double(value - bounds.lowerBound)
		return adjustedValue / range
	}

	func adjustValue(for direction: AccessibilityAdjustmentDirection) {
		switch direction {
		case .increment:
			value.wrappedValue = min(value.wrappedValue + Value(step), bounds.upperBound)
		case .decrement:
			value.wrappedValue = max(value.wrappedValue - Value(step), bounds.lowerBound)
		@unknown default:
			break
		}
	}
}
