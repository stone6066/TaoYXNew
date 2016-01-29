//
//  popView.m
//  团购项目
//
//  Created by lb on 15/5/27.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//

#import "popView.h"

@interface popView ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *leftTV;
@property (weak, nonatomic) IBOutlet UITableView *rightTV;

@property (nonatomic,assign) NSInteger selectRow;

@end

@implementation popView

+ (popView *)makePopView{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"popView" owner:self options:nil]firstObject];
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _leftTV) {
        
        return [self.dataSource numberOfRowsInLeftTable:self];
    }else{
        return [self.dataSource popView:self subDataForRow:_selectRow].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTV) {
        static NSString *str = @"Mycell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.textLabel.text =[self.dataSource popView:self titleForRow:indexPath.row];

        
        NSArray *subDataArray = [self.dataSource popView:self subDataForRow:indexPath.row];
        
        if (subDataArray.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
        
    }else{
        static NSString *str = @"Mycell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.textLabel.text =[self.dataSource popView:self subDataForRow:_selectRow][indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTV) {
        self.selectRow = indexPath.row;
        [_rightTV reloadData];
        
        //
        if ([self.delegate respondsToSelector:@selector(popView:didSelectRowAtLeftTable:)]) {
            //进一步实现
            [self.delegate popView:self didSelectRowAtLeftTable:indexPath.row];
        }
    }else{
        //
        if ([self.delegate respondsToSelector:@selector(popView:didSelectRowAtRightTable:)]) {
            //进一步实现
            [self.delegate popView:self didSelectRowAtRightTable:indexPath.row];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
