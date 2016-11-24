
//
//  CustomClass.m
//  RuntimeAPI
//
//  Created by linghang on 16/11/22.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "CustomClass.h"
#import <objc/runtime.h>




@interface CustomClass ()
{
    NSLock *managerLock;
    NSMutableArray *targets;
    NSInteger num;
    NSString *strNum;
    
    BOOL flag;
    NSObject *girlFriend;
    NSObject *gayFriend;
}

@end
@implementation CustomClass
- (id)init{
    self = [super init];
    if (self) {
        class_replaceMethod([self class], @selector(test1), (IMP)test4, "@");
        ;
        strNum = @"strNum";
    }
    return self;
}
- (void)test1{
    NSLog(@"test1");
}
- (void)test2{
    NSLog(@"test2");
}
static void test4(id self, SEL _cmd, int a){
    NSLog(@"test4");
}
+ (void)test3{
    NSLog(@"test3");
}
@end
