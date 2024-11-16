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

