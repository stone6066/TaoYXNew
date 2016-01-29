//
//  dealModel.m
//  团购项目
//
//  Created by lb on 15/7/20.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//

#import "dealModel.h"

@implementation dealModel


//- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
//    NSMutableArray *arr = [[NSMutableArray alloc]init];
//    NSArray *dictArray = [dict objectForKey:@"deals"];
//    for (NSDictionary *dict in dictArray) {
//        dealModel *md = [[dealModel alloc]init];
//        md.categories = dict[@"categories"];
//        md.city = dict[@"city"];
//        md.current_price = [dict[@"current_price"]stringValue];
//        md.deal_url = dict[@"deal_url"];
//        md.Description = dict[@"description"];
//        md.image_url = dict[@"image_url"];
//        //@"http://img-ta-01.b0.upaiyun.com/14383126145187714.jpg";//dict[@"image_url"];
//        md.s_image_url = dict[@"s_image_url"];
//        //@"http://img-ta-01.b0.upaiyun.com/14383126145187714.jpg";//dict[@"s_image_url"];
//        md.list_price = [dict[@"list_price"]stringValue];
//        md.purchase_deadline = dict[@"purchase_deadline"];
//        md.title = dict[@"title"];//@"伊丹蝶夏装雪纺衬衫";//
//        md.deal_id=dict[@"deal_id"];
//        
//        md.name=dict[@"name"];
//        //md.send_time=[dict[@"publish_date"]stringValue];
//        [arr addObject:md];
//    }
//    return arr;
//}

- (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    NSString *typeStr=[[NSString alloc]init];
    for (NSDictionary *dict in dictArray) {
        dealModel *md = [[dealModel alloc]init];
        md.title=[dict objectForKey:@"title"];
        md.name=[dict objectForKey:@"contact"];
        md.phone=[dict objectForKey:@"phone"];
        md.image_url=[dict objectForKey:@"images"];
        md.supplyDesc=[dict objectForKey:@"supplyDesc"];
    if(![[dict objectForKey:@"supplyType"] isEqual:[NSNull null]])
    {
        typeStr=[dict objectForKey:@"supplyType"];
        if ([typeStr isEqualToString: @"0"]) {
            md.supplyType=@"供应";
        }
        else
            md.supplyType=@"求购";
    }
        [arr addObject:md];
    }
    return arr;
}

-(NSMutableArray *)assignAdImgWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"ad_deals"];
    for (NSDictionary *dict in dictArray) {
        dealModel *md = [[dealModel alloc]init];
        md.AdImg = dict[@"ad_img"];
        [arr addObject:md];
    }
    return arr;
}

-(NSMutableArray *)assignAdTxtWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"ad_deals"];
    for (NSDictionary *dict in dictArray) {
        dealModel *md = [[dealModel alloc]init];
        md.AdImg = dict[@"ad_txt"];
        [arr addObject:md];
    }
    return arr;
}
-(NSMutableArray *)assignAdUrlWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"ad_deals"];
    for (NSDictionary *dict in dictArray) {
        dealModel *md = [[dealModel alloc]init];
        md.AdImg = dict[@"ad_url"];
        [arr addObject:md];
    }
    return arr;
}
@end
