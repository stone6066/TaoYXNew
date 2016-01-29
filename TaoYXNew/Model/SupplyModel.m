//
//  SupplyModel.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/31.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "SupplyModel.h"

@implementation SupplyModel
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
    NSString *typeStr=[[NSString alloc]init];
    for (NSDictionary *dict in dictArray) {
        SupplyModel *md = [[SupplyModel alloc]init];
        md.title=[dict objectForKey:@"title"];
        md.name=[dict objectForKey:@"contact"];
        md.phone=[dict objectForKey:@"phone"];
        md.images=[dict objectForKey:@"images"];
        md.supplyDesc=[dict objectForKey:@"supplyDesc"];
        md.brandName=[dict objectForKey:@"brandName"];
        if(![[dict objectForKey:@"supplyType"] isEqual:[NSNull null]])
        {
        typeStr=[dict objectForKey:@"supplyType"];
        if ([typeStr isEqualToString: @"0"]) {
            md.supplyType=@"供应";
        }
        else
            md.supplyType=@"求购";
        }
        if(![[dict objectForKey:@"supplyId"] isEqual:[NSNull null]])
        md.supplyId=[[dict objectForKey:@"supplyId"]stringValue];
        md.supplyPrice=[NSString stringWithFormat:@"价格：%@元/%@",[dict objectForKey:@"supplyPrice"],[dict objectForKey:@"supplyUnit"]];
        if(![[dict objectForKey:@"pubId"] isEqual:[NSNull null]])
            md.pubId=[[dict objectForKey:@"pubId"]stringValue];
        [arr addObject:md];
    }
    }
    return arr;
}


- (NSArray *)asignDetailModelWithDict:(NSDictionary *)mydict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSDictionary *dict = [mydict objectForKey:@"data"];
    if(![[mydict objectForKey:@"data"] isEqual:[NSNull null]])
    {
       
       
        SupplyModel *md = [[SupplyModel alloc]init];
        md.title=[dict objectForKey:@"title"];
        md.name=[dict objectForKey:@"contact"];
        md.phone=[dict objectForKey:@"phone"];
        md.images=[dict objectForKey:@"images"];
        md.supplyDesc=[dict objectForKey:@"supplyDesc"];
        md.brandName=[dict objectForKey:@"brandName"];
        md.areaName=[dict objectForKey:@"areaName"];
        md.supplySpecName=[dict objectForKey:@"supplySpecName"];
        md.supplyType=[dict objectForKey:@"supplyType"];
        md.supplyUnit=[dict objectForKey:@"supplyUnit"];
        
        if(![[dict objectForKey:@"brandId"] isEqual:[NSNull null]])
           md.brandId=[[dict objectForKey:@"brandId"]stringValue];
        
        
        if(![[dict objectForKey:@"areaId"] isEqual:[NSNull null]])
           md.areaId=[[dict objectForKey:@"areaId"]stringValue];
    
        
        if(![[dict objectForKey:@"supplyId"] isEqual:[NSNull null]])
            md.supplyId=[[dict objectForKey:@"supplyId"]stringValue];
        
        if(![[dict objectForKey:@"supplyPrice"] isEqual:[NSNull null]])
           md.supplyPrice=[[dict objectForKey:@"supplyPrice"]stringValue];
        
        
        if(![[dict objectForKey:@"supplyValidate"] isEqual:[NSNull null]])
            md.supplyValidate=[self stdTimeToStr:[[dict objectForKey:@"supplyValidate"]stringValue]];
        
        if(![[dict objectForKey:@"pubId"] isEqual:[NSNull null]])
            md.pubId=[[dict objectForKey:@"pubId"]stringValue];
        
        [arr addObject:md];
        
    }
    return arr;
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    return [objDateformat stringFromDate: date];
}

@end
