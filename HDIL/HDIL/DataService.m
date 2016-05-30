//
//  DataService.m
//  HDIL
//
//  Created by Richard Velazquez on 5/27/16.
//  Copyright © 2016 Ricky. All rights reserved.
//

#import "DataService.h"
#import <ProjectOxfordFace/MPOFaceSDK.h>

@implementation DataService
NSString *ProjectOxfordFaceSubscriptionKey = @"7c58808782884bbf9597e5b42841fd96";


+(BOOL)checkingBridge{
  
  return true;
}

+(void)returnImageAnalysisDataUsingData:(NSData *)data withBlock:(void (^)(NSString *result))block {
   MPOFaceServiceClient *client = [[MPOFaceServiceClient alloc] initWithSubscriptionKey:ProjectOxfordFaceSubscriptionKey];
  
  [client detectWithData:data returnFaceId:false returnFaceLandmarks:false returnFaceAttributes:@[@(MPOFaceAttributeTypeGender), @(MPOFaceAttributeTypeAge)] completionBlock:^(NSArray<MPOFace *> *collection, NSError *error) {
    if (error) {
      block(@"Error");
    } else {
      
      if (collection.count >1)
      {
        block(@"Too many faces");
      } else if (collection.count == 1)
      {
        NSString *sex;
        for (MPOFace *face in collection) {
          sex = [NSString stringWithFormat:@"%@", face.attributes.gender];
          //NSLog(@"%@", face.attributes.gender);
          //NSLog(@"%@", face.attributes.age);
          }
        block(sex);
      }else
      {
          block(@"No faces");
        }
      }
    
  }];
}








@end
