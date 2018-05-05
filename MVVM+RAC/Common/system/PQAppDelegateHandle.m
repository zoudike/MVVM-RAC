//
//  PQAppDelegateHandle.m
//  MVVM+RAC
//
//  Created by pqwen on 2018/4/18.
//  Copyright © 2018年 pqwen. All rights reserved.
//

#import "PQAppDelegateHandle.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation PQAppDelegateHandle

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static PQAppDelegateHandle *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super alloc] init];
    });
    return instance;
}

- (void)progressHudStype {
    SVProgressHUD.defaultStyle = SVProgressHUDStyleDark;
    SVProgressHUD.defaultMaskType = SVProgressHUDMaskTypeBlack;
}

@end
