//
//  RACSampleViewModel.h
//  RAC-sample
//
//  Created by taketin on 2014/11/20.
//  Copyright (c) 2014年 Takeshita Hidenori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface RACSampleViewModel : NSObject

@property (nonatomic, copy) NSString *usernameValue;
@property (nonatomic, copy) NSString *passwordValue;
@property (nonatomic, copy) NSString *passwordConfirmationValue;
@property (nonatomic, strong) UIColor *usernameTextColor;
@property (nonatomic, strong) UIColor *passwordTextColor;
@property (nonatomic, strong) UIColor *passwordConfirmationTextColor;
@property (nonatomic, readonly) RACCommand *submitCommand;

@end