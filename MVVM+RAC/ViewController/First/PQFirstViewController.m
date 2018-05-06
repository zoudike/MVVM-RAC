//
//  PQFirstViewController.m
//  MVVM+RAC
//
//  Created by pqwen on 2018/4/17.
//  Copyright © 2018年 pqwen. All rights reserved.
//

#import "PQFirstViewController.h"
#import "PQFirstViewModel.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface PQFirstViewController ()

- (IBAction)coolSignalTestAction:(id)sender;
- (IBAction)coolSignal2TestAction:(id)sender;
- (IBAction)subjectTestAction:(id)sender;
- (IBAction)subjectTestAction2:(id)sender;
- (IBAction)replaySubjectTestAction:(id)sender;
- (IBAction)repeatSubscriberTestAction:(id)sender;
- (IBAction)connectTestAction:(id)sender;
- (IBAction)commandTestAction:(id)sender;



@property (nonatomic, strong)PQFirstViewModel *viewModel;

@end

@implementation PQFirstViewController

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
}

- (void)bindViewModel {
    self.viewModel = [[PQFirstViewModel alloc] init];
    //command处理结果，如果涉及UI的变化可以在viewcontroller或者view中进行订阅
    [[[self.viewModel.command.executionSignals switchToLatest] deliverOnMainThread] subscribeNext:^(id x) {
        NSLog(@"捕获结果再处理ui层的变化");
    }];
}

#pragma mark -- Actions

- (IBAction)coolSignalTestAction:(id)sender {
    [self.viewModel.coolSignal1 subscribeNext:^(id x) {
        NSLog(@"只有被订阅了才能触发信号");
    }];
}

- (IBAction)coolSignal2TestAction:(id)sender {
    RACDisposable *disposable = [self.viewModel.coolSignal2 subscribeNext:^(id x) {
        NSLog(@"信号没有被完成可以使用手动释放订阅");
    }];
    //可以打开下面注释的方法，信号的订阅将结束
//    [disposable dispose];
}

//只有先订阅再发送信号，订阅者才能接受值
- (IBAction)subjectTestAction:(id)sender {
    RACSubject *tempSubject = [RACSubject subject];
    [tempSubject sendNext:@"123"];
    [tempSubject subscribeNext:^(id x) {
        NSLog(@"subscriber %@",x);
    }];
}

- (IBAction)subjectTestAction2:(id)sender {
    RACSubject *tempSubject = [RACSubject subject];
    [tempSubject subscribeNext:^(id x) {
        NSLog(@"subscriber %@",x);
    }];
    [tempSubject subscribeNext:^(id x) {
        NSLog(@"subscriber2 %@",x);
    }];
    [tempSubject sendNext:@"1234"];
}

- (IBAction)replaySubjectTestAction:(id)sender {
    RACReplaySubject *tempReplaySubject = [RACReplaySubject subject];
    //可以先发信号再订阅
    [tempReplaySubject sendNext:@"123"];
    [tempReplaySubject sendNext:@"1234"];
    [tempReplaySubject subscribeNext:^(id x) {
        NSLog(@"subscriber %@",x);
    }];
}

- (IBAction)repeatSubscriberTestAction:(id)sender {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"进入block");
        [subscriber sendNext:nil];
        return nil;
    }];
        [signal subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
        [signal subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
        [signal subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
}

- (IBAction)connectTestAction:(id)sender {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"进入block");
        [subscriber sendNext:nil];
        return nil;
    }];
    RACMulticastConnection *connection = [signal publish];
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"subscriber1");
    }];
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"subscriber2");
    }];
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"subscriber3");
    }];
    [connection connect];
    
}

- (IBAction)commandTestAction:(id)sender {
    [self.viewModel.command execute:nil];
}

@end
