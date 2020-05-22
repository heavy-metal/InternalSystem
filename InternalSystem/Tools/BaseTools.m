//
//  BaseTools.m
//  清远驾培
//
//  Created by lzh_apple on 16/3/17.
//  Copyright © 2016年 XinNong. All rights reserved.
//

#import "BaseTools.h"
#import <CommonCrypto/CommonDigest.h>
#define kNUMINSERT @"1234567890"
@implementation BaseTools
#pragma mark --- sha1 md5 加密
+ (NSString *)sha1:(NSString *)str {
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes,(unsigned int) data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

+ (NSString *)md5Hash:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    NSString *md5Result = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return md5Result;
}
#pragma mark --- 获取文件夹的大小
+(long long)folderSize:(NSString *)folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
//       NSLog(@"文件夹里面没有文件");
        return 0;
    }else{
        NSEnumerator * childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
        NSString * fileName ;
        long long folderSize = 0;
        while (fileName = [childFilesEnumerator nextObject]) {
            NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            long long fileSize = [[self alloc] fileSizeAtPath:fileAbsolutePath];
            folderSize += fileSize;
        }
        return folderSize;
    }

}
-(long long)fileSizeAtPath:(NSString*)fileAbsolutePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:fileAbsolutePath]) {
        return [[manager attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
    }
    return 0;
}
#pragma mark --判断是否有中文
+(BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
        
    }
    return NO;
    
}
#pragma mark --- 加密算法
+(NSString*)lzhEncode:(NSString*)str{
    NSRange  range = NSMakeRange(1, 2);
    NSString* strSubIndex =  [str substringWithRange:range];
    return   [str stringByAppendingString:strSubIndex];
}
+(NSString*)lzhDecode:(NSString*)str{
    return  [str substringToIndex:str.length-2];
    
}
#pragma mark ---NSInteger 转NSString
+(NSString*)IntegerToString:(NSInteger)integer{
    return [NSString stringWithFormat:@"%lu",(unsigned long)integer];
}

+(BOOL)checkForOnlyHaveNumber:(NSString*)text{
   
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:kNUMINSERT] invertedSet];
        
        
        NSString *filtered = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        //按cs分离出数组,componentsJoinedByString 代表数组里面的每个字符串，后面增加“” 形成新的字符串，然后在把数组里面的所有字符串穿起来形成新的字符串，数组按@""组合出字符串
        BOOL canChange = [text isEqualToString:filtered];
    return canChange;
}
+(BOOL)checkForIsOneToTen:(NSString*)text{
    NSArray * array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    if ([array containsObject:text]) {
        return YES;
    }else{
        return NO;
    }
}
@end
