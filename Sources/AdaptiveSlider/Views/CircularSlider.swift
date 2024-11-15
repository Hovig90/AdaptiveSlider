//
//  CircularSlider.swift
//
//
//  Created by John Kousherian on 2024-11-15.
//

import SwiftUI

public struct CircularSlider<Value: BinaryFloatingPoint, Label: View>: CircularSliderConfigurable where Value.Stride: BinaryFloatingPoint {

	public var value: Binding<Value>
	public var bounds: ClosedRange<Value>
	public var step: Value.Stride
	public var label: () -> Label

	public var radius: CGFloat = 100
	public var thumbRadius: CGFloat = 11
	public var thumbColor: Color = .white
	public var trackColor: Color = .gray
	public var lineWidth: CGFloat = 5

	public init(
		value: Binding<Value>,
		in bounds: ClosedRange<Value>,
		step: Value.Stride,
		@ViewBuilder label: @escaping () -> Label
	) {
		self.value = value
		self.bounds = bounds
		self.step = step
		self.label = label
	}

	public var body: some View {
		VStack {
			label()
		}
	}
}

struct PreviewCircularSlider: View {
	@State private var value: Double = 50
	var body: some View {
		VStack {
			CircularSlider(
				value: $value) {
					Text("Hello World")
				}
			CircularSlider(value: $value)
		}
	}
}

#Preview {
	PreviewCircularSlider()
}
