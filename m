Return-Path: <linux-hyperv+bounces-10892-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBK9ElxIBmo3hwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10892-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 00:10:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DB954759C
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 00:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3944430071CD
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 22:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01E238E10F;
	Thu, 14 May 2026 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpFEOA3l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC9834B183
	for <linux-hyperv@vger.kernel.org>; Thu, 14 May 2026 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778796633; cv=none; b=LNG3a6RZ9FOYrWUO8d+OV9/2GzCUuBu9j4+/vbgntY3bADX9aFymMqILeCu7/IcFdYO7A/fFQ4DmIfIOx6M43rZRst8s4ymf+XMCvCAQlGeSrqe8DsElusbJIIGw/lO+vayIy41+vDdj3e1At8EpaSpXDhkCxDsU9cLvxD7EW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778796633; c=relaxed/simple;
	bh=RTa27qRMevcB0MZboTWX8LdlXU+2b1Z15KPDd70jmLI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tDYvdutG0aOIYXEJprRIc0R6SnlLabuLoevT/QlyhgdAcZb0/WMSyDm5tXm5Rs+D38yTjW+SXlqv7HRmzcS3hHo9ClmS4y7dJPgsvpO+CB3XA93YKlhhcpodCjToAjzw2L99bANHD2dNeu9vkx9AwHXLwtJ/LtCdfDA8aR0j0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpFEOA3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5C9C2BCB3;
	Thu, 14 May 2026 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778796633;
	bh=RTa27qRMevcB0MZboTWX8LdlXU+2b1Z15KPDd70jmLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NpFEOA3lJmoEy0n8efP9j0K/NQsr9SIJQvlAErZi/m0zAORPoUG4Ne6Fk5tzRaX5U
	 TkS0EhrjIDfWP9qsPQtgPQyYgXQnJOQIMf76p117m6p7JP8Pe8UKbdR5UWmZAxUcaZ
	 mK1Bx3aJN61nR9sImrFOsfqHulmraAialLoAr5NKr/xp9j6FSfaUpEDGcW0WnE4CQA
	 b8rlOio42f5i2cFrWsCBdvWRC85KARBsVNy2DFeNG0g2Ii3W37jrFTyJTwmve7Gt9N
	 HOt8wxUbWhtcKbvTNLoOkEdrXl5x7+xY2bdAQ7/jI4zOAVVj5pvYFz412l5Gp4Wh8z
	 sDiW9gz9f/TTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 1/6] net: mana: Create separate EQs for each
 vPort
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260513220956.402058-2-longli@microsoft.com>
References: <20260513220956.402058-2-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 22:10:32 +0000
Message-Id: <20260514221033.3B5C9C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 97DB954759C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10892-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Race condition in `mana_set_channels()` allows an RDMA applica=
tion to steal vport ownership during an Ethernet reconfiguration, leading t=
o out-of-bounds memory accesses and interface breakage.
- [Critical] Per-PD reference counting for per-port EQs causes a scope mism=
atch, leading to NULL pointer dereferences and resource leaks when a Protec=
tion Domain is shared across multiple ports.
--

commit 31a11c151b6c97fb0cd32cd8787a2fa1cd92856b
Author: Long Li <longli@microsoft.com>
Subject: net: mana: Create separate EQs for each vPort

To prepare for assigning vPorts to dedicated MSI-X vectors, remove EQ
sharing among the vPorts and create dedicated EQs for each vPort.

> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/ma=
na/main.c
> index ac5e75dd3494d..6159bd03a0217 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
[ ... ]
> @@ -55,15 +57,23 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 po=
rt, struct mana_ib_pd *pd,
>  		return err;
>  	}
> =20
> -	mutex_unlock(&pd->vport_mutex);
> =20
> -	pd->tx_shortform_allowed =3D mpc->tx_shortform_allowed;
> -	pd->tx_vp_offset =3D mpc->tx_vp_offset;
> +	err =3D mana_create_eq(mpc);
> +	if (err) {
> +		mana_uncfg_vport(mpc);
> +		pd->vport_use_count--;
> +	} else {
> +		pd->tx_shortform_allowed =3D mpc->tx_shortform_allowed;
> +		pd->tx_vp_offset =3D mpc->tx_vp_offset;
> +	}
> =20
> -	ibdev_dbg(&dev->ib_dev, "vport handle %llx pdid %x doorbell_id %x\n",
> -		  mpc->port_handle, pd->pdn, doorbell_id);
> +	mutex_unlock(&pd->vport_mutex);

Could this lead to a NULL pointer dereference or resource leak if a Protect=
ion
Domain is shared across multiple ports?

The vport_use_count is tracked per-PD (pd->vport_use_count), but Event Queu=
es
are now managed per-port (mpc->eqs).

If a user creates a QP on Port 1, pd->vport_use_count becomes 1 and mpc1->e=
qs
are allocated. If the user then creates a QP on Port 2 using the same PD, t=
he
code in mana_ib_cfg_vport() will see pd->vport_use_count > 1 and bypass
configuration for Port 2.

This leaves mpc2->eqs as NULL if the Ethernet interface is down, leading to=
 a
NULL dereference when EQs are accessed. When QPs are later destroyed, it
will also destroy the context of whichever port the last QP belonged to,
permanently leaking the hardware configuration and EQs of the port that was
actually initialized.

[ ... ]
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index 04350973e19e3..e121834d17f3a 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -454,18 +454,40 @@ static int mana_set_coalesce(struct net_device *nde=
v,
>  	return err;
>  }
> =20
> +/* mana_set_channels - change the number of queues on a port
> + *
> + * Returns -EBUSY if the port is down and RDMA holds the vport with
> + * EQs sized to the current num_queues.
> + */
>  static int mana_set_channels(struct net_device *ndev,
>  			     struct ethtool_channels *channels)
>  {
>  	struct mana_port_context *apc =3D netdev_priv(ndev);
>  	unsigned int new_count =3D channels->combined_count;
>  	unsigned int old_count =3D apc->num_queues;
> +	bool locked =3D false;
>  	int err;
> =20
> +	/* When the port is down, hold vport_mutex for the entire
> +	 * operation to serialize against RDMA's mana_cfg_vport().
> +	 * This is safe because mana_detach()/mana_attach() skip
> +	 * vport teardown/setup when port_st_save is false.
> +	 * When the port is up, Ethernet owns the vport exclusively
> +	 * so no locking against RDMA is needed.
> +	 */
> +	if (!apc->port_is_up) {
> +		mutex_lock(&apc->vport_mutex);
> +		if (apc->vport_use_count) {
> +			mutex_unlock(&apc->vport_mutex);
> +			return -EBUSY;
> +		}
> +		locked =3D true;
> +	}
> =20
>  	err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu, new_count);
>  	if (err) {
>  		netdev_err(ndev, "Insufficient memory for new allocations");
> -		return err;
> +		goto unlock;
>  	}
> =20
>  	err =3D mana_detach(ndev, false);

Can this lead to a race condition with RDMA operations when the port is up?

If apc->port_is_up is true, the function does not acquire apc->vport_mutex.
It proceeds to call mana_detach(), which calls mana_uncfg_vport() and lowers
apc->vport_use_count to 0.

Because no lock is held across the detach/attach window, a concurrent RDMA
operation like mana_ib_create_qp_raw() could grab apc->vport_mutex, observe
a use count of 0, and steal ownership of the vport.

If the RDMA thread allocates apc->eqs based on old_count, and then
mana_set_channels() updates apc->num_queues =3D new_count, subsequent RDMA
queue indexing operations may read out of bounds. The Ethernet interface wi=
ll
also fail to reattach because RDMA now owns the vport, leaving the interface
broken.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513220956.4020=
58-1-longli@microsoft.com?part=3D1

