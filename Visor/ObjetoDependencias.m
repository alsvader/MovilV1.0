//
//  ObjetoDependencias.m
//  Visor
//
//  Created by aaron on 5/10/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import "ObjetoDependencias.h"

@implementation ObjetoDependencias


@synthesize Id_dependencia;
@synthesize Desc_dependencia;
@synthesize Desc_corta;
@synthesize Id_eje;

-(id)initWithJSONData:(NSDictionary*)Dependencias{
    self = [super init];
    if(self){
        self.Id_dependencia = [Dependencias objectForKey:@"ID_DEPENDENCIA"];
        self.Desc_dependencia = [Dependencias objectForKey:@"DESC_DEPENDENCIA"];
        self.Desc_corta = [Dependencias objectForKey:@"DESC_CORTA"];
        self.Id_eje = [Dependencias objectForKey:@"ID_EJE"];        
    }
    return self;
}


@end
