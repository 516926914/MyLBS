//
//  MapViewController.h
//  MyLBS
//
//  Created by jyd on 16/4/2.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController

@property (nonatomic, strong) MKMapItem * mapItem;
@property (nonatomic, assign) MKCoordinateRegion region;
@end
