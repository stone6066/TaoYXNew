//
//  CmpModel.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/24.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "CmpModel.h"

@implementation CmpModel
- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    for (NSDictionary *dict in dictArray) {
        CmpModel *md = [[CmpModel alloc]init];
        md.empName=[dict objectForKey:@"empName"];
        md.areaName=[dict objectForKey:@"areaName"];
        md.contact=[dict objectForKey:@"contact"];
        md.images=[dict objectForKey:@"images"];
        md.empDesc=[dict objectForKey:@"empDesc"];
        md.phone=[dict objectForKey:@"phone"];
        md.mobile=[dict objectForKey:@"mobile"];
        md.address=[dict objectForKey:@"address"];
        if(![[dict objectForKey:@"empId"] isEqual:[NSNull null]])
            md.empId=[[dict objectForKey:@"empId"]stringValue];
        [arr addObject:md];
    }
    return arr;
}

- (NSArray *)asignDetailModelWithDict:(NSDictionary *)mydict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSDictionary *dict = [mydict objectForKey:@"data"];
    if(![[mydict objectForKey:@"data"] isEqual:[NSNull null]])
     {
        CmpModel *md = [[CmpModel alloc]init];
        md.empName=[dict objectForKey:@"empName"];
        md.areaName=[dict objectForKey:@"areaName"];
        md.contact=[dict objectForKey:@"contact"];
        md.images=[dict objectForKey:@"images"];
        md.empDesc=[dict objectForKey:@"empDesc"];
        md.phone=[dict objectForKey:@"phone"];
        md.mobile=[dict objectForKey:@"mobile"];
        md.address=[dict objectForKey:@"address"];
        if(![[dict objectForKey:@"empId"] isEqual:[NSNull null]])
            md.empId=[[dict objectForKey:@"empId"]stringValue];
        if(![[dict objectForKey:@"areaId"] isEqual:[NSNull null]])
             md.areaId=[[dict objectForKey:@"areaId"]stringValue];
         md.fax=[dict objectForKey:@"fax"];
        [arr addObject:md];
    }
    return arr;
}

@end
