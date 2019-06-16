//
//  WaterShopMessageViewController.m
//  WaterCube
//
//  Created by apple on 2019/5/25.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "WaterShopMessageViewController.h"

@interface WaterShopMessageViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *FirstView;
@property (weak, nonatomic) IBOutlet UIView *SecondView;
@property (weak, nonatomic) IBOutlet UIImageView *ShopImage;
@property (weak, nonatomic) IBOutlet UITextField *ShopNameTF;
@property (weak, nonatomic) IBOutlet UITextField *ShopPeoperTF;
@property (weak, nonatomic) IBOutlet UITextField *ShopPhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *ProvinceTF;
@property (weak, nonatomic) IBOutlet UITextField *DetailTF;
@property (weak, nonatomic) IBOutlet UIButton *SubmitBT;

@end

@implementation WaterShopMessageViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Navigation_itemBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.title = @"水站信息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)leftBarBtnClicked:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self requestDataFromNet];
    // Do any additional setup after loading the view from its nib.
}

- (void)initView{
    
    self.FirstView.layer.masksToBounds = YES;
    self.FirstView.layer.cornerRadius = 8;
    
    self.SecondView.layer.masksToBounds = YES;
    self.SecondView.layer.cornerRadius = 8;
    
    self.SubmitBT.layer.masksToBounds = YES;
    self.SubmitBT.layer.cornerRadius = 8;
    self.SubmitBT.hidden = YES;
}

- (void)requestDataFromNet{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/b/merchantSso/getMerchantShopByToken?token=%@",KFORMALURL,KUSERTOKEN];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //  NSLog(@"%@",responseObject);
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            NSDictionary *data = responseObject[@"data"];
            NSDictionary *shopInfo = data[@"shopInfo"];
            NSDictionary *sso = data[@"sso"];
            [self.ShopImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",shopInfo[@"bizLicImg"]]] placeholderImage:[UIImage imageNamed:@""]];
            self.ShopNameTF.text = [NSString stringWithFormat:@"%@",shopInfo[@"shopName"]];
            self.ShopPhoneTF.text = [NSString stringWithFormat:@"%@",KUSERPHONE];
            self.ShopPeoperTF.text = [NSString stringWithFormat:@"%@",sso[@"name"]];
            self.ProvinceTF.text = [NSString stringWithFormat:@"%@%@%@",shopInfo[@"province"],shopInfo[@"city"],shopInfo[@"area"]];
            self.DetailTF.text = [NSString stringWithFormat:@"%@",shopInfo[@"address"]];
            
        }else{
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}



- (IBAction)ImageChangeTap:(UITapGestureRecognizer *)sender {
    [MBProgressHUD showError:@"暂时不能修改图片"];
//    UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    // 从相册选取
//    UIAlertAction *album = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
//        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
//        picker.allowsEditing = YES;
//        picker.delegate = self;
//        [self presentViewController:picker animated:YES completion:nil];
//    }];
//
//    // 从相机选取
//    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
//
//        picker.allowsEditing = YES;
//        picker.delegate = self;
//        [self presentViewController:picker animated:YES completion:nil];
//    }];
//
//
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [aler addAction:cancel];
//    [aler addAction:camera];
//    [aler addAction:album];
//    [self presentViewController:aler animated:YES completion:nil];
}

/** 选择图片结束代理方法 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image){
        // 压缩图片质量
        UIImage *newImage = [CommonClass imageCompressForWidth:image targetWidth:2 * kScreenWidth];
        [self uploadUserPortraitToServerWithHeaderImg:newImage];
    } else {
        [MBProgressHUD showError:@"图片选择失败"];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
/**
 上传图像至服务器
 
 @param portrait 用户选择的照片
 */
- (void)uploadUserPortraitToServerWithHeaderImg:(UIImage *)portrait {
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *imageName = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
    NSData *imageData = UIImageJPEGRepresentation(portrait, 1.0f);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    NSString *url = [NSString stringWithFormat:@"%@api/b/image/uploadGoodsImage?name=%@",KUPLOADIMAGE,fileName];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"上传图片中...";
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            [hud hideAnimated:YES];
           
        }else{
            [MBProgressHUD showError:@"上传图片失败"];
            [hud hideAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
        
    }];
    
}


- (IBAction)UploadDataBtAction:(UIButton *)sender {
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
