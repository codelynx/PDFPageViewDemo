//
//	PDFPageView.swift
//	TestPDF
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


import UIKit
import CoreGraphics

class PDFPageView: UIView {
	
	@IBOutlet weak var contentView: UIView!
	var page: CGPDFPage!
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.layer.drawsAsynchronously = true
		self.contentScaleFactor = self.window?.screen.scale ?? UIScreen.main.scale
	}
	
	override func draw(_ layer: CALayer, in ctx: CGContext) {
		UIGraphicsPushContext(ctx)
		ctx.saveGState()
		
		let box = page.getBoxRect(.cropBox)
		let contentBounds = self.contentView.bounds.aspectFit(box.size)
		let rect = self.contentView.convert(contentBounds, to: self)
		ctx.translateBy(x: rect.minX, y: rect.minY)
		ctx.translateBy(x: 0, y: rect.height)
		ctx.scaleBy(x: 1, y: -1)
		
		let scale = min(rect.width / box.width, rect.height / box.height)
		ctx.scaleBy(x: scale, y: scale)
		
		ctx.drawPDFPage(page)
		
		ctx.restoreGState()
		UIGraphicsPopContext()
		
		self.contentView.isHidden = true
	}
	
	override func setNeedsDisplay() {
		super.setNeedsDisplay()
		self.layer.setNeedsDisplay()
	}
	
}


