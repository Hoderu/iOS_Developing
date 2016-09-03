//
//  RecordingFile.m
//  LingvoLive
//
//  Created by Андрей Решетников on 03.08.16.
//  Copyright © 2016 AbbyyMobile. All rights reserved.
//

#import "RecordingFile.h"

@implementation RecordingFile

static NSString* const fileName = @"recording";
static NSString* const fileExtension = @"m4a";

+ (NSURL*)pathUrl
{
    NSString* paths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString* urlPath = [[paths stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:fileExtension];
    
    return [[NSURL alloc] initFileURLWithPath:urlPath];
}

@end
