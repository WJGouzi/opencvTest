//
//  ViewController.m
//  opencvTest
//
//  Created by gouzi on 2017/4/7.
//  Copyright © 2017年 gouzi. All rights reserved.
//

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/types_c.h>
#import <opencv2/imgcodecs/ios.h>
#endif
#import "ViewController.h"

@interface ViewController (){
    cv::Mat cvImage;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nneib.
    [self nomarlImageToCvImgae];
}

/**
 普通照片转换为cv处理过的照片
 */
- (void)nomarlImageToCvImgae {
    UIImage *image = [UIImage imageNamed:@"xinyuanjieyi.jpg"];
    UIImageToMat(image, cvImage);
    if(!cvImage.empty()){
        cv::Mat gray;
        // 将图像转换为灰度显示
        cv::cvtColor(cvImage,gray,CV_RGB2GRAY);
        // 应用高斯滤波器去除小的边缘
        cv::GaussianBlur(gray, gray, cv::Size(5,5), 1.2,1.2);
        // 计算与画布边缘
        cv::Mat edges;
        cv::Canny(gray, edges, 0, 50);
        // 使用白色填充
        cvImage.setTo(cv::Scalar::all(225));
        // 修改边缘颜色
        cvImage.setTo(cv::Scalar(0,128,255,255),edges);
        // 将Mat转换为Xcode的UIImageView显示
        self.imgView.image = MatToUIImage(cvImage);
    }
}


@end
