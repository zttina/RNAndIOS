//
//  RCTMoudules.m
//  RN_iOS
//
//  Created by zt on 2019/5/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RCTMoudules.h"
#import <React/RCTBridge.h>

@implementation RCTMoudules
//导出模块,不添加参数即默认为该类的类名名
RCT_EXPORT_MODULE(RTModule)
//RN跳转原生界面，参数：eventName=方法名字，propertyDic=参数，callback可回调
RCT_EXPORT_METHOD(addEventName:(NSString *)eventName propertyDic:(NSDictionary *)propertyDic callback:(RCTResponseSenderBlock)callback)
{
  NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"eventName":eventName}];
  if (propertyDic) {
    [dic setObject:propertyDic forKey:@"propertyDic"];
  }
  NSLog(@"RN传入eventName=%@,propertyDic=%@",eventName,propertyDic);
  dispatch_async(dispatch_get_main_queue(), ^{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RNToIOS" object:dic];
  });
}

@end
