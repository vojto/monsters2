//
//  M2Document.h
//  monsters2
//
//  Created by Rinik Vojto on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M2DocumentController.h"
#import "M2CanvasObject.h"
#import "M2CanvasView.h"

/**
 Kontroluje jeden otvorený dokument. Je súčasťou hierarchie pre dokumentovú
 aplikáciu podporovanú knižnicou Cocoa.

 Keďže táto trieda dedí od triedy `NSPersistentDocument`, kontext spravovaný
 objektov je spravovaný za nás. Tento kontext sa používa pre perzistenciu
 dát v dokumente.
*/
 
@interface M2Document : NSPersistentDocument

/****************************************************************************
 @name Všeobecné pomocné metódy
****************************************************************************/

/**
 Vlastnosť pre rýchly prístup ku ovládaču dokumentov
*/
@property (readonly) M2DocumentController *documentController;

/**
 Vlastnosť pre rýchly prístup k zdieľanému dátovému kontextu
*/
@property (readonly) NSManagedObjectContext *sharedContext;

/**
 Skratka pre nájdenie okná dokumentu
 */
- (NSWindow *)window;

/****************************************************************************
 @name Ovládače polí
 ****************************************************************************/

/**
 Ovládač pre správu objektov v knižnici
*/
@property (assign) IBOutlet NSArrayController *libObjectsController;

/**
 Ovládač pre správu objektov na plátne
*/
@property (assign) IBOutlet NSArrayController *canvasObjectsController;

/****************************************************************************
 @name Zobrazenia
 ****************************************************************************/

/**
 Zobrazenie plátna
*/
@property (assign) IBOutlet M2CanvasView *canvasView;

/****************************************************************************
 @name Exportovanie
 ****************************************************************************/

/**
 Prídavné zobrazenie pre panel exportovania. Obsahuje políčko pre výber formátu.
*/
@property (assign) IBOutlet NSView *exportView;

/**
 Políčko pre výber formátu. Použité pri ukladaní na nájdenie vybraného formátu.
*/
@property (assign) IBOutlet NSPopUpButton *exportFormatButton;

/**
 Akcia pre export aktuálneho dokumentu.
 */
- (IBAction)exportAction:(id)sender;

/**
 Vracia zoznam dostupných formátov pre export. Použité pre naplnenie hodnôt
 v políčku formátov.
 */
- (NSArray *)exportFormats;

/**
 Exportuje aktuálny dokument do súboru v zvolenej adrese so zvoleným formátom.
 */
- (void)exportToURL:(NSURL *)url withFormat:(NSString *)format;

/****************************************************************************
 @name Všeobecné akcie
 ****************************************************************************/

/**
 Akcia pre vytvorenie nového zobrazenia na ploche z objektov v knižnici.
*/
- (IBAction)instantiateAction:(id)sender;

/**
 Akcia pre odstránenie objektov z plochy. Spustená tlačítkom "vymazať".
*/
- (IBAction)removeAction:(id)sender;

/**
 Akcia pre tlač aktuálneho dokumentu. 
*/
- (IBAction)printAction:(id)sender;

/****************************************************************************
 @name Ukladanie a galéria
 ****************************************************************************/

/**
 Vráti pravdivú hodnotú, ak je aktuálny dokument uložený
*/
- (BOOL)isSaved;

/**
 Akcia pre pridanie dokumentu do galérie.
*/
- (IBAction)galleryAddAction:(id)sender;

/****************************************************************************
 @name Importovanie objektov do galknižnice.
 ****************************************************************************/

/**
 Otvorí dialóg pre vybranie súboru, ktorý má byť importovaný.
 */
- (IBAction)importAction:(id)sender;

/**
 Importuje SVG súbor umiestnený v špecifickej adrese.
 */
- (void)importSVGByURL:(NSURL *)url;

@end
