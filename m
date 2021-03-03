Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2554732C6B6
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Mar 2021 02:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451093AbhCDA3z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Mar 2021 19:29:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:39192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242461AbhCCNzb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Mar 2021 08:55:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614777516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTjwCAs8NFhD6G8Me32PjCtQRtajdWLNU8hPxq2kLwY=;
        b=OG2D8K0+PfCuA5USdfd+Vx6vvOPTyS3EUyRmE7sqZ415QTN8GcaX9NJMw0mxPVVFu1pGLR
        m/nhsBzCaOzVYjLB8Jp0BgoRT32O09qY+clnqr6yXiqa/1CU+6464zYukujhq7ChdCD79P
        71x09r4i/F0vei3pckPBC7HbLpQl/ms=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 531B1AD29;
        Wed,  3 Mar 2021 13:18:36 +0000 (UTC)
Date:   Wed, 3 Mar 2021 14:18:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Meyer <thomas@m3y3r.de>, linux-um@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
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
        Oleg Nesterov <oleg@redhat.com>, Wei Li <liwei391@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: lkml delivery: was: Re: [PATCH next v4 00/15] printk: remove
 logbuf_lock
Message-ID: <YD+MpccJp4gX6bOP@alley>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303101528.29901-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi John,

On Wed 2021-03-03 11:15:13, John Ogness wrote:
> Hello,
> 
> Here is v4 of a series to remove @logbuf_lock, exposing the
> ringbuffer locklessly to both readers and writers. v3 is
> here [0].

Have you got some reply from lkml that it has not delivered there,
please?

I am not able to get the patchset using b4 tool:

$> b4 am -o test 20210303101528.29901-1-john.ogness@linutronix.de
Looking up https://lore.kernel.org/r/20210303101528.29901-1-john.ogness%40linutronix.de
Grabbing thread from lore.kernel.org/linux-hyperv
Analyzing 2 messages in the thread
---
Thread incomplete, attempting to backfill
Grabbing thread from lore.kernel.org/lkml
Server returned an error: 404
Grabbing thread from lore.kernel.org/linux-mtd
Server returned an error: 404
Grabbing thread from lore.kernel.org/linuxppc-dev
Loaded 2 messages from https://lore.kernel.org/linuxppc-dev/
---
Writing test/v4_20210303_john_ogness_printk_remove_logbuf_lock.mbx
  ERROR: missing [1/15]!
  ERROR: missing [2/15]!
  ERROR: missing [3/15]!
  ERROR: missing [4/15]!
  ERROR: missing [5/15]!
  ERROR: missing [6/15]!
  ERROR: missing [7/15]!
  ERROR: missing [8/15]!
  ERROR: missing [9/15]!
  ERROR: missing [10/15]!
  [PATCH next v4 11/15] printk: kmsg_dumper: remove @active field
  ✓ [PATCH next v4 12/15] printk: introduce a kmsg_dump iterator
  ERROR: missing [13/15]!
  [PATCH next v4 14/15] printk: kmsg_dump: remove _nolock() variants
  ERROR: missing [15/15]!
---
Total patches: 3
---
WARNING: Thread incomplete!
Cover: test/v4_20210303_john_ogness_printk_remove_logbuf_lock.cover
 Link: https://lore.kernel.org/r/20210303101528.29901-1-john.ogness@linutronix.de
 Base: not found
       git am test/v4_20210303_john_ogness_printk_remove_logbuf_lock.mbx


and I do not see it at lore. It has only found copies in linux-hyperv
and linux-ppcdev mailing lists,
see https://lore.kernel.org/lkml/20210303101528.29901-2-john.ogness@linutronix.de/

Best Regards,
Petr
