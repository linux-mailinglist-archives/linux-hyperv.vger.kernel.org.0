Return-Path: <linux-hyperv+bounces-2935-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C10296A837
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2024 22:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13431C244BF
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2024 20:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B2C1A4F18;
	Tue,  3 Sep 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXjjmNlS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66FB1DC745;
	Tue,  3 Sep 2024 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394760; cv=none; b=Sp3oP3S29XLfPhVp3rzPJW5YESYmNUasG+qk0utyAVOL8ghuMsEV3DDIn2dQIbW9RpQwQS2Xjsvw0RzJfKnQIkeDHKi+qco0m7SHj/gW1dvWOr7mpEC+jQItSvREtjF47ThIPAaKy/DN9SgsqRW5If9ctCgSQt9sHKrdyQGLqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394760; c=relaxed/simple;
	bh=dz+tMp2ATV+JMYyjOvthXfNM9cjRqAmDrGururm2O6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyH/zTIbi0ENJ5Hn4f8GIFuk016cgwSKPRDPiIukASaUOChDcdatnrj48u+XbIzk1ws8s3kb+EE8jJFAllXalQp3bPrgA0ZkoU6vID/esqUE9z7lg+ZZYEnQLiKOdQMuSQXrODantPhkMpPtqzcaxQGSvCXS0rCTsgTpvohYip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXjjmNlS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725394759; x=1756930759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dz+tMp2ATV+JMYyjOvthXfNM9cjRqAmDrGururm2O6c=;
  b=AXjjmNlSbl0HoGS3e6t9P3n1xkXcxWHoa460Q+U8oVbUPKVQCvYKC5tN
   YiK2PfAfcC7Ffd3Z4KukVJDxcAFqCJYLI0anCzGNtk/s4nkZkjWhTMFjL
   PZcG4xya+GdgFx+sCJ+N+EY/Ppnqd3y2UskLz7KgeiEYs4VSFv4j7yXdq
   9yuzmt4pp1wBjrUiC1EaHcDPR9RYuXWQROcAHvP8Y+ArpA4Lt2HQq+j11
   Zbrwr0J7ysukUdHoyX8pY8cRKsBNUeGa6Qe653S991D4FPMzxX3SbrVj0
   tJoYIJJIxoekqjNJ9EImyU0y4oO3q6H499rj1gb3rKOE3v0BI6csu9nX7
   g==;
X-CSE-ConnectionGUID: 3Evnodn6RbqaBQ/iFdWkNA==
X-CSE-MsgGUID: HxNAq2XXSm6sEamqCBeWjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="27777150"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="27777150"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 13:19:18 -0700
X-CSE-ConnectionGUID: ltyab9DsRua7EElXVGzqoQ==
X-CSE-MsgGUID: D0DsWEa0Q8utcPlFEBDd3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65748857"
Received: from unknown (HELO localhost) ([10.79.232.150])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 13:19:17 -0700
Date: Tue, 3 Sep 2024 13:19:17 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 4/9] x86/hyperv: Parse the ACPI wakeup mailbox
Message-ID: <20240903201917.GB105@yjiang5-mobl.amr.corp.intel.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-5-yunhong.jiang@linux.intel.com>
 <BN7PR02MB4148CC3F9091BC2604E457CFD4922@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR02MB4148CC3F9091BC2604E457CFD4922@BN7PR02MB4148.namprd02.prod.outlook.com>

On Mon, Sep 02, 2024 at 03:35:13AM +0000, Michael Kelley wrote:
> From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > 
> > Parse the wakeup mailbox VTL2 TDX guest. Put it to the guest_late_init, so
> > that it will be invoked before hyperv_init() where the mailbox address is
> > checked.
> 
> Could you elaborate on the choice to set the wakeup_mailbox_address
> in ms_hyperv_late_init()? The code in hv_common.c is intended to be
> code that is architecture neutral (see the comment at the top of the module),
> so it's a red flag to see #ifdef CONFIG_X86_64. Couldn't the
> wakeup_mailbox_address be set in the x86 version of hyperv_init()
> before it is needed?

Sure, will try to put it in hyperv_init() before it's needed.
> 
> > 
> > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > ---
> >  arch/x86/include/asm/mshyperv.h | 3 +++
> >  arch/x86/kernel/cpu/mshyperv.c  | 2 ++
> >  drivers/hv/hv_common.c          | 8 ++++++++
> >  3 files changed, 13 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index 390c4d13956d..5178b96c7fc9 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -10,6 +10,7 @@
> >  #include <asm/nospec-branch.h>
> >  #include <asm/paravirt.h>
> >  #include <asm/mshyperv.h>
> > +#include <asm/madt_wakeup.h>
> > 
> >  /*
> >   * Hyper-V always provides a single IO-APIC at this MMIO address.
> > @@ -49,6 +50,8 @@ extern u64 hv_current_partition_id;
> > 
> >  extern union hv_ghcb * __percpu *hv_ghcb_pg;
> > 
> > +extern u64 wakeup_mailbox_addr;
> > +
> >  bool hv_isolation_type_snp(void);
> >  bool hv_isolation_type_tdx(void);
> >  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index 3d4237f27569..f6b727b4bd0b 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -43,6 +43,8 @@ struct ms_hyperv_info ms_hyperv;
> >  bool hyperv_paravisor_present __ro_after_init;
> >  EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
> > 
> > +u64 wakeup_mailbox_addr;
> 
> This value duplicates acpi_mp_wake_mailbox_paddr in
> madt_wakeup.c. It looks like the duplicate value is used
> for two things:
> 
> 1) In hv_is_private_mmio_tdx() to control the encrypted
> vs. decrypted mapping (Patch 5 of this series)
> 
> 2) As a boolean in hv_vtl_early_init() to avoid overwriting
> the wakeup_secondary_cpu_64 value when
> dtb_parse_mp_wake() has set it to acpi_wakeup_cpu().
> (Patch 9 of this series).
> 
> Having a duplicate value is messy, and I'm wondering if
> it can be avoided. For (1), hv_private_mmio_tdx() could call
> into a function added to madt_wakeup.c to make the
> check.  For (2), the check should probably be based on
> hv_isolation_type_tdx() instead of whether the wakeup
> mailbox address is set.  I'll note that Patch 5 of this series
> is using hv_isolation_type_tdx(), so there's a bit of an
> inconsistency in testing the wakeup_mailbox_addr in
> Patch 9.

I think your comment includes two points, the duplicated variables and the
incosistency in the testing.

Thank you for pointing out the duplication of wakeup_mailbox_addr with
acpi_mp_wake_mailbox_paddr. I didn't realize it. Yes, such duplication should be
avoided and will fix it in next submission.

Agree the inconsistency in testing wakeup_mailbox_addr and
hv_isolation_type_tdx() is not good. IMHO, the wakeup_mailbox_addr (or the new
function you proposed) is better than hv_isolation_type_tdx(), since the
wakeup_mailbox_addr is more directly related.  But hv_vtl_init_platform()
happens before DT parse, thus I have to use the hv_isolation_type_tdx() in it. I
don't have a good idea on how to fix this.

Thanks
--jyh

> 
> This is just a suggestion, as I haven't worked out all
> the details. If you think it ends up being messier than
> the duplicate value, then I'm OK with it.
> 
> Michael
> 
> > +
> >  #if IS_ENABLED(CONFIG_HYPERV)
> >  static inline unsigned int hv_get_nested_msr(unsigned int reg)
> >  {
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index 9c452bfbd571..14b005b6270f 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -365,6 +365,14 @@ void __init ms_hyperv_late_init(void)
> >  	u8 *randomdata;
> >  	u32 length, i;
> > 
> > +	/*
> > +	 * Parse the ACPI wakeup structure information from device tree.
> > +	 * Currently VTL2 TDX guest only.
> > +	 */
> > +#ifdef CONFIG_X86_64
> > +	wakeup_mailbox_addr = dtb_parse_mp_wake();
> > +#endif
> > +
> >  	/*
> >  	 * Seed the Linux random number generator with entropy provided by
> >  	 * the Hyper-V host in ACPI table OEM0.
> > --
> > 2.25.1
> > 
> 

