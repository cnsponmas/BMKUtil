//
//  RouteAnnotation.m
//  ZKPlatform
//
//  Created by developer on 17/1/7.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "RouteAnnotation.h"
#import "UIImage+Rotate.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@implementation RouteAnnotation
@synthesize type = _type;
@synthesize degree = _degree;


- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent:filename];
        return s;
    }
    return nil ;
}

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview
{
    BMKAnnotationView* view = nil;
    switch (_type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"start_node"];
                view.image = [UIImage imageNamed:@"icon_nav_start.png"];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
            }
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"end_node"];
                view.image = [UIImage imageNamed:@"icon_nav_end.png"];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
            }
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageNamed:@"icon_nav_bus.png"];
            }
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageNamed:@"icon_nav_rail.png"];
            }
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"route_node"];
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageNamed:@"icon_direction.png"];
            view.image = [image imageRotatedByDegrees:_degree];
        }
            break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"waypoint_node"];
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageNamed:@"icon_nav_waypoint.png"];
            view.image = [image imageRotatedByDegrees:_degree];
        }
            break;
            
        case 6:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"stairs_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"stairs_node"];
            }
            view.image = [UIImage imageNamed:@"icon_stairs.png"];
        }
            break;
        default:
            break;
    }
    if (view) {
        view.annotation = self;
        view.canShowCallout = YES;
    }
    return view;
}


@end
