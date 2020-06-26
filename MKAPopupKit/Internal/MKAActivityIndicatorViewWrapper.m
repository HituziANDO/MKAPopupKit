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

#import "MKAActivityIndicatorViewWrapper.h"

@interface MKAActivityIndicatorViewWrapper ()

@property (nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation MKAActivityIndicatorViewWrapper

- (instancetype)init {
    if (self = [super init]) {
        _indicatorView = [UIActivityIndicatorView new];
        if (@available(iOS 13.0, *)) {
            [self setActivityIndicatorViewStyleAndResize:UIActivityIndicatorViewStyleMedium];
        }
        else {
            [self setActivityIndicatorViewStyleAndResize:UIActivityIndicatorViewStyleGray];
        }
    }

    return self;
}

#pragma mark - MKAIndicatorInterface

- (UIView *)view {
    return self.indicatorView;
}

- (void)startAnimating {
    [self.indicatorView startAnimating];
}

- (void)stopAnimating {
    [self.indicatorView stopAnimating];
}

#pragma mark - public method

- (void)setActivityIndicatorViewStyleAndResize:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
    self.indicatorView.activityIndicatorViewStyle = activityIndicatorViewStyle;

    // Adjusts the size of the view to the style.
    if (@available(iOS 13.0, *)) {
        if (activityIndicatorViewStyle == UIActivityIndicatorViewStyleLarge) {
            self.indicatorView.bounds = CGRectMake(0, 0, 64.f, 64.f);
        }
        else {  // Medium
            self.indicatorView.bounds = CGRectMake(0, 0, 32.f, 32.f);
        }
    }
    else {
        if (activityIndicatorViewStyle == UIActivityIndicatorViewStyleWhiteLarge) {
            self.indicatorView.bounds = CGRectMake(0, 0, 64.f, 64.f);
        }
        else {  // Gray or White
            self.indicatorView.bounds = CGRectMake(0, 0, 32.f, 32.f);
        }
    }
}

@end
