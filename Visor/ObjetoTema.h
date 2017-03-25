//
//  ObjetoTema.h
//  Visor
//
//  Created by aaron on 3/24/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjetoTema : NSObject
-(id)initWithJSONData:(NSDictionary*)Tema;
@property (strong) NSString *Id_Tema;
@property (strong) NSString *Id_Unidad;
@property (strong) NSString *Id_Dependencia;
@property (strong) NSString *Descripcion;
@property (strong) NSString *Descripcion_corta;

@end
