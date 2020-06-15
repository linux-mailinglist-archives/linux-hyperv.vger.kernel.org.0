Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9011F919C
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jun 2020 10:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgFOIf2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 Jun 2020 04:35:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35442 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728451AbgFOIf1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Jun 2020 04:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592210125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=phOlbjTOdvARM/mTZZxrS9vASbyMVJpwN2vWscSJYrs=;
        b=Bqn4wC0ax//pQVvX6TbdXNPSId4x5ZOlS6jSr6sb40v1l/loeEvVbc2tQkn88DUlw+1EPx
        fk8TlG2Ei2E+nbGmi4xVXHr7BOjItQVLALcz6slUzFySvCVgT3RE1dK0kSM6fidsvBOTMa
        QoY3rFPPJXRO/FQbjlGV85N5oX5AzZ0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-di-8CbbgPT6uSLIvCemkAA-1; Mon, 15 Jun 2020 04:35:23 -0400
X-MC-Unique: di-8CbbgPT6uSLIvCemkAA-1
Received: by mail-ej1-f71.google.com with SMTP id s4so7499604eju.3
        for <linux-hyperv@vger.kernel.org>; Mon, 15 Jun 2020 01:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=phOlbjTOdvARM/mTZZxrS9vASbyMVJpwN2vWscSJYrs=;
        b=ivxz7jQoysynfkg5mQCm1Gj7oJXRUnvctmg7quykU0X4kj8SOTF6vCSN6TO0RZwYXA
         2ysT7zN6KzHwmnkKa0wyWBnTHnR/m6jnxEgnoIa2eYa11V6Jug5sTM2QmYCKgzsRFCJX
         oGA+3EIP3TP9GG8FNNpccQtjPsXvP1q6y+UhW+v8URU4L8QHNs217/bOnbdceBb7qCdu
         D5pQRMgFMCKBmPDudCuwFOGy1VJuMzzHevLQoWVC3FLTnzEYyeno6iKxtgYtMADYGbj6
         ktpMX7Ln22+r+kMyxyHQc+d4e5XbgsNX0rYIo8GGQ8LDCfcLBle3/E/ZoEK5oNQaz21X
         PT0A==
X-Gm-Message-State: AOAM532XsJhbElCMogmiVjsBjm6R5g9j4q7qIF/+e2AYBG8MP+vUUDbq
        yXjzyPw8YzzGJkWX0TiQz/UoTzCYtBOjReS5UUBVN6WW42cwmVUtCpoFf3A5oqGS0afpklxAtuH
        8Vsr969zk1Z/R7cIjWIKd0pR8
X-Received: by 2002:a17:906:3e0c:: with SMTP id k12mr23882432eji.441.1592210121746;
        Mon, 15 Jun 2020 01:35:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwJhR4Ph1kPkjPbkWaXkAb68i/Q8V3TMlwCsSQPQMFouFvWhAe3TPiPcOe32u+hPvuWdgu9g==
X-Received: by 2002:a17:906:3e0c:: with SMTP id k12mr23882413eji.441.1592210121421;
        Mon, 15 Jun 2020 01:35:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id bg21sm8608364ejb.90.2020.06.15.01.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:35:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Christoph Hellwig <hch@lst.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: hv_hypercall_pg page permissios
In-Reply-To: <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
References: <20200407073830.GA29279@lst.de> <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net> <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
Date:   Mon, 15 Jun 2020 10:35:19 +0200
Message-ID: <87y2ooiv5k.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

>> From: linux-hyperv-owner@vger.kernel.org
>> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Andy Lutomirski
>> Sent: Tuesday, April 7, 2020 2:01 PM
>> To: Christoph Hellwig <hch@lst.de>
>> Cc: vkuznets <vkuznets@redhat.com>; x86@kernel.org;
>> linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; KY Srinivasan
>> <kys@microsoft.com>; Stephen Hemminger <stephen@networkplumber.org>;
>> Andy Lutomirski <luto@kernel.org>; Peter Zijlstra <peterz@infradead.org>
>> Subject: Re: hv_hypercall_pg page permissios
>> 
>> 
>> > On Apr 7, 2020, at 12:38 AM, Christoph Hellwig <hch@lst.de> wrote:
>> >
>> > ﻿On Tue, Apr 07, 2020 at 09:28:01AM +0200, Vitaly Kuznetsov wrote:
>> >> Christoph Hellwig <hch@lst.de> writes:
>> >>
>> >>> Hi all,
>> >>>
>> >>> The x86 Hyper-V hypercall page (hv_hypercall_pg) is the only allocation
>> >>> in the kernel using __vmalloc with exectutable persmissions, and the
>> >>> only user of PAGE_KERNEL_RX.  Is there any good reason it needs to
>> >>> be readable?  Otherwise we could use vmalloc_exec and kill off
>> >>> PAGE_KERNEL_RX.  Note that before 372b1e91343e6 ("drivers: hv: Turn
>> off
>> >>> write permission on the hypercall page") it was even mapped writable..
>> >>
>> >> [There is nothing secret in the hypercall page, by reading it you can
>> >> figure out if you're running on Intel or AMD (VMCALL/VMMCALL) but it's
>> >> likely not the only possible way :-)]
>> >>
>> >> I see no reason for hv_hypercall_pg to remain readable. I just
>> >> smoke-tested
>> >
>> > Thanks, I have the same in my WIP tree, but just wanted to confirm this
>> > makes sense.
>> 
>> Just to make sure we’re all on the same page: x86 doesn’t normally have an
>> execute-only mode. Executable memory in the kernel is readable unless you
>> are using fancy hypervisor-based XO support.
>
> Hi hch,
> The patch is merged into the mainine recently, but unluckily we noticed
> a warning with CONFIG_DEBUG_WX=y (it looks typically this config is defined
> by default in Linux distros, at least in Ubuntu 18.04's  
> /boot/config-4.18.0-11-generic).
>
> Should we revert this patch, or figure out a way to ask the DEBUG_WX code to
> ignore this page?
>

Are you sure it is hv_hypercall_pg? AFAIU it shouldn't be W+X as we
are allocating it with vmalloc_exec(). In other words, if you revert
78bb17f76edc, does the issue go away?

> [   19.387536] debug: unmapping init [mem 0xffffffff82713000-0xffffffff82886fff]
> [   19.431766] Write protecting the kernel read-only data: 18432k
> [   19.438662] debug: unmapping init [mem 0xffffffff81c02000-0xffffffff81dfffff]
> [   19.446830] debug: unmapping init [mem 0xffffffff821d6000-0xffffffff821fffff]
> [   19.522368] ------------[ cut here ]------------
> [   19.527495] x86/mm: Found insecure W+X mapping at address 0xffffc90000012000
> [   19.535066] WARNING: CPU: 26 PID: 1 at arch/x86/mm/dump_pagetables.c:248 note_page+0x639/0x690
> [   19.539038] Modules linked in:
> [   19.539038] CPU: 26 PID: 1 Comm: swapper/0 Not tainted 5.7.0+ #1
> [   19.539038] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
> [   19.539038] RIP: 0010:note_page+0x639/0x690
> [   19.539038] Code: fe ff ff 31 c0 e9 a0 fe ff ff 80 3d 39 d1 31 01 00 0f 85 76 fa ff ff 48 c7 c7 98 55 0a 82 c6 05 25 d1 31 01 01 e8 f7 c9 00 00 <0f> 0b e9 5c fa ff ff 48 83 c0 18 48 c7 45 68 00 00 00 00 48 89 45
> [   19.539038] RSP: 0000:ffffc90003137cb0 EFLAGS: 00010282
> [   19.539038] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000007
> [   19.539038] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff810fa9c4
> [   19.539038] RBP: ffffc90003137ea0 R08: 0000000000000000 R09: 0000000000000000
> [   19.539038] R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90000013000
> [   19.539038] R13: 0000000000000000 R14: ffffc900001ff000 R15: 0000000000000000
> [   19.539038] FS:  0000000000000000(0000) GS:ffff8884dad00000(0000) knlGS:0000000000000000
> [   19.539038] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   19.539038] CR2: 0000000000000000 CR3: 0000000002210001 CR4: 00000000003606e0
> [   19.539038] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   19.539038] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   19.539038] Call Trace:
> [   19.539038]  ptdump_pte_entry+0x39/0x40
> [   19.539038]  __walk_page_range+0x5b7/0x960
> [   19.539038]  walk_page_range_novma+0x7e/0xd0
> [   19.539038]  ptdump_walk_pgd+0x53/0x90
> [   19.539038]  ptdump_walk_pgd_level_core+0xdf/0x110
> [   19.539038]  ? ptdump_walk_pgd_level_debugfs+0x40/0x40
> [   19.539038]  ? hugetlb_get_unmapped_area+0x2f0/0x2f0
> [   19.703692]  ? rest_init+0x24d/0x24d
> [   19.703692]  ? rest_init+0x24d/0x24d
> [   19.703692]  kernel_init+0x2c/0x113
> [   19.703692]  ret_from_fork+0x24/0x30
> [   19.703692] irq event stamp: 2840666
> [   19.703692] hardirqs last  enabled at (2840665): [<ffffffff810fa9c4>] console_unlock+0x444/0x5b0
> [   19.703692] hardirqs last disabled at (2840666): [<ffffffff81001ec9>] trace_hardirqs_off_thunk+0x1a/0x1c
> [   19.703692] softirqs last  enabled at (2840662): [<ffffffff81c00366>] __do_softirq+0x366/0x490
> [   19.703692] softirqs last disabled at (2840655): [<ffffffff8107dba8>] irq_exit+0xe8/0x100
> [   19.703692] ---[ end trace 99ca90806a8e657c ]---
> [   19.786235] x86/mm: Checked W+X mappings: FAILED, 1 W+X pages found.
> [   19.793298] rodata_test: all tests were successful
> [   19.798508] x86/mm: Checking user space page tables
> [   19.818007] x86/mm: Checked W+X mappings: passed, no W+X pages found.
>
> Thanks,
> -- Dexuan

-- 
Vitaly

