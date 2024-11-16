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
	public var trackColor: Color = Color(.systemGray5)
	public var progressColor: Color = Color(.systemBlue)
	public var lineWidth: CGFloat = 5

	private var angle: Double {
		valueToAngle(value: value.wrappedValue)
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
	}

	public var body: some View {
		ZStack {
			// Track Circle
			Circle()
				.stroke(trackColor, style: StrokeStyle(lineWidth: lineWidth * 1.3, lineCap: .butt))
				.frame(width: radius * 2, height: radius * 2)

			// Progress Circle
			Circle()
				.trim(from: 0.0, to: CGFloat(valueAsPercentage(value: value.wrappedValue)))
				.stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
				.foregroundColor(progressColor)
				.frame(width: radius * 2, height: radius * 2)
				.rotationEffect(.degrees(-90))

			// Thumb
			Circle()
				.fill(thumbColor)
				.shadow(color: Color.black.opacity(0.25), radius: 2)
				.frame(width: thumbRadius * 2.5, height: thumbRadius * 2.5)
				.offset(y: -radius)
				.rotationEffect(Angle.degrees(angle))
				.gesture(
					DragGesture(minimumDistance: 0.0)
						.onChanged { gesture in
							change(location: gesture.location)
						}
				)

			label()
		}
	}

	/// Updates the slider's value and angle based on the touch location.
	private func change(location: CGPoint) {
		let vector = CGVector(dx: location.x, dy: location.y)
		let newAngle = atan2(vector.dy, vector.dx) + .pi / 2.0
		let fixedAngle = normalizeAngle(newAngle)
		let newValue = angleToValue(angleInRadians: fixedAngle)

		let snappedValue = snapToIncrement(newValue: newValue)

		if isBeyondThreshold(snappedValue) {
			updateCurrentValue(with: Double(snappedValue), angle: fixedAngle)
		}
	}

	/// Normalizes the angle to be within 0 to 2π radians.
	private func normalizeAngle(_ angle: Double) -> Double {
		angle < 0.0 ? angle + 2.0 * .pi : angle
	}

	/// Snaps the new value to the nearest step increment.
	private func snapToIncrement(newValue: Value) -> Value {
		let stepValue = Value(step)
		return (newValue / stepValue).rounded() * stepValue
	}

	/// Determines if the new value is significantly different from the current value.
	private func isBeyondThreshold(_ value: Value) -> Bool {
		let currentValueAsPercentage = valueAsPercentage(value: self.value.wrappedValue)
		let diff = abs(value - self.value.wrappedValue)
		let diffThreshold = 0.15 * bounds.range

		if currentValueAsPercentage > 0.9 && diff > diffThreshold {
			self.value.wrappedValue = bounds.upperBound
			return false
		} else if currentValueAsPercentage < 0.1 && diff > diffThreshold {
			self.value.wrappedValue = bounds.lowerBound
			return false
		} else {
			return value != self.value.wrappedValue
		}
	}

	/// Updates the current value and recalculates the angle.
	private func updateCurrentValue(with value: Double, angle: Double) {
		self.value.wrappedValue = Value(value)
	}

	/// Converts an angle in radians to the corresponding slider value.
	private func angleToValue(angleInRadians: Double) -> Value {
		let angleAsPercentage = angleInRadians / (2.0 * .pi)
		let newValue = Value(angleAsPercentage) * bounds.range + bounds.lowerBound
		return newValue
	}

	/// Converts a value to the corresponding angle in degrees.
	private func valueToAngle(value: Value) -> Double {
		return 360 * valueAsPercentage(value: value)
	}

	/// Calculates the percentage of the value within the bounds.
	private func valueAsPercentage(value: Value) -> Double {
		let range = Double(bounds.range)
		let adjustedValue = Double(value - bounds.lowerBound)
		return adjustedValue / range
	}
}

struct PreviewCircularSlider: View {
	@State private var value: Double = 50
	var body: some View {
		VStack {
			CircularSlider(
				value: $value) {
					Text("Hello World")
				}
			CircularSlider(value: $value)
		}
	}
}

#Preview {
	PreviewCircularSlider()
}
