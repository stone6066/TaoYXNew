//
//  LongExpressDeal.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/28.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "LongExpressDeal.h"

@implementation LongExpressDeal

//@property (nonatomic,copy)NSString *logEmpName;//名称
//@property (nonatomic,copy)NSString *line;//线路
//@property (nonatomic,copy)NSString *mobile;//移动电话
//@property (nonatomic,copy)NSString *address;//地址
//@property (nonatomic,copy)NSString *infoDesc;//详情

- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSDictionary *logEmp =[[NSDictionary alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    for (NSDictionary *dict in dictArray) {
        LongExpressDeal *md = [[LongExpressDeal alloc]init];
        
        md.line=[NSString stringWithFormat:@"%@--%@",[dict objectForKey:@"lineStart"],[dict objectForKey:@"lineEnd"]];
        md.logEmpName=[dict objectForKey:@"logEmpName"];
        if(![[dict objectForKey:@"logEmp"] isEqual:[NSNull null]]){
        logEmp = [dict objectForKey:@"logEmp"];
        md.mobile=[logEmp objectForKey:@"phone"];
        md.address=[logEmp objectForKey:@"address"];
        md.infoDesc=[logEmp objectForKey:@"memo"];
        }
        [arr addObject:md];
    }
    return arr;
}
@end
