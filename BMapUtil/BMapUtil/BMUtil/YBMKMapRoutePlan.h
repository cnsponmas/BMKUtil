//
//  YBMKMapRoutePlan.h
//  BMapUtil
//
//  Created by developer on 17/2/9.
//  Copyright © 2017年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "RouteAnnotation.h"

@interface YBMKMapRoutePlan : NSObject

/**
 开始路径规划
 
 @param planNodes 路径点
 @param success   成功回调（折线,折点数组）
 */
+ (void)startBMRoutePlan:(NSArray *)planNodes success:(void(^)(BMKPolyline *line, NSArray *annotations))success;


@end
