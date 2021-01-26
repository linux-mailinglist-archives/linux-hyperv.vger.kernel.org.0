Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9A0304208
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jan 2021 16:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406220AbhAZPQL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 10:16:11 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:52594 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406053AbhAZPP5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Jan 2021 10:15:57 -0500
Received: by mail-wm1-f53.google.com with SMTP id m187so2755986wme.2;
        Tue, 26 Jan 2021 07:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nsr5M9DRFMqInpuwv5Xd2i8l7XIErxkUkU+kMNMeqzY=;
        b=qCfondhnhXwcR6v75bZjyDjlRHbOhsrjr6m5bGF0ofVzjL7r7ztQaM1mbnGCnYOirW
         Ijt2RTn8MCsy4XdhNH3VT4Aw597NVbKUYltezSH5WDWROycn8Vym+7meeNNFKBFe36Pe
         uzF8Ap+VoWp3XAN6fLnvhVXxTGLWH+Xec9jUcx7US8oY/FBTxe8Y9NBNv1AvcWaE4Piw
         XDP+R59EYy/YFm+Nl1TXwyMiZuXn5BUeUu9XM+vpIfIVjlz/J5t/H2fYs0UrRc3g0Ppl
         PIICaCVLI+yQQCLKSQXHEAt618mvuwMoqU5EXJtHI6s/wGxFh6RLHEZRPwdlDuv2G0je
         6JYQ==
X-Gm-Message-State: AOAM530dwpdmHs+nlFuXRUDYeu2vEXUa1B6QECnm1sAe1qHSpVlCtldf
        OHzFiQnj6U/ELlBBijZ+lWo=
X-Google-Smtp-Source: ABdhPJxgzk946sVj33edywfjyES7QVRX3uQIxXx0tPSGSNNg6h3JDc4ax4Zve7ZKOD2jkYwULH5u7g==
X-Received: by 2002:a7b:cf34:: with SMTP id m20mr224184wmg.84.1611674114090;
        Tue, 26 Jan 2021 07:15:14 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m2sm3448801wml.34.2021.01.26.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 07:15:13 -0800 (PST)
Date:   Tue, 26 Jan 2021 15:15:12 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 02/16] x86/hyperv: detect if Linux is the root
 partition
Message-ID: <20210126151512.jz4f3jxfs7ommvm3@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-3-wei.liu@kernel.org>
 <MWHPR21MB159358B1D6151AC5B5D38C7FD7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB159358B1D6151AC5B5D38C7FD7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 26, 2021 at 12:31:31AM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> > 
> > For now we can use the privilege flag to check. Stash the value to be
> > used later.
> > 
> > Put in a bunch of defines for future use when we want to have more
> > fine-grained detection.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> > v3: move hv_root_partition to mshyperv.c
> > ---
> >  arch/x86/include/asm/hyperv-tlfs.h | 10 ++++++++++
> >  arch/x86/include/asm/mshyperv.h    |  2 ++
> >  arch/x86/kernel/cpu/mshyperv.c     | 20 ++++++++++++++++++++
> >  3 files changed, 32 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> > index 6bf42aed387e..204010350604 100644
> > --- a/arch/x86/include/asm/hyperv-tlfs.h
> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
> > @@ -21,6 +21,7 @@
> >  #define HYPERV_CPUID_FEATURES			0x40000003
> >  #define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004
> >  #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
> > +#define HYPERV_CPUID_CPU_MANAGEMENT_FEATURES	0x40000007
> >  #define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
> > 
> >  #define HYPERV_CPUID_VIRT_STACK_INTERFACE	0x40000081
> > @@ -110,6 +111,15 @@
> >  /* Recommend using enlightened VMCS */
> >  #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
> > 
> > +/*
> > + * CPU management features identification.
> > + * These are HYPERV_CPUID_CPU_MANAGEMENT_FEATURES.EAX bits.
> > + */
> > +#define HV_X64_START_LOGICAL_PROCESSOR			BIT(0)
> > +#define HV_X64_CREATE_ROOT_VIRTUAL_PROCESSOR		BIT(1)
> > +#define HV_X64_PERFORMANCE_COUNTER_SYNC			BIT(2)
> > +#define HV_X64_RESERVED_IDENTITY_BIT			BIT(31)
> > +
> 
> I wonder if these bit definitions should go in the asm-generic part of
> hyperv-tlfs.h instead of the X64 specific part.  They look very architecture
> neutral (in which case the X64 should be dropped from the name
> as well).  Of course, they can be moved later when/if we get to that point
> and have a firmer understanding of what is and isn't arch neutral.

Yes. This is the approach I'm taking here. They can be easily moved in
the future if there is a need.

> 
> >  /*
> >   * Virtual processor will never share a physical core with another virtual
> >   * processor, except for virtual processors that are reported as sibling SMT
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index ffc289992d1b..ac2b0d110f03 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -237,6 +237,8 @@ int hyperv_fill_flush_guest_mapping_list(
> >  		struct hv_guest_mapping_flush_list *flush,
> >  		u64 start_gfn, u64 end_gfn);
> > 
> > +extern bool hv_root_partition;
> > +
> >  #ifdef CONFIG_X86_64
> >  void hv_apic_init(void);
> >  void __init hv_init_spinlocks(void);
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index f628e3dc150f..c376d191a260 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -32,6 +32,10 @@
> >  #include <asm/nmi.h>
> >  #include <clocksource/hyperv_timer.h>
> > 
> > +/* Is Linux running as the root partition? */
> > +bool hv_root_partition;
> > +EXPORT_SYMBOL_GPL(hv_root_partition);
> > +
> >  struct ms_hyperv_info ms_hyperv;
> >  EXPORT_SYMBOL_GPL(ms_hyperv);
> > 
> > @@ -237,6 +241,22 @@ static void __init ms_hyperv_init_platform(void)
> >  	pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
> >  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
> > 
> > +	/*
> > +	 * Check CPU management privilege.
> > +	 *
> > +	 * To mirror what Windows does we should extract CPU management
> > +	 * features and use the ReservedIdentityBit to detect if Linux is the
> > +	 * root partition. But that requires negotiating CPU management
> > +	 * interface (a process to be finalized).
> > +	 *
> > +	 * For now, use the privilege flag as the indicator for running as
> > +	 * root.
> > +	 */
> > +	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {
> 
> Should the EBX value be captured in the ms_hyperv structure with the
> other similar values, and then used from there?
> 

There is only one usage of this in this whole series so I didn't bother
capturing. I would also like to clean up ms_hyperv_info's fields a bit.

Given there are quite some patches pending which change ms_hyperv_info
struct, I would like to avoid creating more conflicts than necessary.

My plan is to implement my idea from the thread "Field names inside
ms_hyperv_info" once all patches that touch ms_hyperv_info are merged.

Wei.
