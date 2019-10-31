//
// MKAPopupKit
//
// Copyright (c) 2019-present Hituzi Ando. All rights reserved.
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

@protocol MKAPopupDelegate;

typedef NS_ENUM(NSInteger, MKAPopupViewAnimation) {
    MKAPopupViewAnimationFade,
    MKAPopupViewAnimationSlideUp,
    MKAPopupViewAnimationSlideDown,
    MKAPopupViewAnimationSlideLeft,
    MKAPopupViewAnimationSlideRight,
    MKAPopupViewAnimationNone,
};

@interface MKAPopupLabel : UILabel
/**
 * A padding of a label.
 */
@property (nonatomic) UIEdgeInsets padding;

@end

@interface MKAPopupView : UIView
/**
 * A title view. It is shown when a title is specified.
 */
@property (nonatomic, readonly) MKAPopupLabel *titleLabel;
/**
 * A container of main content view.
 */
@property (nonatomic, readonly) UIView *containerView;

- (void)beginShowingAnimation:(MKAPopupViewAnimation)animation;
- (void)showWithAnimation:(MKAPopupViewAnimation)animation
                 duration:(NSTimeInterval)duration
               completion:(nullable void (^)(BOOL finished))completion;
- (void)hideWithAnimation:(MKAPopupViewAnimation)animation
                 duration:(NSTimeInterval)duration
               completion:(nullable void (^)(BOOL finished))completion;

@end

@interface MKAPopup : UIView
/**
 * A popup view.
 */
@property (nonatomic, readonly) MKAPopupView *popupView;
/**
 * Main content view in the popup view.
 */
@property (nonatomic, readonly, nullable) __kindof UIView *contentView;
/**
 * A delegate.
 */
@property (nonatomic, weak, nullable) id <MKAPopupDelegate> delegate;
/**
 * Tells whether a user can hide a popup when touches up outside it.
 */
@property (nonatomic) BOOL canHideWhenTouchUpOutside;
/**
 * An animation type for showing a popup.
 */
@property (nonatomic) MKAPopupViewAnimation showingAnimation;
/**
 * An animation type for hiding a popup.
 */
@property (nonatomic) MKAPopupViewAnimation hidingAnimation;
/**
 * An animation duration.
 */
@property (nonatomic) NSTimeInterval duration;
/**
 * Returns YES if a popup is shown, otherwise NO.
 */
@property (nonatomic, readonly) BOOL isShowing;
/**
 * A popup view's size.
 */
@property (nonatomic) CGSize popupSize;

/**
 * Creates an instance with a content view.
 *
 * @param contentView Main content view.
 * @return An instance.
 */
- (instancetype)initWithContentView:(__kindof UIView *)contentView;

/**
 * Shows a popup using the set animation type and duration.
 */
- (void)show;
/**
 * Shows a popup using given animation type and the set duration.
 *
 * @param animation An animation to show a popup.
 */
- (void)showWithAnimation:(MKAPopupViewAnimation)animation;
/**
 * Shows a popup using given animation type and duration.
 *
 * @param animation An animation to show a popup.
 * @param duration An animation duration.
 */
- (void)showWithAnimation:(MKAPopupViewAnimation)animation duration:(NSTimeInterval)duration;
/**
 * Hides a popup using the set animation type and duration.
 */
- (void)hide;
/**
 * Hides a popup using given animation type and the set duration.
 *
 * @param animation An animation to hide a popup.
 */
- (void)hideWithAnimation:(MKAPopupViewAnimation)animation;
/**
 * Hides a popup using given animation type and duration.
 *
 * @param animation An animation to hide a popup.
 * @param duration An animation duration.
 */
- (void)hideWithAnimation:(MKAPopupViewAnimation)animation duration:(NSTimeInterval)duration;

@end

@protocol MKAPopupDelegate <NSObject>
@optional

- (void)popupWillAppear:(MKAPopup *)popup;
- (void)popupDidAppear:(MKAPopup *)popup;
- (void)popupWillDisappear:(MKAPopup *)popup;
- (void)popupDidDisappear:(MKAPopup *)popup;

@end

NS_ASSUME_NONNULL_END
