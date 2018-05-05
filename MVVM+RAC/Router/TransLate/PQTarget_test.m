//
//  PQTarget_test.m
//  MVVM+RAC
//
//  Created by pqwen on 2018/4/18.
//  Copyright © 2018年 pqwen. All rights reserved.
//

#import "PQTarget_test.h"
#import "PQSecondViewController.h"

@implementation PQTarget_test

- (UIViewController *)action_present:(NSDictionary *)params {
    return [PQSecondViewController viewController];
}

@end
