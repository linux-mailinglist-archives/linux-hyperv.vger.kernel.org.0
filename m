Return-Path: <linux-hyperv+bounces-11391-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OLvMh01GmoG2QgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11391-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 02:53:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A12960A789
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 02:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10F6F30683D5
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 00:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DEC257851;
	Sat, 30 May 2026 00:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1OaMLOB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B91D54FA;
	Sat, 30 May 2026 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102061; cv=none; b=Dx0Lf0rpVwaF4TbgopV6g2EoQkPw3QEfh4XF/WeOBEBhzyaTJwCmSUNnTks8nWTpuTW5+PS6x5yv28OlGFxQTW4dz0aCsHz+M5tiwh+mghVONguKm8TAHPUivQDM5KO93yLnAS3nEBVJvJViX26NkLr4K7cG94qvemIEahBtVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102061; c=relaxed/simple;
	bh=GIUA1ZJcerl9EtPkjTk4vWZw5c5jI3IWktjzJxZgVWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X5JeRK2cBVUrVbXFhqqEx03268S4w41Ysp5+R6pHkK43GTblbFiidNVp7XRw7j1n/+Z5TtLGZQSPnkCO6aibjY8mPeXLMBxt6260Ljr5dUWBj0wfUHDsmDY6e7PIXylZWuw0Fl0RVitd6a1ZvcAK4lr3TO0FZRtCdcHy4dWTS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1OaMLOB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BAF1F00893;
	Sat, 30 May 2026 00:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102060;
	bh=1uBYplieCwbqrYFRWgZNoc7fVVv82PXPE5XdR8AY8wc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T1OaMLOBDRV9ku0c8FedViOKid0RXwfXL2nwy8W1WN+hDSydgdKdM2AtoHR/VTsYh
	 MQFsSIFmS9UrKKrdQWtCsod+KJr57aF7+Fn7589Njaw8NVHxg3zmYcSwS0WBZR/m4K
	 iPpv4nhp4Agv4Pozb92dC78bVkpoQsbN7gj9RdIc0pKt5Laxchp59UdTSNz1kaqSCw
	 6zI1Fnq1/8kY/uiis/xw14wfIa8k9Q2thXPUH14HM6QV2XVxBFrckA24YHkgNPG0ij
	 evDpX757py62+FM4ySrE7ymOs582XyTWFvzjm8E5Xxso5ryAu6FRf0c2jxsIUBCn/x
	 KnIhewwA+hMTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/2] net: mana: Add NULL guards in teardown path
 to prevent panic on attach failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260525081129.1230035-2-dipayanroy@linux.microsoft.com>
References: <20260525081129.1230035-2-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:47:40 +0000
Message-Id: <20260530004740.B2BAF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11391-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 4A12960A789
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] mana_add_rx_queues() writes to a freed apc->rxqs pointer on succes=
s path after an error.
- [Medium] mana_destroy_txq() attempts to destroy uninitialized WQ objects.
--

commit f9a2821b4cd7ff0d58042e4bdeeb3d484c4946cf
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: Add NULL guards in teardown path to prevent panic on attach fail=
ure

This patch adds NULL guards for apc->rxqs and apc->tx_qp in multiple teardo=
wn
paths, such as mana_fence_rqs(), mana_destroy_vport(), and
mana_dealloc_queues(), to prevent NULL pointer dereference panics when queue
allocation fails.

> When queue allocation fails partway through, the error cleanup frees
> and NULLs apc->tx_qp and apc->rxqs. Multiple teardown paths such as
> mana_remove(), mana_change_mtu() recovery, and internal error handling
> in mana_alloc_queues() can subsequently call into functions that
> dereference these pointers without NULL checks:

[Severity: High]
This is a pre-existing issue, but could a subsequent interface bring-up
cause a panic due to the NULL apc->rxqs pointer?

If mana_attach() fails (e.g., during mana_change_mtu() recovery), the error
path calls mana_cleanup_port_context(apc), which frees apc->rxqs and sets it
to NULL, leaving the interface in a down state.

If the interface is subsequently brought back up, mana_open() is invoked.
mana_open() calls mana_alloc_queues() directly, skipping
mana_init_port_context() where apc->rxqs is normally allocated.

When mana_alloc_queues() reaches mana_add_rx_queues(), it executes:

mana_add_rx_queues()
    apc->rxqs[i] =3D rxq;

Would this write to the freed apc->rxqs pointer and cause a kernel panic?

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 9afc786b297a8..9e7e4bf526bf6 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -2858,13 +2861,16 @@ static void mana_destroy_vport(struct mana_port_c=
ontext *apc)
>  	struct mana_rxq *rxq;
>  	u32 rxq_idx;
> =20
> -	for (rxq_idx =3D 0; rxq_idx < apc->num_queues; rxq_idx++) {
> -		rxq =3D apc->rxqs[rxq_idx];
> -		if (!rxq)
> -			continue;
> +	if (apc->rxqs) {
> =20
> -		mana_destroy_rxq(apc, rxq, true);
> -		apc->rxqs[rxq_idx] =3D NULL;
> +		for (rxq_idx =3D 0; rxq_idx < apc->num_queues; rxq_idx++) {
> +			rxq =3D apc->rxqs[rxq_idx];
> +			if (!rxq)
> +				continue;
> +
> +			mana_destroy_rxq(apc, rxq, true);
> +			apc->rxqs[rxq_idx] =3D NULL;
> +		}
>  	}
> =20
>  	mana_destroy_txq(apc);

[Severity: Medium]
This is a pre-existing issue, but does mana_destroy_txq() send invalid
teardown requests to the hardware if mana_create_txq() failed partway
through?

Unlike mana_destroy_rxq(), which explicitly checks if rxq->rxobj is valid
(rxq->rxobj !=3D INVALID_MANA_HANDLE) before destroying it, mana_destroy_tx=
q()
unconditionally loops over all num_queues and calls:

mana_destroy_txq()
    mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);

For queues that were not initialized, the tx_object handle is 0 because the
memory was zeroed by allocation, rather than being set to
INVALID_MANA_HANDLE.

Does this result in blindly sending a MANA_DESTROY_WQ_OBJ hardware request
with wq_obj_handle =3D 0 for the uninitialized queues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525081129.1230=
035-1-dipayanroy@linux.microsoft.com?part=3D1

