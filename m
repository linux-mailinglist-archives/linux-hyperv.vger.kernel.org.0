Return-Path: <linux-hyperv+bounces-11389-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB8aHNkzGmp+2AgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11389-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 02:48:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C8760A575
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 02:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 594F8305297C
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 00:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D9223E324;
	Sat, 30 May 2026 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKa7mNQJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8465D29D27D;
	Sat, 30 May 2026 00:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102013; cv=none; b=mf3ijmT4m2FP1iSKlfc/ogfEIdnYmpDWeY74KfpvaND31Hq7ycBoDMxOfTgcla+gkrAnY1qpCxBFCbz6m10KmRHsdUih2xEEUjSpuqJFcHVYg8z5kBFMplUrvV0MGtSyszjaoqw9KmLjoPdqqCRgV3aYaGK79E+4AECapwaqFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102013; c=relaxed/simple;
	bh=nrtHY8bTzppKIagw49KWprbaZZYC8MjlyJkDW5cxa3Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kgdZLkf7rlBSuFGcWezvmUQjvy6FP3hQ3b8+ho/gaLsOiVHJQm2FxHpW34aNOv3P5uuH32QkJZvUVZBDAn3BgbsfZSe6ywCIP1ts5TWFw9UfLsN/6LL8K+vzaQnvHebmTc5udIKT4COyIqfrueLAcdyIpqwyNHXRTG3Z2dGvepo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKa7mNQJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8281F00893;
	Sat, 30 May 2026 00:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102012;
	bh=jtj/UeoVVsiy0f+lzoYFOjyjLdeKD++mqQAoqHJZGfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NKa7mNQJxVIpK0FmbLero9TsswmhTUk58Tmct0BNpaufSy30HxOsXn7CpIf4nbUhe
	 D9TG4v189odwpCsLY7DXX4j4jROTyEULisiasppHJYKpZ3+pOJOl7q9jXHzc2Y1Nkb
	 +e2/IUTZZUFdEvp91wfVpw0zvIRwOHM2bWP8QG0+4xIc6q5AWhkWCHl3bTC3IWdkbh
	 gwhmBCQYVci4W8BqItOrxzgwj2Cxv25xxVlSTEqk/Es7uZ/6oKzpPx/ReDMuOGGjpz
	 cgBTy6AfBy4WyNmGSqBs512QpcCMGJqydSUmaSTpzUpne5oIgXor13ChX7xgWyWVkG
	 uF4m2RdCvFKmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/2] net: mana: Add NULL guards in teardown path
 to prevent panic on attach failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260522233555.1099342-2-dipayanroy@linux.microsoft.com>
References: <20260522233555.1099342-2-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:46:51 +0000
Message-Id: <20260530004652.4E8281F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11389-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 58C8760A575
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] State Machine Violation / NULL Pointer Dereference on interface op=
en after a failed MTU change.
- [High] Uninitialized Resource Teardown / Invalid Hardware Request during =
TX queue creation failure.
--

commit effecc83d343cb89cadf93984f0a62ac828d0166
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: Add NULL guards in teardown path to prevent panic on attach fail=
ure

When queue allocation fails partway through, the error cleanup frees
and NULLs apc->tx_qp and apc->rxqs. Multiple teardown paths such as
mana_remove(), mana_change_mtu() recovery, and internal error handling
in mana_alloc_queues() can subsequently call into functions that
dereference these pointers without NULL checks.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 9afc786b297a8..9e7e4bf526bf6 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1727,6 +1727,9 @@ static void mana_fence_rqs(struct mana_port_context=
 *apc)
>  	struct mana_rxq *rxq;
>  	int err;
> =20
> +	if (!apc->rxqs)
> +		return;
> +

[Severity: High]
This isn't a bug introduced by this patch, but if mana_change_mtu() fails,
does it leave the device in a state where a subsequent mana_open() will cra=
sh?

When mana_change_mtu() calls mana_detach(ndev, false), the device is detach=
ed
and mana_cleanup_port_context() is explicitly called, freeing apc->rxqs and
setting it to NULL.

It then calls mana_attach(). If mana_attach() fails internally (e.g., inside
its call to mana_alloc_queues()), its error path calls
mana_cleanup_port_context() again, which frees apc->rxqs and sets it to NUL=
L.

mana_change_mtu() then returns the error.

The interface is now in the DOWN state (apc->port_is_up =3D=3D false) with
apc->rxqs =3D=3D NULL.

If the user subsequently attempts to bring the interface up (ip link set up=
),
mana_open() is executed. mana_open() calls mana_alloc_queues() but does not
call mana_init_port() to reallocate apc->rxqs.

Inside mana_alloc_queues(), mana_add_rx_queues() unconditionally dereferenc=
es
apc->rxqs:

    apc->rxqs[i] =3D rxq;

Could this result in a kernel panic?

[ ... ]

> @@ -3287,33 +3294,38 @@ static int mana_dealloc_queues(struct net_device =
*ndev)
>  	 * number of queues.
>  	 */
> =20
> -	for (i =3D 0; i < apc->num_queues; i++) {
> -		txq =3D &apc->tx_qp[i].txq;
> -		tsleep =3D 1000;
> -		while (atomic_read(&txq->pending_sends) > 0 &&
> -		       time_before(jiffies, timeout)) {
> -			usleep_range(tsleep, tsleep + 1000);
> -			tsleep <<=3D 1;
> -		}
> -		if (atomic_read(&txq->pending_sends)) {
> -			err =3D pcie_flr(to_pci_dev(gd->gdma_context->dev));
> -			if (err) {
> -				netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
> -					   err, atomic_read(&txq->pending_sends),
> -					   txq->gdma_txq_id);
> +	if (apc->tx_qp) {
> +		for (i =3D 0; i < apc->num_queues; i++) {
> +			txq =3D &apc->tx_qp[i].txq;
> +			tsleep =3D 1000;
> +			while (atomic_read(&txq->pending_sends) > 0 &&
> +			       time_before(jiffies, timeout)) {
> +				usleep_range(tsleep, tsleep + 1000);
> +				tsleep <<=3D 1;
> +			}

[Severity: High]
This is a pre-existing issue, but does mana_destroy_txq() send invalid hand=
les
to the hardware when TX queue creation fails?

In mana_create_txq(), the apc->tx_qp array is allocated via kzalloc_objs(),
meaning all elements (including tx_object) are initialized to 0.

The function then loops over num_queues. For the current queue i, it sets
apc->tx_qp[i].tx_object =3D INVALID_MANA_HANDLE; before attempting to creat=
e the
hardware object via mana_create_wq_obj().

If creation fails, it jumps to the out label and calls mana_destroy_txq(apc=
).
mana_destroy_txq() unconditionally loops over all num_queues and calls:

    mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);

Unlike mana_destroy_rxq(), which checks if (rxq->rxobj !=3D INVALID_MANA_HA=
NDLE),
mana_destroy_txq() passes the handle directly to mana_destroy_wq_obj().

For the failed queue, the handle is INVALID_MANA_HANDLE. For all unreached
queues (j > i), the handle is 0.

Could this cause mana_destroy_wq_obj() to send invalid handles (including 0,
which might be a valid handle for an unrelated object) to the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522233555.1099=
342-1-dipayanroy@linux.microsoft.com?part=3D1

