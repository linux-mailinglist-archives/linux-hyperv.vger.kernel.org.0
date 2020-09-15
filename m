Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B60126A332
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Sep 2020 12:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgIOKcq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Sep 2020 06:32:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49512 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726142AbgIOKcg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Sep 2020 06:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600165954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QeRQZPobCs6e4P32IINeGIKOUrcjgI68IIdMqZ+JT7M=;
        b=hVwGfL9dnQpX8KIDx8g1sn7cVZOfVSQ9mYeH7vrxPIySeRhg6SvDXs/dgHMMtn3uKQHR2g
        V6P2LVibNuFQzOUGdG+dZ/z5bEfCe8YFrfZm/eCk2aP8ZmpGSXHkj+sMIMGsYE5gvO057a
        RRzE1s4kMJtQYaxCZX18lrUjTqypDok=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-SzXZN0RsOdSn0bbiMWKN2A-1; Tue, 15 Sep 2020 06:32:32 -0400
X-MC-Unique: SzXZN0RsOdSn0bbiMWKN2A-1
Received: by mail-wm1-f71.google.com with SMTP id b20so1909193wmj.1
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2020 03:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QeRQZPobCs6e4P32IINeGIKOUrcjgI68IIdMqZ+JT7M=;
        b=K73D+zwX8b0Flkl+m6upfWw+UF+qYvbYWTiUxWlSE4FQzl/ePDmYUX99lwfEpoKBc4
         2m3aw/++MiEMbTaHmTDn1WT7sWhkajD5DAxYBWJk0d1EldsiiZ63GfzegZYIPbk6/nxI
         EXqzwSNHrKp90CPKu12tkShnUlxU7SF00nibLW9dtgHhWVzCu75/qpBlURUuNVU6Q3JI
         IKDX25YwyZRkt9OCU5w9PT0GmtxI3hsLwfQybLcu9hNDIZP28v+mEIeeclZ+sEc0808F
         gweSxJB9Am8yBIvICA0VYLZ4zq+v5WQAh30L6RYNkfXkASeQAz8NvdBHvMaAUS6VguaO
         cD4w==
X-Gm-Message-State: AOAM532+ZZp6mL7l9dMN2BkVpmUpislCcxwy/gjNIGXcl/igy9cs0PkZ
        A9ChpSl2tIyJTLpkLNGwsh7OFCHcdLMKaQez2OlJy8Z5DHR2pYt2/HMpLKyf5VFW5ojJ8WTTaZg
        W4NqAJD1GMc4PKnKHlkjFLrL5
X-Received: by 2002:adf:c44d:: with SMTP id a13mr20330463wrg.11.1600165951349;
        Tue, 15 Sep 2020 03:32:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJkSTvuIy8gFdXXAANcRbGCR0uaovccUxBhrr2j1y4ZvaRu9mnQDPVvKZveLtC18WrUxMMFA==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr20330439wrg.11.1600165951106;
        Tue, 15 Sep 2020 03:32:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q8sm25810346wrx.79.2020.09.15.03.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 03:32:30 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC v1 08/18] x86/hyperv: handling hypercall page setup for root
In-Reply-To: <20200914112802.80611-9-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914112802.80611-9-wei.liu@kernel.org>
Date:   Tue, 15 Sep 2020 12:32:29 +0200
Message-ID: <87v9gfjpoi.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> When Linux is running as the root partition, the hypercall page will
> have already been setup by Hyper-V. Copy the content over to the
> allocated page.

And we can't setup a new hypercall page by writing something different
to HV_X64_MSR_HYPERCALL, right?

>
> The suspend, resume and cleanup paths remain untouched because they are
> not supported in this setup yet.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Nuno Das Neves <nudasnev@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_init.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 0eec1ed32023..26233aebc86c 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -25,6 +25,7 @@
>  #include <linux/cpuhotplug.h>
>  #include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
> +#include <linux/highmem.h>
>  
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> @@ -448,8 +449,29 @@ void __init hyperv_init(void)
>  
>  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	hypercall_msr.enable = 1;
> -	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> -	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +
> +	if (hv_root_partition) {
> +		struct page *pg;
> +		void *src, *dst;
> +
> +		/*
> +		 * Order is important here. We must enable the hypercall page
> +		 * so it is populated with code, then copy the code to an
> +		 * executable page.
> +		 */
> +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +
> +		pg = vmalloc_to_page(hv_hypercall_pg);
> +		dst = kmap(pg);
> +		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
> +				MEMREMAP_WB);

memremap() can fail...

> +		memcpy(dst, src, PAGE_SIZE);
> +		memunmap(src);
> +		kunmap(pg);
> +	} else {
> +		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	}

Why can't we do wrmsrl() for both cases here?

>  
>  	/*
>  	 * Ignore any errors in setting up stimer clockevents

-- 
Vitaly

