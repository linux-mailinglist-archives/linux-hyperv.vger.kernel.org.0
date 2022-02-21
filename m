Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA44BDC6B
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Feb 2022 18:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiBULUf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Feb 2022 06:20:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355804AbiBULTi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Feb 2022 06:19:38 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5669613D05
        for <linux-hyperv@vger.kernel.org>; Mon, 21 Feb 2022 03:07:21 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BED141EC0528;
        Mon, 21 Feb 2022 12:07:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645441632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ziuW27yYUNc9AJAsMDe/3C2eMM0Eh56w0WceWniYUEA=;
        b=owbHnX+e9o6E6pdr17ZxfjAdsBCRDkz5nzPfLu1IV+Q6/FgkGBzC/l1EtmSAuXb6/OqFxE
        FeIzrfOYiwEpB++IbcvPuUyfz2c0O0q59Gve2toifYktwkm6RAQO/lDk4X6p/IXa2HR1dO
        wAt60tBOMB0WHhDZtNTydlPIvwtONfA=
Date:   Mon, 21 Feb 2022 12:07:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-hyperv@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCHv3.1 2/32] x86/coco: Explicitly declare type of
 confidential computing platform
Message-ID: <YhNyY5ErqQHZ961+@zn.tnic>
References: <YhAWcPbzgUGcJZjI@zn.tnic>
 <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Feb 19, 2022 at 03:13:04AM +0300, Kirill A. Shutemov wrote:
> Kernel derives type of confidential computing platform from sme_me_mask
> value and hv_is_isolation_supported(). This detection process will be
> more complicated as more platforms get added.
> 
> Declare confidential computing vendor explicitly via cc_init().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/coco.h        | 16 ++++++++++++++++
>  arch/x86/kernel/cc_platform.c      | 29 +++++++++++++++++------------
>  arch/x86/kernel/cpu/mshyperv.c     |  3 +++
>  arch/x86/mm/mem_encrypt_identity.c |  8 +++++---
>  4 files changed, 41 insertions(+), 15 deletions(-)
>  create mode 100644 arch/x86/include/asm/coco.h
> 
> diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
> new file mode 100644
> index 000000000000..6e770e0dd683
> --- /dev/null
> +++ b/arch/x86/include/asm/coco.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_COCO_H
> +#define _ASM_X86_COCO_H
> +
> +#include <asm/pgtable_types.h>
> +
> +enum cc_vendor {
> +	CC_VENDOR_NONE,
> +	CC_VENDOR_AMD,
> +	CC_VENDOR_HYPERV,
> +	CC_VENDOR_INTEL,
> +};
> +
> +void cc_init(enum cc_vendor);
> +
> +#endif /* _ASM_X86_COCO_H */
> diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
> index 6a6ffcd978f6..891d3074a16e 100644
> --- a/arch/x86/kernel/cc_platform.c
> +++ b/arch/x86/kernel/cc_platform.c
> @@ -9,18 +9,15 @@
>  
>  #include <linux/export.h>
>  #include <linux/cc_platform.h>
> -#include <linux/mem_encrypt.h>
>  
> -#include <asm/mshyperv.h>
> +#include <asm/coco.h>
>  #include <asm/processor.h>
>  
> -static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
> +static enum cc_vendor cc_vendor;

static enum cc_vendor vendor __ro_after_init;

> +
> +static bool intel_cc_platform_has(enum cc_attr attr)
>  {
> -#ifdef CONFIG_INTEL_TDX_GUEST
> -	return false;
> -#else
>  	return false;
> -#endif
>  }
>  
>  /*
> @@ -74,12 +71,20 @@ static bool hyperv_cc_platform_has(enum cc_attr attr)
>  
>  bool cc_platform_has(enum cc_attr attr)
>  {
> -	if (sme_me_mask)
> +	switch (cc_vendor) {
> +	case CC_VENDOR_AMD:
>  		return amd_cc_platform_has(attr);
> -
> -	if (hv_is_isolation_supported())
> +	case CC_VENDOR_INTEL:
> +		return intel_cc_platform_has(attr);
> +	case CC_VENDOR_HYPERV:
>  		return hyperv_cc_platform_has(attr);
> -
> -	return false;
> +	default:
> +		return false;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(cc_platform_has);
> +
> +__init void cc_init(enum cc_vendor vendor)
> +{
> +	cc_vendor = vendor;
> +}
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 5a99f993e639..d77cf3a31f07 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -33,6 +33,7 @@
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/numa.h>
> +#include <asm/coco.h>
>  
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> @@ -344,6 +345,8 @@ static void __init ms_hyperv_init_platform(void)
>  		 */
>  		swiotlb_force = SWIOTLB_FORCE;
>  #endif
> +		if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
> +			cc_init(CC_VENDOR_HYPERV);

Isn't that supposed to test HV_ISOLATION_TYPE_SNP instead?

I mean, I have no clue what HV_ISOLATION_TYPE_VBS is. It is not used
anywhere in the tree either.

a6c76bb08dc7 ("x86/hyperv: Load/save the Isolation Configuration leaf")
calls it "'VBS' (software-based isolation)" - whatever that means - so
I'm not sure that is going to need the cc-facilities.

For stuff like that you need to use get_maintainers.pl and Cc them
folks:

$ git log -p -1 | ./scripts/get_maintainer.pl | grep -i hyper
"K. Y. Srinivasan" <kys@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
Haiyang Zhang <haiyangz@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
Stephen Hemminger <sthemmin@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
Wei Liu <wei.liu@kernel.org> (supporter:Hyper-V/Azure CORE AND DRIVERS,commit_signer:1/4=25%)
Dexuan Cui <decui@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS)

/me adds the ML to Cc.

>  	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 3f0abb403340..eb7fbd85b77e 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -44,6 +44,7 @@
>  #include <asm/setup.h>
>  #include <asm/sections.h>
>  #include <asm/cmdline.h>
> +#include <asm/coco.h>
>  
>  #include "mm_internal.h"
>  
> @@ -565,8 +566,7 @@ void __init sme_enable(struct boot_params *bp)
>  	} else {
>  		/* SEV state cannot be controlled by a command line option */
>  		sme_me_mask = me_mask;
> -		physical_mask &= ~sme_me_mask;
> -		return;
> +		goto out;
>  	}
>  
>  	/*
> @@ -600,6 +600,8 @@ void __init sme_enable(struct boot_params *bp)
>  		sme_me_mask = 0;
>  	else
>  		sme_me_mask = active_by_default ? me_mask : 0;
> -
> +out:
>  	physical_mask &= ~sme_me_mask;
> +	if (sme_me_mask)
> +		cc_init(CC_VENDOR_AMD);
>  }

I guess.

Adding SEV folks to Cc too.

Please use get_maintainer.pl - you should know that - you're not some
newbie who started doing kernel work two weeks ago.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
