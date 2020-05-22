//
//  BaseTools.h
//  清远驾培
//
//  Created by lzh_apple on 16/3/17.
//  Copyright © 2016年 XinNong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseTools : NSObject
+ (NSString *)sha1:(NSString *)str;
+ (NSString *)md5Hash:(NSString *)str;
+(BOOL)IsChinese:(NSString *)str;
+(long long)folderSize:(NSString*)folderPath;
+(NSString*)lzhEncode:(NSString*)str;
+(NSString*)lzhDecode:(NSString*)str;
+(NSString*)IntegerToString:(NSInteger)integer;

+(BOOL)checkForOnlyHaveNumber:(NSString*)text;
+(BOOL)checkForIsOneToTen:(NSString*)text;
@end
