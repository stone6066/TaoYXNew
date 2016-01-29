//
//  PricePlaceModel.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/25.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "PricePlaceModel.h"

@implementation PricePlaceModel
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    for (NSDictionary *dict in dictArray) {
        PricePlaceModel *md = [[PricePlaceModel alloc]init];
        md.title=[dict objectForKey:@"brandName"];
        md.areaName=[NSString stringWithFormat:@"产地：%@",[dict objectForKey:@"origin"]];
        
        if(![[dict objectForKey:@"priceId"] isEqual:[NSNull null]])
            md.priceId=[[dict objectForKey:@"priceId"]stringValue];
        md.price=[NSString stringWithFormat:@"价格：%@元/%@",[dict objectForKey:@"price"],[dict objectForKey:@"unit"]];
       
         if(![[dict objectForKey:@"createTime"] isEqual:[NSNull null]])
        md.publicTime=[self stdTimeToStr:[[dict objectForKey:@"createTime"]stringValue]];
        
        if(![[dict objectForKey:@"price"] isEqual:[NSNull null]])
        md.pricenum=[[dict objectForKey:@"price"]stringValue];
        
        md.unit=[dict objectForKey:@"unit"];
        
        [arr addObject:md];
    }
    return arr;
}




- (NSArray *)asignDetailModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
   
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
     {
        NSDictionary *dictArray = [dict objectForKey:@"data"];
        PricePlaceModel *md = [[PricePlaceModel alloc]init];
        md.title=[dictArray objectForKey:@"brandName"];
        md.areaName=[NSString stringWithFormat:@"产地：%@",[dictArray objectForKey:@"origin"]];
        md.empDesc=[dictArray objectForKey:@"priceDesc"];
        if(![[dictArray objectForKey:@"priceId"] isEqual:[NSNull null]])
            md.priceId=[[dictArray objectForKey:@"priceId"]stringValue];
        md.price=[NSString stringWithFormat:@"价格：%@元/%@",[dictArray objectForKey:@"price"],[dictArray objectForKey:@"unit"]];
        if(![[dictArray objectForKey:@"createTime"] isEqual:[NSNull null]])
            md.publicTime=[self stdTimeToStr:[[dictArray objectForKey:@"createTime"]stringValue]];
         if(![[dict objectForKey:@"price"] isEqual:[NSNull null]])
             md.pricenum=[[dictArray objectForKey:@"price"]stringValue];
         
        md.unit=[dictArray objectForKey:@"unit"];
         
         
        if(![[dictArray objectForKey:@"areaId"] isEqual:[NSNull null]])
        md.areaId=[[dictArray objectForKey:@"areaId"]stringValue];
         
        if(![[dictArray objectForKey:@"typeId"] isEqual:[NSNull null]])
        md.typeId=[[dictArray objectForKey:@"typeId"]stringValue];
         
        if(![[dictArray objectForKey:@"brandId"] isEqual:[NSNull null]])
        md.brandId=[[dictArray objectForKey:@"brandId"]stringValue];
         
        md.brandName=[dictArray objectForKey:@"brandName"];
        
        if(![[dictArray objectForKey:@"pubId"] isEqual:[NSNull null]])
        md.pubId=[[dictArray objectForKey:@"pubId"]stringValue];
        md.publisher=[dictArray objectForKey:@"publisher"];
        md.mareaName=[dictArray objectForKey:@"areaName"];
        md.origin=[dictArray objectForKey:@"origin"];
        md.typeName=[dictArray objectForKey:@"typeName"];
         
         
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
