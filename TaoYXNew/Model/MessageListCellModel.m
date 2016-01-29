//
//  MessageListCellModel.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MessageListCellModel.h"



@implementation MessageListCellModel
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    if(![[dict objectForKey:@"data"] isEqual:[NSNull null]])
    {
        
        for (NSDictionary *dict in dictArray) {
            MessageListCellModel *NM=[[MessageListCellModel alloc]init];
            NM.msgId = [dict[@"detailId"]stringValue];
            NM.msgType = dict[@"type"];
            if(![[dict objectForKey:@"closingdate"] isEqual:[NSNull null]])
                NM.closingdate=[self stdTimeToStr:[[dict objectForKey:@"closingdate"]stringValue]];
            
            if(![[dict objectForKey:@"createtime"] isEqual:[NSNull null]])
                NM.createtime=[self stdTimeToStr:[[dict objectForKey:@"createtime"]stringValue]];
            NM.area=dict[@"area"];
            NM.detailId=[dict[@"detailId"]stringValue];
            if(![[dict objectForKey:@"title"] isEqual:[NSNull null]])
                NM.describe=dict[@"title"];
            else
                NM.describe=@"标题为空";
            [arr addObject:NM];
        }
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
