Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B09446210
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Nov 2021 11:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhKEKTm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Nov 2021 06:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232693AbhKEKTm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Nov 2021 06:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636107422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kPznHvWnpFcoHTeIhXssVu2znI1z2HpT9qw2EMKn0Kw=;
        b=NMupP2J6JDnRYXVdj07Cp2RHvNJ+6tY/a0N2Qg+k9snM/giaXN4B7shmodX/cyOqk0wLdY
        vBwNetbXCtTV9q9+JPMR818RbGY9O6LmaNeNfkLbynkQCroBlYybHGXFchZSQCXN1u3z/J
        rE+YnGPTRrfwwmqzme0GmAhpggaPijE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-Cpl6Zum4MAWsER6qrCd4MA-1; Fri, 05 Nov 2021 06:16:17 -0400
X-MC-Unique: Cpl6Zum4MAWsER6qrCd4MA-1
Received: by mail-wr1-f70.google.com with SMTP id j12-20020adf910c000000b0015e4260febdso2143362wrj.20
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Nov 2021 03:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kPznHvWnpFcoHTeIhXssVu2znI1z2HpT9qw2EMKn0Kw=;
        b=wjwiTLr2sn6nmT1XZxiu/oqXR79CKo6YQzWWgdOaifhoIsOlGvUZ857TCgbQ7UGesk
         4TWXnd6qGwIbE82w4PFgMl4W8uXhvSDfNXPPNzSOTIdKl2QhA4BeKVRExurZcS8ReA3g
         VjxWsgTf/Up3D7xl6xl6x+qvEo4Z4b0qokrimKSVyUiCTPNZLx0hwvgn2vgI0pWqpdDi
         VbzYhEIE6a40Q0qgieCXJMkqEctPoH5dp+gM/ywlDiXQFhsN4/YV9zPjZ3f9R7Nj+HlB
         FsAYLG8a7sLLQ7BwgDi9cDtX4BWzTJPk7xcBGF207XoZM3D43k1DlCICDtvT6ilQ2blg
         9Sow==
X-Gm-Message-State: AOAM531HbWGrs1cJbShSHURGwMsFgx5Inu5DEYk3vgxwVxwj/fvm+F9i
        wt38aB11rc1MSj9La0X+D6+XnJ0WPZV75vqZAesdinqod7DCMY9LV5xWrkAh1xVD9t2QkXuuhLt
        /7aF1LcMqhbQ0Wl0g+cZ55MYV
X-Received: by 2002:a1c:c908:: with SMTP id f8mr29129212wmb.142.1636107376080;
        Fri, 05 Nov 2021 03:16:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhNqPBlKrGt6TwQdZcOZ2s0zp+RaoRtDdcuBKkzTuLRk6nNdBqdk1JmcztBkYqd6i7RjoCdA==
X-Received: by 2002:a1c:c908:: with SMTP id f8mr29129188wmb.142.1636107375911;
        Fri, 05 Nov 2021 03:16:15 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z6sm7896874wrm.93.2021.11.05.03.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 03:16:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2 1/2] x86/hyperv: Fix NULL deref in
 set_hv_tscchange_cb() if Hyper-V setup fails
In-Reply-To: <20211104182239.1302956-2-seanjc@google.com>
References: <20211104182239.1302956-1-seanjc@google.com>
 <20211104182239.1302956-2-seanjc@google.com>
Date:   Fri, 05 Nov 2021 11:16:14 +0100
Message-ID: <87mtmilxg1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Check for a valid hv_vp_index array prior to derefencing hv_vp_index when
> setting Hyper-V's TSC change callback.  If Hyper-V setup failed in
> hyperv_init(), the kernel will still report that it's running under
> Hyper-V, but will have silently disabled nearly all functionality.
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] SMP
>   CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc2+ #75
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:set_hv_tscchange_cb+0x15/0xa0
>   Code: <8b> 04 82 8b 15 12 17 85 01 48 c1 e0 20 48 0d ee 00 01 00 f6 c6 08
>   ...
>   Call Trace:
>    kvm_arch_init+0x17c/0x280
>    kvm_init+0x31/0x330
>    vmx_init+0xba/0x13a
>    do_one_initcall+0x41/0x1c0
>    kernel_init_freeable+0x1f2/0x23b
>    kernel_init+0x16/0x120
>    ret_from_fork+0x22/0x30
>
> Fixes: 93286261de1b ("x86/hyperv: Reenlightenment notifications support")
> Cc: stable@vger.kernel.org
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/hyperv/hv_init.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 24f4a06ac46a..7d252a58fbe4 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -177,6 +177,9 @@ void set_hv_tscchange_cb(void (*cb)(void))
>  		return;
>  	}
>  
> +	if (!hv_vp_index)
> +		return;
> +

Arguably, we could've merged this with 'if (!hv_reenlightenment_available())' 
above to get a message printed:

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 24f4a06ac46a..4a2a091c2f0e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -172,7 +172,7 @@ void set_hv_tscchange_cb(void (*cb)(void))
        };
        struct hv_tsc_emulation_control emu_ctrl = {.enabled = 1};
 
-       if (!hv_reenlightenment_available()) {
+       if (!hv_reenlightenment_available() || !hv_vp_index) {
                pr_warn("Hyper-V: reenlightenment support is unavailable\n");
                return;
        }

just to have an indication that something is off.

>  	hv_reenlightenment_cb = cb;
>  
>  	/* Make sure callback is registered before we write to MSRs */

With or without the change,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

