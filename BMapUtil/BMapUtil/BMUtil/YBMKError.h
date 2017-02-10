//
//  YBMKError.h
//  BMapUtil
//
//  Created by developer on 17/2/9.
//  Copyright © 2017年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - 检索结果
///检索接口为空
static int const YBMKErrorCode_POI_None          = 1001;

///网络出现问题
static int const YBMKErrorCode_POI_NetworkFailed = 1002;

///检索失败
static int const YBMKErrorCode_POI_Failed        = 1003;

///检索出现错误
static int const YBMKErrorCode_POI_Error         = 1004;

@interface YBMKError : NSError

+ (id)yBMKErrorWithCode:(NSInteger)code message:(NSString *)message;

@end
