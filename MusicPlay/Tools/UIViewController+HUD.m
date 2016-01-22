//
//  UIViewController+HUD.m
//  MusicPlay
//
//  Created by lanou on 1/22/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"

@implementation UIViewController (HUD)

- (void)showHUDwith:(NSString *)str
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:self.view.bounds];
    hud.labelText = str;
    hud.tag = 1000;
    [hud show:YES];
    [self.view addSubview:hud];
}

// 
- (void)hideHUD
{
    for (UIView *view in self.view.subviews) {
        if (view.tag == 1000) {
            [((MBProgressHUD *)view) hide:YES afterDelay:1];
        }
    }
}

- (void)showHUDwhenDisconnectedWith:(NSString *)str
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = str;
    [hud show:YES];
    
    [hud hide:YES afterDelay:3];
}


//- (void)sayHello{
//    NSLog(@"sayhello");
//}

@end
