Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5DF2B086E
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 16:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgKLPbE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 10:31:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728231AbgKLPbE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 10:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605195062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XHp7Bo10vm0UfwNZa83vSvzkaRjk9257JvNRreDbMPA=;
        b=i8rjBmP0C5zRz7t2g6S6Rlh54z0DHobnsdzqi4eX+B1pbt39811kEnI2Y13hSIF0+UqbM3
        7mLfSldlK1pa2GmpHL+Uj1NdW0hncsEqbSBzJ27xm0rXVhd1uGh62oy5sSUK8d9KgM7z5A
        PtFdw58GYpV1bTIOLMvPPH+gvH67NM8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-kvtycSgHMp-nscENdOn-uA-1; Thu, 12 Nov 2020 10:31:00 -0500
X-MC-Unique: kvtycSgHMp-nscENdOn-uA-1
Received: by mail-wm1-f71.google.com with SMTP id y26so1865503wmj.7
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2020 07:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XHp7Bo10vm0UfwNZa83vSvzkaRjk9257JvNRreDbMPA=;
        b=XYOFFHAUzN5d1J3H1H1PF50tpLXB1LQMlpel8lprDRDlrO9/triqFmVyGz3+ZXk8oy
         LeDU6eekKv1FVfsCDNcMSU1y9yogVlMAJnWioW1v+m210GV2oPlse63yxR8qKU1ixAaG
         k4m/gvQjPmtUZbHnfIbCs86BiBaL3+mYm84PpxyliVJvwjd0GpeGYNB7tmE2tk+zf9oT
         AnRay+P/SKtBA13eUvr2toa8IAqAIG2rWBf5JeOkZHtDWgiCOt+M/s1WzKOxQlZc1cur
         DA9VnKjvenbiZK5GMekl9YFP0GXPQUMEMVc3rqyiJLp3mBzbTi0UHs3Rw5rLWmL/i1gF
         9nmA==
X-Gm-Message-State: AOAM531VLOdHKPfnzbQVihOwdG2evtWwwmiZ/qSpnhjLzRS+u4umfa2D
        3u1sPQvc/OQXd9vMIfdO5hRoObBJvkcTWBPMdstDqqBg9GlOdOvpo8T41KzPsMt1BJScCCT6rBH
        qw6B4HNeHmTCvYwAUlb5wyuuA
X-Received: by 2002:adf:f542:: with SMTP id j2mr56187wrp.107.1605195059652;
        Thu, 12 Nov 2020 07:30:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1OngyKpQAS+Q4bbI3Hywakt2LTSLrDkVsSOy8wiQ/1aW5MGElsPEZVtZPjFlyvRpBGUIsaQ==
X-Received: by 2002:adf:f542:: with SMTP id j2mr56174wrp.107.1605195059474;
        Thu, 12 Nov 2020 07:30:59 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c129sm7158288wmd.7.2020.11.12.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:30:58 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 05/17] clocksource/hyperv: use MSR-based access if
 running as root
In-Reply-To: <20201105165814.29233-6-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-6-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:30:57 +0100
Message-ID: <87d00iy4lq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> Signed-off-by: Wei Liu <wei.liu@kernel.org>

In the missing commit message I'd like to see why we don't use 'TSC
page' clocksource for the root partition. My guess would be that it's
not available and actually we're supposed to use raw TSC value (because
root partitions never migrate) but please spell it out.

> ---
>  drivers/clocksource/hyperv_timer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index ba04cb381cd3..269a691bd2c4 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -426,6 +426,9 @@ static bool __init hv_init_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return false;
>  
> +	if (hv_root_partition)
> +		return false;
> +
>  	hv_read_reference_counter = read_hv_clock_tsc;
>  	phys_addr = virt_to_phys(hv_get_tsc_page());

-- 
Vitaly

