Return-Path: <linux-hyperv+bounces-8855-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMpyI4D5j2nuUgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8855-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 05:26:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1B613AFDD
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 05:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A907A3006D63
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 04:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8266529E0E7;
	Sat, 14 Feb 2026 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JnhDeaO0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9650A7404E;
	Sat, 14 Feb 2026 04:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771043195; cv=none; b=ZFRFt1/KmcJ279r1GCGYVD1UBVhVi4UlNlR135o4QGON9t42aJhrR1hmmKyJh4pq0vANV4e7SW2A/XnKmuUTiRzye75Nf1Mf6uZI6hTmK73HLQ2DJNwK15o67F5DaUZIQlQPo0bsWwo2cZBLd0ZaYFbSynABVLbmS+SMoAYATuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771043195; c=relaxed/simple;
	bh=UFJi+MYVCwDB0n2VneILsonlTyYyKYAunWK7J4Y6KlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOLQhV+m3FscfZ7nck5Js4aWmo+3tYsqpmeabnEqiip3qNm0BOHZ0jVzJQLIGmWukIEdxQaJXuyqhvmrtB0Waddy2SblRi39vJS54OfaaNOWtMbfxeLK2Fkee7T5WXmwtUOTPNXWcGKu6OOwd7PQE5fmGjx8rgYNdiyV/zyhAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JnhDeaO0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 4811C20B7167; Fri, 13 Feb 2026 20:26:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4811C20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771043192;
	bh=tCCdhsKGRgZcgYLz8pXiGdmG6FCr0BAaeXlAPyR+DwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnhDeaO0hi1bCouOfPC3PbZZLFxwL4ss1tWYegkXIJypc96nI879qV1IM3rDeEAm2
	 Oqu5NKbWST5cWWa6f68cXVvc9CHpTgYcTYd9sn9/HZYu1RVV3ckufZE6YGaDjcd92t
	 MmTl3v0L9Us3Ut7+V8YH5mkjY5UePcjaHTxijYDY=
Date: Fri, 13 Feb 2026 20:26:32 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Message-ID: <aY/5eBLvodLYbV0a@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <514e068c-1b85-4e39-8388-c1d2b106b4e9@siemens.com>
 <aY/4D/JVu7TjNOku@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aY/4D/JVu7TjNOku@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8855-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ssengar@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,linux.microsoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,siemens.com:email]
X-Rspamd-Queue-Id: 9C1B613AFDD
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 08:20:31PM -0800, Saurabh Singh Sengar wrote:
> On Fri, Feb 06, 2026 at 07:47:54AM +0100, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > 
> > Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
> > with related guest support enabled:
> > 
> > [    1.127941] hv_vmbus: registering driver hyperv_drm
> > 
> > [    1.132518] =============================
> > [    1.132519] [ BUG: Invalid wait context ]
> > [    1.132521] 6.19.0-rc8+ #9 Not tainted
> > [    1.132524] -----------------------------
> > [    1.132525] swapper/0/0 is trying to lock:
> > [    1.132526] ffff8b9381bb3c90 (&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0xc4/0x2b0
> > [    1.132543] other info that might help us debug this:
> > [    1.132544] context-{2:2}
> > [    1.132545] 1 lock held by swapper/0/0:
> > [    1.132547]  #0: ffffffffa010c4c0 (rcu_read_lock){....}-{1:3}, at: vmbus_chan_sched+0x31/0x2b0
> > [    1.132557] stack backtrace:
> > [    1.132560] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc8+ #9 PREEMPT_{RT,(lazy)}
> > [    1.132565] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/25/2025
> > [    1.132567] Call Trace:
> > [    1.132570]  <IRQ>
> > [    1.132573]  dump_stack_lvl+0x6e/0xa0
> > [    1.132581]  __lock_acquire+0xee0/0x21b0
> > [    1.132592]  lock_acquire+0xd5/0x2d0
> > [    1.132598]  ? vmbus_chan_sched+0xc4/0x2b0
> > [    1.132606]  ? lock_acquire+0xd5/0x2d0
> > [    1.132613]  ? vmbus_chan_sched+0x31/0x2b0
> > [    1.132619]  rt_spin_lock+0x3f/0x1f0
> > [    1.132623]  ? vmbus_chan_sched+0xc4/0x2b0
> > [    1.132629]  ? vmbus_chan_sched+0x31/0x2b0
> > [    1.132634]  vmbus_chan_sched+0xc4/0x2b0
> > [    1.132641]  vmbus_isr+0x2c/0x150
> > [    1.132648]  __sysvec_hyperv_callback+0x5f/0xa0
> > [    1.132654]  sysvec_hyperv_callback+0x88/0xb0
> > [    1.132658]  </IRQ>
> > [    1.132659]  <TASK>
> > [    1.132660]  asm_sysvec_hyperv_callback+0x1a/0x20
> > 
> > As code paths that handle vmbus IRQs use sleepy locks under PREEMPT_RT,
> > the complete vmbus_handler execution needs to be moved into thread
> > context. Open-coding this allows to skip the IPI that irq_work would
> > additionally bring and which we do not need, being an IRQ, never an NMI.
> > 
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> First I would like to share my opinion that, although support for the
> RT kernel is not on the near-term roadmap, we should welcome RT Linux
> patches.
> 
> Coming back to this patch I can reproduce the stack trace referenced
> in the commit when running with PREEMPT_RT enabled, and I have verified
> that this patch resolves the issue. Next, I observed the storage-related
> stack trace mentioned in Jan’s other patch; applying the storvsc patch
> fixed that as well.
> 
> However, when testing without PREEMPT_RT enabled, I see a another lockdep
> warning below (both with and without Jan’s patches). IWanted to check if
> is it possible to address this issue as part of the same fix ?
> Doing so would make the change more useful beyond PREEMPT_RT.


Sharing the stack, missed in previous email:

[    1.612866] =============================
[    1.616197] tun: Universal TUN/TAP device driver, 1.6
[    1.612866] [ BUG: Invalid wait context ]
[    1.612866] 6.19.0-next-20260212+ #8 Not tainted
[    1.612866] -----------------------------
[    1.612866] swapper/0/0 is trying to lock:
[    1.612866] ffff895a03dfd3f0 (&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0xda/0x350
[    1.621086] PPP generic driver version 2.4.2
[    1.612866] other info that might help us debug this:
[    1.612866] context-{2:2}
[    1.612866] 1 lock held by swapper/0/0:
[    1.612866]  #0: ffffffff9b7d4660 (rcu_read_lock){....}-{1:3}, at: vmbus_chan_sched+0x38/0x350
[    1.628045] i8042: PNP: No PS/2 controller found.
[    1.612866] stack backtrace:
[    1.612866] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-next-20260212+ #8 PREEMPT
[    1.612866] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/25/2025
[    1.612866] Call Trace:
[    1.612866]  <IRQ>
[    1.612866]  dump_stack_lvl+0x6f/0xb0
[    1.612866]  dump_stack+0x10/0x20
[    1.612866]  __lock_acquire+0x973/0x24e0
[    1.612866]  ? __lock_acquire+0x449/0x24e0
[    1.612866]  lock_acquire+0xb6/0x2c0
[    1.612866]  ? vmbus_chan_sched+0xda/0x350
[    1.612866]  ? vmbus_chan_sched+0x38/0x350
[    1.612866]  _raw_spin_lock+0x2f/0x50
[    1.612866]  ? vmbus_chan_sched+0xda/0x350
[    1.612866]  vmbus_chan_sched+0xda/0x350
[    1.612866]  ? sched_clock_idle_wakeup_event+0x22/0x50
[    1.612866]  vmbus_isr+0x26/0x170
[    1.612866]  __sysvec_hyperv_callback+0x43/0x80
[    1.612866]  sysvec_hyperv_callback+0x85/0xb0
[    1.612866]  </IRQ>
[    1.612866]  <TASK>
[    1.612866]  asm_sysvec_hyperv_callback+0x1b/0x20
[    1.612866] RIP: 0010:pv_native_safe_halt+0xb/0x10
[    1.612866] Code: 48 2b 05 d8 00 97 00 5d c3 cc cc cc cc 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 0f 00 2d 99 33 1f 00 fb f4 <e9> 40 9e 01 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55
[    1.612866] RSP: 0000:ffffffff9b603dd8 EFLAGS: 00000242
[    1.612866] RAX: 0000000000040d85 RBX: 0000000000000000 RCX: 0000000000000000
[    1.612866] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9981172f
[    1.612866] RBP: ffffffff9b603de0 R08: 0000000000000001 R09: 0000000000000000
[    1.612866] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[    1.612866] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff9b628490
[    1.612866]  ? do_idle+0x20f/0x290
[    1.612866]  ? default_idle+0x9/0x20
[    1.612866]  arch_cpu_idle+0x9/0x10
[    1.612866]  default_idle_call+0x83/0x210
[    1.612866]  do_idle+0x20f/0x290
[    1.612866]  cpu_startup_entry+0x29/0x30
[    1.612866]  rest_init+0x104/0x200
[    1.612866]  start_kernel+0xa13/0xc90
[    1.612866]  ? sme_unmap_bootdata+0x14/0x70
[    1.612866]  x86_64_start_reservations+0x18/0x30
[    1.612866]  x86_64_start_kernel+0x148/0x1a0
[    1.612866]  ? soft_restart_cpu+0x14/0x14
[    1.612866]  common_startup_64+0x13e/0x141
[    1.612866]  </TASK>

- Saurabh

