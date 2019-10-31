MKAPopupKit
===

***MKAPopupKit is simple and customizable popup view for iOS.***

<img src="./README/popup1.gif" width="200"/> <img src="./README/popup2.gif" width="200"/>

## Installation

### CocoaPods

MKAPopupKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MKAPopupKit"
```

### Carthage

You can use [Carthage](https://github.com/Carthage/Carthage) to install MKAPopupKit by adding it to your Cartfile:

```
github "HituziANDO/MKAPopupKit"
```

If you use Carthage to build your dependencies, make sure you have added MKAPopupKit.framework to the "Frameworks, Libraries and Embedded Content" section of your target, and have included them in your Carthage framework copying build phase.

### Manual Installation

1. Download latest [MKAPopupKit](https://github.com/HituziANDO/MKAPopupKit/releases) framework and copy it into your Xcode project
1. Open the "General" panel
1. Click on the + button under the "Frameworks, Libraries and Embedded Content" section
1. After click "Add Other...", choose MKAPopupKit.framework


## Quick Usage

Let's see following code.

```swift
import MKAPopupKit

...

// Creates your content view.
let contentView = ...YOUR CONTENT VIEW CREATION...
// Creates a popup using your content view.
let popup       = MKAPopup(contentView: contentView)

// Customizes...

// Title (default is nil)
popup.popupView.titleLabel.text = "About Swift"

// Title Text Color (default is system default color)
popup.popupView.titleLabel.textColor = .white

// Title Font (default is system default font)
popup.popupView.titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)

// Title Text Padding (default is (16, 16, 16, 16))
popup.popupView.titleLabel.padding = UIEdgeInsets(top: 24.0, left: 16.0, bottom: 24.0, right: 16.0)

// Popup Background Color (default is white)
popup.popupView.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1.0, alpha: 1.0)

// Popup Corner Radius (default is 5)
popup.popupView.layer.cornerRadius = 20.0

// Popup Size (default is (300, 400))
popup.popupSize = CGSize(width: 320.0, height: 480.0)

// Overlay Color (default is black with alpha=0.4)
popup.backgroundColor = UIColor.black.withAlphaComponent(0.8)

// Can hide when a user touches up outside a popup (default is true)
popup.canHideWhenTouchUpOutside = false

// Showing Animation (default is fade)
popup.showingAnimation = .fade

// Hiding Animation (default is fade)
popup.hidingAnimation = .fade

// Animation Duration (default is 0.3)
popup.duration = 0.3

// Delegate
popup.delegate = self

// Shows the popup.
popup.show()

...

// Hides the popup.
popup.hide()
```

## Animation Types

### Fade

<img src="./README/popup_fade.gif" width="200"/>

### SlideUp

<img src="./README/popup_slideup.gif" width="200"/>

### SlideDown

<img src="./README/popup_slidedown.gif" width="200"/>

### SlideLeft

<img src="./README/popup_slideleft.gif" width="200"/>

### SlideRight

<img src="./README/popup_slideright.gif" width="200"/>
