//
//  PropertiesViewController.h
//  RuntimeAPI
//
//  Created by linghang on 16/11/22.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertiesViewController : UIViewController{
    __strong id _gayFriend; // 无修饰符的对象默认会加 __strong
    __weak id _girlFriend;
    __unsafe_unretained id _company;

}

@end
