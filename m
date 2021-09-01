Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340D63FD8A3
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Sep 2021 13:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242472AbhIAL0B (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Sep 2021 07:26:01 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:34735 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbhIAL0A (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Sep 2021 07:26:00 -0400
Received: by mail-wr1-f48.google.com with SMTP id m9so3999400wrb.1;
        Wed, 01 Sep 2021 04:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KaSwOXkLfh9qiRo+DNfL4zx4Fa3mJkkgXH0ivKf33k0=;
        b=OopcQCDd4v3s1aGdKomY8j2lI4g7hqNs33VBMM3gH96WrlfyCzJyLYs9P21l/UTzlq
         D/c4TjmGd13ADVEeOw1pOa6Q4znxyypiqNMfGSeWBX1O+aMcVtC7bsqt4ZpzwEx1aUfH
         nICIdU+YLwxMfelhoaA6KIrSOGTRyOFGRgFFIiVXiq+y/jyj/JgpgbaZA26R1UcTp/49
         LF/GFWaLEFKuLF7t6baWZc8JgirS/X6d8zAL8+BcmJYcgU5LNdFo5SdRKZr6UZv7s8v+
         aufZXtcw60tgEZa6/AqMkaP12fb0eBYTLPbxPVxxpapKotuZoJuX/hzHx5AnvCcioTN8
         VdJg==
X-Gm-Message-State: AOAM530yhwLKRduUeTz4sKWFbGwwcUwL/LJj1xtRGs5ISCAqvIeDeu96
        VOmf3J/J50jXpS8MFras9ZQ=
X-Google-Smtp-Source: ABdhPJzr/QEmTSlf+41SpOvqer+18Ydhe6vTOke21tVwcKpu3XTdknRwGjCwPdabRjDMHjTT9rvTFw==
X-Received: by 2002:adf:ed85:: with SMTP id c5mr35984071wro.379.1630495503194;
        Wed, 01 Sep 2021 04:25:03 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v5sm20680606wrw.44.2021.09.01.04.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:25:02 -0700 (PDT)
Date:   Wed, 1 Sep 2021 11:25:00 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, Andres Beltran <lkmlabelt@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix kernel crash upon unbinding a
 device from uio_hv_generic driver
Message-ID: <20210901112500.7q4oxjtesiuniop3@liuwe-devbox-debian-v2>
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

This certainly won't hurt.

I would however like to wait till Andrea and Michael go over the
reasoning of this patch before doing anything.

Wei.

>  	ring_info->pkt_buffer_size = 0;
>  }
>  
> -- 
> 2.31.1
> 
