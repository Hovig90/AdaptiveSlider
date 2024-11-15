import SwiftUI

// MARK: - AdaptiveSlider Protocol

/// A protocol defining the behaviour of adaptive sliders.
protocol AdaptiveSlider: View {
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
	var label: (() -> Label)? { get }

	/// Initializes an adaptive slider.
	/// - Parameters:
	///   - value: The current value of the slider.
	///   - bounds: The range within which the slider operates.
	///   - step: The incremental step for the slider’s value.
	///   - label: A closure returning a label view to display with the slider.
	init(
		value: Binding<Value>,
		bounds: ClosedRange<Value>,
		step: Value.Stride,
		@ViewBuilder label: (() -> Label)
	)
}
