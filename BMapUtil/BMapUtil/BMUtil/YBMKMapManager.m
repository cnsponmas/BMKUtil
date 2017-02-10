//
//  YBMKMapManager.m
//  BMapUtil
//
//  Created by developer on 17/2/9.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "YBMKMapManager.h"

#define BaiduMapKey @"your map key"

#define YBMKMapManagerInstance [YBMKMapManager shareInstance]


@interface YBMKMapManager (){
    BMKMapManager* mapManager;
}

@end

@implementation YBMKMapManager

+ (instancetype)shareInstance
{
    static YBMKMapManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [YBMKMapManager new];
    });
    return instance;
}


+ (void)initBMKMap{
    [YBMKMapManagerInstance startMap];
}

- (void)onGetNetworkState:(int)iError{
    NSLog(@"onGetNetworkState:%d",iError);
    
    
}

- (void)onGetPermissionState:(int)iError{
    NSLog(@"onGetPermissionState:%d",iError);
}

- (void)startMap{
    mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [mapManager start:BaiduMapKey  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }else{
        NSLog(@"manager start success!");
    }
}

@end
