

//
//  HYBMethodLearn.m
//  RuntimeAPI
//
//  Created by linghang on 16/11/25.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "HYBMethodLearn.h"
#import <objc/runtime.h>
#import <objc/message.h>
//网址：http://blog.csdn.net/woaifen3344/article/details/50505808
@implementation HYBMethodLearn
- (int)testInstanceMethod:(NSString *)name andValue:(NSNumber *)value {
    NSLog(@"%@", name);
    
    return value.intValue;
}

- (NSArray *)arrayWithNames:(NSArray *)names {
    NSLog(@"%@", names);
    return names;
}

- (void)getMethods {
    unsigned int outCount = 0;
    Method *methodList = class_copyMethodList(self.class, &outCount);
    
    for (unsigned int i = 0; i < outCount; ++i) {
        Method method = methodList[i];
        
        SEL methodName = method_getName(method);
        NSLog(@"方法名：%@", NSStringFromSelector(methodName));
        
        // 获取方法的参数类型
        unsigned int argumentsCount = method_getNumberOfArguments(method);
        char argName[512] = {};
        for (unsigned int j = 0; j < argumentsCount; ++j) {
            method_getArgumentType(method, j, argName, 512);
            
            NSLog(@"第%u个参数类型为：%s", j, argName);
            memset(argName, '\0', strlen(argName));
        }
        
        char returnType[512] = {};
        method_getReturnType(method, returnType, 512);
        NSLog(@"返回值类型：%s", returnType);
        
        // type encoding
        NSLog(@"TypeEncoding: %s", method_getTypeEncoding(method));
    }
    
    free(methodList);
}
@end
