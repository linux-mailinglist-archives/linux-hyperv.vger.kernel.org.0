Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7F83D2213
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jul 2021 12:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhGVJrL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jul 2021 05:47:11 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:46693 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhGVJrK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jul 2021 05:47:10 -0400
Received: by mail-wr1-f49.google.com with SMTP id d12so5320324wre.13;
        Thu, 22 Jul 2021 03:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HwowVUI9D1rPovF81Wa9afDqFuAo1nrAAriXPs7RICc=;
        b=pNnD6hJR1//IYJLiKkCrwNLOMxN6TNh6A6THxR/Q/28msNgQ722jK56Z3DJICMTZe1
         lsXhs/l9Cv9Vm8vphA4IruVcCKfoX/ONcZaUUElB/viTYfHrSN4MYc53A3kkXV/NKduh
         5tXteM+rnbEZeDdm+AJYfGKCKsrVdgKsQfCUDoP1Now462wrpiWqIOoVMH9oir5pADXg
         I3aeVs+x17CyskjwrNyKH2gVXMjulul4nf18mYIJmkAbz2pNX0JrIEfBZm2UPrLmppm5
         ps2VLYM+hQBClQGin7t32tP8tXm7qalYhk1cJEQ9/JlzpAyNhn2cbrVllN10La1d/O+U
         dIww==
X-Gm-Message-State: AOAM530lqwzi4HKUoUrsbEDMkyX9+tCFX8zXYf4DpZJFyGWCqOF0Xtvi
        2X4Es87B2VwDLbLy6xgixvQ=
X-Google-Smtp-Source: ABdhPJzjKDWTKHrmBw8NjQQvc23o+nbklcj/ynVT3NTvcUt5s7G06lnmadTcDqjheE9EuWanJgRSEA==
X-Received: by 2002:adf:f9c9:: with SMTP id w9mr46685607wrr.107.1626949663922;
        Thu, 22 Jul 2021 03:27:43 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f13sm30998763wrt.86.2021.07.22.03.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 03:27:43 -0700 (PDT)
Date:   Thu, 22 Jul 2021 10:27:41 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com
Subject: Re: [PATCH v2] hyperv: root partition faults writing to VP ASSIST
 MSR PAGE
Message-ID: <20210722102741.vl4fvv3abifru2ge@liuwe-devbox-debian-v2>
References: <20210721180302.18764-1-kumarpraveen@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721180302.18764-1-kumarpraveen@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 21, 2021 at 11:33:02PM +0530, Praveen Kumar wrote:
> For Root partition the VP assist pages are pre-determined by the
> hypervisor. The Root kernel is not allowed to change them to
> different locations. And thus, we are getting below stack as in
> current implementation Root is trying to perform write to specific
> MSR.
> 
> [ 2.778197] unchecked MSR access error: WRMSR to 0x40000073 (tried to
> write 0x0000000145ac5001) at rIP: 0xffffffff810c1084
> (native_write_msr+0x4/0x30)
> [ 2.784867] Call Trace:
> [ 2.791507] hv_cpu_init+0xf1/0x1c0
> [ 2.798144] ? hyperv_report_panic+0xd0/0xd0
> [ 2.804806] cpuhp_invoke_callback+0x11a/0x440
> [ 2.811465] ? hv_resume+0x90/0x90
> [ 2.818137] cpuhp_issue_call+0x126/0x130
> [ 2.824782] __cpuhp_setup_state_cpuslocked+0x102/0x2b0
> [ 2.831427] ? hyperv_report_panic+0xd0/0xd0
> [ 2.838075] ? hyperv_report_panic+0xd0/0xd0
> [ 2.844723] ? hv_resume+0x90/0x90
> [ 2.851375] __cpuhp_setup_state+0x3d/0x90
> [ 2.858030] hyperv_init+0x14e/0x410
> [ 2.864689] ? enable_IR_x2apic+0x190/0x1a0
> [ 2.871349] apic_intr_mode_init+0x8b/0x100
> [ 2.878017] x86_late_time_init+0x20/0x30
> [ 2.884675] start_kernel+0x459/0x4fb
> [ 2.891329] secondary_startup_64_no_verify+0xb0/0xbb
> 
> Since, the hypervisor already provides the VP assist page for root
> partition, we need to memremaps the memory from hypervisor for root
> kernel to use. The mapping is done in hv_cpu_init during bringup and
> is unmaped in hv_cpu_die during teardown.
> 
> Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 53 ++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 17 deletions(-)
> 
> changelog:
> v1: initial patch
> v2: commit message changes, removal of HV_MSR_APIC_ACCESS_AVAILABLE
>     check and addition of null check before reading the VP assist MSR
>     for root partition
> 
> ---
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 6f247e7e07eb..ffd3d3b37235 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -55,26 +55,41 @@ static int hv_cpu_init(unsigned int cpu)
>  		return 0;
>  
>  	/*
> -	 * The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's Section
> -	 * 5.2.1 "GPA Overlay Pages"). Here it must be zeroed out to make sure
> -	 * we always write the EOI MSR in hv_apic_eoi_write() *after* the
> -	 * EOI optimization is disabled in hv_cpu_die(), otherwise a CPU may
> -	 * not be stopped in the case of CPU offlining and the VM will hang.
> +	 * For Root partition we need to map the hypervisor VP ASSIST PAGE
> +	 * instead of allocating a new page.
>  	 */
> -	if (!*hvp) {
> -		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
> -	}
> +	if (hv_root_partition) {
> +		union hv_x64_msr_hypercall_contents hypercall_msr;
> +
> +		rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, hypercall_msr.as_uint64);
> +		/* remapping to root partition address space */
> +		if (!*hvp)
> +			*hvp = memremap(hypercall_msr.guest_physical_address <<
> +					HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
> +					PAGE_SIZE, MEMREMAP_WB);
> +		WARN_ON(!(*hvp));
> +	} else {
> +		/*
> +		 * The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's
> +		 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
> +		 * out to make sure we always write the EOI MSR in
> +		 * hv_apic_eoi_write() *after* theEOI optimization is disabled
> +		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
> +		 * case of CPU offlining and the VM will hang.
> +		 */
> +		if (!*hvp)
> +			*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
>  
> -	if (*hvp) {
> -		u64 val;
> +		if (*hvp) {
> +			u64 val;
>  
> -		val = vmalloc_to_pfn(*hvp);
> -		val = (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
> -			HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
> +			val = vmalloc_to_pfn(*hvp);
> +			val = (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
> +				HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
>  
> -		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
> +			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
> +		}
>  	}
> -
>  	return 0;
>  }
>  
> @@ -170,8 +185,12 @@ static int hv_cpu_die(unsigned int cpu)
>  
>  	hv_common_cpu_die(cpu);
>  
> -	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
> -		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> +		if (hv_root_partition)
> +			memunmap(hv_vp_assist_page[cpu]);

I think about this a bit more, the NULL check for *hvp in hv_cpu_init in
the original code is perhaps due to the code has opted to not free the
page when disabling the VP assist page. When the CPU is brought back
online, it does not want to allocate another page, but to use the one
that's already allocated.

So, since you listened to my suggestion to add a similar check, you need
to reset hv_vp_assist_page to NULL here. Alternatively the check for
*hvp can be dropped for the root path. Either way, the difference
between root and non-root should be documented.

Wei.

> +		else
> +			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> +	}
>  
>  	if (hv_reenlightenment_cb == NULL)
>  		return 0;
> -- 
> 2.25.1
> 
