//
//  UIViewController+HUD.h
//  MusicPlay
//
//  Created by lanou on 1/22/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

//- (void)sayHello;

// 显示菊花+文字
- (void)showHUDwith:(NSString *)str;
// 隐藏菊花+文字
- (void)hideHUD;
// 没有网络
- (void)showHUDwhenDisconnectedWith:(NSString *)str;


@end
