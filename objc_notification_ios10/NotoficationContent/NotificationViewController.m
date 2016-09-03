//
//  NotificationViewController.m
//  NotoficationContent
//
//  Created by Андрей Решетников on 08.08.16.
//  Copyright © 2016 Андрей Решетников. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, 300);
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
}

- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption))completion
{
    NSString* actionIdentifier = response.actionIdentifier;
    NSLog(@"%@", actionIdentifier);
}

@end
