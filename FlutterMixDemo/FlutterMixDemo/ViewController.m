//
//  ViewController.m
//  FlutterMixDemo
//
//  Created by 陈竹青 on 2021/6/16.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>
#import "AddressViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)clickAction:(id)sender {
//    FlutterEngine * flutterEngine = ((AppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
//    FlutterViewController * flutterVC = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
//    [flutterVC pushRoute:@"/secondPage"];
//    flutterVC.view.backgroundColor =[UIColor whiteColor];
//    flutterVC.title = @"我是第二个页面";
//    [self.navigationController pushViewController:flutterVC animated:YES];
    
//    AddressViewController * address = [[AddressViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
//    [address pushRoute:@"/AddressSelect"];
    AddressViewController * address = [[AddressViewController alloc] init];
    [self presentViewController:address animated:YES completion:nil];
    
}


@end
