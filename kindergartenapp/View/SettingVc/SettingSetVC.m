//
//  SettingSetVC.m
//  kindergartenapp
//
//  Created by zr-mac on 2016/10/29.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "SettingSetVC.h"

#define Cell_ClearCache 4008

@interface SettingSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tb_setting;

@end

@implementation SettingSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    // Do any additional setup after loading the view.
    _tb_setting.delegate=self;
    _tb_setting.dataSource=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell_Setting";
    //从缓冲区中获取已有的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        if (indexPath.row==0) {
           // cell.textLabel.text=[NSString stringWithFormat:@"%@     (%.2fM)",@"清除缓存",[self filePath]];
            cell.textLabel.text=@"清除缓存";
            cell.detailTextLabel.text=[NSString stringWithFormat:@"(%.2fM)",[self filePath]];
            cell.tag=Cell_ClearCache;
        }

    }
    else {
        cell.textLabel.text=@"清除缓存";
        cell.detailTextLabel.text=[NSString stringWithFormat:@"(%.2fM)",[self filePath]];
        cell.tag=Cell_ClearCache;

    }
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell.tag==Cell_ClearCache) {
         [self clearFile];
    }
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

//显示缓存大小
-(float)filePath {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [self folderSizeAtPath:cachePath];
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

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
        
    }
    
    return 0;
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
