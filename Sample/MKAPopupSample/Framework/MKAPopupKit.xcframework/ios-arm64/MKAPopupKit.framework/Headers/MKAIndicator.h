//
// MIT License
//
// Copyright (c) 2020-present Hituzi Ando
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

typedef NS_ENUM(NSInteger, MKAIndicatorType) {
    MKAIndicatorTypeBasic = 0,
    MKAIndicatorTypeCustom,
    MKAIndicatorTypeSpriteAnimation,
};

@interface MKAIndicator : NSObject
/**
 * Returns YES if the indicator is displayed, otherwise NO.
 */
@property (nonatomic, readonly) BOOL isVisible;
/**
 * Returns a type of the indicator.
 */
@property (nonatomic, readonly) MKAIndicatorType indicatorType;
/**
 * The overlay's background color.
 */
@property (nonatomic) UIColor *overlayColor;

/**
 * Set given indicator as default indicator. You can get it using `+defaultIndicator` method.
 *
 * @param indicator An indicator.
 */
+ (void)setDefaultIndicator:(MKAIndicator *)indicator;
/**
 * Returns an indicator set by `+setDefaultIndicator:` method.
 * If you don't execute `+setDefaultIndicator:` method before executing this method, an exception occurs.
 */
+ (instancetype)defaultIndicator;
/**
 * Returns new instance of basic style. Specify a UIActivityIndicatorViewStyle of the indicator.
 *
 * @param style UIActivityIndicatorViewStyle.
 */
+ (instancetype)indicatorWithActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)style;
/**
 * Returns new instance of custom style. Specify the indicator's image.
 *
 * @param image An image of an indicator.
 */
+ (instancetype)indicatorWithImage:(UIImage *)image;
/**
 * Returns new instance of sprite animation style.
 * Specify an array of indicator's images. The size of the indicator's image must be unified.
 * And specify the animation speed.
 *
 * @param images An array of indicator's images.
 */
+ (instancetype)indicatorWithImages:(NSArray<UIImage *> *)images;
/**
 * Returns new instance of sprite animation style.
 * Specify the indicator's image file name format and number of frames.
 * The size of the indicator's image must be unified. And specify the animation speed.
 *
 * @param format A file name format like "indicator%ld". The file name must have a sequential number from 0.
 * @param count Number of frames.
 */
+ (instancetype)indicatorWithImagesFormat:(NSString *)format count:(NSInteger)count;

- (void)startAnimating:(BOOL)animating inView:(UIView *)view withTouchDisabled:(BOOL)touchDisabled DEPRECATED_MSG_ATTRIBUTE(
    "Use `toggle:inView:ignoringUserInteraction:` method instead of this.");
- (void)startAnimating:(BOOL)animating inView:(UIView *)view atPoint:(CGPoint)point withTouchDisabled:(BOOL)touchDisabled DEPRECATED_MSG_ATTRIBUTE(
    "Use `toggle:inView:atPoint:ignoringUserInteraction:` method instead of this.");
- (void)showInView:(UIView *)view withTouchDisabled:(BOOL)touchDisabled DEPRECATED_MSG_ATTRIBUTE(
    "Use `showInView:ignoringUserInteraction:` method instead of this.");
- (void)showInView:(UIView *)view atPoint:(CGPoint)point withTouchDisabled:(BOOL)touchDisabled DEPRECATED_MSG_ATTRIBUTE(
    "Use `showInView:atPoint:ignoringUserInteraction:` method instead of this.");
/**
 * Shows the indicator on the root view at center when any indicator isn't displayed.
 * The indicator will not be displayed in duplicate even if this method is executed more than once.
 * If this method is executed more than once, the counter that counts displayed indicators is incremented by 1.
 *
 * @param isUserInteractionDisabled If YES, the user can not operate while the indicator is displayed.
 */
- (void)showIgnoringUserInteraction:(BOOL)isUserInteractionDisabled;
/**
 * Shows the indicator on specified view at center when any indicator isn't displayed.
 * The indicator will not be displayed in duplicate even if this method is executed more than once.
 * If this method is executed more than once, the counter that counts displayed indicators is incremented by 1.
 *
 * @param view Shows the indicator on specified view.
 * @param isUserInteractionDisabled If YES, the user can not operate while the indicator is displayed.
 */
- (void)showInView:(UIView *)view ignoringUserInteraction:(BOOL)isUserInteractionDisabled;
/**
 * Shows the indicator on the specified view at specified point when any indicator isn't displayed.
 * The indicator will not be displayed in duplicate even if this method is executed more than once.
 * If this method is executed more than once, the counter that counts displayed indicators is incremented by 1.
 *
 * @param view Shows the indicator on specified view.
 * @param point The center coordinates of the indicator on the specified view.
 * @param isUserInteractionDisabled If YES, the user can not operate while the indicator is displayed.
 */
- (void)showInView:(UIView *)view atPoint:(CGPoint)point ignoringUserInteraction:(BOOL)isUserInteractionDisabled;
/**
 * Hides the indicator when the counter that counts displayed indicators is equal to 1.
 */
- (void)hide;
/**
 * Hides the indicator forcibly even if the counter that counts displayed indicators is greater than 1.
 */
- (void)hideForcibly;
/**
 * Executes show method if `show` is YES, otherwise hide method.
 *
 * @param show YES if the indicator is displayed.
 * @param isUserInteractionDisabled If YES, the user can not operate while the indicator is displayed.
 */
- (void)toggle:(BOOL)show ignoringUserInteraction:(BOOL)isUserInteractionDisabled;
/**
 * Executes show method if `show` is YES, otherwise hide method.
 *
 * @param show YES if the indicator is displayed.
 * @param view Shows the indicator on specified view.
 * @param isUserInteractionDisabled If YES, the user can not operate while the indicator is displayed.
 */
- (void)toggle:(BOOL)show inView:(UIView *)view ignoringUserInteraction:(BOOL)isUserInteractionDisabled;
/**
 * Executes show method if `show` is YES, otherwise hide method.
 *
 * @param show YES if the indicator is displayed.
 * @param view Shows the indicator on specified view.
 * @param point The center coordinates of the indicator on the specified view.
 * @param isUserInteractionDisabled If YES, the user can not operate while the indicator is displayed.
 */
- (void)toggle:(BOOL)show inView:(UIView *)view atPoint:(CGPoint)point ignoringUserInteraction:(BOOL)isUserInteractionDisabled;
/**
 * Sets the size of the indicator. You can not change the style while displaying.
 *
 * @param size The size of the view.
 */
- (instancetype)withSize:(CGSize)size;
- (instancetype)setSize:(CGSize)size DEPRECATED_MSG_ATTRIBUTE("Use `withSize:` method instead of this.");
/**
 * Sets the animation speed when `indicatorType` is MKAIndicatorTypeCustom or MKAIndicatorTypeSpriteAnimation.
 * You can not change the style while displaying.
 *
 * @param duration The animation speed (smaller value means faster).
 */
- (instancetype)withAnimationDuration:(double)duration;
- (instancetype)setAnimationDuration:(double)duration DEPRECATED_MSG_ATTRIBUTE("Use `withAnimationDuration:` method instead of this.");
/**
 * Sets the number of animation's iterations when `indicatorType` is MKAIndicatorTypeCustom or MKAIndicatorTypeSpriteAnimation.
 * You can not change the style while displaying.
 *
 * @param repeatCount The number of animation's iterations.
 */
- (instancetype)withAnimationRepeatCount:(NSInteger)repeatCount;
- (instancetype)setAnimationRepeatCount:(NSInteger)repeatCount DEPRECATED_MSG_ATTRIBUTE("Use `withAnimationRepeatCount:` method instead of this.");;
/**
 * Sets the overlay's background color.
 *
 * @param color The color.
 */
- (instancetype)withOverlayColor:(UIColor *)color;
/**
 * Add the arbitrary background to the indicator.
 * The added background is set on the back. You can not change the style while displaying.
 *
 * @param bgView The background view.
 */
- (instancetype)addBackgroundView:(UIView *)bgView;
/**
 * Add the black background to the indicator. You can not change the style while displaying.
 */
- (instancetype)addBlackBackgroundView;

@end

NS_ASSUME_NONNULL_END
