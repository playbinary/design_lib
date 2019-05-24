#include "wlist.h"

activeRam getactiveRam(ppD _ppD){
    ppD _ppD_ = _ppD;
    activeNum offsetAddr = _ppD_->port << PRIORITY + _ppD_->pri;
//    activeNum * activeRamBase = (activeNum *)malloc(4 * EACTIVERAM_DEEPTH);
    activeNum  activeRamBase[] ;
    activeNum * addr_t = activeRamBase + (activeRam *)offsetAddr;
    activeNum num = *addr_t;
    if(num < ACTIVE_NUM - 1){
        *addr_t += 1;
    }else if(num >= ACTIVE_NUM - 1){
        *addr_t = 0;
    }
//    free(activeRamBase);
    return num;
}