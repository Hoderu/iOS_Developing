//
//  SFSpeechRecognitionHelper.h
//  LingvoLive
//
//  Created by Андрей Решетников on 03.08.16.
//  Copyright © 2016 AbbyyMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioRecording.h"
#import "SpeechRecognition.h"
@import Speech;

@interface SFSpeechRecognitionHelper : NSObject <SpeechRecognition>

@property (nonatomic, weak) NSObject<AudioRecordingDelegate>* delegate;

+ (instancetype)sharedInstance;
- (instancetype)init;
- (NSArray*)translationProcessing:(NSString*)inputString;
- (void)delegateMethod:(NSError*)error;
- (void)startWithLocale:(NSLocale*)locale;
- (void)stop;

@end
