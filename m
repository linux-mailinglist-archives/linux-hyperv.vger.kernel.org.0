Return-Path: <linux-hyperv+bounces-11617-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nTiOD/tXLGq0PgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-11617-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 21:03:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE4167BE7C
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 21:03:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LQjaZJCP;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11617-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11617-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A141D30A552B
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 19:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1936AB54;
	Fri, 12 Jun 2026 19:03:20 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7400367290
	for <linux-hyperv@vger.kernel.org>; Fri, 12 Jun 2026 19:03:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291000; cv=none; b=CWdcRK7ASM+3KRhWOBsBss0Ddo9VLimXLtbNh7/bovrudc6hvKP3opBVSvxg3igxRxaBzUussXf8gSeg+RAj3yIYoRdvnM+2DYi2l6bJz9M80sx9SBASBdr36yre3ScLEgGB2WpY6S7llYuTOvjZUIHNrHnM6s7y7lbSMhCQt6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291000; c=relaxed/simple;
	bh=oJZy5f39rilTR8mdWeZvla1FQL0wSwV1ow2Nw/ccr1s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O752nr4+dpBkf/j6vmKhLbI+XlzA+1e3GJMtH/Qy+wbHp3y+eH4wNKonD/6fVknCPm0foxcCDCBUdjtjp6+gCPRV5V44OI3UZRI6EI/1fmxS97zh6RDuSTzYtTh7wPAqJ24altYK47ZnhpN0k5pBXiIQflDLa6bIKdzTBl7vopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQjaZJCP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4201F000E9;
	Fri, 12 Jun 2026 19:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781290998;
	bh=wh+6dEr5VHqaVcAHcynF3ttAnUowuj2GOsdF1PDyaec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LQjaZJCPUgJQaNcozjmJ/gdgc0zw2qWW9RoROgMi1ohP8PatJhGNQ3v4NsnKDgDtE
	 4aj8/RCmscpNDBTvhIkA30mYhBTPLwPMeGR1bfCtENGkDFCKc4T+AGWDhSRdYspHgZ
	 VbKYN3/wnUnO6/GhlJGckILYOFbtgm8qr1rD788IqCPooG7iVGkwDiT8dOwMDAIFQ4
	 mcF80XbRkBhbCLbQBAe1WlFIxTL9mMNZo2vxF+eJ+MP4NeshmSYznkPoxwxiGAR5ox
	 M5ke+Mst3/pDuRfNIiSptx9rwZraBGVY3epC7jgHDXe9egq1JbPr9zeglZUy/A2Bpk
	 ELTt+QoPhjIeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3] net: mana: Add Interrupt Moderation support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haiyang Zhang" <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260611190239.2532429-1-haiyangz@linux.microsoft.com>
References: <20260611190239.2532429-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 19:03:17 +0000
Message-Id: <20260612190318.4C4201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11617-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EE4167BE7C

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Calling `mana_update_rx_dim` and `mana_update_tx_dim` after `napi_=
complete_done` violates NAPI serialization, leading to data races and corru=
ption of the `net_dim` state.
- [High] Unconditional use of the `GDMA_MESSAGE_V3` format and `req_cq_mode=
ration` flag breaks WQ object creation on older MANA firmwares.
- [High] NAPI is enabled before the DIM work struct is initialized, allowin=
g NAPI to run on an uninitialized work struct.
- [High] Lockless access to the DIM enable flags lacks memory barriers, pot=
entially exposing uninitialized DIM structures to NAPI.
- [High] TX DIM incorrectly uses enqueued packets instead of completed pack=
ets, and reads concurrent stats unsafely.
--

commit 275fa81625ff24a83b95ff846fea9070fb3193d8
Author: Haiyang Zhang <haiyangz@microsoft.com>
Date:   Thu Jun 11 19:02:22 2026 +0000

    net: mana: Add Interrupt Moderation support
   =20
    This commit adds Static and Dynamic Interrupt Moderation (DIM) support =
for
    Rx and Tx. It updates the queue creation procedure, adds functions to
    collect stats for DIM, and provides ethtool handler support to get/set
    the moderation settings.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 26aef21c6c2c8..d92e022d8533c 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1579,6 +1579,9 @@ int mana_create_wq_obj(struct mana_port_context *ap=
c,
> =20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_CREATE_WQ_OBJ,
>  			     sizeof(req), sizeof(resp));
> +
> +	req.hdr.req.msg_version =3D GDMA_MESSAGE_V3;
> +	req.hdr.resp.msg_version =3D GDMA_MESSAGE_V2;
>  	req.vport =3D vport;
>  	req.wq_type =3D wq_type;
>  	req.wq_gdma_region =3D wq_spec->gdma_region;
> @@ -1587,6 +1590,9 @@ int mana_create_wq_obj(struct mana_port_context *ap=
c,
>  	req.cq_size =3D cq_spec->queue_size;
>  	req.cq_moderation_ctx_id =3D cq_spec->modr_ctx_id;
>  	req.cq_parent_qid =3D cq_spec->attached_eq;
> +	req.req_cq_moderation =3D cq_spec->req_cq_moderation;
> +	req.cq_moderation_comp =3D cq_spec->cq_moderation_comp;
> +	req.cq_moderation_usec =3D cq_spec->cq_moderation_usec;

[Severity: High]
Does this break queue creation on older Azure host firmwares?

The code unconditionally bumps the WQ object creation request to use
GDMA_MESSAGE_V3 and passes the req_cq_moderation flag. If the firmware does
not support GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERATION, could the firmware
reject the queue creation request and break device initialization entirely?

[ ... ]

> +static void mana_update_tx_dim(struct mana_cq *cq)
> +{
> +	struct mana_port_context *apc =3D netdev_priv(cq->txq->ndev);
> +	struct dim_sample dim_sample =3D {};
> +	struct mana_txq *txq =3D cq->txq;
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

> @@ -2324,7 +2434,13 @@ static int mana_cq_handler(void *context, struct g=
dma_queue *gdma_queue)
>  	if (w < cq->budget) {
>  		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
>  		cq->work_done_since_doorbell =3D 0;
> -		napi_complete_done(&cq->napi, w);
> +
> +		if (napi_complete_done(&cq->napi, w)) {
> +			if (cq->type =3D=3D MANA_CQ_TYPE_RX)
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

> @@ -2562,6 +2685,9 @@ static int mana_create_txq(struct mana_port_context=
 *apc,
>  		napi_enable_locked(&cq->napi);
>  		txq->napi_initialized =3D true;
> =20
> +		INIT_WORK(&cq->dim.work, mana_tx_dim_work);
> +		cq->dim.mode =3D DIM_CQ_PERIOD_MODE_START_FROM_EQE;

[Severity: High]
Could this allow NAPI to schedule an uninitialized work_struct?

napi_enable_locked() is called right before INIT_WORK(). Once NAPI is
enabled, it can be scheduled to run immediately (for example, via netpoll).
If NAPI executes before INIT_WORK completes, mana_update_tx_dim() would
pass the uninitialized cq->dim to net_dim(), which could cause a kernel
panic when it attempts to call schedule_work().

This pattern also occurs in mana_create_rxq().

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index 94e658d07a27e..67a2b282ff4da 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c

[ ... ]

> @@ -440,18 +474,123 @@ static int mana_set_coalesce(struct net_device *nd=
ev,
> +		if (enable_rx_dim)
> +			apc->rx_dim_enabled =3D true;
> +		if (enable_tx_dim)
> +			apc->tx_dim_enabled =3D true;

[Severity: High]
Could the lack of memory barriers here expose uninitialized DIM structures
to NAPI?

The driver initializes DIM via mana_dim_change() and then sets
apc->rx_dim_enabled to true. Without an smp_store_release() here and a
corresponding smp_load_acquire() in mana_update_rx_dim(), weakly-ordered
CPUs like ARM64 might reorder the stores. Concurrently, NAPI polling might
observe the flag as true before the initialization is fully visible in memo=
ry,
potentially invoking net_dim() on garbage memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611190239.2532=
429-1-haiyangz@linux.microsoft.com?part=3D1

