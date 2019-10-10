//
//  WebViewController.m
//  uikitcore_bug
//
//  Created by a.reshetnikov on 08/10/2019.
//  Copyright © 2019 MIPT. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()
@property (strong, nonatomic, readonly) WKWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self tapOpenWebView];
}

- (void)tapOpenWebView {
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:[WKWebViewConfiguration new]];

    [self.view addSubview:_webView];
    [_webView loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"https://e.mail.ru/payment/center"]]];
}

-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_USEC), dispatch_get_main_queue(),
               ^{
                   [super presentViewController:viewControllerToPresent animated:flag completion:completion];
               });
}

@end
