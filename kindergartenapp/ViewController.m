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
#import "BaseFunc.h"
#import "ParentInfo.h"
#import "TeacherInfo.h"
#import "Baby.h"
#import "Class_child.h"
#import "MBProgressHUD.h"


@interface ViewController ()<UITextFieldDelegate,YBMonitorNetWorkStateDelegate>
@property (weak, nonatomic) IBOutlet UIButton *login_Parent;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *txtUsrName;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UIImageView *imgarrow;


@property (nonatomic, strong) AFHTTPSessionManager *session;

@property (nonatomic,strong) NSMutableArray *refreshImages;

@property (nonatomic,strong) NSMutableArray *normalImages;

@end

@implementation ViewController {
    NSString *str_reachable;
    BaseFunc *baseFunc;
    UIImageView *img_refresh;
    MBProgressHUD *view_indicator;
    
}

- (NSMutableArray *)normalImages
{
    if (_normalImages == nil) {
        _normalImages = [[NSMutableArray alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_0"]];
        [self.normalImages addObject:image];
    }
    return _normalImages;
}
//正在刷新状态下的图片
- (NSMutableArray *)refreshImages
{
    if (_refreshImages == nil) {
        _refreshImages = [[NSMutableArray alloc] init];
        //				循环添加图片
        for (NSUInteger i = 0; i<6; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_%ld", i]];
            [self.refreshImages addObject:image];
        }
    }
    return _refreshImages;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSMutableArray *images = [NSMutableArray new];
    
    [images addObject:[UIImage imageNamed:@"slide_image1"]];
    [images addObject:[UIImage imageNamed:@"slide_image2"]];
    [images addObject:[UIImage imageNamed:@"slide_image3"]];
    [images addObject:[UIImage imageNamed:@"slide_image4"]];
    /*
    [[HcdGuideViewManager sharedInstance] showGuideViewWithImages:images
                                                   andButtonTitle:@"开始体验"
                                              andButtonTitleColor:[UIColor blueColor]
                                                 andButtonBGColor:[UIColor clearColor]
                                             andButtonBorderColor:[UIColor blueColor]];
    */
    
    // Do any additional setup after loading the view, typically from a nib.
    baseFunc=[[BaseFunc alloc]init];
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
   
    _txtUsrName.text=@"P01";
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
    
    img_refresh=[baseFunc IndicatorAnimationView];
    
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
        
        
        view_indicator=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        view_indicator.customView=img_refresh;
        [view_indicator show:YES];
       // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        if ([str_reachable isEqualToString:@"wifi"] || [str_reachable isEqualToString:@"GPRS"]) {
            [_session POST:str_url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *JSON=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"接收数据成功");
                NSString *str_result= [JSON objectForKey:@"result"];
                if ([str_result isEqualToString:@"success"]) {
                   
                    UserInfo *usrInfo=[self CreateUserInfo:JSON];
                    NSString *str_token=usrInfo.str_token;
                    NSString *str_id=usrInfo.str_id;
                    NSString *str_role=usrInfo.str_role;
                    NSMutableDictionary *usr_params=[NSMutableDictionary dictionary];
                    usr_params[@"reqtype"]=@"user_relation_info";
                    usr_params[@"userid"]=str_id;
                    usr_params[@"role"]=str_role;
                    usr_params[@"token"]=str_token;
                    [_session POST:str_url parameters:usr_params progress:^(NSProgress * _Nonnull uploadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSArray *JSON=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                        NSLog(@"接收数据成功");
                        if (JSON!=nil && [JSON count]>0) {
                            [self saveUserAdditionInfo:JSON role:str_role];
                        }
                        [self MoveToNextPage:usrInfo];
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                    }];
                    
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


-(UserInfo*)CreateUserInfo:(NSDictionary*)dic_usr {
    UserInfo *usrInfo=[[UserInfo alloc]init];
    NSString *str_token=[baseFunc GetValueFromDic:dic_usr key:@"token"];
    NSMutableArray *arr_menus=[dic_usr objectForKey:@"menus"];
    NSMutableDictionary *dic_tmp_usr=[dic_usr objectForKey:@"user"];
    NSString *str_id=[baseFunc GetValueFromDic:dic_tmp_usr key:@"id"];
    NSString *str_name=[baseFunc GetValueFromDic:dic_tmp_usr key:@"name"];
    NSString *str_nickname=[baseFunc GetValueFromDic:dic_tmp_usr key:@"nickname"];
    NSString *str_account=[baseFunc GetValueFromDic:dic_tmp_usr key:@"account"];
    NSString *str_role=[baseFunc GetValueFromDic:dic_tmp_usr key:@"role"];
    NSString *str_schoolcode =[baseFunc GetValueFromDic:dic_tmp_usr key:@"schoolcode"];
    NSString *str_org=[baseFunc GetValueFromDic:dic_tmp_usr key:@"orgnization"];
    NSString *str_phonenum=[baseFunc GetValueFromDic:dic_tmp_usr key:@"phonenumber"];
    
    usrInfo.str_token=str_token;
    usrInfo.arr_menus=arr_menus;
    usrInfo.str_id=str_id;
    usrInfo.str_name=str_name;
    usrInfo.nickname=str_nickname;
    usrInfo.str_account=str_account;
    usrInfo.str_role=str_role;
    usrInfo.str_schoolcode=str_schoolcode;
    usrInfo.str_org=str_org;
    usrInfo.str_phonenumber=str_phonenum;

    return usrInfo;
}

-(void)MoveToNextPage:(UserInfo*)usrInfo {
       [self saveUserInfo:usrInfo];
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"navMain"];
     [view_indicator hide:YES];
    [self presentViewController:next animated:YES completion:nil];
}

-(void)saveUserInfo:(UserInfo*)usrInfo {
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:usrInfo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"user"];
    [defaults synchronize];
}

-(void)saveUserAdditionInfo:(NSArray*)arr_usr_add role:(NSString*)str_role {
    NSInteger i_role=[str_role integerValue];
    if (i_role==0) {
        //解析所有孩子，添加家长
        NSMutableArray *arr_babies=[self GenerateBabies:arr_usr_add];
        ParentInfo *parent=[ParentInfo CreateParent:arr_babies];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:parent];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"user_parent"];
        [defaults synchronize];
        NSLog(@"家长数据保存成功!");
        
    }
    else if (i_role==2) {
        //解析所有班级，添加教师
        NSMutableArray *arr_class=[self GenerateClass:arr_usr_add];
        TeacherInfo *teacher=[TeacherInfo CreateTeacher:arr_class];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:teacher];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"user_teacher"];
        [defaults synchronize];
        NSLog(@"老师数据保存成功");
    }
    else if (i_role==3) {
        NSLog(@"园长");
    }
   
}

//转换成孩子
-(NSMutableArray*)GenerateBabies:(NSArray*)arr_usr_add {
    NSMutableArray *arr_babies=[[NSMutableArray alloc]init];
    for (int i=0;i<[arr_usr_add count];i++) {
        NSDictionary *dic_baby_info=[arr_usr_add objectAtIndex:i];
        NSString *str_sex=[baseFunc GetValueFromDic:dic_baby_info key:@"sex"];
        NSString *str_xuehao=[baseFunc GetValueFromDic:dic_baby_info key:@"xuehao"];
        NSString *str_address=[baseFunc GetValueFromDic:dic_baby_info key:@"address"];
        NSString *str_birthday=[baseFunc GetValueFromDic:dic_baby_info key:@"birthday"];
        NSString *str_classname=[baseFunc GetValueFromDic:dic_baby_info key:@"classname"];
        NSString *str_schoolcode=[baseFunc GetValueFromDic:dic_baby_info key:@"schoolcode"];
        NSString *str_gradeid=[baseFunc GetValueFromDic:dic_baby_info key:@"gradeid"];
        NSString *str_xuejihao=[baseFunc GetValueFromDic:dic_baby_info key:@"xuejihao"];
        NSString *str_gradename=[baseFunc GetValueFromDic:dic_baby_info key:@"gradename"];
        NSString *str_name=[baseFunc GetValueFromDic:dic_baby_info key:@"name"];
        NSString *str_classid=[baseFunc GetValueFromDic:dic_baby_info key:@"classid"];
        NSString *str_schoolname=[baseFunc GetValueFromDic:dic_baby_info key:@"schoolname"];
        Baby *baby=[[Baby alloc]init];
        baby.sex=str_sex;
        baby.xuehao=str_xuehao;
        baby.address=str_address;
        baby.birthday=str_birthday;
        baby.classname=str_classname;
        baby.schoolcode=str_schoolcode;
        baby.gradeid=str_gradeid;
        baby.xuejihao=str_xuejihao;
        baby.gradename=str_gradename;
        baby.name=str_name;
        baby.classid=str_classid;
        baby.schoolname=str_schoolname;
        [arr_babies addObject:baby];
    }
    return arr_babies;
}

-(NSMutableArray*)GenerateClass:(NSArray*)arr_usr_add {
    NSMutableArray *arr_class=[[NSMutableArray alloc]init];
    for (int i=0;i<[arr_usr_add count];i++) {
        NSDictionary *dic_class_info=[arr_usr_add objectAtIndex:i];
        NSString *str_gradeid=[baseFunc GetValueFromDic:dic_class_info key:@"gradeid"];
        NSString *str_class_id=[baseFunc GetValueFromDic:dic_class_info key:@"id"];
        NSString *str_schoolid=[baseFunc GetValueFromDic:dic_class_info key:@"schoolid"];
        NSString *str_schoolname=[baseFunc GetValueFromDic:dic_class_info key:@"schoolname"];
        NSString *str_stunumber=[baseFunc GetValueFromDic:dic_class_info key:@"stunumber"];
        NSString *str_classname=[baseFunc GetValueFromDic:dic_class_info key:@"classname"];
        Class_child *o_class=[[Class_child alloc]init];
        o_class.gradeid=str_gradeid;
        o_class.class_id=str_class_id;
        o_class.schoolid=str_schoolid;
        o_class.schoolname=str_schoolname;
        o_class.stunumber=str_stunumber;
        o_class.classname=str_classname;
        [arr_class addObject:o_class];

    }
       return arr_class;
    
}


@end
