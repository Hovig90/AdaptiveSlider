//
//  ClosedRange.swift
//
//
//  Created by John Kousherian on 2024-11-15.
//

import Foundation

extension ClosedRange where Bound: BinaryFloatingPoint {
	var range: Bound {
		upperBound - lowerBound
	}
}
