//
//  ViewController.m
//  MyLBS
//
//  Created by jyd on 16/4/2.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ShowDataTableViewController.h"

typedef enum : NSUInteger {
    LBS_GAME = 0,
    LBS_EAT,
    LBS_REST,
    LBS_BUSSION,
    LBS_OTHER,
    LBS_OTHER1,
    LBS_OTHER2,
    LBS_OTHER3,
    LBS_OTHER4,
} EBtnTag;

@interface ViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self creatSearchBar];
    [self creatBtn];
}

-(void)creatSearchBar{
    _searchBar = [[UISearchBar alloc] init];
    [_searchBar setDelegate:self];
    [_searchBar setPlaceholder:@"请输入你要查询的内容"];
    [_searchBar setBackgroundImage:[self creatImageFromColor:[UIColor orangeColor] frame:CGRectMake(0, 0, self.view.frame.size.width, 50)]];
    [_searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_searchBar];
    
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        
    }];
    
}

-(void)creatBtn{
    NSInteger dataArr[] = {LBS_GAME,LBS_EAT,LBS_REST,LBS_OTHER,LBS_OTHER1,LBS_OTHER2,LBS_OTHER3,LBS_OTHER4};
    CGFloat btnWith = 80;
    CGFloat spacing = (self.view.frame.size.width - 3 * btnWith) / 4;
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = dataArr[i];
        [btn setTranslatesAutoresizingMaskIntoConstraints:NO];
        btn.backgroundColor = [UIColor orangeColor];
        [btn addTarget:self action:@selector(didTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_searchBar.mas_bottom).with.offset(10+i/3* (btnWith +spacing) +spacing);
            make.left.equalTo(self.view.mas_left).with.offset(i%3* (btnWith +spacing) +spacing);
            make.size.mas_equalTo(CGSizeMake(80, 80));
            
        }];
       
        

    }
}

-(void)didTouch:(UIButton *)sender{
    NSString *seletString = nil;
    switch (sender.tag) {
        case LBS_GAME:
        {
             seletString = @"游戏";
        }
           
            break;
        case LBS_EAT:
        {
              seletString = @"吃喝";
        }
          
            break;
        case LBS_REST:
        {
            seletString = @"休息";
        }
            break;
        case LBS_BUSSION:
        {
            seletString = @"逛街";
        }
            break;
        default:
        {
            seletString = @"游戏";
        }

            break;
    }
    [self showDataViewControllerWithString:seletString];
}

-(void)showDataViewControllerWithString:(NSString *)str{
    ShowDataTableViewController * showData = [[ShowDataTableViewController alloc] initWithStyle:UITableViewStylePlain];
    showData.searchString = str;
    [self.navigationController pushViewController:showData animated:YES];

}
#pragma mark - touch

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_searchBar resignFirstResponder];
}

#pragma mark - SearchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
    NSString *newString = [_searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (newString.length == 0) {
        return;
    }
    [self showDataViewControllerWithString:newString];
}

#pragma mark - CreatImage

-(UIImage *)creatImageFromColor:(UIColor *)color frame:(CGRect)frame{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
