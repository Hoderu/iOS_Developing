//
//  AudioRecordingDelegate.h
//  LingvoLive
//
//  Created by Андрей Решетников on 03.08.16.
//  Copyright © 2016 AbbyyMobile. All rights reserved.
//

@protocol AudioRecordingDelegate
@required

- (void)didFinishedRecoring:(NSSet*)result bestTranslation:(NSString*)bestTranslation error:(NSError*)error;

@end
