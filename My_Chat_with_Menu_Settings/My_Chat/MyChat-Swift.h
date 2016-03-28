//
//  MyChat_Swift.h
//  My_Chat
//
//  Created by Андрей Решетников on 28.02.16.
//  Copyright © 2016 mipt. All rights reserved.
//


#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif

#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif

#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif

#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif

@class LGChatMessage;
@class UIImage;
@class NSNotification;
@class LGChatInput;
@class UITableView;
@class NSIndexPath;
@class UIScrollView;
@class UITableViewCell;
@protocol LGChatControllerDelegate;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC10SimpleChat16LGChatController")
@interface LGChatController : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSArray<LGChatMessage *> * __nonnull messages;
@property (nonatomic) UIImage * __nullable opponentImage;
@property (nonatomic, weak) id <LGChatControllerDelegate> __nullable delegate;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)keyboardWillChangeFrame:(NSNotification * __nonnull)note;
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
- (void)addNewMessage:(LGChatMessage * __nonnull)message;
- (void)chatInputDidResize:(LGChatInput * __nonnull)chatInput;
- (void)chatInput:(LGChatInput * __nonnull)chatInput didSendMessage:(NSString * __nonnull)message;
- (CGFloat)tableView:(UITableView * __nonnull)tableView heightForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (void)scrollViewDidScroll:(UIScrollView * __nonnull)scrollView;
- (NSInteger)numberOfSectionsInTableView:(UITableView * __nonnull)tableView;
- (NSInteger)tableView:(UITableView * __nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * __nonnull)tableView:(UITableView * __nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_PROTOCOL("_TtP10SimpleChat24LGChatControllerDelegate_")
@protocol LGChatControllerDelegate
@optional
- (BOOL)shouldChatController:(LGChatController * __nonnull)chatController addMessage:(LGChatMessage * __nonnull)message;
- (void)chatController:(LGChatController * __nonnull)chatController didAddNewMessage:(LGChatMessage * __nonnull)message;
@end

@class LGStretchyTextView;

SWIFT_PROTOCOL("_TtP10SimpleChat26LGStretchyTextViewDelegate_")
@protocol LGStretchyTextViewDelegate
- (void)stretchyTextViewDidChangeSize:(LGStretchyTextView * __nonnull)chatInput;
@optional
- (void)stretchyTextView:(LGStretchyTextView * __nonnull)textView validityDidChange:(BOOL)isValid;
@end

@class UIColor;
@class UIFont;
@class UIButton;

SWIFT_CLASS("_TtC10SimpleChat11LGChatInput")
@interface LGChatInput : UIView <LGStretchyTextViewDelegate>
+ (void)setAppearanceIncludeBlur:(BOOL)includeBlur;
+ (void)setAppearanceTintColor:(UIColor * __nonnull)color;
+ (void)setAppearanceBackgroundColor:(UIColor * __nonnull)color;
+ (void)setAppearanceTextViewFont:(UIFont * __nonnull)textViewFont;
+ (void)setAppearanceTextViewTextColor:(UIColor * __nonnull)textColor;
+ (void)setAppearanceTextViewBackgroundColor:(UIColor * __nonnull)color;
@property (nonatomic) UIEdgeInsets textViewInsets;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)setup;
- (void)setupTextView;
- (void)styleTextView;
- (void)setupSendButton;
- (void)setupSendButtonConstraints;
- (void)setupTextViewConstraints;
- (void)setupBlurredBackgroundView;
- (void)setupBlurredBackgroundViewConstraints;
- (void)stylize;
- (void)stretchyTextViewDidChangeSize:(LGStretchyTextView * __nonnull)textView;
- (void)stretchyTextView:(LGStretchyTextView * __nonnull)textView validityDidChange:(BOOL)isValid;
- (void)sendButtonPressed:(UIButton * __nonnull)sender;
@end


SWIFT_CLASS("_TtC10SimpleChat13LGChatMessage")
@interface LGChatMessage : NSObject
+ (NSString * __nonnull)SentByUserString;
+ (NSString * __nonnull)SentByOpponentString;
@property (nonatomic, copy) NSString * __nonnull sentByString;
@property (nonatomic, copy) NSString * __nonnull content;
- (nonnull instancetype)initWithContent:(NSString * __nonnull)content sentByString:(NSString * __nonnull)sentByString;
- (nonnull instancetype)initWithContent:(NSString * __nonnull)content sentByString:(NSString * __nonnull)sentByString timeStamp:(NSTimeInterval)timeStamp;
@end


SWIFT_CLASS("_TtC10SimpleChat17LGChatMessageCell")
@interface LGChatMessageCell : UITableViewCell
+ (void)setAppearanceOpponentColor:(UIColor * __nonnull)opponentColor;
+ (void)setAppearanceUserColor:(UIColor * __nonnull)userColor;
+ (void)setAppearanceFont:(UIFont * __nonnull)font;
- (CGSize)setupWithMessage:(LGChatMessage * __nonnull)message;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * __nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSTextContainer;

SWIFT_CLASS("_TtC10SimpleChat18LGStretchyTextView")
@interface LGStretchyTextView : UITextView <UIScrollViewDelegate, UITextViewDelegate>
@property (nonatomic, weak) id <LGStretchyTextViewDelegate> __nullable stretchyTextViewDelegate;
@property (nonatomic) CGFloat maxHeightPortrait;
@property (nonatomic) CGFloat maxHeightLandScape;
@property (nonatomic, readonly) CGFloat maxHeight;
@property (nonatomic) CGSize contentSize;
@property (nonatomic) UIFont * __null_unspecified font;
@property (nonatomic) UIEdgeInsets textContainerInset;
- (nonnull instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer * __nullable)textContainer OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)setup;
- (void)resize;
- (CGFloat)targetHeight;
- (void)align;
- (void)textViewDidChangeSelection:(UITextView * __nonnull)textView;
- (void)textViewDidChange:(UITextView * __nonnull)textView;
@end



SWIFT_CLASS("_TtC10SimpleChat26SwiftExampleViewController")
@interface SwiftExampleViewController : UIViewController <LGChatControllerDelegate>
- (void)viewDidLoad;
- (void)launchChatController;
- (void)chatController:(LGChatController * __nonnull)chatController didAddNewMessage:(LGChatMessage * __nonnull)message;
- (BOOL)shouldChatController:(LGChatController * __nonnull)chatController addMessage:(LGChatMessage * __nonnull)message;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
