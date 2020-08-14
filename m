Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26185244740
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Aug 2020 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgHNJoH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Aug 2020 05:44:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36335 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgHNJoH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 05:44:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so7411390wmi.1;
        Fri, 14 Aug 2020 02:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qxju5gCtdZfDOIWTLAir45a9M2m86cvcOQuRF45cqVw=;
        b=CMp1fYrl6DpF1s/9XOdxxhJKjN12LzlVhxLnPmMQ8C07MjHniaTu0xvGX6W/ahER4c
         KnzqT6AGxuwS9pgcYw4lVPzSXo9b/gG1itYluFRUt+akcyNW75chpUNM31RQj8Kb/Cxa
         CZVsU6wmj08mvApqsQyNnN/AErSpvei8cpOv/ze5DMc0IH+qDom6nkD+JI6uc4uxMn23
         CDn4eRubMsRv2HKKsGWeku3r1Yc20qVw0Lu7u5JRX2P8tP7MsVltqBflgItIu7eAWuhf
         e40z+pXd0JsSRncsm45zinFwlxZixZRz14XB2kPiaRoWBa5pLVccxDKERh1J1w1FGJfY
         R2Eg==
X-Gm-Message-State: AOAM533u1y6TH3Sy/k7x9WGCme1nvUk3BGWFhOJZBgy71XYaTgfnWJ5j
        zB8Wqf4roKd0OuCuaE265Ng=
X-Google-Smtp-Source: ABdhPJxCVxYpk7RwkD/3Vl6aY71IkXz6sNRRIKFHFxjDmASbOU7JKqDHKDrU6WuIbO04S1M8Q6/PRg==
X-Received: by 2002:a1c:6a03:: with SMTP id f3mr1857480wmc.181.1597398245369;
        Fri, 14 Aug 2020 02:44:05 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i7sm15001164wrs.25.2020.08.14.02.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 02:44:04 -0700 (PDT)
Date:   Fri, 14 Aug 2020 09:44:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Add parsing of VMbus interrupt
 in ACPI DSDT
Message-ID: <20200814094403.uhgrc74khr5vcyva@liuwe-devbox-debian-v2>
References: <1597362679-37965-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597362679-37965-1-git-send-email-mikelley@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 13, 2020 at 04:51:19PM -0700, Michael Kelley wrote:
> On ARM64, Hyper-V now specifies the interrupt to be used by VMbus
> in the ACPI DSDT.  This information is not used on x86 because the
> interrupt vector must be hardcoded.  But update the generic
> VMbus driver to do the parsing and pass the information to the
> architecture specific code that sets up the Linux IRQ.  Update
> consumers of the interrupt to get it from an architecture specific
> function.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h |  1 +
>  arch/x86/kernel/cpu/mshyperv.c  |  3 ++-
>  drivers/hv/hv.c                 |  2 +-
>  drivers/hv/vmbus_drv.c          | 30 +++++++++++++++++++++++++++---
>  include/asm-generic/mshyperv.h  |  4 +++-
>  5 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 4f77b8f..ffc2899 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -54,6 +54,7 @@ typedef int (*hyperv_fill_flush_list_func)(
>  #define hv_enable_vdso_clocksource() \
>  	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
>  #define hv_get_raw_timer() rdtsc_ordered()
> +#define hv_get_vector() HYPERVISOR_CALLBACK_VECTOR
>  
>  /*
>   * Reference to pv_ops must be inline so objtool
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 3112544..538aa87 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -55,9 +55,10 @@
>  	set_irq_regs(old_regs);
>  }
>  
> -void hv_setup_vmbus_irq(void (*handler)(void))
> +int hv_setup_vmbus_irq(int irq, void (*handler)(void))
>  {

irq is not used here. Did you perhaps forget to commit a chunk of code?

>  	vmbus_handler = handler;
> +	return 0;
>  }

Wei.
