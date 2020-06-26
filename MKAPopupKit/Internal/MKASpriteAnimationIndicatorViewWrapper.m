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

#import "MKASpriteAnimationIndicatorViewWrapper.h"

@interface MKASpriteAnimationIndicatorViewWrapper ()

@property (nonatomic) UIView *containerView;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic, copy, readonly) NSMutableArray<UIImage *> *images;

@end

@implementation MKASpriteAnimationIndicatorViewWrapper

- (instancetype)init {
    if (self = [super init]) {
        _containerView = [UIView new];
        _imageView = [UIImageView new];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_containerView addSubview:_imageView];
        _duration = MKAIndicatorDefaultAnimationDuration;
        _repeatCount = 0;   // Infinite
        _images = [NSMutableArray array];
    }

    return self;
}

#pragma mark - MKAIndicatorInterface

- (UIView *)view {
    return self.containerView;
}

- (void)startAnimating {
    self.imageView.animationImages = self.images;
    self.imageView.animationDuration = self.duration;
    self.imageView.animationRepeatCount = self.repeatCount;
    [self.imageView startAnimating];
}

- (void)stopAnimating {
    [self.imageView stopAnimating];
}

#pragma mark - public method

- (void)setSpriteImagesWithFormat:(NSString *)format count:(NSInteger)count {
    if (!format || count <= 0) {
        return;
    }

    [self.images removeAllObjects];

    for (NSInteger i = 0; i < count; i++) {
        [self.images addObject:[UIImage imageNamed:[NSString stringWithFormat:format, i]]];
    }

    self.containerView.bounds = (CGRect) { CGPointZero, self.images[0].size };
}

- (void)setSpriteImagesWithArray:(NSArray<UIImage *> *)images {
    if (images.count <= 0) {
        return;
    }

    [self.images removeAllObjects];
    [self.images addObjectsFromArray:images];

    self.containerView.bounds = (CGRect) { CGPointZero, self.images[0].size };
}

@end
