Return-Path: <linux-hyperv+bounces-8027-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E87CC31E5
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 14:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1802308747C
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B4634D4F7;
	Tue, 16 Dec 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCZJjVc1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAF34D3AB;
	Tue, 16 Dec 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887645; cv=none; b=G5DanFSthevPHdzZ4TGMmjsntavvTRB+GIv2eyBIdO6IBwFrQOJUrJuHG5YIR7glbgXWiUTPVF5pZCFCNRuGh8VbYKj3ksj1I2K5FGMn3x3flhvh45sQvzsmJpUM/a3v/GUM8TzVAnXmX2KmXUQTc2+GnrJtYSZXLewpN8h0irQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887645; c=relaxed/simple;
	bh=YUQEOtdBM4h1nc++QKKGyni9ZcT7y5HRI51H7ug9qvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPjjU86rWQCsFVRS+uWRnIiqszlQ0xdz+9z/61Pywh50Xd3g43tT9YJhlJbqAN281cyIl15DGZLXGcIcWDJyFtnY8HlScpl7qGBRDExngI6wg0bsH8riuYS961PaHRQQlEi0Bcnlg1iSz20ym32Tpr4RL1r/CbcPhBxBkc8fKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCZJjVc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C09AC4CEF1;
	Tue, 16 Dec 2025 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765887645;
	bh=YUQEOtdBM4h1nc++QKKGyni9ZcT7y5HRI51H7ug9qvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCZJjVc1mPf1+U6aTg+0G2Dl9Qalans3zgrluwgOXTe/kxNISyaJrQlZ2udr1s0X5
	 x8ch/uWQA0zFx+zD2vNwNTHd5qM18OzzQU3+f7hQX2zdWjog9qXKeuyc6sIYtN55hT
	 evIxHDpRELyQNYzfdaZGluY71DPKucFGP3xzm2vNEhuKtPoAz9kakmrF9ddAreb02H
	 ucoyThGwOdS8V4+psw9oD29cFmWQUgbJrIHC6+ilUh9COsm1AvReVJolaNX6Mer8Nx
	 hj282intAZYueA6YPvVZf/uvJaV/Xyv+1dM5b/wrE/77zGwX1CB5or1emjgGjy4RkJ
	 t4mkuziICA1iQ==
Date: Tue, 16 Dec 2025 12:20:39 +0000
From: Simon Horman <horms@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	dipayanroy@microsoft.com
Subject: Re: [PATCH net-next] net: mana: Fix use-after-free in reset service
 rescan path
Message-ID: <aUFOl4euBSyPtA5F@horms.kernel.org>
References: <20251216105508.GA13584@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216105508.GA13584@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Tue, Dec 16, 2025 at 02:55:08AM -0800, Dipayaan Roy wrote:
> When mana_serv_reset() encounters -ETIMEDOUT or -EPROTO from
> mana_gd_resume(), it performs a PCI rescan via mana_serv_rescan().
> 
> mana_serv_rescan() calls pci_stop_and_remove_bus_device(), which can
> invoke the driver's remove path and free the gdma_context associated
> with the device. After returning, mana_serv_reset() currently jumps to
> the out label and attempts to clear gc->in_service, dereferencing a
> freed gdma_context.
> 
> The issue was observed with the following call logs:
> [  698.942636] BUG: unable to handle page fault for address: ff6c2b638088508d
> [  698.943121] #PF: supervisor write access in kernel mode
> [  698.943423] #PF: error_code(0x0002) - not-present page
> [S[  698.943793] Pat Dec  6 07:GD5 100000067 P4D 1002f7067 PUD 1002f8067 PMD 101bef067 PTE 0
> 0:56 2025] hv_[n e 698.944283] Oops: Oops: 0002 [#1] SMP NOPTI
> tvsc f8615163-00[  698.944611] CPU: 28 UID: 0 PID: 249 Comm: kworker/28:1
> ...
> [Sat Dec  6 07:50:56 2025] R10: [  699.121594] mana 7870:00:00.0 enP30832s1: Configured vPort 0 PD 18 DB 16
> 000000000000001b R11: 0000000000000000 R12: ff44cf3f40270000
> [Sat Dec  6 07:50:56 2025] R13: 0000000000000001 R14: ff44cf3f402700c8 R15: ff44cf3f4021b405
> [Sat Dec  6 07:50:56 2025] FS:  0000000000000000(0000) GS:ff44cf7e9fcf9000(0000) knlGS:0000000000000000
> [Sat Dec  6 07:50:56 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [Sat Dec  6 07:50:56 2025] CR2: ff6c2b638088508d CR3: 000000011fe43001 CR4: 0000000000b73ef0
> [Sat Dec  6 07:50:56 2025] Call Trace:
> [Sat Dec  6 07:50:56 2025]  <TASK>
> [Sat Dec  6 07:50:56 2025]  mana_serv_func+0x24/0x50 [mana]
> [Sat Dec  6 07:50:56 2025]  process_one_work+0x190/0x350
> [Sat Dec  6 07:50:56 2025]  worker_thread+0x2b7/0x3d0
> [Sat Dec  6 07:50:56 2025]  kthread+0xf3/0x200
> [Sat Dec  6 07:50:56 2025]  ? __pfx_worker_thread+0x10/0x10
> [Sat Dec  6 07:50:56 2025]  ? __pfx_kthread+0x10/0x10
> [Sat Dec  6 07:50:56 2025]  ret_from_fork+0x21a/0x250
> [Sat Dec  6 07:50:56 2025]  ? __pfx_kthread+0x10/0x10
> [Sat Dec  6 07:50:56 2025]  ret_from_fork_asm+0x1a/0x30
> [Sat Dec  6 07:50:56 2025]  </TASK>
> 
> Fix this by returning immediately after mana_serv_rescan() to avoid
> accessing GC state that may no longer be valid.
> 
> Fixes: 9bf66036d686 ("net: mana: Handle hardware recovery events when probing the device")
> 

nit: no blank line here please - tags should all appear in one block

> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

I see that this patch is targeted at net-next.
But this is a fix for a patch present in net.
So it should be targeted at net instead

Subject: [PATCH net] ...

Probably it is not necessary to repost in order to address the minor
feedback I've provided above. But if you do, please be sure to observe
the 24h rule and wait that long between posting revisions of that patch.

https://docs.kernel.org/process/maintainer-netdev.html

The above not withstanding, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

