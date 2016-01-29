//
//  NavModel.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/9.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "NavModel.h"

@implementation NavModel
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"deals"];
    for (NSDictionary *dict in dictArray) {
        NavModel *NM=[[NavModel alloc]init];
        NM.newsTitle = dict[@"title"];
        NM.newsDetail = dict[@"description"];
        NM.newsImgUrl = dict[@"image_url"];
        NM.cellUrl=dict[@"deal_id"];
        //NSLog(@"newsTitle:%@",NM.newsTitle);
        [arr addObject:NM];
    }
    return arr;
    
}


@end
