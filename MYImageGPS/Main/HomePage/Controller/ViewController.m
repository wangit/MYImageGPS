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

#import "ViewController.h"
#import "MYAdressViewController.h"
#import <ImageIO/ImageIO.h>
#include "AssetsLibrary/ALAssetsLibrary.h"
#include "AssetsLibrary/ALAssetRepresentation.h"
#import "MYInformationImageViewController.h"
#import "MYGPSExif.h"

#ifdef DEBUG
#define GPSLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define GPSLog(format, ...)
#endif
@interface ViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>{
    NSMutableDictionary *GPSDict;
    NSMutableDictionary *EXIFDictionary;
    NSMutableDictionary *TIFFDict;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageSelect;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)imageSelect:(id)sender {
    [self callActionSheetFunc];
    
}
- (IBAction)adressSelect:(id)sender {
    
    MYAdressViewController *adressSelect  = [[MYAdressViewController alloc]init];
    [self presentViewController:adressSelect animated:YES completion:nil];
    
}

/**
 @ 调用ActionSheet
 */
- (void)callActionSheetFunc{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择",  nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",  nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 2) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}
- (NSMutableDictionary *)getExifInfoWithImageData:(NSData *)imageData{
    CGImageSourceRef cImageSource = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    NSDictionary *dict =  (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(cImageSource, 0, NULL));
    NSMutableDictionary *dictInfo = [NSMutableDictionary dictionaryWithDictionary:dict];
    return dictInfo;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];

    NSLog(@"%@",info);
    NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    NSDictionary * assetMetadata= [info objectForKey:UIImagePickerControllerMediaMetadata];
    UIImage * assetImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.headImage setContentMode:UIViewContentModeScaleAspectFill];
    
    self.headImage.clipsToBounds = YES;
    self.headImage.image = assetImage;
    [MYGPSExif assetURL:assetURL :^(NSDictionary *info) {
        NSLog(@"%@",info);
    }];

/*
    //NSLog(@"%@",assetMetadata);

    __block NSMutableDictionary *imageMetadata = nil;
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:assetURL
             resultBlock:^(ALAsset *asset)  {
                 imageMetadata = [[NSMutableDictionary alloc] initWithDictionary:asset.defaultRepresentation.metadata];

                 //GPS数据
                 GPSDict=[[imageMetadata objectForKey:(NSString*)kCGImagePropertyGPSDictionary] mutableCopy];
                 //EXIF数据
                 EXIFDictionary =[[imageMetadata objectForKey:(NSString *)kCGImagePropertyExifDictionary]mutableCopy];
                 //TIFF数据
                 TIFFDict=[[imageMetadata objectForKey:(NSString*)kCGImagePropertyTIFFDictionary]mutableCopy] ;

                 [GPSDict setObject:@"N" forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
                 [GPSDict setObject:[NSNumber numberWithFloat:48.512954] forKey:(NSString*)kCGImagePropertyGPSLatitude];
                 
                 [GPSDict setObject:@"E" forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
                 [GPSDict setObject:[NSNumber numberWithFloat:2.174019] forKey:(NSString*)kCGImagePropertyGPSLongitude];
                 GPSLog(@"修改钱---%@",imageMetadata);
                 if (GPSDict.count == 0) {
                     
                 }
                 else{
                     [imageMetadata setObject:GPSDict forKey:(NSString*)kCGImagePropertyGPSDictionary];

                 }
                 GPSLog(@"修改后---%@",imageMetadata);

                 
             }
            failureBlock:^(NSError *error) {
            }];

    */
  //[self saveImageToPhotos:imageDataShow];


}

- (void)saveImageToPhotos:(UIImage*)savedImage

{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"保存图片失败" ;
        
    }else{
        
        msg = @"保存图片成功" ;
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                          
                                                    message:msg
                          
                                                   delegate:self
                          
                                          cancelButtonTitle:@"确定"
                          
                                          otherButtonTitles:nil];
    
    [alert show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)informationTap:(id)sender {
    MYInformationImageViewController *infrmation = [[MYInformationImageViewController alloc]init];
    [infrmation setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    infrmation.GPSDict = GPSDict;
    infrmation.EXIFDictionary = EXIFDictionary;
    infrmation.TIFFDict = TIFFDict;
    [self presentViewController:infrmation animated:YES completion:nil];
}


- (int)typeForImageData:(NSData *)data {
    
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    
    
    switch (c) {
            
        case 0xFF:
            
            return 0;//@"image/jpeg"
            
        case 0x89:
            
            return 1;//@"image/png"
            
        case 0x47:
            
            return 2;//@"image/gif"
            
        case 0x49:
            
        case 0x4D:
            
            return 9;//@"image/tiff"
            
    }
    
    return nil;
    
}

@end
