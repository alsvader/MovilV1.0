//
//  ObjetoTema.m
//  Visor
//
//  Created by aaron on 3/24/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import "ObjetoTema.h"

@implementation ObjetoTema

@synthesize  Id_Tema;
@synthesize  Id_Unidad;
@synthesize  Id_Dependencia;
@synthesize  Descripcion;
@synthesize  Descripcion_corta;

-(id)initWithJSONData:(NSDictionary*)Subtema{
    self = [super init];
    if(self){
        self.Id_Tema = [Subtema objectForKey:@"ID_TEMA"];
        self.Id_Unidad = [Subtema objectForKey:@"ID_UNIDAD"];
        self.Id_Dependencia = [Subtema objectForKey:@"ID_DEPENDENCIA"];
        self.Descripcion = [Subtema objectForKey:@"DESCRIPCION"];
        self.Descripcion_corta = [Subtema objectForKey:@"DESCRIPCION_CORTA"];
        
    }
    return self;
}

@end
