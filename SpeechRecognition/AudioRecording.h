//
//  AudioRecording.h
//  LingvoLive
//
//  Created by Андрей Решетников on 03.08.16.
//  Copyright © 2016 AbbyyMobile. All rights reserved.
//

#import "RecordingFile.h"
#import "AudioRecordingDelegate.h"
#import "SFSpeechRecognitionHelper.h"
#import <AVFoundation/AVFoundation.h>
@import AVFoundation;

@interface AudioRecording : NSObject <AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder* audioRecorder;

+ (instancetype)sharedInstance;
- (void)start;
- (void)stop;

@end
