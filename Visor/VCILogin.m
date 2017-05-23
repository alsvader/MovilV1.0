//
//  VCILogin.m
//  Visor
//
//  Created by aaron on 3/9/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import "VCILogin.h"
#import "VCMenu.h"

@interface VCILogin ()

@end

@implementation VCILogin

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnEntrar:(id)sender{
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VCMenu *pVCMenu =[storyBoard instantiateViewControllerWithIdentifier:@"VCMenu"];
    [self.navigationController pushViewController:pVCMenu animated:YES];
  
    
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
