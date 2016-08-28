//
//  BaseFunc.h
//  kindergartenapp
//
//  Created by zr-mac on 16/8/21.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseFunc : NSObject

-(NSString*)GetValueFromDic:(NSDictionary*)dic_tmp key:(NSString*)str_key;

-(NSString*)GetValueFromArray:(NSArray*)arr_tmp index:(NSInteger)i_index;

-(UIImageView*)IndicatorAnimationView;

@end
