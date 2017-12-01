/*
 * 　┏┓　　　┏┓
 *┏┛┻━━━┛┻┓
 *┃　　　　　　　┃
 *┃　　　━　　　┃
 *┃　┳┛　┗┳　┃
 *┃　　　　　　　┃
 *┃　　　┻　　　┃
 *┃　　　　　　　┃
 *┗━┓　　　┏━┛
 *　　┃　　　┃神兽保佑
 *　　┃　　　┃代码无BUG！
 *　　┃　　　┗━━━┓
 *　　┃　　　　　　　┣┓
 *　　┃　　　　　　　┏┛
 *　　┗┓┓┏━┳┓┏┛
 *　　　┃┫┫　┃┫┫
 *　　　┗┻┛　┗┻┛
 *
 */
//  Created by 甲和灯 on 2017/3/23.
//  Github： https://github.com/wangit
//  简书：http://www.jianshu.com/users/221f350cb0f3/timeline

#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>
typedef void(^GPSExifInfo)(NSDictionary *info);

@interface MYGPSExif : NSObject

+ (void )assetURL:(NSURL*)url :(GPSExifInfo)Info;


@end
