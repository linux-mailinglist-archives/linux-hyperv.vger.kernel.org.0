Return-Path: <linux-hyperv+bounces-9751-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK9sNLaow2nAtAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9751-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 10:19:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6EA3220AE
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 10:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE124303B7DB
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F0F350A1B;
	Wed, 25 Mar 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plX75fj6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B8347BC1;
	Wed, 25 Mar 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430043; cv=none; b=p69hyiCNsZ2JR4rRDBgvVsIfwcAer9GJQOdAj0Lfs/CwC/HDrOYj3mzObNUd5nb90kGT4lBf7FIs6aqvVXbrBCyBcpphrZbFHYSl+T3RhjUiLN5klDIStVtk/APmKto2ZKClpxaDGmMMwqD7O+2aAt5ZWwxKCHRdF3G2DnEUzCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430043; c=relaxed/simple;
	bh=78pyxin5qndZKSJzDXsFFmZnhzDT7LLyrqA2VFYSpPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upkUNpIsg+06/j0pVK744setFYNMOqu13OtPvWqwnUVhb4PeXxSN3cAwyS4YMm5lAXPvutUpP3oF2pd/Z3v03HYQt/VSIba/ieiSYtdTo08P3qR2GZIOvXHHqBR0nqVvFBxFO0Wa/YEXxzz8p/9Qcue0xpofdhyI+6/dJlm8xwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plX75fj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EFCC4CEF7;
	Wed, 25 Mar 2026 09:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774430043;
	bh=78pyxin5qndZKSJzDXsFFmZnhzDT7LLyrqA2VFYSpPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=plX75fj6Fi/CInEUCv8w5cHIDsad+uaIJX11gWXQZPLJJfOjxOosFJurvATwdmzyf
	 XM1fLbDydsi7l/I4rpFP1BhjUzFOQ6/hjYw54HGBxNQsrwyEtfT2GI0a4cA2FlfiHb
	 Sov+e/lBVY+RfSyA0pCltMc0T/7xgv642U1NGI0MXjy8jQyo/dCKntQ7HYnpgUgil6
	 50NrK30hAVvx6h94jAhu8o0u0oOb2WcEjPIS4o6//SY9KR923JbehewO+oIH9PAMhT
	 stADXCjZPDMiqTzvvHa2LGYvmbBAg6lKE7Lk6gOOGIJPio4X+XTCnZWFF3z1ULGLKk
	 TlxBWeUuqn+DQ==
Date: Wed, 25 Mar 2026 11:13:57 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH rdma v2] RDMA/mana_ib: Disable RX steering on RSS QP
 destroy
Message-ID: <20260325091357.GP814676@unreal>
References: <20260323201106.1768705-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323201106.1768705-1-longli@microsoft.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9751-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A6EA3220AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 01:10:56PM -0700, Long Li wrote:
> When an RSS QP is destroyed (e.g. DPDK exit), mana_ib_destroy_qp_rss()
> destroys the RX WQ objects but does not disable vPort RX steering in
> firmware. This leaves stale steering configuration that still points to
> the destroyed RX objects.
> 
> If traffic continues to arrive (e.g. peer VM is still transmitting) and
> the VF interface is subsequently brought up (mana_open), the firmware
> may deliver completions using stale CQ IDs from the old RX objects.
> These CQ IDs can be reused by the ethernet driver for new TX CQs,
> causing RX completions to land on TX CQs:
> 
>   WARNING: mana_poll_tx_cq+0x1b8/0x220 [mana]  (is_sq == false)
>   WARNING: mana_gd_process_eq_events+0x209/0x290 (cq_table lookup fails)
> 
> Fix this by disabling vPort RX steering before destroying RX WQ objects.
> Note that mana_fence_rqs() cannot be used here because the fence
> completion is delivered on the CQ, which is polled by user-mode (e.g.
> DPDK) and not visible to the kernel driver.
> 
> Refactor the disable logic into a shared mana_disable_vport_rx() in
> mana_en, exported for use by mana_ib, replacing the duplicate code.
> The ethernet driver's mana_dealloc_queues() is also updated to call
> this common function.
> 
> Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
> v2:
>   - Removed redundant ibdev_err on mana_disable_vport_rx() failure as
>     mana_cfg_vport_steering() already logs all failure scenarios.
>   - Added comment clarifying this is best effort.
>  drivers/infiniband/hw/mana/qp.c               | 15 +++++++++++++++
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 11 ++++++++++-
>  include/net/mana/mana.h                       |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)


It doesn't apply to rdma-rc.

Looking up https://lore.kernel.org/all/20260323201106.1768705-1-longli@microsoft.com/
Grabbing thread from lore.kernel.org/all/20260323201106.1768705-1-longli@microsoft.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 3 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
---
  [PATCH v2] RDMA/mana_ib: Disable RX steering on RSS QP destroy
    + Link: https://patch.msgid.link/20260323201106.1768705-1-longli@microsoft.com
    + Signed-off-by: Leon Romanovsky <leon@kernel.org>
  ---
  NOTE: install dkimpy for DKIM signature verification
---
Total patches: 1
---
Applying: RDMA/mana_ib: Disable RX steering on RSS QP destroy
Patch failed at 0001 RDMA/mana_ib: Disable RX steering on RSS QP destroy
error: patch failed: drivers/net/ethernet/microsoft/mana/mana_en.c:3339
error: drivers/net/ethernet/microsoft/mana/mana_en.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Press any key to continue...

Thanks

