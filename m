Return-Path: <linux-hyperv+bounces-11620-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j0GzNtYSLWquawQAu9opvQ
	(envelope-from <linux-hyperv+bounces-11620-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jun 2026 10:20:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3226A67E1CF
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jun 2026 10:20:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JF1NCZZE;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11620-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11620-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE9C1304E6C5
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jun 2026 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677DB3B9618;
	Sat, 13 Jun 2026 08:20:36 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82229AAEA;
	Sat, 13 Jun 2026 08:20:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781338836; cv=none; b=owMBegMQSXtpf5Q2X3ZVkKR+meB8rfh51yd7loqeDsm2P456FShZq6pCzhhXSqqJ0MT5C9Lw24m+bCoucaMmP2bqTRqz2KXNMb435C5MFY4GIrb6+Qzf41AYY9eDFpLOWgdc4lU6IT6typ9KsvypKGAjA1GRJGbD9oFRFpB7mNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781338836; c=relaxed/simple;
	bh=DE25FeJIR3eJbEyPjqnpV0gPCOu3SN4ATSHKVunPjeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hISBRXa3BI608Z3QRiC4idcfEtQXwynQqz9z9ycetQ8NKYplk9isFMhvHTkdKrWHm2+5cHYcKjuLY2nA7sgZNcX2AF1DsiP4LGVsCgWbHL6uwxfx37cNjKUh+qrJKpvTZTR8DsjKgVep0HSbsjq316pPZbzxlEOHoEkwW9FRYN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JF1NCZZE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE641F000E9;
	Sat, 13 Jun 2026 08:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781338833;
	bh=owuCffPj0B6/q5HMfLZveBGQe9ejC5DkgaoaNYPwlyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JF1NCZZEzUhUrypMbf9whwV19dOYhpu6tusXQeZiMlKEqECpkpXhLH+/nsu2WUwOt
	 YfOBVV0Yx9s3cxTHnShBEdDGeeqHF5kqNKiGDDVwKUvnIpq3wpC32HBQ887rzgDQHg
	 pJ7IC4tByuRnDqVHCPAnr6fPDqiNCTqC3I14Eoivwv49V1sRXjypQfqtXmOgFhxQWA
	 I5fM5n/Koel+q1i8GG19VrifHGq3x9VnhY/t5bN4Z1Tbk3J3kK9HumX1bTvphHRM9g
	 o88ldYXMp5ZkVIjo1vwJOqiI5oCV6ZtYgU02tyHzdy9LzghUbqstWYrWqxC7rQeY/j
	 68jhso09zMCVg==
From: Simon Horman <horms@kernel.org>
To: haiyangz@linux.microsoft.com
Cc: Simon Horman <horms@kernel.org>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	kees@kernel.org,
	leitao@debian.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	paulros@microsoft.com
Subject: Re: [PATCH net-next v3] net: mana: Add Interrupt Moderation support
Date: Sat, 13 Jun 2026 09:20:14 +0100
Message-ID: <20260613082014.715350-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611190239.2532429-1-haiyangz@linux.microsoft.com>
References: <20260611190239.2532429-1-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:horms@kernel.org,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:shradhagupta@linux.microsoft.com,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:kees@kernel.org,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11620-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3226A67E1CF

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Date:   Thu Jun 11 19:02:22 2026 +0000

    net: mana: Add Interrupt Moderation support
    
    This commit adds Static and Dynamic Interrupt Moderation (DIM) support for
    Rx and Tx. It updates the queue creation procedure, adds functions to
    collect stats for DIM, and provides ethtool handler support to get/set
    the moderation settings.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 26aef21c6c2c8..d92e022d8533c 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1579,6 +1579,9 @@ int mana_create_wq_obj(struct mana_port_context *apc,
>  
>  	mana_gd_init_req_hdr(&req.hdr, MANA_CREATE_WQ_OBJ,
>  			     sizeof(req), sizeof(resp));
> +
> +	req.hdr.req.msg_version = GDMA_MESSAGE_V3;
> +	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;
>  	req.vport = vport;
>  	req.wq_type = wq_type;
>  	req.wq_gdma_region = wq_spec->gdma_region;
> @@ -1587,6 +1590,9 @@ int mana_create_wq_obj(struct mana_port_context *apc,
>  	req.cq_size = cq_spec->queue_size;
>  	req.cq_moderation_ctx_id = cq_spec->modr_ctx_id;
>  	req.cq_parent_qid = cq_spec->attached_eq;
> +	req.req_cq_moderation = cq_spec->req_cq_moderation;
> +	req.cq_moderation_comp = cq_spec->cq_moderation_comp;
> +	req.cq_moderation_usec = cq_spec->cq_moderation_usec;

[Severity: High]
Does this break queue creation on older Azure host firmwares?

The code unconditionally bumps the WQ object creation request to use
GDMA_MESSAGE_V3 and passes the req_cq_moderation flag. If the firmware does
not support GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERATION, could the firmware
reject the queue creation request and break device initialization entirely?

[ ... ]

> +static void mana_update_tx_dim(struct mana_cq *cq)
> +{
> +	struct mana_port_context *apc = netdev_priv(cq->txq->ndev);
> +	struct dim_sample dim_sample = {};
> +	struct mana_txq *txq = cq->txq;
> +
> +	if (!apc->tx_dim_enabled)
> +		return;
> +
> +	dim_update_sample(READ_ONCE(cq->dim_event_ctr), txq->stats.packets,
> +			  txq->stats.bytes, &dim_sample);
> +	net_dim(&cq->dim, &dim_sample);
> +}

[Severity: High]
Does this measure the CPU enqueue rate rather than the hardware completion
rate?

It appears that txq->stats.packets is incremented in mana_start_xmit()
upon enqueue, not during completion in mana_poll_tx_cq(). Dynamic interrupt
moderation relies on measuring the actual hardware completion rate to
function correctly.

Additionally, is it safe to read txq->stats.packets here without the
u64_stats_fetch_begin() retry loop? Reading a 64-bit statistic locklessly
without the synchronization primitives could result in torn reads on 32-bit
systems.

[ ... ]

> @@ -2324,7 +2434,13 @@ static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
>  	if (w < cq->budget) {
>  		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
>  		cq->work_done_since_doorbell = 0;
> -		napi_complete_done(&cq->napi, w);
> +
> +		if (napi_complete_done(&cq->napi, w)) {
> +			if (cq->type == MANA_CQ_TYPE_RX)
> +				mana_update_rx_dim(cq);
> +			else
> +				mana_update_tx_dim(cq);
> +		}

[Severity: High]
Is it safe to call mana_update_rx_dim() and mana_update_tx_dim() after
napi_complete_done()?

Since napi_complete_done() ends the NAPI polling cycle and relinquishes
mutual exclusion, and the hardware interrupt was already re-armed by
mana_gd_ring_cq() right before this, couldn't a new packet trigger an
interrupt immediately? This could allow NAPI to be scheduled on another CPU
concurrently while this CPU is still running the DIM update, potentially
corrupting the non-thread-safe net_dim() state machine.

[ ... ]

> @@ -2562,6 +2685,9 @@ static int mana_create_txq(struct mana_port_context *apc,
>  		napi_enable_locked(&cq->napi);
>  		txq->napi_initialized = true;
>  
> +		INIT_WORK(&cq->dim.work, mana_tx_dim_work);
> +		cq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;

[Severity: High]
Could this allow NAPI to schedule an uninitialized work_struct?

napi_enable_locked() is called right before INIT_WORK(). Once NAPI is
enabled, it can be scheduled to run immediately (for example, via netpoll).
If NAPI executes before INIT_WORK completes, mana_update_tx_dim() would
pass the uninitialized cq->dim to net_dim(), which could cause a kernel
panic when it attempts to call schedule_work().

This pattern also occurs in mana_create_rxq().

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index 94e658d07a27e..67a2b282ff4da 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c

[ ... ]

> @@ -440,18 +474,123 @@ static int mana_set_coalesce(struct net_device *ndev,
> +		if (enable_rx_dim)
> +			apc->rx_dim_enabled = true;
> +		if (enable_tx_dim)
> +			apc->tx_dim_enabled = true;

[Severity: High]
Could the lack of memory barriers here expose uninitialized DIM structures
to NAPI?

The driver initializes DIM via mana_dim_change() and then sets
apc->rx_dim_enabled to true. Without an smp_store_release() here and a
corresponding smp_load_acquire() in mana_update_rx_dim(), weakly-ordered
CPUs like ARM64 might reorder the stores. Concurrently, NAPI polling might
observe the flag as true before the initialization is fully visible in memory,
potentially invoking net_dim() on garbage memory.

