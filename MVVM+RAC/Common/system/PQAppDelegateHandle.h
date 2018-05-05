//
//  PQAppDelegateHandle.h
//  MVVM+RAC
//
//  Created by pqwen on 2018/4/18.
//  Copyright © 2018年 pqwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PQAppDelegateHandle : NSObject

+ (instancetype)shareInstance;

- (void)progressHudStype;

@end
