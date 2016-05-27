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

+(NSArray *)returnImageAnalysisDataUsingData:(NSData *)data {
   MPOFaceServiceClient *client = [[MPOFaceServiceClient alloc] initWithSubscriptionKey:ProjectOxfordFaceSubscriptionKey];
  
  [client detectWithData:data returnFaceId:false returnFaceLandmarks:false returnFaceAttributes:@[@(MPOFaceAttributeTypeGender), @(MPOFaceAttributeTypeAge)] completionBlock:^(NSArray<MPOFace *> *collection, NSError *error) {
    if (error) {
      NSLog(@"%@", error.localizedDescription);
    } else {
      for (MPOFace *face in collection) {
        
        NSLog(@"%@", face.attributes.gender);
        NSLog(@"%@", face.attributes.age);
      }
    }
    
  }];
  
  return @[@"skjfdb"];
  
}








@end
