//
//  CategoriyModel.m
//  团购项目
//
//  Created by lb on 15/5/28.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//

#import "CategoriyModel.h"
#import "PublicDefine.h"

@implementation CategoriyModel

- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    //NSDictionary *dictArray = [dict objectForKey:@"data"];
    NSDictionary *typedict = [dict objectForKey:@"type"];
    
    CategoriyModel *md = [[CategoriyModel alloc]init];
   
    md.name = @"全部";
    md.dataid=@"0";
    [arr addObject:md];
    
    for (NSDictionary *dict in typedict) {
        CategoriyModel *md = [[CategoriyModel alloc]init];
        NSMutableDictionary *submd = [[NSMutableDictionary alloc]init];
        md.name = [dict objectForKey:@"typeName"];
        md.dataid=[[dict objectForKey:@"typeId"]stringValue];
        NSDictionary *subdict = [dict objectForKey:@"brands"];
        NSMutableArray *subarr = [[NSMutableArray alloc]init];
        if (subdict.count>0) {
            [submd setValue:@"全部" forKey:@"name"];
            [submd setValue:0 forKey:@"id"];
            [subarr addObject:submd];
        }
        for (NSDictionary *mydict in subdict)
        {
            [subarr addObject:mydict];
        }
        md.subcategories =subarr;//[dict objectForKey:@"brands"];
        //[dict objectForKey:@"brands"];
        [arr addObject:md];
    }
    return arr;
}

-(NSDictionary*)readTypeInfo{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDictionary * NSUserDefaults = [user objectForKey:NSUserTypeData];
    return NSUserDefaults;
}
//加载plist文件
- (NSArray *)loadPlistData:(NSInteger)datatype{
    //获取plist文件地址
    NSString *file;
    if (0==datatype) {
         file = [[NSBundle mainBundle]pathForResource:@"cities.plist" ofType:nil];
        NSArray *plistArray = [NSArray arrayWithContentsOfFile:file];
        NSArray *dataArray = [self getDataWithArray:plistArray];
        return dataArray;
    }
    else
    {
        return [self asignModelWithDict:[self readTypeInfo]];
    }
    //加载plist为数组
   
}

//字典转模型
- (CategoriyModel *)makeModelWithDict:(NSDictionary *)dict{
    self.name = [dict objectForKey:@"name"];
    self.subcategories = [dict objectForKey:@"subcategories"];
    return self;
}

//解析
- (NSArray *)getDataWithArray:(NSArray *)array{
    NSMutableArray *Arr = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in array) {
        CategoriyModel *md = [[CategoriyModel alloc]init];
        [md makeModelWithDict:dict];
        [Arr addObject:md];
    }
    return Arr;
}

@end
