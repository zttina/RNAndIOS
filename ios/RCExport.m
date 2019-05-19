//
//  RCExport.m
//  RN_iOS
//
//  Created by zt on 2019/5/16.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RCExport.h"
@interface RCExport()

@property (nonatomic,copy) NSString *ToRNStr;//要传给RN的字符串

@end
@implementation RCExport
//导出模块,不添加参数即默认为该类的类名名
RCT_EXPORT_MODULE();
//必须写的，否则程序会崩溃。
- (NSArray<NSString *> *)supportedEvents {
  //ios暴露给RN的监听事件。
  return @[@"nativeToRN"];
}
//添加通知，在iOS想调RN的地方直接发此通知即可
- (void)startObserving {
  NSLog(@"==添加通知");
  [[NSNotificationCenter defaultCenter]addObserver:self
                                          selector:@selector(iOSSendMsgToRN:)
                                              name:@"iOSSendMsgToRN"
                                            object:nil];
}
// 在此移除通知
-(void)stopObserving {
  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"iOSSendMsgToRN" object:nil];
}
- (void)iOSSendMsgToRN:(NSNotification *)noti {
  NSLog(@"iOSSendMsgToRN:%@",noti.userInfo);
  dispatch_async(dispatch_get_main_queue(), ^{
    [self sendEventWithName:@"nativeToRN" body:noti.userInfo];
  });
}

//传值
RCT_EXPORT_METHOD(getInfo:(RCTResponseSenderBlock)callback) {
  if (![self.ToRNStr isEqualToString:@"我是从iOS传来的值哟"]) {
    self.ToRNStr = @"我是从iOS传来的值哟";
    callback(@[[NSNull null],@"我是从iOS传来的值哟"]);
  }
}

@end
