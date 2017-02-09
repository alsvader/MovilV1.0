//
//  ObjetoTabUniContenido.h
//  Visor
//
//  Created by chable on 12/10/16.
//  Copyright (c) 2016 ST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjetoTabUniContenido : NSObject

-(id)initWithJSONData:(NSDictionary*)TabUniContenido;
@property (strong) NSString *Id_unidades_contenido;
@property (strong) NSString *Id_dependencia;
@property (strong) NSString *Id_tema;
@property (strong) NSString *Id_subtema;
@property (strong) NSString *Id_trimestre;
@property (strong) NSString *Monto;
@property (strong) NSString *Beneficio;
@property (strong) NSString *Avance;
@property (strong) NSString *Beneficiario;
@property (strong) NSString *Iniciativa;
@property (strong) NSString *Aprobada;
@property (strong) NSString *Publicada;
@property (strong) NSString *En_vigor;
@property (strong) NSString *Observaciones;
@property (strong) NSString *Motivo;
@property (strong) NSString *Fecha_inicio;
@property (strong) NSString *Fecha_termino;
@property (strong) NSString *Lugar;
@property (strong) NSString *Descripcion;
@property (strong) NSString *Cantidad;
@property (strong) NSString *Desc_beneficiario;
@property (strong) NSString *Desc_monto;
@property (strong) NSString *Desc_proc_legislativo;
@property (strong) NSString *Desc_beneficio;
@property (strong) NSString *Estatus;
@property (strong) NSString *Desc_fuente_financiamiento;
@property (strong) NSString *Desc_avance;
@property (strong) NSString *Desc_Tipo_Ingreso;







@end
