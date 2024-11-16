//
//  CircularSliderConfigurable.swift
//
//
//  Created by John Kousherian on 2024-11-15.
//

import Foundation

public protocol CircularSliderConfigurable: AdaptiveSlider {
	// Property specific to circular sliders
	var radius: CGFloat { get set }
}

public extension CircularSliderConfigurable {
	func radius(_ radius: CGFloat) -> Self {
		var copy = self
		copy.radius = radius
		return copy
	}
}

