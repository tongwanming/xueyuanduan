//
//  SubjectOneDetailTrafficSignViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneDetailTrafficSignViewController.h"
#import "SubjectDetailRegularCollectionViewCell.h"
#import "JHHeaderFlowLayout.h"
#import "CustomAlertView.h"
#import "SubjectTrallicPicModel.h"

@interface SubjectOneDetailTrafficSignViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation SubjectOneDetailTrafficSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.98f alpha:1.00f];
    
    JHHeaderFlowLayout *layout = [[JHHeaderFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, CURRENT_BOUNDS.width, CURRENT_BOUNDS.height-64) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
//    _collectionView.showsVerticalScrollIndicator = NO;
//    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.hidden = YES;
    _titileLabel.text = _titleStr;
    [self.view addSubview:_collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SubjectDetailRegularCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SubjectDetailRegularCollectionViewCell"];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titileLabel.text = titleStr;
}

- (void)getData{
    
    [CustomAlertView showAlertViewWithVC:self];
    NSDictionary *dic =@{@"signType":_tralicType};
    
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
    NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7072/order-service/api/common/trafficSign/query"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"];
    [request setValue:token forHTTPHeaderField:@"HMAuthorization"];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = [jsonDict objectForKey:@"data"];
            
            for (NSDictionary *dic in arr) {
                SubjectTrallicPicModel *model = [[SubjectTrallicPicModel alloc] init];
                model.currentId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
                model.picTitle = [dic objectForKey:@"picTitle"];
                model.signDesc = [dic objectForKey:@"signDesc"];
                model.signType = [NSString stringWithFormat:@"%@",[dic objectForKey:@"signType"]];
                model.signTypeName = [dic objectForKey:@"signTypeName"];
                model.title = [dic objectForKey:@"title"];
                [_data addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
                _collectionView.hidden = NO;
                [_collectionView reloadData];
               
            });
            
        }else{
            
            [CustomAlertView hideAlertView];
            
            //验证码输入错误
            UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"获取数据失败！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [v addAction:active];
            [self presentViewController:v animated:YES completion:^{
                
            }];
        }
    }];
    [dataTask resume];

}

#pragma mark - collectviewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.imageData.count;
    return _data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-30)/2;
    
    return CGSizeMake(width, width);
}


//每个item之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//每个section中不同行的行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 5, 10);//分别为上、左、下、右
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SubjectDetailRegularCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SubjectDetailRegularCollectionViewCell" forIndexPath:indexPath];
    
    SubjectTrallicPicModel *model = _data[indexPath.row];
    cell.imageStr = model.picTitle;
    //    cell.t.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
//    cell.imageStr = self.imageData[indexPath.section][indexPath.row];
//    cell.titleStr = self.titleData[indexPath.section][indexPath.row];
//    cell.imageStr = @"";
    cell.titleStr = model.title;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(id)sender {
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
