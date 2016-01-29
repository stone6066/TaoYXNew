//
//  MyGrapDeal.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/22.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MyGrapDeal.h"


@implementation MyGrapDeal
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
       
        for (NSDictionary *dict in dictArray) {
            MyGrapDeal *md = [[MyGrapDeal alloc]init];
            md.contact=[dict objectForKey:@"contact"];
          
            md.memo=[dict objectForKey:@"memo"];
            md.mobile=[dict objectForKey:@"mobile"];
            md.phone=[dict objectForKey:@"phone"];
            
            md.publisher=[dict objectForKey:@"publisher"];
            if(![[dict objectForKey:@"supply"] isEqual:[NSNull null]])
            {
                NSDictionary *dictTmp=[dict objectForKey:@"supply"];
                if(![[dictTmp objectForKey:@"images"] isEqual:[NSNull null]])
                    md.images=[dictTmp objectForKey:@"images"];
            }
            if(![[dict objectForKey:@"pubId"] isEqual:[NSNull null]])
                md.pubId=[dict objectForKey:@"pubId"];
            
            if(![[dict objectForKey:@"supplyOrderId"] isEqual:[NSNull null]])
                md.supplyOrderId=[dict objectForKey:@"supplyOrderId"];
            if(![[dict objectForKey:@"supplyOrderNum"] isEqual:[NSNull null]])
                md.supplyOrderNum=[dict objectForKey:@"supplyOrderNum"];
            if(![[dict objectForKey:@"supplyOrderPrice"] isEqual:[NSNull null]])
                md.supplyOrderPrice=[dict objectForKey:@"supplyOrderPrice"];
            if(![[dict objectForKey:@"supplyOrderFlag"] isEqual:[NSNull null]])
                md.supplyOrderFlag=[dict objectForKey:@"supplyOrderFlag"];
            
            if(![[dict objectForKey:@"supplyId"] isEqual:[NSNull null]])
                md.supplyId=[dict objectForKey:@"supplyId"];
            if(![[dict objectForKey:@"createTime"] isEqual:[NSNull null]])
                md.createTime=[self stdTimeToStr:[[dict objectForKey:@"createTime"]stringValue]];
           
            
            [arr addObject:md];
        }
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
