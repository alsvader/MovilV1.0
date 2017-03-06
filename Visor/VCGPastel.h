//
//  VCGDif.h
//  Visor
//
//  Created by chable on 1/31/17.
//  Copyright (c) 2017 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCGPastel : UIViewController

@property (strong, nonatomic) id pTemaSel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *labelTrimestre;
@property (weak, nonatomic) IBOutlet UILabel *labelEje;
@property (weak, nonatomic) IBOutlet UILabel *labelGraf;
@property (weak, nonatomic) IBOutlet UILabel *etiquetaX;
@property (weak, nonatomic) IBOutlet UILabel *etiquetaY;
@property (weak, nonatomic) IBOutlet UILabel *labelValX;
@property (weak, nonatomic) IBOutlet UILabel *labelValY;


@end
