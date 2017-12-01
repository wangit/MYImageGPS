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

#import "MYGPSExif.h"
#import <ImageIO/ImageIO.h>
#include "AssetsLibrary/ALAssetsLibrary.h"
#include "AssetsLibrary/ALAssetRepresentation.h"
@interface MYGPSExif(){
    NSMutableDictionary *GPSDict;
    NSMutableDictionary *EXIFDictionary;
    NSMutableDictionary *TIFFDict;
}

@end
@implementation MYGPSExif
+ (void )assetURL:(NSURL*)url :(GPSExifInfo)Info{
    __block NSMutableDictionary *imageMetadata = nil;
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:url
             resultBlock:^(ALAsset *asset)  {
                 imageMetadata = [[NSMutableDictionary alloc] initWithDictionary:asset.defaultRepresentation.metadata];
                 
                 Info([[imageMetadata objectForKey:(NSString *)kCGImagePropertyExifDictionary]mutableCopy]);
             }
            failureBlock:^(NSError *error) {
            }];

    }
@end
