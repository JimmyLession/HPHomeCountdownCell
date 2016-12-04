//
//  HPHomePageViewModel.m
//  HouPu
//
//  Created by 雷建民 on 16/11/18.
//  Copyright © 2016年 杭州后铺信息科技有限公司. All rights reserved.
//

#import "HPHomePageViewModel.h"

@interface HPHomePageViewModel ()

@property(nonatomic,retain) dispatch_source_t timer;


@end

@implementation HPHomePageViewModel

/**
 一秒钟倒计时方法
 
 @param PER_SECBlock 倒计时回调
 */
- (void)countDownWithPER_SECBlock:(void (^)())PER_SECBlock
{
    if (_timer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                PER_SECBlock();
            });
        });
        dispatch_resume(_timer);
    }
}


- (NSMutableArray *)rushArray
{
    if (!_rushArray) {
        _rushArray = [NSMutableArray arrayWithObjects:
                      @"2016-12-01 18:01:00",
                      @"2016-12-02 19:02:59",
                      @"2016-12-03 20:03:58",
                      @"2016-12-04 21:04:57",
                      @"2016-12-05 22:05:56",
                      @"2016-12-06 23:06:55",
                      @"2016-12-07 00:07:54",
                      @"2016-12-08 00:08:53",
                      @"2016-12-09 01:09:52",
                      @"2016-12-10 02:10:51",
                      @"2016-12-11 03:11:50",nil];
    }
    return _rushArray;
}

@end
