
SweeftToast
=============
[![CocoaPods Version](https://img.shields.io/badge/version-v0.0.5-green.svg)](https://github.com/jeongjinho/SweeftToast)
[![Swift Version](https://img.shields.io/badge/swift-4.2-orange.svg)](https://github.com/jeongjinho/SweeftToast)
[![Licence](http://img.shields.io/badge/license-MIT-brightgreen.svg)](https://github.com/jeongjinho/SweeftToast)

SweeftToast is very simple android Style AlertView, So this library is a view inherited and implemented.
t's just an implementation by creating a view and invoking a startup method!





### Setup Instructions

---------------

[CocoaPods](http://cocoaPods.org)

------------------

Install with CocoaPods by adding the following to your `Podfile`:

```ruby
pod 'SweeftToast'
```



### Basic Example

-------

```swift
// basic usage
let toast = Toast(self,"hi Toast") // initial
toast.toastMessage = "change Message" // set message
toast.startToastView(duration: 3.0) // show Toast


// handler usage, When Toast is hidden 
 let toast = Toast(self, "this is after action Toast") 
 toast.startToastView(duration: 3.0) {
     // When toast is hidden, this execute this handler
     }
// show multiLine Text
 Toast(self, "Delete topic and update Topic data!", { (toast) in
            toast.toastButton.setTitle("cancel", for: .normal)
            toast.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.75)
        }).textLine(2).viewWidth(300).startToastView(duration: 3.0)
```



MIT License
-----------

    Copyright (c) 2019 jeong jin ho
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
