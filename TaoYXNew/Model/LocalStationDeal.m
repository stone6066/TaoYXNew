//
//  LocalStationDeal.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/28.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "LocalStationDeal.h"

@implementation LocalStationDeal


- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSDictionary *logEmp =[[NSDictionary alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    for (NSDictionary *dict in dictArray) {
        LocalStationDeal *md = [[LocalStationDeal alloc]init];
        md.logEmpName=[dict objectForKey:@"logEmpName"];
        md.business=[dict objectForKey:@"business"];
        
        
        if(![[dict objectForKey:@"logEmp"] isEqual:[NSNull null]]){
            logEmp = [dict objectForKey:@"logEmp"];
            md.mobile=[logEmp objectForKey:@"phone"];
            md.address=[logEmp objectForKey:@"address"];
            md.infoDesc=[logEmp objectForKey:@"memo"];
        }
        
        //infoDesc
        //NSLog(@"%@",logEmp);
        [arr addObject:md];
    }
    return arr;
}

@end
