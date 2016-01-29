//
//  HomeModel.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/31.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
       
    for (NSDictionary *dict in dictArray) {
        HomeModel *NM=[[HomeModel alloc]init];
        NM.title = dict[@"goodsTitle"];
        NM.price = dict[@"goodsPrice"];
        NM.imageurl=dict[@"goodsPicUrl"];
        NM.dealurl=dict[@"goodsInfoMobileUrl"];
        [arr addObject:NM];
    }
    }
    return arr;
    
}
@end
