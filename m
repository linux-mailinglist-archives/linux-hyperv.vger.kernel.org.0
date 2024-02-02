Return-Path: <linux-hyperv+bounces-1502-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BEB84667E
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Feb 2024 04:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3818928D3C3
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Feb 2024 03:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084B3F4E4;
	Fri,  2 Feb 2024 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aawybKbj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4FFF500;
	Fri,  2 Feb 2024 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844342; cv=none; b=a63AJoo7CeOOZKJp7NLSP5d67ISW5djIaYRZlbbbn/nrzL7XkNSmnrSlL3/jceq05QKE2tx1Y15A8eNbalzFDPd5q8gCD02nPw5NqGQo9WWpTu90Ceb3oWgq8KG9O0cBLEnW7UGrzxUP7oYXcvoLtLaf40zNBuVG13L8vSmiscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844342; c=relaxed/simple;
	bh=5FqF6XjRAP7FUafdp3VbHh6CWxWN40EUhF23QZ+j5mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLTY7Ww9CXRSXwKgzP9w2oVWAtZjF4Np6VHvzz6QUg8zvtnBvpRxS0xCDyyx3luAqtGu2cWOjzBKFbcgvgjir6ZWadjVzxzCRMQo2WDIBt/8rf5heXrMTDFN+0GHxZgn5DdktprHj/1bapE2aVn2+nv6sN2zD97MArV0SMvDgXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aawybKbj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id DF85B206FCE2; Thu,  1 Feb 2024 19:25:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF85B206FCE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706844340;
	bh=rBO9aX1g8nZoaH4O94txNiEXsHgf2YweqLUV2Mz2V5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aawybKbjyvNmR21bUKDWIESmZatr9ZF7K0kQRiVSnVEbqwlHg6o+fk2/f9jD8UWH2
	 VCRWwEJhyMKTjwinwPKR816umJQbaOFqQUT2FMgsfM0cXo+y3wAjMJhuv1pMCDO2TW
	 XaylzByrLYdXl5olfUBf1c7DiO5g7kJLbQ3hRJ5g=
Date: Thu, 1 Feb 2024 19:25:40 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>
Subject: Re: [PATCH] x86/hyperv: Use per cpu initial stack for vtl context
Message-ID: <20240202032540.GA13603@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1706811931-3579-1-git-send-email-ssengar@linux.microsoft.com>
 <SN6PR02MB415750EE9132ECB049D7B20AD4432@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415750EE9132ECB049D7B20AD4432@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Feb 01, 2024 at 07:53:59PM +0000, Michael Kelley wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, February 1, 2024 10:26 AM
> > 
> > Currently, the secondary vCPUs in Hyper-V VTL context lack support for
> > parallel startup. Therefore, relying on the single initial_stack fetched
> > from the current task structure suffices for all vCPUs.
> > 
> > However, common initial_stack risks stack corruption when parallel startup
> > is enabled. In order to facilitate parallel startup, use the initial_stack
> > from the per CPU idle thread instead of the current task.
> > 
> > Fixes: 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_vtl.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> > index 96e6c51515f5..a54b46b673de 100644
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
> > @@ -71,7 +72,8 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
> >  	struct ldttss_desc *ldt;
> >  	struct desc_struct *gdt;
> > 
> > -	u64 rsp = current->thread.sp;
> > +	struct task_struct *idle = idle_thread_get(target_vp_index);
> 
> The "VP index" of a vCPU is a Hyper-V concept, and may not match
> the Linux concept of a CPU number.   In most cases, they *do* match,
> so your testing of this patch probably worked.  But there's no guarantee
> that they match.  The Hyper-V TLFS does not even guarantee that VP
> indices are dense or that they start with 0 (even though they do in
> current versions of Hyper-V).
> 
> As a different kind of example, in a kdump kernel, Linux labels the
> booting CPU as CPU 0, but it may not be the 0th CPU in the guest
> VM, and hence may not have VP index of 0.  Of course, in a kdump
> kernel nr_cpus is typically 1, so you aren't bringing up secondary
> CPUs.  But sometimes kdump kernels boot with nr_cpus=2 or greater,
> in which case the mismatch would occur.
> 
> This conceptual difference in VP index and Linux CPU numbers is why
> the hv_vp_index array exists -- to map from a Linux CPU number to a
> Hyper-V VP index, and thereby avoid assuming they are equal.
> 
> So before hv_vtl_wakeup_secondary_cpu() calls this function, it needs
> to separately map the apicid to a Linux CPU number, which can then
> be passed to idle_thread_get().
> 
> Michael

Thanks for the review. I will fix this in V2.

> 
> > +	u64 rsp = (unsigned long)idle->thread.sp;
> >  	u64 rip = (u64)&hv_vtl_ap_entry;
> > 
> >  	native_store_gdt(&gdt_ptr);
> > --
> > 2.34.1
> > 
> 

