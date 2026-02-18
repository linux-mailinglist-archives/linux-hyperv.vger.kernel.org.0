Return-Path: <linux-hyperv+bounces-8884-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOprIyFolWk/QgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8884-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 08:20:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2319D1539CA
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 08:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 823B9300749D
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 07:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325D3093BF;
	Wed, 18 Feb 2026 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EYiTpTWr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC4A2848BB;
	Wed, 18 Feb 2026 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399198; cv=none; b=Ebtb2oTri1WtjT7hbZTZRb6mirSgB67mOF4mSmOkhBcI1tAwsp0Yziu2T/DIccaPTGYOTDwyavqENq9mPAgIGe4I85d+qzHbLyQ4UalPoUZsU8vBKgIuIB01Hk5zybz2t2oIR6ZZcsqOshzwM5QL+UxSIoarIPSo8wpzVoga5ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399198; c=relaxed/simple;
	bh=CMnonVvti53FCRIs2GqHwCIvnDUHhvw5xYvkB6fIZK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCl2QmekyAwj7baT9KFuN9Dd65Ct/+bjSLWsg6xwvRRok5xyBjcOfbtAe+mU2X1AGSyQilKRrKydW4s9tp8JONLF5zaQE17V/ArETqHGuXWf2qKyKB4y+dacYXwq8A+FYTkrBSnOhwUGH3g6EneTidSBYb98rirMsiLDhXsBAec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EYiTpTWr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id F084220B6F00; Tue, 17 Feb 2026 23:19:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F084220B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771399196;
	bh=mCFkIACFMaE8niH2M/LuVm2Qd7DXdaZwuVMfoVs2KmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EYiTpTWrl25m8rTuX6RPtBGGmSpK83ybkCk4A6GWiLT5dnjNGaMFc4GMOWwWeKdxV
	 FhnFxqjIDqDWorPbRMD5oBGS0CMfFkwZsSPNWAe0Sqf5FLDYGxaM5Qxz+4Fqo41Xbg
	 rP3BMX8RuvrHBO6Vj9FUN3nNSVpT9YmsGxZHvk3I=
Date: Tue, 17 Feb 2026 23:19:56 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
Message-ID: <aZVoHGJWGqB3W9mv@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
 <20260218070557.GF2236050@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218070557.GF2236050@liuwe-devbox-debian-v2.local>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8884-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[siemens.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,gmail.com,outlook.com,linux.microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ssengar@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,siemens.com:email,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 2319D1539CA
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 07:05:57AM +0000, Wei Liu wrote:
> On Mon, Feb 16, 2026 at 05:24:56PM +0100, Jan Kiszka wrote:
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
> > the vmbus_isr execution needs to be moved into thread context. Open-
> > coding this allows to skip the IPI that irq_work would additionally
> > bring and which we do not need, being an IRQ, never an NMI.
> > 
> > This affects both x86 and arm64, therefore hook into the common driver
> > logic.
> > 
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Applied to hyperv-next. Thanks.
> 
> Saurabh and Naman, I want to get this submitted in this merge window. If
> you find any more issues with this patch, we can address them in the RC
> phase. In the worst case, we can revert this patch later.
> 
> Wei

I was in the process of completing the final round of testing; however, since
the change has now been merged, it will receive broader coverage, I will rely
on that.

Overall, the patch looks good to me.

- Saurabh

