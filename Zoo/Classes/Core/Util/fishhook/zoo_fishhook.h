//
//  zoo_fishhook.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#ifndef zoo_fishhook_h
#define zoo_fishhook_h

#include <stddef.h>
#include <stdint.h>

#if !defined(ZOO_FISHHOOK_EXPORT)
#define ZOO_FISHHOOK_VISIBILITY __attribute__((visibility("hidden")))
#else
#define ZOO_FISHHOOK_VISIBILITY __attribute__((visibility("default")))
#endif

#ifdef __cplusplus
extern "C" {
#endif //__cplusplus

/*
 * A structure representing a particular intended rebinding from a symbol
 * name to its replacement
 */
struct zoo_rebinding {
  const char *name;
  void *replacement;
  void **replaced;
};

/*
 * For each rebinding in rebindings, rebinds references to external, indirect
 * symbols with the specified name to instead point at replacement for each
 * image in the calling process as well as for all future images that are loaded
 * by the process. If rebind_functions is called more than once, the symbols to
 * rebind are added to the existing list of rebindingzoo_rebind_symbolsl
 * is rebound more than once, the later rebinding will take precedence.
 */
ZOO_FISHHOOK_VISIBILITY
int zoo_rebind_symbols(struct zoo_rebinding rebindings[], size_t rebindings_nel);

/*
 * Rebinds as above, but only in the specified image. The header should point
 * to the mach-o header, the slide should be the slide offset. Others as above.
 */
ZOO_FISHHOOK_VISIBILITY
int zoo_rebind_symbols_image(void *header,
                         intptr_t slide,
                         struct zoo_rebinding rebindings[],
                         size_t rebindings_nel);
#ifdef __cplusplus
}
#endif //__cplusplus


#endif /* zoo_fishhook_h */
