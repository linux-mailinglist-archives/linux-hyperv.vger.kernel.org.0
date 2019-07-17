Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59FFC6C369
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jul 2019 01:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfGQXDx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Jul 2019 19:03:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55555 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfGQXDx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Jul 2019 19:03:53 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hnsxW-0006ey-Qb; Thu, 18 Jul 2019 01:03:39 +0200
Date:   Thu, 18 Jul 2019 01:03:37 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dexuan Cui <decui@microsoft.com>
cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] x86/hyper-v: Zero out the VP assist page to fix CPU
 offlining
In-Reply-To: <PU1P153MB01697CBE66649B4BA91D8B48BFFA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Message-ID: <alpine.DEB.2.21.1907180058210.1778@nanos.tec.linutronix.de>
References: <PU1P153MB01697CBE66649B4BA91D8B48BFFA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dexuan,

On Thu, 4 Jul 2019, Dexuan Cui wrote:

> When a CPU is being offlined, the CPU usually still receives a few
> interrupts (e.g. reschedule IPIs), after hv_cpu_die() disables the
> HV_X64_MSR_VP_ASSIST_PAGE, so hv_apic_eoi_write() may not write the EOI
> MSR, if the apic_assist field's bit0 happens to be 1; as a result, Hyper-V
> may not be able to deliver all the interrupts to the CPU, and the CPU may
> not be stopped, and the kernel will hang soon.
> 
> The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's Section
> 5.2.1 "GPA Overlay Pages"), so with this fix we're sure the apic_assist
> field is still zero, after the VP ASSIST PAGE is disabled.
> 
> Fixes: ba696429d290 ("x86/hyper-v: Implement EOI assist")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 0e033ef11a9f..db51a301f759 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -60,8 +60,14 @@ static int hv_cpu_init(unsigned int cpu)
>  	if (!hv_vp_assist_page)
>  		return 0;
>  
> +	/*
> +	 * The ZERO flag is necessary, because in the case of CPU offlining
> +	 * the page can still be used by hv_apic_eoi_write() for a while,
> +	 * after the VP ASSIST PAGE is disabled in hv_cpu_die().
> +	 */
>  	if (!*hvp)
> -		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
> +		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO,
> +				 PAGE_KERNEL);

This is the allocation when the CPU is brought online for the first
time. So what effect has zeroing at allocation time vs. offlining and
potentially receiving IPIs? That allocation is never freed.

Neither the comment nor the changelog make any sense to me.

Thanks,

	tglx

