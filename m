Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F433EEBBE
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Aug 2021 13:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbhHQLaa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Aug 2021 07:30:30 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:54034 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbhHQLaa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Aug 2021 07:30:30 -0400
Received: by mail-wm1-f43.google.com with SMTP id k4so13486827wms.3;
        Tue, 17 Aug 2021 04:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f1vOCac0RpfwqbOEiPeRvX2ve16zSx0Z9z2fikjKVW0=;
        b=keEIA2jqSLnBxOewToJe8YuZr+4nvpYIKTygTHSv9bjzRPTHhIdlEk80PaV0eiZv/9
         +Zko51eoSpV7x6M7guRq/J79YwU/EE2c5Zb1zrS7NRFQYnR77qg8GOo5o+gwNvyBUBfY
         sny55L0FSOTs/b4O6GduZ4qHzHG78bjBzsR7pFPslmyeDJnQ4Y8nDaeOOgI+dyu/GLrV
         07aWLiVV/Y79i6IfAxHhLmmy7P9MNqoUyspfrJayOIsoUoG9g5jZ3mXJMqh6TR5jZsxr
         RmE9BpqXDrgj0UQjjE9DcHUvItY59xBH5OSdBkhbHxD+9mh/8HnNNIeEZgX8NkCOee9a
         /1Jw==
X-Gm-Message-State: AOAM531+gP0SSN/zUwbrxB2ziIOJ54K7wiX8n+ZkGHAxQu5nXOeDZU4I
        RXp5kq+paLAPK2W5TBscaN8=
X-Google-Smtp-Source: ABdhPJxTp7v8K2H4tc0C6+LGrmq0Hb3G/UPu3HsVbjaWWE/+fTywUcYwOYPUST1N5+SqYCFbFHnLRw==
X-Received: by 2002:a05:600c:4145:: with SMTP id h5mr1775054wmm.7.1629199796510;
        Tue, 17 Aug 2021 04:29:56 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m10sm2728614wro.63.2021.08.17.04.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 04:29:56 -0700 (PDT)
Date:   Tue, 17 Aug 2021 11:29:54 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     David Mozes <david.mozes@silk.us>
Cc:     David Moses <mosesster@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        =?utf-8?B?16rXldee16gg15DXkdeV15jXkdeV15w=?= 
        <tomer432100@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Message-ID: <20210817112954.ufjd77ujq5nhmmew@liuwe-devbox-debian-v2>
References: <MWHPR21MB15935468547C25294A253E0AD7F39@MWHPR21MB1593.namprd21.prod.outlook.com>
 <FD8265E6-895E-45CF-9AE3-787FAD669FC8@gmail.com>
 <VI1PR0401MB2415E89B6E3D01B446FD1DACF1FE9@VI1PR0401MB2415.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB2415E89B6E3D01B446FD1DACF1FE9@VI1PR0401MB2415.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Please use the "reply all" button in your mail client and  avoid
top-posting. It is very difficult for me to decipher this thread...

On Tue, Aug 17, 2021 at 09:16:45AM +0000, David Mozes wrote:
> Hi Michael and all .
> I am back from the Holiday and did your saggestiones /requstes 
> 
> 1. While  running with patch number-2 (disable the Hyper-V specific flush routines) 
>  As you suspected, we got panic similar to what we got with the Hyper-V specific flash routines. 
> Below is the trace we got: 
> 
> 	[32097.577728] kernel BUG at kernel/sched/rt.c:1004!
> [32097.577738] invalid opcode: 0000 [#1] SMP
> [32097.578711] CPU: 45 PID: 51244 Comm: STAR4BLKS0_WORK Kdump: loaded Tainted: G           OE     4.19.195-KM9 #1

It seems that you have out of tree module(s) loaded. Please make sure
they don't do anything unusual.

> [32097.578711] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
> [32097.578711] RIP: 0010:dequeue_top_rt_rq+0x88/0xa0
> [32097.578711] Code: 00 48 89 d5 48 0f a3 15 6e 19 82 01 73 d0 48 89 c7 e8 bc b7 fe ff be 02 00 00 00 89 ef 84 c0 74 0b e8 2c 94 04 00 eb b6 0f 0b <0f> 0b e8 b1 93 04 00 eb ab 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00
> [32097.578711] RSP: 0018:ffff9442e0de7b48 EFLAGS: 00010046
> [32097.578711] RAX: ffff94809f9e1e00 RBX: ffff9448295e4c40 RCX: 00000000ffffffff
> [32097.578711] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff94809f9e2040
> [32097.578711] RBP: ffff94809f9e1e00 R08: fffffffffff0be25 R09: 00000000000216c0
> [32097.578711] R10: 00004bbc85e1eff3 R11: 0000000000000000 R12: 0000000000000000
> [32097.578711] R13: ffff9448295e4a20 R14: 0000000000021e00 R15: ffff94809fa21e00
> [32097.578711] FS:  00007f7b0cea0700(0000) GS:ffff94809f940000(0000) knlGS:0000000000000000
> [32097.578711] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [32097.578711] CR2: ffffffffff600400 CR3: 000000201d5b3002 CR4: 00000000003606e0
> [32097.578711] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [32097.578711] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [32097.578711] Call Trace:
> [32097.578711]  dequeue_rt_stack+0x3e/0x280
> [32097.578711]  dequeue_rt_entity+0x1f/0x70
> [32097.578711]  dequeue_task_rt+0x26/0x70
> [32097.578711]  push_rt_task+0x1e2/0x220
> [32097.578711]  push_rt_tasks+0x11/0x20
> [32097.578711]  __balance_callback+0x3b/0x60
> [32097.578711]  __schedule+0x6e9/0x830
> [32097.578711]  schedule+0x28/0x80

It looks like the scheduler is in an irrecoverable state. The stack
trace does not show anything related to TLB flush, so it is unclear to
me this has anything to do with the original report.

Have you tried running the same setup on baremetal?


> [32097.578711]  futex_wait_queue_me+0xb9/0x120
> [32097.578711]  futex_wait+0x139/0x250
> [32097.578711]  ? try_to_wake_up+0x54/0x460
> [32097.578711]  ? enqueue_task_rt+0x9f/0xc0
> [32097.578711]  ? get_futex_key+0x2ee/0x450
> [32097.578711]  do_futex+0x2eb/0x9f0
> [32097.578711]  __x64_sys_futex+0x143/0x180
> [32097.578711]  do_syscall_64+0x59/0x1b0
> [32097.578711]  ? prepare_exit_to_usermode+0x70/0x90
> [32097.578711]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [32097.578711] RIP: 0033:0x7fa2ae151334
> [32097.578711] Code: 66 0f 1f 44 00 00 41 52 52 4d 31 d2 ba 02 00 00 00 81 f6 80 00 00 00 64 23 34 25 48 00 00 00 39 d0 75 07 b8 ca 00 00 00 0f 05 <89> d0 87 07 85 c0 75 f1 5a 41 5a c3 83 3d f1 df 20 00 00 74 59 48
> [32097.578711] RSP: 002b:00007f7b0ce9f3b0 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> [32097.578711] RAX: ffffffffffffffda RBX: 00007f7c1da5bc18 RCX: 00007fa2ae151334
> [32097.578711] RDX: 0000000000000002 RSI: 0000000000000080 RDI: 00007f7c1da5bc58
> [32097.578711] RBP: 00007f7b0ce9f5b0 R08: 00007f7c1da5bc58 R09: 000000000000c82c
> [32097.578711] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7b1a149cf0
> [32097.578711] R13: 00007f7c1da5bc58 R14: 0000000000000001 R15: 00000000000005a1
> 
> 
> 2. as you requested and to help to the community  we running patch no 1 as well : 
> 
> And that is what we got: 
> 
> 	Aug 17 05:36:22 10.230.247.7 [40544.392690] Hyper-V: ERROR_HYPERV: cpu_last= 
> 
> It looks like we got an empty cpumask ! 	

Assuming this is from the patch below, the code already handles empty
cpumask a few lines later.

You should perhaps move your change after that to right before cpus is
actually used.

Wei.

> 
> Would you please let us know what father info you need and what Is the next step for debugging this interesting issue 
> 
> Thx
> David 
> 
> 
> 
> 
> >> 1) Print the cpumask when < num_possible_cpus():
> >> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> >> index e666f7eaf32d..620f656d6195 100644
> >> --- a/arch/x86/hyperv/mmu.c
> >> +++ b/arch/x86/hyperv/mmu.c
> >> @@ -60,6 +60,7 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
> >>         struct hv_tlb_flush *flush;
> >>         u64 status = U64_MAX;
> >>         unsigned long flags;
> >> +       unsigned int cpu_last;
> >> 
> >>         trace_hyperv_mmu_flush_tlb_others(cpus, info);
> >> 
> >> @@ -68,6 +69,11 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
> >> 
> >>         local_irq_save(flags);
> >> 
> >> +       cpu_last = cpumask_last(cpus);
> >> +       if (cpu_last > num_possible_cpus()) {
> > 
> > I think this should be ">=" since cpus are numbered starting at zero.
> > In your VM with 64 CPUs, having CPU #64 in the list would be error.
> > 
> >> +               pr_emerg("ERROR_HYPERV: cpu_last=%*pbl", cpumask_pr_args(cpus));
> >> +       }
> >> +
> >>         /*
> >>          * Only check the mask _after_ interrupt has been disabled to avoid the
> >>          * mask changing under our feet.
> >> 
