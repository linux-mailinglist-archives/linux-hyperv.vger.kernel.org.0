Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20DA4BE0DC
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Feb 2022 18:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356674AbiBULpL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Feb 2022 06:45:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356707AbiBULpF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Feb 2022 06:45:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28D117AA0;
        Mon, 21 Feb 2022 03:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645443881; x=1676979881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQYmqJJE6FDYdAKgZgjhPy1rWMStu2e18a2SFM3qJPk=;
  b=huILiGq4mR9ey2zpqbGNbEGjVHN/y5xlWCi2/t2cKw+Z7Oj8zREt7bXX
   QIkhDT7V4wHL7YPyPgmwxeV9ESLh39jUIeIFoAEae0fsQ0IGhOBKyzo7d
   AlytWiMhqFEjE6b3PHUm89IZAq/qNrK+Pq7gLWa2T+F0xR5KYGPtCzr9O
   RgHQJ2s0zjYk8oBKWCk4U76piGoKff8LM+ONNxVNlasJNoweV90Oprt9x
   R+cWC7oyrET09V0gAnZvnRQQjFv49Ct7u1v+bf3j6Co+hYGyq9o/oyn6S
   xNkChGnC6QLUoU0s4tNiHLB+thKaM5du0ZR/fgYX7uD9Rp8U5H82n3AbJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="276086217"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="276086217"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 03:44:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="638530467"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2022 03:44:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2ABC1161; Mon, 21 Feb 2022 13:44:51 +0200 (EET)
Date:   Mon, 21 Feb 2022 14:44:51 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-hyperv@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCHv3.1 2/32] x86/coco: Explicitly declare type of
 confidential computing platform
Message-ID: <20220221114451.mljggcmadgvrrxbv@black.fi.intel.com>
References: <YhAWcPbzgUGcJZjI@zn.tnic>
 <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
 <YhNyY5ErqQHZ961+@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhNyY5ErqQHZ961+@zn.tnic>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 21, 2022 at 12:07:15PM +0100, Borislav Petkov wrote:
> On Sat, Feb 19, 2022 at 03:13:04AM +0300, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
> > index 6a6ffcd978f6..891d3074a16e 100644
> > --- a/arch/x86/kernel/cc_platform.c
> > +++ b/arch/x86/kernel/cc_platform.c
> > @@ -9,18 +9,15 @@
> >  
> >  #include <linux/export.h>
> >  #include <linux/cc_platform.h>
> > -#include <linux/mem_encrypt.h>
> >  
> > -#include <asm/mshyperv.h>
> > +#include <asm/coco.h>
> >  #include <asm/processor.h>
> >  
> > -static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
> > +static enum cc_vendor cc_vendor;
> 
> static enum cc_vendor vendor __ro_after_init;

Hm. Isn't 'vendor' too generic? It may lead to name conflict in the
future.

What is wrong with cc_vendor here? I noticed that you don't like name of
a variable to match type name. Why?

> > @@ -344,6 +345,8 @@ static void __init ms_hyperv_init_platform(void)
> >  		 */
> >  		swiotlb_force = SWIOTLB_FORCE;
> >  #endif
> > +		if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
> > +			cc_init(CC_VENDOR_HYPERV);
> 
> Isn't that supposed to test HV_ISOLATION_TYPE_SNP instead?

Currently cc_platform_has() relies on hv_is_isolation_supported() which
checks for !HV_ISOLATION_TYPE_NONE. This is direct transfer to the new
scheme. It might be wrong, but it is not regression.

> I mean, I have no clue what HV_ISOLATION_TYPE_VBS is. It is not used
> anywhere in the tree either.
> 
> a6c76bb08dc7 ("x86/hyperv: Load/save the Isolation Configuration leaf")
> calls it "'VBS' (software-based isolation)" - whatever that means - so
> I'm not sure that is going to need the cc-facilities.
> 
> For stuff like that you need to use get_maintainers.pl and Cc them
> folks:
> 
> $ git log -p -1 | ./scripts/get_maintainer.pl | grep -i hyper
> "K. Y. Srinivasan" <kys@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
> Haiyang Zhang <haiyangz@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
> Stephen Hemminger <sthemmin@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
> Wei Liu <wei.liu@kernel.org> (supporter:Hyper-V/Azure CORE AND DRIVERS,commit_signer:1/4=25%)
> Dexuan Cui <decui@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
> linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS)
> 
> /me adds the ML to Cc.

+Tianyu, who brought HyperV cc_platform_has().

Speaking about HyperV, moving to scheme with cc_init() revealed that
HyperV never selected ARCH_HAS_CC_PLATFORM. Now it leads to build failure
if AMD memory encryption is not enabled:

	ld: arch/x86/kernel/cpu/mshyperv.o: in function `ms_hyperv_init_platform':
	mshyperv.c:(.init.text+0x297): undefined reference to `cc_init'

Maybe something like this:

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 0747a8f1fcee..574ea80601e9 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -8,6 +8,7 @@ config HYPERV
 		|| (ARM64 && !CPU_BIG_ENDIAN))
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
+	select ARCH_HAS_CC_PLATFORM if X86
 	select VMAP_PFN
 	help
 	  Select this option to run Linux as a Hyper-V client operating

Again, it is pre-existing issue. It only escalated to build failure.

> >  	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
> > diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> > index 3f0abb403340..eb7fbd85b77e 100644
> > --- a/arch/x86/mm/mem_encrypt_identity.c
> > +++ b/arch/x86/mm/mem_encrypt_identity.c
> > @@ -44,6 +44,7 @@
> >  #include <asm/setup.h>
> >  #include <asm/sections.h>
> >  #include <asm/cmdline.h>
> > +#include <asm/coco.h>
> >  
> >  #include "mm_internal.h"
> >  
> > @@ -565,8 +566,7 @@ void __init sme_enable(struct boot_params *bp)
> >  	} else {
> >  		/* SEV state cannot be controlled by a command line option */
> >  		sme_me_mask = me_mask;
> > -		physical_mask &= ~sme_me_mask;
> > -		return;
> > +		goto out;
> >  	}
> >  
> >  	/*
> > @@ -600,6 +600,8 @@ void __init sme_enable(struct boot_params *bp)
> >  		sme_me_mask = 0;
> >  	else
> >  		sme_me_mask = active_by_default ? me_mask : 0;
> > -
> > +out:
> >  	physical_mask &= ~sme_me_mask;
> > +	if (sme_me_mask)
> > +		cc_init(CC_VENDOR_AMD);
> >  }
> 
> I guess.
> 
> Adding SEV folks to Cc too.
> 
> Please use get_maintainer.pl - you should know that - you're not some
> newbie who started doing kernel work two weeks ago.

Sorry, will do.

-- 
 Kirill A. Shutemov
