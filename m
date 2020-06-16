Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898441FAC74
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFPJdp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 05:33:45 -0400
Received: from verein.lst.de ([213.95.11.211]:37209 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgFPJdp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 05:33:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BAFB068AFE; Tue, 16 Jun 2020 11:33:41 +0200 (CEST)
Date:   Tue, 16 Jun 2020 11:33:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Dexuan Cui <decui@microsoft.com>, Christoph Hellwig <hch@lst.de>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: hv_hypercall_pg page permissios
Message-ID: <20200616093341.GA26400@lst.de>
References: <20200407073830.GA29279@lst.de> <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net> <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87y2ooiv5k.fsf@vitty.brq.redhat.com> <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87blljicjm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blljicjm.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 11:29:33AM +0200, Vitaly Kuznetsov wrote:
> it seems we need something like PAGE_KERNEL_READONLY_EXEC but we don't
> seem to have one on x86. Hypercall page is special in a way that the
> guest doesn't need to write there at all. vmalloc_exec() seems to have
> only one other user on x86: module_alloc() and it has other needs.

module_alloc actually is a weak function and overriden on x86 (and many
other architectures) , so it isn't used either (did I mention that I hate
weak functions?)

> On
> ARM, alloc_insn_page() does the following:



> 
> arch/arm64/kernel/probes/kprobes.c:     page = vmalloc_exec(PAGE_SIZE);
> arch/arm64/kernel/probes/kprobes.c-     if (page) {
> arch/arm64/kernel/probes/kprobes.c-             set_memory_ro((unsigned long)page, 1);
> arch/arm64/kernel/probes/kprobes.c-             set_vm_flush_reset_perms(page);
> arch/arm64/kernel/probes/kprobes.c-     }
> 
> What if we do the same? (almost untested):
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e2137070386a..31aadfea589b 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -23,6 +23,7 @@
>  #include <linux/kernel.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/syscore_ops.h>
> +#include <linux/set_memory.h>
>  #include <clocksource/hyperv_timer.h>
>  
>  void *hv_hypercall_pg;
> @@ -383,6 +384,8 @@ void __init hyperv_init(void)
>                 wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
>                 goto remove_cpuhp_state;
>         }
> +       set_memory_ro((unsigned long)hv_hypercall_pg, 1);
> +       set_vm_flush_reset_perms(hv_hypercall_pg);

This should work and might be the best for 5.8, but I think we need
to sort this whole mess out for real.
