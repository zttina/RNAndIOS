//
//  RNVC.m
//  RN_iOS
//
//  Created by zt on 2019/5/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNVC.h"
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "RootVC.h"
@interface RNVC ()

@property (nonatomic,strong) NSMutableDictionary *dic;
@end

@implementation RNVC

- (void)viewDidLoad {
  
  [super viewDidLoad];
  self.dic = [NSMutableDictionary dictionary];
  self.title = @"RN页面";
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveFromRN:) name:@"RNToIOS" object:nil];
  //添加RN的view
  [self addRNView];
  //3s后传值给RN
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    self.dic[@"name"] = @"fromIOS-更新值";
    [[NSNotificationCenter defaultCenter]postNotificationName:@"iOSSendMsgToRN"
                                                       object:nil
                                                     userInfo:self.dic];
  });
}
- (void)receiveFromRN:(NSNotification *)noti {
  NSDictionary *dic = noti.object;
  NSString *selName = dic[@"eventName"];
  NSDictionary *propertyName = dic[@"propertyDic"];
  if (propertyName) {
    if ([self respondsToSelector:NSSelectorFromString([NSString stringWithFormat:@"%@:",selName])]) {
      [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@:",selName]) withObject:propertyName];
    }else {
      NSLog(@"===找不到此方法%@:",selName);
    }
  }else {
    if ([self respondsToSelector:NSSelectorFromString(selName)]) {
      [self performSelector:NSSelectorFromString(selName) withObject:nil];
    }else {
      NSLog(@"===找不到此方法%@",selName);
    }
  }
}
- (void)RNToIOS:(NSDictionary *)param {
  
  RootVC *rootVC = [[RootVC alloc]init];
  rootVC.fromRN = param[@"fromRN"];
  [self.navigationController pushViewController:rootVC animated:YES];
}
- (void)RNToIOS {
  
  [self.navigationController pushViewController:[RootVC new] animated:YES];
}

- (void)addRNView {
  
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
  //moduleName需要和RN文件中的registerComponent注册的名字一样
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"RN_iOS"
                                            initialProperties:nil];
  rootView.backgroundColor = [UIColor whiteColor];
  rootView.frame = self.view.bounds;
  [self.view addSubview:rootView];
  
}
- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge {
  
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
