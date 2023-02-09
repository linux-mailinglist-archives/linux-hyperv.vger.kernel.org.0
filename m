Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA7E69041A
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Feb 2023 10:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBIJsx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Feb 2023 04:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBIJsx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Feb 2023 04:48:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E0B241D8
        for <linux-hyperv@vger.kernel.org>; Thu,  9 Feb 2023 01:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675936086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M/aR+B7oolKvJ6j1W4OUTMhGXXCQnfWS4jHDUmtjyXw=;
        b=X/0paZBQghRbUTYVTGCQ6FaGmDMkAwj+aQKIwrpugrrPSOuy2uJ84C8mfrshakJkKwEtay
        KoxpNOtF2wCa8QhVffKMGEPaVWRLWv90uXNZ4Rm8Qns5Fc2wdDNC13dz2v7ixnYlzEZ8Gc
        NHNZZ2Eiouk92YZWBK+nzBqUf/BECMM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-179-MImGAMRiPgS7hpSTS9psWg-1; Thu, 09 Feb 2023 04:48:05 -0500
X-MC-Unique: MImGAMRiPgS7hpSTS9psWg-1
Received: by mail-ot1-f70.google.com with SMTP id w9-20020a9d5a89000000b0068bc6c8621eso642080oth.9
        for <linux-hyperv@vger.kernel.org>; Thu, 09 Feb 2023 01:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/aR+B7oolKvJ6j1W4OUTMhGXXCQnfWS4jHDUmtjyXw=;
        b=bP6zAWVKuIEoTLcVWwVpxMzqWIC7FRIY1CSbUHAzwHfQ0FGrhgQGAlsLFeIynhZRNL
         1q1asDThuZqacVyc1GagapBAppcYyigZNGrVyKc4TGlP9+p3WhZ16jgzfGt2IKgjxkKs
         gG4sSMC+2RhPn9IssKEk8ubdYkDlQJ2VD7tduJtWOSxKG2sjEAdJ9zNsoc1sJnwiltTO
         5PoF8OY7oMXO1+BMDjSAU8O/QwE4SZxwdQD1bgAmxSELqW/CalQRGBxpTGYG29OgkFZN
         uTGg3Ans/X2IrS2Xv8dSijNqHqgRgqhFtkEd4Am4T0psrHLSdH+9s6xtDd6ejWJNISQ/
         bDXg==
X-Gm-Message-State: AO0yUKVme36UWUgG7WzWYtIaHOEQud/07v2QEhLkvTYGbqxkdrK5JtQB
        gjjKkYL95Sq33gPitzM+wsHIedWvnfoj9sJZr4Lf5hEvB7m0p3ZIgrTN4t2H2f/CZD15EVR5uHl
        g3I2QznUGQrklTUGxk18/LbobH72VYiw2JFMSjR0D
X-Received: by 2002:a05:6808:2193:b0:364:5ff7:4e9f with SMTP id be19-20020a056808219300b003645ff74e9fmr546285oib.160.1675936084046;
        Thu, 09 Feb 2023 01:48:04 -0800 (PST)
X-Google-Smtp-Source: AK7set/NIGUjXEVX5ul6c7TTaeDxPC8/LZ4NHPhjLdDQs6Me664eATOE3viFfC6osIez0Ue4ZWvzxYEZgSoDpG7jisw=
X-Received: by 2002:a05:6808:2193:b0:364:5ff7:4e9f with SMTP id
 be19-20020a056808219300b003645ff74e9fmr546281oib.160.1675936083657; Thu, 09
 Feb 2023 01:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20230208113424.864881-1-mgamal@redhat.com> <SA1PR21MB1335F1074908B3E00DFA21BDBFD89@SA1PR21MB1335.namprd21.prod.outlook.com>
 <CAG-HVq8GYwCYBgiBnjO8ca5M27j6-MPK3e9H_c+EPmyotmOHxw@mail.gmail.com>
In-Reply-To: <CAG-HVq8GYwCYBgiBnjO8ca5M27j6-MPK3e9H_c+EPmyotmOHxw@mail.gmail.com>
From:   Mohammed Gamal <mgamal@redhat.com>
Date:   Thu, 9 Feb 2023 11:47:52 +0200
Message-ID: <CAG-HVq9KWPRhy3X1E8vs_0y7xeJFBA-hZ5u6Vxh7H9Tu=gV9WA@mail.gmail.com>
Subject: Re: [PATCH] Drivers: vmbus: Check for channel allocation before
 looking up relids
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 9, 2023 at 11:25 AM Mohammed Gamal <mgamal@redhat.com> wrote:
>
>
> On Wed, Feb 8, 2023 at 9:03 PM Dexuan Cui <decui@microsoft.com> wrote:
> >
> > > From: Mohammed Gamal <mgamal@redhat.com>
> > > Sent: Wednesday, February 8, 2023 3:34 AM
> > >
> > > relid2channel() assumes vmbus channel array to be allocated when called.
> > > However, if the guest receives a vmbus interrupt during driver initialization
> > > before vmbus_connect() is called or if vmbus_connect() fails, the vmbus
> > > interrupt service routine is called which in turn calls relid2channel()
> > > and can cause a null pointer dereference.
> >
> > Before vmbus_connect() is called or if vmbus_connect() fails, there should
> > be no VMBus channel related interrupts at all, so relid2channel() can't be
> > called.
> >
> > Can you please share the log or at least the crash call-stack?
> > I'm curious how the crash can happen.
> >
>
> Hi Dexuan,
> We saw this when triggering a crash with kdump enabled with
> echo 'c' > /proc/sysrq-trigger
>
> When the new kernel boots, we see this stack trace:
>
> [   21.790653] BUG: kernel NULL pointer dereference, address: 0000000000000070
> [   21.816550] #PF: supervisor read access in kernel mode
> [   21.835697] #PF: error_code(0x0000) - not-present page
> [   21.855499] PGD 0 P4D 0
> [   21.865471] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   21.881150] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.14.0-247.el9.x86_64 #       1
> [   21.906679] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090007  05/18/2018
> [   21.939413] RIP: 0010:relid2channel+0x1a/0x30 [hv_vmbus]
> [   21.958240] Code: 00 00 00 e8 a8 01 db c0 e9 78 ff ff ff 0f 1f 00 0f 1f 44 00        00 81 ff ff 07 00 00 77 15 48 8b 05 ac 31 01 00 89 ff 48 8d 04 f8 <48> 8b 00 e9        de ef b2 c1 0f 0b 31 c0 e9 d5 ef b2 c1 0f 1f 44 00 00
> [   22.022266] RSP: 0018:ffffc90000003f90 EFLAGS: 00010097
> [   22.040588] RAX: 0000000000000070 RBX: ffff88807a4ef200 RCX: 0000000000000000
> [   22.065670] RDX: ffffffff82a1a940 RSI: 0000000000000000 RDI: 000000000000000e
> [   22.090778] RBP: 000000000000000e R08: 0000000000000000 R09: 0000000000000000
> [   22.115947] R10: 000000000000000e R11: ffffc90000003ff8 R12: 0000000000000001
> [   22.140901] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   22.165344] FS:  0000000000000000(0000) GS:ffff88807e600000(0000) knlGS:00000       00000000000
> [   22.192958] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.213376] CR2: 0000000000000070 CR3: 000000007ae40000 CR4: 00000000003506b0
> [   22.238792] Call Trace:
> [   22.248268]  <IRQ>
> [   22.256236]  vmbus_chan_sched.isra.0+0x67/0x190 [hv_vmbus]
> [   22.275822]  vmbus_isr+0x21/0xd0 [hv_vmbus]
> [   22.290906]  __sysvec_hyperv_callback+0x2e/0x60
> [   22.307021]  sysvec_hyperv_callback+0x6d/0x90
> [   22.322530]  </IRQ>
> [   22.330559]  <TASK>
> [   22.338573]  asm_sysvec_hyperv_callback+0x16/0x20
> [   22.355090] RIP: 0010:default_idle+0x10/0x20
> [   22.370572] Code: 00 0f ae f0 0f ae 38 0f ae f0 eb b5 66 66 2e 0f 1f 84 00 00        00 00 00 0f 1f 00 0f 1f 44 00 00 eb 07 0f 00 2d 7e 6e 4d 00 fb f4 <e9> 4b dc 2c        00 cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 65
> [   22.435289] RSP: 0018:ffffffff82a03ea8 EFLAGS: 00000202
> [   22.453695] RAX: ffffffff81b33ea0 RBX: ffffffff82a1a940 RCX: 0000000000000000
> [   22.478759] RDX: 00000000000000cd RSI: 0000000000000087 RDI: 00000000000000ce
> [   22.503863] RBP: 0000000000000000 R08: 0138a8c77d17acc3 R09: 0000000000000001
> [   22.528774] R10: 0000000000000400 R11: 00000000005d0eea R12: 0000000000000000
> [   22.553857] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   22.578981]  ? mwait_idle+0x80/0x80
> [   22.591660]  ? mwait_idle+0x80/0x80
> [   22.604332]  default_idle_call+0x33/0xe0
> [   22.618343]  cpuidle_idle_call+0x15d/0x1c0
> [   22.632969]  ? read_hv_sched_clock_tsc+0x5/0x20
> [   22.649218]  do_idle+0x7b/0xe0
> [   22.660741]  cpu_startup_entry+0x19/0x20
> [   22.674964]  rest_init+0xca/0xd0
> [   22.686907]  arch_call_rest_init+0xa/0x14
> [   22.701272]  start_kernel+0x49e/0x4c0
> [   22.714418]  secondary_startup_64_no_verify+0xe5/0xeb
> [   22.732484]  </TASK>
> [   22.740973] Modules linked in: hv_vmbus(+) serio_raw dm_mirror dm_region_hash        dm_log dm_mod fuse overlay squashfs loop
> [   22.779694] CR2: 0000000000000070
> [   22.792006] ---[ end trace 56dd24038e89124f ]---
> [   22.808686] RIP: 0010:relid2channel+0x1a/0x30 [hv_vmbus]
> [   22.827388] Code: 00 00 00 e8 a8 01 db c0 e9 78 ff ff ff 0f 1f 00 0f 1f 44 00        00 81 ff ff 07 00 00 77 15 48 8b 05 ac 31 01 00 89 ff 48 8d 04 f8 <48> 8b 00 e9        de ef b2 c1 0f 0b 31 c0 e9 d5 ef b2 c1 0f 1f 44 00 00
> [   22.891669] RSP: 0018:ffffc90000003f90 EFLAGS: 00010097
> [   22.910168] RAX: 0000000000000070 RBX: ffff88807a4ef200 RCX: 0000000000000000
> [   22.935445] RDX: ffffffff82a1a940 RSI: 0000000000000000 RDI: 000000000000000e
> [   22.958556] RBP: 000000000000000e R08: 0000000000000000 R09: 0000000000000000
> [   22.979539] R10: 000000000000000e R11: ffffc90000003ff8 R12: 0000000000000001
> [   23.004127] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   23.027088] FS:  0000000000000000(0000) GS:ffff88807e600000(0000) knlGS:00000       00000000000
> [   23.053341] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   23.074013] CR2: 0000000000000070 CR3: 000000007ae40000 CR4: 00000000003506b0
> [   23.099322] Kernel panic - not syncing: Fatal exception in interrupt
> [   23.121729] Kernel Offset: disabled

Ugh, my mail client messed up the reply and it was marked as spam.
Resending to the lists in plain text. See the reply above.

