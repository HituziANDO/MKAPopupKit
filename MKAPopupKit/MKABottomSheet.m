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

#import "MKABottomSheet.h"

@implementation MKABottomSheet

- (instancetype)initWithContentView:(__kindof UIView *)contentView {
    if (self = [super initWithContentView:contentView]) {
        self.showingAnimation = MKAPopupViewAnimationSlideUp;
        self.hidingAnimation = MKAPopupViewAnimationSlideDown;
        self.sheetHeight = 300.f;
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.popupView.frame = CGRectMake(0, 0, self.frame.size.width, self.sheetHeight);
    self.popupView.center = CGPointMake(self.frame.size.width / 2.f, self.frame.size.height - self.sheetHeight / 2.f);
}

#pragma mark - public method

- (CGFloat)sheetHeight {
    return self.popupSize.height;
}

- (void)setSheetHeight:(CGFloat)sheetHeight {
    self.popupSize = CGSizeMake(0, sheetHeight);
}

- (instancetype)withSheetHeight:(CGFloat)height {
    self.sheetHeight = height;
    return self;
}

@end
