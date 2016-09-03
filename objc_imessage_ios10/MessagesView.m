//
//  MessagesView.m
//  LingvoLive
//
//  Created by Андрей Решетников on 18.08.16.
//  Copyright © 2016 AbbyyMobile. All rights reserved.
//

#import "MessagesView.h"

@interface MessagesView ()

@end

@implementation MessagesView


- (id)initWithFrame:(CGRect)theFrame {
    self = [super initWithFrame:theFrame];
    self.viewState = @"smallSizeScreen";
    self.lastWord = @"";
    self.statement = @"Small";
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    self.viewState = @"smallSizeScreen";
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateOutput) userInfo:nil repeats:true];
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.inputTextField.enabled = YES;
    self.outputTextField.enabled = NO;
    [self updateInterface];
}

- (void)addCustomClearButton
{
    int kClearButtonWidth = 25;
    int kClearButtonHeight = kClearButtonWidth;
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clearButton setImage:[UIImage imageNamed:@"clear_button_picture"] forState:UIControlStateNormal];
    [self.clearButton setImage:[UIImage imageNamed:@"clear_button_picture_pressed"] forState:UIControlStateHighlighted];
    
    self.clearButton.frame = CGRectMake(0, 0, kClearButtonWidth, kClearButtonHeight);
    self.clearButton.center = CGPointMake(self.inputTextField.frame.size.width - kClearButtonWidth , kClearButtonHeight);
    
    [self.clearButton addTarget:self action:@selector(clearTextView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.inputTextField.rightViewMode = UITextFieldViewModeWhileEditing;
    self.inputTextField.rightView = self.clearButton;
}

- (void)clearTextView:(id)sender
{
    self.inputTextField.text = @"";
    self.outputTextField.text = @"";
    self.lastWord = @"";
}

- (IBAction)inputTextFieldToExpandedSize:(id)sender {
    [self.delegate didAction:self action:@"fullSizeAction" state:self.viewState];
    [self addCustomClearButton];
    self.statement = @"Full";
}

- (IBAction)Copy:(id)sender {
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.outputTextField.text;
    if ([self.statement  isEqual: @"Full"]) {
        [self.delegate didAction:self action:@"smallSizeAction" state:self.viewState];
        self.statement = @"Small";
    }
}

- (IBAction)sourceLangButtonTouched:(id)sender
{
    [self.delegate didAction:self action:@"openUrlSourceLangButtonTouched" state:nil];
}

- (IBAction)destLangButtonTouched:(id)sender
{
    [self.delegate didAction:self action:@"openUrlDestLangButtonTouched" state:nil];
}

- (void)updateOutput
{
    if ((self.inputTextField.text != nil) && ([self.inputTextField.text containsString:@" "]))
    {
        if (![self.inputTextField.text isEqual:self.lastWord]) {
            self.lastWord = self.inputTextField.text;
            [self LLTranslate: self.inputTextField.text];
        }
    } else
    {
        self.outputTextField.text = @"";
    }
}

- (void)updateInterface
{
    [self.sourceLangButton setTitle:[ExtensionSharedManager sharedManager].currentSourceFullLangName forState:UIControlStateNormal];
    [self.destLangButton setTitle:[ExtensionSharedManager sharedManager].currentTargetFullLangName forState:UIControlStateNormal];
}

- (void)LLTranslate:(NSString*)russianInputString
{
    NSURLResponse* response;
    NSString* answer = @"";
    
    //Hide information
    NSString* url = @"abbyyTranslate";
    NSString* ProxyTranslateEngineProxyAuthorization = @"clientScheme";
    //-------
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc]initWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    request.HTTPMethod = @"POST";
    [request setValue:ProxyTranslateEngineProxyAuthorization forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"LingvoLive/1.28 (iPhone; iOS 9.3; Scale/3.00)" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"ru;q=1" forHTTPHeaderField:@"Accept-Language"];
    
    NSString* langS = [@"en" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* langT = [@"ru" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* servers = [@"Auto" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* tempStr = [russianInputString stringByAppendingString:@"\n"];
    NSString* q = [tempStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* paramsString = [NSString stringWithFormat:@"source=%@&target=%@&servers=%@&q=%@", langS, langT, servers, q];
    request.HTTPBody = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError* error;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error == nil) {
        NSObject* jsonList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error == nil) {
            NSObject* dataJson = [[[jsonList valueForKey:@"data"] valueForKey:@"translations"] objectAtIndex:0];
            answer = [dataJson valueForKey:@"translatedText"];
            self.outputTextField.text = answer;
        } else {
            NSLog(@"Ошибка с парсингом: %@", error.description);
        }
    } else {
        NSLog(@"Ошибка в data: %@", error.description);
    }
}

@end
