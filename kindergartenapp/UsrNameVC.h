//
//  UsrNameVC.h
//  kindergartenapp
//
//  Created by hnsi-03 on 16/9/9.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YLSearchDelegate <NSObject>

-(void)tableViewDidSelectRow:(NSString*)str_text;
-(void)searchTextDidChange:(NSString *)searchText;

@end

@interface UsrNameVC : UIViewController

@property (nonatomic,strong) NSMutableArray *listData;
@property (weak, nonatomic) IBOutlet UITextField *txt_usr;

@property (nonatomic,strong) UIColor *bgColor;

/**
 *  frame
 */
@property (nonatomic,assign) CGRect Frame;

@property (nonatomic,weak) id<YLSearchDelegate> delegate;

@end
