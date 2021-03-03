Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2706532C6B5
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Mar 2021 02:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344997AbhCDA3z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Mar 2021 19:29:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:50134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383820AbhCCPfI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Mar 2021 10:35:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614785659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6vUEHEmOuwjOvJINqvANTs3pqAUVxWFEfsNxLOcO0g=;
        b=ba9WkkdYwntSk2Jk4/7eOyr/mGac1IGxTizYSuaSkMmIyBWh/+Whf+/fBKRTHbqnYqcObq
        YMo4v76fMNV3+mbDXS8sQOyDuKevTNHD3YjQOxhQhxDyZYp4/Or6lavqaScPzfGWDLfof4
        Bvu2S5SwUiCNZAvZwFiKSeBZbG2HpOM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E4AAAC24;
        Wed,  3 Mar 2021 15:34:19 +0000 (UTC)
Date:   Wed, 3 Mar 2021 16:34:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
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
Subject: Re: [PATCH next v4 00/15] printk: remove logbuf_lock
Message-ID: <YD+seF3dQUoPcZP7@alley>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303101528.29901-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed 2021-03-03 11:15:13, John Ogness wrote:
> Hello,
> 
> Here is v4 of a series to remove @logbuf_lock, exposing the
> ringbuffer locklessly to both readers and writers. v3 is
> here [0].

The series look ready. I am going to push it into printk/linux.git
the following week unless anyone speaks against it in the meantime.

Best Regards,
Petr
