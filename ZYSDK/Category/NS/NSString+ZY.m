//
//  NSString+ZY.m
//  ZYSDK
//
//  Created by guozengying on 2017/2/21.
//  Copyright © 2017年 gzy. All rights reserved.
//

#import "NSString+ZY.h"
#import <CommonCrypto/CommonDigest.h>
#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)
@implementation NSString (ZY)

// 😀😉😌😰😂 Emoji start
+ (NSString *)emojiWithIntCode:(int)intCode {
    int symbol = EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar) intCode];
    }
    return string;
}

- (NSString *)emoji {
    return [NSString emojiWithStringCode:self];
}

+ (NSString *)emojiWithStringCode:(NSString *)stringCode {
    char *charCode = (char *) stringCode.UTF8String;
    int intCode = (int) strtol(charCode, NULL, 16);
    return [self emojiWithIntCode:intCode];
}

// 判断是否是 emoji表情
- (BOOL)isEmoji {
    BOOL returnValue = NO;
    
    const unichar hs = [self characterAtIndex:0];
    // surrogate pair
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                returnValue = YES;
            }
        }
    } else if (self.length > 1) {
        const unichar ls = [self characterAtIndex:1];
        if (ls == 0x20e3) {
            returnValue = YES;
        }
    } else {
        // non surrogate
        if (0x2100 <= hs && hs <= 0x27ff) {
            returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            returnValue = YES;
        }
    }
    
    return returnValue;
}
// 😀😉😌😰😂 Emoji end

/**
 *  得到文字和字体就能计算文字尺寸
 *
 *  @param font    文字的字体
 *  @param maxW     最大的宽度
 *
 *  @return szie
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
//返回字符串所占用的尺寸
- (CGRect)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
}
- (CGSize)sizeWithFont:(UIFont *)font {
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

//适合的高度 默认 systemFontOfSize:font
- (CGFloat)heightWithFont:(NSInteger)font w:(CGFloat)w {
    
    
    return [self boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:font] } context:nil].size.height;
}
- (CGFloat)heightWithFont:(NSInteger)font w:(CGFloat)w lineSpace:(CGFloat)space {
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = space;
    return [self boundingRectWithSize:CGSizeMake(w,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSParagraphStyleAttributeName:style} context:nil].size.height;
}

//适合的宽度 默认 systemFontOfSize:font
- (CGFloat)widthWithFont:(NSInteger)font h:(CGFloat)h {
    //    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, h) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:font] } context:nil].size.width;
    return [self  boundingRectWithSize:CGSizeMake(0, h) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName] context:nil].size.width;
}

//去空格
- (NSString *)delSpace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
//去空格
- (NSString *)delBlank {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//时间戳对应的NSDate
- (NSDate *)date {
    return [NSDate dateWithTimeIntervalSince1970:self.floatValue];
}

static NSDateFormatter *YYYYMMddHHmmss;
//YYYY-MM-dd HH:mm:ss对应的NSDate
- (NSDate *)date__YMdHMS {
    if (!YYYYMMddHHmmss) {
        YYYYMMddHHmmss = [[NSDateFormatter alloc] init];
        [YYYYMMddHHmmss setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    return [YYYYMMddHHmmss dateFromString:self];
}

static NSDateFormatter *YYYYMMdd;
//YYYY-MM-dd 对应的NSDate
- (NSDate *)date__YMd {
    if (!YYYYMMdd) {
        YYYYMMdd = [[NSDateFormatter alloc] init];
        [YYYYMMdd setDateFormat:@"YYYY-MM-dd"];
    }
    return [YYYYMMdd dateFromString:self];
}
static NSDateFormatter *YYYYMMddDot;
- (NSDate *)date__YMd_Dot {
    if (!YYYYMMddDot) {
        YYYYMMddDot = [[NSDateFormatter alloc] init];
        [YYYYMMddDot setDateFormat:@"YYYY.MM.dd"];
    }
    return [YYYYMMddDot dateFromString:self];
}

//转为 Data
- (NSData *)data {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
//转为 base64string后的Data
- (NSData *)base64Data {
    return [[NSData alloc] initWithBase64EncodedString:self options:0];
}
// 转为 base64String
- (NSString *)base64Str {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
//解 base64为Str 解不了就返回原始的数值
- (NSString *)decodeBase64 {
    NSString *WillDecode = [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:self options:0] encoding:NSUTF8StringEncoding];
    return (WillDecode.length != 0) ? WillDecode : self;
}
// 解 为字典 if 有
- (NSDictionary *)jsonDic {
    return [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
}
// 解 为数组 if 有
- (NSArray *)jsonArr {
    return [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
}
//按字符串的，逗号分割为数组
- (NSArray *)combinArr {
    if ([self hasSuffix:@","]) {
        return [[self substringToIndex:self.length - 1] componentsSeparatedByString:@","];
    }
    return [self componentsSeparatedByString:@","];
}

#pragma mark -

//是否包含对应字符
- (BOOL)containStr:(NSString *)subString {
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}
//拼上字符串
- (NSString *)addStr:(NSString *)string {
    if (!string || string.length == 0) {
        return self;
    }
    return [self stringByAppendingString:string];
}
- (NSString *)addInt:(int)string {
    return [self stringByAppendingString:@(string).stringValue];
}
//32位MD5加密
- (NSString *)MD5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG) strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return [result copy];
}
//SHA1加密
- (NSString *)SHA1 {
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG) data.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return [result copy];
}



-(NSString*)encodeString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

//URLDEcode
-(NSString *)decodeString

{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)self,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}




- (UIImage *)qrCode {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //    NSLog(@"filterAttributes:%@", filter.attributes);
    
    [filter setDefaults];
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];
    
    CIContext *context1 = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context1 createCGImage:outputImage
                                        fromRect:[outputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage
                                         scale:1
                                   orientation:UIImageOrientationUp];
    
    //    CGFloat width = image.size.width * resize;
    //    CGFloat height = image.size.height * resize;
    //
    //    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    //    CGContextRef context2 = UIGraphicsGetCurrentContext();
    //    CGContextSetInterpolationQuality(context2, kCGInterpolationNone);
    //    [image drawInRect:CGRectMake(0, 0, width, height)];
    //    image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    return image;
}

#pragma mark -

//是否中文
- (BOOL)isChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
//计算字符串长度 1中文2字符
- (int)textLength {
    float number = 0.0;
    for (int index = 0; index < [self length]; index++) {
        NSString *character = [self substringWithRange:NSMakeRange(index, 1)];
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3) {
            number = number + 2;
        } else {
            number = number + 1;
        }
    }
    return ceil(number);
}
//限制最大显示长度
- (NSString *)limitMaxTextShow:(NSInteger)limit {
    NSString *Orgin = [self copy];
    for (NSInteger i = Orgin.length; i > 0; i--) {
        NSString *Get = [Orgin substringToIndex:i];
        if (Get.textLength <= limit) {
            return Get;
        }
    }
    return self;
}
/**截取 . 之前的字符*/
- (NSString *)ZYSubstringWithPriceString:(NSString *)price{
    NSRange range = [price rangeOfString:@"."];
    return [price substringToIndex:range.location];
}

- (BOOL)isEmpty{
    
    if ([self isEqualToString:@"(null)"]) {
        return YES;
    }
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
//邮箱格式验证
- (BOOL)isValidEmail {
    //    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    //    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    //    return [emailTest evaluateWithObject:self];
    if([self rangeOfString:@"@"].location !=NSNotFound){
        return YES;
    }
    else{
        return NO;
    }
}

//手机号格式验证
- (BOOL)isValidPhone{
    NSString * phoneRegex = @"1[3|4|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
//手机号/电话号验证
- (BOOL)validateContactNumber{
    if (self.length < 10)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    /**
     25     * 大陆地区固话及小灵通
     26     * 区号：010,020,021,022,023,024,025,027,028,029
     27     * 号码：七位或八位
     28     */
    NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate * regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate * regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate * regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate * regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate * regextestM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES)
        || ([regextestM evaluateWithObject:self] == YES )){
        return YES;
    }
    else{
        return NO;
    }
}
//身份证验证
- (BOOL)isValidID{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
    //    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    //    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //    return [identityCardPredicate evaluateWithObject:self];
    
    /*
     //长度不为18的都排除掉
     if (self.length!=18) {
     return NO;
     }
     //校验格式
     NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
     NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
     BOOL flag = [identityCardPredicate evaluateWithObject:self];
     
     if (!flag) {
     return flag;    //格式错误
     }else {
     //格式正确在判断是否合法
     //将前17位加权因子保存在数组里
     NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
     
     //这是除以11后，可能产生的11位余数、验证码，也保存成数组
     NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
     
     //用来保存前17位各自乖以加权因子后的总和
     NSInteger idCardWiSum = 0;
     for(int i = 0;i < 17;i++){
     NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
     NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
     
     idCardWiSum+= subStrIndex * idCardWiIndex;
     }
     //计算出校验码所在数组的位置
     NSInteger idCardMod=idCardWiSum%11;
     
     //得到最后一位身份证号码
     NSString * idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
     
     //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
     if(idCardMod==2){
     if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
     return YES;
     }else{
     return NO;
     }
     }else{
     //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
     if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]){
     return YES;
     }
     else{
     return NO;
     }
     }
     }
     */
}
- (BOOL)isValidBankNum{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[self length];
    int lastNum = [[self substringFromIndex:cardNoLength-1] intValue];
    
    NSString * cardNo = [self substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

//验证是否ASCII码
- (BOOL)isASCII {
    NSCharacterSet *cs;
    cs = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@／:;（）¥「」!,.?<>£＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\"/"
          ""];
    NSRange specialrang = [self rangeOfCharacterFromSet:cs];
    if (specialrang.location != NSNotFound) {
        return YES;
    }
    return NO;
}

//验证是含本方法定义的 “特殊字符”
- (BOOL)isSpecialCharacter {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／:;（）¥「」!,.?<>£＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\"/"
                           ""];
    NSRange specialrang = [self rangeOfCharacterFromSet:set];
    if (specialrang.location != NSNotFound) {
        return YES;
    }
    return NO;
}

// 验证是否是数字
- (BOOL)isNumber {
    NSCharacterSet *cs;
    cs = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSRange specialrang = [self rangeOfCharacterFromSet:cs];
    if (specialrang.location != NSNotFound) {
        return YES;
    }
    return NO;
}

// 验证字符串里面是否都是数字
- (BOOL)isPureNumber {
    NSUInteger length = [self length];
    for (float i = 0; i < length; i++) {
        // NSString * c=[mytimestr characterAtIndex:i];
        NSString *STR = [self substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"%@", STR);
        if ([STR isNumber]) {
            continue;
        } else {
            return NO;
        }
    }
    return YES;
}

//是否是纯数字 这里可以有小数点
- (BOOL)isFloat {
    NSUInteger length = [self length];
    for (float i = 0; i < length; i++) {
        // NSString * c=[mytimestr characterAtIndex:i];
        NSString *STR = [self substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"%@", STR);
        if ([STR isNumber] || [STR isEqualToString:@"."]) {
            continue;
        } else {
            return NO;
        }
    }
    return YES;
}

//去掉 表情符号
- (NSString *)disableEmoji {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return modifiedString;
}

+ (NSString *)UUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
    
    CFRelease(uuidRef);
    
    return (__bridge_transfer NSString *) uuid;
}
+ (NSString *)systemVersion{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}


@end

@implementation NSDictionary (WT)

//字典 转为 JsonStr
- (NSString *)jsonStr {
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:0 error:NULL] encoding:NSUTF8StringEncoding];
}


@end

