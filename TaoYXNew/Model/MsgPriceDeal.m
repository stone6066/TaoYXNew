//
//  MsgPriceDeal.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/7.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//
//"typeName":"蔬菜",
//"origin":"宁夏银川",
//"areaName":"灵武市",
//"brandName":"青椒",
//"typeId":1,
//"brandId":2,
//"pubId":null,
//"publisher":"管理员",
//"priceDesc":"<p>青椒价格10元/斤</p>",
//"price":10,
//"unit":"斤",
//"areaId":10,
//"priceId":3,
//"createTime":1451377774000

#import "MsgPriceDeal.h"

@implementation MsgPriceDeal
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSDictionary *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
    MsgPriceDeal *md = [[MsgPriceDeal alloc]init];
    md.typeName=[dictArray objectForKey:@"typeName"];
    md.origin=[dictArray objectForKey:@"origin"];
    md.areaName=[dictArray objectForKey:@"areaName"];
    md.brandName=[dictArray objectForKey:@"brandName"];
    md.typeId=[dictArray objectForKey:@"typeId"];
    md.brandId=[dictArray objectForKey:@"brandId"];
    md.pubId=[dictArray objectForKey:@"pubId"];
    md.publisher=[dictArray objectForKey:@"publisher"];
    md.priceDesc=[dictArray objectForKey:@"priceDesc"];
    md.price=[dictArray objectForKey:@"price"];
    md.unit=[dictArray objectForKey:@"unit"];
    md.areaId=[dictArray objectForKey:@"areaId"];
    md.priceId=[dictArray objectForKey:@"priceId"];
   if(![[dictArray objectForKey:@"createTime"] isEqual:[NSNull null]])
    md.createTime=[self stdTimeToStr:[[dictArray objectForKey:@"createTime"]stringValue]];
    
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
