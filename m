Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9611244AE3
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Aug 2020 15:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgHNNoQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Aug 2020 09:44:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40202 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgHNNoN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 09:44:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id k20so7963150wmi.5;
        Fri, 14 Aug 2020 06:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EVQHIchWAvbJrR7F5pGcTLqwzTGRpidCCQO103cMN5Q=;
        b=aehlxuArczjlFwbdVk0grexGqxGNRBnHj2WhjbbCBPsykQD3dB7XW/UIC0ps4XYog7
         RVYZ90uaz+K91eAsOIrSA4kVCEI3+lLL9L3tIoUalm02t05fGtfseFsQwBHnZCR+AWIk
         PF8vOlQx9xTqQvc+ZGBSME3qTtvqV1C1i+LwcJkI5XWqrpVtdXcbhgdwVe9nCNfPstag
         yTrJf6K5buJfJ/W3/56fxuW57z7gEhRCtysRrcebr2MZqHpb5+rQWls89d/ntwFC4yuV
         eRrDZJ4X7f8/QPPnZSspmV96b08p7NLnfa6HUWm/FdM7F24muCwsnuimSKHzQ5yVHjGE
         8MsA==
X-Gm-Message-State: AOAM532prCpA5FessBBwDLc6NaGgPY8i8qSX38IIGPdX4p6OsXSagf4r
        ekaGW+VtdHF1vRlFEpipnP8=
X-Google-Smtp-Source: ABdhPJyupzTLvM3OPYJQq5jd05naBXn3/EU+shcT2GpIoXsngVfAHRl5p+bq3HfrNlyisYNapH/L2Q==
X-Received: by 2002:a1c:66c5:: with SMTP id a188mr2542188wmc.173.1597412651906;
        Fri, 14 Aug 2020 06:44:11 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t189sm15703924wmf.47.2020.08.14.06.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 06:44:11 -0700 (PDT)
Date:   Fri, 14 Aug 2020 13:44:09 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Add parsing of VMbus interrupt
 in ACPI DSDT
Message-ID: <20200814134409.ccvo3uqblhy7h5le@liuwe-devbox-debian-v2>
References: <1597362679-37965-1-git-send-email-mikelley@microsoft.com>
 <20200814094403.uhgrc74khr5vcyva@liuwe-devbox-debian-v2>
 <MW2PR2101MB1052649114BC9A0396FB8905D7400@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052649114BC9A0396FB8905D7400@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 14, 2020 at 01:32:11PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Friday, August 14, 2020 2:44 AM
> > 
> > On Thu, Aug 13, 2020 at 04:51:19PM -0700, Michael Kelley wrote:
> > > On ARM64, Hyper-V now specifies the interrupt to be used by VMbus
> > > in the ACPI DSDT.  This information is not used on x86 because the
> > > interrupt vector must be hardcoded.  But update the generic
> > > VMbus driver to do the parsing and pass the information to the
> > > architecture specific code that sets up the Linux IRQ.  Update
> > > consumers of the interrupt to get it from an architecture specific
> > > function.
> > >
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > > ---
> > >  arch/x86/include/asm/mshyperv.h |  1 +
> > >  arch/x86/kernel/cpu/mshyperv.c  |  3 ++-
> > >  drivers/hv/hv.c                 |  2 +-
> > >  drivers/hv/vmbus_drv.c          | 30 +++++++++++++++++++++++++++---
> > >  include/asm-generic/mshyperv.h  |  4 +++-
> > >  5 files changed, 34 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > > index 4f77b8f..ffc2899 100644
> > > --- a/arch/x86/include/asm/mshyperv.h
> > > +++ b/arch/x86/include/asm/mshyperv.h
> > > @@ -54,6 +54,7 @@ typedef int (*hyperv_fill_flush_list_func)(
> > >  #define hv_enable_vdso_clocksource() \
> > >  	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
> > >  #define hv_get_raw_timer() rdtsc_ordered()
> > > +#define hv_get_vector() HYPERVISOR_CALLBACK_VECTOR
> > >
> > >  /*
> > >   * Reference to pv_ops must be inline so objtool
> > > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > > index 3112544..538aa87 100644
> > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > @@ -55,9 +55,10 @@
> > >  	set_irq_regs(old_regs);
> > >  }
> > >
> > > -void hv_setup_vmbus_irq(void (*handler)(void))
> > > +int hv_setup_vmbus_irq(int irq, void (*handler)(void))
> > >  {
> > 
> > irq is not used here. Did you perhaps forget to commit a chunk of code?
> 
> No, this is correct.  Per the commit message, the irq information
> parsed from the DSDT is not used in the x86 code.  But it is used on the
> ARM64 side.  I should add a comment to that effect here in the x86
> code so there's no confusion.

I see. The function for Arm64 is not here yet.

If you want to send a new version, feel free. I can also queue this
version up. I don't think lacking a comment here is a blocking issue.

Wei.

> 
> Michael
> 
> > 
> > >  	vmbus_handler = handler;
> > > +	return 0;
> > >  }
> > 
> > Wei.
