//
//  SubjectOneTrafficSignViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneTrafficSignViewController.h"
#import "SubjectRegularCollectionViewCell.h"
#import "JHHeaderFlowLayout.h"
#import "SubjectRegularReusableView.h"
#import "SubjectOneDetailTrafficSignViewController.h"

@interface SubjectOneTrafficSignViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) NSArray *titleData;

@property (nonatomic, strong) NSMutableArray *titleSubData;

@property (nonatomic, strong) NSMutableArray *idData;

@end

@implementation SubjectOneTrafficSignViewController
{
    NSMutableDictionary *_dict;
}

- (NSArray *)titleData{
    if (!_titleData) {
        _titleData = @[@"道路交通标志",@"道路交通标线",@"交警手势图解",@"其他标志标示"];
    }
    return _titleData;
}

- (NSMutableArray *)data{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
        NSArray *arr1 = @[@"m1",@"m2",@"m3",@"m4",@"m5",@"m6",@"m7"];
        NSArray *arr2 = @[@"m8",@"m9",@"m10",@"m11"];
        NSArray *arr3 = @[@"m12",@"m13",@"m14",@"m15",@"m16",@"m17",@"m18",@"m19"];
        NSArray *arr4 = @[@"m20",@"m21",@"m22"];
        [_data addObject:arr1];
        [_data addObject:arr2];
        [_data addObject:arr3];
        [_data addObject:arr4];
    }
    return _data;
}

- (NSMutableArray *)idData{
    if (!_idData) {
        _idData = [[NSMutableArray alloc] init];
        NSArray *arr1 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
        NSArray *arr2 = @[@"8",@"9",@"10",@"11"];
        NSArray *arr3 = @[@"15",@"15",@"15",@"15",@"15",@"15",@"15",@"15"];
        NSArray *arr4 = @[@"12",@"13",@"15"];
        [_idData addObject:arr1];
        [_idData addObject:arr2];
        [_idData addObject:arr3];
        [_idData addObject:arr4];
    }
    return _idData;
}

- (NSMutableArray *)titleSubData{
    if (!_titleSubData) {
        _titleSubData = [[NSMutableArray alloc] init];
        NSArray *arr1 = @[@"禁令标志",@"警告标志",@"指示标志",@"指路标志",@"旅游区标志",@"道路施工标志",@"辅助标志"];
        NSArray *arr2 = @[@"禁止标线",@"警告标线",@"指示标线",@"道路施工安全设施设置示例"];
        NSArray *arr3 = @[@"停止信号",@"直行信号",@"左转信号",@"左转弯待转信号",@"右转弯信号",@"变道信号",@"减速慢行信号",@"车辆靠边停车信号"];
        NSArray *arr4 = @[@"汽车仪表指示灯",@"车内功能按键",@"交通事故责任认定"];
        [_titleSubData addObject:arr1];
        [_titleSubData addObject:arr2];
        [_titleSubData addObject:arr3];
        [_titleSubData addObject:arr4];
    }
    
    return _titleSubData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.98f alpha:1.00f];
     _dict = [[NSMutableDictionary alloc] init];
    
    JHHeaderFlowLayout *layout = [[JHHeaderFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, CURRENT_BOUNDS.width, CURRENT_BOUNDS.height-64) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SubjectRegularCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SubjectRegularCollectionViewCell"];
    [self.collectionView registerClass:[SubjectRegularReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SubjectRegularReusableView"];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - collectviewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.titleData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return ((NSArray *)(self.data[section])).count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-32-16)/3;
    
    return CGSizeMake(width, width*1.12);
}
//header的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 58);
}

//每个item之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}
//每个section中不同行的行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 16, 8, 16);//分别为上、左、下、右
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SubjectRegularCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SubjectRegularCollectionViewCell" forIndexPath:indexPath];
   
//    cell.t.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    cell.imageStr = self.data[indexPath.section][indexPath.row];
    cell.titleStr = self.titleSubData[indexPath.section][indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        SubjectRegularReusableView *headerView = [_dict objectForKey:@(indexPath.section)];
        
        
        if (!headerView) {
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SubjectRegularReusableView" forIndexPath:indexPath];
            headerView.titleStr = self.titleData[indexPath.section];
        }
        
        
        reusableview = headerView;
    }
    
    reusableview.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.98f alpha:1.00f];;
    
    return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return;
    }
    SubjectOneDetailTrafficSignViewController *v = [[SubjectOneDetailTrafficSignViewController alloc] init];
    v.titleStr = _titleData[indexPath.section];
    v.tralicType = [NSNumber numberWithInt:[self.idData[indexPath.section][indexPath.row] intValue]];
    [self.navigationController pushViewController:v animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnclick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
