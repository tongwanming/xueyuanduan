//
//  SubjectThreeViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/11.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectThreeViewController.h"
#import "SubjectTwoTopView.h"
#import "SubjectTwoCollectionViewCell.h"
#import "SubjectTwoModel.h"

@interface SubjectThreeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SubjectTwoTopViewDelegate>

@property (nonatomic, strong) UICollectionView *collectView;

@end

@implementation SubjectThreeViewController{
    NSMutableArray *_arrData;
}

- (NSMutableArray *)getData{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSArray *imgaeData = @[@"2.1",@"2.2",@"2.3",@"2.4",@"2.5",@"2.6",@"2.7",@"2.8",@"2.9",@"2.10",@"2.11",@"2.12"];
    NSArray *titleData = @[@"夜间灯光使用",@"上车准备",@"起步",@"直线行驶",@"变更车道",@"加减档操作",@"掉头",@"超车",@"靠边停车",@"通过人行横道",@"通过学校区域",@"通过公交车站"];
    NSArray *timeData = @[@"01:36",@"01:38",@"01:15",@"01:10",@"01:22",@"0:41",@"01:12",@"01:10",@"01:40",@"0:45",@"0:25",@"0:25"];
    NSArray *describeData = @[@"小车通过“直角”路段转弯过程",@"小车通过“直角”路段转弯过程",@"整个考场为一个“凸”字形",@"一进一退方式将车停入库区",@"上破前，是汽车靠向道理右侧",@"一进一退方式将车停入库区",@"上破前，是汽车靠向道理右侧",@"小车通过“直角”路段转弯过程",@"小车通过“直角”路段转弯过程",@"整个考场为一个“凸”字形",@"一进一退方式将车停入库区",@"上破前，是汽车靠向道理右侧"];
    for (int i = 0; i < imgaeData.count; i++) {
        SubjectTwoModel *model = [[SubjectTwoModel alloc] init];
        model.imageName = imgaeData[i];
        model.timeStr = timeData[i];
        model.firstStr = titleData[i];
        model.secondStr = describeData[i];
        [arr addObject:model];
    }
    return arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrData = [self getData];
//    self.view.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor colorWithRed:0.94f green:0.95f blue:0.96f alpha:1.00f];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, [UIScreen mainScreen].bounds.size.height - 106) collectionViewLayout:layout];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.showsVerticalScrollIndicator = NO;
    _collectView.showsHorizontalScrollIndicator = NO;
    _collectView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectView];
    [self.collectView registerNib:[UINib nibWithNibName:@"SubjectTwoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SubjectTwoCollectionViewCell"];
    [self.collectView registerClass:[SubjectTwoTopView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SubjectTwoTopView"];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - collectviewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-42)/2;
    
    return CGSizeMake(width, width);
}
//header的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 145);
}

//每个item之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//每个section中不同行的行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 16, 10, 16);//分别为上、左、下、右
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SubjectTwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SubjectTwoCollectionViewCell" forIndexPath:indexPath];
    SubjectTwoModel *model = _arrData[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:model.imageName];
    cell.titleLabel.text = model.firstStr;
    cell.describeLabel.text = model.secondStr;
    cell.timeLabel.text = model.timeStr;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(SubjectThreeViewControllerDelegateTapWithIndex:)]) {
        [self.delegate performSelector:@selector(SubjectThreeViewControllerDelegateTapWithIndex:) withObject:[NSString stringWithFormat:@"%@",@(indexPath.row)]];
    }
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        SubjectTwoTopView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SubjectTwoTopView" forIndexPath:indexPath];
        headerView.delegate = self;
        
        
        reusableview = headerView;
    }
    
    reusableview.backgroundColor = [UIColor redColor];
    
    return reusableview;
}

#pragma SubjectTwoTopViewDelegate
- (void)subjectTwoTopViewBtnClickWithBtn:(id)sender{
    NSLog(@"点击按钮：%ld",(long)((UIButton *)sender).tag);
    
    if ([self.delegate respondsToSelector:@selector(SubjectThreeViewControllerDelegateTapWithIndex:)]) {
        [self.delegate performSelector:@selector(SubjectThreeViewControllerDelegateTapWithIndex:) withObject:[NSString stringWithFormat:@"%@",@(((UIButton *)sender).tag)]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
