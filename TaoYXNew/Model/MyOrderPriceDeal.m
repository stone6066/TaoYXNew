//
//  MyOrderPriceDeal.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/21.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MyOrderPriceDeal.h"


@implementation MyOrderPriceDeal
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSDictionary *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        MyOrderPriceDeal *md = [[MyOrderPriceDeal alloc]init];
        md.supplyType=[dictArray objectForKey:@"supplyType"];
        if(![[dictArray objectForKey:@"supplyOrderPrice"] isEqual:[NSNull null]])
            md.supplyOrderPrice=[[dictArray objectForKey:@"supplyOrderPrice"]stringValue];
        
        if(![[dictArray objectForKey:@"supplyOrderNum"] isEqual:[NSNull null]])
            md.supplyOrderNum=[[dictArray objectForKey:@"supplyOrderNum"]stringValue];

        if(![[dictArray objectForKey:@"supplyOrderValidate"] isEqual:[NSNull null]])
            md.supplyOrderValidate=[self stdTimeToStr:[[dictArray objectForKey:@"supplyOrderValidate"]stringValue]];
        
        if(![[dictArray objectForKey:@"createTime"] isEqual:[NSNull null]])
            md.createTime=[self stdTimeToStr:[[dictArray objectForKey:@"createTime"]stringValue]];
        
        md.supplyOrderFlag=[dictArray objectForKey:@"supplyOrderFlag"];
        md.mobile=[dictArray objectForKey:@"mobile"];
        
        if(![[dictArray objectForKey:@"supplyOrderId"] isEqual:[NSNull null]])
        md.supplyOrderId=[[dictArray objectForKey:@"supplyOrderId"]stringValue];
        
        if(![[dictArray objectForKey:@"supplyId"] isEqual:[NSNull null]])
        md.supplyId=[[dictArray objectForKey:@"supplyId"]stringValue];
        
        if(![[dictArray objectForKey:@"supplyPrice"] isEqual:[NSNull null]])
        md.supplyPrice=[[dictArray objectForKey:@"supplyPrice"]stringValue];
        
        md.supplyUnit=[dictArray objectForKey:@"supplyUnit"];
        md.contact=[dictArray objectForKey:@"contact"];
        md.memo=[dictArray objectForKey:@"memo"];
        if(![[dictArray objectForKey:@"pubId"] isEqual:[NSNull null]])
        md.pubId=[[dictArray objectForKey:@"pubId"]stringValue];
        md.publisher=[dictArray objectForKey:@"publisher"];
        md.phone=[dictArray objectForKey:@"phone"];
     
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
