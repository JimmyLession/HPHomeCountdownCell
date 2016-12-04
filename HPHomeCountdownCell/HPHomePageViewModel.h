//
//  HPHomePageViewModel.h
//  HouPu
//
//  Created by 雷建民 on 16/11/18.
//  Copyright © 2016年 杭州后铺信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPHomePageViewModel : NSObject


@property (nonatomic ,strong)NSMutableArray *rushArray;


/**
 一秒钟倒计时方法
 
 @param PER_SECBlock 倒计时回调
 */
- (void)countDownWithPER_SECBlock:(void (^)())PER_SECBlock;

@end
