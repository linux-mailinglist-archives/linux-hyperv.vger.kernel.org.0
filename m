Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAF327758B
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Sep 2020 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgIXPg7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Sep 2020 11:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728139AbgIXPg7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Sep 2020 11:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600961817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjW6jQGewuIh7wjRg7lkekbFgljfn1Q0WKM0iJVFmTc=;
        b=TphtjcqCjFaW3YGB7Q93ukYntohPW0SldWMfIrDJsL9BpqzoVOv4tHOtAdSq9MbRe+pOj7
        BypbLy0fRi/7wupBt+XKhOdZ4uomm2W1kUWsMa1ED8/CGpt9rO+x1MILbOcWjilWmes6Ys
        UjvLEOpuNhw5AATzKFFhHNSY8EHBT1s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-96AlOkcCPIOZoKAHhcOxkA-1; Thu, 24 Sep 2020 11:36:55 -0400
X-MC-Unique: 96AlOkcCPIOZoKAHhcOxkA-1
Received: by mail-wm1-f69.google.com with SMTP id a7so1384003wmc.2
        for <linux-hyperv@vger.kernel.org>; Thu, 24 Sep 2020 08:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WjW6jQGewuIh7wjRg7lkekbFgljfn1Q0WKM0iJVFmTc=;
        b=TztFY7vTWD0Npssb9eMmWozaDZTK3yeXZ1UbIJtHCUE6NX0KlzhFcGbYKlFw2Q8J6y
         NEYJp0NagEzDPMdyc9fPkXRdgGe4CNSGGbAo+B2DRnLLl7ZVOemOOSSQnCcrAp/hBK82
         RJ5hgtGVmYnYLXpd5ug+r5d+RGNsNVrCZ67UREng+jjfd1xkdONyKoHVSAr9J1QNn5L3
         zPdLoOkbqGdcE2nKAg7JHc/2bAhyP2eIhQV1mTtMwxrNaFreM6gzm7fgFlQFjDBd8J+B
         qiQ1lkCZM5PEvyHQYhdRHYXLTX5LsuuRiZx6i/qbHwALqfXwnPNjXwuAUFKRbUgR8Xd7
         vFnw==
X-Gm-Message-State: AOAM533HIyA9qDQovWQNnpf1TrMKtSnkh2+nHSBHjmmue+Ax/n4jQbOr
        8n8DWsqlhzr5m4g+L/3dq6SfzagHRtHL2Fttrl+Qc7zdTUphqkluFCzqvwH3aXzFYFEGB77R7UU
        ocjPtF2vHMc8OH1suK3s4Aleg
X-Received: by 2002:adf:a49d:: with SMTP id g29mr371141wrb.219.1600961813255;
        Thu, 24 Sep 2020 08:36:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQQEvyY8FDVVtfnFw8D9lgSckf6rQqNpCOTNS/+eiROwRhVhxvj6qaFAQCKBgwIDwyj55iNg==
X-Received: by 2002:adf:a49d:: with SMTP id g29mr371109wrb.219.1600961812913;
        Thu, 24 Sep 2020 08:36:52 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b84sm4406575wmd.0.2020.09.24.08.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:36:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Mohammed Gamal <mgamal@redhat.com>, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Tianyu.Lan@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org,
        Mohammed Gamal <mgamal@redhat.com>
Subject: Re: [PATCH] hv: clocksource: Add notrace attribute to read_hv_sched_clock_*() functions
In-Reply-To: <20200924151117.767442-1-mgamal@redhat.com>
References: <20200924151117.767442-1-mgamal@redhat.com>
Date:   Thu, 24 Sep 2020 17:36:51 +0200
Message-ID: <87pn6bchkc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Mohammed Gamal <mgamal@redhat.com> writes:

> When selecting function_graph tracer with the command:
>  # echo function_graph > /sys/kernel/debug/tracing/current_tracer
>
> The kernel crashes with the following stack trace:
>
> [69703.122389] BUG: stack guard page was hit at 000000001056545c (stack is 00000000fa3f8fed..0000000005d39503)
> [69703.122403] kernel stack overflow (double-fault): 0000 [#1] SMP PTI
> [69703.122413] CPU: 0 PID: 16982 Comm: bash Kdump: loaded Not tainted 4.18.0-236.el8.x86_64 #1
> [69703.122420] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.0 12/17/2019
> [69703.122433] RIP: 0010repare_ftrace_return+0xa/0x110
> [69703.122458] Code: 05 00 0f 0b 48 c7 c7 10 ca 69 ae 0f b6 f0 e8 4b 52 0c 00 31 c0 eb ca 66 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 56 41 55 41 54 <53> 48 83 ec 18 65 48 8b 04 25 28 00 00 00 48 89 45 d8 31 c0 48 85
> [69703.122467] RSP: 0018:ffffbd6d01118000 EFLAGS: 00010086
> [69703.122476] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000003
> [69703.122484] RDX: 0000000000000000 RSI: ffffbd6d011180d8 RDI: ffffffffadce7550
> [69703.122491] RBP: ffffbd6d01118018 R08: 0000000000000000 R09: ffff9d4b09266000
> [69703.122498] R10: ffff9d4b0fc04540 R11: ffff9d4b0fc20a00 R12: ffff9d4b6e42aa90
> [69703.122506] R13: ffff9d4b0fc20ab8 R14: 00000000000003e8 R15: ffffbd6d0111837c
> [69703.122514] FS:  00007fd5f2588740(0000) GS:ffff9d4b6e400000(0000) knlGS:0000000000000000
> [69703.122521] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [69703.122528] CR2: ffffbd6d01117ff8 CR3: 00000000565d8001 CR4: 00000000003606f0
> [69703.122538] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [69703.122545] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [69703.122552] Call Trace:
> [69703.122568]  ftrace_graph_caller+0x6b/0xa0
> [69703.122589]  ? read_hv_sched_clock_tsc+0x5/0x20
> [69703.122599]  read_hv_sched_clock_tsc+0x5/0x20
> [69703.122611]  sched_clock+0x5/0x10
> [69703.122621]  sched_clock_local+0x12/0x80
> [69703.122631]  sched_clock_cpu+0x8c/0xb0
> [69703.122644]  trace_clock_global+0x21/0x90
> [69703.122655]  ring_buffer_lock_reserve+0x100/0x3c0
> [69703.122671]  trace_buffer_lock_reserve+0x16/0x50
> [69703.122683]  __trace_graph_entry+0x28/0x90
> [69703.122695]  trace_graph_entry+0xfd/0x1a0
> [69703.122705]  ? read_hv_clock_tsc_cs+0x10/0x10
> [69703.122714]  ? sched_clock+0x5/0x10
> [69703.122723]  prepare_ftrace_return+0x99/0x110
> [69703.122734]  ? read_hv_clock_tsc_cs+0x10/0x10
> [69703.122743]  ? sched_clock+0x5/0x10
> [69703.122752]  ftrace_graph_caller+0x6b/0xa0
> [69703.122768]  ? read_hv_clock_tsc_cs+0x10/0x10
> [69703.122777]  ? sched_clock+0x5/0x10
> [69703.122786]  ? read_hv_sched_clock_tsc+0x5/0x20
> [69703.122796]  ? ring_buffer_unlock_commit+0x1d/0xa0
> [69703.122805]  read_hv_sched_clock_tsc+0x5/0x20
> [69703.122814]  ftrace_graph_caller+0xa0/0xa0
> [69703.122823]  ? trace_clock_local+0x5/0x10
> [69703.122831]  ? ftrace_push_return_trace+0x5d/0x120
> [69703.122842]  ? read_hv_clock_tsc_cs+0x10/0x10
> [69703.122850]  ? sched_clock+0x5/0x10
> [69703.122860]  ? prepare_ftrace_return+0xd5/0x110
> [69703.122871]  ? read_hv_clock_tsc_cs+0x10/0x10
> [69703.122879]  ? sched_clock+0x5/0x10
> [69703.122889]  ? ftrace_graph_caller+0x6b/0xa0
> [69703.122904]  ? read_hv_clock_tsc_cs+0x10/0x10
> [69703.122912]  ? sched_clock+0x5/0x10
> [69703.122922]  ? read_hv_sched_clock_tsc+0x5/0x20
> [69703.122931]  ? ring_buffer_unlock_commit+0x1d/0xa0
> [69703.122940]  ? read_hv_sched_clock_tsc+0x5/0x20
> [69703.122966]  ? ftrace_graph_caller+0xa0/0xa0
> [69703.122975]  ? trace_clock_local+0x5/0x10
> [69703.122984]  ? ftrace_push_return_trace+0x5d/0x120
> [69703.122995]  ? read_hv_clock_tsc_cs+0x10/0x10
> [69703.123006]  ? sched_clock+0x5/0x10
> [69703.123016]  ? prepare_ftrace_return+0xd5/0x110
> [69703.123026]  ? read_hv_clock_tsc_cs+0x10/0x10
> [69703.123035]  ? sched_clock+0x5/0x10
> [69703.123044]  ? ftrace_graph_caller+0x6b/0xa0
> [69703.123059]  ? read_hv_clock_tsc_cs+0x10/0x10
> [69703.123068]  ? sched_clock+0x5/0x10

Obviously we're seeing a recursion, we can trim this log a bit.

>
> Setting the notrace attribute for read_hv_sched_clock_msr() and
> read_hv_sched_clock_tsc() fixes it
>
> Fixes: bd00cd52d5be ("clocksource/drivers/hyperv: Add Hyper-V specific
> sched clock function")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Rather 'Suggested-by:' but not a big deal.

> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  drivers/clocksource/hyperv_timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 09aa44cb8a91d..ba04cb381cd3f 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -341,7 +341,7 @@ static u64 notrace read_hv_clock_tsc_cs(struct clocksource *arg)
>  	return read_hv_clock_tsc();
>  }
>  
> -static u64 read_hv_sched_clock_tsc(void)
> +static u64 notrace read_hv_sched_clock_tsc(void)
>  {
>  	return (read_hv_clock_tsc() - hv_sched_clock_offset) *
>  		(NSEC_PER_SEC / HV_CLOCK_HZ);
> @@ -404,7 +404,7 @@ static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
>  	return read_hv_clock_msr();
>  }
>  
> -static u64 read_hv_sched_clock_msr(void)
> +static u64 notrace read_hv_sched_clock_msr(void)
>  {
>  	return (read_hv_clock_msr() - hv_sched_clock_offset) *
>  		(NSEC_PER_SEC / HV_CLOCK_HZ);

-- 
Vitaly

