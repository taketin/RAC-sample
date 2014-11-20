//
//  ViewController.h
//  RAC-sample
//
//  Created by Takeshita Hidenori on 2014/11/20.
//  Copyright (c) 2014年 Takeshita Hidenori. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmationField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) NSNumber *usernameValid;
@property (strong, nonatomic) NSNumber *passwordValid;

@end

