//
//  VCIProcesoLeg.h
//  Visor
//
//  Created by chable on 2/4/17.
//  Copyright (c) 2017 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCIProcesoLeg : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *lbEje;
@property (weak, nonatomic) IBOutlet UILabel *lbDependencia;
@property (weak, nonatomic) IBOutlet UITextView *txtTema;
@property (weak, nonatomic) IBOutlet UITextView *txtSubtema;

@property (weak, nonatomic) IBOutlet UILabel *lbDescprogLeg;
@property (weak, nonatomic) IBOutlet UILabel *lbIniciativa;
@property (weak, nonatomic) IBOutlet UILabel *lbAprobada;
@property (weak, nonatomic) IBOutlet UITextView *txtPublicada;
@property (weak, nonatomic) IBOutlet UITextView *txtEnvigor;
@property (weak, nonatomic) IBOutlet UITextView *txtObservaciones;


//Parametros
@property (strong, nonatomic) id pSubTemaSel;

@end
