//
//  UsrNameVC.m
//  kindergartenapp
//
//  Created by hnsi-03 on 16/9/9.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "UsrNameVC.h"
#import "UsrCell.h"

@interface UsrNameVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tb_usr;
@property (weak, nonatomic) IBOutlet UIButton *btn_show;


@property (nonatomic,assign) float x;//自身的x坐标
@property (nonatomic,assign) float y;//自身的y坐标
@property (nonatomic,assign) float width;//宽度
@property (nonatomic,assign) float hight;//高
@end

@implementation UsrNameVC
- (IBAction)btn_show:(id)sender {
    if (_tb_usr.hidden==YES) {
        self.tb_usr.frame = CGRectMake(CGRectGetMinX(self.txt_usr.frame), CGRectGetMaxY(self.txt_usr.frame) + 2, CGRectGetWidth(self.txt_usr.frame), self.listData.count * 40);
        self.view.frame = CGRectMake(self.x, self.y, self.width, CGRectGetHeight(self.tb_usr.frame)+ 40);

        _tb_usr.hidden=NO;
        
    }
    else {
        self.view.frame = CGRectMake(self.x, self.y, self.width, CGRectGetHeight(self.txt_usr.frame));
        _tb_usr.hidden=YES;
       
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _txt_usr.delegate=self;
    _tb_usr.delegate=self;
    _tb_usr.dataSource=self;
    _tb_usr.hidden=YES;
    //_tb_usr.backgroundColor=[UIColor clearColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell";
    //从缓冲区中获取已有的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // cell.backgroundColor=[UIColor colorWithRed:249/255.0f green:248/255.0f blue:246/255.0f alpha:1];
        cell.backgroundColor=[UIColor clearColor];
        
    }
    cell.textLabel.text = self.listData[indexPath.row];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[self.tb_usr cellForRowAtIndexPath:indexPath];
    NSString *str_usrname=cell.textLabel.text;
    [_delegate tableViewDidSelectRow:str_usrname];
     self.view.frame = CGRectMake(self.x, self.y, self.width, CGRectGetHeight(self.txt_usr.frame));
    self.tb_usr.hidden=YES;
}

-(void)setFrame:(CGRect)Frame {
    self.x = CGRectGetMinX(Frame);
    self.y = CGRectGetMinY(Frame);
    self.width = CGRectGetWidth(Frame);
    self.hight = CGRectGetHeight(Frame);
    self.view.frame = Frame;

}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
