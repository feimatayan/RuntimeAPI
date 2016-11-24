//
//  CustomClass.h
//  RuntimeAPI
//
//  Created by linghang on 16/11/22.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomClass : NSObject
@property(nonatomic,copy)NSString *ivarStr;
@property(nonatomic,strong)NSTimer *timer;
@property NSString *str;
@property NSUInteger sum;
- (void)test1;
- (void)test2;
+ (void)test3;
@end
