//
//  InternationExpDeal.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/28.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "InternationExpDeal.h"

@implementation InternationExpDeal
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSDictionary *logEmp =[[NSDictionary alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    for (NSDictionary *dict in dictArray) {
        InternationExpDeal *md = [[InternationExpDeal alloc]init];
        
        md.line=[dict objectForKey:@"foreignCountry"];
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
