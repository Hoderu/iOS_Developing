//
//  MessagesViewController.h
//  LingvoLiveiMessage
//
//  Created by Андрей Решетников on 18.08.16.
//  Copyright © 2016 AbbyyMobile. All rights reserved.
//

#import <Messages/Messages.h>
#import "MessagesView.h"
#import "ExtensionSharedConstants.h"

@interface MessagesViewController : MSMessagesAppViewController
@property (weak, nonatomic) IBOutlet MessagesView* messagesView;

@end
