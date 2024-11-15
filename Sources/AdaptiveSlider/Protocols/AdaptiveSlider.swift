import SwiftUI

// MARK: - AdaptiveSlider Protocol

/// A protocol defining the behaviour of adaptive sliders.
public protocol AdaptiveSlider: View {
	associatedtype Value: BinaryFloatingPoint where Value.Stride: BinaryFloatingPoint
	associatedtype Label: View

	// Core Slider Properties
	var value: Binding<Value> { get }
	var bounds: ClosedRange<Value> { get }
	var step: Value.Stride { get }

	// Thumb Properties
	var thumbRadius: CGFloat { get }
	var thumbColor: Color { get }

	// Track Properties
	var trackColor: Color { get }
	var lineWidth: CGFloat { get }

	// Label
	var label: () -> Label { get }

	/// Initializes an adaptive slider.
	/// - Parameters:
	///   - value: The current value of the slider.
	///   - bounds: The range within which the slider operates.
	///   - step: The incremental step for the slider’s value.
	///   - label: A closure returning a label view to display with the slider.
	init(
		value: Binding<Value>,
		in bounds: ClosedRange<Value>,
		step: Value.Stride,
		@ViewBuilder label: @escaping () -> Label
	)
}

extension AdaptiveSlider {
	/// Initializes an adaptive slider with default bounds and step values.
	/// - Parameters:
	///   - value: The current value of the slider.
	///   - bounds: The range within which the slider operates. Defaults to `0...100`.
	///   - step: The incremental step for the slider’s value. Defaults to `1`.
	///   - label: A closure returning a label view to display with the slider.
	public init(
		value: Binding<Value>,
		in bounds: ClosedRange<Value> = 0...100,
		step: Value.Stride = 1,
		@ViewBuilder label: @escaping () -> Label
	) {
		self.init(
			value: value,
			in: bounds,
			step: step,
			label: label)
	}

	/// Initializes an adaptive slider with default bounds, step values, and no label.
	/// - Parameters:
	///   - value: The current value of the slider.
	///   - bounds: The range within which the slider operates. Defaults to `0...100`.
	///   - step: The incremental step for the slider’s value. Defaults to `1`.
	public init(
		value: Binding<Value>,
		in bounds: ClosedRange<Value> = 0...100,
		step: Value.Stride = 1
	) where Label == EmptyView {
		self.init(
			value: value,
			in: bounds,
			step: step,
			label: { EmptyView() })
	}
}
