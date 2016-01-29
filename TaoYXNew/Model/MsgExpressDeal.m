//
//  MsgExpressDeal.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/7.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MsgExpressDeal.h"


@implementation MsgExpressDeal
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSDictionary *dictArray = [dict objectForKey:@"data"];
    NSString *typeStr=[[NSString alloc]init];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
    MsgExpressDeal *md = [[MsgExpressDeal alloc]init];
    md.goodsVolume=[dictArray objectForKey:@"goodsVolume"];
    md.vehicleLength=[dictArray objectForKey:@"vehicleLength"];
    md.startCounty=[dictArray objectForKey:@"startCounty"];
    md.vehicleType=[dictArray objectForKey:@"vehicleType"];
    md.goodsWeight=[dictArray objectForKey:@"goodsWeight"];
    md.endProvicen=[dictArray objectForKey:@"endProvicen"];
    typeStr=[dictArray objectForKey:@"logInfoType"];
    if ([typeStr isEqualToString: @"0"]) {
        md.logInfoType=@"货源";
    }
    else
        md.logInfoType=@"车源";
     md.logInfoDesc=[dictArray objectForKey:@"logInfoDesc"];
     md.startProvince=[dictArray objectForKey:@"startProvince"];
     md.vehicleLoad=[dictArray objectForKey:@"vehicleLoad"];
    if(![[dictArray objectForKey:@"sendTime"] isEqual:[NSNull null]])
        md.sendTime=[self stdTimeToStr:[[dictArray objectForKey:@"sendTime"]stringValue]];
     md.startCity=[dictArray objectForKey:@"startCity"];
     md.endCity=[dictArray objectForKey:@"endCity"];
     md.endCounty=[dictArray objectForKey:@"endCounty"];
     md.logInfoId=[[dictArray objectForKey:@"logInfoId"]stringValue];
     md.telphone=[dictArray objectForKey:@"telphone"];
     md.carCode=[dictArray objectForKey:@"carCode"];
     md.goodsType=[dictArray objectForKey:@"goodsType"];
     md.goodsName=[dictArray objectForKey:@"goodsName"];
    if(![[dictArray objectForKey:@"createTime"] isEqual:[NSNull null]])
     md.createTime=[self stdTimeToStr:[[dictArray objectForKey:@"createTime"]stringValue]];
    
     md.customerName=[dictArray objectForKey:@"customerName"];
    
    [arr addObject:md];
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
