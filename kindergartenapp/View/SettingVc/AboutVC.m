//
//  AboutVC.m
//  kindergartenapp
//
//  Created by zr-mac on 16/9/10.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "AboutVC.h"

@interface AboutVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tb_About;

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"关于我们";
    NSDictionary * dict;
    if (iPad) {
        dict=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:25]};
    }
    else {
        dict =@{
                NSForegroundColorAttributeName:   [UIColor whiteColor]};
    }
    
    self.navigationController.navigationBar.titleTextAttributes=dict;

    UIButton *btn_back=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    [btn_back setTitle:@"返回" forState:UIControlStateNormal];
    [btn_back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_back setTintColor:[UIColor whiteColor]];
    [btn_back setImage:[UIImage imageNamed:@"returnlogo"] forState:UIControlStateNormal];
    [btn_back setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [btn_back addTarget:self action:@selector(BackToAppCenter:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn_back];
    
    
    _tb_About.delegate=self;
    _tb_About.dataSource=self;
    // Do any additional setup after loading the view.
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
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell_About";
    //从缓冲区中获取已有的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell==nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        if (indexPath.row==0) {
            cell.textLabel.text=@"关于马良家园";
        }
        else if (indexPath.row==1) {
            cell.textLabel.text=@"马良家园官网";
            cell.detailTextLabel.text=@"http://www.mlhomein.com";
        }
        else if (indexPath.row==2) {
            cell.textLabel.text=@"客服电话";
            cell.detailTextLabel.text=@"400-859-7686";
        }
        else if (indexPath.row==3) {
            cell.textLabel.text=@"微信公众号";
            cell.detailTextLabel.text=@"mlsmkj888";
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}


-(void)BackToAppCenter:(UIButton*)Btn {
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.0679347826087*Height;
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
