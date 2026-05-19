Return-Path: <linux-hyperv+bounces-11031-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHyvBq2/DGqJlgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11031-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 21:53:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676A45845A3
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 21:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 015E33057885
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 19:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6852D39C64E;
	Tue, 19 May 2026 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0OXHz8z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2417138BF7A;
	Tue, 19 May 2026 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220070; cv=none; b=WVP6Her7bZn+Snh0i9xkM9vufgdR7ykhSiKKQSEesKv6jlWB3HFAtd1f6MaeYCVhXZr57+GX7+a3N9EaX5xMFeh6dN5XBefUEs7IrGgtL2oTLH+/+c+HT1QzRIdLG0ZSpvYdZZ30LaIS4tSfKSi9+3oGO7qmTExJ7VJiiQjuin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220070; c=relaxed/simple;
	bh=BSrPY4gPw17spkBwS0rZBvox/62Gih28VXdmdz/KqIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lflvNfy85FujDsQmREESqIdeBsJYEnXT7IYN3MwOdo4bwxS6LRNXLi5lKwDBLZ02P3psOIsAemVcUWZ33/NlaHy6wy2odi27k78KUm6Zlti4rrzqHWEAWi109H09ca9o9DtqWRJByagRGONvVYchVJ564uhsyoTCCf95aXPhBpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0OXHz8z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779301F000E9;
	Tue, 19 May 2026 19:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779220068;
	bh=ffiK6usqIvshLSQEFoM0C2CbZc8vGcx9ALJwGKofBxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g0OXHz8z+fQLCq5kc454EJwxswIjH+/79/a2ynD7KtWKHK6Sr2lfKIZ5HGtQnW4u3
	 1nKuer11qiuRO3C+nySRDIuLGed6huK15TnqBq/YT5OGiVg8d41JS3Zlwnz5E1AjsP
	 cWLHMCyA42MfRZRrCdBEXwKSrZm9qC+Vh50gb08zOcbKPsVlCFiCH9KnCUxcKa79TO
	 muaVBuCcj06WnuakFTrT3UDUTyXHegOxN1V/UE1eFAhjS6tdp0II/hs5NQYWX/1zhF
	 hhJ2WhN+Awp7CKk/rfMoFVgDibn4FTyEGCk24FYZtf8lsUeFXQOz0bMf0WRgZaBAdR
	 Al+X+dBlFlEbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net: mana: Add NULL guards in teardown path to
 prevent panic on attach failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260518194654.735580-2-dipayanroy@linux.microsoft.com>
References: <20260518194654.735580-2-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 19:47:47 +0000
Message-Id: <20260519194748.779301F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11031-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Queue-Id: 676A45845A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing re-allocation of `apc->rxqs` during interface bring-up cau=
ses deterministic NULL pointer dereference
- [High] Uninitialized queue handles (0 and INVALID_MANA_HANDLE) are sent t=
o the firmware during error teardown, corrupting hardware state
- [High] GDMA admin commands are issued immediately after a PCI Function Le=
vel Reset (FLR), causing severe cascading timeouts and hardware state viola=
tions
--

commit 2129283d37aabfe724d7509e34346eab93d302a2
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: Add NULL guards in teardown path to prevent panic on attach fail=
ure
   =20
When queue allocation fails partway through, the error cleanup frees
and NULLs apc->tx_qp and apc->rxqs. The patch adds NULL guards for these
pointers in teardown paths such as mana_destroy_vport(), mana_fence_rqs(),
and mana_dealloc_queues() to prevent NULL pointer dereferences.

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

If the teardown path frees apc->rxqs and sets it to NULL on attach failure,
how does the interface recover if the user subsequently brings it back up?

When mana_open() is invoked, it directly calls mana_alloc_queues(). Inside
mana_alloc_queues() -> mana_add_rx_queues(), the code does:

    apc->rxqs[i] =3D rxq;

If apc->rxqs was left as NULL during the teardown, will this cause a NULL
pointer dereference on the next interface bring-up?

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

In the error path where queue creation fails partway through, will
mana_destroy_txq() be called?

If mana_destroy_txq() unconditionally iterates over all apc->num_queues:

    for (i =3D 0; i < apc->num_queues; i++) {
        ...
        mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
        ...

Will it pass 0 or INVALID_MANA_HANDLE to mana_destroy_wq_obj() for queues
that were never fully initialized?

Does mana_destroy_wq_obj() send a MANA_DESTROY_WQ_OBJ command to the hardwa=
re
with these uninitialized handles, and could handle 0 corrupt the firmware
state?

> +		for (i =3D 0; i < apc->num_queues; i++) {
> +			txq =3D &apc->tx_qp[i].txq;
> +			tsleep =3D 1000;
> +			while (atomic_read(&txq->pending_sends) > 0 &&
> +			       time_before(jiffies, timeout)) {
> +				usleep_range(tsleep, tsleep + 1000);
> +				tsleep <<=3D 1;
> +			}
> +			if (atomic_read(&txq->pending_sends)) {
> +				err =3D
> +				    pcie_flr(to_pci_dev(gd->gdma_context->dev));

If pcie_flr() is triggered here, the PCI Function Level Reset wipes the
internal GDMA state.

Further down in this function, mana_disable_vport_rx(), mana_fence_rqs(),
and mana_destroy_vport() are called. Will these functions attempt to send
commands to the now-destroyed GDMA admin queue via mana_send_request() and
wait for completions?

Could this lead to cascading timeouts since the hardware was just reset and
cannot process admin commands?

> +				if (err) {
> +					netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
> +						   err,
> +					    atomic_read(&txq->pending_sends),
> +					    txq->gdma_txq_id);
> +				}
> +				break;
>  			}
> -			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518194654.7355=
80-1-dipayanroy@linux.microsoft.com?part=3D1

