//
//  BaseFunc.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/21.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "BaseFunc.h"

@interface BaseFunc()

@property (nonatomic,strong) NSMutableArray *refreshImages;


@end

@implementation BaseFunc {
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


-(NSString*)GetValueFromDic:(NSDictionary*)dic_tmp key:(NSString*)str_key {
    NSObject *obj_tmp=[dic_tmp objectForKey:str_key];
    NSString *str_tmp=@"";
    if (obj_tmp!=[NSNull null]) {
        if ([obj_tmp isKindOfClass:[NSNumber class]]) {
            long l_tmp=[(NSNumber*)obj_tmp longLongValue];
            str_tmp=[NSString stringWithFormat:@"%ld",l_tmp];
        }
        else {
             str_tmp=(NSString*)obj_tmp;
        }
       
    }
    return str_tmp;
}

-(NSString*)GetValueFromArray:(NSArray*)arr_tmp index:(NSInteger)i_index {
    NSObject *obj_tmp=[arr_tmp objectAtIndex:0];
    NSString *str_tmp=@"";
    if (obj_tmp!=[NSNull null]) {
        str_tmp=(NSString*)obj_tmp;
    }
    
    return str_tmp;
}

-(UIImageView*)IndicatorAnimationView {
    UIImageView  *img_refresh=[[UIImageView alloc]initWithFrame:CGRectMake(Width/2-50, Height/2-50, 100, 100)];
    img_refresh.animationImages=self.refreshImages;
    img_refresh.animationDuration=0.5;
    img_refresh.animationRepeatCount=0;
    return img_refresh;
}

@end
