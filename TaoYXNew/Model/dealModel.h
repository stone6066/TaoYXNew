//
//  dealModel.h
//  团购项目
//
//  Created by lb on 15/7/20.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dealModel : NSObject

// 商品分类
@property (nonatomic,copy)NSString *categories;
//所在城市
@property (nonatomic,copy)NSString *city;
//价格
@property (nonatomic,copy)NSString *current_price;
//h5
@property (nonatomic,copy)NSString *deal_h5_url;
//deal_url
@property (nonatomic,copy)NSString *deal_url;
//description
@property (nonatomic,copy)NSString *Description;
//image_url
@property (nonatomic,copy)NSString *image_url;
//s_image_url
@property (nonatomic,copy)NSString *s_image_url;
//list_price
@property (nonatomic,copy)NSString *list_price;
//purchase_deadline
@property (nonatomic,copy)NSString *purchase_deadline;
//title
@property (nonatomic,copy)NSString *title;
//deal_id
@property (nonatomic,copy)NSString *deal_id;
//name
@property (nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *send_time;

@property (nonatomic,copy)NSString *phone;

@property (nonatomic,copy)NSString *supplyType;

@property (nonatomic,copy)NSString *supplyDesc;


@property(nonatomic,copy)NSString *AdUrl;

@property(nonatomic,copy)NSString *AdTxt;

@property(nonatomic,copy)NSString *AdImg;
- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
//- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
-(NSMutableArray *)assignAdImgWithDict:(NSDictionary *)dict;
-(NSMutableArray *)assignAdTxtWithDict:(NSDictionary *)dict;
-(NSMutableArray *)assignAdUrlWithDict:(NSDictionary *)dict;

@end
