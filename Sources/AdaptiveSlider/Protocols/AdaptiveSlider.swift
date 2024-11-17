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
	var thumbRadius: CGFloat { get set }
	var thumbColor: Color { get set }

	// Track Properties
	var trackColor: Color { get set }
	var progressColor: Color { get set }
	var lineWidth: CGFloat { get set }

	// Optional Ticks
	var showTicks: Bool { get set }
	var tickCount: Int { get set }
	var tickSize: CGSize { get set }
	var tickColor: Color { get set }

	/// Optional feedback generator for haptics
	var feedbackGenerator: UIImpactFeedbackGenerator? { get set }

	// Accessibility properties

	/// This label should describe what the slider represents, making it easier for assistive technologies to convey its purpose.
	var accessibilityLabel: String { get set }

	/// This value should reflect the current position or setting of the slider, helping users understand its current state.
	var accessibilityValue: String { get set }

	/// Communicates to the user what happens after performing the slider’s action.
	var accessibilityHint: String { get set }

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
	///   - bounds: The range within which the slider operates. Defaults to `0...1`.
	///   - label: A closure returning a label view to display with the slider.
	public init(
		value: Binding<Value>,
		in bounds: ClosedRange<Value> = 0...1,
		@ViewBuilder label: @escaping () -> Label
	) {
		self.init(
			value: value,
			in: bounds,
			step: 0.01,
			label: label)
	}

	/// Initializes an adaptive slider with default bounds, step values, and no label.
	/// - Parameters:
	///   - value: The current value of the slider.
	///   - bounds: The range within which the slider operates. Defaults to `0...1`.
	public init(
		value: Binding<Value>,
		in bounds: ClosedRange<Value> = 0...1
	) where Label == EmptyView {
		self.init(
			value: value,
			in: bounds,
			step: 0.01,
			label: { EmptyView() })
	}

	/// Initializes an adaptive slider with default bounds and step values.
	/// - Parameters:
	///   - value: The current value of the slider.
	///   - bounds: The range within which the slider operates.
	///   - step: The incremental step for the slider’s value. Defaults to `1`.
	///   - label: A closure returning a label view to display with the slider.
	public init(
		value: Binding<Value>,
		in bounds: ClosedRange<Value>,
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
	///   - bounds: The range within which the slider operates.
	///   - step: The incremental step for the slider’s value. Defaults to `1`.
	public init(
		value: Binding<Value>,
		in bounds: ClosedRange<Value>,
		step: Value.Stride = 1
	) where Label == EmptyView {
		self.init(
			value: value,
			in: bounds,
			step: step,
			label: { EmptyView() })
	}
}
