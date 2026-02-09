Return-Path: <linux-hyperv+bounces-8770-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHkNHIG4iWnoBAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-8770-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Feb 2026 11:35:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C72C910E31B
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Feb 2026 11:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DDB5301C59C
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Feb 2026 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FB1366046;
	Mon,  9 Feb 2026 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="cKHuk6xQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E063367F4D
	for <linux-hyperv@vger.kernel.org>; Mon,  9 Feb 2026 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633320; cv=none; b=oSoxigwvGdWvv4MkOjbOcjzOmU3OTXbZ9kT94Bt8xt8D4skVUEEBSpIYKiEEWXIntQ2Ckq2gF4LKIQzsPp8cll2cH6biDglO2PjXa8aJAjyz4lYvaH5sV3zjP/Po6o3hs8r3UM0yHOToZbw1UEnwkKcE6dG3y6q5CPMU2G53puk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633320; c=relaxed/simple;
	bh=7hMHm0iRtxr04qDK/tz0DPUluRPXuol7JIrOSavW5h8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dfiYLZx3OiBUnM4tg4cN7LU33DVInzmo/hdZhd5teZ6xEkf43XDd2Xs+HGRik5bb4CPcs1/YlPX4symS/9Ry+fLZNCVRxwoj+89mqpFfD2V8EUSFTtdAUzatJIdHlebGL4OQd5f7bHWibxKuo/HJODJvCcR9O2UOPA5u7zxiwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=cKHuk6xQ; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260209103515d311369f6d000207d7
        for <linux-hyperv@vger.kernel.org>;
        Mon, 09 Feb 2026 11:35:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Sbmxn3u6Ho878rqkPnilMh7wbXv7sRc1stsqyjvumbk=;
 b=cKHuk6xQKgpHMc33oEHowDxp2hlVSfWGH8GRcW0bMfjC+Yz6ysEQTj6JFeXnKJnBCVIXxP
 gD2N6eIwfu2lF0/DZzLSlsiScgf2WrmvuVQYaT1BCfzi9x7dXHi3dm9zh+DELMWapkjfSxbz
 NVoeVJc5oCLQF2Ty5v9/wZxKk14yQxlDXPYfaMVQR34WE+CQbsnhq/6pPVTWngGcuUhhEr6K
 91RjCGoNzQIqX18t1an1GUMuLWUuH22IREks18BBJfJnxkT3SM1TP1FK9Imb/mxUW6vHpqWQ
 xkq5FdmLxx+XOduPvPEZx1VY9LR7fFglUmt6gGLkCRhxKfW+G+rF2sPg==;
Message-ID: <1b569fcf3d096066aeb011e21f9c1fe21f7df9b5.camel@siemens.com>
Subject: Re: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Michael Kelley <mhklinux@outlook.com>, Jan Kiszka
 <jan.kiszka@siemens.com>,  "K. Y. Srinivasan"	 <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu	 <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li	 <longli@microsoft.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar	 <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen	 <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>, RT
 <linux-rt-users@vger.kernel.org>,  Mitchell Levy <levymitchell0@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>, 
 "mrathor@linux.microsoft.com"	 <mrathor@linux.microsoft.com>,
 "anirudh@anirudhrb.com" <anirudh@anirudhrb.com>, 
 "schakrabarti@linux.microsoft.com"	 <schakrabarti@linux.microsoft.com>,
 "ssengar@linux.microsoft.com"	 <ssengar@linux.microsoft.com>
Date: Mon, 09 Feb 2026 11:35:14 +0100
In-Reply-To: <SN6PR02MB41579F60E39CA2A3CA8A5A75D467A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
	 <SN6PR02MB4157B6A9C8BEFA312F0D9D68D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <eb5debe8-b7d6-4076-b295-9a02271c2ee6@siemens.com>
	 <SN6PR02MB41579F60E39CA2A3CA8A5A75D467A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8770-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.microsoft.com,anirudhrb.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,siemens.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[siemens.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.bezdeka@siemens.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:mid,siemens.com:dkim]
X-Rspamd-Queue-Id: C72C910E31B
X-Rspamd-Action: no action

On Sat, 2026-02-07 at 01:30 +0000, Michael Kelley wrote:

[snip]
>=20
> I've run your suggested experiment on an arm64 VM in the Azure cloud. My
> kernel was linux-next 20260128. I set CONFIG_PREEMPT_RT=3Dy and
> CONFIG_PROVE_LOCKING=3Dy, but did not add either of your two patches
> (neither the storvsc driver patch nor the x86 VMBus interrupt handling pa=
tch).
> The VM comes up and runs, but with this warning during boot:
>=20
> [    3.075604] hv_utils: Registering HyperV Utility Driver
> [    3.075636] hv_vmbus: registering driver hv_utils
> [    3.085920] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    3.088128] hv_vmbus: registering driver hv_netvsc
> [    3.091180] [ BUG: Invalid wait context ]
> [    3.093544] 6.19.0-rc7-next-20260128+ #3 Tainted: G            E
> [    3.097582] -----------------------------
> [    3.099899] systemd-udevd/284 is trying to lock:
> [    3.102568] ffff000100e24490 (&channel->sched_lock){....}-{3:3}, at: v=
mbus_chan_sched+0x128/0x3b8 [hv_vmbus]
> [    3.108208] other info that might help us debug this:
> [    3.111454] context-{2:2}
> [    3.112987] 1 lock held by systemd-udevd/284:
> [    3.115626]  #0: ffffd5cfc20bcc80 (rcu_read_lock){....}-{1:3}, at: vmb=
us_chan_sched+0xcc/0x3b8 [hv_vmbus]
> [    3.121224] stack backtrace:
> [    3.122897] CPU: 0 UID: 0 PID: 284 Comm: systemd-udevd Tainted: G     =
       E       6.19.0-rc7-next-20260128+ #3 PREEMPT_RT
> [    3.129631] Tainted: [E]=3DUNSIGNED_MODULE
> [    3.131946] Hardware name: Microsoft Corporation Virtual Machine/Virtu=
al Machine, BIOS Hyper-V UEFI Release v4.1 06/10/2025
> [    3.138553] Call trace:
> [    3.140015]  show_stack+0x20/0x38 (C)
> [    3.142137]  dump_stack_lvl+0x9c/0x158
> [    3.144340]  dump_stack+0x18/0x28
> [    3.146290]  __lock_acquire+0x488/0x1e20
> [    3.148569]  lock_acquire+0x11c/0x388
> [    3.150703]  rt_spin_lock+0x54/0x230
> [    3.152785]  vmbus_chan_sched+0x128/0x3b8 [hv_vmbus]
> [    3.155611]  vmbus_isr+0x34/0x80 [hv_vmbus]
> [    3.158093]  vmbus_percpu_isr+0x18/0x30 [hv_vmbus]
> [    3.160848]  handle_percpu_devid_irq+0xdc/0x348
> [    3.163495]  handle_irq_desc+0x48/0x68
> [    3.165851]  generic_handle_domain_irq+0x20/0x38
> [    3.168664]  gic_handle_irq+0x1dc/0x430
> [    3.170868]  call_on_irq_stack+0x30/0x70
> [    3.173161]  do_interrupt_handler+0x88/0xa0
> [    3.175724]  el1_interrupt+0x4c/0xb0
> [    3.177855]  el1h_64_irq_handler+0x18/0x28
> [    3.180332]  el1h_64_irq+0x84/0x88
> [    3.182378]  _raw_spin_unlock_irqrestore+0x4c/0xb0 (P)
> [    3.185493]  rt_mutex_slowunlock+0x404/0x440
> [    3.187951]  rt_spin_unlock+0xb8/0x178
> [    3.190394]  kmem_cache_alloc_noprof+0xf0/0x4f8
> [    3.193100]  alloc_empty_file+0x64/0x148
> [    3.195461]  path_openat+0x58/0xaa0
> [    3.197658]  do_file_open+0xa0/0x140
> [    3.199752]  do_sys_openat2+0x190/0x278
> [    3.202124]  do_sys_open+0x60/0xb8
> [    3.204047]  __arm64_sys_openat+0x2c/0x48
> [    3.206433]  invoke_syscall+0x6c/0xf8
> [    3.208519]  el0_svc_common.constprop.0+0x48/0xf0
> [    3.211050]  do_el0_svc+0x24/0x38
> [    3.212990]  el0_svc+0x164/0x3c8
> [    3.214842]  el0t_64_sync_handler+0xd0/0xe8
> [    3.217251]  el0t_64_sync+0x1b0/0x1b8
> [    3.219450] hv_utils: Heartbeat IC version 3.0
> [    3.219471] hv_utils: Shutdown IC version 3.2
> [    3.219844] hv_utils: TimeSync IC version 4.0=20

That matches with my expectation that the same problem exists on arm64.
The patch from Jan addresses that issue for x86 (only, so far) as we do
not have a working test environment for arm64 yet.

>=20
> I don't see an indication that vmbus_isr() has been offloaded from
> interrupt level onto a thread.  The stack starting with el1h_64_irq()
> and going forward is the stack for normal per-cpu interrupt handling.
> Maybe arm64 with PREEMPT_RT does the offload to a thread only
> for SPIs and LPIs, but not for PPIs? I haven't looked at the source code
> for how PREEMPT_RT affects arm64 interrupt handling.
>=20
> Also, I had expected to see a problem with storvsc because I did
> not apply your storvsc patch. But there was no such problem, even
> with some disk I/O load (read only). arm64 VMs in Azure use exactly
> the same virtual SCSI devices that are used with x86 VMs in Azure or
> on local Hyper-V. I don't have an explanation. Will think about it.
>=20

Running the --iomix stressor provided by stress-ng was able to trigger
the SCSI problem within 2 minutes. The result was a completely frozen
system. For completeness the complete stress-ng command line:

# stress-ng --cpu 2 --iomix 8 --vm 2 --vm-bytes 128M --fork 4

Best regards,
Florian

