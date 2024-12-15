import SwiftUI

/// A type alias representing a flexible style for filling a shape.
///
/// `AdaptiveStyle` can be used for colors, gradients, or other fill styles.
/// This typealias makes it easier to apply either solid colors or gradients
/// (e.g., `LinearGradient`, `RadialGradient`, `AngularGradient`)
/// to views, enhancing the versatility of UI components like sliders.
///
/// Example usage:
/// ```swift
/// let style: AdaptiveStyle = LinearGradient(colors: [.red, .blue], startPoint: .leading, endPoint: .trailing)
/// ```
public typealias AdaptiveStyle = (any ShapeStyle)

// MARK: - AdaptiveSlider Protocol

/// A protocol defining the behaviour of adaptive sliders.
///
/// `AdaptiveSlider` provides customizable slider functionality with both linear and circular options.
/// It allows developers to create highly stylized sliders with custom thumb styles,
///  track colors, ticks, labels, and haptic feedback.
@MainActor
public protocol AdaptiveSlider: View {
	associatedtype Value: BinaryFloatingPoint where Value.Stride: BinaryFloatingPoint
	associatedtype Label: View

	// Core Slider Properties

	/// The current value of the slider.
	var value: Binding<Value> { get }

	/// The range within which the slider operates.
	var bounds: ClosedRange<Value> { get }

	/// The incremental step for the slider's value.
	var step: Value.Stride { get }

	// Thumb Properties

	/// The radius of the slider's thumb.
	var thumbRadius: CGFloat { get set }

	/// The color of the slider's thumb.
	var thumbColor: Color { get set }

	// Track Properties

	/// The color of the slider's track.
	var trackColor: Color { get set }

	/// The color or gradient style used for the progress line
	var progressColor: AdaptiveStyle? { get set }

	/// The width of the track line.
	var lineWidth: CGFloat { get set }

	// Optional Ticks

	/// Indicates whether ticks are displayed on the slider.
	var showTicks: Bool { get set }

	/// The number of ticks to display on the slider.
	var tickCount: Int { get set }

	/// The size of the ticks displayed on the slider.
	var tickSize: CGSize { get set }

	/// The color of the ticks displayed on the slider.
	var tickColor: Color { get set }

#if os(iOS)
	/// Optional feedback generator for providing haptic feedback during slider interaction.
	///
	/// Available on iOS only, this property allows the slider to provide tactile feedback during movement.
	var feedbackGenerator: UIImpactFeedbackGenerator? { get set }
#endif

	// Accessibility properties

	/// This label should describe what the slider represents,
	/// making it easier for assistive technologies to convey its purpose.
	var accessibilityLabel: String { get set }

	/// This value should reflect the current position or setting of the slider,
	/// helping users understand its current state.
	var accessibilityValue: String { get set }

	/// Communicates to the user what happens after performing the slider’s action.
	var accessibilityHint: String { get set }

	// Label

	/// A closure returning a label view to display with the slider.
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
