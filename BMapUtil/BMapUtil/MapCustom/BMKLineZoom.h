//
//  BMKLineZoom.h
//  ZKPlatform
//
//  Created by developer on 17/1/13.
//  Copyright © 2017年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@interface BMKLineZoom : NSObject

+ (void)mapViewFitPolyLine:(BMKPolyline *)polyLine mapView:(BMKMapView *)mapView;

@end
