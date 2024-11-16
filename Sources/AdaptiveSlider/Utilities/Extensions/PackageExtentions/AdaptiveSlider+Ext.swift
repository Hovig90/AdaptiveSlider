import SwiftUI

public extension AdaptiveSlider {
	func tint(_ tint: Color?) -> some AdaptiveSlider {
		guard let tint else { return self }
		var copy = self
		copy.progressColor = tint
		return copy
	}
}

public extension AdaptiveSlider {
	func trackStyle(lineWidth: CGFloat, color: Color = Color(.systemGray5)) -> some AdaptiveSlider {
		var copy = self
		copy.lineWidth = lineWidth
		copy.trackColor = color
		return copy
	}
}

public extension AdaptiveSlider {
	func thumbStyle(radius: CGFloat, color: Color = .white) -> some AdaptiveSlider {
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
	) -> some View {
		var copy = self
		copy.showTicks = true
		copy.tickCount = count
		copy.tickSize = CGSize(width: 1.5, height: lineWidth)
		copy.tickColor = color
		return copy
	}
}
