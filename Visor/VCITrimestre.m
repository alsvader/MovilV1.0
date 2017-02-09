//
//  VCITrimestre.m
//  Visor
//
//  Created by chable on 11/29/16.
//  Copyright (c) 2016 ST. All rights reserved.
//

#import "VCITrimestre.h"
#import "VCITemas.h"

@interface VCITrimestre ()

@end

@implementation VCITrimestre

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  //  Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   //}


- (IBAction)bt1Trimestre:(id)sender{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VCITrimestre *pViewController =[storyBoard instantiateViewControllerWithIdentifier:@"VCITemas"];
    [self.navigationController pushViewController:pViewController animated:YES];
}

@end
