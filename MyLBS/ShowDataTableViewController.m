//
//  ShowDataTableViewController.m
//  MyLBS
//
//  Created by jyd on 16/4/2.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "ShowDataTableViewController.h"
#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "MBProgressHUD.H"
@interface ShowDataTableViewController ()

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, strong)MKLocalSearch *localSearch;

@property (nonatomic, assign) MKCoordinateRegion  currentRegion;

@end
static NSString * tableViewKey = @"Key";
@implementation ShowDataTableViewController


-(instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
           _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"地点选择"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewKey];
        //[_dataArray addObject:@{@"siteName":@"地点一"}];
    if (_localSearch != nil) {
        _localSearch = nil;
    }
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(39.930871, 116.500855), 2000, 2000);
    _currentRegion = region;
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    
    request.naturalLanguageQuery = self.searchString;
    request.region = region;
    _localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    [_localSearch startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
        if (response.mapItems.count == 0 || error) {
            NSLog(@"");
        }else{
            [_dataArray addObjectsFromArray:response.mapItems];
            if (_dataArray.count == 0) {
                self.tableView.bounces = NO;
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            }else{
                self.tableView.bounces = YES;
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                [self.tableView reloadData];
            }
            
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.dataArray count];;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewKey forIndexPath:indexPath];
    
    MKMapItem *item = _dataArray[indexPath.row];
    [cell.textLabel setText:item.name];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MapViewController *map = [[MapViewController alloc] init];
    map.mapItem = _dataArray[indexPath.row];
    map.region = _currentRegion;
    [self.navigationController pushViewController:map animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
