//
//  PQSecondViewController.m
//  MVVM+RAC
//
//  Created by pqwen on 2018/4/17.
//  Copyright © 2018年 pqwen. All rights reserved.
//

#import "PQSecondViewController.h"
#import "PQSecondViewModel.h"

@interface PQSecondViewController ()

@property (nonatomic, strong) PQSecondViewModel *viewModel;
- (IBAction)dismiss:(id)sender;

@end

@implementation PQSecondViewController


#pragma mark -- life cycle

+ (instancetype)viewController {
    PQSecondViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    vc.viewModel = [[PQSecondViewModel alloc] init];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- actions



- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
