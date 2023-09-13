# HYMenu

[![CI Status](https://img.shields.io/travis/HENRY/HYMenu.svg?style=flat)](https://travis-ci.org/HENRY/HYMenu)
[![Version](https://img.shields.io/cocoapods/v/HYMenu.svg?style=flat)](https://cocoapods.org/pods/HYMenu)
[![License](https://img.shields.io/cocoapods/l/HYMenu.svg?style=flat)](https://cocoapods.org/pods/HYMenu)
[![Platform](https://img.shields.io/cocoapods/p/HYMenu.svg?style=flat)](https://cocoapods.org/pods/HYMenu)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Preview 
![](https://github.com/hg45hg2000/HYMenu/blob/master/menu.gif)
## Requirements

## Installation

HYMenu is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HYMenu'
```
## Usage
First:
```Swift 
import HYMenu
```

```Swift
        let nav = UINavigationController()
        nav.view.backgroundColor = .blue
        let left = UIViewController()
        left.view.backgroundColor = .brown
        let right = UIViewController()
        right.view.backgroundColor = .red
        let menu = HYMenuViewController()
        menu.setupLeft(left).setupCenter(nav).setupRight(right)
        window?.rootViewController = menu
        window?.makeKeyAndVisible()
            
```
HYMenuViewController Support Following
```Swift
        var menuSlideVelocity = 0.3
        var leftWidth : CGFloat = 150.0
        var rightWidth : CGFloat = 150.0
            
        func openSideMenu(edges:SlideSide)
        func closeSideMenu(edges:SlideSide)
```
## Author

HENRY, hg45hg2000@me.com

## License

HYMenu is available under the MIT license. See the LICENSE file for more info.
