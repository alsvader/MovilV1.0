//
//  VCIReuniones.h
//  Visor
//
//  Created by chable on 1/24/17.
//  Copyright (c) 2017 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCIReuniones : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbEje;
@property (weak, nonatomic) IBOutlet UILabel *lbDependencia;
@property (weak, nonatomic) IBOutlet UILabel *lbTrimestre;
@property (weak, nonatomic) IBOutlet UILabel *lbTema;
@property (weak, nonatomic) IBOutlet UILabel *lbSubtema;


@property (weak, nonatomic) IBOutlet UILabel *lbLugar;
@property (weak, nonatomic) IBOutlet UILabel *lbFechaInicio;
//@property (weak, nonatomic) IBOutlet UILabel *lbFechaFin;
@property (weak, nonatomic) IBOutlet UITextView *lbMotivo;
//Parametros

@property (weak, nonatomic) IBOutlet UILabel *etMotivo;
@property (weak, nonatomic) IBOutlet UILabel *etLugar;
@property (weak, nonatomic) IBOutlet UILabel *etFechaInicio;


@property (strong, nonatomic) id pSubTemaSel;


@end
