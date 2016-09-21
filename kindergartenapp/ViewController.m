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
#import "Class_School.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"
#import "ZLCGuidePageView.h"
#import "UsrNameVC.h"







@interface ViewController ()<UITextFieldDelegate,YBMonitorNetWorkStateDelegate,YLSearchDelegate>

@property (weak, nonatomic) IBOutlet UIButton *login_Parent;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;

@property (nonatomic,strong) UsrNameVC *ursNameVC;

@property (weak, nonatomic) IBOutlet UIView *view_usr_bg;

@property (weak, nonatomic) IBOutlet UIImageView *bg_Login;


@property (nonatomic, strong) AFHTTPSessionManager *session;

@property (nonatomic,strong) NSMutableArray *refreshImages;

@property (nonatomic,strong) NSMutableArray *normalImages;

@property (nonatomic) NSArray *dataSource;



@end

@implementation ViewController {
    NSString *str_reachable;
    BaseFunc *baseFunc;
    UIImageView *img_refresh;
    MBProgressHUD *view_indicator;
    NSMutableArray *bandArray;
    
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
    
    [self.navigationController.navigationBar setHidden:YES];
    
    //创建引导页视图
    ZLCGuidePageView *pageView = [[ZLCGuidePageView alloc]initWithFrame:self.view.frame WithImages:images];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [self.navigationController.view addSubview:pageView];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    _dataSource=[[NSArray alloc]initWithObjects:@"P01",@"T01",@"Y01", nil];
    
    
    
    
    
    /*
    [[HcdGuideViewManager sharedInstance] showGuideViewWithImages:images
                                                   andButtonTitle:@"开始体验"
                                              andButtonTitleColor:[UIColor blueColor]
                                                 andButtonBGColor:[UIColor clearColor]
                                             andButtonBorderColor:[UIColor blueColor]];
    */
    
    if (_b_update==YES) {
    }
    
    
    //去掉所有保存
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [defaults dictionaryRepresentation];
    for (id  key in dic) {
        if ([key isEqualToString:@"systemversion"] || [key isEqualToString:@"firstLaunch"]) {
            continue;
        }
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    baseFunc=[[BaseFunc alloc]init];
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    _login_Parent.layer.borderWidth=1;
   
    _login_Parent.layer.borderColor=[[UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1] CGColor];
    _login_Parent.backgroundColor=[UIColor colorWithRed:243/255.0f green:131/255.0f blue:45/255.0f alpha:1];
    _login_Parent.layer.cornerRadius=10;
    [_login_Parent addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [_login_Parent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // [_txtUsrName setBorderStyle:UITextBorderStyleNone];
    [_txtPwd setBorderStyle:UITextBorderStyleNone];
    _bgView.layer.cornerRadius=10;
   
   // _txtUsrName.text=@"P01";
    _txtPwd.delegate=self;
    _txtPwd.secureTextEntry=YES;
    _txtPwd.layer.borderWidth=0;
  //  _txtUsrName.delegate=self;
   
    
    

    _session=[AFHTTPSessionManager manager];
    _session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_session.requestSerializer setHTTPShouldHandleCookies:YES];
    [_session.requestSerializer setTimeoutInterval:10.0f];
    
    // 设置代理
    [YBMonitorNetWorkState shareMonitorNetWorkState].delegate = self;
    // 添加网络监听
    [[YBMonitorNetWorkState shareMonitorNetWorkState] addMonitorNetWorkState];
    
    [self netWorkStateChanged];

    
    self.bg_Login.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];

    
    [self.bg_Login addGestureRecognizer:singleTap];
    
    img_refresh=[baseFunc IndicatorAnimationView];
    /*
    _LoginLookupBtn = [[AKLookups alloc] initWithLookupViewController:_listVC];
    _LoginLookupBtn.frame = CGRectMake(_txtUsrName.frame.origin.x,CGRectGetMaxY(_txtUsrName.frame), _txtUsrName.frame.size.width, _txtUsrName.frame.size.height);
    [_LoginLookupBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_LoginLookupBtn];
     */
    self.ursNameVC=[[UsrNameVC alloc]init];
    
    self.ursNameVC.delegate=self;
    
    self.ursNameVC.view.layer.cornerRadius=10;
    
    
    bandArray=[[NSMutableArray alloc]init];
    
    [bandArray addObject:@"P01"];
    [bandArray addObject:@"T01"];
    [bandArray addObject:@"Y01"];
    self.ursNameVC.listData=bandArray;
   
    [self.view sendSubviewToBack:_view_usr_bg];

    
   
}

-(void)viewDidAppear:(BOOL)animated {
    
    self.ursNameVC.Frame=CGRectMake(_bgView.frame.origin.x+_txtPwd.frame.origin.x, _bgView.frame.origin.y+5, self.view_usr_bg.frame.size.width, self.view_usr_bg.frame.size.height);
    self.ursNameVC.bgColor=self.bgView.backgroundColor;
    
    [self.view addSubview:self.ursNameVC.view];
      // create the array of data;
  
        //self.downPicker=[[DownPicker alloc] initWithTextField:self.txtUsrName withData:bandArray];
}

//登陆
-(void)Login:(UIButton*)sender {
   // NSString *str_usrname=_txtUsrName.text;
    NSString *str_usrname=_ursNameVC.txt_usr.text;
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
        view_indicator.userInteractionEnabled=NO;
        view_indicator.dimBackground=YES;
        view_indicator.color=[UIColor clearColor];
        [self.view addSubview:view_indicator];
        view_indicator.mode=MBProgressHUDModeCustomView;
        UIImage *imges=[UIImage sd_animatedGIFNamed:@"loading"];
        view_indicator.customView=[[UIImageView alloc]initWithImage:imges];
        [view_indicator.customView setFrame:CGRectMake(0, 0, 0.2*Width, 0.2*Width)];
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
                        NSMutableArray *arr_JSON=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                        NSLog(@"接收数据成功");
                        if (arr_JSON!=nil && [arr_JSON count]>0) {
                            NSInteger i_role=[str_role integerValue];
                            if (i_role==0) {
                                 [self saveParentAdditionInfo:arr_JSON];
                                 [self MoveToNextPage:usrInfo];
                            }
                            else if (i_role==2) {
                                for (int i=0;i< [arr_JSON count];i++) {
                                    NSMutableDictionary *dic_class=[arr_JSON objectAtIndex:i];
                                    NSString  *str_roleid=[baseFunc GetValueFromDic:dic_class key:@"roleid"];
                                    NSInteger i_sub_roleid=[str_roleid integerValue];
                                    if (i_sub_roleid==2) {
                                        NSString *str_classid=[baseFunc GetValueFromDic:dic_class key:@"dutyid"];
                                        NSMutableDictionary *num_param=[NSMutableDictionary dictionary];
                                        num_param[@"reqtype"]=@"get_class_student_count";
                                        num_param[@"classid"]=str_classid;
                                        [_session POST:str_url parameters:num_param progress:^(NSProgress * _Nonnull uploadProgress) {
                                            
                                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            NSDictionary *dic_count=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                            [dic_class addEntriesFromDictionary:dic_count];
                                            BOOL b_enter=YES;
                                            for (int j=0;j<[arr_JSON count];j++) {
                                                NSDictionary *dic_test=[arr_JSON objectAtIndex:j];
                                                NSString  *str_roleid=[baseFunc GetValueFromDic:dic_test key:@"roleid"];
                                                NSInteger i_sub_roleid=[str_roleid integerValue];
                                                if (i_sub_roleid==2) {
                                                    if (dic_test.allKeys.count==6) {
                                                        b_enter=NO;
                                                    }
                                                }
                                            }
                                            if (b_enter==YES) {
                                                [self SaveTeacherAdditionInfo:arr_JSON];
                                                [self MoveToNextPage:usrInfo];
                                            }
                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            
                                        }];
                                    }
                                    else {
                                       
                                    }
                                }
                            }
                           
                        }
                        else {
                            [self MoveToNextPage:usrInfo];
                        }
                       
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         [view_indicator hide:YES];
                        NSLog(@"失败");
                    }];
                    
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"接收失败");
                [view_indicator hide:YES];
                [view_indicator setLabelText:@"接受失败"];
                view_indicator.mode=MBProgressHUDModeText;
                [view_indicator show:YES];
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
    [_ursNameVC.txt_usr resignFirstResponder];
   // [_txtUsrName resignFirstResponder];
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

#pragma mark 根据接受数据保存角色内容
-(void)saveParentAdditionInfo:(NSArray*)arr_usr_add{

        //解析所有孩子，添加家长
        NSMutableArray *arr_babies=[self GenerateBabies:arr_usr_add];
        ParentInfo *parent=[ParentInfo CreateParent:arr_babies];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:parent];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data forKey:@"user_parent"];
        [defaults synchronize];
        NSLog(@"家长数据保存成功!");
   
}


-(void)SaveTeacherAdditionInfo:(NSMutableArray*)arr_usr_add {
    //解析所有班级，添加教师
    NSMutableArray *arr_result=[self GenerateClass:arr_usr_add];
    NSMutableArray *arr_class=[[NSMutableArray alloc]init];
    Class_School *dic_school=[[Class_School alloc]init];
    for (int i=0;i<[arr_result count];i++) {
        Class_School *tmp=[arr_result objectAtIndex:i];
        NSString *str_roleid=tmp.roleid;
        NSInteger i_roleid=[str_roleid integerValue];
        if (i_roleid==2) {
            [arr_class addObject:tmp];
        }
        else if (i_roleid==3) {
            dic_school=tmp;
        }
    }
    TeacherInfo *teacher=[TeacherInfo CreateTeacher:arr_class school:dic_school];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:teacher];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"user_teacher"];
    [defaults synchronize];
    NSLog(@"老师数据保存成功");
}

//园长
-(void)SaveLeaderAdditionInfo {
   
       NSLog(@"园长");
    
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

-(NSMutableArray*)GenerateClass:(NSArray*)arr_usr_add{
    NSMutableArray *arr_class=[[NSMutableArray alloc]init];
    for (int i=0;i<[arr_usr_add count];i++) {
        NSDictionary *dic_class_info=[arr_usr_add objectAtIndex:i];
        NSString *str_userid=[baseFunc GetValueFromDic:dic_class_info key:@"userid"];
        NSString *str_i_id=[baseFunc GetValueFromDic:dic_class_info key:@"id"];
        NSString *str_rolename=[baseFunc GetValueFromDic:dic_class_info key:@"rolename"];
        NSString *str_dutyid=[baseFunc GetValueFromDic:dic_class_info key:@"dutyid"];
        NSString *str_roleid=[baseFunc GetValueFromDic:dic_class_info key:@"roleid"];
        NSString *str_dutyname=[baseFunc GetValueFromDic:dic_class_info key:@"dutyname"];
        NSInteger i_roleid=[str_roleid integerValue];
        NSString *str_count=@"0";
        if (i_roleid==2) {
            str_count=[baseFunc GetValueFromDic:dic_class_info key:@"count"];
        }
        
       // if ([str_roleid isEqualToString:str_role]) {
            Class_School *o_class=[[Class_School alloc]init];
            o_class.userid=str_userid;
            o_class.i_id=str_i_id;
            o_class.rolename=str_rolename;
            o_class.dutyid=str_dutyid;
            o_class.roleid=str_roleid;
            o_class.dutyname=str_dutyname;
            o_class.count=str_count;
            [arr_class addObject:o_class];
      //  }
       

    }
       return arr_class;
    
}

-(void)tableViewDidSelectRow:(NSString*)str_text {
    _ursNameVC.txt_usr.text=str_text;
    _txtPwd.text=@"123456";
}

-(void)searchTextDidChange:(NSString *)searchText {
    
}







@end
