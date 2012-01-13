//
//  M2CanvasView+PrivateMethods.h
//  monsters2
//
//  Created by Rinik Vojto on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "M2CanvasView.h"

/**
 Methods of M2CanvasView that are meant to be used internally by the same
 class.
 */
@interface M2CanvasView (PrivateMethods)

/****************************************************************************
 @name Updating models according to changes on canvas
 ****************************************************************************/

/**
 Updates objects displayed on canvas from array controller.
 */
- (void)_updateObjects;

/**
 Updates particular object on canvas from its model.
 */
- (void)_updateView:(M2ObjectView *)view fromObject:(M2CanvasObject *)canvasObject;

/**
 Returns canvas model object for passed canvas view object
 */
- (M2CanvasObject *)_canvasObjetForView:(M2ObjectView *)view;

/****************************************************************************
 @name Updating object selection
 ****************************************************************************/

/**
 Updates selection on canvas from selection in array controller.
 */
- (void)_updateSelection;

/**
 Returns view for selection in array controller.
 */
- (M2ObjectView *)_viewForSelection;

/****************************************************************************
 @name Updating properties of selected object
 ****************************************************************************/

/**
 Updates properties of object selected on canvas from object selected in
 array controller.
 */
- (void)_updateSelectionFromSelectedObject;

@end
