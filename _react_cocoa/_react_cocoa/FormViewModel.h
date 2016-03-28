//
//  FormViewModel.h
//  _react_cocoa
//
//  Created by Андрей Решетников on 23.05.15.
//  Copyright (c) 2015 mipt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormViewModel : UIView

@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *secondName;
@property(nonatomic) NSString *fullName;
- (instancetype)initWithFirstName:(NSString*)firstName secondName:(NSString*)secondName;
@end
