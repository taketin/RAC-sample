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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.submitBtn.enabled = NO;
    @weakify(self)

    RAC(self, usernameValid) =
    [self.usernameField.rac_textSignal map:^(NSString *newName) {
        return @(newName.length >= 4);
    }];

    [RACObserve(self, usernameValid) subscribeNext:^(NSNumber *isUsernameValid) {
        @strongify(self)
        if ([isUsernameValid boolValue]) {
            self.usernameField.textColor = [UIColor blueColor];
        } else {
            self.usernameField.textColor = [UIColor grayColor];
        }
    }];

    RAC(self, passwordValid) =
    [RACSignal combineLatest:@[self.passwordField.rac_textSignal, self.passwordConfirmationField.rac_textSignal]
                      reduce:^(NSString *password, NSString *passwordConfirmation) {
                          return @(password.length >= 6 &&
                                   passwordConfirmation.length >= 6 &&
                                   [password isEqual:passwordConfirmation]);
                      }];

    [RACObserve(self, passwordValid) subscribeNext:^(NSNumber *isPasswordValid) {
        @strongify(self)
        if ([isPasswordValid boolValue]) {
            self.passwordField.textColor = [UIColor blueColor];
            self.passwordConfirmationField.textColor = [UIColor blueColor];
        } else {
            self.passwordField.textColor = [UIColor grayColor];
            self.passwordConfirmationField.textColor = [UIColor grayColor];
        }
    }];

    RAC(self.submitBtn, enabled) =
    [RACSignal combineLatest:@[RACObserve(self, usernameValid), RACObserve(self, passwordValid)]
                      reduce:^(NSNumber *isUsernameValid, NSNumber *isPasswordValid) {
                          return @([isUsernameValid boolValue] && [isPasswordValid boolValue]);
                      }];

    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *submitBtn) {
        if (submitBtn.enabled) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submitted"
                                                            message:@""
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
}

@end
