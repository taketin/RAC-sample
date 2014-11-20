//
//  ViewController.h
//  RAC-sample
//
//  Created by Takeshita Hidenori on 2014/11/20.
//  Copyright (c) 2014年 Takeshita Hidenori. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSampleViewModel;

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) RACSampleViewModel *viewModel;

@end

