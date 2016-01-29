//
//  CarExpressDeal.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/28.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "CarExpressDeal.h"


@implementation CarExpressDeal
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
    for (NSDictionary *dict in dictArray) {
        CarExpressDeal *md = [[CarExpressDeal alloc]init];
        md.startProvince=[dict objectForKey:@"startProvince"];
        md.startCity=[dict objectForKey:@"startCity"];
        md.startCounty=[dict objectForKey:@"startCounty"];
        
        md.endProvicen=[dict objectForKey:@"endProvicen"];
        md.endCity=[dict objectForKey:@"endCity"];
        md.endCounty=[dict objectForKey:@"endCounty"];
        
        md.contact=[dict objectForKey:@"customerName"];
        md.mobile=[dict objectForKey:@"telphone"];
        md.goodsName=[dict objectForKey:@"goodsName"];
        
       // md.publicTime=[[dict objectForKey:@"createTime"]stringValue];
         if(![[dict objectForKey:@"sendTime"] isEqual:[NSNull null]])
        md.publicTime=[self stdTimeToStr:[[dict objectForKey:@"sendTime"]stringValue]];
        md.infoDesc=[dict objectForKey:@"logInfoDesc"];
        md.carCode=[dict objectForKey:@"carCode"];
        md.expId=[dict objectForKey:@"logInfoId"];
        md.logInfoType=[dict objectForKey:@"logInfoType"];
        md.vehicleType=[dict objectForKey:@"vehicleType"];
        md.vehicleLength=[dict objectForKey:@"vehicleLength"];
        md.vehicleLoad=[dict objectForKey:@"vehicleLoad"];
        [arr addObject:md];
    }
    }
    return arr;
}

- (NSArray *)asignDetailModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSDictionary *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
     {
        CarExpressDeal *md = [[CarExpressDeal alloc]init];
        md.startProvince=[dictArray objectForKey:@"startProvince"];
        md.startCity=[dictArray objectForKey:@"startCity"];
        md.startCounty=[dictArray objectForKey:@"startCounty"];
        
        md.endProvicen=[dictArray objectForKey:@"endProvicen"];
        md.endCity=[dictArray objectForKey:@"endCity"];
        md.endCounty=[dictArray objectForKey:@"endCounty"];
        
        md.contact=[dictArray objectForKey:@"customerName"];
        md.mobile=[dictArray objectForKey:@"telphone"];
        md.goodsName=[dictArray objectForKey:@"goodsName"];
        md.goodsType=[dictArray objectForKey:@"goodsType"]; 
        // md.publicTime=[[dict objectForKey:@"createTime"]stringValue];
        if(![[dictArray objectForKey:@"sendTime"] isEqual:[NSNull null]])
            md.publicTime=[self stdTimeToStr:[[dictArray objectForKey:@"sendTime"]stringValue]];
        md.infoDesc=[dictArray objectForKey:@"logInfoDesc"];
        md.carCode=[dictArray objectForKey:@"carCode"];
        md.expId=[dictArray objectForKey:@"logInfoId"];
        md.logInfoType=[dictArray objectForKey:@"logInfoType"];
        md.vehicleType=[dictArray objectForKey:@"vehicleType"];
        
        if(![[dictArray objectForKey:@"vehicleLength"] isEqual:[NSNull null]])
            md.vehicleLength=[[dictArray objectForKey:@"vehicleLength"]stringValue];
        if(![[dictArray objectForKey:@"vehicleLoad"] isEqual:[NSNull null]])
            md.vehicleLoad=[[dictArray objectForKey:@"vehicleLoad"]stringValue];
        if(![[dictArray objectForKey:@"goodsVolume"] isEqual:[NSNull null]])
            md.goodsVolume=[[dictArray objectForKey:@"goodsVolume"]stringValue];
        if(![[dictArray objectForKey:@"goodsWeight"] isEqual:[NSNull null]])
            md.goodsWeight=[[dictArray objectForKey:@"goodsWeight"]stringValue];
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
