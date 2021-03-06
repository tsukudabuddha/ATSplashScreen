# ATSplashScreen

[![Version](https://img.shields.io/cocoapods/v/ATSplashScreen.svg?style=flat)](https://cocoapods.org/pods/ATSplashScreen)
[![Platform](https://img.shields.io/cocoapods/p/ATSplashScreen.svg?style=flat)](https://cocoapods.org/pods/ATSplashScreen)
[![Swift Version](https://img.shields.io/badge/Swift-4.0-blue.svg)](https://cocoapods.org/pods/ATSplashScreen)
[![License](https://img.shields.io/cocoapods/l/ATSplashScreen.svg?style=flat)](https://cocoapods.org/pods/ATSplashScreen)


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

You should see this

![Demo Gif](splashScreenGif1.gif)

## Usage
Add a Splash Screen View as a subview of the view you want to load

This code would go in your first view controller's viewDidLoad() func
```swift
let splashScreen = SplashScreenView(imageName: "apple")

view.addSubView(splashScreen)
```

There are also more verbose initializers, for example:
```Swift
let splashScreen = SplashScreenView(imageColor: .black, imageSize: CGSize(width: 200, height: 200), imageName: "apple", transition: .shutter, lineOrientation: .horizontal)
```
Which was used to create the splash screen in the example app (gif above)

## Installation

ATSplashScreen is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ATSplashScreen'
```

## Author

tsukudabuddha, andrewtsukuda@gmail.com

## License

ATSplashScreen is available under the MIT license. See the LICENSE file for more info.
