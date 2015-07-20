//
//  ViewController.h
//  TestMJRefrash
//
//  Created by qianfeng on 15-7-8.
//  Copyright (c) 2015年 CenYaLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

{
    NSMutableArray *_dataArray;
    NSUInteger _currentPage;
    BOOL _isShowHUD;
}

@property (nonatomic, copy) NSString *urlstring;
@property (nonatomic, copy) NSString *categoryId;
@end

