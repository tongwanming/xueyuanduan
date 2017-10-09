//
//  SubjectPractiseTabPanelPopView.m
//  好梦学车
//
//  Created by haomeng on 2017/5/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectPractiseTabPanelPopView.h"
#import "SubjectPopTopView.h"
#import "SubjectPopViewCollectionViewCell.h"
#import "JHHeaderFlowLayout.h"

@interface SubjectPractiseTabPanelPopView ()<UICollectionViewDelegate,UICollectionViewDataSource,SubjectPopTopViewBtnDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SubjectPractiseTabPanelPopView{
    UILabel *_trueLabel;
    UILabel *_faultLabel;
    UILabel *_finshedLabel;
    UILabel *_totalLabel;
    NSMutableDictionary *_dict;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView{
    
    _dict = [[NSMutableDictionary alloc] init];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 53)];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    
   
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(16, 20, 35, 13)];
    label1.text = @"答对:";
    label1.textColor = TEXT_COLOR;
    label1.font = [UIFont systemFontOfSize:13];
//    label1.backgroundColor = [UIColor redColor];
    [topView addSubview:label1];
    
    _trueLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 20, 25, 14)];
    
    _trueLabel.textColor = BLUE_BACKGROUND_COLOR;
    _trueLabel.font = [UIFont systemFontOfSize:14];
    _trueLabel.textAlignment = NSTextAlignmentRight;
//    _trueLabel.backgroundColor = [UIColor blueColor];
    [topView addSubview:_trueLabel];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_trueLabel.frame)+25, 20, 35, 14)];
    label2.text = @"答错:";
    label2.textColor = TEXT_COLOR;
    label2.font = [UIFont systemFontOfSize:14];
//    label2.backgroundColor = [UIColor purpleColor];
    [topView addSubview:label2];
    
    _faultLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), 20, 25, 14)];
    
    _faultLabel.textColor = FF8400;
    _faultLabel.font = [UIFont systemFontOfSize:14];
    _faultLabel.textAlignment = NSTextAlignmentRight;
    [topView addSubview:_faultLabel];
    
    _totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-60, 20, 40, 14)];
    _totalLabel.textColor = ADB1B9;
    _totalLabel.font = [UIFont systemFontOfSize:14];
    _totalLabel.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:_totalLabel];
    
    _finshedLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-100, 20, 40, 14)];
    
    _finshedLabel.textColor = TEXT_COLOR;
    _finshedLabel.font = [UIFont systemFontOfSize:14];
    _finshedLabel.textAlignment = NSTextAlignmentRight;
    [topView addSubview:_finshedLabel];
    
    JHHeaderFlowLayout *layout = [[JHHeaderFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 53, CURRENT_BOUNDS.width, self.frame.size.height-53) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:_collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SubjectPopViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SubjectPopViewCollectionViewCell"];
    [self.collectionView registerClass:[SubjectPopTopView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SubjectPopTopView"];
    
}

- (void)setModel:(SubjectPractiseTabPanelPopViewModel *)model{
    _model = model;
    NSMutableArray *trueData = [[NSMutableArray alloc] init];
    for (NSString *str in _model.dic.allValues) {
        if ([str isEqualToString:@"YES"]) {
            [trueData addObject:str];
        }
    }
    _faultLabel.text = [NSString stringWithFormat:@"%ld",_model.dic.allValues.count - trueData.count];
    _finshedLabel.text = [NSString stringWithFormat:@"%ld",_model.dic.allKeys.count];
    _trueLabel.text = [NSString stringWithFormat:@"%ld",trueData.count];
    _totalLabel.text = [NSString stringWithFormat:@"/%@",_model.totalNum];
    [_collectionView reloadData];
}

#pragma mark - collectviewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 20;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_model.totalNum integerValue];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-44-5*31/2)/6;
    
    return CGSizeMake(width, width);
}
//header的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 38);
}

//每个item之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
//每个section中不同行的行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 12;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(6, 20, 6, 20);//分别为上、左、下、右
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SubjectPopViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SubjectPopViewCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row < [_model.totalNum integerValue]) {
//        NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row];
//        NSLog(@"获取到的值：%@---row:%ld",str,indexPath.row);
        cell.state = [_model.dic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }else{
        cell.state = @"";
    }
    cell.numLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(SubjectPractiseTabPanelPopViewDelegateWithCollection:)]) {
        [self.delegate performSelector:@selector(SubjectPractiseTabPanelPopViewDelegateWithCollection:) withObject:indexPath];
    }
    
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        SubjectPopTopView *headerView = [_dict objectForKey:@(indexPath.section)];
        
        
        if (!headerView) {
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SubjectPopTopView" forIndexPath:indexPath];
            headerView.titleNameStr = @"第一章：道路交通安全法律法规和政策";
            headerView.secntion = indexPath.section;
            headerView.delegate = self;
        }
        
        
        reusableview = headerView;
    }
    
    reusableview.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.98f alpha:1.00f];;
    
    return reusableview;
}

- (void)subjectPopTopViewBtnClickWithBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(topViewBtnClcikWithBtn:)]) {
        [self.delegate performSelector:@selector(topViewBtnClcikWithBtn:) withObject:btn];
    }
    NSLog(@"当前的行数：%ld",btn.tag);
}

@end
