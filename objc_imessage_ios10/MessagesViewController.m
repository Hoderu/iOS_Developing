//
//  MessagesViewController.m
//  LingvoLiveiMessage
//
//  Created by Андрей Решетников on 18.08.16.
//  Copyright © 2016 AbbyyMobile. All rights reserved.
//

#import "MessagesViewController.h"
#import "MessagesViewDelegate.h"
@import Messages;

@interface MessagesViewController () <MessagesViewDelegate>

@property (nonatomic, assign) BOOL flagDoubleFullSize;
@property (nonatomic, weak) NSString* actionPair;

@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messagesView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Conversation Handling

- (void)willBecomeActiveWithConversation:(MSConversation *)conversation
{
    [super willBecomeActiveWithConversation:conversation];
    self.messagesView.viewState = ([self.actionPair  isEqual: @"translation"]) ? @"fullSizeScreen" : @"smallSizeScreen";
}

-(void)didBecomeActiveWithConversation:(MSConversation*)conversation
{
    [super didBecomeActiveWithConversation:conversation];
}

- (void)didResignActiveWithConversation:(MSConversation *)conversation
{
    [super didResignActiveWithConversation:conversation];
}

-(void)willResignActiveWithConversation:(MSConversation*)conversation
{
    [super willResignActiveWithConversation:conversation];
}

-(void)didReceiveMessage:(MSMessage*)message conversation:(MSConversation*)conversation {}
-(void)didStartSendingMessage:(MSMessage*)message conversation:(MSConversation*)conversation {}
-(void)didCancelSendingMessage:(MSMessage*)message conversation:(MSConversation*)conversation {}

- (void)willSelectMessage:(MSMessage *)message conversation:(MSConversation *)conversation
{
    [super willSelectMessage:message conversation:conversation];
    self.messagesView.viewState = ([self.actionPair  isEqual: @"translation"]) ? @"fullSizeScreen" : @"smallSizeScreen";
}

- (void)didSelectMessage:(MSMessage *)message conversation:(MSConversation *)conversation
{
    [super didSelectMessage:message conversation:conversation];
}

-(void)willTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    [super willTransitionToPresentationStyle:presentationStyle];
    switch (presentationStyle) {
        case MSMessagesAppPresentationStyleCompact:
            self.actionPair = @"copying";
            self.messagesView.viewState = @"smallSizeScreen";
            break;
            
        case MSMessagesAppPresentationStyleExpanded:
            self.flagDoubleFullSize = YES;
            break;
            
        default:
            break;
    }
}

-(void)didTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    [super didTransitionToPresentationStyle:presentationStyle];
    switch (presentationStyle) {
        case MSMessagesAppPresentationStyleExpanded:
            [self.messagesView.inputTextField becomeFirstResponder];
            break;
            
        default:
            break;
    }
}

//NSString* const TodayChangeSourceLangURLSchemeHost = @"today_change_source_lang";

- (void)sourceLangButtonTouched
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"lvlive://%@", TodayChangeSourceLangURLSchemeHost]];
    [self.extensionContext openURL:url completionHandler:nil];
}

//NSString* const TodayChangeTargetLangURLSchemeHost = @"today_change_target_lang";

- (void)destLangButtonTouched
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"lvlive://%@", TodayChangeTargetLangURLSchemeHost]];
    [self.extensionContext openURL:url completionHandler:nil];
}

- (void)didAction:(MessagesView*)view action:(NSString*)action state:(NSString*)state
{
    if ([action isEqualToString:@"openUrlSourceLangButtonTouched"]) {
        [self sourceLangButtonTouched];
    } else if ([action isEqualToString:@"openUrlDestLangButtonTouched"]) {
        [self destLangButtonTouched];
    }
    
    NSString* newPair = ([action isEqual:@"smallSizeAction"]) ? @"copying" : @"translation";
    NSString* newViewState = ([newPair  isEqual:@"translation"]) ? @"fullSizeScreen" : @"smallSizeScreen";
    
    if ([newViewState isEqual:@"fullSizeScreen"]) {
        if (!self.flagDoubleFullSize) {
            [self requestPresentationStyle:MSMessagesAppPresentationStyleExpanded];
        }
        self.flagDoubleFullSize = NO;
    } else if ([newViewState isEqual:@"smallSizeScreen"]) {
        [self requestPresentationStyle:MSMessagesAppPresentationStyleCompact];
    } else {
        [self dismiss];
    }
    
    self.actionPair = newPair;
    self.messagesView.viewState = newViewState;
}

@end
