//
//  tb_select.h
//  kindergartenapp
//
//  Created by zr-mac on 16/8/28.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Class_School.h"
#import "Baby.h"

@class tb_select;

@protocol tableviewselectDelegate <NSObject>

-(void)PassValue:(Baby*)v_baby childvalue:(Class_School*)v_class_child;

@end

@interface tb_select : UITableViewController

@property (nonatomic,strong) NSArray *arr_baby;

@property (nonatomic,strong) NSArray *arr_class;

@property (nonatomic,unsafe_unretained) id<tableviewselectDelegate> delegate;

@end
