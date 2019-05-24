#include <stdint.h>
#include <stddef.h>
#include <malloc.h>
/* QNUM_NUM: the quantity of queue
** PORT_NUM: the quantity of port
** */
#define QNUM_NUM            (1024)
#define PORT_NUM            (256)
#define PRIORITY_NUM         (4)
#define PRIORITY_BITWIDTH    (2)
#define QUEUE_LENGTH
#define EACTIVERAM_DEEPTH   (PORT_NUM * PRIORITY_NUM)
#define EACTIVERAM_BITWIDTH (3)
#define DACTIVERAM_DEEPTH   (PORT_NUM * PRIORITY_NUM)
#define DACTIVERAM_BITWIDTH (3)
#define ACTIVE_NUM          ( 1 << EACTIVERAM_BITWIDTH )
#define HPRAM_DEEPTH        (EACTIVERAM_DEEPTH * ACTIVE_NUM)
#define TPRAM_DEEPTH        HPRAM_DEEPTH
#define NEXTRAM_DEEPTH      QNUM_NUM
#define EMPRTYRAM_DEEPTH    HPRAM_DEEPTH
#define FLAGRAM_DEEPTH      QNUM_NUM

typedef struct __packetDescription {
    uint32_t qnum;
    uint32_t port;
    uint32_t pri;
    uint32_t ql;
    uint32_t crbal;
} _packetDescription, *ppD;

typedef uint8_t activeNum;
typedef void (*fun)(void);
activeNum geteactiveRam(ppD _ppD);