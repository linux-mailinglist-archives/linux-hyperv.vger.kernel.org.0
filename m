Return-Path: <linux-hyperv+bounces-11950-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nDMaOrwUU2opWwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11950-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Jul 2026 06:14:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3C1743CA1
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Jul 2026 06:14:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j4KoRsgW;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11950-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11950-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDFC73010C02
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Jul 2026 04:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61813344DA8;
	Sun, 12 Jul 2026 04:14:50 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6551136B07E;
	Sun, 12 Jul 2026 04:14:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783829690; cv=none; b=n5/Octope7+AHvASR6OXAdtrHwc3gIUmeWqZ4KWId++0diqXdvX4sKj4X25NNmmYToTo9TQHmJ2oDk/GJkFlsQ1WjaU104ANkiOHKWIdSDK+p8SR23tY+nLkR3ypy2gLKj0xrXGv+6L+YOHHAMFcNEDBRGGDh/27a0oMuGRlCyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783829690; c=relaxed/simple;
	bh=zBSuTEFzP1tjQ/YlsgGUyutJDxOlPFTdE39mChiY00g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hTMJHkpaK0JJAt5mQVlD2TLsNgZhaYDvpi3k3OPqH2GTXLkbznx3MS+v+T4yT6ZT0ogiV+gYmg5QdOD7kjIfynJgnUjetby+Gky6iOcKk5S/QsZ8Q12A1egJn4za2TkHoYRGJwlDB78ihW6em+PfLrP56t6WDcEndZyXRI+71qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4KoRsgW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFA11F000E9;
	Sun, 12 Jul 2026 04:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783829686;
	bh=0beB9FTE6AsHHZPMwCfAeoWLuIPZ/smIntjOL3WBscs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j4KoRsgWkVhiA+CuoYCwZHOx0UIZ5xJMtTeCi+0ur7BFEhhDoZPVN30u06Ja26PXb
	 5GGmwtHpNr9OtzaxVQAGhow8ifwSpwDsISdvMJSwfEaaCoJhEdtH9bnV3Ccsppy2M2
	 RPR5QWzuYPH/BU6Jd+kV/CCXhZR8oAjYU/DS0PJNTfcXrHAcqecAh7wBnKj3G0gule
	 8XaPeOLZxQgck8E+ymG9p6l2Dh1gLSV3FRnZ1BwoP4r1m7d/YRalOuHbVXDM8K9M2L
	 wk894Nj4gbV2Fhxe4rqu7CLwoW28iOXpDzZ5+q8KbJSGgBlqiW2NRnlpzH7B7pRkFx
	 mcPz9Du82b7GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v12 4/4] net: mana: recover port on attach
 failure in ethtool operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260711041415.3008868-5-dipayanroy@linux.microsoft.com>
References: <20260711041415.3008868-1-dipayanroy@linux.microsoft.com>
 <20260711041415.3008868-5-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 04:14:46 +0000
Message-Id: <20260712041446.8FFA11F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11950-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:dipayanroy@linux.microsoft.com,m:bpf@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C3C1743CA1

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The newly introduced background recovery via `queue_reset_work` ra=
ces with administrative interface state changes (`ip link set down`), causi=
ng the port to become permanently stuck in a broken state.
- [High] Clearing `channel_changing` before queuing `queue_reset_work` in `=
mana_set_channels` creates a race window where the RDMA driver can claim th=
e vport, permanently defeating the recovery.

Pre-existing issues:
- [Critical] A failure in `mana_attach()` leaves the driver vulnerable to a=
 guaranteed NULL pointer dereference when the port is later brought up via =
`ip link set up`.
- [High] Missing RDMA synchronization via the `channel_changing` flag in `m=
ana_set_ringparam`, `mana_change_mtu`, and `mana_xdp_set` allows the RDMA d=
river to hijack the vport during configuration changes.
- [Medium] The fix for `mana_attach()` failures leaving the port in a broke=
n state was applied to ethtool ring size and channel count changes, but mis=
sed MTU changes and XDP program attachment.
--

--- Patch [4]: [PATCH net-next v12 4/4] net: mana: recover port on attach f=
ailure in ethtool operations ---
commit 750fd303cde77a7c9585144b5c7341d83090dbb3
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: recover port on attach failure in ethtool operations

This patch adds a recovery mechanism for mana_attach() failures during etht=
ool=20
ring size or channel count changes by scheduling queue_reset_work, while=20
adjusting retry values to maximize the chance of recovery.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index f77509818d07f..71e69d5a9a04a 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -675,8 +676,19 @@ static int mana_set_channels(struct net_device *ndev,
>  	apc->num_queues =3D new_count;
>  	err =3D mana_attach(ndev);
>  	if (err) {
> -		apc->num_queues =3D old_count;
>  		netdev_err(ndev, "mana_attach failed: %d\n", err);
> +
> +		/* Choose a retry queue count that maximizes recovery
> +		 * chances in the reset work handler.
> +		 */
> +		if (old_count < new_count)
> +			apc->num_queues =3D old_count;
> +		else if (new_count > MANA_DEF_NUM_QUEUES)
> +			apc->num_queues =3D MANA_DEF_NUM_QUEUES;
> +		else
> +			apc->num_queues =3D 1;
> +
> +		schedule_port_reset =3D true;
>  	}

[Severity: Critical]
This is a pre-existing issue, but a failure in mana_attach() leaves the dri=
ver
vulnerable to a NULL pointer dereference when the port is later brought up
manually.

If mana_attach() fails, its failure path calls mana_cleanup_port_context()
which frees apc->rxqs:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_cleanup_port_context() {
    ...
    kfree(apc->rxqs);
    apc->rxqs =3D NULL;
    ...
}

If the user later brings the interface up, mana_open() triggers the queue
allocation chain without reinitializing the port context:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_open() {
    ...
    err =3D mana_alloc_queues(ndev);
    ...
}

Which dereferences the NULL pointer in mana_add_rx_queues():

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_add_rx_queues() {
    ...
    apc->rxqs[i] =3D rxq;
    ...
}

Is there a mechanism to prevent this sequence if recovery fails?

>  out:
> @@ -685,6 +697,11 @@ static int mana_set_channels(struct net_device *ndev,
>  	mutex_lock(&apc->vport_mutex);
>  	apc->channel_changing =3D false;
>  	mutex_unlock(&apc->vport_mutex);

[Severity: High]
Could clearing channel_changing before the reset work executes create a race
condition where the RDMA driver claims the vport?

If mana_set_channels() fails in mana_attach() and drops vport_mutex while
setting apc->channel_changing =3D false, a concurrent RDMA QP creation could
call mana_cfg_vport() and successfully claim the hardware vport since
vport_use_count is 0.

When the queued reset work later calls mana_attach() -> mana_create_vport(),
it would see vport_use_count as 1 and fail with -EBUSY, preventing the
recovery from succeeding.

Should channel_changing remain true until the recovery completes?

> +
> +	if (schedule_port_reset)
> +		queue_work(apc->ac->per_port_queue_reset_wq,
> +			   &apc->queue_reset_work);
> +
>  	return err;
>  }

[Severity: High]
Can this asynchronous recovery race with administrative interface state cha=
nges,
leaving the port in a state where it cannot be brought up or down?

If an admin runs ip link set down before the reset workqueue executes:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_close() {
    if (!apc->port_is_up)
        return 0;
    ...
}

Because mana_close() returns early, apc->port_st_save remains true, while t=
he
kernel state transitions to DOWN.

When the reset work runs, it calls mana_attach() which sees
port_st_save =3D=3D true, reallocates queues, increments vport_use_count to=
 1,
and sets apc->port_is_up =3D true.

If the admin then runs ip link set up, mana_open() will fail in
mana_create_vport() with -EBUSY because vport_use_count is already 1. A
subsequent ip link set down will do nothing because the kernel state is
already DOWN.

Does the reset work handler need to synchronize against administrative state
changes?

[ ... ]

> @@ -752,11 +770,35 @@ static int mana_set_ringparam(struct net_device *nd=
ev,
>  	err =3D mana_attach(ndev);
>  	if (err) {

[Severity: High]
This isn't a bug introduced by this patch, but does the detach and attach
sequence here lack synchronization against the RDMA driver?

Unlike mana_set_channels(), mana_set_ringparam() does not acquire
vport_mutex or set apc->channel_changing =3D true before calling mana_detac=
h().

When it calls mana_detach(ndev, false), vport_use_count drops to 0. A
concurrent RDMA workload could call mana_cfg_vport() and claim the vport
during this window.

When the Ethernet driver subsequently calls mana_attach(), it would fail wi=
th
-EBUSY.=20

This same lack of synchronization appears to be present in mana_change_mtu()
and mana_xdp_set().

>  		netdev_err(ndev, "mana_attach failed: %d\n", err);
> -		apc->tx_queue_size =3D old_tx;
> -		apc->rx_queue_size =3D old_rx;
> +		NL_SET_ERR_MSG_FMT(extack, "failed to change ring params: %d",
> +				   err);
> +
> +		/* Choose retry ring sizes that maximize recovery
> +		 * chances in the reset work handler. Handle RX and
> +		 * TX independently.
> +		 */
> +		if (old_rx < new_rx)
> +			apc->rx_queue_size =3D old_rx;
> +		else if (new_rx > DEF_RX_BUFFERS_PER_QUEUE)
> +			apc->rx_queue_size =3D DEF_RX_BUFFERS_PER_QUEUE;
> +		else
> +			apc->rx_queue_size =3D MIN_RX_BUFFERS_PER_QUEUE;
> +
> +		if (old_tx < new_tx)
> +			apc->tx_queue_size =3D old_tx;
> +		else if (new_tx > DEF_TX_BUFFERS_PER_QUEUE)
> +			apc->tx_queue_size =3D DEF_TX_BUFFERS_PER_QUEUE;
> +		else
> +			apc->tx_queue_size =3D MIN_TX_BUFFERS_PER_QUEUE;
> +
> +		schedule_port_reset =3D true;
>  	}
>  out:
>  	mana_pre_dealloc_rxbufs(apc);
> +
> +	if (schedule_port_reset)
> +		queue_work(apc->ac->per_port_queue_reset_wq,
> +			   &apc->queue_reset_work);
>  	return err;
>  }

[Severity: Medium]
This is a pre-existing issue, but should this same recovery mechanism be
applied to MTU and XDP program changes?

If mana_attach() fails in mana_change_mtu() or mana_xdp_set(), they return
immediately without scheduling queue_reset_work. This leaves the port detac=
hed,
which eventually leads to the NULL pointer dereference in mana_open() if the
user tries to bring the interface up manually.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711041415.3008=
868-1-dipayanroy@linux.microsoft.com?part=3D4

