Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9787A32A666
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Mar 2021 17:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384276AbhCBOzQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Mar 2021 09:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351206AbhCBNgn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Mar 2021 08:36:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18312C061221;
        Tue,  2 Mar 2021 05:24:54 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614691254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wODTS94r7rT1g5V5X1sVfi31G7C1dx6AeI3koBrFuog=;
        b=pdbP0RvjlLwhT6MGt3O7gZlZ1Q1Vzt4kvyP2jb11vAJTSkByIgWXRKROCs34fG3dE0AwTY
        opU3gtVisKtnKDi9H9VaqI9P0bhcuxW+ktoNqViJTmLm/vR+nRGAu3kprbB/6g5+VBDeOZ
        ISR5jMmEubi9pF4n2AWS1K7EJF6nQqOZ7mmnpB1SEorJMS5eXC6YUniwsW+o9YMWNEx/Xj
        xPN5r8bZzOsf6A9vVjHdFrwNDVoQDh1yYdiMi7tbkNI3fa/NGcpZ+fYwM9XNXow6mIJwhV
        c6N2wQQqBhJ0Qe4yqQIr91zIX6QAKM27rCmbJHH1uo6HBm2Z4utmX+gBS6ubiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614691254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wODTS94r7rT1g5V5X1sVfi31G7C1dx6AeI3koBrFuog=;
        b=PvCf8UGzPtfD1uoD5xPlqfOPLQKMHyVSQbbcSZy98K9oXrA3licqYHQYy8osgfMblhBHAa
        hvqSY9FaOO6n64Aw==
To:     Petr Mladek <pmladek@suse.com>
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
In-Reply-To: <YD0tbVV+hZOFvWyB@alley>
References: <20210225202438.28985-1-john.ogness@linutronix.de> <20210225202438.28985-13-john.ogness@linutronix.de> <YD0tbVV+hZOFvWyB@alley>
Date:   Tue, 02 Mar 2021 14:20:51 +0100
Message-ID: <87lfb5pu8c.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2021-03-01, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
>> index 532f22637783..5a64b24a91c2 100644
>> --- a/arch/powerpc/kernel/nvram_64.c
>> +++ b/arch/powerpc/kernel/nvram_64.c
>> @@ -72,8 +72,7 @@ static const char *nvram_os_partitions[] = {
>>  	NULL
>>  };
>>  
>> -static void oops_to_nvram(struct kmsg_dumper *dumper,
>> -			  enum kmsg_dump_reason reason);
>> +static void oops_to_nvram(enum kmsg_dump_reason reason);
>>  
>>  static struct kmsg_dumper nvram_kmsg_dumper = {
>>  	.dump = oops_to_nvram
>> @@ -642,11 +641,11 @@ void __init nvram_init_oops_partition(int rtas_partition_exists)
>>   * that we think will compress sufficiently to fit in the lnx,oops-log
>>   * partition.  If that's too much, go back and capture uncompressed text.
>>   */
>> -static void oops_to_nvram(struct kmsg_dumper *dumper,
>> -			  enum kmsg_dump_reason reason)
>> +static void oops_to_nvram(enum kmsg_dump_reason reason)
>>  {
>>  	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
>>  	static unsigned int oops_count = 0;
>> +	static struct kmsg_dump_iter iter;
>>  	static bool panicking = false;
>>  	static DEFINE_SPINLOCK(lock);
>>  	unsigned long flags;
>> @@ -681,13 +680,14 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
>>  		return;
>>  
>>  	if (big_oops_buf) {
>> -		kmsg_dump_get_buffer(dumper, false,
>> +		kmsg_dump_rewind(&iter);
>
> It would be nice to get rid of the kmsg_dump_rewind(&iter) calls
> in all callers.
>
> A solution might be to create the following in include/linux/kmsg_dump.h
>
> #define KMSG_DUMP_ITER_INIT(iter) {	\
> 	.cur_seq = 0,			\
> 	.next_seq = U64_MAX,		\
> 	}
>
> #define DEFINE_KMSG_DUMP_ITER(iter)	\
> 	struct kmsg_dump_iter iter = KMSG_DUMP_ITER_INIT(iter)

For this caller (arch/powerpc/kernel/nvram_64.c) and for
(kernel/debug/kdb/kdb_main.c), kmsg_dump_rewind() is called twice within
the dumper. So rewind will still be used there.

> Then we could do the following at the beginning of both
> kmsg_dump_get_buffer() and kmsg_dump_get_line():
>
> 	u64 clear_seq = latched_seq_read_nolock(&clear_seq);
>
> 	if (iter->cur_seq < clear_seq)
> 		cur_seq = clear_seq;

I suppose we need to add this part anyway, if we want to enforce that
records before @clear_seq are not to be available for dumpers.

> I am not completely sure about next_seq:
>
>    + kmsg_dump_get_buffer() will set it for the next call anyway.
>      It reads the blocks of messages from the newest.
>
>    + kmsg_dump_get_line() wants to read the entire buffer anyway.
>      But there is a small risk of an infinite loop when new messages
>      are printed when dumping each line.
>
> It might be better to avoid the infinite loop. We could do the following:
>
> static void check_and_set_iter(struct kmsg_dump_iter)
> {
> 	if (iter->cur_seq == 0 && iter->next_seq == U64_MAX) {
> 		kmsg_dump_rewind(iter);
> }
>
> and call this at the beginning of both kmsg_dump_get_buffer()
> and kmsg_dump_get_line()
>
> What do you think?

On a technical level, it does not make any difference. It is pure
cosmetic.

Personally, I prefer the rewind directly before the kmsg_dump_get calls
because it puts the initializer directly next to the user.

As an example to illustrate my view, I prefer:

    for (i = 0; i < n; i++)
        ...;

instead of:

    int i = 0;

    ...

    for (; i < n; i++)
        ...;

Also, I do not really like the special use of 0/U64_MAX to identify
special actions of the kmsg_dump_get functions.

> Note that I do not resist on it. But it might make the API easier to
> use from my POV.

Since you do not resist, I will keep the API the same for v4. But I will
add the @clear_seq check to the kmsg_dump_get functions.

John Ogness
