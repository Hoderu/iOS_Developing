//
//  SpeechRecognition.h
//  LingvoLive
//
//  Created by Андрей Решетников on 03.08.16.
//  Copyright © 2016 AbbyyMobile. All rights reserved.
//

@protocol SpeechRecognition
@required

- (void)recognitionResult:(NSLocale*)locale block:(void(^)(NSMutableSet* allTranslations, NSString* bestTranslation, NSError* error))completion;

@end
