//
//  AppDelegate.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import "User.h"

@implementation User
//添加了下面的宏定义
MJExtensionCodingImplementation
/* 实现下面的方法，说明哪些属性不需要归档和解档 */
+ (NSArray *)mj_ignoredCodingPropertyNames{
    return @[];
}

+ (void)saveUser:(User *)user{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:user] forKey:@"userInfo"];
//    if (!user.skey) {
//       user.skey= [defaults objectForKey:Skey];
//    }
//    if (user.uid.length>0) {
//        [defaults setObject:user.uid forKey:UserID];
//       }
    [defaults synchronize];
}


+ (User *)getUser{
    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]];
    return user;
}

+ (void)deleUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:nil forKey:@"userInfo"];
//    [defaults setValue:nil forKey:UserID];
//    [defaults setValue:nil forKey:Token];
    [defaults synchronize];
}

//+ (NSString *)getUserID {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults objectForKey:UserID];
//}
//
//+ (NSString *)getToken {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults objectForKey:Token];
//}



@end