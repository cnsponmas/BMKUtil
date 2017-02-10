//
//  YBMKError.m
//  BMapUtil
//
//  Created by developer on 17/2/9.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "YBMKError.h"

@implementation YBMKError

+ (id)yBMKErrorWithCode:(NSInteger)code message:(NSString *)message{
    NSString *domain = [[NSBundle mainBundle]bundleIdentifier];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
    return [super errorWithDomain:domain code:code userInfo:userInfo];
}


@end
