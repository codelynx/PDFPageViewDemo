//
//	GeometricUtils.swift
//	ZKit
//
//	The MIT License (MIT)
//
//	Copyright (c) 2016 Electricwoods LLC, Kaz Yoshikawa.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy 
//	of this software and associated documentation files (the "Software"), to deal 
//	in the Software without restriction, including without limitation the rights 
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
//	copies of the Software, and to permit persons to whom the Software is 
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in 
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
//	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
//


import Foundation
import CoreGraphics


public func DegreesToRadians(_ value: CGFloat) -> CGFloat {
	return value * CGFloat.pi / 180.0
}
 
public func RadiansToDegrees (_ value: CGFloat) -> CGFloat {
	return value * 180.0 / CGFloat.pi
}

public extension CGRect {

	func aspectFill(_ size: CGSize) -> CGRect {
		let result: CGRect
		let margin: CGFloat
		let horizontalRatioToFit = self.size.width / size.width
		let verticalRatioToFit = self.size.height / size.height
		let imageHeightWhenItFitsHorizontally = horizontalRatioToFit * size.height
		let imageWidthWhenItFitsVertically = verticalRatioToFit * size.width
		let minX = self.minX
		let minY = self.minY

		if (imageHeightWhenItFitsHorizontally > self.size.height) {
			margin = (imageHeightWhenItFitsHorizontally - self.size.height) * 0.5
			result = CGRect(x: minX, y: minY - margin, width: size.width * horizontalRatioToFit, height: size.height * horizontalRatioToFit)
		}
		else {
			margin = (imageWidthWhenItFitsVertically - self.size.width) * 0.5
			result = CGRect(x: minX - margin, y: minY, width: size.width * verticalRatioToFit, height: size.height * verticalRatioToFit)
		}
		return result;
	}

	func aspectFit(_ size: CGSize) -> CGRect {
		let minX = self.minX
		let minY = self.minY
		let widthRatio = self.size.width / size.width
		let heightRatio = self.size.height / size.height
		let ratio = min(widthRatio, heightRatio)
		let width = size.width * ratio
		let height = size.height * ratio
		let xmargin = (self.size.width - width) / 2.0
		let ymargin = (self.size.height - height) / 2.0
		return CGRect(x: minX + xmargin, y: minY + ymargin, width: width, height: height)
	}
}

public extension CGSize {

	func aspectFit(_ size: CGSize) -> CGSize {
		let widthRatio = self.width / size.width
		let heightRatio = self.height / size.height
		let ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio
		let width = size.width * ratio
		let height = size.height * ratio
		return CGSize(width: width, height: height)
	}

}

public func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
	return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
}

public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
	return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
	return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public extension CGRect {
	var minXminY: CGPoint { return CGPoint(x: self.minX, y: self.minY) }
	var midXminY: CGPoint { return CGPoint(x: self.midX, y: self.minY) }
	var maxXminY: CGPoint { return CGPoint(x: self.maxX, y: self.minY) }

	var minXmidY: CGPoint { return CGPoint(x: self.minX, y: self.midY) }
	var midXmidY: CGPoint { return CGPoint(x: self.midX, y: self.midY) }
	var maxXmidY: CGPoint { return CGPoint(x: self.maxX, y: self.midY) }

	var minXmaxY: CGPoint { return CGPoint(x: self.minX, y: self.maxY) }
	var midXmaxY: CGPoint { return CGPoint(x: self.midX, y: self.maxY) }
	var maxXmaxY: CGPoint { return CGPoint(x: self.maxX, y: self.maxY) }
}


public protocol CGFloatCovertible {
	var cgFloatValue: CGFloat { get }
}

extension CGFloat: CGFloatCovertible {
	public var cgFloatValue: CGFloat { return self }
}

extension Float: CGFloatCovertible {
	public var cgFloatValue: CGFloat { return CGFloat(self) }
}

extension Double: CGFloatCovertible {
	public var cgFloatValue: CGFloat { return CGFloat(self) }
}

extension Int: CGFloatCovertible {
	public var cgFloatValue: CGFloat { return CGFloat(self) }
}

extension CGPoint {
	public init<X: CGFloatCovertible, Y: CGFloatCovertible>(_ x: X, _ y: Y) {
		self = CGPoint(x: x.cgFloatValue, y: y.cgFloatValue)
	}
}

extension CGSize {
	public init<W: CGFloatCovertible, H: CGFloatCovertible>(_ w: W, _ h: H) {
		self = CGSize(width: w.cgFloatValue, height: h.cgFloatValue)
	}
}

extension CGRect {
	public init<X: CGFloatCovertible, Y: CGFloatCovertible, W: CGFloatCovertible, H: CGFloatCovertible>(_ x: X, _ y: Y, _ w: W, _ h: H) {
		self = CGRect(x: x.cgFloatValue, y: y.cgFloatValue, width: w.cgFloatValue, height: h.cgFloatValue)
	}
}

