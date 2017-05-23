//
//  VCIAgrupamientos.h
//  Visor
//
//  Created by chable on 1/24/17.
//  Copyright (c) 2017 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCIAgrupamientos : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbEje;
@property (weak, nonatomic) IBOutlet UILabel *lbDependencia;
@property (weak, nonatomic) IBOutlet UILabel *lbTrimestre;
@property (weak, nonatomic) IBOutlet UILabel *lbTema;
@property (weak, nonatomic) IBOutlet UILabel *lbSubtema;


@property (weak, nonatomic) IBOutlet UITextView *lbDescripcion;
@property (weak, nonatomic) IBOutlet UILabel *lbCantidad;
@property (weak, nonatomic) IBOutlet UILabel *lbMonto;

//Parametros
@property (strong, nonatomic) id pSubTemaSel;


@end
