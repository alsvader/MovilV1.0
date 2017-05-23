//
//  ObjetoTrimestre.m
//  Visor
//
//  Created by aaron on 5/10/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import "ObjetoTrimestre.h"

@implementation ObjetoTrimestre

@synthesize Id_trimestre;
@synthesize Descripcion;
@synthesize anio;
@synthesize fecha_inicio;
@synthesize fecha_termino;

-(id)initWithJSONData:(NSDictionary*)Trimestre{
    self = [super init];
    if(self){
        self.Id_trimestre = [Trimestre objectForKey:@"ID_TRIMESTRE"];
        self.Descripcion = [Trimestre objectForKey:@"DESCRIPCION"];
        self.anio = [Trimestre objectForKey:@"ANIO"];
        self.fecha_inicio = [Trimestre objectForKey:@"FECHA_INICIO"];
        self.fecha_termino = [Trimestre objectForKey:@"FECHA_TERMINO"];        
    }
    return self;
}



@end
