//
//  ViewController.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/13.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *login_Parent;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *txtUsrName;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UIImageView *imgarrow;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    _login_Parent.layer.borderWidth=1;
   
    _login_Parent.layer.borderColor=[[UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1] CGColor];
    _login_Parent.backgroundColor=[UIColor colorWithRed:243/255.0f green:131/255.0f blue:45/255.0f alpha:1];
    _login_Parent.layer.cornerRadius=10;
    [_login_Parent addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [_login_Parent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_txtUsrName setBorderStyle:UITextBorderStyleNone];
    [_txtPwd setBorderStyle:UITextBorderStyleNone];
    _bgView.layer.cornerRadius=10;
   
    [_imgarrow setHidden:YES];

    
}

//登陆
-(void)Login:(UIButton*)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
