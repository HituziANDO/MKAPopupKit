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

/**
 * Show / hide the indicator.
 * If `animating` is YES, the display count is incremented by 1 and the indicator is displayed.
 * If it is NO, the display count is decremented by 1, and when the count becomes 0, the indicator is hidden.
 *
 * @param animating YES if the indicator is displayed.
 * @param view Displays the indicator on specified view.
 * @param touchDisabled If YES, the user can not operate while the indicator is displayed.
 */
- (void)startAnimating:(BOOL)animating
                inView:(UIView *)view
     withTouchDisabled:(BOOL)touchDisabled;
/**
 * Show / hide the indicator.
 * If `animating` is YES, the display count is incremented by 1 and the indicator is displayed.
 * If it is NO, the display count is decremented by 1, and when the count becomes 0, the indicator is hidden.
 *
 * @param animating YES if the indicator is displayed.
 * @param view Displays the indicator on specified view.
 * @param point The center coordinates of the indicator on the specified view.
 * @param touchDisabled If YES, the user can not operate while the indicator is displayed.
 */
- (void)startAnimating:(BOOL)animating
                inView:(UIView *)view
               atPoint:(CGPoint)point
     withTouchDisabled:(BOOL)touchDisabled;
/**
 * The display count is incremented by 1 and the indicator is displayed.
 * The indicator will not be displayed in duplicate even if this method is executed more than once.
 *
 * @param view Displays the indicator on specified view.
 * @param touchDisabled If YES, the user can not operate while the indicator is displayed.
 */
- (void)showInView:(UIView *)view withTouchDisabled:(BOOL)touchDisabled;
/**
 * The display count is incremented by 1 and the indicator is displayed.
 * The indicator will not be displayed in duplicate even if this method is executed more than once.
 *
 * @param view Displays the indicator on specified view.
 * @param point The center coordinates of the indicator on the specified view.
 * @param touchDisabled If YES, the user can not operate while the indicator is displayed.
 */
- (void)showInView:(UIView *)view atPoint:(CGPoint)point withTouchDisabled:(BOOL)touchDisabled;
/**
 * The display count is decremented by 1, and when the count becomes 0, the indicator is hidden.
 */
- (void)hide;
/**
 * Forcibly hide the indicator by setting the display count to 0.
 */
- (void)hideForcibly;
/**
 * Specify a size of the indicator. You can not change the style while displaying.
 *
 * @param size A size of the view.
 */
- (instancetype)setSize:(CGSize)size;
/**
 * Specify the animation speed when `indicatorType` is MKAIndicatorTypeCustom or MKAIndicatorTypeSpriteAnimation.
 * You can not change the style while displaying.
 *
 * @param duration The animation speed (smaller value means faster).
 */
- (instancetype)setAnimationDuration:(double)duration;
/**
 * Specify the number of animation's iterations when `indicatorType` is MKAIndicatorTypeCustom or MKAIndicatorTypeSpriteAnimation.
 * You can not change the style while displaying.
 *
 * @param repeatCount The number of animation's iterations.
 */
- (instancetype)setAnimationRepeatCount:(NSInteger)repeatCount;
/**
 * Add the arbitrary background to the indicator.
 * The added background is set on the back. You can not change the style while displaying.
 
 @param bgView The background view.
 */
- (instancetype)addBackgroundView:(UIView *)bgView;
/**
 * Add the black background to the indicator. You can not change the style while displaying.
 */
- (instancetype)addBlackBackgroundView;

@end

NS_ASSUME_NONNULL_END
