Return-Path: <linux-hyperv+bounces-2942-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D19396C57A
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 19:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1261C22021
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB271E1327;
	Wed,  4 Sep 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1hbp+hI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA935464E;
	Wed,  4 Sep 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471080; cv=none; b=ep9NpZIIwjHdwSsR0iN47b/IchCTzhknVTZVpjoxkjycmVcLhRIWdUQ2oXqtBxGCmoaS33i++IVLQmIdSA7OzR9GLjbaQPPmqZ5inz+FGX/5OjfrlXC6m5XOlqi+eLq94Wc5SMsktV8CS5WylQcWA4kc0KFpwHHhorwhhrfbGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471080; c=relaxed/simple;
	bh=2uQKItW7vt8MX4buVgBQu2rd3/0LezlUPrICrlhrgag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7nwLdiO+ajQAyzq8ZWhWRj7YIWCz1o9f7T13tb6h5LeeK4RfMT+wFb9X/Yp/mXoWPjsngYwLKb/XwlkqOM3waw6n0hg655XYJiQ5cAOjgTNJc2JcBrT6FWDZa0GvW2TQS3C4YSrcNCyYxELTZlDnXn6t1kWKv4u70MYDNl4yGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1hbp+hI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725471080; x=1757007080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2uQKItW7vt8MX4buVgBQu2rd3/0LezlUPrICrlhrgag=;
  b=H1hbp+hIRVLunLt+HsD83Zbb7Uc+iC0J+xUBq+jCSqKeHfPbAIbGHC2+
   DFLXWmpWO4qYyfY4Kfm/Uh5ZxYiwQydHGB1Sog0YTmmnCCmx8i5rIDsZ5
   CxmGZy+nITbYXu3ioufPTUpGQaGpPixd2m7sFwCbz2RVyoQB/6TBjyjjk
   /u98PiXDKHwvHOetChn+gLxG3nteHPn+ScyHta0cfec9sB/tUP4LkreNx
   4tiA26bgoLxVwdrbZONJfVOX2lHTlCdByFjqIFXsy8yzHoDJTDkavBll5
   1uLaMQQMabV2X/+hQYnlO+lCk0vMVtVkVHC1tysMwQUHY54tcP52Z5E2u
   g==;
X-CSE-ConnectionGUID: tF2BjtJRTWie222acjljZA==
X-CSE-MsgGUID: Dul+PFW6QLyrGN0jFc+/9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="46680518"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="46680518"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 10:31:19 -0700
X-CSE-ConnectionGUID: B3fIZmSmRNu715JzRHLOiA==
X-CSE-MsgGUID: bC1PYqJST9Sxw/suC6owEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="69968846"
Received: from unknown (HELO localhost) ([10.79.232.150])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 10:31:18 -0700
Date: Wed, 4 Sep 2024 10:31:17 -0700
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
Message-ID: <20240904173117.GA20992@yjiang5-mobl.amr.corp.intel.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-5-yunhong.jiang@linux.intel.com>
 <BN7PR02MB4148CC3F9091BC2604E457CFD4922@BN7PR02MB4148.namprd02.prod.outlook.com>
 <20240903201917.GB105@yjiang5-mobl.amr.corp.intel.com>
 <SN6PR02MB4157963DE55041D0631188A4D49C2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157963DE55041D0631188A4D49C2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, Sep 04, 2024 at 02:56:49PM +0000, Michael Kelley wrote:
> From: Yunhong Jiang <yunhong.jiang@linux.intel.com> Sent: Tuesday, September 3, 2024 1:19 PM
> > 
> > On Mon, Sep 02, 2024 at 03:35:13AM +0000, Michael Kelley wrote:
> > > From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > > >
> > > > Parse the wakeup mailbox VTL2 TDX guest. Put it to the guest_late_init, so
> > > > that it will be invoked before hyperv_init() where the mailbox address is
> > > > checked.
> > >
> > > Could you elaborate on the choice to set the wakeup_mailbox_address
> > > in ms_hyperv_late_init()? The code in hv_common.c is intended to be
> > > code that is architecture neutral (see the comment at the top of the module),
> > > so it's a red flag to see #ifdef CONFIG_X86_64. Couldn't the
> > > wakeup_mailbox_address be set in the x86 version of hyperv_init()
> > > before it is needed?
> > 
> > Sure, will try to put it in hyperv_init() before it's needed.
> > >
> > > >
> > > > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > > > ---
> > > >  arch/x86/include/asm/mshyperv.h | 3 +++
> > > >  arch/x86/kernel/cpu/mshyperv.c  | 2 ++
> > > >  drivers/hv/hv_common.c          | 8 ++++++++
> > > >  3 files changed, 13 insertions(+)
> > > >
> > > > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > > > index 390c4d13956d..5178b96c7fc9 100644
> > > > --- a/arch/x86/include/asm/mshyperv.h
> > > > +++ b/arch/x86/include/asm/mshyperv.h
> > > > @@ -10,6 +10,7 @@
> > > >  #include <asm/nospec-branch.h>
> > > >  #include <asm/paravirt.h>
> > > >  #include <asm/mshyperv.h>
> > > > +#include <asm/madt_wakeup.h>
> > > >
> > > >  /*
> > > >   * Hyper-V always provides a single IO-APIC at this MMIO address.
> > > > @@ -49,6 +50,8 @@ extern u64 hv_current_partition_id;
> > > >
> > > >  extern union hv_ghcb * __percpu *hv_ghcb_pg;
> > > >
> > > > +extern u64 wakeup_mailbox_addr;
> > > > +
> > > >  bool hv_isolation_type_snp(void);
> > > >  bool hv_isolation_type_tdx(void);
> > > >  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> > > > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > > > index 3d4237f27569..f6b727b4bd0b 100644
> > > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > > @@ -43,6 +43,8 @@ struct ms_hyperv_info ms_hyperv;
> > > >  bool hyperv_paravisor_present __ro_after_init;
> > > >  EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
> > > >
> > > > +u64 wakeup_mailbox_addr;
> > >
> > > This value duplicates acpi_mp_wake_mailbox_paddr in
> > > madt_wakeup.c. It looks like the duplicate value is used
> > > for two things:
> > >
> > > 1) In hv_is_private_mmio_tdx() to control the encrypted
> > > vs. decrypted mapping (Patch 5 of this series)
> > >
> > > 2) As a boolean in hv_vtl_early_init() to avoid overwriting
> > > the wakeup_secondary_cpu_64 value when
> > > dtb_parse_mp_wake() has set it to acpi_wakeup_cpu().
> > > (Patch 9 of this series).
> > >
> > > Having a duplicate value is messy, and I'm wondering if
> > > it can be avoided. For (1), hv_private_mmio_tdx() could call
> > > into a function added to madt_wakeup.c to make the
> > > check.  For (2), the check should probably be based on
> > > hv_isolation_type_tdx() instead of whether the wakeup
> > > mailbox address is set.  I'll note that Patch 5 of this series
> > > is using hv_isolation_type_tdx(), so there's a bit of an
> > > inconsistency in testing the wakeup_mailbox_addr in
> > > Patch 9.
> > 
> > I think your comment includes two points, the duplicated variables and the
> > incosistency in the testing.
> > 
> > Thank you for pointing out the duplication of wakeup_mailbox_addr with
> > acpi_mp_wake_mailbox_paddr. I didn't realize it. Yes, such duplication should be
> > avoided and will fix it in next submission.
> > 
> > Agree the inconsistency in testing wakeup_mailbox_addr and
> > hv_isolation_type_tdx() is not good. IMHO, the wakeup_mailbox_addr (or the new
> > function you proposed) is better than hv_isolation_type_tdx(), since the
> > wakeup_mailbox_addr is more directly related.  But hv_vtl_init_platform()
> > happens before DT parse, thus I have to use the hv_isolation_type_tdx() in it. I
> > don't have a good idea on how to fix this.
> > 
> > Thanks
> > --jyh
> > 
> 
> I don't think there's a requirement to set the "is_private_mmio"
> function in hv_vtl_init_platform(). It just needs to be set before
> acpi_wakeup_cpu() is called, which does the memremap() that will
> invoke the "is_private_mmio" function to decide whether to map
> as encrypted or decrypted.
> 
> So maybe setting the "is_private_mmio" function could be
> done after dtb_parse_mp_wake() is called in its new location, and
> you know you have a valid wake mailbox address? Again, I haven't
> worked out all the details, so this approach might be just as messy,
> but in a different way. Use your judgment ... :-)

Sorry that I didn't explain clearly. The testing in hv_vtl_init_platform() is
not only for the is_private_mmio, but also for the realmode_reserve(), which
happens before the DT parse.

BTW, I don't know why the trampoline_64.S is put into the real mode blob. I
don't find any specific requirement in the code, but I'm not sure if I missed
anything. If this dependency is removed, all the TDX guest will benefit.

Thank you
--jyh

> 
> Michael

