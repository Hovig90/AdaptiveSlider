import SwiftUI

protocol AdaptiveSlider: View {
	associatedtype Value: BinaryFloatingPoint where Value.Stride: BinaryFloatingPoint

	var value: Value { get }
}
