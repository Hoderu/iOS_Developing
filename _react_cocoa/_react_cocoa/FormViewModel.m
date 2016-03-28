//
//  FormViewModel.m
//  _react_cocoa
//
//  Created by Андрей Решетников on 23.05.15.
//  Copyright (c) 2015 mipt. All rights reserved.
//

#import "FormViewModel.h"

@implementation FormViewModel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFirstName:(NSString*)firstName secondName:(NSString*)secondName {
    if (!(self = [super init])) return nil;
    _firstName = firstName;
    _secondName = secondName;
    _fullName = [firstName stringByAppendingFormat:@" %@",secondName];
    return self;
}

@end
