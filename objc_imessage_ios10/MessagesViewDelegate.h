//
//  MessagesViewDelegate.h
//  LingvoLive
//
//  Created by Андрей Решетников on 18.08.16.
//  Copyright © 2016 AbbyyMobile. All rights reserved.
//

#import "MessagesView.h"

@class MessagesView;

@protocol MessagesViewDelegate <NSObject>

- (void)didAction:(MessagesView*)view action:(NSString*)action state:(NSString*)state;

@end
