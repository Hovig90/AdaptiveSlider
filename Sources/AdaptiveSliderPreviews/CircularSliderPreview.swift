//
//  SwiftUIView.swift
//  AdaptiveSlider
//
//  Created by John Kousherian on 2024-12-12.
//

import SwiftUI
import AdaptiveSlider

/// NOTE: To display this preview in Xcode:
/// 1. Ensure the `AdaptiveSliderPreviews` target is included as a dependency in the `Package.swift` manifest file.
/// 2. Add `AdaptiveSliderPreviews` to the `products` section of your package manifest temporarily.
///    Example:
///    ```
///    .library(
///        name: "AdaptiveSlider",
///        targets: ["AdaptiveSlider", "AdaptiveSliderPreviews"]
///    )
///    ```
/// 3. Ensure the preview file is part of the `AdaptiveSliderPreviews` target under Target Membership.
/// 4. After testing, you can remove `AdaptiveSliderPreviews` from the `products` section
/// to avoid shipping it in production.
private struct CircularSliderPreviewView: View {
	@State private var sliderValue1: Double = 25
	@State private var sliderValue2: Double = 60

	var body: some View {
		VStack(spacing: 40) {
			CircularSlider(
				value: $sliderValue1,
				in: 0...100) {
					Text("\(Int(sliderValue1))")
				}
				.tint(
					LinearGradient(
						colors: [.red, .orange, .yellow],
						startPoint: .top,
						endPoint: .bottom
					)
				)

			CircularSlider(
				value: $sliderValue2,
				in: 0...100) {
					Text("\(Int(sliderValue2))")
				}
				.tint(.red)
				.trackStyle(lineWidth: 10, color: .green)
				.showTicks(count: 100, color: .yellow)
		}
	}
}

#Preview {
	CircularSliderPreviewView()
}
