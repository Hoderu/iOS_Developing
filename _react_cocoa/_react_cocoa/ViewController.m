//
//  ViewController.m
//  _react_cocoa
//
//  Created by Андрей Решетников on 23.05.15.
//  Copyright (c) 2015 mipt. All rights reserved.
//

#import "ViewController.h"
#import "FormViewModel.h"

@import ReactiveCocoa;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;

@property (nonatomic) FormViewModel *formViewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.formViewModel = [[FormViewModel alloc] init];
    //RACSignal *fntfSignal = self.firstNameTextField.rac_textSignal;
    //RACSignal *sntfSignal = self.secondNameTextField.rac_textSignal;
    
    //RAC(self.formViewModel, firstName) = self.firstNameTextField.rac_textSignal;
    //RAC(self.formViewModel, secondName) = self.secondNameTextField.rac_textSignal;
    
    /*RAC(self.fullNameLabel, text) = [RACSignal combineLatest:@[self.firstNameTextField.rac_textSignal, self.secondNameTextField.rac_textSignal] reduce:^NSString *(NSString *firstName, NSString *secondName) {
        return [firstName stringByAppendingFormat:@" %@", secondName];
    }];*/
    
    RAC(self.firstNameTextField, text) = RACObserve(self, formViewModel.firstName);
    RAC(self.secondNameTextField, text) = RACObserve(self, formViewModel.secondName);
    RAC(self.fullNameLabel, text)= RACObserve(self, formViewModel.fullName);
    
    RAC(self, formViewModel) = [RACSignal combineLatest:@[self.firstNameTextField.rac_textSignal, self.secondNameTextField.rac_textSignal] reduce:^FormViewModel *(NSString *firstName, NSString *secondName) {
        return [[FormViewModel alloc] initWithFirstName:firstName secondName:secondName];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
