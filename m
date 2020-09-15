Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3952326A415
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Sep 2020 13:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgIOLYY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Sep 2020 07:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgIOLX6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Sep 2020 07:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600169035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6cVCOQ7d2lGCj+sz7IDzW+p3UDF4b8CRkA73qH7l96E=;
        b=HPxZohSerHy4EWHUtAmjKqTe/RNUO0XHPqgEmDos5yabPqlVzInpSS/UEjQj7gL4Fg73rh
        Ziapko3gGneWwxi4wPjPsaqnwUpSyqafdUmeZFlh6iwsTpnldEGgW6XupjgSqPwkTMU9FQ
        t12lwf8QexloL/qlbganTDm7RD75ChU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-SnifR4GKPnWoVfMP5ioLpg-1; Tue, 15 Sep 2020 07:23:54 -0400
X-MC-Unique: SnifR4GKPnWoVfMP5ioLpg-1
Received: by mail-wm1-f72.google.com with SMTP id 23so1044006wmk.8
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2020 04:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6cVCOQ7d2lGCj+sz7IDzW+p3UDF4b8CRkA73qH7l96E=;
        b=ODZ0MYsWEDsBs5hBstN2h1S7SGa4ltUDT/sIDmjW9vaNHEWnNRmyNCPGLK6RSkCzqz
         SJJe+tT9DK+GoW36jQbRgcNGmvSlkhvck4zR7wbDLrcDYwunckHycAX3vqTQg59u38Fa
         Yy6eOFo/rAzg/IPauoiEtzHSFJwh7DnT8Bh4wEExHurqqy0+FpicJnGtWS9Z0yUMxzIN
         JWCaHR+NuJCiYuSMkJ3nhctoG1+jQIYQKujiXfPm/9GLFyaO7GcdhVRL1rdM1ig3MQ4h
         GR/5huqFclM2kRStPhTzvoRo3OlwtYr+NGngMDG4dA26d29bNIMG7EcAUNuiJsu4eBe8
         GxRQ==
X-Gm-Message-State: AOAM533Uv0T4iIc3GdhleoEXigsoeYiDCU6d0P2jj+IbHtxzoTwCsYbQ
        jOMTEBK2QQxsF1Z2rS6IWIuoc3AI2IvY2qcbxXfNFnOTWw2Gae0DAmXD2ITt5daRJCp9XQKqDbh
        sgSm4m32sFsodxHDr8MU40lpe
X-Received: by 2002:a1c:f612:: with SMTP id w18mr4093223wmc.47.1600169032845;
        Tue, 15 Sep 2020 04:23:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvGbq4kAy/QGRtY/BOpA+aWnzBDti4E9VI3Ss2yI2nlXdHQaEUP+BzI9wCqgRzAdsZ43LXEQ==
X-Received: by 2002:a1c:f612:: with SMTP id w18mr4093200wmc.47.1600169032622;
        Tue, 15 Sep 2020 04:23:52 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x16sm25662251wrq.62.2020.09.15.04.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:23:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC v1 08/18] x86/hyperv: handling hypercall page setup for root
In-Reply-To: <20200915111657.boa4cneqjqtmcaaq@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914112802.80611-9-wei.liu@kernel.org> <87v9gfjpoi.fsf@vitty.brq.redhat.com> <20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2> <87pn6njob3.fsf@vitty.brq.redhat.com> <20200915111657.boa4cneqjqtmcaaq@liuwe-devbox-debian-v2>
Date:   Tue, 15 Sep 2020 13:23:50 +0200
Message-ID: <87h7rzjnax.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Tue, Sep 15, 2020 at 01:02:08PM +0200, Vitaly Kuznetsov wrote:
>> Wei Liu <wei.liu@kernel.org> writes:
>> 
>> > On Tue, Sep 15, 2020 at 12:32:29PM +0200, Vitaly Kuznetsov wrote:
>> >> Wei Liu <wei.liu@kernel.org> writes:
>> >> 
>> >> > When Linux is running as the root partition, the hypercall page will
>> >> > have already been setup by Hyper-V. Copy the content over to the
>> >> > allocated page.
>> >> 
>> >> And we can't setup a new hypercall page by writing something different
>> >> to HV_X64_MSR_HYPERCALL, right?
>> >> 
>> >
>> > My understanding is that we can't, but Sunil can maybe correct me.
>> >
>> >> >
>> >> > The suspend, resume and cleanup paths remain untouched because they are
>> >> > not supported in this setup yet.
>> >> >
>> >> > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> >> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
>> >> > Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
>> >> > Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> >> > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
>> >> > Co-Developed-by: Nuno Das Neves <nudasnev@microsoft.com>
>> >> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
>> >> > ---
>> >> >  arch/x86/hyperv/hv_init.c | 26 ++++++++++++++++++++++++--
>> >> >  1 file changed, 24 insertions(+), 2 deletions(-)
>> >> >
>> >> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> >> > index 0eec1ed32023..26233aebc86c 100644
>> >> > --- a/arch/x86/hyperv/hv_init.c
>> >> > +++ b/arch/x86/hyperv/hv_init.c
>> >> > @@ -25,6 +25,7 @@
>> >> >  #include <linux/cpuhotplug.h>
>> >> >  #include <linux/syscore_ops.h>
>> >> >  #include <clocksource/hyperv_timer.h>
>> >> > +#include <linux/highmem.h>
>> >> >  
>> >> >  /* Is Linux running as the root partition? */
>> >> >  bool hv_root_partition;
>> >> > @@ -448,8 +449,29 @@ void __init hyperv_init(void)
>> >> >  
>> >> >  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> >> >  	hypercall_msr.enable = 1;
>> >> > -	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>> >> > -	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> >> > +
>> >> > +	if (hv_root_partition) {
>> >> > +		struct page *pg;
>> >> > +		void *src, *dst;
>> >> > +
>> >> > +		/*
>> >> > +		 * Order is important here. We must enable the hypercall page
>> >> > +		 * so it is populated with code, then copy the code to an
>> >> > +		 * executable page.
>> >> > +		 */
>> >> > +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> >> > +
>> >> > +		pg = vmalloc_to_page(hv_hypercall_pg);
>> >> > +		dst = kmap(pg);
>> >> > +		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
>> >> > +				MEMREMAP_WB);
>> >> 
>> >> memremap() can fail...
>> >
>> > And we don't care here, if it fails, we would rather it panic or oops.
>> >
>> > I was relying on the fact that copying from / to a NULL pointer will
>> > cause the kernel to crash. But of course it wouldn't hurt to explicitly
>> > panic here.
>> >
>> >> 
>> >> > +		memcpy(dst, src, PAGE_SIZE);
>> >> > +		memunmap(src);
>> >> > +		kunmap(pg);
>> >> > +	} else {
>> >> > +		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>> >> > +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> >> > +	}
>> >> 
>> >> Why can't we do wrmsrl() for both cases here?
>> >> 
>> >
>> > Because the hypercall page has already been set up when Linux is the
>> > root.
>> 
>> But you already do wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64)
>> in 'if (hv_root_partition)' case above, that's why I asked.
>> 
>
> You mean extracting wrmsrl to this point?  The ordering matters. See the
> comment in the root branch -- we have to enable the page before copying
> the content.
>
> What can be done is:
>
>    if (!root) {
>        /* some stuff */
>    }
>
>    wrmsrl(...)
>
>    if (root) {
>        /* some stuff */
>    }
>
> This is not looking any better than the existing code.
>

Oh, I missed the comment indeed. So Hypervisor already picked a page for
us, however, it didn't enable it and it's not populated? How can we be
sure that we didn't use it for something else already? Maybe we can
still give a different known-to-be-empty page?

-- 
Vitaly

