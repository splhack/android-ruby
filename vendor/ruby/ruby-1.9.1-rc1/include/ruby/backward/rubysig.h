/**********************************************************************

  rubysig.h -

  $Author: nobu $
  $Date: 2008-09-26 09:55:09 +0900 (Fri, 26 Sep 2008) $
  created at: Wed Aug 16 01:15:38 JST 1995

  Copyright (C) 1993-2008 Yukihiro Matsumoto

**********************************************************************/

#if   defined __GNUC__
#warning rubysig.h is obsolete
#elif defined _MSC_VER || defined __BORLANDC__
#pragma message("warning: rubysig.h is obsolete")
#endif

#ifndef RUBYSIG_H
#define RUBYSIG_H
#include "ruby/ruby.h"

struct rb_blocking_region_buffer;
RUBY_EXTERN struct rb_blocking_region_buffer *rb_thread_blocking_region_begin(void);
RUBY_EXTERN void rb_thread_blocking_region_end(struct rb_blocking_region_buffer *);
#define TRAP_BEG do {void *__region = rb_thread_blocking_region_begin(void);
#define TRAP_END rb_thread_blocking_region_end(__region);} while (0)
#define RUBY_CRITICAL(statements) do {statements;} while (0)
#define DEFER_INTS (0)
#define ENABLE_INTS (1)
#define ALLOW_INTS do {CHECK_INTS;} while (0)
#define CHECK_INTS rb_thread_check_ints()
#endif
