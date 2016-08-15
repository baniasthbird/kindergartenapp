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
@property (weak, nonatomic) IBOutlet UIButton *login_Teacher;

@property (weak, nonatomic) IBOutlet UIButton *Login_Lead;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    _login_Parent.layer.borderWidth=1;
    _login_Teacher.layer.borderWidth=1;
    _Login_Lead.layer.borderWidth=1;
    _login_Parent.layer.borderColor=[[UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1] CGColor];
    _login_Teacher.layer.borderColor=[[UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1] CGColor];
    _Login_Lead.layer.borderColor=[[UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1] CGColor];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
