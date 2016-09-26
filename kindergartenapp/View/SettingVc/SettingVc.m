//
//  SettingVc.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/21.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "SettingVc.h"
#import "CellLogo.h"
#import "CellSetting.h"
#import "AboutVC.h"



//设置页面cell的Tag
#define Cell_Account   4001
#define Cell_ChangePwd 4002
#define Cell_Family_Member    4003
#define Cell_Member_Service    4004
#define Cell_Setting   4005
#define Cell_About     4006
#define Cell_SchoolInfo 4007
#define Cell_ClearCache 4008


@interface SettingVc()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tb_setting;


@end

@implementation SettingVc {
    NSInteger i_role;
}

-(void) viewDidLoad {
    self.tabBarItem.image=[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage=[[UIImage imageNamed:@"setting_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _tb_setting.delegate=self;
    _tb_setting.dataSource=self;
    
    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    _userInfo=[[UserInfo alloc]init];
    _userInfo=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    i_role=[_userInfo.str_role integerValue];
    
    [self.tb_setting registerNib:[UINib nibWithNibName:NSStringFromClass([CellLogo class]) bundle:nil] forCellReuseIdentifier:@"CellLogo"];
    [self.tb_setting registerNib:[UINib nibWithNibName:NSStringFromClass([CellSetting class]) bundle:nil] forCellReuseIdentifier:@"CellSetting"];
    
}



#pragma mark tableView方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (i_role==0 || i_role==3) {
        return 4;
    }
    else {
        return 3;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    else if (section==1) {
        return 2;
    }
    else if (section==2) {
        if (i_role==0) {
            return 2;
        }
        else if (i_role==2) {
            return 3;
        }
        else if (i_role==3){
            return 1;
        }
        else {
            return 0;
        }
    }
    else {
        if (i_role==0 || i_role==3) {
            if (section==3) {
                return 3;
            }
            else {
                return 0;
            }
        }
        else {
            return 0;
        }
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        CellLogo *cell=(CellLogo*)[tableView dequeueReusableCellWithIdentifier:@"CellLogo" forIndexPath:indexPath];
        
        return cell;
    }
    else  {
        CellSetting *cell=(CellSetting*)[tableView dequeueReusableCellWithIdentifier:@"CellSetting" forIndexPath:indexPath];
        if (indexPath.section==1) {
            if (indexPath.row==0) {
                cell.lbl_Title.text=@"我的账号";
                cell.img_Logo.image=[UIImage imageNamed:@"account"];
                cell.tag=Cell_Account;
            }
            else if (indexPath.row==1) {
                cell.lbl_Title.text=@"修改密码";
                cell.img_Logo.image=[UIImage imageNamed:@"ChangePwd"];
                cell.tag=Cell_ChangePwd;
            }
        }
        else if (indexPath.section==2) {
            if (i_role==0) {
                if (indexPath.row==0) {
                    cell.lbl_Title.text=@"家庭成员";
                    cell.img_Logo.image=[UIImage imageNamed:@"FamilyMember"];
                    cell.tag=Cell_Family_Member;
                }
                else if (indexPath.row==1) {
                    cell.lbl_Title.text=@"会员服务";
                    cell.img_Logo.image=[UIImage imageNamed:@"MemberService"];
                    cell.tag=Cell_Member_Service;
                }
            }
            else if (i_role==2) {
                if (indexPath.row==0) {
                    cell.lbl_Title.text=@"设置";
                    cell.img_Logo.image=[UIImage imageNamed:@"Setting"];
                    cell.tag=Cell_Setting;
                }
                else if (indexPath.row==1) {
                    cell.lbl_Title.text=@"关于";
                    cell.img_Logo.image=[UIImage imageNamed:@"About"];
                    cell.tag=Cell_About;
                }
                else if (indexPath.row==2) {
                    cell.lbl_Title.text=[NSString stringWithFormat:@"%@          (%.2fM)",@"清除缓存",[self filePath]];
                    cell.tag=Cell_ClearCache;
                }
            }
            else if (i_role==3) {
                if (indexPath.row==0) {
                    cell.lbl_Title.text=@"基本信息";
                    cell.img_Logo.image=[UIImage imageNamed:@"SchollInfo"];
                    cell.tag=Cell_SchoolInfo;
                }
            }
        }
        else if (indexPath.section==3) {
            if (indexPath.row==0) {
                cell.lbl_Title.text=@"设置";
                cell.img_Logo.image=[UIImage imageNamed:@"Setting"];
                cell.tag=Cell_Setting;
            }
            else if (indexPath.row==1) {
                cell.lbl_Title.text=@"关于";
                cell.img_Logo.image=[UIImage imageNamed:@"About"];
                cell.tag=Cell_About;
            }
            else if (indexPath.row==2) {
                cell.lbl_Title.text=[NSString stringWithFormat:@"%@     (%.2fM)",@"清除缓存",[self filePath]];
                
                cell.tag=Cell_ClearCache;
            }
        }
        else {
            cell.lbl_Title.text=@"其他";
            cell.img_Logo.image=[UIImage imageNamed:@"logo_child"];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 0.3125*Height;
    }
    else {
        return 0.077*Height;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 0;
    }
    else {
        return 0.074275*Height;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view_section=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 0.074275*Height)];
    UILabel *lbl_Title=[[UILabel alloc]initWithFrame:CGRectMake(0.05877616747182*Width, 0.5*view_section.frame.size.height, 200, 10)];
   
    if (section!=0) {
        if (section==1) {
            lbl_Title.text=@"账号";
        }
        else if (section==2) {
            if (i_role==2) {
                lbl_Title.text=@"系统";
            }
            else {
                if (i_role==0) {
                    lbl_Title.text=@"个人";
                }
                else if (i_role==3) {
                    lbl_Title.text=@"学校";
                }
                
            }
        }
        else {
                lbl_Title.text=@"系统";
        }
        lbl_Title.textAlignment=NSTextAlignmentLeft;
        lbl_Title.textColor=[UIColor blackColor];
        [view_section addSubview:lbl_Title];
        return view_section;
    }
    else {
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell.tag==Cell_About) {
        AboutVC *vc_about=[[self storyboard] instantiateViewControllerWithIdentifier:@"AboutView"];
        /*
        UINavigationController *navi1=[[UINavigationController alloc]initWithRootViewController:self];
        [UIApplication sharedApplication].keyWindow.rootViewController=navi1;
        [navi1 pushViewController:vc_about animated:YES];
         */
        vc_about.str_title=@"关于我们";
        [self.navigationController pushViewController:vc_about animated:YES];
    }
    else if (cell.tag==Cell_ClearCache) {
        [self clearFile];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    self.tabBarController.navigationItem.rightBarButtonItem=nil;
}
/*
-(void)viewDidAppear:(BOOL)animated {
    
    UINavigationController *navMain=[[self storyboard] instantiateViewControllerWithIdentifier:@"navMain"];
    [UIApplication sharedApplication].keyWindow.rootViewController=navMain;
}
*/

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
        
    }
    
    return 0;
}

-( float )folderSizeAtPath:(NSString*)folderPath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    
    NSEnumerator *childFielsEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    
    long long folderSize=0;
    
    while ((fileName=[childFielsEnumerator nextObject])!=nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    
    return folderSize/(1024.0 * 1024.0);
}

//显示缓存大小
-(float)filePath {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [self folderSizeAtPath:cachePath];
}

//清理缓存
-(void)clearFile {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSLog(@"cachePath = %@", cachePath);
    
    for (NSString *p in files) {
        NSError *error = nil;
        NSString *path = [cachePath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
    
    [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
}

-(void)clearCacheSuccess {
    NSLog(@"清理成功");
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"缓存清理完毕" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    [_tb_setting reloadData];
}

@end
