Return-Path: <linux-hyperv+bounces-8882-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDNtC9tklWkvQQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8882-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 08:06:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D0A1538DB
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 08:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88F713023D93
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 07:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C03F304BDA;
	Wed, 18 Feb 2026 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJrbhWS+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177CF2EDD7E;
	Wed, 18 Feb 2026 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771398359; cv=none; b=BscH98rKqasjBJm7TTW0hHrmZWWe8MKWZsVdoHwuW8gYJVrRCvPv+szNmCC04OoU1nydnRV32FyCVzZ1RcxIMLap2QXlK/UcBy0rP1+0rIRQU5DeRovjjuQmxiNAm+XSE+Mkes87by8afVOttNeg9ZS+vYaJ+KadT6XO84NpMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771398359; c=relaxed/simple;
	bh=5W717oXZyNPE8Nx/B3j+fPwMsUD/fjo1cC5YUB1IhXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IexuRv6J1BB9O9yMPBe8J6lL6ZoKvc79IcTTLJmtBT2d5/XPt90VdnZR3rRzvK/gDTBEFLJFncan1vfrqfFEPnp+8Qiiaqg1Ukw3MM+GSy6dD+M7TMI6R2/tapqrKvnT7PK2eHGsfDlEsgHplw5GeWjv7CKYVx9oe+t+rucurTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJrbhWS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6FBC19421;
	Wed, 18 Feb 2026 07:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771398358;
	bh=5W717oXZyNPE8Nx/B3j+fPwMsUD/fjo1cC5YUB1IhXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJrbhWS+0mj+G2qIPnuODu54ipCjoswIeIaHUa9QTf51D59ORauMBv1aZb2sb8PWd
	 2MnhGxkeFCAGgn/sJ+rgqIKOfZSz/asNjKxh0/ergpGsTrxY6ayBDN+HcvFG0E70y3
	 VIqlu5Nk1YqoiMLqaDHBwVMumXJrJgNH/cuvTsknNiiok2zHL05pDLK7Rls0ulso7r
	 99irn4g9aM2vKTbfMgIiJ4JFZsO1phhfpNcs8goaNc8Gq4oHmPnLmGavcLu+YQoWHl
	 stPYu+MAGtHG6d8dbCWG5CG+YZHqNKaYB/mzn0Ry9xPU7HgKX05B/PFSASWFlx4UaT
	 /2YhX9gnnvsmw==
Date: Wed, 18 Feb 2026 07:05:57 +0000
From: Wei Liu <wei.liu@kernel.org>
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
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
Message-ID: <20260218070557.GF2236050@liuwe-devbox-debian-v2.local>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-8882-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,outlook.com,linux.microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[liuwe-devbox-debian-v2.local:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96D0A1538DB
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 05:24:56PM +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
> with related guest support enabled:
> 
> [    1.127941] hv_vmbus: registering driver hyperv_drm
> 
> [    1.132518] =============================
> [    1.132519] [ BUG: Invalid wait context ]
> [    1.132521] 6.19.0-rc8+ #9 Not tainted
> [    1.132524] -----------------------------
> [    1.132525] swapper/0/0 is trying to lock:
> [    1.132526] ffff8b9381bb3c90 (&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0xc4/0x2b0
> [    1.132543] other info that might help us debug this:
> [    1.132544] context-{2:2}
> [    1.132545] 1 lock held by swapper/0/0:
> [    1.132547]  #0: ffffffffa010c4c0 (rcu_read_lock){....}-{1:3}, at: vmbus_chan_sched+0x31/0x2b0
> [    1.132557] stack backtrace:
> [    1.132560] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc8+ #9 PREEMPT_{RT,(lazy)}
> [    1.132565] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/25/2025
> [    1.132567] Call Trace:
> [    1.132570]  <IRQ>
> [    1.132573]  dump_stack_lvl+0x6e/0xa0
> [    1.132581]  __lock_acquire+0xee0/0x21b0
> [    1.132592]  lock_acquire+0xd5/0x2d0
> [    1.132598]  ? vmbus_chan_sched+0xc4/0x2b0
> [    1.132606]  ? lock_acquire+0xd5/0x2d0
> [    1.132613]  ? vmbus_chan_sched+0x31/0x2b0
> [    1.132619]  rt_spin_lock+0x3f/0x1f0
> [    1.132623]  ? vmbus_chan_sched+0xc4/0x2b0
> [    1.132629]  ? vmbus_chan_sched+0x31/0x2b0
> [    1.132634]  vmbus_chan_sched+0xc4/0x2b0
> [    1.132641]  vmbus_isr+0x2c/0x150
> [    1.132648]  __sysvec_hyperv_callback+0x5f/0xa0
> [    1.132654]  sysvec_hyperv_callback+0x88/0xb0
> [    1.132658]  </IRQ>
> [    1.132659]  <TASK>
> [    1.132660]  asm_sysvec_hyperv_callback+0x1a/0x20
> 
> As code paths that handle vmbus IRQs use sleepy locks under PREEMPT_RT,
> the vmbus_isr execution needs to be moved into thread context. Open-
> coding this allows to skip the IPI that irq_work would additionally
> bring and which we do not need, being an IRQ, never an NMI.
> 
> This affects both x86 and arm64, therefore hook into the common driver
> logic.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied to hyperv-next. Thanks.

Saurabh and Naman, I want to get this submitted in this merge window. If
you find any more issues with this patch, we can address them in the RC
phase. In the worst case, we can revert this patch later.

Wei

