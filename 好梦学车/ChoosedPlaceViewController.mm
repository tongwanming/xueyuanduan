//
//  ChoosedPlaceViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/4/27.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ChoosedPlaceViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Radar/BMKRadarOption.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>

#import <BaiduMapAPI_Search/BMKRouteSearch.h>
#import <BaiduMapAPI_Search/BMKRouteSearchOption.h>
#import <BaiduMapAPI_Search/BMKRouteSearchType.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import "ApplyOrderViewController.h"
#import "FirstCatStyleModel.h"
#import "FirstLocationModel.h"
#import "DefaultManager.h"
#import "ChoosedClassModel.h"
#import "PersonIndentViewController.h"
#import "OrderValidityManager.h"
#import "PersonIndentViewControllerOther.h"
#import "ManuallyLocateViewController.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件


/** 路线的标注*/
@interface RouteAnnotation : BMKPointAnnotation

@property (nonatomic) int type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@end

@interface UIShowLocationTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *distanceLabel;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailTitleNameLabel;

@property (nonatomic, strong) UIImageView *checkedImage;



@end

@implementation UIShowLocationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(CGFloat)width{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 20, width-60, 13)];
        _distanceLabel.textColor = UNMAIN_TEXT_COLOR;
        _distanceLabel.font = [UIFont systemFontOfSize:13];
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, _distanceLabel.frame.origin.y+10+_distanceLabel.frame.size.height, width-60, 17)];
        _titleNameLabel.textColor = TEXT_COLOR;
        _titleNameLabel.font = [UIFont systemFontOfSize:17];
        _titleNameLabel.textAlignment = NSTextAlignmentLeft;
        
        _detailTitleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, _titleNameLabel.frame.origin.y+_titleNameLabel.frame.size.height + 11, width-60, 13)];
        _detailTitleNameLabel.textColor = UNMAIN_TEXT_COLOR;
        _detailTitleNameLabel.font = [UIFont systemFontOfSize:13];
        _detailTitleNameLabel.textAlignment = NSTextAlignmentLeft;
        
        _checkedImage = [[UIImageView alloc] initWithFrame:CGRectMake(width-25-16, 37, 20, 20)];
        _checkedImage.contentMode = UIViewContentModeScaleAspectFit;
        _checkedImage.backgroundColor = [UIColor clearColor];
        
//        _distanceLabel.backgroundColor = [UIColor redColor];
        [self addSubview:_distanceLabel];
        [self addSubview:_checkedImage];
        [self addSubview:_titleNameLabel];
        [self addSubview:_detailTitleNameLabel];
    }
    return self;
}

@end

@interface ChoosedPlaceViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKRouteSearchDelegate,UITableViewDelegate,UITableViewDataSource,BMKGeoCodeSearchDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) FirstCatStyleModel *model;
@property (nonatomic, strong) BMKGeoCodeSearch *geocodesearch;
@property (nonatomic, strong)NSArray *oldData;//存放最初自己定位周围的场地信息


@end

@implementation ChoosedPlaceViewController{
    BMKMapView *_mapView;
    BMKLocationService *_locServer;
    CLLocationCoordinate2D _currentLocation;
    BMKUserLocation *_userLocationState;
    NSInteger _choosedIndex;
    BMKRouteSearch *_routSearch;
    UIView *_topView;
    UILabel *_locationLabel;
    UIButton *_refreshLocationBtn;
}
- (IBAction)btnClick:(id)sender {
    if (_isByPersonVC) {
        if ([[[OrderValidityManager defaultManager] getCurrentOrderStyle] isEqualToString:@"订单已完成"]) {
            //已经完成订单支付
            PersonIndentViewControllerOther*v = [[PersonIndentViewControllerOther alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }else{
            BOOL isCreateOrder = [[OrderValidityManager defaultManager] orderValidity];
            if (isCreateOrder) {
                PersonIndentViewController *v = [[PersonIndentViewController alloc] init];
                [self.navigationController pushViewController:v animated:YES];
            }else{
                ApplyOrderViewController *v = [[ApplyOrderViewController alloc] init];
                
                FirstCatStyleModel *model = [[FirstCatStyleModel alloc] init];
                ChoosedClassModel *choosedModel = [DefaultManager shareDefaultManager].carStyleData[1];
                model.type = choosedModel.titleStr;
                model.price = choosedModel.C1Str;
                model.price2 = choosedModel.C2Str;
                model.backGroundImageName = choosedModel.imageStr;
                model.isInstalments = choosedModel.isInstalmentsC1;
                model.backGroundImageName = choosedModel.imageStr;
                model.categoryCode = choosedModel.categoryCode;
                model.projectTypeCode = choosedModel.projectTypeCode;
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                [dic setObject:((FirstLocationModel *)_allExerciseLocationData[_choosedIndex]).name forKey:@"myPlace"];
                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
                v.location = ((FirstLocationModel *)_allExerciseLocationData[_choosedIndex]).name;
                
                v.model = model;
                [self.navigationController pushViewController:v animated:YES];
            }
        }
    }else{
        if (_choosedExerciseBlock) {
            _choosedExerciseBlock(_allExerciseLocationData[_choosedIndex]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightItemAcrive{
    ManuallyLocateViewController *v = [[ManuallyLocateViewController alloc] init];
    
    __weak typeof(&*self)weakSelf=self;
    [v returnChoosedLoactionWithBlock:^(NSString *address, CLLocationCoordinate2D pt,NSArray *data) {
       
        NSLog(@"地址：--%@",address);
        _currentLocation = pt;
        weakSelf.allExerciseLocationData = data;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _choosedIndex = 0;
            [weakSelf.tableView reloadData];
            _locationLabel.text = [NSString stringWithFormat:@"我的位置：%@",address];
            [weakSelf searchRouteWithFirstLocationModel:data[0]];
        });
        
    }];
    [self presentViewController:v animated:YES completion:^{
        
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预选场地";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAcrive)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    

    _oldData = [NSArray arrayWithArray:self.allExerciseLocationData];
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _geocodesearch.delegate = self;
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height-300))];
    _mapView.mapType = BMKMapTypeStandard;
    _mapView.delegate = self;
    //    [_mapView setTrafficEnabled:YES];
    [_mapView setZoomLevel:6.0];
    [self.view addSubview:_mapView];
    _mapView.showsUserLocation = YES;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
//    _mapView.buildingsEnabled = YES;
    _mapView.minZoomLevel = 1;
    _mapView.overlookEnabled = YES;
    _mapView.showMapScaleBar = YES;
//    _mapView.overlooking = -45;
    
    
    _choosedIndex = 0;
    _locServer = [[BMKLocationService alloc] init];
    _locServer.delegate = self;
    [_locServer startUserLocationService];
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CURRENT_BOUNDS.width, 40)];
    _topView.backgroundColor = CFEDFF;
    [self.view addSubview:_topView];
    
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, CURRENT_BOUNDS.width-80-16, 40)];
    _locationLabel.textColor = BLUE_BACKGROUND_COLOR;
    _locationLabel.font = [UIFont systemFontOfSize:13];
    [_topView addSubview:_locationLabel];
    
    _refreshLocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _refreshLocationBtn.frame = CGRectMake(CURRENT_BOUNDS.width-50, 0, 50, 40);
    [_refreshLocationBtn setImage:[UIImage imageNamed:@"btn_refresh"] forState:UIControlStateNormal];
    [_refreshLocationBtn addTarget:self action:@selector(refreshLocationActive:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_refreshLocationBtn];
    
    
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-300, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_mapView.frame.size.height-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.layer.masksToBounds = YES;
    [self.view addSubview:_tableView];
    _choosedIndex = 0;

   
    // Do any additional setup after loading the view from its nib.
}

- (void)refreshLocationActive:(UIButton *)btn{
    self.allExerciseLocationData = _oldData;
    _choosedIndex = 0;
    [self.tableView reloadData];
    [_locServer startUserLocationService];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allExerciseLocationData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"indexPath";
    UIShowLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[UIShowLocationTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index andWidth:[UIScreen mainScreen].bounds.size.width];
    }
    
    cell.distanceLabel.text = ((FirstLocationModel *)_allExerciseLocationData[indexPath.row]).distance;
    cell.titleNameLabel.text = ((FirstLocationModel *)_allExerciseLocationData[indexPath.row]).name;
    cell.detailTitleNameLabel.text = ((FirstLocationModel *)_allExerciseLocationData[indexPath.row]).address;
    if (indexPath.row == _choosedIndex) {
        cell.checkedImage.image = [UIImage imageNamed:@"btn_box_click"];
    }else{
        cell.checkedImage.image = [UIImage imageNamed:@"btn_box_normal"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _choosedIndex = indexPath.row;
    [_tableView reloadData];
    [self searchRouteWithFirstLocationModel:_allExerciseLocationData[indexPath.row]];
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    NSLog(@"heading is %@",userLocation.heading);
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    BMKCoordinateRegion region;
    region.center.latitude = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0.2;
    region.span.longitudeDelta = 0.2;
    if (_mapView)
    {
        _mapView.region = region;
        
    }
    
    [_mapView setZoomLevel:17.0];
    
    [_locServer stopUserLocationService];//定位完成停止位置更新
    
    //添加当前位置的标注 //展示定位
    _mapView.showsUserLocation = YES;
    
    //更新位置数据
    [_mapView updateLocationData:userLocation];
    CLLocationCoordinate2D coord;
    coord.latitude = userLocation.location.coordinate.latitude;
    coord.longitude = userLocation.location.coordinate.longitude;
    _currentLocation = coord;
    BMKPointAnnotation *_pointAnnotation = [[BMKPointAnnotation alloc] init];
    _pointAnnotation.coordinate = coord;
    
    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
    pt=(CLLocationCoordinate2D){coord.latitude,coord.longitude};
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView removeOverlays:_mapView.overlays];
        [_mapView setCenterCoordinate:coord animated:true];
        [_mapView addAnnotation:_pointAnnotation];
        
    });
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _userLocationState = userLocation;
     [self searchRouteWithFirstLocationModel:_allExerciseLocationData[0]];
    
    CLLocationCoordinate2D pta = (CLLocationCoordinate2D){0, 0};//初始化
    if (userLocation.location.coordinate.longitude!= 0
        && userLocation.location.coordinate.latitude!= 0) {
        //如果还没有给pt赋值,那就将当前的经纬度赋值给pt
        pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude,
            userLocation.location.coordinate.longitude};
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];//初始化反编码请求
    reverseGeocodeSearchOption.reverseGeoPoint = pt;//设置反编码的店为pt
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功

    
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSLog(@"%u",error
          );
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        NSLog(@"当前位置%@",result.address);
        dispatch_async(dispatch_get_main_queue(), ^{
            _locationLabel.text = [NSString stringWithFormat:@"我的位置：%@",result.address];
        });
        
    }
}

- (void)returnHasChooedExercisePlaceBlock:(choosedPlaceBlock)block{
    _choosedExerciseBlock = block;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locServer.delegate = self;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locServer.delegate = nil;
    if (_choosedExerciseBlock) {
        _choosedExerciseBlock(_allExerciseLocationData[_choosedIndex]);
    }
    [self.navigationController setNavigationBarHidden:YES animated:NO];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (void)searchRouteWithFirstLocationModel:(FirstLocationModel *)model{
    //初始化检索对象
    if (!_routSearch) {
        _routSearch = [[BMKRouteSearch alloc]init];
        _routSearch.delegate = self;
    }
    //发起检索
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    //    start.name = @"龙头寺";
    start.pt = (CLLocationCoordinate2D){_currentLocation.latitude,_currentLocation.longitude};
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    //    end.name = _textStr;106.570132,29.680962
    end.pt = CLLocationCoordinate2D{[model.latitude doubleValue],[model.longitude doubleValue]};
    BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
    transitRouteSearchOption.city= @"重庆市";
    transitRouteSearchOption.from = start;
    transitRouteSearchOption.to = end;
    BOOL flag = [_routSearch transitSearch:transitRouteSearchOption];
    
    if(flag)
    {
        NSLog(@"bus检索发送成功");
    }
    else
    {
        NSLog(@"bus检索发送失败");
    }
}

//实现Deleage处理回调结果
-(void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result
                     errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        BMKTransitRouteLine* plan = (BMKTransitRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        int size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.instruction;
            item.type = 3;
            [_mapView addAnnotation:item];
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        //当路线起终点有歧义时通，获取建议检索起终点
        //result.routeAddrResult
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark 根据overlay生成对应的View
-(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [BLUE_BACKGROUND_COLOR colorWithAlphaComponent:1];
        polylineView.lineWidth = 2.0;
        return polylineView;
    }
    return nil;
}

#pragma mark  根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    
    if (polyLine.pointCount < 1) return;
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    
    for (int i = 0; i < polyLine.pointCount; i++) {
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

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    
    //如果是注释点
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        //根据注释点,创建并初始化注释点视图
        BMKPinAnnotationView  *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"an"];
        
        //设置大头针的颜色
        newAnnotation.pinColor = BMKPinAnnotationColorGreen;
        
        //设置动画
        newAnnotation.animatesDrop = YES;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        label.text = @"起点";
        label.textColor = TEXT_COLOR;
        label.font = [UIFont systemFontOfSize:16];
        NSLog(@"%@---titlr:%@",annotation,annotation.title);
        //设置图片
        
//        newAnnotation.image = [UIImage imageNamed:@"icon_position1"];
        
        newAnnotation.canShowCallout = YES;
        
        newAnnotation.frame = CGRectMake(0, 0, 30, 30);
        if (annotation.title && [annotation.title isEqualToString:@"起点"]) {
            newAnnotation.selected = YES;
        }else{
            newAnnotation.selected = NO;
        }
        
        return newAnnotation;
        
    }
    
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
