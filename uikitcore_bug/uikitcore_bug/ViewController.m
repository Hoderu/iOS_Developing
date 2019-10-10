//
//  ViewController.m
//  uikitcore_bug
//
//  Created by a.reshetnikov on 08/10/2019.
//  Copyright © 2019 MIPT. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)tapOpenWebView:(id)sender {
    WebViewController *controller = [WebViewController new];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
