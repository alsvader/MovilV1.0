//
//  VCGBarras.h
//  Visor
//
//  Created by aaron on 2/23/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCGBarras : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewChart;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *VWgrafica;

@property (weak, nonatomic) IBOutlet UILabel *labelEje;
@property (weak, nonatomic) IBOutlet UILabel *labelDep;
@property (weak, nonatomic) IBOutlet UILabel *labelTrimestre;
@property (weak, nonatomic) IBOutlet UILabel *etiquetaX;
@property (weak, nonatomic) IBOutlet UILabel *etiquetaY;
@property (weak, nonatomic) IBOutlet UILabel *labelValX;
@property (weak, nonatomic) IBOutlet UILabel *labelValY;

@property (strong, nonatomic) id pTemaSel;

@end
