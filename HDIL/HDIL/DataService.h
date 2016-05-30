//
//  DataService.h
//  HDIL
//
//  Created by Richard Velazquez on 5/27/16.
//  Copyright © 2016 Ricky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataService : NSObject
+(BOOL)checkingBridge;
+(void)returnImageAnalysisDataUsingData:(NSData *)data withBlock:(void (^)(NSString *result))block;

@end
