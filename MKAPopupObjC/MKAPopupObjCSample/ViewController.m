//
//  ViewController.m
//  MKAPopupObjCSample
//
//  Created by Masaki Ando on 2019/04/05.
//  Copyright © 2019年 Hituzi Ando. All rights reserved.
//

#import <WebKit/WebKit.h>

#import <MKAPopupObjC/MKAPopupObjC.h>

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, MKAPopupDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray<NSString *> *popupList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    self.popupList = @[ @"Web Content View Popup" ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.popupList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.popupList[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    switch (indexPath.row) {
        case 0: {
            MKAPopup *popup = [self createWebContentPopup];
            popup.tag = 0;
            [popup show];
            break;
        }
        default:
            break;
    }
}

- (MKAPopup *)createWebContentPopup {
    // Creates your content view.
    WKWebView *webView = [WKWebView new];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/HituziANDO"]]];
    // Creates a popup using your content view.
    MKAPopup *popup = [[MKAPopup alloc] initWithContentView:webView];
    // Title (default is nil)
    popup.popupView.titleLabel.text = @"GitHub";
    // Title Text Color (default is system default color)
    popup.popupView.titleLabel.textColor = [UIColor whiteColor];
    // Title Font (default is system default font)
    popup.popupView.titleLabel.font = [UIFont boldSystemFontOfSize:20.f];
    // Title Text Padding (default is (16, 16, 16, 16))
    popup.popupView.titleLabel.padding = UIEdgeInsetsMake(24.f, 16.f, 24.f, 16.f);
    // Popup Background Color (default is white)
    popup.popupView.backgroundColor = [UIColor colorWithRed:0 green:.5f blue:1.f alpha:1.f];
    // Popup Corner Radius (default is 5)
    popup.popupView.layer.cornerRadius = 20.f;
    // Popup Size (default is (300, 400))
    popup.popupSize = CGSizeMake(320.f, 600.f);
    // Overlay Color (default is black with alpha=0.4)
    popup.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8f];
    // Can hide when a user touches up outside a popup (default is true)
    popup.canHideWhenTouchUpOutside = YES;
    // Showing Animation (default is fade)
    popup.showingAnimation = MKAPopupViewAnimationFade;
    // Hiding Animation (default is fade)
    popup.hidingAnimation = MKAPopupViewAnimationFade;
    // Animation Duration (default is 0.3)
    popup.duration = .3f;
    // Delegate
    popup.delegate = self;

    return popup;
}

#pragma mark - MKAPopupDelegate

- (void)popupDidAppear:(MKAPopup *)popup {
    NSLog(@"Popup(tag:%ld) did appear!", (long) popup.tag);
}

- (void)popupDidDisappear:(MKAPopup *)popup {
    NSLog(@"Popup(tag:%ld) did disappear!", (long) popup.tag);
}

@end
