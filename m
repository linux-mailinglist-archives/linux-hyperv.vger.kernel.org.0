Return-Path: <linux-hyperv+bounces-11808-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SMslADV1RmrOVgsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11808-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 16:27:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAD86F8DD7
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 16:27:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=e3BXhN8A;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11808-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11808-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A97FD31631E2
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F114D90D4;
	Thu,  2 Jul 2026 14:18:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA44DBD90;
	Thu,  2 Jul 2026 14:18:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001928; cv=none; b=M3STGgIINOnGjdXeeHwMFInCkD2MA3MRKwHvdKL0TBBx/OUJhR+9JwgAeci/zWIS2gzD1GWzTfZjXnSbldbRDYU9TIWXQXdT0Z75QfN49IRRUwMPU21NFWLdooKD+6/Jb36fSLOL5yv9Ypx5/TY34hqirdMIaELm0GXspSxwBb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001928; c=relaxed/simple;
	bh=Afmir2I7kiJ9IFP6pcIr1ZrHhMgkQJ3DwgTbIXf7Axc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pab2CgtK7TXNryE/Rl95JE/XR+D1pYye6f6leAuK9JIkIeh1VHVKeNKH+jc/nz0O3x2H9x+/R3dgYKyk5qQFsIqL3gaJjQh/0qy6J3xh0LRhNuiYGlXLIo1Gb1ee+JrNvsHi16rZDXqLo6RtYeyDC6+eLJLXxycr0m7+DEvZibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3BXhN8A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876721F000E9;
	Thu,  2 Jul 2026 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783001923;
	bh=mJIabPCgXmZJ7kQs37o83qEJmDNmO5PB3BW150cVzlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e3BXhN8A3lnb7r4qHZxFAf2gSQIzYLg60zSDC+Jo3nHkD3TF/1otUunmTPLsuPd/6
	 M8zFxDY4b4DyPhXJvkp6EnQjBERPoXL2hRCH4rA7RIhuEyLZTnnbhbUfFcujb7QiI+
	 dIlQHJSneji36hZ8bH9k0Mw/XuKFgxqhc7Y/FkE6lHt8RBufmOUt2fNXNxViFMsFcQ
	 5yyy0/An6th5HIvqGabcsyUXl+fPgt+pEr7AUdMzWaJYNXQ35FgVQw/YqtA1G/TmWH
	 GE+pk2yInbLChWwNeRa95huwIAUz71hPKlVTIYFLoxeHLdZW0EvQt6AX8ZkwjmyHe4
	 V3195BFTmbaMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v11 2/2] net: mana: force full-page RX buffers
 via ethtool private flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260701141808.461554-3-dipayanroy@linux.microsoft.com>
References: <20260701141808.461554-1-dipayanroy@linux.microsoft.com>
 <20260701141808.461554-3-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 14:18:41 +0000
Message-Id: <20260702141842.876721F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11808-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:dipayanroy@linux.microsoft.com,m:bpf@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BAD86F8DD7

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Forcing `port_is_up =3D true` in the `mana_attach()` error path le=
aves the port state inconsistent, leading to a double-teardown of hardware =
queues and a NULL pointer dereference in stats gathering.
- [High] The device restart sequence in `mana_set_priv_flags()` lacks `vpor=
t_mutex` synchronization and does not set `apc->channel_changing`, creating=
 a race condition with concurrent RDMA operations.

Pre-existing issues:
- [High] Bulk pre-allocation of RX buffers uses GFP_ATOMIC and emergency me=
mory reserves in a process context (ethtool), which can lead to memory depl=
etion and spurious failures.
- [High] Pre-allocated RX buffers with `from_pool =3D false` are leaked whe=
n dropped in a queue configured with `frag_count > 1`.
--

commit 40ed2f3da9bc06c10116aa35575da8c740d52002
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: force full-page RX buffers via ethtool private flag
   =20
This patch adds an ethtool private flag "full-page-rx" to force one RX
buffer per page on ARM64 platforms. The single-buffer-per-page logic is
consolidated into a new helper function. The driver is detached and
reattached when the flag is modified to apply the new buffer configurations.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index 3531abfdaf433..24f6ce63b031b 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
[ ... ]
> @@ -611,6 +630,88 @@ static int mana_get_link_ksettings(struct net_device=
 *ndev,
>  	return 0;
>  }
> =20
> +static u32 mana_get_priv_flags(struct net_device *ndev)
> +{
> +	struct mana_port_context *apc =3D netdev_priv(ndev);
> +
> +	return apc->priv_flags;
> +}
> +
> +static int mana_set_priv_flags(struct net_device *ndev, u32 priv_flags)
> +{
> +	struct mana_port_context *apc =3D netdev_priv(ndev);
> +	u32 changed =3D apc->priv_flags ^ priv_flags;
> +	u32 old_priv_flags =3D apc->priv_flags;
> +	bool schedule_port_reset =3D false;
> +	int err =3D 0;
> +
> +	if (!changed)
> +		return 0;
> +
> +	/* Reject unknown bits */
> +	if (priv_flags & ~GENMASK(MANA_PRIV_FLAG_MAX - 1, 0))
> +		return -EINVAL;
> +
> +	if (changed & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF)) {
> +		apc->priv_flags =3D priv_flags;
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
> +		err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);

[Severity: High]
This is a pre-existing issue, but does calling mana_pre_alloc_rxbufs() from
ethtool context cause memory allocation problems?

mana_pre_alloc_rxbufs() calls dev_alloc_pages() in a bulk loop, which uses
GFP_ATOMIC and emergency memory reserves. Since this is now triggered from
process context via ethtool, could this deplete system emergency reserves
intended for atomic receive paths, leading to spurious failures or network
drops under memory pressure?

[Severity: High]
This isn't a bug introduced by this patch, but does toggling this flag
dynamically create conditions that permanently leak pre-allocated buffers?

When a packet is dropped, mana_rx_skb() checks if from_pool is false (which
it is for pre-allocated buffers) and unconditionally saves the buffer to
rxq->xdp_save_va. However, mana_get_rxfrag() only reuses xdp_save_va if
rxq->frag_count =3D=3D 1.=20

If this flag causes the queue to operate with frag_count > 1 after buffers
are pre-allocated (e.g. by disabling the flag), xdp_save_va is ignored.
Subsequent drops will trigger WARN_ON_ONCE(rxq->xdp_save_va) and permanently
leak the old buffer.

> +		if (err) {
> +			netdev_err(ndev,
> +				   "Insufficient memory for new allocations\n");
> +			apc->priv_flags =3D old_priv_flags;
> +			return err;
> +		}
> +
> +		err =3D mana_detach(ndev, false);

[Severity: High]
Does this device restart sequence lack vport_mutex synchronization with
concurrent RDMA operations?

In mana_set_channels(), detach and re-attach is protected by asserting
apc->channel_changing under vport_mutex. Here, mana_detach() tears down
the vport (dropping vport_use_count to 0) without setting
apc->channel_changing.=20

Can an RDMA process concurrently call mana_cfg_vport(), observe a zero use
count, and successfully claim the vport before mana_attach() blindly
attempts to configure the exact same vport, resulting in conflicting
hardware programming?

> +		if (err) {
> +			netdev_err(ndev, "mana_detach failed: %d\n", err);
> +			apc->priv_flags =3D old_priv_flags;
> +
> +			/* Port is in an inconsistent state. Restore
> +			 * 'port_is_up' so that queue reset work handler
> +			 * can properly detach and re-attach.
> +			 */
> +			apc->port_is_up =3D true;
> +			schedule_port_reset =3D true;
> +			goto out;
> +		}
> +
> +		err =3D mana_attach(ndev);
> +		if (err) {
> +			netdev_err(ndev, "mana_attach failed: %d\n", err);
> +			apc->priv_flags =3D old_priv_flags;
> +
> +			/* Restore 'port_is_up' so the reset work handler
> +			 * can properly detach/attach. Without this,
> +			 * the handler sees port_is_up=3Dfalse and skips
> +			 * queue allocation, leaving the port dead.
> +			 */
> +			apc->port_is_up =3D true;

[Severity: High]
Does forcing port_is_up to true in this error path lead to a NULL pointer
dereference in stats gathering?

The internal failure path of mana_attach() calls
mana_cleanup_port_context(), which frees apc->rxqs and sets it to NULL.=20

By forcing apc->port_is_up =3D true here, if userspace queries stats via
ethtool -S or ip -s link, mana_get_stats64() and mana_get_ethtool_stats()
will bypass their safety checks and blindly dereference the NULL
apc->rxqs[q] array.

> +			schedule_port_reset =3D true;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701141808.4615=
54-1-dipayanroy@linux.microsoft.com?part=3D2

