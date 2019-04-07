MKAPopupObjC
===

***MKAPopupObjC is simple and customizable popup view written in Objective-C for iOS.***


## Installation

### CocoaPods

MKAPopupObjC is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MKAPopupObjC"
```

## Quick Usage

Let's see following code.

```objc
#import <MKAPopupObjC/MKAPopupObjC.h>

@interface ViewController () <MKAPopupDelegate>

@property (nonatomic) MKAPopup *popup;

@end

...

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	// Creates your content view.
	UIView *contentView = ...YOUR CONTENT VIEW CREATION...;
	
	// Creates a popup using your content view.
	MKAPopup *popup = [[MKAPopup alloc] initWithContentView:contentView];
	
	// Customizes...
	 
	// Title (default is nil)
	popup.popupView.titleLabel.text = @"TITLE";
	
	// Title Text Color (default is system default color)
	popup.popupView.titleLabel.textColor = [UIColor whiteColor];
	
	// Title Font (default is system default font)
	popup.popupView.titleLabel.font = [UIFont boldSystemFontOfSize:20.f];
	
	// Title Text Padding (default is (16, 16, 16, 16))
	popup.popupView.titleLabel.padding = UIEdgeInsetsMake(24.f, 16.f, 24.f, 16.f);
	
	// Popup Background Color (default is white)
	popup.popupView.backgroundColor = [UIColor colorWithRed:0 green:.5f blue:1.f alpha:1.f];
	
	// Popup Corner Radius (default is 5)
	popup.popupView.layer.cornerRadius = 20.f;
	
	// Popup Size (default is (300, 400))
	popup.popupSize = CGSizeMake(320.f, 600.f);
	
	// Overlay Color (default is black with alpha=0.4)
	popup.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8f];
	
	// Can hide when a user touches up outside a popup (default is true)
	popup.canHideWhenTouchUpOutside = YES;
	
	// Showing Animation (default is fade)
	popup.showingAnimation = MKAPopupViewAnimationFade;
	
	// Hiding Animation (default is fade)
	popup.hidingAnimation = MKAPopupViewAnimationFade;
	
	// Animation Duration (default is 0.3)
	popup.duration = .3f;
	
	// Delegate
	popup.delegate = self;
	
	// Shows the popup.
	[popup show];
	
	self.popup = popup;
}

...

- (void)something {
	// Hides the popup.
	[self.popup hide];
}
```
