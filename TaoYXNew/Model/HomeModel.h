//
//  HomeModel.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/31.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *imageurl;
@property (nonatomic,copy)NSString *dealurl;

- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
@end
