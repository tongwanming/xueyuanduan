//
//  ChangedNameViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/6/1.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ChangedNameViewController.h"

@interface ChangedNameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation ChangedNameViewController
- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 1002){
        if (self.changeNameBalock) {
            self.changeNameBalock(_text.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 1003){
        _text.text = @"";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.98f alpha:1.00f];
    if (_nameStr.length > 0) {
        _saveBtn.userInteractionEnabled = YES;
        _saveBtn.titleLabel.textColor = TEXT_COLOR;
    }else{
        _saveBtn.userInteractionEnabled = NO;
        _saveBtn.titleLabel.textColor = UNMAIN_TEXT_COLOR;
    }
    _text.delegate = self;
    _text.text = _nameStr;
    [_text addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    // Do any additional setup after loading the view from its nib.
}

- (void)valueChanged:(UITextField *)textField{
    if (textField.text.length > 0) {
        _saveBtn.userInteractionEnabled = YES;
        _saveBtn.titleLabel.textColor = TEXT_COLOR;
    }else{
        _saveBtn.userInteractionEnabled = NO;
        _saveBtn.titleLabel.textColor = UNMAIN_TEXT_COLOR;
    }
}


- (void)returnChangedName:(ChangeNameBlock)block{
    self.changeNameBalock = block;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
