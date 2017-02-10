//
//  YBMKMapRoutePlan.m
//  BMapUtil
//
//  Created by developer on 17/2/9.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "YBMKMapRoutePlan.h"
#import "YBMKAddressItem.h"

#define YBMKMapRoutePlanInstance [YBMKMapRoutePlan shareInstance]

@interface YBMKMapRoutePlan ()<BMKRouteSearchDelegate>{
    int routePlanPointCounts;
    int planNodeTag;
    NSMutableArray *annotations;
    NSMutableArray *transitSteps;
}
@property (nonatomic, strong)void (^successBlock)(BMKPolyline *line, NSArray *annotations);

@property (nonatomic, strong) BMKRouteSearch *routeSearch;

@property (nonatomic, strong) NSArray *addresses;

@end

@implementation YBMKMapRoutePlan

+ (instancetype)shareInstance
{
    static YBMKMapRoutePlan* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [YBMKMapRoutePlan new];
    });
    return instance;
}

- (id)init{
    self = [super init];
    if (self) {
        routePlanPointCounts = 0;
        planNodeTag = 0;
        annotations = [NSMutableArray array];
        transitSteps = [NSMutableArray array];
    }
    return self;
}

- (BMKRouteSearch *)routeSearch{
    if (!_routeSearch) {
        _routeSearch = [[BMKRouteSearch alloc] init];
        _routeSearch.delegate = self;
    }
    return _routeSearch;
}

+ (void)startBMRoutePlan:(NSArray *)planNodes success:(void (^)(BMKPolyline *, NSArray *))success{
    if (planNodes.count < 2) {
        NSLog(@"路径规划至少需要两个点");
        return;
    }
    YBMKMapRoutePlanInstance.addresses = [NSArray arrayWithArray:planNodes];
    YBMKMapRoutePlanInstance.successBlock = success;
    [YBMKMapRoutePlanInstance startRoute];
}

- (void)startRoute{
    
    
    YBMKAddressItem *item_start = [_addresses objectAtIndex:planNodeTag];
    YBMKAddressItem *item_end = [_addresses objectAtIndex:planNodeTag+1];
    
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.name = item_start.key;
    start.cityName = item_start.city;
    
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.name = item_end.key;
    end.cityName = item_end.city;
    
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    drivingRouteSearchOption.drivingRequestTrafficType = BMK_DRIVING_REQUEST_TRAFFICE_TYPE_NONE;//不获取路况信息
    BOOL flag = [self.routeSearch drivingSearch:drivingRouteSearchOption];
    if(flag)
    {
        NSLog(@"car检索发送成功");
    }
    else
    {
        NSLog(@"car检索发送失败");
    }
}


#pragma mark - MapDelegate
- (void)onGetDrivingRouteResult:(BMKRouteSearch *)searcher
                         result:(BMKDrivingRouteResult *)result
                      errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        NSInteger size = [plan.steps count];
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            [self addRouteAnnotation:i routeLine:plan];
            routePlanPointCounts += transitStep.pointsCount;
        }
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [annotations addObject:item];
            }
        }
        [self addTempPointsRouteLine:plan];
        
        }
    planNodeTag++;
    
    if (planNodeTag == _addresses.count - 1) {
        [self addTemp];
        return;
    }
    [self startRoute];

}


/**
 路段数组 组装成折线
 */
- (void)addTemp{
    BMKMapPoint * temppoints = new BMKMapPoint[routePlanPointCounts];
    int i = 0;
    for (int j = 0; j < transitSteps.count; j++) {
        BMKDrivingStep* transitStep = [transitSteps objectAtIndex:j];
        int k=0;
        for(k=0;k<transitStep.pointsCount;k++) {
            temppoints[i].x = transitStep.points[k].x;
            temppoints[i].y = transitStep.points[k].y;
            i++;
        }
    }
    
    BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:routePlanPointCounts];
    delete []temppoints;
    
    _successBlock(polyLine,annotations);
}


/**
 添加 路段 到数组
 
 @param plan BMKDrivingRouteLine
 */
- (void)addTempPointsRouteLine:(BMKDrivingRouteLine *)plan{
    NSInteger size = [plan.steps count];
    for (int j = 0; j < size; j++) {
        BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
        [transitSteps addObject:transitStep];
    }
}


/**
 遍历百度地图返回的 折点信息 添加到数组
 
 @param index index
 @param plan  BMKDrivingRouteLine
 */
- (void)addRouteAnnotation:(int)index routeLine:(BMKDrivingRouteLine *)plan{
    NSInteger size = [plan.steps count];
    
    if(index == 0 && planNodeTag == 0){
        RouteAnnotation* item = [[RouteAnnotation alloc]init];
        item.coordinate = plan.starting.location;
        item.title = @"起点";
        item.type = 0;
        [annotations addObject:item];
    }else if(index == size-1){
        RouteAnnotation* item = [[RouteAnnotation alloc]init];
        item.coordinate = plan.terminal.location;
        if (planNodeTag == 0) {
            YBMKAddressItem *item_end = [_addresses objectAtIndex:planNodeTag+1];
            item.title = item_end.key;
            item.type = 5;
        }else if (planNodeTag == _addresses.count - 2){
            item.title = @"终点";
            item.type = 1;
        }else{
            //item.title = addresses[planNodeTag+1];
            item.type = 5;
        }
        [annotations addObject:item];
    }
}


@end
