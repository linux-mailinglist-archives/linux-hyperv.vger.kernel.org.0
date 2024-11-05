Return-Path: <linux-hyperv+bounces-3263-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C119BD328
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 18:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A1E283C56
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E11E2614;
	Tue,  5 Nov 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FIWs9HDk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFB41E25FA;
	Tue,  5 Nov 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730826909; cv=none; b=MadI6hHWKGDr0JpRo0q4er1oVDmaBE/pw+dElje4TpGD1ooNe+49IitxHCVr8pWU0jJ2qKYJhGCmZONNIxSEddF4F6Kwyq1r2yh2GIRnoXKxS2WitHNAr2E7nUXgm1zU3x3TYMB0ryPQh9sq2FlGiCxMxsFzQSjhuhD6xteiUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730826909; c=relaxed/simple;
	bh=C/3XFnhzlodPMsHJyb2B5/0qhkCLP3WSPSP/dqJgABA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUXGOaiNv6tMWkvOAx9S1jHTZghgL9wOcks8OrqKKcBh+5c+dlooNnGWNKhpQify949lOlgN2tkdDVtfx6Sg80vGAP5P+JbekhS4uuplG9uZF5c9XJ4XboyeheX4DP9rPt759O/YoGf3r1B2TFFfy3MhFgqN3LBruXLtZDeJ3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FIWs9HDk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 0AA1E2127C73; Tue,  5 Nov 2024 09:15:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0AA1E2127C73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730826907;
	bh=of7Q46g/PHjFP6E80ZwzFuqHkajopC7TLEKF6xIeWQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIWs9HDkNf7P+Sf7GqGKXV8l5gQc6nDKlKb+SmCobcevQJlp7vydUABDVIh/jDwpu
	 Xm8vktoLEGkZwrdYAQmLQKAGWyeXvuj2WQwOOwkYLoiPnppnbWuzGQph9M+9YcSJZY
	 eyYUeC7x/9JG39K8TUjcUbJT9BdBM2bKSlnLG+S0=
Date: Tue, 5 Nov 2024 09:15:07 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "bentiss@kernel.org" <bentiss@kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: Hyper-V HID driver failure in linux-next-20241101
Message-ID: <20241105171507.GA15461@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <SN6PR02MB41573CDE3E478455D17837DED4502@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41573CDE3E478455D17837DED4502@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Nov 03, 2024 at 05:17:19AM +0000, Michael Kelley wrote:
> I was running the linux-next-20241101 kernel in a Hyper-V guest VM today,
> and the Hyper-V guest HID (mouse) driver is failing to probe during boot.
> I bisected the problem to commit 8b7fd6a15f8c:
> 
>     HID: bpf: move HID-BPF report descriptor fixup earlier
> 
> Without that commit, the good case probing output looks like this:
> 
> [    0.306586] hid: raw HID events driver (C) Jiri Kosina
> [    0.357690] hv_vmbus: registering driver hid_hyperv
> [    0.372669] input: Microsoft Vmbus HID-compliant Mouse as /devices/0006:045E:0621.0001/input/input1
> [    0.373202] hid-generic 0006:045E:0621.0001: input: VIRTUAL HID v0.01 Mouse [Microsoft Vmbus HID-compliant Mouse] on
> 
> With that commit, the relevant probing output is this:
> 
> [    0.294685] hid: raw HID events driver (C) Jiri Kosina
> [    0.295977] hv_vmbus: registering driver hid_hyperv
> [    0.296957] ------------[ cut here ]------------
> [    0.297086] WARNING: CPU: 0 PID: 11 at drivers/hid/hid-core.c:1234 hid_open_report+0x268/0x2f0 [hid]
> [    0.297232] Modules linked in: hid_hyperv(E) hv_storvsc(E) hv_netvsc(E+) hid(E) scsi_transport_fc(E) hv_utils(E) hyperv_keyboard(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) sha512_ssse3(E) sha256_ssse3(E) sha1_ssse3(E) hv_vmbus(E) aesni_intel(E) crypto_simd(E) cryptd(E)
> [    0.297694] CPU: 0 UID: 0 PID: 11 Comm: kworker/u32:0 Tainted: G            E      6.12.0-rc1+ #11
> [    0.297835] Tainted: [E]=UNSIGNED_MODULE
> [    0.297997] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/04/2024
> [    0.298160] Workqueue: async async_run_entry_fn
> [    0.298323] RIP: 0010:hid_open_report+0x268/0x2f0 [hid]
> [    0.298509] Code: 35 49 8d bd d0 18 00 00 48 c7 c6 80 8c 72 c0 e8 fe a7 d4 f7 b8 ea ff ff ff e9 37 ff ff ff 0f 0b b8 f0 ff ff ff e9 53 ff ff ff <0f> 0b b8 ed ff ff ff e9 47 ff ff ff 4c 89 ef 89 45 b4 e8 c1 d7 ff
> [    0.298953] RSP: 0018:ffffafd980093cc8 EFLAGS: 00010246
> [    0.299139] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffb8446780
> [    0.299325] RDX: 0000000000000000 RSI: 000000000000011b RDI: 0000000000000000
> [    0.299516] RBP: ffffafd980093d18 R08: 0000000000000000 R09: 0000000000000001
> [    0.299698] R10: 0000000000000092 R11: ffff958e815733f8 R12: ffff958e988f0000
> [    0.299861] R13: ffff958e8905c000 R14: ffff958e8905c000 R15: ffff958e803a06c0
> [    0.300045] FS:  0000000000000000(0000) GS:ffff958f87a00000(0000) knlGS:0000000000000000
> [    0.300230] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.300424] CR2: 000056324c394f10 CR3: 00000001172d0000 CR4: 0000000000350ef0
> [    0.301087] Call Trace:
> [    0.301280]  <TASK>
> [    0.301470]  ? show_regs+0x6b/0x80
> [    0.301662]  ? __warn+0x97/0x160
> [    0.301848]  ? hid_open_report+0x268/0x2f0 [hid]
> [    0.302044]  ? report_bug+0x1bb/0x1d0
> [    0.302228]  ? handle_bug+0x60/0xa0
> [    0.302879]  ? exc_invalid_op+0x1d/0x80
> [    0.303053]  ? asm_exc_invalid_op+0x1f/0x30
> [    0.303230]  ? __pfx___device_attach_driver+0x10/0x10
> [    0.303410]  ? hid_open_report+0x268/0x2f0 [hid]
> [    0.303592]  ? hid_add_device+0x10c/0x2b0 [hid]
> [    0.303780]  mousevsc_probe+0x1b4/0x230 [hid_hyperv]
> [    0.303963]  vmbus_probe+0x3f/0xa0 [hv_vmbus]
> [    0.304148]  really_probe+0xea/0x380
> [    0.304327]  __driver_probe_device+0x7e/0x160
> [    0.304507]  driver_probe_device+0x23/0xa0
> [    0.304685]  __driver_attach_async_helper+0x40/0xa0
> [    0.304866]  async_run_entry_fn+0x34/0x120
> [    0.305043]  process_scheduled_works+0xa3/0x440
> [    0.305351]  worker_thread+0x133/0x270
> [    0.305541]  ? __pfx_worker_thread+0x10/0x10
> [    0.305734]  kthread+0xf6/0x130
> [    0.305920]  ? __pfx_kthread+0x10/0x10
> [    0.306090]  ret_from_fork+0x3d/0x60
> [    0.306245]  ? __pfx_kthread+0x10/0x10
> [    0.306365]  ret_from_fork_asm+0x1a/0x30
> [    0.306652]  </TASK>
> [    0.306799] ---[ end trace 0000000000000000 ]---
> [    0.306953] hid-generic 0006:045E:0621.0001: parse failed
> [    0.307190] ------------[ cut here ]------------
> [    0.307334] WARNING: CPU: 1 PID: 11 at drivers/base/devres.c:691 devres_release_group+0x107/0x120
> [    0.307491] Modules linked in: hid_generic(E) hid_hyperv(E) hv_storvsc(E) hv_netvsc(E+) hid(E) scsi_transport_fc(E) hv_utils(E) hyperv_keyboard(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) sha512_ssse3(E) sha256_ssse3(E) sha1_ssse3(E) hv_vmbus(E) aesni_intel(E) crypto_simd(E) cryptd(E)
> [    0.307945] CPU: 1 UID: 0 PID: 11 Comm: kworker/u32:0 Tainted: G        W   E      6.12.0-rc1+ #11
> [    0.308101] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
> [    0.308259] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/04/2024
> [    0.308419] Workqueue: async async_run_entry_fn
> [    0.308579] RIP: 0010:devres_release_group+0x107/0x120
> [    0.308736] Code: f8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 48 8b 57 28 48 8d 47 28 48 39 c2 74 8f 48 8b 7f 08 48 39 f7 0f 85 6d ff ff ff <0f> 0b 4c 89 c6 4c 89 f7 45 31 ff e8 e9 4a 50 00 eb af e8 f2 5b 4f
> [    0.309069] RSP: 0018:ffffafd980093ba0 EFLAGS: 00010046
> [    0.309237] RAX: 0000000000000246 RBX: 0000000000000000 RCX: 0000000000000000
> [    0.309407] RDX: 0000000000000001 RSI: ffff958e8905db70 RDI: ffff958e8905db70
> [    0.309592] RBP: ffffafd980093be8 R08: 0000000000000246 R09: ffff958e81fc7d98
> [    0.309765] R10: ffffafd980093b60 R11: ffff958e8023f718 R12: ffff958e8905d8d0
> [    0.309940] R13: ffffafd980093ba8 R14: ffff958e8905db6c R15: ffff958e8905d8d0
> [    0.310114] FS:  0000000000000000(0000) GS:ffff958f87a80000(0000) knlGS:0000000000000000
> [    0.310293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.310475] CR2: 000056324c398260 CR3: 00000001172d0000 CR4: 0000000000350ef0
> [    0.310657] Call Trace:
> [    0.310833]  <TASK>
> [    0.310834]  ? show_regs+0x6b/0x80
> [    0.311150]  ? __warn+0x97/0x160
> [    0.311481]  ? devres_release_group+0x107/0x120
> [    0.312169]  ? report_bug+0x1bb/0x1d0
> [    0.313692]  ? handle_bug+0x60/0xa0
> [    0.313894]  ? exc_invalid_op+0x1d/0x80
> [    0.314132]  ? asm_exc_invalid_op+0x1f/0x30
> [    0.314336]  ? devres_release_group+0x107/0x120
> [    0.314541]  hid_device_remove+0x5b/0xb0 [hid]
> [    0.314746]  device_remove+0x43/0x70
> [    0.314947]  device_release_driver_internal+0xbd/0x140
> [    0.315154]  device_release_driver+0x16/0x20
> [    0.315353]  bus_remove_device+0xcf/0x130
> [    0.315552]  device_del+0x16a/0x3c0
> [    0.315750]  hid_destroy_device+0x69/0x80 [hid]
> [    0.315948]  mousevsc_probe+0x19b/0x230 [hid_hyperv]
> [    0.316146]  vmbus_probe+0x3f/0xa0 [hv_vmbus]
> [    0.316338]  really_probe+0xea/0x380
> [    0.316519]  __driver_probe_device+0x7e/0x160
> [    0.316698]  driver_probe_device+0x23/0xa0
> [    0.316874]  __driver_attach_async_helper+0x40/0xa0
> [    0.317052]  async_run_entry_fn+0x34/0x120
> [    0.317221]  process_scheduled_works+0xa3/0x440
> [    0.317389]  worker_thread+0x133/0x270
> [    0.317552]  ? __pfx_worker_thread+0x10/0x10
> [    0.317707]  kthread+0xf6/0x130
> [    0.317859]  ? __pfx_kthread+0x10/0x10
> [    0.318019]  ret_from_fork+0x3d/0x60
> [    0.318169]  ? __pfx_kthread+0x10/0x10
> [    0.318317]  ret_from_fork_asm+0x1a/0x30
> [    0.318464]  </TASK>
> [    0.318610] ---[ end trace 0000000000000000 ]---
> [    0.318884] hv_vmbus: probe failed for device 58f75a6d-d949-4320-99e1-a2a2576d581c (-19)
> 
> I'll do some additional debugging to try to narrow down what's going
> wrong. I'm experienced with Linux guests on Hyper-V, but don't have
> any existing knowledge of the hid-hyperv.c driver or how it interacts with
> the hid-core.c code.  Nonetheless, I should be able to peel the onion a
> bit more.
> 
> Benjamin -- if you have thoughts on what to look for, I would appreciate
> any pointers that could save me some time. It's certainly possible that
> there's a latent bug in how the Hyper-V HID driver interacts with the
> HID core, so I'll look at both sides of the interaction.
> 
> Thanks,
> 
> Michael Kelley

Vitaly patch seems to fix this issue:
https://lore.kernel.org/linux-hyperv/20241105171141.GA13863@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/

- Saurabh

