Return-Path: <linux-hyperv+bounces-8851-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBuOBDqZj2lQRwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8851-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 22:35:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4464D139A1A
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 22:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03CEB3008205
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 21:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E808239567;
	Fri, 13 Feb 2026 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="afq5tNjm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884EF2BE053;
	Fri, 13 Feb 2026 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771018549; cv=pass; b=aX2OLJZLulXDvyu3wRJk2ErexopAt6dEc0br9JzrH/l8yMLXW4zJ8i/sbaUyo6TCSSx+cLwsUnnNaYz1ltZ4p+bexd8E3YKkd46uuqj5jHhKKFCN1bXRvov/5qAlovAHs1t2w66fE1jMuO9KV7173XmtNn2ARJfVuCYwMLrP1jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771018549; c=relaxed/simple;
	bh=Lt57keMJ7yvJapWXt0IU9ikYNZiRrjakTCiZW2hQ2M0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=XZPbsgCaLKFkXmfW8HfgLcT5mU4h5kWbKYSZYx9MzXkZPemjNFohQTPFEZWfnBjUVniilGI8nu7efxq6GsgboQHuOz02XKJ38UvlQasBWYru/AoOqLaabKd4kc8pa4BApfUyFAlAy9+LH2VRg+ZVk14FPYfPlMPUtqHxXvsAWHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=afq5tNjm; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1771018518; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AJWDu/YuykHreyrwWrlP2R8nN9/p25yscUXURVOhM7ZCNvIK7czAFlBQcMkO2TC4T+zSMppOH/rFEEKyLnG+yGiwICjqf4dGpoV8Xv4BTD1uwSRu7l/LyqRazaQ2t3aJxmKE4pI+FtfuYLzGXel5wNm2pyOe276lZbNMEtqxYmU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771018518; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EIiuv5Vs6AT+Dq39tOE4IQUeKRThrTBN+95ysY4yQdc=; 
	b=ib3cv7Ski7GpR7RYb3p7liWbGCbC/dncWBhQi9GrpssKe0gUpeV63y9IhZcJfXWNvViSS0HkAEvvN9VjJIiTw+UWDINF5fASRZM40gRA1OtS5roHgp934dAiiTbDMqUF8PSaPoeoIp2P7kXyuFF7etVHxXnPbIVd27/TEiuRVA0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771018518;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:References:In-Reply-To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=EIiuv5Vs6AT+Dq39tOE4IQUeKRThrTBN+95ysY4yQdc=;
	b=afq5tNjmomYokxt7acLuFyMqXpqkIesWejXfOKLZStxoivkNPcwEfUqu2I2VqYdw
	gEETbSPY/dAz6C4rw/s/NFw3LHJ2pnJ7X9W+SckBB2/VTtQ3fVB4gGvQQ2o5Y3xd7QF
	uY8eqIotkpJ/1W6DVy6kWPMTklmgqHdwiRj7yhg0=
Received: by mx.zohomail.com with SMTPS id 1771018515429105.66604224848857;
	Fri, 13 Feb 2026 13:35:15 -0800 (PST)
From: <mhklkml@zohomail.com>
To: "'Jan Kiszka'" <jan.kiszka@siemens.com>,
	"'Michael Kelley'" <mhklinux@outlook.com>,
	"'Florian Bezdeka'" <florian.bezdeka@siemens.com>,
	"'K. Y. Srinivasan'" <kys@microsoft.com>,
	"'Haiyang Zhang'" <haiyangz@microsoft.com>,
	"'Wei Liu'" <wei.liu@kernel.org>,
	"'Dexuan Cui'" <decui@microsoft.com>,
	"'Long Li'" <longli@microsoft.com>,
	"'Thomas Gleixner'" <tglx@kernel.org>,
	"'Ingo Molnar'" <mingo@redhat.com>,
	"'Borislav Petkov'" <bp@alien8.de>,
	"'Dave Hansen'" <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
Cc: <linux-hyperv@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"'RT'" <linux-rt-users@vger.kernel.org>,
	"'Mitchell Levy'" <levymitchell0@gmail.com>,
	<skinsburskii@linux.microsoft.com>,
	<mrathor@linux.microsoft.com>,
	<anirudh@anirudhrb.com>,
	<schakrabarti@linux.microsoft.com>,
	<ssengar@linux.microsoft.com>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com> <SN6PR02MB4157B6A9C8BEFA312F0D9D68D499A@SN6PR02MB4157.namprd02.prod.outlook.com> <eb5debe8-b7d6-4076-b295-9a02271c2ee6@siemens.com> <SN6PR02MB41579F60E39CA2A3CA8A5A75D467A@SN6PR02MB4157.namprd02.prod.outlook.com> <1b569fcf3d096066aeb011e21f9c1fe21f7df9b5.camel@siemens.com> <SN6PR02MB4157DB59F0F7BFBF56612651D465A@SN6PR02MB4157.namprd02.prod.outlook.com> <b084a7b6-c394-4337-82cd-8b9cb911d8d5@siemens.com>
In-Reply-To: <b084a7b6-c394-4337-82cd-8b9cb911d8d5@siemens.com>
Subject: RE: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on PREEMPT_RT
Date: Fri, 13 Feb 2026 13:35:13 -0800
Message-ID: <005a01dc9d30$a40515e0$ec0f41a0$@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQGjz8e7FSkZkPzCI+SJTzDt4GGRfQGFaGNyAbwf3DgCSz0BDwIefgOPAVbHNUYBfC8vdbWezWMw
Feedback-ID: rr08011227c8422459c5456fd662c50a130000603e8ee2ad8beb3df2d85373b8214f8f721ecfe4b1de18eebc:zu08011227e9c92db4b39f1eb33dd3c4c80000562ef8975bf96f939c82c5d0897dfe665e6d5022752518cd02:rf08011226fb8190d91f3c13764ed6872b0000137a02f389e78dd873da04aca134e8816d40cadbf8852308:ZohoMail
X-ZohoMailClient: External
X-ZohoMail-Owner: <005a01dc9d30$a40515e0$ec0f41a0$@zohomail.com>+zmo_0_mhklkml@zohomail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[siemens.com,outlook.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-8851-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[zohomail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.microsoft.com,anirudhrb.com];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:email]
X-Rspamd-Queue-Id: 4464D139A1A
X-Rspamd-Action: no action

From: Jan Kiszka <jan.kiszka@siemens.com> Sent: Thursday, February 12, =
2026 8:06 AM
>=20
> On 09.02.26 19:25, Michael Kelley wrote:
> > From: Florian Bezdeka <florian.bezdeka@siemens.com> Sent: Monday, =
February 9, 2026 2:35 AM
> >>
> >> On Sat, 2026-02-07 at 01:30 +0000, Michael Kelley wrote:
> >>
> >> [snip]
> >>>
> >>> I've run your suggested experiment on an arm64 VM in the Azure =
cloud. My
> >>> kernel was linux-next 20260128. I set CONFIG_PREEMPT_RT=3Dy and
> >>> CONFIG_PROVE_LOCKING=3Dy, but did not add either of your two =
patches
> >>> (neither the storvsc driver patch nor the x86 VMBus interrupt =
handling patch).
> >>> The VM comes up and runs, but with this warning during boot:
> >>>
> >>> [    3.075604] hv_utils: Registering HyperV Utility Driver
> >>> [    3.075636] hv_vmbus: registering driver hv_utils
> >>> [    3.085920] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >>> [    3.088128] hv_vmbus: registering driver hv_netvsc
> >>> [    3.091180] [ BUG: Invalid wait context ]
> >>> [    3.093544] 6.19.0-rc7-next-20260128+ #3 Tainted: G            =
E
> >>> [    3.097582] -----------------------------
> >>> [    3.099899] systemd-udevd/284 is trying to lock:
> >>> [    3.102568] ffff000100e24490 =
(&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0x128/0x3b8 =
[hv_vmbus]
> >>> [    3.108208] other info that might help us debug this:
> >>> [    3.111454] context-{2:2}
> >>> [    3.112987] 1 lock held by systemd-udevd/284:
> >>> [    3.115626]  #0: ffffd5cfc20bcc80 (rcu_read_lock){....}-{1:3}, =
at: vmbus_chan_sched+0xcc/0x3b8 [hv_vmbus]
> >>> [    3.121224] stack backtrace:
> >>> [    3.122897] CPU: 0 UID: 0 PID: 284 Comm: systemd-udevd Tainted: =
G            E 6.19.0-rc7-next-20260128+ #3 PREEMPT_RT
> >>> [    3.129631] Tainted: [E]=3DUNSIGNED_MODULE
> >>> [    3.131946] Hardware name: Microsoft Corporation Virtual =
Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 06/10/2025
> >>> [    3.138553] Call trace:
> >>> [    3.140015]  show_stack+0x20/0x38 (C)
> >>> [    3.142137]  dump_stack_lvl+0x9c/0x158
> >>> [    3.144340]  dump_stack+0x18/0x28
> >>> [    3.146290]  __lock_acquire+0x488/0x1e20
> >>> [    3.148569]  lock_acquire+0x11c/0x388
> >>> [    3.150703]  rt_spin_lock+0x54/0x230
> >>> [    3.152785]  vmbus_chan_sched+0x128/0x3b8 [hv_vmbus]
> >>> [    3.155611]  vmbus_isr+0x34/0x80 [hv_vmbus]
> >>> [    3.158093]  vmbus_percpu_isr+0x18/0x30 [hv_vmbus]
> >>> [    3.160848]  handle_percpu_devid_irq+0xdc/0x348
> >>> [    3.163495]  handle_irq_desc+0x48/0x68
> >>> [    3.165851]  generic_handle_domain_irq+0x20/0x38
> >>> [    3.168664]  gic_handle_irq+0x1dc/0x430
> >>> [    3.170868]  call_on_irq_stack+0x30/0x70
> >>> [    3.173161]  do_interrupt_handler+0x88/0xa0
> >>> [    3.175724]  el1_interrupt+0x4c/0xb0
> >>> [    3.177855]  el1h_64_irq_handler+0x18/0x28
> >>> [    3.180332]  el1h_64_irq+0x84/0x88
> >>> [    3.182378]  _raw_spin_unlock_irqrestore+0x4c/0xb0 (P)
> >>> [    3.185493]  rt_mutex_slowunlock+0x404/0x440
> >>> [    3.187951]  rt_spin_unlock+0xb8/0x178
> >>> [    3.190394]  kmem_cache_alloc_noprof+0xf0/0x4f8
> >>> [    3.193100]  alloc_empty_file+0x64/0x148
> >>> [    3.195461]  path_openat+0x58/0xaa0
> >>> [    3.197658]  do_file_open+0xa0/0x140
> >>> [    3.199752]  do_sys_openat2+0x190/0x278
> >>> [    3.202124]  do_sys_open+0x60/0xb8
> >>> [    3.204047]  __arm64_sys_openat+0x2c/0x48
> >>> [    3.206433]  invoke_syscall+0x6c/0xf8
> >>> [    3.208519]  el0_svc_common.constprop.0+0x48/0xf0
> >>> [    3.211050]  do_el0_svc+0x24/0x38
> >>> [    3.212990]  el0_svc+0x164/0x3c8
> >>> [    3.214842]  el0t_64_sync_handler+0xd0/0xe8
> >>> [    3.217251]  el0t_64_sync+0x1b0/0x1b8
> >>> [    3.219450] hv_utils: Heartbeat IC version 3.0
> >>> [    3.219471] hv_utils: Shutdown IC version 3.2
> >>> [    3.219844] hv_utils: TimeSync IC version 4.0
> >>
> >> That matches with my expectation that the same problem exists on =
arm64.
> >> The patch from Jan addresses that issue for x86 (only, so far) as =
we do
> >> not have a working test environment for arm64 yet.
> >
> > OK. I had understood Jan's earlier comments to mean that the VMBus
> > interrupt problem was implicitly solved on arm64 because of VMBus =
using
> > a standard Linux IRQ on arm64. But evidently that's not the case. So =
my
> > earlier comment stands: The code changes should go into the =
architecture
> > independent portion of the VMBus driver, and not under arch/x86. I
> > can probably work with you to test on arm64 if need be.
> >
>=20
> I can move the code, sure, but I still haven't understood what
> invalidates my assumptions (beside what you observed). vmbus_drv calls
> request_percpu_irq, and that is - as far as I can see - not injecting
> IRQF_NO_THREAD. Any explanations welcome.

I haven't setup detailed debugging on arm64 yet, but in prep for that
I went looking at the places in the kernel IRQ handling where
IRQF_NO_THREAD influences behavior. The key function appears to be
irq_setup_forced_threading(). This function first checks =
force_irqthreads(),
which will be "true" when PREEMPT_RT is set. The function then checks
the IRQF_NO_THREAD flag and the IRQF_PERCPU flag. From what I can
see, the IRQF_PERCPU flag is treated like the IRQF_NO_THREAD flag, and
causes forced threading to *not* be done. So the behavior ends up being
the same as when PREEMPT_RT is not set.

Since the VMBus interrupt is a per-cpu interrupt, forced threading is =
not
done. In that case, the stack trace I reported makes sense. Take a look =
at
the code and see if you agree.

Michael

>=20
> Reproduction is still not possible for me. I was playing a bit with =
qemu
> in the hope to make it provide its minimal vmbus support (for
> ballooning), but that was not yet successful on arm64.
>=20


