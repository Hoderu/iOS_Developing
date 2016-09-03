//
//  AudioRecording.m
//  LingvoLive
//
//  Created by Андрей Решетников on 03.08.16.
//  Copyright © 2016 AbbyyMobile. All rights reserved.
//

#import "AudioRecording.h"

@implementation AudioRecording

+ (instancetype)sharedInstance
{
    static AudioRecording* _sharedAudioRecording = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedAudioRecording = [[self alloc] init];
    });
    
    return _sharedAudioRecording;
}

- (void)start
{
    NSError* error = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:&error];
    
    if (error) {
        [[SFSpeechRecognitionHelper sharedInstance] delegateMethod:error];
        return;
    }
    
    NSURL* audioURL = [RecordingFile pathUrl];
    NSDictionary *settings = @{AVFormatIDKey : [NSNumber numberWithInt: kAudioFormatMPEG4AAC],
                               AVSampleRateKey : @44100.0,
                               AVNumberOfChannelsKey : [NSNumber numberWithInt:2],
                               AVEncoderAudioQualityKey : [NSNumber numberWithLong:AVAudioQualityMax]
                               };
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:audioURL settings:settings error:&error];
    if (error)
    {
        NSLog(@"SPEECHREC %@ %@ %@", error.domain, error.description, error.userInfo);
        [[SFSpeechRecognitionHelper sharedInstance] delegateMethod:error];
        return;
    }
    self.audioRecorder.delegate = self;
    [self.audioRecorder record];
}

- (void)stop
{
    if (self.audioRecorder != nil) {
        [self.audioRecorder stop];
        self.audioRecorder = nil;
    }
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder*)aRecorder successfully:(BOOL)flag
{
    if (!flag) {
        NSLog(@"SPEECHREC !successfully");
        [self stop];
    } else {
        [[SFSpeechRecognitionHelper sharedInstance] delegateMethod:nil];
    }
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error{
    NSLog(@"SPEECHREC %@ %@ %@", error.domain, error.description, error.userInfo);
}

@end
