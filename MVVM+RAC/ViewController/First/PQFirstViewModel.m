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

//创建command，一般这种实现业务逻辑的操作放在viewmodel中
- (RACCommand *)command {
    if (!_command) {
        _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@" 此处可以进行网络请求或者其他的操作,操作结果可以通过订阅者send出去");
                //模拟一个网络请求
                dispatch_async(dispatch_queue_create(0, 0), ^{
                    [subscriber sendNext:@"事件处理结果"];
                    [subscriber sendCompleted];
                });
                return nil;
            }];
        }];
    }
    return _command;
}

@end

