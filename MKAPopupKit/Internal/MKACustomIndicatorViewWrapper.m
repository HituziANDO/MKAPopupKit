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

#import "MKACustomIndicatorViewWrapper.h"

@interface MKACustomIndicatorViewWrapper ()

@property (nonatomic) UIView *containerView;
@property (nonatomic) UIImageView *imageView;

@end

@implementation MKACustomIndicatorViewWrapper

- (instancetype)init {
    if (self = [super init]) {
        _containerView = [UIView new];
        _imageView = [UIImageView new];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_containerView addSubview:_imageView];
        _duration = MKAIndicatorDefaultAnimationDuration;
        _repeatCount = MKAIndicatorDefaultRepeatCount;
    }

    return self;
}

#pragma mark - MKAIndicatorInterface

- (UIView *)view {
    return self.containerView;
}

- (void)startAnimating {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = self.duration;
    animation.repeatCount = self.repeatCount;
    animation.fromValue = @(0);
    animation.toValue = @(2.0 * M_PI);
    // Do not restore when animation ends.
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.imageView.layer addAnimation:animation forKey:MKAIndicatorRotationAnimationKey];
}

- (void)stopAnimating {
    [self.imageView.layer removeAnimationForKey:MKAIndicatorRotationAnimationKey];
}

#pragma mark - public method

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    self.containerView.bounds = (CGRect) { CGPointZero, image.size };
}

@end
