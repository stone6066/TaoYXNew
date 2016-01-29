//
//  ViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/7.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AOScrollerView.h"

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,ValueClickDelegate>
{
    AOScrollerView *_myheaderView;
    UIView *_mySeparateView;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)NSInteger VersionType;//1城市版，0农村版
@property(nonatomic,strong)UILabel *cityLbl;
@property(nonatomic,strong)UIImageView *cityView;
@property(nonatomic,strong)UIImageView *dropDown;
@property(nonatomic,strong)UILabel *verTypeLbl;
@property(nonatomic,strong)UIButton *topBtn;
@property(nonatomic,strong)UILabel *myViewTitle;

-(void)setcitylblText:(NSString*)txt;
@end

