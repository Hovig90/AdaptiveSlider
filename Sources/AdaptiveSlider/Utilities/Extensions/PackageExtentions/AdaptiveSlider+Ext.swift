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
