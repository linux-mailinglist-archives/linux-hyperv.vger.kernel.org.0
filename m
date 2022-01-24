Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A46E497BC2
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jan 2022 10:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiAXJU3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Jan 2022 04:20:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232544AbiAXJUU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Jan 2022 04:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643016019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JrLz3L3tcI/I3BMhVWiGKT3p97BtzBHRcz9TbUScQEA=;
        b=Fp2EElm1N9LSQsHyT3CMVR4CbHBuJQxchh/+2NoWC0Goh7mspRg3aZLxl/S4J77WmyYcSu
        djltZs4GD9GJTmHrb+kH6qn6ocpKhyrveiHbGALrXNh0q/E+NHhCcv6K7/aCtBm6ZAG2rh
        o/P+KNr+I2af4QupDLXmDnsCa3Yx7H0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-mW2ljEpoNKu2iINjpfhQig-1; Mon, 24 Jan 2022 04:20:17 -0500
X-MC-Unique: mW2ljEpoNKu2iINjpfhQig-1
Received: by mail-wr1-f69.google.com with SMTP id a11-20020adffb8b000000b001a0b0f4afe9so1600369wrr.13
        for <linux-hyperv@vger.kernel.org>; Mon, 24 Jan 2022 01:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JrLz3L3tcI/I3BMhVWiGKT3p97BtzBHRcz9TbUScQEA=;
        b=ralDDDituaMgghmCTqSidvS7ExG2DnUt4H6jaj7tSdVdkjXFu0NgSgGNvVGLOWCmQ2
         1SmxtZk4dBVSPM5pMeOg/0Tjm/JkqR3hYlKAEzEDjjVcXA2YlCyDYayo9zAapwNSWyjY
         F96xJ6YZGtYES+ro3aDu34ZjDoYp1kTOcU6Ic0r1D1/0traA+KCMueLG5KjCObcO3T30
         khRK3p+fR3hT3ndClGGDx1k3GOSS8FcNeAJP7EBzyrhvKlSU3H+6wM4kwLeEj1spKXj0
         XRRRlwT0zR3Oh3JTCnvV8DEfl4pBQZdHOiN7u+WcHHTyPoXYczYQjNt3HzK2N0WUg8W+
         f+Cg==
X-Gm-Message-State: AOAM5325A/HvvWo74EAVqVu2AHP/YcHZsbtrwvs371PngPYZ1d+g91v6
        VX6MoXi/R3DCfz3iAQfjWe48YunktOSRxCxBzpdEZmEv6bcTB9+15Ryvah6NcAyUk+horSA5dvW
        vMZOMmYn/RtHbVrPalYx2R2qCP1BoF7ELPMH+HhkTyg6GONWF254NFeO6hwbUFUe4/8+KCc2ARB
        mo
X-Received: by 2002:a05:6000:15cd:: with SMTP id y13mr8194703wry.717.1643016016320;
        Mon, 24 Jan 2022 01:20:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4R22u7FIxHqgpdrWuaajXWUTtWvmGkHFSfBJmpgldZHbqSTAVOG6ygBQXND7VsYnOQae8Ww==
X-Received: by 2002:a05:6000:15cd:: with SMTP id y13mr8194655wry.717.1643016016053;
        Mon, 24 Jan 2022 01:20:16 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 31sm16657869wrl.27.2022.01.24.01.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 01:20:15 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 43/54] drivers/hv: replace cpumask_weight with
 cpumask_weight_eq
In-Reply-To: <20220123183925.1052919-44-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-44-yury.norov@gmail.com>
Date:   Mon, 24 Jan 2022 10:20:13 +0100
Message-ID: <87sftdij76.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Yury Norov <yury.norov@gmail.com> writes:

> init_vp_index() calls cpumask_weight() to compare the weights of cpumasks
> We can do it more efficiently with cpumask_weight_eq because conditional
> cpumask_weight may stop traversing the cpumask earlier (at least one), as
> soon as condition is met.

Same comment as for "PATCH 41/54": cpumask_weight_eq() can only stop
earlier if the condition is not met, to prove the equality all bits need
always have to be examined.

>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 60375879612f..7420a5fd47b5 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -762,8 +762,8 @@ static void init_vp_index(struct vmbus_channel *channel)
>  		}
>  		alloced_mask = &hv_context.hv_numa_map[numa_node];
>  
> -		if (cpumask_weight(alloced_mask) ==
> -		    cpumask_weight(cpumask_of_node(numa_node))) {
> +		if (cpumask_weight_eq(alloced_mask,
> +			    cpumask_weight(cpumask_of_node(numa_node)))) {

This code is not performace critical and I prefer the old version:

 	cpumask_weight() == cpumask_weight()

 looks better than

	cpumask_weight_eq(..., cpumask_weight())

(let alone the inner cpumask_of_node()) to me.

>  			/*
>  			 * We have cycled through all the CPUs in the node;
>  			 * reset the alloced map.

-- 
Vitaly

