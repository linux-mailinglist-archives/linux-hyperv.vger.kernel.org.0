Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9FB3FDE96
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Sep 2021 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343713AbhIAP0K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Sep 2021 11:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343726AbhIAP0J (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Sep 2021 11:26:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861D5C061575;
        Wed,  1 Sep 2021 08:25:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id q17so4400163edv.2;
        Wed, 01 Sep 2021 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b8PqCqBTpRcV16xsLLDnhr5LuVBDAMakK1uy+SsVjMM=;
        b=FOQzkMv5slkXaelBQlgnyGuCYkgbB2QLK2471cEIXDAHGND9IRukuMHgsbTp0cNNWw
         8D4kBijOvqPBF+plun9g6qP6ZSfGRxiNvY7kU9Y86wABVJ/P8b0ZvjJH/OO3zwvAnLDk
         mTluMHYEe6nRyfxjoqLEm8Y2AbXakmiaFDXWM/5Lpnl87ko+czwPM7dw/QhpHYs9ErcA
         bxzy7QYMRwvbqYgCeWdkBm3InMz/vFSurqF3Rtjao/00nIwiUp3TtERTHMaGOYCf2kl3
         oWPtPaSwr3jjF33GcL1YSM82Y9t+wstiS848oHkv/f/GKL/Jr6oW8Pp33F/5UPFhYp00
         1zNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b8PqCqBTpRcV16xsLLDnhr5LuVBDAMakK1uy+SsVjMM=;
        b=Mvw06/21g8eDPBBZZvAjpFhUt5eJa79vTbGcDpp+wstRgVnvUUPmd44+Zhmx9zCs0G
         5ifHgz6GsKewCfio5LNcJszi6gV+4G36YuqAX4bYOA6W3KqY4mJh+lAOSP7O3VIxYJdN
         iRXYqwmFYOzzpi1iIOcZ1OhwxnwUTiJbmcJdlcxYFbR2oIFIGT87nWa8caD3Wmz5LHW/
         DBWJgI3otMyoiNVSbsqgObqBjYBBygGRzmtn6faKGUeA00jDfLn/dtcGdo9f9pw6LdsO
         uAK4+CxeGnVUdiO/yqUsLoTg7nZNvuU+dbm2kF7+ehBuImbVdH/WewEGkeEiP0GgAu0p
         slpg==
X-Gm-Message-State: AOAM5314iBlxvHPRZaHgXOgW0W2makS3ufheyTJsE/j5I4SwlZFP/Gal
        N0rmSFrjgelayL7VurzoQTS9Bir2dHHvGyJG
X-Google-Smtp-Source: ABdhPJxWOum36f060/87nuVq8ONvaORBy5QFGXZod7eQu7pkvd1J1WQkC/4bV4H+8/c0e5PofSm1Cw==
X-Received: by 2002:a05:6402:cab:: with SMTP id cn11mr113964edb.293.1630509910872;
        Wed, 01 Sep 2021 08:25:10 -0700 (PDT)
Received: from anparri (host-79-24-20-93.retail.telecomitalia.it. [79.24.20.93])
        by smtp.gmail.com with ESMTPSA id x9sm95851edj.95.2021.09.01.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 08:25:10 -0700 (PDT)
Date:   Wed, 1 Sep 2021 17:25:02 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, Andres Beltran <lkmlabelt@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix kernel crash upon unbinding a
 device from uio_hv_generic driver
Message-ID: <20210901152502.GA4349@anparri>
References: <20210831143916.144983-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831143916.144983-1-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 31, 2021 at 04:39:16PM +0200, Vitaly Kuznetsov wrote:
> The following crash happens when a never-used device is unbound from
> uio_hv_generic driver:
> 
>  kernel BUG at mm/slub.c:321!
>  invalid opcode: 0000 [#1] SMP PTI
>  CPU: 0 PID: 4001 Comm: bash Kdump: loaded Tainted: G               X --------- ---  5.14.0-0.rc2.23.el9.x86_64 #1
>  Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
>  RIP: 0010:__slab_free+0x1d5/0x3d0
> ...
>  Call Trace:
>   ? pick_next_task_fair+0x18e/0x3b0
>   ? __cond_resched+0x16/0x40
>   ? vunmap_pmd_range.isra.0+0x154/0x1c0
>   ? __vunmap+0x22d/0x290
>   ? hv_ringbuffer_cleanup+0x36/0x40 [hv_vmbus]
>   kfree+0x331/0x380
>   ? hv_uio_remove+0x43/0x60 [uio_hv_generic]
>   hv_ringbuffer_cleanup+0x36/0x40 [hv_vmbus]
>   vmbus_free_ring+0x21/0x60 [hv_vmbus]
>   hv_uio_remove+0x4f/0x60 [uio_hv_generic]
>   vmbus_remove+0x23/0x30 [hv_vmbus]
>   __device_release_driver+0x17a/0x230
>   device_driver_detach+0x3c/0xa0
>   unbind_store+0x113/0x130
> ...
> 
> The problem appears to be that we free 'ring_info->pkt_buffer' twice:
> first, when the device is unbound from in-kernel driver (netvsc in this
> case) and second from hv_uio_remove(). Normally, ring buffer is supposed
> to be re-initialized from hv_uio_open() but this happens when UIO device
> is being opened and this is not guaranteed to happen.
> 
> Generally, it is OK to call hv_ringbuffer_cleanup() twice for the same
> channel (which is being handed over between in-kernel drivers and UIO) even
> if we didn't call hv_ringbuffer_init() in between. We, however, need to
> avoid kfree() call for an already freed pointer.
> 
> Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

LGTM.

Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

ae6935ed7d424f appears to have anticipated this problem on ->ring_buffer
and adopted the solution proposed here by Vitaly.

  Andrea


> ---
>  drivers/hv/ring_buffer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 2aee356840a2..314015d9e912 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -245,6 +245,7 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info)
>  	mutex_unlock(&ring_info->ring_buffer_mutex);
>  
>  	kfree(ring_info->pkt_buffer);
> +	ring_info->pkt_buffer = NULL;
>  	ring_info->pkt_buffer_size = 0;
>  }
>  
> -- 
> 2.31.1
> 
