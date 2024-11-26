import SwiftUI

public extension AdaptiveSlider {
	/// Sets the color or gradient used for the progress line.
	///
	/// - Parameter tint: An optional `AdaptiveStyle` (`Any ShapeStyle`) used to set the progress color or gradient.
	///   If `nil`, the original color remains unchanged.
	/// - Returns: An updated instance of `AdaptiveSlider` with the specified progress color.
	///
	/// Example with regular color:
	/// ```swift
	/// CircularSlider(value: $sliderValue, in: 0...100)
	///     .tint(.red)
	/// ```
	///
	/// Example with gradients:
	/// ```swift
	/// CircularSlider(value: $sliderValue, in: 0...100)
	///     .tint(LinearGradient(
	///				colors: [.red, .orange, .yellow],
	///				startPoint: .top,
	///				endPoint: .bottom))
	/// ```
	func tint(_ tint: AdaptiveStyle?) -> Self {
		guard let tint else { return self }
		var copy = self
		copy.progressColor = tint
		return copy
	}
}

extension AdaptiveSlider {
	/// Provides a computed property for the progress line's fill.
	///
	/// If a custom progress color (`progressColor`) is set, it returns that color.
	/// Otherwise, it defaults to system blue color (`Color(.systemBlue)`).
	var progressFill: AnyShapeStyle {
		if let progressColor {
			return AnyShapeStyle(progressColor)
		} else  {
			return AnyShapeStyle(Color(.systemBlue))
		}
	}
}

public extension AdaptiveSlider {
	/// Sets the style of the track, including its width and color.
	///
	/// - Parameters:
	///   - lineWidth: A `CGFloat` specifying the width of the track line.
	///   - color: An optional `Color` to set as the track color. Defaults to `.systemGray5` on iOS or `.gray` on other platforms.
	/// - Returns: An updated instance of `AdaptiveSlider` with the specified track style.
	///
	/// Example usage:
	/// ```swift
	/// CircularSlider(value: $sliderValue, in: 0...100)
	///     .trackStyle(lineWidth: 5, color: .gray)
	/// ```
	func trackStyle(lineWidth: CGFloat, color: Color? = nil) -> Self {
		var copy = self
		copy.lineWidth = lineWidth
#if os(iOS)
		copy.trackColor = color ?? Color(.systemGray5)
#else
		copy.trackColor = color ?? Color.gray
#endif
		return copy
	}
}

public extension AdaptiveSlider {
	/// Customizes the thumb's radius and color.
	///
	/// - Parameters:
	///   - radius: A `CGFloat` specifying the radius of the thumb.
	///   - color: A `Color` specifying the thumb color. Default is `.white`.
	/// - Returns: An updated instance of `AdaptiveSlider` with the specified thumb style.
	///
	/// Example usage:
	/// ```swift
	/// CircularSlider(value: $sliderValue, in: 0...100)
	///     .thumbStyle(radius: 10, color: .red)
	/// ```
	func thumbStyle(radius: CGFloat, color: Color = .white) -> Self {
		var copy = self
		copy.thumbRadius = radius
		copy.thumbColor = color
		return copy
	}
}

public extension AdaptiveSlider {
	/// Adds visual markers (ticks) to the slider to enhance user interaction.
	///
	/// - Parameters:
	///   - count: An `Int` representing the number of ticks to be shown.
	///   - size: An optional `CGSize` specifying the size of each tick. Defaults to `CGSize(width: 1.5, height: lineWidth)`.
	///   - color: An optional `Color` specifying the tick color. Defaults to `.systemGray2` on iOS or `.gray` on other platforms.
	/// - Returns: An updated instance of `AdaptiveSlider` with the specified ticks.
	///
	/// Example usage:
	/// ```swift
	/// CircularSlider(value: $sliderValue, in: 0...100)
	///     .showTicks(count: 10, size: CGSize(width: 2, height: 5), color: .black)
	/// ```
	func showTicks(
		count: Int,
		size: CGSize? = nil,
		color: Color? = nil
	) -> Self {
		var copy = self
		copy.showTicks = true
		copy.tickCount = count
		copy.tickSize = size ?? CGSize(width: 1.5, height: lineWidth)
#if os(iOS)
		copy.tickColor = color ?? Color(.systemGray2)
#else
		copy.tickColor = color ?? Color.gray
#endif
		return copy
	}
}

#if os(iOS)
public extension AdaptiveSlider {
	/// Adds haptic feedback to the slider during interaction.
	///
	/// - Parameter style: A `UIImpactFeedbackGenerator.FeedbackStyle` specifying the type of haptic feedback.
	/// - Returns: An updated instance of `AdaptiveSlider` with the specified haptic feedback.
	///
	/// Example usage:
	/// ```swift
	/// CircularSlider(value: $sliderValue, in: 0...100)
	///     .hapticFeedback(.medium)
	/// ```
	func hapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle) -> Self {
		var copy = self
		copy.feedbackGenerator = UIImpactFeedbackGenerator(style: style)
		return copy
	}
}
#endif

public extension AdaptiveSlider {
	/// Enables customization of the accessibility **Value**, **Hint**, and **Label** for `AdaptiveSlider`.
	///
	/// - Note: By default, the `accessibilityValue` is set to whatever the current value of the slider is, suffixed by "Percent". Both `accessibilityHint` and `accessibilityLabel` are empty strings.
	///
	/// - Parameters:
	///   - value: A `String` representing the current value of the slider (e.g., "75 percent").
	///            This parameter is required when calling the modifier.
	///   - hint: A `String` providing additional information or instructions about how to use the slider.
	///           Default is an empty string (`""`). Set this to give more context for VoiceOver users,
	///           such as  “Adjust volume”.
	///   - label: A `String` giving a descriptive label for the slider.
	///            Default is an empty string (`""`). This can be used to identify the purpose of the slider more effectively,
	///            such as "Volume control".
	///
	/// - Returns: A modified instance of `AdaptiveSlider` with the specified accessibility properties.
	///
	/// Example usage:
	/// ```swift
	/// CircularSlider(value: $sliderValue, in: 0...100)
	///     .accessibilityValue("75 percent", hint: "Adjust the temperature setting", label: "Temperature Control")
	/// ```
	func accessibilityValue(_ value: String, hint: String = "", label: String = "") -> Self {
		var copy = self
		copy.accessibilityValue = value
		copy.accessibilityHint = hint
		copy.accessibilityLabel = label
		return copy
	}
}
