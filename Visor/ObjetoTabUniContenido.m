//
//  ObjetoTabUniContenido.m
//  Visor
//
//  Created by chable on 12/10/16.
//  Copyright (c) 2016 ST. All rights reserved.
//

#import "ObjetoTabUniContenido.h"

@implementation ObjetoTabUniContenido


@synthesize Id_unidades_contenido;
@synthesize Id_dependencia;
@synthesize Id_tema;
@synthesize Id_subtema;
@synthesize Id_trimestre;
@synthesize Monto;
@synthesize Beneficio;
@synthesize Avance;
@synthesize Beneficiario;
@synthesize Iniciativa;
@synthesize Aprobada;
@synthesize Publicada;
@synthesize En_vigor;
@synthesize Observaciones;
@synthesize Motivo;
@synthesize Fecha_inicio;
@synthesize Fecha_termino;
@synthesize Lugar;
@synthesize Descripcion;
@synthesize Cantidad;
@synthesize Desc_beneficiario;
@synthesize Desc_monto;
@synthesize Desc_proc_legislativo;
@synthesize Desc_beneficio;
@synthesize Estatus;
@synthesize Desc_fuente_financiamiento;
@synthesize Desc_avance;
@synthesize Desc_Tipo_Ingreso;

-(id)initWithJSONData:(NSDictionary*)TabUniContenido{
    self = [super init];
    if(self){
        self.Id_unidades_contenido = [TabUniContenido objectForKey:@"ID_UNIDADES_CONTENIDO"];
        self.Id_dependencia =  [TabUniContenido objectForKey:@"ID_DEPENDENCIA"];
        self.Id_tema =  [TabUniContenido objectForKey:@"ID_TEMA"];
        self.Id_subtema =  [TabUniContenido objectForKey:@"ID_SUBTEMA"];
        self.Id_trimestre =  [TabUniContenido objectForKey:@"ID_TRIMESTRE"];
        self.Monto =  [TabUniContenido objectForKey:@"MONTO"];
        self.Beneficio =  [TabUniContenido objectForKey:@"BENEFICIO"];
        self.Avance =  [TabUniContenido objectForKey:@"AVANCE"];
        self.Beneficiario =  [TabUniContenido objectForKey:@"BENEFICIARIO"];
        self.Iniciativa =  [TabUniContenido objectForKey:@"INICIATIVA"];
        self.Aprobada =  [TabUniContenido objectForKey:@"APROBADA"];
        self.Publicada =  [TabUniContenido objectForKey:@"PUBLICADA"];
        self.En_vigor =  [TabUniContenido objectForKey:@"EN_VIGOR"];
        self.Observaciones =  [TabUniContenido objectForKey:@"OBSERVACIONES"];
        self.Motivo =  [TabUniContenido objectForKey:@"MOTIVO"];
        self.Fecha_inicio =  [TabUniContenido objectForKey:@"FECHA_INICIO"];
        self.Fecha_termino =  [TabUniContenido objectForKey:@"FECHA_TERMINO"];
        self.Lugar =  [TabUniContenido objectForKey:@"LUGAR"];
        self.Descripcion =  [TabUniContenido objectForKey:@"DESCRIPCION"];
        self.Cantidad =  [TabUniContenido objectForKey:@"CANTIDAD"];
        self.Desc_beneficiario =  [TabUniContenido objectForKey:@"DESC_BENEFICIARIO"];
        self.Desc_monto =  [TabUniContenido objectForKey:@"DESC_MONTO"];
        self.Desc_proc_legislativo =  [TabUniContenido objectForKey:@"DESC_PROC_LEGISLATIVO"];
        self.Desc_beneficio =  [TabUniContenido objectForKey:@"DESC_BENEFICIO"];
        self.Estatus =  [TabUniContenido objectForKey:@"ESTATUS"];
        self.Desc_fuente_financiamiento =  [TabUniContenido objectForKey:@"DESC_FUENTE_FINANCIAMIENTO"];
        self.Desc_avance =  [TabUniContenido objectForKey:@"DESC_AVANCE"];
        self.Desc_Tipo_Ingreso =  [TabUniContenido objectForKey:@"DESC_TIPO_INGRESO"];

    }
    return self;
}

@end
