# BMKUtil

![image](https://github.com/yanlinhong/BMKUtil/blob/master/BMapUtil/BMapUtil/bmk.png)
百度地图多点规划
===
这是我自己在github上分享的第一个项目，请大家指点指点

在使用百度地图的时候遇到的一个需求，多点路径规划，按照百度地图官方文档，写的有点麻烦，就自己稍微封装了一下 
使用方法
```c
  
    NSArray *keys = @[@"百度大厦",@"天安门",@"长城"];
    NSMutableArray *items = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < keys.count; i++) {
        YBMKAddressItem *item1 = [[YBMKAddressItem alloc]init];
        item1.city = @"北京"; //城市名
        item1.key = keys[i];  //关键词
        [items addObject:item1];
    }

    
    [YBMKMapRoutePlan startBMRoutePlan:items success:^(BMKPolyline *line, NSArray *annotations) {
        for (RouteAnnotation* item in annotations) {
            [_mapView addAnnotation:item];
        }
        [_mapView addOverlay:line];
        [self mapViewFitPolyLine:line];
    }];
 ```
 新建三个点，按照顺序排列，在block里处理路径规划的结果
 
 
使用百度地图路径规划的时候，遇到两个问题，记录一下
---
1，没有路线的问题是 BMKMapViewDelegate 的两个代理方法没有实现

```c
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
```
2，图标不对，RouteAnnotation.m 中会制定起点、终点、途径点的图片，按照你自己的需求修改就好
```c
view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"start_node"];
                view.image = [UIImage imageNamed:@"icon_nav_start.png"];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
            }
```
