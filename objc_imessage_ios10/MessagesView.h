//
//  MessagesView.h
//  LingvoLive
//
//  Created by Андрей Решетников on 18.08.16.
//  Copyright © 2016 AbbyyMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessagesViewDelegate.h"
#import "ExtensionSharedManager.h"

@interface MessagesView : UIView

@property (nonatomic, weak) NSString* lastWord;
@property (nonatomic, weak) NSString* viewState;
@property (nonatomic, weak) NSString* statement;
@property (nonatomic, weak) NSObject<MessagesViewDelegate>* delegate;

@property (nonatomic, weak) IBOutlet UIStackView *buttonsStackView;
@property (nonatomic, weak) IBOutlet UITextField *inputTextField;
@property (nonatomic, weak) IBOutlet UITextField *outputTextField;
@property (nonatomic, strong) UIButton* clearButton;
@property (nonatomic, weak) IBOutlet UIButton *sourceLangButton;
@property (nonatomic, weak) IBOutlet UIButton *destLangButton;

@end
