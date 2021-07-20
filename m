Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB23CF8B9
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhGTKjk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 06:39:40 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:35356 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbhGTKjf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 06:39:35 -0400
Received: by mail-wr1-f41.google.com with SMTP id m2so25614742wrq.2;
        Tue, 20 Jul 2021 04:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xNlpSS0ScizpXZxsSlD/NBLUzLd30uJjVdEiXOvFTP0=;
        b=HMI2KnW+VGtj5zONp7DX868TDV6+LctOYeMbum3O51AADJxzY337/zkGUI40HLUomf
         wXbjQFSrh92YrWnMOYXE20ruF2DzucdDjZ/lwRdx3z+lKkH+1FSpLMHYv6qnLIdzG+Qj
         oxekDTM3i3tbHR0UCmTA2HljruYGuWBNOS7DdxKwVkHTVMWHGxBjwi//5udjhJ4lML2P
         d+KRzcvxaeDGWEUowK+A+j6HRW89ckpToIkOiqf08CttvpvM1j1CjAwO48842XoN7ijO
         AWsYXYjZI3UDfQ2zVE80e2MDHuiWqgw5ZeFOyJpG0F0AcGK9l5SsPC9fcPuSeZSZ6hby
         yCdw==
X-Gm-Message-State: AOAM531X1VMqaPHn4czlENy9xo4ZZqYA3U27pwMk5z/Rn84BWJpebw+B
        D65PxZpRB4sxr1pbQpVgsU8=
X-Google-Smtp-Source: ABdhPJx+77IalUgErDRCqX7ZY2U4QXj5QXATKigVtAIzC48qhRiHTcqzsV2KeeI2A+y+aWXVMWd9Lg==
X-Received: by 2002:adf:e405:: with SMTP id g5mr34783353wrm.365.1626780013363;
        Tue, 20 Jul 2021 04:20:13 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n23sm18452693wms.4.2021.07.20.04.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:20:12 -0700 (PDT)
Date:   Tue, 20 Jul 2021 11:20:11 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com
Subject: Re: [PATCH] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Message-ID: <20210720112011.7nxhiy6iyz4gz3j5@liuwe-devbox-debian-v2>
References: <20210719185126.3740-1-kumarpraveen@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719185126.3740-1-kumarpraveen@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The commit message needs a bit of work.

On Tue, Jul 20, 2021 at 12:21:26AM +0530, Praveen Kumar wrote:
> The root partition is not supposed to write to VP ASSIST PAGE as this MSR
> is specific to Guest VP, and thus below stack is observed.
> 

Yes, root kernel is supposed to write to this MSR, but that's not
because this MSR is specific to children (guest) partitions. It is just
that for root this is read-only.

You should mention VP assist pages for root are pre-determined by the
hypervisor. Root kernel is not allowed to change them to different
locations.

> [    2.778197] unchecked MSR access error: WRMSR to 0x40000073 (tried to write 0x0000000145ac5001) at rIP: 0xffffffff810c1084 (native_write_msr+0x4/0x30)
> [    2.784867] Call Trace:
> [    2.791507]  hv_cpu_init+0xf1/0x1c0
> [    2.798144]  ? hyperv_report_panic+0xd0/0xd0
> [    2.804806]  cpuhp_invoke_callback+0x11a/0x440
> [    2.811465]  ? hv_resume+0x90/0x90
> [    2.818137]  cpuhp_issue_call+0x126/0x130
> [    2.824782]  __cpuhp_setup_state_cpuslocked+0x102/0x2b0
> [    2.831427]  ? hyperv_report_panic+0xd0/0xd0
> [    2.838075]  ? hyperv_report_panic+0xd0/0xd0
> [    2.844723]  ? hv_resume+0x90/0x90
> [    2.851375]  __cpuhp_setup_state+0x3d/0x90
> [    2.858030]  hyperv_init+0x14e/0x410
> [    2.864689]  ? enable_IR_x2apic+0x190/0x1a0
> [    2.871349]  apic_intr_mode_init+0x8b/0x100
> [    2.878017]  x86_late_time_init+0x20/0x30
> [    2.884675]  start_kernel+0x459/0x4fb
> [    2.891329]  secondary_startup_64_no_verify+0xb0/0xbb
> 
> Root partition actually shares the VP ASSIST page with hypervisor, and

So do children partitions. This page is by design shared between
hypervisor and any partitions that use it.

> thus as a solution, this patch memremaps the memory from hypervisor
> during hv_cpu_init and unmaps during hv_cpu_die calls.
> 
> Further, this patch also resolve some error handling and checkpatch
> errors
> 
> Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 57 +++++++++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 6f247e7e07eb..292b17e0b173 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -44,7 +44,7 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>  
>  static int hv_cpu_init(unsigned int cpu)
>  {
> -	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
> +	struct hv_vp_assist_page **hvp = NULL;
>  	int ret;
>  
>  	ret = hv_common_cpu_init(cpu);
> @@ -54,25 +54,43 @@ static int hv_cpu_init(unsigned int cpu)
>  	if (!hv_vp_assist_page)
>  		return 0;
>  
> +	hvp = &hv_vp_assist_page[smp_processor_id()];
> +

Why is this needed? Is it because of checkpatch?

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

This path suggests that it is possible to enter this function with *hvp
already set.

The new path for root is missing this check.

> +	if (hv_root_partition &&
> +	    ms_hyperv.features & HV_MSR_APIC_ACCESS_AVAILABLE) {

Is HV_MSR_APIC_ACCESS_AVAILABLE a root only flag? Shouldn't non-root
kernel check this too?

Wei.
