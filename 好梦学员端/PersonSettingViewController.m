//
//  PersonSettingViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/31.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "PersonSettingViewController.h"
#import "ChangedNameViewController.h"
#import "SettingPictureViewController.h"
#import "SettingCameraViewController.h"
#import "ChooicePictureViewController.h"
#import "UIImageView+WebCache.h"
#import "ResetPasswordViewController.h"
#import "ChoicePlaceViewController.h"
#import "CustomAlertView.h"
#import "QNUploadManager.h"
#import "QNUploadOption.h"
#import "QNConfiguration.h"
#import "UIImage+imageOrientation.h"
//#import "QNZone.h"

@interface PersonSettingViewCell : UITableViewCell

@property (nonatomic, strong) NSString *logoImageStr;

@property (nonatomic, strong) NSString *firstStr;

@property (nonatomic, strong) NSString *secondStr;

@property (nonatomic, strong) UIImage *imagel;

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) NSString *imageUrl;
@end

@interface PersonSettingViewCell()

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *secondTitleLabel;

@end

@implementation PersonSettingViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, self.bounds.size.height/2-8, CURRENT_BOUNDS.width/2-20, 16)];
        _titleNameLabel.textColor = TEXT_COLOR;
        _titleNameLabel.font = [UIFont systemFontOfSize:16];
        _titleNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleNameLabel];
        
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-50-16-11-10, 16, 50, 50)];
        _logoImageView.layer.masksToBounds = YES;
        _logoImageView.layer.cornerRadius = 25;
        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _logoImageView.hidden = YES;
        [self.contentView addSubview:_logoImageView];
        
        _secondTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-150-16-11-10, 22, 150, 16)];
        _secondTitleLabel.textColor = ADB1B9;
        _secondTitleLabel.font = [UIFont systemFontOfSize:16];
        _secondTitleLabel.textAlignment = NSTextAlignmentRight;
        _secondTitleLabel.hidden = YES;
        [self.contentView addSubview:_secondTitleLabel];
        
    }
    
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    self.logoImageView.hidden = NO;
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"bg_personal_defaultavatar"]];
}

- (void)setImagel:(UIImage *)imagel{
    _imagel = imagel;
    _logoImageView.image = _imagel;
    _logoImageView.hidden = NO;
    _secondTitleLabel.hidden = YES;
}

- (void)setFirstStr:(NSString *)firstStr{
    _firstStr = firstStr;
    _titleNameLabel.text = firstStr;
    if ([firstStr isEqualToString:@"头像"]) {
        _titleNameLabel.frame = CGRectMake(22, 33, CURRENT_BOUNDS.width/2-20, 16);
    }else{
       _titleNameLabel.frame = CGRectMake(22, 22, CURRENT_BOUNDS.width/2-20, 16);
    }
}

- (void)setSecondStr:(NSString *)secondStr{
    _secondStr = secondStr;
    _secondTitleLabel.text = _secondStr;
    _secondTitleLabel.hidden = NO;
    _logoImageView.hidden = YES;
}

- (void)setLogoImageStr:(NSString *)logoImageStr{
    _logoImageStr = logoImageStr;
    _logoImageView.image = [UIImage imageNamed:_logoImageStr];
    _logoImageView.hidden = NO;
    _secondTitleLabel.hidden = YES;
}
@end

@interface PersonSettingViewController ()<UITableViewDelegate,UITableViewDataSource,SettingCameraViewControllerDelegate,ChooicePictureViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSString *imageKey;

@end

@implementation PersonSettingViewController
- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        [self showAlertView];
        
    }else{
        [self resaveActive];
           }
}

- (void)resaveActive{
    [CustomAlertView showAlertViewWithVC:self];
    NSMutableDictionary *dica = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *district = [dica objectForKey:@"address"];
    NSString *name = [dica objectForKey:@"userName"];
    if (district == nil) {
        district = @"渝中区";
    }
    NSDictionary *dic;
    if (_imageKey.length < 1) {
        dic =@{@"city":@"重庆",@"province":@"重庆",@"nickname":name,@"district":district};
    }else{
        dic =@{@"city":@"重庆",@"province":@"重庆",@"nickname":name,@"district":district,@"headPicture":_imageKey};
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
    NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7072/user-service/student/modifyInfo"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [request setHTTPBody:jsonData];
    [request setValue:token forHTTPHeaderField:@"HMAuthorization"];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
        });
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *_success = [jsonDict objectForKey:@"success"];
            if (_success.boolValue) {
                //修改资料成功
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改资料成功" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        });
                    }];
                    [v addAction:active];
                    [self presentViewController:v animated:YES completion:^{
                        
                    }];
                });
            }else{
                //上传资料失败
                UIAlertController *v = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存信息失败，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [v addAction:active];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:v animated:YES completion:^{
                        
                    }];
                });
            }
        }else{
            //上传资料失败
            UIAlertController *v = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存信息失败，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [v addAction:active];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:v animated:YES completion:^{
                    
                }];
            });
        }
    }];
    [dataTask resume];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageKey = @"";
    self.view.backgroundColor = [UIColor colorWithRed:0.92f green:0.92f blue:0.93f alpha:1.00f];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
//    [self getTokenActive];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 1;
    }else
        return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 82;
    }else
        return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    PersonSettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[PersonSettingViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    if (indexPath.section == 0) {
        cell.firstStr = @"头像";
        NSObject *data = [dic objectForKey:@"userLogoImage"];
        if (data && [data isKindOfClass:[NSData class]]) {
            cell.imagel = [UIImage fixOrientation:[UIImage imageWithData:(NSData *)data]];
        }else{
            if (((NSString *)data).length > 0) {
                cell.imageUrl = (NSString *)data;
            }else{
                cell.logoImageStr = @"bg_personal_defaultavatar";
            }
            
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.firstStr = @"昵称";
            cell.secondStr = [dic objectForKey:@"userName"];
        }else{
            cell.firstStr = @"所在地区";
            cell.secondStr = [dic objectForKey:@"address"];
        }
    }else if (indexPath.section == 2){
        cell.firstStr = @"修改密码";
        cell.secondStr = @"";
    }else{
        if (indexPath.row == 0) {
            cell.firstStr = @"所报版型";
            cell.secondStr = @"一价全包班";
        }else if (indexPath.row == 1){
            cell.firstStr = @"我的教练";
            cell.secondStr = @"未选择教练";
        }else{
            cell.firstStr = @"训练场地";
            cell.secondStr = @"牛角沱训练场";
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonSettingViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        UIAlertController *v = [UIAlertController alertControllerWithTitle:@"" message:@"请选择一种方式设置头像" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *a = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            SettingCameraViewController *v = [[SettingCameraViewController alloc] init];
            v.delegate = self;
            [self presentViewController:v animated:YES completion:^{
                
            }];
        }];
        UIAlertAction *b = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            SettingPictureViewController *v = [[SettingPictureViewController alloc] init];
            v.delegate = self;
            v.maxChoiceImageNumberumber = 1;
            [self presentViewController:[[UINavigationController alloc]initWithRootViewController:v] animated:YES completion:nil];
            
        }];
        UIAlertAction *c = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [v addAction:a];
        [v addAction:b];
        [v addAction:c];
        [self presentViewController:v animated:YES completion:nil];
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            ChangedNameViewController *v = [[ChangedNameViewController alloc ]init];
            v.nameStr = cell.secondStr;
            [v returnChangedName:^(NSString *str) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                if (dic) {
                    [dic setValue:str forKey:@"userName"];
                }else{
                    dic = [[NSMutableDictionary alloc] init];
                    [dic setValue:str forKey:@"userName"];
                }
                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            }];
            [self.navigationController pushViewController:v animated:YES];
        }else{
            ChoicePlaceViewController *v = [[ChoicePlaceViewController alloc] init];
            [v returnPlaceBlock:^(NSString *place) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                if (dic) {
                    [dic setValue:place forKey:@"address"];
                }else{
                    dic = [[NSMutableDictionary alloc] init];
                    [dic setValue:place forKey:@"address"];
                }
                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            }];
            [self.navigationController pushViewController:v animated:YES];
        }
    }else if (indexPath.section == 2){
        ResetPasswordViewController * v = [[ResetPasswordViewController alloc] init];
        [self.navigationController pushViewController:v animated:YES];
    }else{
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

//修改图片大小
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImage *newImage = [self imageFromImage:scaledImage];
    return newImage;   //返回的就是已经改变的图片
}

#pragma mark - chooicedPicDelegate

- (void)SettingCameraViewController:(SettingCameraViewController *)vc andSelectedPhone:(UIImage *)image{
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:0 inSection:0];
    PersonSettingViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    UIImage *newImage =  [self OriginImage:image scaleToSize:CGSizeMake(120, 120*image.size.height/image.size.width)];
    cell.imagel = newImage;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSData *imageData = UIImagePNGRepresentation([UIImage fixOrientation:newImage]);
    if (dic) {
        //UIImage转换为NSData
        
        [dic setObject:imageData forKey:@"userLogoImage"];
    }else{
        dic = [[NSMutableDictionary alloc] init];
        [dic setObject:imageData forKey:@"userLogoImage"];
    }
    if ([dic objectForKey:@"address"] == nil) {
        [dic setObject:@"渝中区" forKey:@"address"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
    [self getTokenActive];
}

- (void)WHCChoicePictureVC:(ChooicePictureViewController *)choicePictureVC didSelectedPhoto:(UIImage *)image{
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:0 inSection:0];
    PersonSettingViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    UIImage *newImage =  [self OriginImage:image scaleToSize:CGSizeMake(120, 120*image.size.height/image.size.width)];
    cell.imagel = newImage;
   
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSData *imageData = UIImagePNGRepresentation([UIImage fixOrientation:newImage]);
    if (dic) {
         //UIImage转换为NSData
        
        [dic setObject:imageData forKey:@"userLogoImage"];
    }else{
        dic = [[NSMutableDictionary alloc] init];
        [dic setObject:imageData forKey:@"userLogoImage"];
    }
    if ([dic objectForKey:@"address"] == nil) {
        [dic setObject:@"渝中区" forKey:@"address"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
    [self getTokenActive];
}

#pragma mark - 上传图片到服务器的方法
- (void)upDataWithImage:(UIImage *)image andKey:(NSString *)key andToken:(NSString *)token{
  
    
    QNUploadManager *manager = [[QNUploadManager alloc] init];
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSData *data = [dic objectForKey:@"userLogoImage"];
    __weak __typeof(&*self)weakSelf = self;
    if (data) {
        [manager putData:data key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            if (resp) {
                weakSelf.imageKey = [resp objectForKey:@"key"];
            }
            
            
        } option:nil];
    }

    
    
}

- (void)getTokenActive{
    NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7072/user-service/file/img/getUploadHeadPicToken"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
  
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"];
    [request setValue:token forHTTPHeaderField:@"HMAuthorization"];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dic = [jsonDict objectForKey:@"data"];
            [self upDataWithImage:[UIImage imageNamed:@"11"] andKey:[dic objectForKey:@"key"] andToken:[dic objectForKey:@"token"]];
            NSLog(@"%@",jsonDict);
            
            
        }else{
            UIAlertController *v = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"服务器异常！！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [v addAction:active];
            [self presentViewController:v animated:YES completion:^{
                
            }];
        }
    }];
    [dataTask resume];
}

- (void)showAlertView{
    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否需要将修改内容保存！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"不保存" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *active = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self resaveActive];
    }];
    
    [v addAction:cancel];
    [v addAction:active];
    [self presentViewController:v animated:YES completion:^{
        
    }];
}

- (UIImage *)imageFromImage:(UIImage *)image{
    CGRect rect;
    CGFloat scale = [UIScreen mainScreen].scale;
    if (image.size.width >= image.size.height) {
        rect = CGRectMake((image.size.width - image.size.height)/2, 0, image.size.height, image.size.height);
    }else{
        rect = CGRectMake((image.size.height - image.size.width)/2, 0, image.size.width, image.size.width);
    }
    CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}

@end
