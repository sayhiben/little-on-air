/* SPDX-License-Identifier: MIT */
/* Deterministic host scheduler for the real indicator state machine. */
#pragma once
#include <stddef.h>
#include <stdint.h>

struct k_mutex {
	int unused;
};
struct k_work {
	void (*handler)(struct k_work *);
};
struct k_work_delayable {
	struct k_work work;
};
#define K_FOREVER                         (-1)
#define K_NO_WAIT                         0
#define K_SECONDS(s)                      ((s) * 1000U)
#define ARRAY_SIZE(a)                     (sizeof(a) / sizeof((a)[0]))
#define BUILD_ASSERT(cond, msg)           _Static_assert(cond, msg)
#define K_MUTEX_DEFINE(name)              struct k_mutex name = {0}
#define ARG_UNUSED(arg)                   ((void)(arg))
#define K_WORK_DELAYABLE_DEFINE(name, fn) struct k_work_delayable name = {.work = {.handler = fn}}
#define K_MSEC(ms)                        (ms)
#define CONTAINER_OF(ptr, type, member)   ((type *)((char *)(ptr) - offsetof(type, member)))
static inline void k_mutex_init(struct k_mutex *mutex)
{
	(void)mutex;
}
static inline void k_mutex_lock(struct k_mutex *mutex, int timeout)
{
	(void)mutex;
	(void)timeout;
}
static inline void k_mutex_unlock(struct k_mutex *mutex)
{
	(void)mutex;
}
static inline void k_work_init_delayable(struct k_work_delayable *work,
					 void (*handler)(struct k_work *))
{
	work->work.handler = handler;
}
uint32_t k_uptime_get_32(void);
int k_work_reschedule(struct k_work_delayable *work, uint32_t delay_ms);
int k_work_cancel_delayable(struct k_work_delayable *work);
