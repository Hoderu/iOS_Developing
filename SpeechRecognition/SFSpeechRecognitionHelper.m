//
//  SFSpeechRecognitionHelper.m
//  LingvoLive
//
//  Created by Андрей Решетников on 03.08.16.
//  Copyright © 2016 AbbyyMobile. All rights reserved.
//

#import "SFSpeechRecognitionHelper.h"
#import "RecordingFile.h"
#import "AudioRecording.h"

@interface SFSpeechRecognitionHelper ()

@property (nonatomic, strong) NSURL* url;
@property (nonatomic, strong) AudioRecording* audioRecording;
@property (nonatomic, strong) NSMutableSet* allTranslations;
@property (nonatomic, strong) NSLocale* locale;

@end

@implementation SFSpeechRecognitionHelper

+ (instancetype)sharedInstance
{
    static SFSpeechRecognitionHelper* _sharedSFSpeechRecognitionHelper = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedSFSpeechRecognitionHelper = [[self alloc] init];
    });
    
    return _sharedSFSpeechRecognitionHelper;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.url = [RecordingFile pathUrl];
        self.audioRecording = [AudioRecording sharedInstance];
    }
    return self;
}

- (void)startWithLocale:(NSLocale*)locale
{
    self.locale = locale;
    [self.audioRecording start];
}

- (void)stop
{
    [self.audioRecording stop];
}

- (void)delegateMethod:(NSError*)error
{
    if (!error) {
        [self recognitionResult:self.locale block:^(NSMutableSet* result, NSString* bestTranslation, NSError* error) {
            [self.delegate didFinishedRecoring:result bestTranslation:bestTranslation error:error];
        }];
    } else {
        [self.delegate didFinishedRecoring:nil bestTranslation:nil error:error];
    }
}

- (NSArray*)translationProcessing:(NSString*)inputString
{
    //mark 0 удаляем все кавычки (разные виды бывают) и ударения (не апострофы)
    inputString = [[inputString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\"\"\\ʺ\\˝\\ˮ\\˶\\ײ\\״\\“\\”\\‟\\″\\‶\\〃\\＂\u0301"]] componentsJoinedByString:@""];
    //mark 5 удаляем парные скобки с содержимым [] ()
    NSRegularExpression* regexBrackets = [NSRegularExpression regularExpressionWithPattern: @"(?:\\([^\\(^\\)^\\[^\\]]*\\))|(?:\\[[^\\(^\\)^\\[^\\]]*\\])" options: 0 error: nil];
    inputString = [regexBrackets stringByReplacingMatchesInString:inputString options: 0 range: NSMakeRange(0, [inputString length]) withTemplate: @""];
    //mark 1 режем по , и ;
    NSArray* tokens = [[inputString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",;"]] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    //mark 2-6
    NSMutableCharacterSet* spaceSet = [NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    [spaceSet addCharactersInString:@"-"];
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < tokens.count; i++) {
        //mark 2 удаляем концевые пробелы и -
        NSString* token_i;
        token_i = [tokens[i] stringByTrimmingCharactersInSet:spaceSet];
        //mark 4 Удаляем все знаки пунктуации (точка многоточие : ! ?) исключая []()'-
        NSMutableCharacterSet* punctuationSet = [NSMutableCharacterSet punctuationCharacterSet];
        [punctuationSet removeCharactersInString:@"[]()'-"];
        token_i = [[token_i componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
        //mark 6 удалить двойные пробелы
        NSRegularExpression* regexDoubleSpaces = [NSRegularExpression regularExpressionWithPattern:@"  +" options:NSRegularExpressionCaseInsensitive error:nil];
        token_i = [regexDoubleSpaces stringByReplacingMatchesInString:token_i options:0 range:NSMakeRange(0, [token_i length]) withTemplate:@" "];
        //mark 2 удаляем концевые пробелы и -
        token_i = [token_i stringByTrimmingCharactersInSet:spaceSet];
        [resultArray addObject:token_i];
    }
    
    return resultArray;
}

- (void)recognitionResult:(NSLocale*)locale block:(void(^)(NSMutableSet* allTranslations, NSString* bestTranslation, NSError* error))completion
{
    SFSpeechRecognizer* recognizer = [[SFSpeechRecognizer alloc] initWithLocale:locale];
    
    SFSpeechURLRecognitionRequest* request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:self.url];
    self.allTranslations = [[NSMutableSet alloc] init];
    
    [recognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult* result, NSError* error) {
        if (error) {
            NSLog(@"SPEECHREC %@ %@ %@", error.domain, error.description, error.userInfo);
            NSMutableDictionary* details = [NSMutableDictionary dictionary];
            [details setValue:@"Repeate again please" forKey:NSLocalizedDescriptionKey];
            return completion(nil, nil, [NSError errorWithDomain:@"CannotHearAnything" code:200 userInfo:details]);
        } else {
            [self.allTranslations addObject:[[result bestTranscription] formattedString]];
            if (result.isFinal) {
                for(SFTranscriptionSegment* alternativeSubstringSegment in [[result bestTranscription] segments]) {
                    for(NSString* alternativeSubstring in [alternativeSubstringSegment alternativeSubstrings]) {
                        [self.allTranslations addObject:alternativeSubstring];
                    }
                }
                return completion(self.allTranslations, [[result bestTranscription] formattedString], nil);
            }
        }
    }];
}

@end
