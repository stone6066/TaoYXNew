//
//  MsgPopModel.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MsgPopModel.h"
#import "PublicDefine.h"
@implementation MsgPopModel

- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    //NSDictionary *dictArray = [dict objectForKey:@"data"];
    NSDictionary *typedict = [dict objectForKey:@"type"];
    
    for (NSDictionary *dict in typedict) {
        MsgPopModel *md = [[MsgPopModel alloc]init];
        //NSMutableDictionary *submd = [[NSMutableDictionary alloc]init];
        md.name = [dict objectForKey:@"typeName"];
        md.dataid=[[dict objectForKey:@"typeId"]stringValue];
        NSDictionary *subdict = [dict objectForKey:@"brands"];
        NSMutableArray *subarr = [[NSMutableArray alloc]init];
        
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
        file = [[NSBundle mainBundle]pathForResource:@"msgCities.plist" ofType:nil];
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
- (MsgPopModel *)makeModelWithDict:(NSDictionary *)dict{
    self.name = [dict objectForKey:@"name"];
    self.subcategories = [dict objectForKey:@"subcategories"];
    return self;
}

//解析
- (NSArray *)getDataWithArray:(NSArray *)array{
    NSMutableArray *Arr = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in array) {
        MsgPopModel *md = [[MsgPopModel alloc]init];
        [md makeModelWithDict:dict];
        [Arr addObject:md];
    }
    return Arr;
}

@end
