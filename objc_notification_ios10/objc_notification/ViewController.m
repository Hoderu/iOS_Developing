//
//  ViewController.m
//  objc_notification
//
//  Created by Андрей Решетников on 08.08.16.
//  Copyright © 2016 Андрей Решетников. All rights reserved.
//

#import "ViewController.h"
@import UserNotifications;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)createNotification:(id)sender {
    [self setupAndGenerateNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupAndGenerateNotification
{
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    UNNotificationAction* accept = [UNNotificationAction actionWithIdentifier:@"superAccept" title:@"Accept" options:UNNotificationActionOptionForeground];
    UNNotificationAction* cancel = [UNNotificationAction actionWithIdentifier:@"superCancel" title:@"Cancel" options:UNNotificationActionOptionDestructive];
    UNTextInputNotificationAction* comment = [UNTextInputNotificationAction actionWithIdentifier:@"superComment" title:@"Input something" options:UNNotificationActionOptionNone textInputButtonTitle:@"Comment" textInputPlaceholder:@"Input"];
    
    UNNotificationCategory* normal = [UNNotificationCategory categoryWithIdentifier:@"normalCategory" actions:@[accept, cancel, comment]intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    [center setNotificationCategories:[NSSet setWithObject:normal]];
    
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Title" arguments:@[]];
    content.body = [NSString localizedUserNotificationStringForKey:@"Body" arguments:@[]];
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
    content.categoryIdentifier = @"normalCategory";
    
    UNNotificationAttachment* attachment = [UNNotificationAttachment attachmentWithIdentifier:@"Attachment" URL:[[NSBundle mainBundle] URLForResource:@"smile" withExtension:@"gif"] options:nil error:nil];
    content.attachments = @[attachment];
    
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:false];
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"normalCategory" content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:nil];
}

@end
