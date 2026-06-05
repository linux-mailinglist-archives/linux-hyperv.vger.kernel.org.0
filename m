Return-Path: <linux-hyperv+bounces-11516-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rfrkC2pfI2odrgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11516-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Jun 2026 01:44:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A661364BD89
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Jun 2026 01:44:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=D+6sG7Id;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11516-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11516-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6A25303AF1D
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2026 23:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2053F8EC3;
	Fri,  5 Jun 2026 23:43:21 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F63D333B
	for <linux-hyperv@vger.kernel.org>; Fri,  5 Jun 2026 23:43:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703001; cv=none; b=Cq2+pwR/ofKjmYDrvzTO6waT6AOoSuVObkLWDKBxw8ZDVVIWuCIjdN5o9XOXV91db+6rH5EVlyMyWiO4V4/+8GGK3xzG+y0v6AWbm4drInKki9LaQSdMjSSU3xKgmDhJsn0HHJ9MUhS5iKwAsDGX0izGL05fBXhwc25Y5qVTzJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703001; c=relaxed/simple;
	bh=0dcbpl/loKcDtOyGYEdulNrUdgVrx8UaI/rtzsBDwKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a/3icxfb+DRISMTdDS7r38X4tr766/JlIRmemZcPlEGhGY/A0ATyV6Mt1RRLzj6JIiN4LLrEONrdyDLv6OFyWKocJyfL1qS5+4zXIJ0Fi+L0x4p8h6ngz/KUOBwgysMo/7eWpJ5qwfsk5P1UcDDCSCNfdgzT/jtVTKIGDzTj3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+6sG7Id; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38551F00898;
	Fri,  5 Jun 2026 23:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702999;
	bh=5aG5Bt/mdKMqfvtE26OayHgLIfK/57AbXFVn4NtAcJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D+6sG7IdvBXLsihFIwSRAe0CZrD8Nm4uJKYNbXXg67zH1God2R7FjrkbROy5sx7Dy
	 07z1z9V9/T1FModXGqnahJfcixJNVh/loutEg+cN9Ok0Ev/ZP0byQB7f+G8U+mZfu8
	 qSJJevf3X89mehjRlqosVjDK7DXVKASwhaLtlrnuZeqI/Wa0pAQENMHzjxe+0nqQzd
	 sZv/d928GgQO+zf6NUPeg8EGaxjbRpOyCgIW1UwAknkmauZzSpbZaqDqZhOPKh2kUJ
	 nlq9Uz0UpQjNHZv80uKgGYYxOoD994yDQ6R66//U7HI7GKmAgbPjtOH4bK3FBNDf1g
	 4SvxI5zjJ/P4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Add Interrupt Moderation support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haiyang Zhang" <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260604234211.2056341-1-haiyangz@linux.microsoft.com>
References: <20260604234211.2056341-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 23:43:19 +0000
Message-Id: <20260605234319.D38551F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11516-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A661364BD89

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Use-after-free and workqueue corruption due to a race between NAPI=
 polling and interface teardown.
- [High] Unconditional use of GDMA_MESSAGE_V3 breaks backward compatibility=
 with older firmware.
- [Medium] Static interrupt moderation is silently disabled if only one par=
ameter is configured.
--

commit ec13708996b121633f56552fac3f0ceba004bf71
Author: Haiyang Zhang <haiyangz@microsoft.com>

net: mana: Add Interrupt Moderation support

This commit adds Static and Dynamic Interrupt Moderation (DIM) support for =
Rx
and Tx. It updates the queue creation procedure with new data structures and
settings, adds statistics collection functions for DIM, and introduces work=
ers
to update DIM settings. It also hooks into ethtool to allow configuration.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index db14357d3732e..b1e0c444f4144 100644
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
>  	req.vport =3D vport;

[Severity: High]
Will this break initialization on older firmware? We unconditionally set
msg_version to GDMA_MESSAGE_V3 here without checking if the hardware actual=
ly
supports it.

If an older Azure host without the GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERAT=
ION
capability rejects the V3 request, could this cause queue creation to fail
and result in a complete loss of network connectivity?

[ ... ]
> @@ -2274,7 +2344,13 @@ static int mana_cq_handler(void *context, struct g=
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
Is there a race condition here during teardown? If napi_complete_done()
clears the scheduling state, a concurrent teardown thread in
mana_destroy_rxq() can return from napi_disable_locked() and proceed to call
cancel_work_sync().

Because mana_update_rx_dim() hasn't been called yet to schedule the work,
cancel_work_sync() would return immediately and the queue memory would be
freed. When the NAPI thread resumes and calls mana_update_rx_dim(), could
this lead to a use-after-free or corruption of the workqueue linked list
by scheduling work on freed memory?

[ ... ]
> @@ -2783,6 +2869,10 @@ static struct mana_rxq *mana_create_rxq(struct man=
a_port_context *apc,
>  	cq_spec.queue_size =3D cq->gdma_cq->queue_size;
>  	cq_spec.modr_ctx_id =3D 0;
>  	cq_spec.attached_eq =3D cq->gdma_cq->cq.parent->id;
> +	cq_spec.req_cq_moderation =3D apc->rx_dim_enabled ||
> +		(apc->intr_modr_rx_usec && apc->intr_modr_rx_comp);
> +	cq_spec.cq_moderation_usec =3D apc->intr_modr_rx_usec;
> +	cq_spec.cq_moderation_comp =3D apc->intr_modr_rx_comp;

[Severity: Medium]
Does this logic unintentionally ignore user configurations where only one
parameter is non-zero?=20

In mana_set_coalesce(), ethtool allows setting rx-usecs without setting
rx-frames. If a user sets only time-based moderation (e.g., rx-usecs 50,
rx-frames 0), the condition here evaluates to false and silently disables
static moderation without returning an error via ethtool.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604234211.2056=
341-1-haiyangz@linux.microsoft.com?part=3D1

