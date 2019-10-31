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

#import "MKAPopup.h"

@implementation MKAPopupLabel

- (instancetype)init {
    self = [super init];

    if (self) {
        _padding = UIEdgeInsetsMake(16.f, 16.f, 16.f, 16.f);
    }

    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _padding)];
}

- (CGSize)sizeThatFits:(CGSize)size {
    size = [super sizeThatFits:size];
    size.width += self.padding.left + self.padding.right;
    size.height += self.padding.top + self.padding.bottom;

    return size;
}

@end

@interface MKAPopupView ()

@property (nonatomic) MKAPopupLabel *titleLabel;

@end

@implementation MKAPopupView

- (instancetype)init {
    self = [super init];

    if (self) {
        _titleLabel = [MKAPopupLabel new];
        _containerView = [UIView new];

        [self addSubview:_titleLabel];
        [self addSubview:_containerView];

        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5.f;
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.titleLabel.text.length > 0) {
        [self.titleLabel sizeToFit];
    }
    else {
        self.titleLabel.bounds = CGRectZero;
    }

    self.titleLabel.center = CGPointMake(self.frame.size.width / 2.f, self.titleLabel.frame.size.height / 2.f);
    self.containerView.frame = CGRectMake(0,
                                          CGRectGetMaxY(self.titleLabel.frame),
                                          self.frame.size.width,
                                          self.frame.size.height - CGRectGetMaxY(self.titleLabel.frame));

}

- (void)beginShowingAnimation:(MKAPopupViewAnimation)animation {
    switch (animation) {
        case MKAPopupViewAnimationFade:
            self.alpha = 0;
            break;
        case MKAPopupViewAnimationSlideUp:
            self.transform = CGAffineTransformMakeTranslation(0, UIScreen.mainScreen.bounds.size.height);
            break;
        case MKAPopupViewAnimationSlideDown:
            self.transform = CGAffineTransformMakeTranslation(0, -UIScreen.mainScreen.bounds.size.height);
            break;
        case MKAPopupViewAnimationSlideLeft:
            self.transform = CGAffineTransformMakeTranslation(UIScreen.mainScreen.bounds.size.width, 0);
            break;
        case MKAPopupViewAnimationSlideRight:
            self.transform = CGAffineTransformMakeTranslation(-UIScreen.mainScreen.bounds.size.width, 0);
            break;
        default:
            break;
    }
}

- (void)showWithAnimation:(MKAPopupViewAnimation)animation
                 duration:(NSTimeInterval)duration
               completion:(nullable void (^)(BOOL finished))completion {

    __weak typeof(self) weakSelf = self;

    [UIView animateWithDuration:duration
                     animations:^{
                         switch (animation) {
                             case MKAPopupViewAnimationFade:
                                 weakSelf.alpha = 1.f;
                                 break;
                             case MKAPopupViewAnimationSlideUp:
                             case MKAPopupViewAnimationSlideDown:
                             case MKAPopupViewAnimationSlideLeft:
                             case MKAPopupViewAnimationSlideRight:
                                 weakSelf.transform = CGAffineTransformMakeTranslation(0, 0);
                                 break;
                             default:
                                 break;
                         }
                     }
                     completion:completion];
}

- (void)hideWithAnimation:(MKAPopupViewAnimation)animation
                 duration:(NSTimeInterval)duration
               completion:(nullable void (^)(BOOL finished))completion {

    __weak typeof(self) weakSelf = self;

    [UIView animateWithDuration:duration
                     animations:^{
                         switch (animation) {
                             case MKAPopupViewAnimationFade:
                                 weakSelf.alpha = 0;
                                 break;
                             case MKAPopupViewAnimationSlideUp:
                                 weakSelf.transform = CGAffineTransformMakeTranslation(0,
                                                                                       -UIScreen.mainScreen.bounds.size.height);
                                 break;
                             case MKAPopupViewAnimationSlideDown:
                                 weakSelf.transform = CGAffineTransformMakeTranslation(0,
                                                                                       UIScreen.mainScreen.bounds.size.height);
                                 break;
                             case MKAPopupViewAnimationSlideLeft:
                                 weakSelf.transform = CGAffineTransformMakeTranslation(-UIScreen.mainScreen.bounds.size.width,
                                                                                       0);
                                 break;
                             case MKAPopupViewAnimationSlideRight:
                                 weakSelf.transform = CGAffineTransformMakeTranslation(UIScreen.mainScreen.bounds.size.width,
                                                                                       0);
                                 break;
                             default:
                                 break;
                         }
                     }
                     completion:completion];
}

@end

@interface MKAPopup ()

@property (nonatomic) BOOL isShowing;

@end

@implementation MKAPopup

- (instancetype)initWithContentView:(UIView *)contentView {
    self = [super initWithFrame:UIScreen.mainScreen.bounds];

    if (self) {
        _canHideWhenTouchUpOutside = YES;
        _showingAnimation = MKAPopupViewAnimationFade;
        _hidingAnimation = MKAPopupViewAnimationFade;
        _duration = 0.3;

        _popupView = [MKAPopupView new];
        _popupView.frame = CGRectMake(0, 0, 300.f, 400.f);
        [self addSubview:_popupView];

        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];

        [_popupView.containerView addSubview:contentView];

        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [_popupView.containerView addConstraints:@[
            [NSLayoutConstraint constraintWithItem:contentView
                                         attribute:NSLayoutAttributeLeft
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:_popupView.containerView
                                         attribute:NSLayoutAttributeLeft
                                        multiplier:1.f
                                          constant:0],
            [NSLayoutConstraint constraintWithItem:contentView
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:_popupView.containerView
                                         attribute:NSLayoutAttributeTop
                                        multiplier:1.f
                                          constant:0],
            [NSLayoutConstraint constraintWithItem:contentView
                                         attribute:NSLayoutAttributeRight
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:_popupView.containerView
                                         attribute:NSLayoutAttributeRight
                                        multiplier:1.f
                                          constant:0],
            [NSLayoutConstraint constraintWithItem:contentView
                                         attribute:NSLayoutAttributeBottom
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:_popupView.containerView
                                         attribute:NSLayoutAttributeBottom
                                        multiplier:1.f
                                          constant:0],
        ]];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"%s is not implemented. Use `-initWithContentView:` method instead of it", __FUNCTION__]
                                 userInfo:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"%s is not implemented. Use `-initWithContentView:` method instead of it", __FUNCTION__]
                                 userInfo:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.popupView.center = CGPointMake(self.frame.size.width / 2.f, self.frame.size.height / 2.f);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    const BOOL isBackgroundTouched = touches.anyObject.view == self;

    if (isBackgroundTouched && self.canHideWhenTouchUpOutside) {
        [self hide];
    }
}

#pragma mark - property

- (BOOL)isShowing {
    return self.superview != nil;
}

- (CGSize)popupSize {
    return self.popupView.bounds.size;
}

- (void)setPopupSize:(CGSize)popupSize {
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    CGFloat width = popupSize.width < screenSize.width ? popupSize.width : screenSize.width;
    CGFloat height = popupSize.height < screenSize.height ? popupSize.height : screenSize.height;
    self.popupView.bounds = (CGRect) { { 0, 0 }, { width, height } };
}

#pragma mark - public method

- (void)show {
    [self showWithAnimation:self.showingAnimation];
}

- (void)showWithAnimation:(MKAPopupViewAnimation)animation {
    [self showWithAnimation:animation duration:self.duration];
}

- (void)showWithAnimation:(MKAPopupViewAnimation)animation duration:(NSTimeInterval)duration {
    if (self.isShowing) {
        return;
    }

    self.alpha = 0;
    [self.popupView beginShowingAnimation:animation];

    [[UIApplication sharedApplication].keyWindow.subviews.lastObject addSubview:self];

    __weak typeof(self) weakSelf = self;

    [UIView animateWithDuration:.3 animations:^{
        weakSelf.alpha = 1.0;
    }];

    [self.popupView showWithAnimation:animation
                             duration:duration
                           completion:^(BOOL finished) {
                               if ([weakSelf.delegate respondsToSelector:@selector(popupDidAppear:)]) {
                                   [weakSelf.delegate popupDidAppear:weakSelf];
                               }
                           }];
}

- (void)hide {
    [self hideWithAnimation:self.hidingAnimation];
}

- (void)hideWithAnimation:(MKAPopupViewAnimation)animation {
    [self hideWithAnimation:animation duration:self.duration];
}

- (void)hideWithAnimation:(MKAPopupViewAnimation)animation duration:(NSTimeInterval)duration {
    if (!self.isShowing) {
        return;
    }

    __weak typeof(self) weakSelf = self;

    [UIView animateWithDuration:.3 animations:^{
        weakSelf.alpha = 0;
    }];

    [self.popupView hideWithAnimation:animation
                             duration:duration
                           completion:^(BOOL finished) {
                               [weakSelf removeFromSuperview];

                               if ([weakSelf.delegate respondsToSelector:@selector(popupDidDisappear:)]) {
                                   [weakSelf.delegate popupDidDisappear:weakSelf];
                               }
                           }];
}

@end
