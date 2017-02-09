//
//  VCIProgramasyAcciones.h
//  Visor
//
//  Created by chable on 1/25/17.
//  Copyright (c) 2017 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCIProgramasyAcciones : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbEje;
@property (weak, nonatomic) IBOutlet UILabel *lbDependencia;
@property (weak, nonatomic) IBOutlet UILabel *lbTrimestre;
@property (weak, nonatomic) IBOutlet UILabel *lbTema;
@property (weak, nonatomic) IBOutlet UILabel *lbSubtema;


@property (weak, nonatomic) IBOutlet UILabel *lbMonto;
@property (weak, nonatomic) IBOutlet UILabel *lbFuenteFinanciamiento;
@property (weak, nonatomic) IBOutlet UILabel *lbBeneficio;
//@property (weak, nonatomic) IBOutlet UILabel *lbDescBeneficio;
@property (weak, nonatomic) IBOutlet UILabel *lbAvance;
@property (weak, nonatomic) IBOutlet UILabel *lbBeneficiario;

//Parametros
@property (strong, nonatomic) id pSubTemaSel;

@end
