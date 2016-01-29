//
//  MySupplyOrderDeal.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MySupplyOrderDeal.h"



@implementation MySupplyOrderDeal
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    for (NSDictionary *dict in dictArray) {
        MySupplyOrderDeal *md = [[MySupplyOrderDeal alloc]init];
        if(![[dict objectForKey:@"supply"] isEqual:[NSNull null]])
        {
        NSDictionary *supplyDict=[dict objectForKey:@"supply"];
        md.title=[supplyDict objectForKey:@"title"];
        md.supplyPrice=[supplyDict objectForKey:@"supplyPrice"];
        md.supplyUnit=[supplyDict objectForKey:@"supplyUnit"];
        md.images=[supplyDict objectForKey:@"images"];
        NSString *typeStr=[supplyDict objectForKey:@"supplyType"];
        if ([typeStr isEqualToString: @"0"]) {
            md.supplyType=@"供应";
        }
        else
            md.supplyType=@"求购";
        
        if(![[supplyDict objectForKey:@"supplyValidate"] isEqual:[NSNull null]])
            md.supplyValidate=[self stdTimeToStr:[[supplyDict objectForKey:@"supplyValidate"]stringValue]];
        
        }
        
        if(![[dict objectForKey:@"supplyOrderId"] isEqual:[NSNull null]])
            md.supplyOrderId=[[dict objectForKey:@"supplyOrderId"]stringValue];
        md.supplyOrderPrice=[dict objectForKey:@"supplyOrderPrice"];
        md.supplyOrderNum=[dict objectForKey:@"supplyOrderNum"];
        if(![[dict objectForKey:@"supplyOrderFlag"] isEqual:[NSNull null]])
        {
            NSString *flagStr=[dict objectForKey:@"supplyOrderFlag"];
            if ([flagStr isEqualToString: @"0"]) {
                md.supplyOrderFlag=@"抢单中";
            }
            else if ([flagStr isEqualToString: @"1"])
                md.supplyOrderFlag=@"已中单";
            else
                md.supplyOrderFlag=@"未中单";
        }

        
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
