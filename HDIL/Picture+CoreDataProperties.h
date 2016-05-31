//
//  Picture+CoreDataProperties.h
//  
//
//  Created by Richard Velazquez on 5/30/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Picture.h"

NS_ASSUME_NONNULL_BEGIN

@interface Picture (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *binary;

@end

NS_ASSUME_NONNULL_END
