//
//  ObjetoSubtema.m
//  Visor
//
//  Created by aaron on 3/24/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import "ObjetoSubtema.h"

@implementation ObjetoSubtema

@synthesize Id_subtema;
@synthesize Id_Tema;
@synthesize Descripcion;
@synthesize Descripcion_corta;

-(id)initWithJSONData:(NSDictionary*)Subtema{
    self = [super init];
    if(self){
        self.Id_subtema = [Subtema objectForKey:@"ID_SUBTEMA"];
        self.Id_Tema = [Subtema objectForKey:@"ID_TEMA"];
        self.Descripcion = [Subtema objectForKey:@"DESCRIPCION"];
        self.Descripcion_corta = [Subtema objectForKey:@"DESCRIPCION_CORTA"];
        
        
    }
    return self;
}



@end
