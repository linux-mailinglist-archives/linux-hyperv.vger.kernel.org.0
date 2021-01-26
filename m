Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB31330418B
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jan 2021 16:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406110AbhAZPHO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 10:07:14 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:47015 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406117AbhAZPG5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Jan 2021 10:06:57 -0500
Received: by mail-wr1-f52.google.com with SMTP id q7so16802572wre.13;
        Tue, 26 Jan 2021 07:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1zxAP5nWOub6Bvc04Q0nYCpX745bg4gnoQMttyKcbDA=;
        b=cLyO/H40Qe5XBacyvxPrEls2PLQpH229f1gtEJhXThmPVRs0jqLeLFJ66FS4BNao6X
         Ik0zRQmTfxZCZ10g5dBtUebX1+ISJoiGEgv2ZQsZerr0AKmDwtgV/Aa1mCNaUeEJCvWl
         /0DiVwEW4v9bOW9d/AIrtJOm8239T3DrIgQ6Xgy8SlO1RAOS50Atmhuem8VKJfdPVsek
         w3oFXqk/G/5zW73vgu+UZDQVBn2frbgn/DHaAcprKr+ToZMN136S3rcoQH8GkhPCV/IZ
         7W6Hl5r9yH4qj6PloJk6n0hg/Pd4W4p7zLOhwRzNpMRr1LDRGEb9H2pMoFrACCdj+wCy
         ZJug==
X-Gm-Message-State: AOAM533xm0AKkD+0quXUwxs04rKwWMZZTGXqhRULzOTnXhHORbiucVUq
        6OfoHdGLRGtga92sP0CLaAw=
X-Google-Smtp-Source: ABdhPJz6nXhDC+EdSuhgT02+BMd0x/AUACUUkmfcFOGpK/ISfMtzwNbVHBGQODyMvxpp8w2rucWM5Q==
X-Received: by 2002:a5d:640c:: with SMTP id z12mr6619568wru.342.1611673575016;
        Tue, 26 Jan 2021 07:06:15 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i131sm3814078wmi.25.2021.01.26.07.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 07:06:14 -0800 (PST)
Date:   Tue, 26 Jan 2021 15:06:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 02/16] x86/hyperv: detect if Linux is the root
 partition
Message-ID: <20210126150613.6fg5f5ouqicq4job@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-3-wei.liu@kernel.org>
 <CA+CK2bDHYxTr_ttbC88u1OvT-=cm5do5RmyoxC+joz=GjK1WtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDHYxTr_ttbC88u1OvT-=cm5do5RmyoxC+joz=GjK1WtA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 20, 2021 at 11:03:18AM -0500, Pavel Tatashin wrote:
> On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
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
> >  #define HYPERV_CPUID_FEATURES                  0x40000003
> >  #define HYPERV_CPUID_ENLIGHTMENT_INFO          0x40000004
> >  #define HYPERV_CPUID_IMPLEMENT_LIMITS          0x40000005
> > +#define HYPERV_CPUID_CPU_MANAGEMENT_FEATURES   0x40000007
> >  #define HYPERV_CPUID_NESTED_FEATURES           0x4000000A
> >
> >  #define HYPERV_CPUID_VIRT_STACK_INTERFACE      0x40000081
> > @@ -110,6 +111,15 @@
> >  /* Recommend using enlightened VMCS */
> >  #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED            BIT(14)
> >
> > +/*
> > + * CPU management features identification.
> > + * These are HYPERV_CPUID_CPU_MANAGEMENT_FEATURES.EAX bits.
> > + */
> > +#define HV_X64_START_LOGICAL_PROCESSOR                 BIT(0)
> > +#define HV_X64_CREATE_ROOT_VIRTUAL_PROCESSOR           BIT(1)
> > +#define HV_X64_PERFORMANCE_COUNTER_SYNC                        BIT(2)
> > +#define HV_X64_RESERVED_IDENTITY_BIT                   BIT(31)
> > +
> >  /*
> >   * Virtual processor will never share a physical core with another virtual
> >   * processor, except for virtual processors that are reported as sibling SMT
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index ffc289992d1b..ac2b0d110f03 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -237,6 +237,8 @@ int hyperv_fill_flush_guest_mapping_list(
> >                 struct hv_guest_mapping_flush_list *flush,
> >                 u64 start_gfn, u64 end_gfn);
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
> >         pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
> >                  ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
> >
> > +       /*
> > +        * Check CPU management privilege.
> > +        *
> > +        * To mirror what Windows does we should extract CPU management
> > +        * features and use the ReservedIdentityBit to detect if Linux is the
> > +        * root partition. But that requires negotiating CPU management
> > +        * interface (a process to be finalized).
> 
> Is this comment relevant? Do we have to mirror what Windows does?
> 

We should do that in the future when the process for negotiating CPU
management features is stabilized / finalized.

> > +        *
> > +        * For now, use the privilege flag as the indicator for running as
> > +        * root.
> > +        */
> > +       if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {
> > +               hv_root_partition = true;
> > +               pr_info("Hyper-V: running as root partition\n");
> > +       }
> > +
> 
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Thanks for reviewing these patches.

Wei.
