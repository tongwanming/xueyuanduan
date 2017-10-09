//
//  SubjectOneViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/11.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneViewController.h"
#import "SubjectOneCollectionViewCell.h"
#import "SubjectOneTopView.h"
#import "SubjectOneMode.h"
#import "SqliteDateManager.h"


@interface SubjectOneViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SubjectOneTopViewDelegate>

@property (nonatomic, strong) UICollectionView *collectView;

@end

@implementation SubjectOneViewController{
    NSMutableArray *_data;
    
}

- (NSMutableArray *)getData{
    NSString *str = [self getMyMistake];
    NSString *str2 = [self getCollection];
    NSArray *imageData = @[@"icon_fault",@"icon_save",@"icon_cheats",@"icon_traffic-sign",@"icon_sebject"];
    NSArray *name1Data = @[@"我的错题",@"我的收藏",@"必过秘籍",@"交通标识",@"科目考规"];
    NSArray *name2Data = @[str,str2,@"好梦学车独家打造",@"交通标识轻松识别",@"科一到科四考规大全"];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < imageData.count; i ++) {
        SubjectOneMode *model = [[SubjectOneMode alloc] init];
        model.imageName = imageData[i];
        model.firstStr = name1Data[i];
        model.secondStr = name2Data[i];
        [arr addObject:model];
    }
    
    
    return arr;
}

- (NSString *)getMyMistake{
    NSString *str;
   NSArray *arr = [[SqliteDateManager sharedManager] getAllDataWithType:@"myMistake"];
    str = [NSString stringWithFormat:@"做错%lu道题",(unsigned long)arr.count];
    
    return str;
}

- (NSString *)getCollection{
    NSString *str;
    NSArray *arr = [[SqliteDateManager sharedManager] getAllDataWithType:@"collection"];
    str = [NSString stringWithFormat:@"收藏%lu道题",(unsigned long)arr.count];
    
    return str;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    _data = [self getData];
    [_collectView reloadData];
    NSLog(@"刷新需要用到的！");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
 
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,CURRENT_BOUNDS.width, [UIScreen mainScreen].bounds.size.height - 104) collectionViewLayout:layout];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.showsVerticalScrollIndicator = NO;
    _collectView.showsHorizontalScrollIndicator = NO;
    _collectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectView];
    [self.collectView registerNib:[UINib nibWithNibName:@"SubjectOneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SubjectOneCollectionViewCell"];
    [self.collectView registerClass:[SubjectOneTopView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SubjectOneTopView"];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - collectviewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width)/2;
    
    return CGSizeMake(width, 100);
}
//header的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 318);
}

//每个item之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//每个section中不同行的行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SubjectOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SubjectOneCollectionViewCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    SubjectOneMode *model = _data[indexPath.row];
    if (indexPath.row%2 > 0) {
        cell.lineView.hidden = YES;
    }else{
        cell.lineView.hidden = NO;
    }
    cell.firstLabel.text = model.firstStr;
    cell.secondLabel.text = model.secondStr;
    cell.logoImageView.image = [UIImage imageNamed:model.imageName];
//    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(subjectOneViewControllerTapWithIndex:)]) {
        [self.delegate performSelector:@selector(subjectOneViewControllerTapWithIndex:) withObject:@(indexPath.row)];
    }
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        SubjectOneTopView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SubjectOneTopView" forIndexPath:indexPath];
        headerView.delegate = self;
        headerView.type = @"1";
        
        reusableview = headerView;
    }
    
    reusableview.backgroundColor = [UIColor redColor];
    
    return reusableview;
}

#pragma mark - SubjectOneTopViewDelegate
- (void)subjectOneTopViewBtnClickWithBtn:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
//    NSLog(@"btn.tag--:%ld",(long)btn.tag);
    if ([self.delegate respondsToSelector:@selector(subjectOneViewControllerTapWithIndex:)]) {
        [self.delegate performSelector:@selector(subjectOneViewControllerTapWithIndex:) withObject:@(btn.tag)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
