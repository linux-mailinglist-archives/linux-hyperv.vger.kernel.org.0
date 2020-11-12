Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428302B085C
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 16:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgKLP1X (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 10:27:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbgKLP1W (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 10:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605194838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EToCEhKZCbY5qYquKZLEYM9Zxm5PVC8drZdaa3o0iK0=;
        b=POSWt5rriJTL/YutC5GtHeZukXKWQQpcdDd3Ohd01UWIjYM7ySKMnDmeyXv41Qw+/uSXjk
        eJYXxSC/WcRa3zjNjdw8Km4wD71Gk6vEUBABE+53KNZLP70jGxO0shHj9OwShcfb+aEcbD
        6Rw8a6v7MHy1lwTY7k7PlHgk8Qrr9xA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-u8bD8yzTORi9WlWYYzKbvg-1; Thu, 12 Nov 2020 10:27:17 -0500
X-MC-Unique: u8bD8yzTORi9WlWYYzKbvg-1
Received: by mail-wm1-f70.google.com with SMTP id o81so1881774wma.0
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2020 07:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EToCEhKZCbY5qYquKZLEYM9Zxm5PVC8drZdaa3o0iK0=;
        b=GiJPHMzjj2cdfUkbtG1RwC6/dG9I0QYV88hSwTSsm6kO2yQ864eaaQeUlx6MjMlFXs
         LrBj4w1kNKVyWdUWM/uk2RNwlhdICk/1Gky1MXIFrt1ecRYGA/trHQdG4ZqO87Psh0iP
         7ATSgjzqaDGL0xtjlwAO3X+MnwZfPwP38Dnmj1akZZPdR6KiZOMynS+ybuNrr+SLZo1d
         9MxVypcX1o+MoTXY/qAY5lvxjSThywWhjQbg5RccdeXTtZcKHzBEiZCzjG7F3j7tlPul
         H/+iO5UtyTFaTfmeDnAnjtGrsTv1fWtFMCr7Z94VwNznw0lEUU8fH8iDjU8toeQonIgs
         dM4Q==
X-Gm-Message-State: AOAM531Uw02bODEqBUORLdKJrBlzsJL78pU2kgHRD+58rRB5a/TYqmJI
        5lVxvgaVUYV/liHWJ+V5XpUs9o0ToVVb6gXyQ7rYHQ7lyPfkjMXrQ1lrVxObKIKOjO/7VcqnlWq
        LyT3Q0oMRF5W4+dD84wFhKV5h
X-Received: by 2002:adf:e44f:: with SMTP id t15mr57350wrm.380.1605194836252;
        Thu, 12 Nov 2020 07:27:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAEjBmoTH4/mr7/4f2REbvjuU/hHE1H+2TbgcnFk0M+o34TM33nSDmKd9yjYVLC54SujLB8w==
X-Received: by 2002:adf:e44f:: with SMTP id t15mr57335wrm.380.1605194836113;
        Thu, 12 Nov 2020 07:27:16 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a9sm7378333wrp.21.2020.11.12.07.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:27:15 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v2 04/17] iommu/hyperv: don't setup IRQ remapping when
 running as root
In-Reply-To: <20201105165814.29233-5-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-5-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:27:14 +0100
Message-ID: <87ft5ey4rx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> The IOMMU code needs more work. We're sure for now the IRQ remapping
> hooks are not applicable when Linux is the root.

Super-nitpick: I would suggest we always say 'root partition' as 'root'
has a 'slightly different' meaning in Linux and this commit message may
sound confusing to an unprepared reader.

>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/hyperv-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index e09e2d734c57..8d3ce3add57d 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -20,6 +20,7 @@
>  #include <asm/io_apic.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
>  
>  #include "irq_remapping.h"
>  
> @@ -143,7 +144,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>  	int i;
>  
>  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
> -	    !x2apic_supported())
> +	    !x2apic_supported() || hv_root_partition)
>  		return -ENODEV;
>  
>  	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

