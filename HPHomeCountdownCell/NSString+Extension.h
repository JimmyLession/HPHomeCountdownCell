//
//  NSString+Extension.h
//  textsss
//
//  Created by 雷建民 on 16/11/18.
//  Copyright © 2016年 杭州后铺信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)

/**
 MD5加密
 
 @return 加密后的string
 */
- (NSString *)hp_toMD5;
/**
 日期转化为倒计时时间   如:2016-11-21 18:00:00 转化为 与当前时间的时间差

 @param timeString 需要转化的时间
 @return 返回时间差
 */
+(NSString *)stringToCurtDownString:(NSString *)timeString;

/**
 *  计算字符串高度 （多行）
 *
 *  @param width 字符串的宽度
 *  @param font  字体大小
 *
 *  @return 字符串的尺寸
 */
- (CGSize)heightWithWidth:(CGFloat)width andFont:(CGFloat)font;

/**
 *  计算字符串宽度
 *
 *  @param height 字符串的高度
 *  @param font  字体大小
 *
 *  @return 字符串的尺寸
 */
- (CGSize)widthWithHeight:(CGFloat)height andFont:(CGFloat)font;

/**
 计算字符串的尺寸

 @param font 字体大小
 @param maxSize 最大的尺寸
 @return 新的字符串尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 是否是手机号
 
 @param phone 手机号
 @return YES  or NO
 */
+ (BOOL)hp_isMobilePhone:(NSString *)phone;

/**
 是否是身份证号

 @param IDCard 身份证号
 @return YES  or NO
 */
+ (BOOL)hp_isIDCardPreson:(NSString *)IDCard;



@end
