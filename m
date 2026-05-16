Return-Path: <linux-hyperv+bounces-10988-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HeScHxDtB2rmPAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10988-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 06:05:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B5655A1B8
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 06:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41061301918A
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 04:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345DF1C861D;
	Sat, 16 May 2026 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3u5PhnB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE9F12B143
	for <linux-hyperv@vger.kernel.org>; Sat, 16 May 2026 04:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778904333; cv=none; b=YssJhZ+Fvrk9yDFMccYyyQyVHMhFs4YpYpnFWSsmA6Fjxrq197aw6zJ6cXhJ7Z29ooCBmAgvfUaCRzFgdsImQW6rveTp/GWwaEtxYXulkO9tvm10bA99sLXj9z7U94QDzgjg4jd5gbANVpoTjNGnrT2ECtzVReD3kOThlHyUZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778904333; c=relaxed/simple;
	bh=tTHQ7osD0q0V9Zn76HJOE2KRCFcXiLxEq4wIMpL0K6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nA1/G2G9To++zNBkZQ3puWB8vl3wROjJFhOAHizzH8THcCwYbhXqnsJHTzZCA/PRUAWpoIkrFBT8LOV33wre/F7DTmRQ+Daa8/9CGYYIUu53LOMQHUGxCBtUSlT0rmnTIjPx509HxfeW1Ff4ksfDJHnu3UQRzrEDFYxRzwE1WFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3u5PhnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEF5C19425;
	Sat, 16 May 2026 04:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778904332;
	bh=tTHQ7osD0q0V9Zn76HJOE2KRCFcXiLxEq4wIMpL0K6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=p3u5PhnBS5qylIA6Wu025FOy5lQVU8fd9tOEEiPCUx86DFmeVbI7dNE8UVElCvKSd
	 sOojhGseCz6xzuUQ3SxmVNTMZz0pMLq0V7pLxNTear7b8Ypjyde4pvN0/zjH4Q1kil
	 UU/4PgHAZHPl6t0TywLDwdLAAjhH8WZO/okyJYLFDN4ZMApYN5rFAdrGPRsn0tzy7K
	 /AJmiorZndtnC4LqBR7lnCtsL+lHyRx29XJtN2cinNtlkUOI/OOptlGwyBLOJhnEIc
	 FaySJWpcE1o2HupzqW7Z22Ykt5+9GTSHovlQkLX1lXXy+Rm/uLm17iow8c4ZPm7pDq
	 A+pWgx6WLx1tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v10 1/6] net: mana: Create separate EQs for
 each vPort
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515040508.491748-2-longli@microsoft.com>
References: <20260515040508.491748-2-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 04:05:32 +0000
Message-Id: <20260516040532.7EEF5C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: B9B5655A1B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10988-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Missing cross-port validation in `mana_ib_create_qp_rss()` all=
ows userspace to trigger NULL pointer dereferences and corrupt other ports'=
 queues.
- [High] Use of boolean flag `channel_changing` as an ad-hoc lock in `mana_=
set_channels()` violates networking subsystem guidelines.
--

commit ed2a523d0427d1b949add95925cad26c8b468ff8
Author: Long Li <longli@microsoft.com>
Date:   Fri May 15 04:05:03 2026 +0000

    net: mana: Create separate EQs for each vPort

This commit separates EQs for each vPort, removing the shared EQ mechanism
from the MANA driver to prepare for dedicated MSI-X vector assignment.
RSS QPs are updated to take a vport reference, ensuring EQs outlive QP
consumers.

> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index 0fbcf449c134b..108ec4c5ce51c 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
[ ... ]
> @@ -155,6 +156,18 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp,=
 struct ib_pd *pd,
> =20
>  	qp->port =3D port;
> =20
> +	/* Take a reference on the vport to ensure EQs outlive this QP.
> +	 * The vport must already be configured by a raw QP.
> +	 */
> +	mutex_lock(&mana_pd->vport_mutex);
> +	if (!mana_pd->vport_use_count) {
> +		mutex_unlock(&mana_pd->vport_mutex);
> +		ret =3D -EINVAL;
> +		goto fail;
> +	}
> +	mana_pd->vport_use_count++;
> +	mutex_unlock(&mana_pd->vport_mutex);
> +

Does this code need to verify that the requested port matches
mana_pd->vport_port?

While mana_ib_cfg_vport() correctly rejects cross-port PD sharing for
raw QPs, an RSS QP creation could specify a different port (e.g., Port B)
using the same PD bound to Port A.

If Port B is unconfigured, could fetching its mpc result in a NULL
pointer dereference when accessing mpc->eqs below?

If Port B is active, could this lead to erroneously destroying Port B's EQs
or underflowing its vport_use_count when the PD drops its references during
teardown?

>  	for (i =3D 0; i < ind_tbl_size; i++) {
>  		struct mana_obj_spec wq_spec =3D {};
[ ... ]
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index 04350973e19e3..4633acc976f0a 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
[ ... ]
> @@ -462,10 +467,22 @@ static int mana_set_channels(struct net_device *nde=
v,
>  	unsigned int old_count =3D apc->num_queues;
>  	int err;
> =20
> +	/* Set channel_changing to block RDMA from grabbing the vport
> +	 * during the detach/attach window. mana_cfg_vport() checks
> +	 * this flag under vport_mutex and returns -EBUSY if set.
> +	 */
> +	mutex_lock(&apc->vport_mutex);
> +	if (!apc->port_is_up && apc->vport_use_count) {
> +		mutex_unlock(&apc->vport_mutex);
> +		return -EBUSY;
> +	}
> +	apc->channel_changing =3D true;
> +	mutex_unlock(&apc->vport_mutex);
> +

Is channel_changing acting as an ad-hoc lock here?

The networking subsystem guidelines discourage using boolean flags set on
entry and cleared on exit to guard code sections against concurrent access.

Since mana_detach() and mana_attach() are executed while this flag is held
to prevent mana_cfg_vport() from proceeding, could this be replaced with a
standard locking mechanism to ensure lockdep visibility?

>  	err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu, new_count);
>  	if (err) {
>  		netdev_err(ndev, "Insufficient memory for new allocations");
> -		return err;
> +		goto clear_flag;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515040508.4917=
48-1-longli@microsoft.com?part=3D1

