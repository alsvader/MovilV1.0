//
//  ObjetoDependencias.h
//  Visor
//
//  Created by aaron on 5/10/17.
//  Copyright © 2017 ST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjetoDependencias : NSObject

-(id)initWithJSONData:(NSDictionary*)Dependencias;
@property (strong) NSString *Id_dependencia;
@property (strong) NSString *Desc_dependencia;
@property (strong) NSString *Desc_corta;
@property (strong) NSString *Id_eje;


@end
