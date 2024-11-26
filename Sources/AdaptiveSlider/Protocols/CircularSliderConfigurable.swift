//
//  CircularSliderConfigurable.swift
//
//
//  Created by John Kousherian on 2024-11-15.
//

import Foundation

/// A protocol that extends `AdaptiveSlider` for circular sliders.
///
/// `CircularSliderConfigurable` adds properties and methods specific to circular sliders,
/// allowing the customization of circular-specific attributes like the radius.
public protocol CircularSliderConfigurable: AdaptiveSlider {

	/// The radius of the circular slider.
	///
	/// This property defines the distance from the center of the slider to its thumb.
	/// It affects the overall size and the interactive area of the circular slider.
	var radius: CGFloat { get set }
}

public extension CircularSliderConfigurable {

	/// Sets the radius of the circular slider.
	///
	/// - Parameter radius: A `CGFloat` value representing the radius of the circular slider.
	/// - Returns: An updated copy of the circular slider with the new radius applied.
	///
	/// Use this modifier to adjust the radius of the circular slider to fit your layout and visual design.
	///
	/// Example usage:
	/// ```swift
	/// CircularSlider(value: $sliderValue, in: 0...100)
	///     .radius(150)
	/// ```
	func radius(_ radius: CGFloat) -> Self {
		var copy = self
		copy.radius = radius
		return copy
	}
}
