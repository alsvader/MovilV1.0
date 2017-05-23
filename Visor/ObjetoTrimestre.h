//
//  ObjetoTrimestre.h
//  Visor
//
//  Created by aaron on 5/10/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjetoTrimestre : NSObject

-(id)initWithJSONData:(NSDictionary*)Trimestre;
@property (strong) NSString *Id_trimestre;
@property (strong) NSString *Descripcion;
@property (strong) NSString *anio;
@property (strong) NSString *fecha_inicio;
@property (strong) NSString *fecha_termino;


@end
