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

#import "MKAToast.h"

const CGFloat MKAToastDefaultWidth = 300.f;
const CGFloat MKAToastDefaultHeight = 80.f;

@implementation MKAToastStyleConfiguration

- (instancetype)init {
    if (self = [super init]) {
        _width = MKAToastDefaultWidth;
        _height = MKAToastDefaultHeight;
        _backgroundColor = MKAToastDefaultBackgroundColor;
        _textColor = MKAToastDefaultTextColor;
        _font = MKAToastDefaultFont;
    }

    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    MKAToastStyleConfiguration *config = [MKAToastStyleConfiguration new];
    config.width = self.width;
    config.height = self.height;
    config.backgroundColor = self.backgroundColor;
    config.textColor = self.textColor;
    config.font = self.font;
    return config;
}

@end

const NSTimeInterval MKAToastShortTime = 3.0;
const NSTimeInterval MKAToastLongTime = 5.0;
const NSTimeInterval MKAToastTimeShort = 3.0;
const NSTimeInterval MKAToastTimeLong = 5.0;
const NSTimeInterval MKAToastTimeForever = -1.0;

@interface MKAToast ()

@property (nonatomic) UILabel *label;
/**
 * A delegate.
 */
@property (nonatomic, weak, nullable) id <MKAToastDelegate> delegate;
/**
 * A duration of fade-in and fade-out in seconds.
 */
@property (nonatomic) NSTimeInterval animationDuration;
/**
 * A display time in seconds.
 */
@property (nonatomic) NSTimeInterval time;
/**
 * A delay in seconds that the toast view is shown after it.
 */
@property (nonatomic) NSTimeInterval delay;

@end

@implementation MKAToast

static const NSTimeInterval kDefaultAnimationDuration = .3;

static MKAToastStyleConfiguration *_config = nil;
static NSMutableDictionary<NSString *, MKAToastStyleConfiguration *> *_styleConfigCaches = nil;

+ (instancetype)toastWithText:(NSString *)text {
    // Sets default style configuration when it's not set yet.
    [self setDefaultStyleConfiguration:[MKAToastStyleConfiguration new]];
    return [[MKAToast alloc] initWithText:text style:_config];
}

+ (instancetype)toastWithText:(NSString *)text style:(MKAToastStyleConfiguration *)styleConfig {
    return [[MKAToast alloc] initWithText:text style:styleConfig];
}

+ (instancetype)toastWithText:(NSString *)text forKey:(NSString *)key {
    return [[MKAToast alloc] initWithText:text style:_styleConfigCaches[key]];
}

- (instancetype)initWithText:(NSString *)text style:(MKAToastStyleConfiguration *)styleConfig {
    CGRect frame = CGRectMake(0, 0, styleConfig.width, styleConfig.height);

    if (self = [super initWithFrame:frame]) {
        // Sets default values.
        _animationDuration = kDefaultAnimationDuration;
        _time = MKAToastTimeShort;
        _delay = 0;
        self.backgroundColor = styleConfig.backgroundColor;

        // Adds left and right margin.
        _label = [[UILabel alloc] initWithFrame:CGRectMake(20.f, 0, frame.size.width - 40.f, 0)];

        _label.text = text;
        _label.textColor = styleConfig.textColor;
        _label.font = styleConfig.font;

        // Available to line break.
        _label.numberOfLines = 0;   // Infinite lines.
        _label.lineBreakMode = NSLineBreakByWordWrapping;

        [_label sizeToFit];

        [self addSubview:_label];

        _label.center = CGPointMake(frame.size.width * .5f, frame.size.height * .5f);

        self.layer.cornerRadius = frame.size.height * .5f;

        // Hides characters that protrude.
        self.clipsToBounds = YES;

        self.alpha = 0;
    }

    return self;
}

#pragma mark - public method

- (BOOL)isShowing {
    return self.alpha == 1.f;
}

- (instancetype)withTag:(NSInteger)tag {
    self.tag = tag;
    return self;
}

- (instancetype)withDelegate:(nullable id <MKAToastDelegate>)delegate {
    self.delegate = delegate;
    return self;
}

- (instancetype)withAnimationDuration:(NSTimeInterval)duration {
    self.animationDuration = duration;
    return self;
}

- (instancetype)withTime:(NSTimeInterval)time {
    self.time = time;
    return self;
}

- (instancetype)withDelay:(NSTimeInterval)delay {
    self.delay = delay;
    return self;
}

- (void)show {
    if ([self.delegate respondsToSelector:@selector(toastWillAppear:)]) {
        [self.delegate toastWillAppear:self];
    }

    UIView *view = [self rootView];
    [view addSubview:self];
    // Places horizontal center adding margin bottom.
    self.center = CGPointMake(view.center.x, view.frame.size.height - 56.f - self.frame.size.height / 2.f);

    self.alpha = 0;
    [UIView animateWithDuration:self.animationDuration
                          delay:self.delay
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.alpha = 1.f;
                     }
                     completion:^(BOOL b) {
                         if (self.time != MKAToastTimeForever) {
                             [NSTimer scheduledTimerWithTimeInterval:self.time
                                                              target:self
                                                            selector:@selector(hide:)
                                                            userInfo:nil
                                                             repeats:NO];
                         }

                         if ([self.delegate respondsToSelector:@selector(toastDidAppear:)]) {
                             [self.delegate toastDidAppear:self];
                         }
                     }];
}

- (void)hide {
    if (self.time == MKAToastTimeForever) {
        [self hide:nil];
    }
}

+ (void)showText:(NSString *)text {
    [[MKAToast toastWithText:text] show];
}

+ (void)setDefaultStyleConfiguration:(MKAToastStyleConfiguration *)config {
    if (!config) {
        return;
    }

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _config = [config copy];
    });
}

+ (void)addStyleConfiguration:(MKAToastStyleConfiguration *)config forKey:(NSString *)key {
    if (!config) {
        return;
    }

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _styleConfigCaches = [NSMutableDictionary new];
    });

    _styleConfigCaches[key] = config;
}

+ (void)removeStyleConfigurationForKey:(NSString *)key {
    if (_styleConfigCaches[key]) {
        [_styleConfigCaches removeObjectForKey:key];
    }
}

#pragma mark - private method

- (void)hide:(NSTimer *)timer {
    if ([self.delegate respondsToSelector:@selector(toastWillDisappear:)]) {
        [self.delegate toastWillDisappear:self];
    }

    [UIView animateWithDuration:self.animationDuration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL b) {
                         [self removeFromSuperview];

                         if ([self.delegate respondsToSelector:@selector(toastDidDisappear:)]) {
                             [self.delegate toastDidDisappear:self];
                         }
                     }];
}

- (UIView *)rootView {
    return [UIApplication sharedApplication].keyWindow.subviews.lastObject;
}

@end
