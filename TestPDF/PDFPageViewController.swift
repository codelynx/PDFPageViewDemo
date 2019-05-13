//
//	PDFPageViewController.swift
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

class PDFPageViewController: UIViewController, UIScrollViewDelegate {

	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var pdfPageView: PDFPageView!
	@IBOutlet weak var contentView: UIImageView!


	lazy var document: CGPDFDocument = {
		let resourceURL = Bundle.main.url(forResource: "GDM_2012_09_12", withExtension: "pdf")!
		return CGPDFDocument(resourceURL as CFURL)!
	}()

	var page: CGPDFPage!

	override func viewDidLoad() {
		super.viewDidLoad()

		self.page = self.document.page(at: 1)
		self.pdfPageView.page = self.page
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

	override func viewWillLayoutSubviews() {
		let box = self.page.getBoxRect(.cropBox)
		let pageRect = self.scrollView.bounds.aspectFit(box.size)
		contentView.frame = CGRect(x: 0, y: 0, width: pageRect.width, height: pageRect.height)
		self.scrollView.contentSize = pageRect.size
		self.scrollView.contentOffset = CGPoint.zero
		self.contentView.setNeedsUpdateConstraints()
		self.contentView.layoutIfNeeded()
	}

	override func updateViewConstraints() {
		super.updateViewConstraints()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	// MARK: -
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return contentView
	}

	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		self.pdfPageView.setNeedsDisplay()
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		self.pdfPageView.setNeedsDisplay()
	}

}

