//
//  RootVC.m
//  RN_iOS
//
//  Created by zt on 2019/5/16.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RootVC.h"
#import "RNVC.h"

@interface RootVC ()

@property (nonatomic,strong) UIButton *toRNBtn;

@end

@implementation RootVC

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];
  self.toRNBtn = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.view addSubview:self.toRNBtn];
  self.toRNBtn.frame = CGRectMake(0, 0, 300, 60);
  self.toRNBtn.center = self.view.center;
  [self.toRNBtn addTarget:self action:@selector(goToRNVC) forControlEvents:UIControlEventTouchUpInside];
  if (self.fromRN.length == 0) {
    [self.toRNBtn setTitle:@"进入RN" forState:UIControlStateNormal];
  }else {
    [self.toRNBtn setTitle:self.fromRN forState:UIControlStateNormal];
  }
}

- (void)goToRNVC {
  
  //跳到展示RN的页面
  RNVC *vc = [RNVC new];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
