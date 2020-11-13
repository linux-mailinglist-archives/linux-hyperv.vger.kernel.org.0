Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F3D2B1DC4
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Nov 2020 15:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKMOxI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Nov 2020 09:53:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46961 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgKMOxH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Nov 2020 09:53:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id d12so10168474wrr.13;
        Fri, 13 Nov 2020 06:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J3g1EmbPGYLgsVJyJusBp+ecz9drgGWXqp9ghw7oo04=;
        b=oc9l91eWAtIhZ02QQ8YnH+Vu9Mg80ncYBDbdOOtSmY7zsRV1MeiSo3FOkfOxAkMaIe
         ljnHFBCqrh0wHU3RuQdUYi8ZzEsxfl5ttEP4T3imbZQzaH5aFlGtap+Jare0WRH89MEz
         TwJlmFeIUpkuQQQrfQpzBLnOHAXU+GiHSLZSnz1z/R8JmeBEB0L1yRPP4gKJnVjlty4z
         HQdg+MWIQB0rmXqWleBNbZuMhP8RTpCj0Vb85/YMh6mhTV5FPCc2TYoQk6l/dUYXQ2dt
         qhlKDL+lkw7fDzign76PbJoMk312v7ui+7dAdB9AOAX9JxbzW0lLqPD/c7FfzDWr3PcV
         w2LA==
X-Gm-Message-State: AOAM533dd6UWq6lGME/JKxc4T7jMWvQ1zzxIvN8+OH0pwT9ZH4GmNi/j
        +sE1HTqnC/1bv1F9hrO4VSg=
X-Google-Smtp-Source: ABdhPJzVhgHWH+ov3Hd5rUXZqXGqiSjFrXDw4D/7d7K8Q6VCR1SzDiuP4R19ZvbbTIhBSZZZ4eN/EA==
X-Received: by 2002:adf:804b:: with SMTP id 69mr3963167wrk.274.1605279186710;
        Fri, 13 Nov 2020 06:53:06 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a17sm12104587wra.61.2020.11.13.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 06:53:06 -0800 (PST)
Date:   Fri, 13 Nov 2020 14:53:04 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Joerg Roedel <jroedel@suse.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v2 04/17] iommu/hyperv: don't setup IRQ remapping when
 running as root
Message-ID: <20201113145304.37w3h6xi7fmhgcg6@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-5-wei.liu@kernel.org>
 <87ft5ey4rx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft5ey4rx.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 12, 2020 at 04:27:14PM +0100, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > The IOMMU code needs more work. We're sure for now the IRQ remapping
> > hooks are not applicable when Linux is the root.
> 
> Super-nitpick: I would suggest we always say 'root partition' as 'root'
> has a 'slightly different' meaning in Linux and this commit message may
> sound confusing to an unprepared reader.

Fixed.

> 
> >
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > Acked-by: Joerg Roedel <jroedel@suse.de>
> > ---
> >  drivers/iommu/hyperv-iommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> > index e09e2d734c57..8d3ce3add57d 100644
> > --- a/drivers/iommu/hyperv-iommu.c
> > +++ b/drivers/iommu/hyperv-iommu.c
> > @@ -20,6 +20,7 @@
> >  #include <asm/io_apic.h>
> >  #include <asm/irq_remapping.h>
> >  #include <asm/hypervisor.h>
> > +#include <asm/mshyperv.h>
> >  
> >  #include "irq_remapping.h"
> >  
> > @@ -143,7 +144,7 @@ static int __init hyperv_prepare_irq_remapping(void)
> >  	int i;
> >  
> >  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
> > -	    !x2apic_supported())
> > +	    !x2apic_supported() || hv_root_partition)
> >  		return -ENODEV;
> >  
> >  	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks.

Wei.

> 
> -- 
> Vitaly
> 
