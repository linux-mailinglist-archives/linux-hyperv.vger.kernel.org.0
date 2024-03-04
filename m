Return-Path: <linux-hyperv+bounces-1656-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2D286FA05
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Mar 2024 07:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D869281576
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Mar 2024 06:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E003C15B;
	Mon,  4 Mar 2024 06:24:34 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42FBA5E;
	Mon,  4 Mar 2024 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533474; cv=none; b=CFUsGNuDqRJeXv05gaCBFcWRSGigxQKfzGfGF2uQfrV3BcENz8q6eUkYnMlIaxXytAIbPGjiwjcSd/NRfuqik5EukMLtsQtereKdjqNjYTxGBG6/03o1L5zpqVG7N/2azQYP79dVpKk7PJl6sTEnEf2Fkz+7fIhejTPkILL6glY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533474; c=relaxed/simple;
	bh=7cgEFo3Z7KS9w83A6EgR9pr+hmtVWdvYNr+fhPwZlOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLNlPFK6/JdINEac7a/IF29F7I+7DmfvKTZLgGm6qukodspoDpnXUj6LRKIkjr8wMgxAnptd0k/ayld1hglLW1lHXwoTxCHV04bGFOvQwZkgGua5ehc5B2lVRtaZhJzRtuEqLKTiia8T/ZDMGFH+Aa0bE7vaVGVK8hyw57ibdNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6082eab17so730595b3a.1;
        Sun, 03 Mar 2024 22:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709533472; x=1710138272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bhc2/UNlCiB/z3MRcKCqHLzDqMQWaoERtyFDoVG3iM=;
        b=IizX4Z4e42Vl4qLmMArFZnpiunuNNbdQ2i8LizYca0JeR8nwFryK3SUZMHXmjm0Ht+
         25tpxAr8AgH2KdvivRgF9y3Kr7BXUp6YixPzEHGPuMsgie49XPeYZBBvWCzNdA+YNly4
         mr+dtjTbCnggTa/576Wlk7gKUj09SXrOHr0RtIkeZGBkIX0PilWwdYTZt0Kq59k/xP5l
         t8Ruwo9PN0cc3Rd8jR6cNd4wqty2dgY1N5ZmDD3VgB1u4vK7hJk4gqoBX5WCyNBgpLUz
         IZdS49PFdZ18pwpxRLNsbC32WvrWLmSa/dI74qND6IC8gJkwT0mgtAmw3eMZ4VcU8s9/
         1XLg==
X-Forwarded-Encrypted: i=1; AJvYcCVV7uheBkYEAsQwg003lgYdeqGrvBBKIc3dD8sifPSXJHqedjBMP9GaBQE6qCJOcyh5kqaZRKxv4XbgEuU7NXTHDb/Du08RPx6kuUOMQbwv+r+qzT13LHlnITmj8Rler7/2mIAmynBBe47N
X-Gm-Message-State: AOJu0YziujKcPkwTPm/ptZ6DCUr7TuTUZ8jTnzBxo0Izyiw/mXZYYMBC
	CxKaLSFz0X49oW3dec3shkx6wi1Zf+Ic3tmZOqMztMPhx8VZzyMfmtU2I8Pr
X-Google-Smtp-Source: AGHT+IGZDCf5sioWcZ6ZqOHqhTmXWlEvatEqE5jLt/EbHUAUVl7gFv1mmLtXEFQ78yFzcE/adkey/w==
X-Received: by 2002:a05:6a00:b8f:b0:6e6:13ec:7178 with SMTP id g15-20020a056a000b8f00b006e613ec7178mr2529403pfj.32.1709533471890;
        Sun, 03 Mar 2024 22:24:31 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id u15-20020a62d44f000000b006e3635c5641sm6815407pfl.25.2024.03.03.22.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 22:24:31 -0800 (PST)
Date: Mon, 4 Mar 2024 06:24:27 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, dwmw@amazon.co.uk, peterz@infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	ssengar@microsoft.com, mhklinux@outlook.com
Subject: Re: [PATCH v3] x86/hyperv: Use per cpu initial stack for vtl context
Message-ID: <ZeVpG07p9ayjk7yb@liuwe-devbox-debian-v2>
References: <1709452896-13342-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709452896-13342-1-git-send-email-ssengar@linux.microsoft.com>

On Sun, Mar 03, 2024 at 12:01:36AM -0800, Saurabh Sengar wrote:
> Currently, the secondary CPUs in Hyper-V VTL context lack support for
> parallel startup. Therefore, relying on the single initial_stack fetched
> from the current task structure suffices for all vCPUs.
> 
> However, common initial_stack risks stack corruption when parallel startup
> is enabled. In order to facilitate parallel startup, use the initial_stack
> from the per CPU idle thread instead of the current task.
> 
> Fixes: 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")

I don't think this patch is buggy. Instead, it exposes an assumption in
the VTL code. So this either should be dropped or point to the patch
which introduces the assumption.

Let me know what you would prefer.

Thanks,
Wei.

> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
> [V3]
>  - Added the VTL code dependency on SMP to fix kernel build error
>    when SMP is disabled.
> 
>  arch/x86/hyperv/hv_vtl.c | 19 +++++++++++++++----
>  drivers/hv/Kconfig       |  1 +
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 804b629ea49d..b4e233954d0f 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -12,6 +12,7 @@
>  #include <asm/i8259.h>
>  #include <asm/mshyperv.h>
>  #include <asm/realmode.h>
> +#include <../kernel/smpboot.h>
>  
>  extern struct boot_params boot_params;
>  static struct real_mode_header hv_vtl_real_mode_header;
> @@ -58,7 +59,7 @@ static void hv_vtl_ap_entry(void)
>  	((secondary_startup_64_fn)secondary_startup_64)(&boot_params, &boot_params);
>  }
>  
> -static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
> +static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
>  {
>  	u64 status;
>  	int ret = 0;
> @@ -72,7 +73,9 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
>  	struct ldttss_desc *ldt;
>  	struct desc_struct *gdt;
>  
> -	u64 rsp = current->thread.sp;
> +	struct task_struct *idle = idle_thread_get(cpu);
> +	u64 rsp = (unsigned long)idle->thread.sp;
> +
>  	u64 rip = (u64)&hv_vtl_ap_entry;
>  
>  	native_store_gdt(&gdt_ptr);
> @@ -199,7 +202,15 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
>  
>  static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
>  {
> -	int vp_id;
> +	int vp_id, cpu;
> +
> +	/* Find the logical CPU for the APIC ID */
> +	for_each_present_cpu(cpu) {
> +		if (arch_match_cpu_phys_id(cpu, apicid))
> +			break;
> +	}
> +	if (cpu >= nr_cpu_ids)
> +		return -EINVAL;
>  
>  	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
>  	vp_id = hv_vtl_apicid_to_vp_id(apicid);
> @@ -213,7 +224,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
>  		return -EINVAL;
>  	}
>  
> -	return hv_vtl_bringup_vcpu(vp_id, start_eip);
> +	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
>  }
>  
>  int __init hv_vtl_early_init(void)
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 00242107d62e..862c47b191af 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -16,6 +16,7 @@ config HYPERV
>  config HYPERV_VTL_MODE
>  	bool "Enable Linux to boot in VTL context"
>  	depends on X86_64 && HYPERV
> +	depends on SMP
>  	default n
>  	help
>  	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> -- 
> 2.34.1
> 

