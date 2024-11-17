import SwiftUI

public extension AdaptiveSlider {
	func tint(_ tint: Color?) -> Self {
		guard let tint else { return self }
		var copy = self
		copy.progressColor = tint
		return copy
	}
}

public extension AdaptiveSlider {
	func trackStyle(lineWidth: CGFloat, color: Color = Color(.systemGray5)) -> Self {
		var copy = self
		copy.lineWidth = lineWidth
		copy.trackColor = color
		return copy
	}
}

public extension AdaptiveSlider {
	func thumbStyle(radius: CGFloat, color: Color = .white) -> Self {
		var copy = self
		copy.thumbRadius = radius
		copy.thumbColor = color
		return copy
	}
}

public extension AdaptiveSlider {
	func showTicks(
		count: Int,
		size: CGSize? = nil,
		color: Color = Color(.systemGray2)
	) -> Self {
		var copy = self
		copy.showTicks = true
		copy.tickCount = count
		copy.tickSize = size ?? CGSize(width: 1.5, height: lineWidth)
		copy.tickColor = color
		return copy
	}
}

public extension AdaptiveSlider {
	func hapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle) -> Self {
		var copy = self
		copy.feedbackGenerator = UIImpactFeedbackGenerator(style: style)
		return copy
	}
}

public extension AdaptiveSlider {
	/// Enables customization of the accessibility **Value**, **Hint**, and **Label** for `AdaptiveSlider`.
	///
	/// - Note: By default the accessibilityValue is set to whatever is the current value of the slider is suffixed by "Precent", both accessibilityHint and accessibilityLabel are empty strings.
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
	func accessibilityValue(_ value: String, hint: String = "", label: String = "") -> Self {
		var copy = self
		copy.accessibilityValue = value
		copy.accessibilityHint = hint
		copy.accessibilityLabel = label
		return copy
	}
}
