Return-Path: <linux-hyperv+bounces-7921-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BFCCA06E8
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 18:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 290AC30014C5
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 17:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B79B32FA04;
	Wed,  3 Dec 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiWKPY2m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D72E2667;
	Wed,  3 Dec 2025 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764782001; cv=none; b=MnlOiAT77mhFesRRlDh/dAehMn1yEM1CdtjctL1DO6h4vDCD77omConUNOBeWTTB5bubPAatTJi91XSOIVm2GjwkyP8dKq0bn6JKnUDZ4o50kfhNZnX8XmL5YqFzF4rXkCGo8SxVsvTMIu6m3+zawcPzDoxfxlGGRe5E8y+vSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764782001; c=relaxed/simple;
	bh=f86vge0vpGZnDRrtakjeKTiXJhXYgzo5SQyPcMfQZ6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeiuNXVeQe5FfDr7TBLq2AAnOqQqyGmrbaAbTki2MajrzK5T8Oih2+17tc3bT7pUYYZlufH64aiUMZo5j2nLLaZQO4hyBVZ9qPo6u9ZKVupmtz9tAz5L22S+PQZN4o/SkBCUEh+GO27D72m4Y6YM99gHGAmA/L2dYuBk6oHG+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiWKPY2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B76C4CEF5;
	Wed,  3 Dec 2025 17:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764782000;
	bh=f86vge0vpGZnDRrtakjeKTiXJhXYgzo5SQyPcMfQZ6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uiWKPY2mUvQl/0Egzdfvt3GbwVYSqVqlPW8NkY1KWFy67O+X4uTydUl9/S+tVhFYy
	 oNfHQfL+xVPKCVYhyezJTyfyitCdhaz+gOnrC+vCL0HSg7u+73qy/OH5gvfFEfPY70
	 +9MV/tSflK236fvMTJEL6auVCO/bbjBXCDrLeQYsFVqZ89rMUPpGRVYKhM+LF4zXcF
	 YcXCRHMOLqgd4RkMdJjEnGzeasJFi68vpAvPsehKQcYbeRvKUFn29ZNtO8wqTTwI8t
	 Z07o9cBtZjQ7F6cVM8g++rSwpywYyfAWvxMQSR5xU6vfUOrM6jfqC/gO8OIxn38Gme
	 XkzGLuO85U3Tw==
Date: Wed, 3 Dec 2025 18:13:14 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Praveen K Paladugu <prapal@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, anbelski@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v6 2/3] hyperv: Use reboot notifier to configure sleep
 state
Message-ID: <aTBvqqdxH-C7tOq2@gmail.com>
References: <20251126215013.11549-1-prapal@linux.microsoft.com>
 <20251126215013.11549-3-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126215013.11549-3-prapal@linux.microsoft.com>

* Praveen K Paladugu <prapal@linux.microsoft.com> wrote:

> Configure sleep state information in mshv hypervisor. This sleep state
> information from ACPI will be used by hypervisor to poweroff the host.
> 
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c       |  1 +
>  arch/x86/include/asm/mshyperv.h |  2 +
>  drivers/hv/mshv_common.c        | 80 +++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e28737ec7054..daf97a984b78 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -555,6 +555,7 @@ void __init hyperv_init(void)
>  
>  		hv_remap_tsc_clocksource();
>  		hv_root_crash_init();
> +		hv_sleep_notifiers_register();
>  	} else {
>  		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>  		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 10037125099a..166053df0484 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -182,8 +182,10 @@ int hyperv_fill_flush_guest_mapping_list(
>  void hv_apic_init(void);
>  void __init hv_init_spinlocks(void);
>  bool hv_vcpu_is_preempted(int vcpu);
> +void hv_sleep_notifiers_register(void);
>  #else
>  static inline void hv_apic_init(void) {}
> +static inline void hv_sleep_notifiers_register(void) {};
>  #endif
>  
>  struct irq_domain *hv_create_pci_msi_domain(void);

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

