## What is this sample project is about?

This sample code demonstrate how to prevent two common problems using PDF in UIScrollView.  

Firstly, PDF contents get blurry when zoomed.  In order to fix this you may want to set contentScaleFactor for the contentView within UIScrollView.  But if you like to zoom-in more higher number scale, iOS needs more large amount of memory of rasterized bit map and cause run out of memory issue at some point.


 <img width="500" alt="Screen Shot 2016-11-28 at 14.21.11.png" src="https://qiita-image-store.s3.amazonaws.com/0/65634/bb9b2fef-c489-5667-a9e1-221a6034b9b9.png">


This sample code place a UIImageView within UIScrollView, and low resolution pre-rasterized image is set as a cached image, so that user will see something on screen when PDF Page View took a couple of seconds to draw.


<img width="500" alt="Screen Shot 2016-11-28 at 14.26.38.png" src="https://qiita-image-store.s3.amazonaws.com/0/65634/01fcc46a-fece-a2f0-f5cf-76e6b16ab2f6.png">

Secondly, this sample code do not set contentScaleFactor to the zooming view with in the scroll view to avoid memory error.  Instead View that actually draw PDF page (PDFPageView) is placed in the same level of UIScrollView.  Then PDFPageView converts coordinate of content view to its own coordinate and draw it.  Then wow!  PDFPage is not actually zoomed or scrolled, but it looks like it.

This sample code is a part of presentation I made in Nov.2016. 

[Using PDF in iOS (speakerdeck)](https://speakerdeck.com/codelynx/using-pdf-in-ios)

### Caution

Materials under resource files are just for demonstration purpose only.  Please do not redistribute those with this project.  Rest of the code can be redistribute under MIT license.  Be aware, this sample code is just for demonstration purpose quality, you will have to implement quite a few error checking and detail implementation to be production ready.

