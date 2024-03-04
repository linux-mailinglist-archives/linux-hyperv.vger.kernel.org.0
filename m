Return-Path: <linux-hyperv+bounces-1659-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED3486FA7A
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Mar 2024 08:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B227B1F2102A
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Mar 2024 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ADA12E72;
	Mon,  4 Mar 2024 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OsJW4yDh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C3712E4F;
	Mon,  4 Mar 2024 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536099; cv=none; b=IDNywbP02tf81LtZc/zWX9rPqvisMFZT5SualRn+Chv94trFuzX/TFJ7P1rdeZkuXLMZqio1UJCXNobk6N+9D1N0tsOtasZ/Sjtsbf6NsJJT6tcO0X0WCXFayem3YUfumIUuBzTv2aNvaXxEwiV6qMpYXJXYJyE1fnBaooSGxv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536099; c=relaxed/simple;
	bh=85CjglgMm8FIeWTxu2nlk+0mIr4+9dhpjr8AGjXgTj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPB/xAE3aK+JyNHFRdM+g5gKgd4bI/1bCNDJkZiyFJc/a0hm1NZ92derlHQa/ZWxztVQeNMvLymD2S1+BeJSkNaFmTPmnjxiAku8pnDv9LM9vF1/znh6E4xgzLOJiepoVWRPvd4DfE/BSJUt6FjUjPX0+2TYaEWDx80s3N82LgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OsJW4yDh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 1CE1220B74C0; Sun,  3 Mar 2024 23:08:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CE1220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709536097;
	bh=9pO23Pg5PwijYFQsb1h5+UWzqjRYkZ7j/df8N5fJN/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OsJW4yDhbvbHNx7GnAKnTRfP/quYg8LO2oJxJ6v2+b6xuatqvDXie56KHJvZk3+1t
	 Lq73c11RhfqbKt0QvQm9LmaqP1ryVkY5cELKAC/VZAe8c+PKMl7ENghGyuumM/52kO
	 NmTJYGeZ9LcrU5piFiJK6ctqKmHVenAUsFAOHo1s=
Date: Sun, 3 Mar 2024 23:08:17 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	dwmw@amazon.co.uk, peterz@infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	ssengar@microsoft.com, mhklinux@outlook.com
Subject: Re: [PATCH v3] x86/hyperv: Use per cpu initial stack for vtl context
Message-ID: <20240304070817.GA501@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1709452896-13342-1-git-send-email-ssengar@linux.microsoft.com>
 <ZeVpG07p9ayjk7yb@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeVpG07p9ayjk7yb@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Mar 04, 2024 at 06:24:27AM +0000, Wei Liu wrote:
> On Sun, Mar 03, 2024 at 12:01:36AM -0800, Saurabh Sengar wrote:
> > Currently, the secondary CPUs in Hyper-V VTL context lack support for
> > parallel startup. Therefore, relying on the single initial_stack fetched
> > from the current task structure suffices for all vCPUs.
> > 
> > However, common initial_stack risks stack corruption when parallel startup
> > is enabled. In order to facilitate parallel startup, use the initial_stack
> > from the per CPU idle thread instead of the current task.
> > 
> > Fixes: 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")
> 
> I don't think this patch is buggy. Instead, it exposes an assumption in
> the VTL code. So this either should be dropped or point to the patch
> which introduces the assumption.
> 
> Let me know what you would prefer.

The VTL code will crash if this fix is not present post above mentioned patch:
18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE").
So I would prefer a fixes which added the assumption in VTL:

Fixes: 3be1bc2fe9d2 ("x86/hyperv: VTL support for Hyper-V")

Please let me know if you need V4 for it.

> 
> Thanks,
> Wei.
> 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> > [V3]
> >  - Added the VTL code dependency on SMP to fix kernel build error
> >    when SMP is disabled.
> > 
> >  arch/x86/hyperv/hv_vtl.c | 19 +++++++++++++++----
> >  drivers/hv/Kconfig       |  1 +
> >  2 files changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> > index 804b629ea49d..b4e233954d0f 100644
> > --- a/arch/x86/hyperv/hv_vtl.c
> > +++ b/arch/x86/hyperv/hv_vtl.c
> > @@ -12,6 +12,7 @@
> >  #include <asm/i8259.h>
> >  #include <asm/mshyperv.h>
> >  #include <asm/realmode.h>
> > +#include <../kernel/smpboot.h>
> >  
> >  extern struct boot_params boot_params;
> >  static struct real_mode_header hv_vtl_real_mode_header;
> > @@ -58,7 +59,7 @@ static void hv_vtl_ap_entry(void)
> >  	((secondary_startup_64_fn)secondary_startup_64)(&boot_params, &boot_params);
> >  }
> >  
> > -static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
> > +static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
> >  {
> >  	u64 status;
> >  	int ret = 0;
> > @@ -72,7 +73,9 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
> >  	struct ldttss_desc *ldt;
> >  	struct desc_struct *gdt;
> >  
> > -	u64 rsp = current->thread.sp;
> > +	struct task_struct *idle = idle_thread_get(cpu);
> > +	u64 rsp = (unsigned long)idle->thread.sp;
> > +
> >  	u64 rip = (u64)&hv_vtl_ap_entry;
> >  
> >  	native_store_gdt(&gdt_ptr);
> > @@ -199,7 +202,15 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
> >  
> >  static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
> >  {
> > -	int vp_id;
> > +	int vp_id, cpu;
> > +
> > +	/* Find the logical CPU for the APIC ID */
> > +	for_each_present_cpu(cpu) {
> > +		if (arch_match_cpu_phys_id(cpu, apicid))
> > +			break;
> > +	}
> > +	if (cpu >= nr_cpu_ids)
> > +		return -EINVAL;
> >  
> >  	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
> >  	vp_id = hv_vtl_apicid_to_vp_id(apicid);
> > @@ -213,7 +224,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
> >  		return -EINVAL;
> >  	}
> >  
> > -	return hv_vtl_bringup_vcpu(vp_id, start_eip);
> > +	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
> >  }
> >  
> >  int __init hv_vtl_early_init(void)
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index 00242107d62e..862c47b191af 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -16,6 +16,7 @@ config HYPERV
> >  config HYPERV_VTL_MODE
> >  	bool "Enable Linux to boot in VTL context"
> >  	depends on X86_64 && HYPERV
> > +	depends on SMP
> >  	default n
> >  	help
> >  	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> > -- 
> > 2.34.1
> > 

