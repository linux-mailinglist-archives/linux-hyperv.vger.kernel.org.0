Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444BA30F874
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Feb 2021 17:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbhBDQt2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Feb 2021 11:49:28 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:41207 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbhBDQtT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Feb 2021 11:49:19 -0500
Received: by mail-wr1-f49.google.com with SMTP id p15so4286402wrq.8;
        Thu, 04 Feb 2021 08:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZKBnpUeMo730D8AdWVMakbcCm1b7M/eKIDeLqDP9XrI=;
        b=kVqMYuBcG83cm3Z6DttbcCuPLQfur60dLncRkL78pnPHwAEerI3bL2J+u0w07L4urZ
         INLJecDPFRSh6XhFw6Y4zJOG4dsWgTk2Q+sOA/psi6JhbmjXfi2vKfrpAXiVxXQKYsZp
         3g1qeZY+2NEuQy2P/zWVSf6aeZhFT1Hfi3i2PJspWZY1aI9+w8QAAx7Wx0yg6PAbvIfy
         oXNMqAHSmTXBdVxsSiy9pc6NXOun108TtpAQzrJXyn4iaDgSoyHv/v0pnYlOuCrjHcxf
         bD/5PsGNeEFeDAIek+157/30eJQR77cL9LP4OVd0k6iIqPFKFk6HR0NXAB3UmBiOqdif
         0Ksg==
X-Gm-Message-State: AOAM531Xi+kkehAc28JmLSjh0Ryfes7Z/3BHPCZj07zCJMNTGRoNSiGP
        X+junLR/SNDCXqqt2SAxP34=
X-Google-Smtp-Source: ABdhPJzP5TV1DdTEip1CBP5TkYTA31w954zIpqhAtz0ZyGAXo/7QIe6RobDJOF5XaAec/SkKKYIAJw==
X-Received: by 2002:a5d:5910:: with SMTP id v16mr235527wrd.29.1612457317643;
        Thu, 04 Feb 2021 08:48:37 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v1sm6662200wmj.31.2021.02.04.08.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 08:48:37 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:48:35 +0000
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
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v5 16/16] iommu/hyperv: setup an IO-APIC IRQ remapping
 domain for root partition
Message-ID: <20210204164835.b74zjs6n5hll5bnz@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-17-wei.liu@kernel.org>
 <MWHPR21MB15936ED25B56AF897B655B76D7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210203124700.ugx5vd526455u7lb@liuwe-devbox-debian-v2>
 <MWHPR21MB1593F0BB81545B450D2ACBE6D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593F0BB81545B450D2ACBE6D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 04, 2021 at 04:41:47PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, February 3, 2021 4:47 AM
[...]
> > > > +
> > > > +	if (level)
> > > > +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_LEVEL;
> > > > +	else
> > > > +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
> > > > +
> > > > +	__set_bit(vcpu, (unsigned long *)&intr_desc->target.vp_mask);
> > > > +
> > > > +	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, 0, input,
> > output) &
> > > > +			 HV_HYPERCALL_RESULT_MASK;
> > > > +	local_irq_restore(flags);
> > > > +
> > > > +	*entry = output->interrupt_entry;
> > > > +
> > > > +	return status;
> > >
> > > As a cross-check, I was comparing this code against hv_map_msi_interrupt().  They are
> > > mostly parallel, though some of the assignments are done in a different order.  It's a nit,
> > > but making them as parallel as possible would be nice. :-)
> > >
> > 
> > Indeed. I will see about factoring out a function.
> 
> If factoring out a separate helper function is clumsy, just having the parallel code
> in the two functions be as similar as possible makes it easier to see what's the
> same and what's different.
> 

No. It is not clumsy at all. I've done it in the newly posted v6.

I was baffled why I wrote hv_unmap_interrupt helper to be used by both
hv_unmap_ioapic_interrupt and hv_unmap_msi_interrupt in the previous
patch, but didn't write a hv_map_interrupt. Maybe I didn't have enough
coffee that day. :-/

Thanks for pointing out that issue. It definitely helped improve the
quality of this series.

Wei.
