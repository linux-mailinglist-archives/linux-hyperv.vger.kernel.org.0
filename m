Return-Path: <linux-hyperv+bounces-10796-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMdJDbqOAmryuQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10796-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:21:46 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9901518E01
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A26E23018C2F
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0E3363081;
	Tue, 12 May 2026 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+ZNzb8x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BAC1A680C;
	Tue, 12 May 2026 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552497; cv=none; b=Wfj7qU2Y79Txb1w/MNqUhxqOz5RDXUZV2D2f7eaVJlZTM3wxA0d25/fpkq7AmsUtVTJz0TWnBKVVbzyPpdFBPSq9gbDIs/KWSxVMp12SwbxESg0imCFrzAk1Qe505sY+ugsieelFLc1rJvgIhUtUa6wHLRPRDP8vEGlI+h9IxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552497; c=relaxed/simple;
	bh=T+0Nef/1KS8+15UPaVvnoK25b9jw3Qq81QPRwdPZQYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON15t93W1RXTI2GQJ7bQVTOi6zudA5I4Rp5Roy83p+SIe1dUhZiQuRMhYwSwAfql47Wl9R8bZNaYTVa4DF6rZmfG2J/F/bLVlZyfIoC54Ihn07qRfcQGXHuGUB3sdRd0klYPkHAVx+0iuMjeX9ekSDTQu7F7CLeitkfh9U8IxZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+ZNzb8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C70AC2BCF5;
	Tue, 12 May 2026 02:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778552496;
	bh=T+0Nef/1KS8+15UPaVvnoK25b9jw3Qq81QPRwdPZQYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+ZNzb8xj6Rp4yY/07754ewJ407kQs9VG7mxAtf+AbcxcvXzPR2THpc+eUjyyCSeb
	 DomBi0XfG321XOM8wlEnDXeIsxHrsImaGk0DDcHTBnY7cPTP3q41NcKEgz1Av4Ii6Y
	 wwJKqPqgklKg+mzVcFUaDOFEnvSxnsz5jGZl4fIKSbUyDplNJh2xDlZ3TKCuPQ73lC
	 onkzFmQXESTrVP9yO7ksHshCS6eKXxCbjKTKstTw0zThg3JhhSpWTPL3QKfgNI0aPe
	 xVtO7UVsnDVMQHDOuTrbKSBO9jUzX7oMEs+essH8t4s2h4NAONpCLbIellTKr9Zzkd
	 I5d5LIwXpZQGA==
From: Jakub Kicinski <kuba@kernel.org>
To: dipayanroy@linux.microsoft.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	stephen@networkplumber.org,
	jacob.e.keller@intel.com,
	dipayanroy@microsoft.com,
	leitao@debian.org,
	kees@kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	sdf@fomichev.me,
	yury.norov@gmail.com
Subject: Re: [PATCH v8 2/2] net: mana: force full-page RX buffers via ethtool private flag
Date: Mon, 11 May 2026 19:21:33 -0700
Message-ID: <20260512022133.856196-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508115100.488506-3-dipayanroy@linux.microsoft.com>
References: <20260508115100.488506-3-dipayanroy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A9901518E01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10796-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mana: force full-page RX buffers via ethtool private flag

This patch adds an ethtool private flag "full-page-rx" that forces one
RX buffer per page, bypassing the page_pool fragment path, to address
a 15-20% throughput regression seen on some 4K PAGE_SIZE ARM64
platforms under high connection counts.  Toggling the flag triggers
mana_detach() + mana_attach() to apply the new RX buffer layout.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index a28ca461c135..dfd222de11d0 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c

[ ... ]

> @@ -590,6 +609,88 @@ static int mana_get_link_ksettings(struct net_device *ndev,
>  	return 0;
>  }
>  

[ ... ]

> +static int mana_set_priv_flags(struct net_device *ndev, u32 priv_flags)
> +{
> +	struct mana_port_context *apc = netdev_priv(ndev);
> +	u32 changed = apc->priv_flags ^ priv_flags;
> +	u32 old_priv_flags = apc->priv_flags;
> +	bool schedule_port_reset = false;
> +	int err = 0;
> +
> +	if (!changed)
> +		return 0;
> +
> +	/* Reject unknown bits */
> +	if (priv_flags & ~GENMASK(MANA_PRIV_FLAG_MAX - 1, 0))
> +		return -EINVAL;
> +
> +	if (changed & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF)) {
> +		apc->priv_flags = priv_flags;
> +
> +		if (!apc->port_is_up) {
> +			/* Port is down, flag updated to apply on next up
> +			 * so just return.
> +			 */
> +			return 0;
> +		}
> +
> +		/* Pre-allocate buffers to prevent failure in mana_attach
> +		 * later
> +		 */
> +		err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
> +		if (err) {
> +			netdev_err(ndev,
> +				   "Insufficient memory for new allocations\n");
> +			apc->priv_flags = old_priv_flags;
> +			return err;
> +		}
> +
> +		err = mana_detach(ndev, false);
> +		if (err) {
> +			netdev_err(ndev, "mana_detach failed: %d\n", err);
> +			apc->priv_flags = old_priv_flags;
> +
> +			/* Port is in an inconsistent state. Restore
> +			 * 'port_is_up' so that queue reset work handler
> +			 * can properly detach and re-attach.
> +			 */
> +			apc->port_is_up = true;
> +			schedule_port_reset = true;
> +			goto out;
> +		}
> +
> +		err = mana_attach(ndev);
> +		if (err) {
> +			netdev_err(ndev, "mana_attach failed: %d\n", err);
> +			apc->priv_flags = old_priv_flags;
> +
> +			/* Restore 'port_is_up' so the reset work handler
> +			 * can properly detach/attach. Without this,
> +			 * the handler sees port_is_up=false and skips
> +			 * queue allocation, leaving the port dead.
> +			 */
> +			apc->port_is_up = true;
> +			schedule_port_reset = true;
> +		}
> +	}
> +
> +out:
> +	mana_pre_dealloc_rxbufs(apc);
> +
> +	if (schedule_port_reset)
> +		queue_work(apc->ac->per_port_queue_reset_wq,
> +			   &apc->queue_reset_work);
> +
> +	return err;
> +}

[High]
Can this failure path oops inside the reset work handler?

When mana_attach() fails after mana_detach() has already torn the vport
down, apc->tx_qp has been set to NULL by mana_destroy_txq() and apc->rxqs
has been cleared by mana_cleanup_port_context().  This code then forces
apc->port_is_up back to true and queues apc->queue_reset_work:

    apc->port_is_up = true;
    schedule_port_reset = true;

When mana_per_port_queue_reset_work_handler runs it calls
mana_detach(ndev, false), which latches port_st_save = port_is_up = true
and, because port_st_save is true, invokes mana_dealloc_queues().  The TX
drain loop there does:

    txq = &apc->tx_qp[i].txq;
    atomic_read(&txq->pending_sends);

with no NULL check on apc->tx_qp, and mana_destroy_vport further down
iterates apc->rxqs[rxq_idx] while rxqs is NULL.  Would that produce a
NULL pointer dereference in the workqueue worker whenever mana_attach()
fails here (for example on an allocation failure in
mana_init_port_context or mana_create_txq, or a transient HW command
failure in mana_query_vport_cfg / mana_cfg_vport)?

The mana_detach() failure path above (goto out) reaches
mana_dealloc_queues() through the same chain and looks to have the same
exposure.

For comparison, mana_change_mtu() handles a mana_attach() failure by
returning the error without scheduling a reset.  Would a similar
treatment here avoid the asynchronous oops, or is there a reason the
reset must be scheduled in this specific failure case?
-- 
pw-bot: cr

