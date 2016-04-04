//
//  MapViewController.m
//  MyLBS
//
//  Created by jyd on 16/4/2.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () <MKMapViewDelegate>

@property (nonatomic ,strong) MKMapView *mapView;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"线路导航"];
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
   
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        
        if ([_locationManager respondsToSelector: @selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    
    MKPointAnnotation *annotation =[[MKPointAnnotation alloc] init];
    annotation.coordinate = self.mapItem.placemark.location.coordinate;
    [annotation setTitle:self.mapItem.name];
    [self.mapView addAnnotation:annotation];
     [_mapView setRegion:[_mapView regionThatFits:_region] animated:YES];
    
    [self creatLineFromCurrentSite:[MKMapItem mapItemForCurrentLocation ] to:self.mapItem];
    
}

-(void) creatLineFromCurrentSite:(MKMapItem *)fromItem to:(MKMapItem *)toItem{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    [request setSource:fromItem];
    [request setDestination:toItem];
    [request setRequestsAlternateRoutes:YES];
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        if (error || response.routes.count == 0) {
            NSLog(@"%@",error);
        }else{
            for (MKRoute *route in response.routes) {
                [_mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
            }
        }
    }];
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        [renderer setLineWidth:1];
        [renderer setStrokeColor:[UIColor redColor]];
        return renderer;
    }else{
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
