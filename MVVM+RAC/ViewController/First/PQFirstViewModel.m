//
//  PQFirstViewModel.m
//  MVVM+RAC
//
//  Created by pqwen on 2018/4/17.
//  Copyright © 2018年 pqwen. All rights reserved.
//

#import "PQFirstViewModel.h"
#import "PQMediator+TranslateView.h"

@interface PQFirstViewModel ()

@property (nonatomic, strong) id<RACSubscriber> subscriber;//强引用订阅者

@end

@implementation PQFirstViewModel

- (instancetype)init {
    if (self = [super init]) {
        //信号1
        self.coolSignal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"冷信号1发送内容"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"结束1");
            }];
        }];
        
        //信号2
        self.coolSignal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            self.subscriber = subscriber;
            [subscriber sendNext:@"冷信号2发送内容"];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"结束2");
            }];
        }];
    }
    return self;
}


@end

