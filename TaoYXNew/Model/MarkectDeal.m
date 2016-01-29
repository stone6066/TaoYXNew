//
//  MarkectDeal.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/28.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "MarkectDeal.h"

@implementation MarkectDeal
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    for (NSDictionary *dict in dictArray) {
        MarkectDeal *NM=[[MarkectDeal alloc]init];
        NM.title = dict[@"title"];
       
         if(![[dict objectForKey:@"createTime"] isEqual:[NSNull null]])
        NM.publicTime=[self stdTimeToStr:[[dict objectForKey:@"createTime"]stringValue]];
        NM.empDesc = dict[@"priceDesc"];
        //NM.cellUrl=dict[@"priceDesc"];
        NM.priceInfoId=dict[@"priceInfoId"];
        [arr addObject:NM];
    }
    return arr;
}

- (NSArray *)asignDetailModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSDictionary *dictArray = [dict objectForKey:@"data"];
     {
        MarkectDeal *NM=[[MarkectDeal alloc]init];
        NM.title = dictArray[@"title"];
        if(![[dictArray objectForKey:@"createTime"] isEqual:[NSNull null]])
            NM.publicTime=[self stdTimeToStr:[[dictArray objectForKey:@"createTime"]stringValue]];
        NM.empDesc = dictArray[@"priceDesc"];
        NM.priceInfoId=dictArray[@"priceInfoId"];
        [arr addObject:NM];
    }
    return arr;
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [objDateformat stringFromDate: date];
}
@end
