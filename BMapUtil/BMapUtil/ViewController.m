//
//  ViewController.m
//  BMapUtil
//
//  Created by developer on 17/2/9.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <Masonry/Masonry.h>

#import "YBMKMapRoutePlan.h"
#import "YBMKAddressItem.h"

@interface ViewController ()<BMKMapViewDelegate>{
    BMKMapView *_mapView;
    NSArray *addresses;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatMapView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)creatMapView{
    _mapView = [[BMKMapView alloc]init];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
   UIButton* startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startRoute) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(25);
        make.left.mas_equalTo(self.view).offset(0);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];

}



- (void)startRoute{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    
    NSArray *keys = @[@"百度大厦",@"天安门",@"长城"];
    NSMutableArray *items = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < keys.count; i++) {
        YBMKAddressItem *item1 = [[YBMKAddressItem alloc]init];
        item1.city = @"北京";
        item1.key = keys[i];
        [items addObject:item1];
    }

    
    [YBMKMapRoutePlan startBMRoutePlan:items success:^(BMKPolyline *line, NSArray *annotations) {
        for (RouteAnnotation* item in annotations) {
            [_mapView addAnnotation:item];
        }
        [_mapView addOverlay:line];
        [self mapViewFitPolyLine:line];
    }];
}

- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
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
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
}


- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [(RouteAnnotation*)annotation getRouteAnnotationView:view];
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
