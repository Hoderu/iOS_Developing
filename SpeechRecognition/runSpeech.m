@interface RunClass : UIView <AudioRecordingDelegate>
@property (nonatomic, strong) SFSpeechRecognitionHelper* audioRecordingHelper;
@end

@implementation RunClass
- (void)awakeFromNib
{
    self.audioRecordingHelper = [SFSpeechRecognitionHelper sharedInstance];
}

#pragma mark -
#pragma mark Actions

- (IBAction)startRecording:(id)sender
{
    AVAudioSession* session = [AVAudioSession sharedInstance];
    [session requestRecordPermission:^(BOOL granted) {
        if(granted) {
            [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if(status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                        [self startRecordingWithPermissions:sender];
                    } else {
                        [AlertHelper showMessage:@"Speech Recognition nedded. Go to device settings"];
                    }
                });
            }];
        } else {
            [AlertHelper showMessage:@"Microfone-permission nedded. Go to device settings"];
        }
    }];
}

- (void)startRecordingWithPermissions:(UIButton*)startButton
{
    self.audioRecordingHelper.delegate = self;
    
    TLanguage recognizerLang = self.isReverseDirection ? cardEntity.langDirection.sourceLang : cardEntity.langDirection.targetLang;
    LangObject* recLang = [[LangObject alloc] initWithLang:recognizerLang];
    NSLocale* locale = [[NSLocale alloc] initWithLocaleIdentifier:[recLang shortName]];
    [self.audioRecordingHelper startWithLocale:locale];
    
    startButton.layer.borderColor = [UIColor greenColor].CGColor;
    startButton.layer.borderWidth = 3.0f;
}

- (IBAction)stopRecording:(id)sender
{
    [self.audioRecordingHelper stop];
    UIButton* startButton = sender;
    startButton.layer.borderColor = [UIColor clearColor].CGColor;
    startButton.layer.borderWidth = 0.0f;
}


#pragma mark -
#pragma mark work with speech

- (void)didFinishedRecoring:(NSSet*)result bestTranslation:(NSString*)bestTranslation error:(NSError*)error
{
    if (error) {
        NSLog(@"SPEECHREC %@ %@ %@", error.domain, error.description, error.userInfo);
        [SuccessMessage showAfterDelay:[error.userInfo objectForKey:@"NSLocalizedDescription"] view:self.window afterDelay:1.0];
        return;
    }
    
    if (!result) {
        return;
    } else {
        NSString* translationText = self.isReverseDirection ? self.cardEntity.fromText : self.cardEntity.toText;
        NSArray* processedTranslationsLingvo = [self.audioRecordingHelper translationProcessing:translationText];
        NSString* translationSpeech;
        BOOL flagFindingTranslation = NO;
        for(NSString* processedTranslation in processedTranslationsLingvo) {
            if (!flagFindingTranslation) {
                for(translationSpeech in result) {
                    if ([[processedTranslation lowercaseString] isEqualToString:[translationSpeech lowercaseString]]) {
                        flagFindingTranslation = YES;
                        break;
                    }
                }
            }
        }
        if (flagFindingTranslation) {
            [SuccessMessage showAfterDelay:[[@"Correct: \"" stringByAppendingString:translationSpeech] stringByAppendingString:@"\""] view:self.window afterDelay:1.0];
            self.isTranslationShown = !self.isTranslationShown;
            [self showTranslation:self.isTranslationShown animated:YES];
            [self.mainController handleCardToggleTranslation:self];
            
        } else {
            [SuccessMessage showAfterDelay:[[@"Incorrect: \"" stringByAppendingString:bestTranslation] stringByAppendingString:@"\""] view:self.window afterDelay:1.0];
            //TODO
            //Алерт с шапкой error'а
        }
    }
}

@end
