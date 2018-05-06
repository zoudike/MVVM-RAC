//
//  PQFirstViewModel.h
//  MVVM+RAC
//
//  Created by pqwen on 2018/4/17.
//  Copyright © 2018年 pqwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface PQFirstViewModel : NSObject

@property (nonatomic, strong) RACSignal *coolSignal1;            //冷信号1
@property (nonatomic, strong) RACSignal *coolSignal2;           //冷信号2
@property (nonatomic, strong) RACCommand *command;

@end
