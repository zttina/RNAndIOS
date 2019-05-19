//
//  RootVC.h
//  RN_iOS
//
//  Created by zt on 2019/5/16.
//  Copyright © 2019 Facebook. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootVC : UIViewController

//用来接收从RN传过来的参数
@property (nonatomic,copy) NSString *fromRN;

@end

NS_ASSUME_NONNULL_END
