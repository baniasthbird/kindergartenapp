//
//  ViewController.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/13.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "YBMonitorNetWorkState.h"
#import "UserInfo.h"
#import "HcdGuideView.h"

@interface ViewController ()<UITextFieldDelegate,YBMonitorNetWorkStateDelegate>
@property (weak, nonatomic) IBOutlet UIButton *login_Parent;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *txtUsrName;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UIImageView *imgarrow;

@property (nonatomic, strong) AFHTTPSessionManager *session;

@end

@implementation ViewController {
    NSString *str_reachable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *images = [NSMutableArray new];
    
    [images addObject:[UIImage imageNamed:@"slide_image1"]];
    [images addObject:[UIImage imageNamed:@"slide_image2"]];
    [images addObject:[UIImage imageNamed:@"slide_image3"]];
    [images addObject:[UIImage imageNamed:@"slide_image4"]];
    
    [[HcdGuideViewManager sharedInstance] showGuideViewWithImages:images
                                                   andButtonTitle:@"开始体验"
                                              andButtonTitleColor:[UIColor blueColor]
                                                 andButtonBGColor:[UIColor clearColor]
                                             andButtonBorderColor:[UIColor blueColor]];
    
    
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
   
    _txtUsrName.text=@"p112";
    _txtPwd.text=@"123456";
    _txtPwd.delegate=self;
    _txtUsrName.delegate=self;
    [_imgarrow setHidden:YES];

    _session=[AFHTTPSessionManager manager];
    _session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_session.requestSerializer setHTTPShouldHandleCookies:YES];
    [_session.requestSerializer setTimeoutInterval:10.0f];
    
    // 设置代理
    [YBMonitorNetWorkState shareMonitorNetWorkState].delegate = self;
    // 添加网络监听
    [[YBMonitorNetWorkState shareMonitorNetWorkState] addMonitorNetWorkState];
    
    [self netWorkStateChanged];

    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];

    
}

//登陆
-(void)Login:(UIButton*)sender {
    NSString *str_usrname=_txtUsrName.text;
    NSString *str_pwd=_txtPwd.text;
    if (![str_usrname isEqualToString:@""] && ![str_pwd isEqualToString:@""]) {
        NSString *str_url=@"http://123.56.238.120:8080/Base/MobileAccessService";
        str_usrname= [str_usrname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        str_pwd=[str_pwd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        params[@"reqtype"]=@"validate_logon";
        params[@"userid"]=str_usrname;
        params[@"password"]=str_pwd;
        
        if ([str_reachable isEqualToString:@"wifi"] || [str_reachable isEqualToString:@"GPRS"]) {
            [_session POST:str_url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *JSON=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"接收数据成功");
                NSString *str_result= [JSON objectForKey:@"result"];
                if ([str_result isEqualToString:@"success"]) {
                    [self MoveToNextPage:JSON];
                    
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"接收失败");
            }];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 网络监听代理方法，当网络状态发生改变的时候发生
-(void)netWorkStateChanged {
    // 获取当前网络类型
    NSString *currentNetWorkState = [[YBMonitorNetWorkState shareMonitorNetWorkState] getCurrentNetWorkType];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentNetWorkState forKey:@"connection"];
    [defaults synchronize];
    
    str_reachable=currentNetWorkState;

}

#pragma mark textField方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [_txtPwd resignFirstResponder];
    [_txtUsrName resignFirstResponder];
}


-(void)MoveToNextPage:(NSDictionary*)dic_usr {
    UserInfo *usrInfo=[[UserInfo alloc]init];
    NSString *str_token=[dic_usr objectForKey:@"token"];
    NSMutableArray *arr_menus=[dic_usr objectForKey:@"menus"];
    NSMutableDictionary *dic_tmp_usr=[dic_usr objectForKey:@"user"];
    NSString *str_id=[dic_tmp_usr objectForKey:@"id"];
    NSString *str_name=[dic_tmp_usr objectForKey:@"name"];
    NSString *str_nickname=[dic_tmp_usr objectForKey:@"nickname"];
    NSString *str_account=[dic_tmp_usr objectForKey:@"account"];
    NSString *str_role=[dic_tmp_usr objectForKey:@"role"];
    NSInteger i_role=[str_role integerValue];
    str_role=[NSString stringWithFormat:@"%ld",(long)i_role];
    NSString *str_schoolcode =[dic_tmp_usr objectForKey:@"schoolcode"];
    NSString *str_org=[dic_tmp_usr objectForKey:@"orgnization"];
    NSString *str_phonenum=[dic_tmp_usr objectForKey:@"phonenumber"];
    
    usrInfo.str_token=str_token;
    usrInfo.arr_menus=arr_menus;
    usrInfo.str_id=str_id;
    usrInfo.str_name=str_name;
    usrInfo.nickname=str_nickname;
    usrInfo.str_account=str_account;
    usrInfo.str_org=str_role;
    usrInfo.str_schoolcode=str_schoolcode;
    usrInfo.str_org=str_org;
    usrInfo.str_phonenumber=str_phonenum;
    [self saveUserInfo:usrInfo];
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"navMain"];
    [self presentViewController:next animated:YES completion:nil];
}

-(void)saveUserInfo:(UserInfo*)usrInfo {
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:usrInfo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"user"];
    [defaults synchronize];
}

@end
