//
//  ViewController.m
//  RAC-sample
//
//  Created by Takeshita Hidenori on 2014/11/20.
//  Copyright (c) 2014年 Takeshita Hidenori. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import "ViewController.h"
#import "ReactiveCocoa.h"
#import "RACSampleViewModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmationField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.viewModel = [[RACSampleViewModel alloc] init];

    RAC(self.viewModel, usernameValue) = self.usernameField.rac_textSignal;
    RAC(self.viewModel, passwordValue) = self.passwordField.rac_textSignal;
    RAC(self.viewModel, passwordConfirmationValue) = self.passwordConfirmationField.rac_textSignal;
    RAC(self.usernameField, textColor) = RACObserve(self.viewModel, usernameTextColor);
    RAC(self.passwordField, textColor) = RACObserve(self.viewModel, passwordTextColor);
    RAC(self.passwordConfirmationField, textColor) = RACObserve(self.viewModel, passwordConfirmationTextColor);
    self.submitBtn.rac_command = self.viewModel.submitCommand;
}

@end
