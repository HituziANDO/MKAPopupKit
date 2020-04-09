//
// MKAPopupKit
//
// Copyright (c) 2020-present Hituzi Ando. All rights reserved.
//
// MIT License
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A default value of a toast view's width.
 */
UIKIT_EXTERN const CGFloat MKAToastDefaultWidth;
/**
 * A default value of a toast view's height.
 */
UIKIT_EXTERN const CGFloat MKAToastDefaultHeight;

/**
 * A default background color of a toast view.
 */
#define MKAToastDefaultBackgroundColor [[UIColor grayColor] colorWithAlphaComponent:.95f]
/**
 * A default text color.
 */
#define MKAToastDefaultTextColor [UIColor whiteColor]
/**
 * A default font.
 */
#define MKAToastDefaultFont [UIFont systemFontOfSize:15.f weight:UIFontWeightRegular]

@interface MKAToastStyleConfiguration : NSObject <NSCopying>
/**
 * A toast view's width.
 */
@property (nonatomic) CGFloat width;
/**
 * A toast view's height.
 */
@property (nonatomic) CGFloat height;
/**
 * A background color of a toast view.
 */
@property (nonatomic) UIColor *backgroundColor;
/**
 * A text color.
 */
@property (nonatomic) UIColor *textColor;
/**
 * A font.
 */
@property (nonatomic) UIFont *font;

@end

@protocol MKAToastDelegate;

/**
 * A default short display time for a toast view.
 */
UIKIT_EXTERN const NSTimeInterval MKAToastShortTime DEPRECATED_MSG_ATTRIBUTE("Use `MKAToastTimeShort` instead.");
/**
 * A default long display time for a toast view.
 */
UIKIT_EXTERN const NSTimeInterval MKAToastLongTime DEPRECATED_MSG_ATTRIBUTE("Use `MKAToastTimeLong` instead.");
/**
 * A default short display time for a toast view.
 */
UIKIT_EXTERN const NSTimeInterval MKAToastTimeShort;
/**
 * A default long display time for a toast view.
 */
UIKIT_EXTERN const NSTimeInterval MKAToastTimeLong;
/**
 * A toast view is displayed forever (until `hide` method is called).
 */
UIKIT_EXTERN const NSTimeInterval MKAToastTimeForever;

/**
 * MKAToast is the view that disappears automatically after displaying a short message for a few seconds.
 * It is inspired by Android's Toast.
 */
@interface MKAToast : UIView
/**
 * A label.
 */
@property (nonatomic, readonly) UILabel *label;
/**
 * Tells whether the toast view is showing.
 */
@property (nonatomic, readonly) BOOL isShowing;

/**
 * Creates a toast view with default style.
 */
+ (instancetype)toastWithText:(NSString *)text NS_SWIFT_NAME(init(_:));
/**
 * Creates a toast view with given style.
 */
+ (instancetype)toastWithText:(NSString *)text style:(MKAToastStyleConfiguration *)styleConfig NS_SWIFT_NAME(init(_:style:));
/**
 * Creates a toast view with cached style by given key.
 */
+ (instancetype)toastWithText:(NSString *)text forKey:(NSString *)key NS_SWIFT_NAME(init(_:forKey:));

/**
 * Sets a tag.
 */
- (instancetype)withTag:(NSInteger)tag;
/**
 * Sets a delegate.
 */
- (instancetype)withDelegate:(nullable id <MKAToastDelegate>)delegate;
/**
 * Sets an animation duration of fade-in and fade-out in seconds.
 */
- (instancetype)withAnimationDuration:(NSTimeInterval)duration;
/**
 * Sets a display time in seconds.
 */
- (instancetype)withTime:(NSTimeInterval)time;
/**
 * Sets a delay in seconds that the toast view is shown after it.
 */
- (instancetype)withDelay:(NSTimeInterval)delay;
/**
 * Shows the toast view with the animation in configured time. After fading out, it is separated from the parent view.
 */
- (void)show;
/**
 * Shows the toast view with the animation in configured time at specified point. After fading out, it is separated from the parent view.
 */
- (void)showAtLocation:(CGPoint)center NS_SWIFT_NAME(show(at:));
/**
 */
- (void)hide;

/**
 * Shows a toast view with the animation in default time. After fading out, it is separated from the parent view.
 */
+ (void)showText:(NSString *)text NS_SWIFT_UNAVAILABLE("In Swift, use `MKAToast(_:).show()` instead.");
/**
 * Shows a toast view with the animation in default time at specified point. After fading out, it is separated from the parent view.
 */
+ (void)showText:(NSString *)text atLocation:(CGPoint)center NS_SWIFT_UNAVAILABLE("In Swift, use `MKAToast(_:).show(at:)` instead.");
/**
 * Sets a default style configuration.
 */
+ (void)setDefaultStyleConfiguration:(MKAToastStyleConfiguration *)config;
/**
 * Adds a style configuration to the cache.
 */
+ (void)addStyleConfiguration:(MKAToastStyleConfiguration *)config forKey:(NSString *)key NS_SWIFT_NAME(add(styleConfiguration:forKey:));
/**
 * Removes a style configuration from the cache.
 */
+ (void)removeStyleConfigurationForKey:(NSString *)key;

@end

@protocol MKAToastDelegate <NSObject>
@optional
/**
 * Called just before a toast view appears.
 */
- (void)toastWillAppear:(MKAToast *)toast;
/**
 * Called immediately after a toast view disappears.
 */
- (void)toastDidAppear:(MKAToast *)toast;
/**
 * Called just before a toast view disappears.
 */
- (void)toastWillDisappear:(MKAToast *)toast;
/**
 * Called immediately after a toast view disappears.
 */
- (void)toastDidDisappear:(MKAToast *)toast;
/**
 * Called when the toast view is clicked.
 */
- (void)toastClicked:(MKAToast *)toast;

@end

NS_ASSUME_NONNULL_END
