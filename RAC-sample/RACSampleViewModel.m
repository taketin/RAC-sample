//
//  RACSampleViewModel.m
//  RAC-sample
//
//  Created by taketin on 2014/11/20.
//  Copyright (c) 2014年 Takeshita Hidenori. All rights reserved.
//

#import "RACSampleViewModel.h"
#import "EXTScope.h"

@interface RACSampleViewModel ()

@property (strong, nonatomic) NSNumber *usernameValid;
@property (strong, nonatomic) NSNumber *passwordValid;

@end

@implementation RACSampleViewModel

- (id)init
{
    if (self = [super init]) {
        [self initialize];
    }

    return self;
}

- (void)initialize
{
    @weakify(self)

    [RACObserve(self, usernameValue) subscribeNext:^(NSString *newUsername) {
        @strongify(self)
        self.usernameValid = @(newUsername.length >= 4);
    }];

    [RACObserve(self, usernameValid) subscribeNext:^(NSNumber *isUsernameValid) {
        @strongify(self)
        UIColor *color = [UIColor grayColor];
        if ([isUsernameValid boolValue]) {
            color = [UIColor blueColor];
        }
        self.usernameTextColor = color;
    }];

    RAC(self, passwordValid) =
    [RACSignal combineLatest:@[RACObserve(self, passwordValue), RACObserve(self, passwordConfirmationValue)]
                      reduce:^(NSString *password, NSString *passwordConfirmation) {
                          return @(password.length >= 6 &&
                                   passwordConfirmation.length >= 6 &&
                                   [password isEqual:passwordConfirmation]);
                      }];

    [RACObserve(self, passwordValid) subscribeNext:^(NSNumber *isPasswordValid) {
        @strongify(self)
        UIColor *color = [UIColor grayColor];
        if ([isPasswordValid boolValue]) {
            color = [UIColor blueColor];
        }
        self.passwordTextColor = color;
        self.passwordConfirmationTextColor = color;
    }];
}

- (RACCommand *)submitCommand
{
    return [[RACCommand alloc] initWithEnabled:
            [RACSignal combineLatest:@[RACObserve(self, usernameValid), RACObserve(self, passwordValid)]
                              reduce:^(NSNumber *usernameValid, NSNumber *passwordValid) {
                                  return @([usernameValid boolValue] && [passwordValid boolValue]);
                              }] signalBlock:^RACSignal *(id input) {
                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submitted"
                                                                                  message:@""
                                                                                 delegate:nil
                                                                        cancelButtonTitle:@"OK"
                                                                        otherButtonTitles:nil];
                                  [alert show];
                                  return [RACSignal empty];
                              }];
}

@end
