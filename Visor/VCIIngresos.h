//
//  VCIIngresos.h
//  Visor
//
//  Created by chable on 1/25/17.
//  Copyright (c) 2017 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCIIngresos : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbEje;
@property (weak, nonatomic) IBOutlet UILabel *lbDependencia;
@property (weak, nonatomic) IBOutlet UILabel *lbTrimestre;
@property (weak, nonatomic) IBOutlet UILabel *lbTema;
@property (weak, nonatomic) IBOutlet UILabel *lbSubtema;


@property (weak, nonatomic) IBOutlet UILabel *lbTipoIngreso;
@property (weak, nonatomic) IBOutlet UILabel *lbMonto;

@property (weak, nonatomic) IBOutlet UILabel *etTipoIngreso;
@property (weak, nonatomic) IBOutlet UILabel *etMonto;


//Parametros
@property (strong, nonatomic) id pSubTemaSel;


@end
