Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56648325791
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Feb 2021 21:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhBYUZ3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 Feb 2021 15:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBYUZY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 Feb 2021 15:25:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3388C06174A;
        Thu, 25 Feb 2021 12:24:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614284679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qDVKAKnnfPFs0Dxv5+kX2VVyNzrYE33K+BDYTVeJME8=;
        b=Itg1HgnAQey3puEfZXpKRRf1RkHbrPWXsodppd3f9/agHLs59mQxmZvHrDVfXhn7TF2e+X
        YgctQb8llo4ek4IXOH40pHKrSlSJUv+qmqSuRbNPlwERu5vmF3/VXIexN4FpY+8WHM5d4n
        3zHVITkWvbjhosz0zzfOytwQyTccmRTsG9uKDQ/PoVKslKdevkHeAS8FY/vBbTk7ZYAmwx
        j9C6lcv4wUAstQLOYdbQOINDWx2UjXbjMRmTNEt/9KnzbRIvSmj2EXQuCLrXAd5jyQHGnB
        6degQSHuHB1F0v3eFX0HxngBtbRJympKrqQjrUQzvVBIk1MNI805LQYIDMpUAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614284679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qDVKAKnnfPFs0Dxv5+kX2VVyNzrYE33K+BDYTVeJME8=;
        b=R+fgiTn80NtyboUkoI+34S01BUhJK8k4MSy2VNzuYCNOKjN83g0YvSMQCLvesqnrTwxeYZ
        t+PogSzB5duz2fCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-um@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jordan Niethe <jniethe5@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Wei Li <liwei391@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Oleg Nesterov <oleg@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH next v3 00/15] printk: remove logbuf_lock
Date:   Thu, 25 Feb 2021 21:24:23 +0100
Message-Id: <20210225202438.28985-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello,

Here is v3 of a series to remove @logbuf_lock, exposing the
ringbuffer locklessly to both readers and writers. v2 is here [0].

Since @logbuf_lock was protecting much more than just the
ringbuffer, this series clarifies and cleans up the various
protections using comments, lockless accessors, atomic types, and a
new finer-grained @syslog_lock.

Removing @logbuf_lock required changing the semantics of the
kmsg_dumper callback in order to work locklessly. Since this
involved touching all the kmsg_dump users, we also decided [1] to
use this opportunity to clean up and clarify the kmsg_dump semantics
in general.

This series is based on next-20210225.

Changes since v2:

- use get_maintainer.pl to get the full list of developers that
  should at least see the changes in their respective areas

- do not disable interrupts in arch/um kmsg_dumper (because there is
  no need to)

- protect the mtd/mtdoops kmsg_dumper buffer against concurrent
  dumps

- update kerneldoc for kmsg_dump_get_line() (@len_out)

- remove ksmg_dump's @active flag

- change kmsg_dumper callback to:
  void (*dump)(enum kmsg_dump_reason reason);

- rename kmsg_dumper_iter to kmsg_dump_iter

- update kmsg_dumpers to use their own kmsg_dump_iter (and
  initialize it with kmsg_dump_rewind() if necessary)

John Ogness

[0] https://lkml.kernel.org/r/20210218081817.28849-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/YDeZAA08NKCHa4s%2F@alley

John Ogness (15):
  um: synchronize kmsg_dumper
  mtd: mtdoops: synchronize kmsg_dumper
  printk: limit second loop of syslog_print_all
  printk: kmsg_dump: remove unused fields
  printk: refactor kmsg_dump_get_buffer()
  printk: consolidate kmsg_dump_get_buffer/syslog_print_all code
  printk: introduce CONSOLE_LOG_MAX for improved multi-line support
  printk: use seqcount_latch for clear_seq
  printk: use atomic64_t for devkmsg_user.seq
  printk: add syslog_lock
  printk: kmsg_dumper: remove @active field
  printk: introduce a kmsg_dump iterator
  printk: remove logbuf_lock
  printk: kmsg_dump: remove _nolock() variants
  printk: console: remove unnecessary safe buffer usage

 arch/powerpc/kernel/nvram_64.c             |  14 +-
 arch/powerpc/platforms/powernv/opal-kmsg.c |   3 +-
 arch/powerpc/xmon/xmon.c                   |   6 +-
 arch/um/kernel/kmsg_dump.c                 |  15 +-
 drivers/hv/vmbus_drv.c                     |   7 +-
 drivers/mtd/mtdoops.c                      |  20 +-
 fs/pstore/platform.c                       |   8 +-
 include/linux/kmsg_dump.h                  |  49 +--
 kernel/debug/kdb/kdb_main.c                |  10 +-
 kernel/printk/internal.h                   |   4 +-
 kernel/printk/printk.c                     | 456 ++++++++++-----------
 kernel/printk/printk_safe.c                |  27 +-
 12 files changed, 309 insertions(+), 310 deletions(-)

-- 
2.20.1

