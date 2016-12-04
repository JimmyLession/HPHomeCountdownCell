//
//  NSString+Extension.m
//  textsss
//
//  Created by 雷建民 on 16/11/18.
//  Copyright © 2016年 杭州后铺信息科技有限公司. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Extension)

+(NSString *)stringToCurtDownString:(NSString *)timeString;
{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:timeString];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
    
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    if (days<10) {
        dayStr = [NSString stringWithFormat:@"0%d",days];
    }else {
        dayStr = [NSString stringWithFormat:@"%d",days];
    }
    //小时
    if (hours<10) {
        hoursStr = [NSString stringWithFormat:@"0%d",hours];
    }else {
        hoursStr = [NSString stringWithFormat:@"%d",hours];
    }
    //分钟
    if(minutes<10){
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
}else{
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    }
    //秒
    if(seconds < 10){
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
} else{
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
}
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"已结束";
    }
    if (days) {
       return [NSString stringWithFormat:@"距结束%@:%@:%@:%@", dayStr,hoursStr, minutesStr,secondsStr];
    }
    if (hours) {
        return [NSString stringWithFormat:@"距结束%@:%@:%@:%@", dayStr,hoursStr, minutesStr,secondsStr];
        
    }
    if (minutes) {
        return [NSString stringWithFormat:@"距结束%@:%@:%@:%@", dayStr,hoursStr, minutesStr,secondsStr];
        
    }
    if (seconds) {
        return [NSString stringWithFormat:@"距结束%@天 %@小时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
        
    }
    return @"还没完？";
}




#pragma mark - 计算字符串尺寸
/**
 *  计算字符串高度 （多行）
 *
 *  @param width 字符串的宽度
 *  @param font  字体大小
 *
 *  @return 字符串的尺寸
 */
- (CGSize)heightWithWidth:(CGFloat)width andFont:(CGFloat)font
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize  size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)  options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)  attributes:attribute context:nil].size;
    return size;
}

/**
 *  计算字符串宽度
 *
 *  @param height 字符串的高度
 *  @param font  字体大小
 *
 *  @return 字符串的尺寸
 */
- (CGSize)widthWithHeight:(CGFloat)height andFont:(CGFloat)font
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize  size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)  options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)   attributes:attribute context:nil].size;
    return size;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


/**
 是否是手机号

 @param phone 手机号
 @return YES  or NO
 */
+ (BOOL)hp_isMobilePhone:(NSString *)phone
{
    NSString *pattern = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if ([mobilePredicate evaluateWithObject:phone]) {
        return YES;
    }
    
    return NO;
}

/**
 是否是身份证号
 
 @param IDCard 身份证号
 @return YES  or NO
 */
+ (BOOL)hp_isIDCardPreson:(NSString *)IDCard
{
    if (IDCard.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:IDCard]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[IDCard substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [IDCard substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
    
}

/**
 MD5加密

 @return 加密后的string
 */
- (NSString *)hp_toMD5 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}




@end
