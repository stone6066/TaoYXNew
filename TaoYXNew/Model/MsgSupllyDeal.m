//
//  MsgSupllyDeal.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MsgSupllyDeal.h"

@implementation MsgSupllyDeal
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSDictionary *dictArray = [dict objectForKey:@"data"];
    
    NSString *typeStr=[[NSString alloc]init];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        MsgSupllyDeal *md = [[MsgSupllyDeal alloc]init];
        md.title=[dictArray objectForKey:@"title"];
        md.name=[dictArray objectForKey:@"contact"];
        md.phone=[dictArray objectForKey:@"phone"];
        md.images=[dictArray objectForKey:@"images"];
        md.supplyDesc=[dictArray objectForKey:@"supplyDesc"];
        md.brandName=[dictArray objectForKey:@"brandName"];
        typeStr=[dictArray objectForKey:@"supplyType"];
        if ([typeStr isEqualToString: @"0"]) {
            md.supplyType=@"供应";
        }
        else
            md.supplyType=@"求购";
        
        [arr addObject:md];
    }
    return arr;
}
@end
