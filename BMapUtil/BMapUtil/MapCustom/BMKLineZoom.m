//
//  BMKLineZoom.m
//  ZKPlatform
//
//  Created by developer on 17/1/13.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "BMKLineZoom.h"

@implementation BMKLineZoom

+ (void)mapViewFitPolyLine:(BMKPolyline *)polyLine mapView:(BMKMapView *)mapView{
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [mapView setVisibleMapRect:rect];
    mapView.zoomLevel = mapView.zoomLevel - 0.3;
}


@end
