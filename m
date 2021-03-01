Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24443289FC
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Mar 2021 19:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbhCASJl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Mar 2021 13:09:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:46240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239339AbhCASIb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Mar 2021 13:08:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614622064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qp4HJtwIT4bWIf+9Fj02wgzG00aspAv7NDE1H9XsKw8=;
        b=aH1+7x/WqqqBgwoXsxJWiMMfixqBzqQo+CHJ0FMCUdP0kn8yxVawZhEsqiOr+QSi7cVRUm
        cH6dvttkUBHzyuxGaLPn0bQ3ilhyaCz7ZY6y77iScN5BUKhqdowr9f4TAygKPghH0VyeHu
        hCUXGbUSrWDF6mn/T5TxstesPyTwCSg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E550DAE3C;
        Mon,  1 Mar 2021 18:07:43 +0000 (UTC)
Date:   Mon, 1 Mar 2021 19:07:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Jordan Niethe <jniethe5@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>, Wei Li <liwei391@huawei.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-mtd@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH next v3 12/15] printk: introduce a kmsg_dump iterator
Message-ID: <YD0tbVV+hZOFvWyB@alley>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
 <20210225202438.28985-13-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225202438.28985-13-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu 2021-02-25 21:24:35, John Ogness wrote:
> Rather than storing the iterator information in the registered
> kmsg_dumper structure, create a separate iterator structure. The
> kmsg_dump_iter structure can reside on the stack of the caller, thus
> allowing lockless use of the kmsg_dump functions.
> 
> This change also means that the kmsg_dumper dump() callback no
> longer needs to pass in the kmsg_dumper as an argument. If
> kmsg_dumpers want to access the kernel logs, they can use the new
> iterator.
> 
> Update the kmsg_dumper callback prototype. Update code that accesses
> the kernel logs using the kmsg_dumper structure to use the new
> kmsg_dump_iter structure. For kmsg_dumpers, this also means adding a
> call to kmsg_dump_rewind() to initialize the iterator.
> 
> All this is in preparation for removal of @logbuf_lock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  arch/powerpc/kernel/nvram_64.c             | 14 +++---
>  arch/powerpc/platforms/powernv/opal-kmsg.c |  3 +-
>  arch/powerpc/xmon/xmon.c                   |  6 +--
>  arch/um/kernel/kmsg_dump.c                 |  8 +--
>  drivers/hv/vmbus_drv.c                     |  7 +--
>  drivers/mtd/mtdoops.c                      |  8 +--
>  fs/pstore/platform.c                       |  8 +--
>  include/linux/kmsg_dump.h                  | 38 ++++++++-------
>  kernel/debug/kdb/kdb_main.c                | 10 ++--
>  kernel/printk/printk.c                     | 57 ++++++++++------------
>  10 files changed, 81 insertions(+), 78 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index 532f22637783..5a64b24a91c2 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -72,8 +72,7 @@ static const char *nvram_os_partitions[] = {
>  	NULL
>  };
>  
> -static void oops_to_nvram(struct kmsg_dumper *dumper,
> -			  enum kmsg_dump_reason reason);
> +static void oops_to_nvram(enum kmsg_dump_reason reason);
>  
>  static struct kmsg_dumper nvram_kmsg_dumper = {
>  	.dump = oops_to_nvram
> @@ -642,11 +641,11 @@ void __init nvram_init_oops_partition(int rtas_partition_exists)
>   * that we think will compress sufficiently to fit in the lnx,oops-log
>   * partition.  If that's too much, go back and capture uncompressed text.
>   */
> -static void oops_to_nvram(struct kmsg_dumper *dumper,
> -			  enum kmsg_dump_reason reason)
> +static void oops_to_nvram(enum kmsg_dump_reason reason)
>  {
>  	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
>  	static unsigned int oops_count = 0;
> +	static struct kmsg_dump_iter iter;
>  	static bool panicking = false;
>  	static DEFINE_SPINLOCK(lock);
>  	unsigned long flags;
> @@ -681,13 +680,14 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
>  		return;
>  
>  	if (big_oops_buf) {
> -		kmsg_dump_get_buffer(dumper, false,
> +		kmsg_dump_rewind(&iter);

It would be nice to get rid of the kmsg_dump_rewind(&iter) calls
in all callers.

A solution might be to create the following in include/linux/kmsg_dump.h

#define KMSG_DUMP_ITER_INIT(iter) {	\
	.cur_seq = 0,			\
	.next_seq = U64_MAX,		\
	}

#define DEFINE_KMSG_DUMP_ITER(iter)	\
	struct kmsg_dump_iter iter = KMSG_DUMP_ITER_INIT(iter)

Then we could do the following at the beginning of both
kmsg_dump_get_buffer() and kmsg_dump_get_line():

	u64 clear_seq = latched_seq_read_nolock(&clear_seq);

	if (iter->cur_seq < clear_seq)
		cur_seq = clear_seq;


I am not completely sure about next_seq:

   + kmsg_dump_get_buffer() will set it for the next call anyway.
     It reads the blocks of messages from the newest.

   + kmsg_dump_get_line() wants to read the entire buffer anyway.
     But there is a small risk of an infinite loop when new messages
     are printed when dumping each line.

It might be better to avoid the infinite loop. We could do the following:

static void check_and_set_iter(struct kmsg_dump_iter)
{
	if (iter->cur_seq == 0 && iter->next_seq == U64_MAX) {
		kmsg_dump_rewind(iter);
}

and call this at the beginning of both kmsg_dump_get_buffer()
and kmsg_dump_get_line()

What do you think?

Note that I do not resist on it. But it might make the API easier to
use from my POV.

Otherwise the patch looks good to me.

Best Regards,
Petr
