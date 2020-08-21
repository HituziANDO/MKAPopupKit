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

#import "MKAIndicator.h"

#import "MKAActivityIndicatorViewWrapper.h"
#import "MKACustomIndicatorViewWrapper.h"
#import "MKAIndicatorInterface.h"
#import "MKAPopupKitHelper.h"
#import "MKASpriteAnimationIndicatorViewWrapper.h"

@interface MKAIndicator ()

@property (nonatomic) id <MKAIndicatorInterface> indicatorView;
@property (nonatomic) NSUInteger count;
@property (nonatomic) MKAIndicatorType indicatorType;
@property (nonatomic, nullable) UIView *overlay;

@end

@implementation MKAIndicator

static MKAIndicator *_defaultIndicator = nil;

+ (void)setDefaultIndicator:(MKAIndicator *)indicator {
    @synchronized (self) {
        [_defaultIndicator hideForcibly];

        _defaultIndicator = indicator;
    }
}

+ (instancetype)defaultIndicator {
    @synchronized (self) {
        if (!_defaultIndicator) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:@"Default indicator is not set. Execute `+setDefaultIndicator:` method before execute `+defaultIndicator` method."
                                         userInfo:nil];
        }

        return _defaultIndicator;
    }
}

+ (instancetype)indicatorWithActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)style {
    MKAIndicator *indicator = [MKAIndicator new];
    indicator.indicatorType = MKAIndicatorTypeBasic;
    [((MKAActivityIndicatorViewWrapper *) indicator.indicatorView) setActivityIndicatorViewStyleAndResize:style];

    return indicator;
}

+ (instancetype)indicatorWithImage:(UIImage *)image {
    MKAIndicator *indicator = [MKAIndicator new];
    indicator.indicatorType = MKAIndicatorTypeCustom;
    [((MKACustomIndicatorViewWrapper *) indicator.indicatorView) setImage:image];

    return indicator;
}

+ (instancetype)indicatorWithImages:(NSArray<UIImage *> *)images {
    MKAIndicator *indicator = [MKAIndicator new];
    indicator.indicatorType = MKAIndicatorTypeSpriteAnimation;
    [((MKASpriteAnimationIndicatorViewWrapper *) indicator.indicatorView) setSpriteImagesWithArray:images];

    return indicator;
}

+ (instancetype)indicatorWithImagesFormat:(NSString *)format count:(NSInteger)count {
    MKAIndicator *indicator = [MKAIndicator new];
    indicator.indicatorType = MKAIndicatorTypeSpriteAnimation;
    [((MKASpriteAnimationIndicatorViewWrapper *) indicator.indicatorView) setSpriteImagesWithFormat:format count:count];

    return indicator;
}

- (instancetype)init {
    if (self = [super init]) {
        _indicatorView = [MKAActivityIndicatorViewWrapper new];
        _indicatorType = MKAIndicatorTypeBasic;
        _overlayColor = [UIColor.blackColor colorWithAlphaComponent:0.05];
    }

    return self;
}

#pragma mark - property

- (BOOL)isVisible {
    return self.count > 0;
}

- (void)setIndicatorType:(MKAIndicatorType)indicatorType {
    _indicatorType = indicatorType;

    if (indicatorType == MKAIndicatorTypeCustom) {
        _indicatorView = [MKACustomIndicatorViewWrapper new];
    }
    else if (indicatorType == MKAIndicatorTypeSpriteAnimation) {
        _indicatorView = [MKASpriteAnimationIndicatorViewWrapper new];
    }
    else {
        _indicatorView = [MKAActivityIndicatorViewWrapper new];
    }
}

#pragma mark - public method

- (void)startAnimating:(BOOL)animating inView:(UIView *)view withTouchDisabled:(BOOL)touchDisabled {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [self startAnimating:animating inView:view atPoint:view.center withTouchDisabled:touchDisabled];
#pragma clang diagnostic pop
}

- (void)startAnimating:(BOOL)animating inView:(UIView *)view atPoint:(CGPoint)point withTouchDisabled:(BOOL)touchDisabled {
    if (animating) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [self showInView:view atPoint:point withTouchDisabled:touchDisabled];
#pragma clang diagnostic pop
    }
    else {
        [self hide];
    }
}

- (void)showInView:(UIView *)view withTouchDisabled:(BOOL)touchDisabled {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [self showInView:view atPoint:view.center withTouchDisabled:touchDisabled];
#pragma clang diagnostic pop
}

- (void)showInView:(UIView *)view atPoint:(CGPoint)point withTouchDisabled:(BOOL)touchDisabled {
    ++self.count;

    if (self.count == 1) {
        self.indicatorView.view.center = point;

        [view addSubview:self.indicatorView.view];
        [view bringSubviewToFront:self.indicatorView.view];

        [self.indicatorView startAnimating];

        if (touchDisabled && ![UIApplication sharedApplication].isIgnoringInteractionEvents) {
            // Disables user touch events.
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        }
    }
}

- (void)showIgnoringUserInteraction:(BOOL)isUserInteractionDisabled {
    UIView *view = [MKAPopupKitHelper rootView];
    [self showInView:view ignoringUserInteraction:isUserInteractionDisabled];
}

- (void)showInView:(UIView *)view ignoringUserInteraction:(BOOL)isUserInteractionDisabled {
    [self showInView:view atPoint:view.center ignoringUserInteraction:isUserInteractionDisabled];
}

- (void)showInView:(UIView *)view atPoint:(CGPoint)point ignoringUserInteraction:(BOOL)isUserInteractionDisabled {
    ++self.count;

    if (self.count == 1) {
        if (isUserInteractionDisabled && !self.overlay) {
            // Adds the overlay view for preventing user interaction events.
            self.overlay = [[UIView alloc] initWithFrame:view.bounds];
            self.overlay.backgroundColor = self.overlayColor;
            [self.overlay setUserInteractionEnabled:YES];
            [view addSubview:self.overlay];
        }

        self.indicatorView.view.center = point;

        [view addSubview:self.indicatorView.view];

        [self.indicatorView startAnimating];
    }
}

- (void)hide {
    if (!self.isVisible) {
        return;
    }

    --self.count;

    if (self.count == 0) {
        [self.indicatorView stopAnimating];

        [self.indicatorView.view removeFromSuperview];

        [self.overlay removeFromSuperview];
        self.overlay = nil;

        if ([UIApplication sharedApplication].isIgnoringInteractionEvents) {
            // Enables user touch events.
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    }
}

- (void)hideForcibly {
    if (!self.isVisible) {
        return;
    }

    self.count = 0;

    [self.indicatorView stopAnimating];

    [self.indicatorView.view removeFromSuperview];

    [self.overlay removeFromSuperview];
    self.overlay = nil;

    if ([UIApplication sharedApplication].isIgnoringInteractionEvents) {
        // Enables user touch events.
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
}

- (void)toggle:(BOOL)show ignoringUserInteraction:(BOOL)isUserInteractionDisabled {
    UIView *view = [MKAPopupKitHelper rootView];
    [self toggle:show inView:view ignoringUserInteraction:isUserInteractionDisabled];
}

- (void)toggle:(BOOL)show inView:(UIView *)view ignoringUserInteraction:(BOOL)isUserInteractionDisabled {
    [self toggle:show inView:view atPoint:view.center ignoringUserInteraction:isUserInteractionDisabled];
}

- (void)toggle:(BOOL)show inView:(UIView *)view atPoint:(CGPoint)point ignoringUserInteraction:(BOOL)isUserInteractionDisabled {
    if (show) {
        [self showInView:view atPoint:point ignoringUserInteraction:isUserInteractionDisabled];
    }
    else {
        [self hide];
    }
}

- (instancetype)withSize:(CGSize)size {
    if (self.isVisible) {
        return self;
    }

    self.indicatorView.view.bounds = (CGRect) { CGPointZero, size };

    return self;
}

- (instancetype)setSize:(CGSize)size {
    return [self withSize:size];
}

- (instancetype)withAnimationDuration:(double)duration {
    if (self.isVisible) {
        return self;
    }

    if (self.indicatorType == MKAIndicatorTypeCustom) {
        ((MKACustomIndicatorViewWrapper *) self.indicatorView).duration = duration;
    }
    else if (self.indicatorType == MKAIndicatorTypeSpriteAnimation) {
        ((MKASpriteAnimationIndicatorViewWrapper *) self.indicatorView).duration = duration;
    }

    return self;
}

- (instancetype)setAnimationDuration:(double)duration {
    return [self withAnimationDuration:duration];
}

- (instancetype)withAnimationRepeatCount:(NSInteger)repeatCount {
    if (self.isVisible) {
        return self;
    }

    if (self.indicatorType == MKAIndicatorTypeCustom) {
        ((MKACustomIndicatorViewWrapper *) self.indicatorView).repeatCount = repeatCount;
    }
    else if (self.indicatorType == MKAIndicatorTypeSpriteAnimation) {
        ((MKASpriteAnimationIndicatorViewWrapper *) self.indicatorView).repeatCount = repeatCount;
    }

    return self;
}

- (instancetype)setAnimationRepeatCount:(NSInteger)repeatCount {
    return [self withAnimationRepeatCount:repeatCount];
}

- (instancetype)withOverlayColor:(UIColor *)color {
    self.overlayColor = color;
    return self;
}

- (instancetype)addBackgroundView:(UIView *)bgView {
    if (self.isVisible) {
        return self;
    }

    bgView.center = CGPointMake(self.indicatorView.view.frame.size.width * .5f,
                                self.indicatorView.view.frame.size.height * .5f);
    [self.indicatorView.view addSubview:bgView];
    [self.indicatorView.view sendSubviewToBack:bgView];

    return self;
}

- (instancetype)addBlackBackgroundView {
    // Makes a slightly enlarged background than the indicator.
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              self.indicatorView.view.frame.size.width * 1.2f,
                                                              self.indicatorView.view.frame.size.height * 1.2f)];
    bgView.layer.cornerRadius = 5.f;
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7f];

    return [self addBackgroundView:bgView];
}

@end
