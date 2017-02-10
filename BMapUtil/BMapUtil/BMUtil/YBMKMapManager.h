//
//  YBMKMapManager.h
//  BMapUtil
//
//  Created by developer on 17/2/9.
//  Copyright © 2017年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>

@interface YBMKMapManager : NSObject<BMKGeneralDelegate>

+ (void)initBMKMap;

/**
 初始化百度地图
 */
- (void)startMap;

@end
