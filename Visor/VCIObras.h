//
//  VCIObras.h
//  Visor
//
//  Created by chable on 1/17/17.
//  Copyright (c) 2017 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCIObras : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbEje;
@property (weak, nonatomic) IBOutlet UILabel *lbDependencia;
@property (weak, nonatomic) IBOutlet UILabel *lbTrimestre;
@property (weak, nonatomic) IBOutlet UILabel *lbTema;
@property (weak, nonatomic) IBOutlet UITextView *lbSubtema;


@property (weak, nonatomic) IBOutlet UITextView *lbDescValor;
@property (weak, nonatomic) IBOutlet UILabel *lbCantidadValor;
@property (weak, nonatomic) IBOutlet UILabel *lbMonto;
@property (weak, nonatomic) IBOutlet UILabel *lbFfinanValor;
@property (weak, nonatomic) IBOutlet UILabel *lbAvfisicoValor;
@property (weak, nonatomic) IBOutlet UILabel *lbBeneficiarioValor;


//Parametros
@property (strong, nonatomic) id pSubTemaSel;

@end
