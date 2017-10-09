//
//  FirstLocationTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstLocationTableViewCell.h"
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

#import "HorizontalFlowLayout.h"
#import "FirstLocationCollectionViewCell.h"
#import "FirstLocationModel.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件


@interface FirstLocationTableViewCell ()<BMKMapViewDelegate,BMKLocationServiceDelegate,UICollectionViewDelegate,UICollectionViewDataSource,BMKGeoCodeSearchDelegate>

@property (nonatomic, assign) NSInteger integer;

@property (nonatomic, strong) NSString *longitude;

@property (nonatomic, strong) NSString *latitude;

@property (nonatomic, strong) BMKGeoCodeSearch *geocodesearch;

@end

@implementation FirstLocationTableViewCell{
    BMKMapView *_mapView;
    BMKLocationService *_locServer;
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    if (_dataArray.count > 0) {
        return;
    }else
        _dataArray = dataArray;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.subView.layer.masksToBounds = YES;
    self.subView.layer.cornerRadius = 10;
    self.integer = 0;
    [self createMapView];
}
- (IBAction)locationActive:(id)sender {
    CLLocationCoordinate2D coord;
    coord.latitude = [_latitude floatValue];
    coord.longitude = [_longitude floatValue];
    [_mapView setCenterCoordinate:coord animated:true];
}

- (void)createMapView{
    
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _geocodesearch.delegate = self;
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, self.subView.frame.size.width,self.subView.frame.size.height)];
    _mapView.mapType = BMKMapTypeStandard;
    _mapView.delegate = self;
    //    [_mapView setTrafficEnabled:YES];
    [_mapView setZoomLevel:6.0];
    [self.subView addSubview:_mapView];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    _mapView.buildingsEnabled = YES;
    _mapView.overlookEnabled = YES;
    _mapView.showMapScaleBar = NO;
//    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
     
//    _mapView.overlooking = -45;
    
    
    
    _locServer = [[BMKLocationService alloc] init];
    _locServer.delegate = self;
    [_locServer startUserLocationService];
    
    HorizontalFlowLayout *layout = [[HorizontalFlowLayout alloc] init];
    
    CGRect rct = self.bounds;
    rct.size.height = 185;
    rct.origin.y = 280;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:rct collectionViewLayout:layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateNormal;
    
    [self.collectionView registerClass:[FirstLocationCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([FirstLocationCollectionViewCell class])];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
//    self.collectionView.backgroundColor = [UIColor redColor];
    [self addSubview:_collectionView];
//    _collectionView.hidden = YES;
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    NSLog(@"heading is %@",userLocation.heading);
}


- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    BMKCoordinateRegion region;
    region.center.latitude = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    _longitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    _latitude = [NSString stringWithFormat:@"%lf",userLocation.location.coordinate.latitude];
    
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
//    _currentLocation = coord;
    BMKPointAnnotation *_pointAnnotation = [[BMKPointAnnotation alloc] init];
    _pointAnnotation.coordinate = coord;
    
    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
    pt=(CLLocationCoordinate2D){coord.latitude,coord.longitude};
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView removeOverlays:_mapView.overlays];
        [_mapView setCenterCoordinate:coord animated:true];
        [_mapView addAnnotation:_pointAnnotation];
        
    });
    
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
    
    [self getDataActive];
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    _userLocationState = userLocation;
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSLog(@"%u",error
          );
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        NSLog(@"当前位置%@",result.address);
        if (self.provinceBlock) {
            self.provinceBlock(result.addressDetail.province);
        }
        
    }
}

- (void)retunLoadDataWithBlock:(locationBlock)block{
    _block = block;
}

- (void)retunLoadDataWithProvinceBlock:(locationBlockProvince)block{
    _provinceBlock = block;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locServer.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
   
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locServer.delegate = nil;
   
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FirstLocationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FirstLocationCollectionViewCell class]) forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == self.integer) {
        cell.choosed = YES;
    }else{
        cell.choosed = NO;
    }
    return cell;
}

- (CGSize)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(140, collectionView.bounds.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    self.integer = indexPath.row;
    [_collectionView reloadData];
    if ([self.delegate respondsToSelector:@selector(firstLocationTableViewCellSubCellSelectActive:andData:)]) {
        [self.delegate performSelector:@selector(firstLocationTableViewCellSubCellSelectActive:andData:) withObject:indexPath withObject:_dataArray];
    }
    //滚动到中间
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

//使前后项都能居中显示
- (UIEdgeInsets)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    NSInteger itemCount = [self collectionView:collectionView numberOfItemsInSection:section];
    
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    CGSize firstSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:firstIndexPath];
    
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:itemCount - 1 inSection:section];
    CGSize lastSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:lastIndexPath];
    
    return UIEdgeInsetsMake(0, 16,
                            0, (collectionView.bounds.size.width - lastSize.width) / 9);
}

- (void)getDataActive{
    NSDictionary *dic = @{@"longitude":_longitude,
                        @"latitude":_latitude,
                        @"displayNum":@10};
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
    
    NSRange range = {0,jsonStr.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\\"withString:@""options:NSLiteralSearch range:range3];
    NSData *jsonData = [mutStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //    NSURL *url = [NSURL URLWithString:urlstr];
    NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7072/manage-service/trainplace/listByCoords"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *str = [jsonDict objectForKey:@"success"];
            if ([str boolValue]) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSArray *_success = [jsonDict objectForKey:@"data"];
                    if (_dataArray.count > 1) {
                        [_dataArray removeAllObjects];
                    }
                    for (NSDictionary *dic in _success) {
                        FirstLocationModel *model = [[FirstLocationModel alloc] init];
                        model.currentId = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"id"]];
                        model.descrip = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"descrip"]];
                        
                        model.trainDrivingLicense = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"trainDrivingLicense"]];
                        model.contactPersonPhone = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"contactPersonPhone"]];
                        model.trainSubjects = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"trainSubjects"]];
                        model.contactPersonName = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"contactPersonName"]];
                        model.province = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"province"]];
                        model.longitude = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"longitude"]];
                        model.latitude =[NSString stringWithFormat:@"%@",[dic objectForSubKey:@"latitude"]];
                        model.pictures = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"pictures"]];
                        model.belongSchool =[NSString stringWithFormat:@"%@",[dic objectForSubKey:@"belongSchool"]];
                        model.address = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"descrip"]];
                        model.city = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"city"]];
                        model.addTime = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"addTime"]];
                        model.district = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"district"]];
                        model.distance = [NSString stringWithFormat:@"距你%.2lfkm",[[dic objectForKey:@"distance"] floatValue]];
                        model.name = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"name"]];
                        model.updateTime = [NSString stringWithFormat:@"%@",[dic objectForSubKey:@"updateTime"]];
                        [_dataArray addObject:model];
                    }
                    _collectionView.hidden = NO;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [_collectionView reloadData];
                    });
                    
                    if (_block) {
                        _block(_dataArray);
                    }
                });
                
                
                
            }else{
  
                
            }
        }
    }];
    [dataTask resume];
}





@end
