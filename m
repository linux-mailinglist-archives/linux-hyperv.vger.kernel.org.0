Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147BD32A667
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Mar 2021 17:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384245AbhCBOzw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Mar 2021 09:55:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:58544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239578AbhCBN44 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Mar 2021 08:56:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614693328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2zHzG0WPsx3xKiPqPnMCcC9JpT/COf8SAqNxgYPDcwI=;
        b=oL4v99bE7SLyOQloEmxBm5+k/xMRvTkk4pt/OG8qvLA6b9DdiRhtxaD+0nUB4F5N4OQcsj
        Ic/6CdYJx/OPu8rlCqsNQGpM38HYhSfsHpGptacoyamFaVFqs7/yek3tHvqyg/+qcdd+DL
        OfjwuhDgZRqJTg+9ADLiziF6AFqEqM8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5718AAFF5;
        Tue,  2 Mar 2021 13:55:28 +0000 (UTC)
Date:   Tue, 2 Mar 2021 14:55:26 +0100
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
Message-ID: <YD5DzldNpnzuECaA@alley>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
 <20210225202438.28985-13-john.ogness@linutronix.de>
 <YD0tbVV+hZOFvWyB@alley>
 <87lfb5pu8c.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfb5pu8c.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue 2021-03-02 14:20:51, John Ogness wrote:
> On 2021-03-01, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> >> index 532f22637783..5a64b24a91c2 100644
> >> --- a/arch/powerpc/kernel/nvram_64.c
> >> +++ b/arch/powerpc/kernel/nvram_64.c
> >> @@ -681,13 +680,14 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
> >>  		return;
> >>  
> >>  	if (big_oops_buf) {
> >> -		kmsg_dump_get_buffer(dumper, false,
> >> +		kmsg_dump_rewind(&iter);
> >
> > It would be nice to get rid of the kmsg_dump_rewind(&iter) calls
> > in all callers.
> >
> > A solution might be to create the following in include/linux/kmsg_dump.h
> >
> > Then we could do the following at the beginning of both
> > kmsg_dump_get_buffer() and kmsg_dump_get_line():
> >
> > 	u64 clear_seq = latched_seq_read_nolock(&clear_seq);
> >
> > 	if (iter->cur_seq < clear_seq)
> > 		cur_seq = clear_seq;
> 
> I suppose we need to add this part anyway, if we want to enforce that
> records before @clear_seq are not to be available for dumpers.

Yup.

> > It might be better to avoid the infinite loop. We could do the following:
> >
> > static void check_and_set_iter(struct kmsg_dump_iter)
> > {
> > 	if (iter->cur_seq == 0 && iter->next_seq == U64_MAX) {
> > 		kmsg_dump_rewind(iter);
> > }
> >
> > and call this at the beginning of both kmsg_dump_get_buffer()
> > and kmsg_dump_get_line()
> >
> > What do you think?
> 
> On a technical level, it does not make any difference. It is pure
> cosmetic.

Yup.

> Personally, I prefer the rewind directly before the kmsg_dump_get calls
> because it puts the initializer directly next to the user.
> 
> As an example to illustrate my view, I prefer:
> 
>     for (i = 0; i < n; i++)
>         ...;
> 
> instead of:
> 
>     int i = 0;
> 
>     ...
> 
>     for (; i < n; i++)
>         ...;
> 
> Also, I do not really like the special use of 0/U64_MAX to identify
> special actions of the kmsg_dump_get functions.

Fair enough.

> > Note that I do not resist on it. But it might make the API easier to
> > use from my POV.
> 
> Since you do not resist, I will keep the API the same for v4. But I will
> add the @clear_seq check to the kmsg_dump_get functions.

Go for it.

Best Regards,
Petr
