Return-Path: <linux-hyperv+bounces-11417-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCbwApWSHGpdPQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11417-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 May 2026 21:57:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F82617C84
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 May 2026 21:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B430300229C
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 May 2026 19:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388403033EA;
	Sun, 31 May 2026 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuwATMbl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B121ADC7
	for <linux-hyperv@vger.kernel.org>; Sun, 31 May 2026 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257086; cv=none; b=nVi6eIA+51VBFunmfV3GML8YLES2/kT64Uz/v8tDUroiIYQWT/VRPlhfAmewph+LFc2mRNbkhwKzRZcZZfpX3FiicQGH+wfBBdYEG2Q1W9Age0a2/Y8QXVW8tznlg39H93p8f5br5RtRQh/DUJotE7miXz0teIjmWCD60wWON7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257086; c=relaxed/simple;
	bh=Sd5HPj8rIdm8/0zq33UmmS0ovKWIyIvX+BKk/ZXA9Zc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yap5T5hOOelFBvU0g4Gm949yj7392fGvjFF1rXOzV+HwsKjUULGIJzXE+cWcbkoNRJsmWuN7qpk8oWb9VktBspXyu66DodJ0v4n5mLmQPxWskWqLb1Y76LijSam68EvmflfBiWuFx2J6WbOEAHDo/MS4qAU7puP/T72goHrMaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuwATMbl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1641F00893;
	Sun, 31 May 2026 19:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780257084;
	bh=Xyej+ZojtR5z/Pq1pFKou/3kmTn7/FHvEplhZExRoU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GuwATMbl3h3WTafbu9wZNGLTB/cWqhHyRHssHYkxkwQQq2ADusVkbU+kHaCT9lHRA
	 JmHnvWq4+5SFaYvYMmH4YLqxHGM3RXL87R6aiV3gXsgWEpbDGUoz938bhbRzWKRAPc
	 VlXA2bDuz/rGHzfag99EzkgJXI1w4GMKVwxkq2lxvorknTLLgwkRTuiLhLiu2vdvlO
	 gUnkA86Fz3WpU5ZNA+lwc0mpI+NtHAOc7HAnFtsehT7l4yV12CdkbAcYC1LiNnIiTe
	 A9jqqRtoIDmvGC+4t6pkyDPzeFlOn7KrDqFlf1fJF3iJqHtetqUXNGRCNs4sO1Nq+t
	 H9wEGwstpEoUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net: mana: Add Interrupt Moderation support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haiyang Zhang" <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260530194957.1690459-1-haiyangz@linux.microsoft.com>
References: <20260530194957.1690459-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 19:51:24 +0000
Message-Id: <20260531195124.8B1641F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11417-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 66F82617C84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Static CQ moderation is silently disabled if only one parameter is=
 configured.
- [High] Unconditional use of `GDMA_MESSAGE_V3` may break queue creation on=
 older firmware.
- [High] Data race in DIM updates due to calling net_dim() after napi_compl=
ete_done().

Pre-existing issues:
- [High] ethtool coalesce change can leave the interface permanently detach=
ed/down on failure.
--

commit ed18c14aae7553debe324941814e80fe58d99fe0
Author: Haiyang Zhang <haiyangz@microsoft.com>

net: mana: Add Interrupt Moderation support

Add Static and Dynamic Interrupt Moderation (DIM) support for Rx and Tx.
Update queue creation procedure with new data struct with the related
settings. Update ethtool handler to get/set the moderation settings.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1551,6 +1551,9 @@ int mana_create_wq_obj(struct mana_port_context *ap=
c,
> =20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_CREATE_WQ_OBJ,
>  			     sizeof(req), sizeof(resp));
> +
> +	req.hdr.req.msg_version =3D GDMA_MESSAGE_V3;
> +	req.hdr.resp.msg_version =3D GDMA_MESSAGE_V2;

[Severity: High]
Could this unconditional upgrade to GDMA_MESSAGE_V3 break queue creation on
older firmware?

If the driver is loaded on an older host where the hardware firmware does
not support V3 messages (for example, lacking DIM capabilities), it seems
the hardware might reject the MANA_CREATE_WQ_OBJ request. Would it be
safer to conditionally apply this message version upgrade based on hardware
capabilities?

[ ... ]

> @@ -2271,7 +2337,13 @@ static int mana_cq_handler(void *context, struct g=
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
Does calling net_dim() after napi_complete_done() introduce a data race?

Since napi_complete_done() clears the NAPI_STATE_SCHED bit and
relinquishes the NAPI polling context, and the hardware interrupt
was already armed via mana_gd_ring_cq() just above, a new interrupt
could fire immediately.

If another CPU schedules NAPI and executes mana_cq_handler() concurrently,
it seems internal state in net_dim() could be corrupted. Additionally,
could this lead to torn reads of 64-bit queue statistics on 32-bit systems
since they are read outside NAPI protection?

[ ... ]

> @@ -2780,6 +2862,10 @@ static struct mana_rxq *mana_create_rxq(struct man=
a_port_context *apc,
>  	cq_spec.queue_size =3D cq->gdma_cq->queue_size;
>  	cq_spec.modr_ctx_id =3D 0;
>  	cq_spec.attached_eq =3D cq->gdma_cq->cq.parent->id;
> +	cq_spec.req_cq_moderation =3D apc->rx_dim_enabled ||
> +		(apc->intr_modr_rx_usec && apc->intr_modr_rx_comp);
> +	cq_spec.cq_moderation_usec =3D apc->intr_modr_rx_usec;
> +	cq_spec.cq_moderation_comp =3D apc->intr_modr_rx_comp;

[Severity: High]
Does this logic silently disable static moderation if only one parameter is
configured?

If a user disables adaptive moderation and requests timer-based moderation
without a frame limit (e.g. adaptive-rx off rx-usecs 50 rx-frames 0), the
logical AND evaluates to false. This appears to cause the driver to silently
disable hardware moderation completely instead of applying the requested
rx-usecs.

(Note: The same pattern appears in mana_create_txq() for TX).

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
[ ... ]
> @@ -447,10 +517,46 @@ static int mana_set_coalesce(struct net_device *nde=
v,
[ ... ]
> +	if (modr_changed || dim_changed) {
> +		err =3D mana_detach(ndev, false);
> +		if (err) {
> +			netdev_err(ndev, "mana_detach failed: %d\n", err);
> +			goto restore_modr;
> +		}
> +
> +		err =3D mana_attach(ndev);
> +		if (err) {
> +			netdev_err(ndev, "mana_attach failed: %d\n", err);
> +			goto restore_modr;
> +		}
> +	}
> +
>  	return err;
> =20
> +restore_modr:
> +	apc->cqe_coalescing_enable =3D saved_cqe_coalescing_enable;

[Severity: High]
This is a pre-existing issue, but does this error path leave the interface
permanently detached?

If mana_detach() succeeds but mana_attach() fails (for example, due to an
allocation failure), the function jumps to restore_modr. This restores the
software tracking variables but does not appear to revert the hardware stat=
e.

This could leave the network interface completely broken and detached from
the system until it is manually brought down and up again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530194957.1690=
459-1-haiyangz@linux.microsoft.com?part=3D1

