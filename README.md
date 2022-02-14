# HYMenu

[![CI Status](https://img.shields.io/travis/HENRY/HYMenu.svg?style=flat)](https://travis-ci.org/HENRY/HYMenu)
[![Version](https://img.shields.io/cocoapods/v/HYMenu.svg?style=flat)](https://cocoapods.org/pods/HYMenu)
[![License](https://img.shields.io/cocoapods/l/HYMenu.svg?style=flat)](https://cocoapods.org/pods/HYMenu)
[![Platform](https://img.shields.io/cocoapods/p/HYMenu.svg?style=flat)](https://cocoapods.org/pods/HYMenu)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage
```Swift
        let menu = HYMenuViewController()
        let viewController1 = UIViewController()
        menu.setupMenuViewController(menuViewController: viewController1)
        let viewController2 = UIViewController()
        menu.setupContentViewController(contentViewController: viewController2)
        window?.rootViewController = menu
```

## Requirements

## Installation

HYMenu is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HYMenu'
```

## Author

HENRY, hg45hg2000@me.com

## License

HYMenu is available under the MIT license. See the LICENSE file for more info.
