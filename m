Return-Path: <linux-hyperv+bounces-11390-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFGNEbU0Gmp+2AgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11390-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 02:52:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B3060A746
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 02:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 819D230FAC85
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 00:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F88C279DAD;
	Sat, 30 May 2026 00:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqAL3WiQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1545124BBFD
	for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102019; cv=none; b=sP98u3vRb4rqX/qnRCf8LMd927WWnku2fR1FU2Kxev8b0Qeq6U5a5Z8fQreVXlh/y88Z9OB4M9hqTjNz2ugSj2jpsdMSduaAKe45jb/MXNBrNgiFFcB/epSNNxZZ1VRl/Ax+39r1/PnYWPgxJDnWR70kYBx7+GjEQ8WyXIq+KRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102019; c=relaxed/simple;
	bh=WRUBf7/iz83FX27rsQvVG/ingpgCE0RQgMHgt+gK/mE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UTeZ8pEJPlepIMAsyeM22NYaHu5keX6gm/+kiiBI+mOD8b1XQfKentqQCEl6HksxoN+oFi3j4lJfMIcODGKj9U9r9gOpugBls3PbPULzwobP+PmHCZJH64PgXYbY72H9oUnmJlN7HI6jNYGI2nox/Omn/9mjAnQQJfZnghjca9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqAL3WiQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B531F00893;
	Sat, 30 May 2026 00:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102018;
	bh=7tY0INFYS7iL8qjNU0GJPb0+YHLm9pNfaC16Hhp7sGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cqAL3WiQlRLr3LC/xdBYSFTU/D0ifPK8ZbS/1C1zXLqbqo4LWhO+aOcB+H7YWh3gO
	 +aHHFD9M+bzV/IqlZFFcu2AxdT/YRTYCKBDEDhjAxwNH7GaAZy1izkmL9lwkP2h7+2
	 97mbO35pc4OXVsC45hMgw0+nV1DY5m82Y6o6tV3YtldCrmQHanIOrzv2RU5RP4oF8v
	 DzLQWeTedNHZxvPw2Xaxv1zR84z4XXQlnivHNaaUbpPnwB+IbgSvpwXZQWwmXTA4m3
	 C1n8OV4xsgG0DuHe1ExD2FoeD2A1S5rB5p8XVYTH9xEn9UH7J5DAk2Tf7cuNtKQaMk
	 mvz3QgSZG5mVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v11 1/6] net: mana: Create separate EQs for
 each vPort
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260523020258.1107742-2-longli@microsoft.com>
References: <20260523020258.1107742-2-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:46:57 +0000
Message-Id: <20260530004657.D1B531F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11390-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B4B3060A746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing rollback of `mana_pf_register_hw_vport()` on failure in `m=
ana_create_vport()` leads to hardware resource leak.
- [High] Destroying an RSS QP disables RX steering for the entire physical =
vport, breaking any other active QPs.
--

commit 81a114514be59954addf46b0c28014c7c1c47694
Author: Long Li <longli@microsoft.com>
Subject: net: mana: Create separate EQs for each vPort

The patch moves EQ definition from mana_context to mana_port_context and
removes EQ sharing among vPorts to prepare for dedicated MSI-X vectors. It
also ensures RSS QPs take a vport reference to guarantee EQs outlive QP
consumers. Finally, cross-port PD sharing is explicitly rejected and
mana_set_channels is serialized against RDMA vport configuration.

> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index 0fbcf449c134b..d9a0bf8b2bc9c 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
[ ... ]
> @@ -817,6 +841,8 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *=
qp,
>  		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
>  	}
> =20
> +	mana_ib_uncfg_vport(mdev, pd, qp->port);
> +

[Severity: High]
This is a pre-existing issue, but since this patch explicitly adds
vport_use_count refcounting to allow multiple QPs to share the same physical
vport, does the unconditional call to mana_disable_vport_rx() earlier in th=
is
function break other active QPs?

If multiple QPs are active, destroying a single RSS QP will globally disable
receive steering for the entire hardware vport. Will this silently blackhole
all receive traffic for the remaining QPs on that port?

>  	return 0;
>  }
> =20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 82f1461a48e93..7c776f115f5aa 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> @@ -2913,11 +2922,7 @@ static int mana_create_vport(struct mana_port_cont=
ext *apc,
>  			return err;
>  	}
> =20
> -	err =3D mana_cfg_vport(apc, gd->pdid, gd->doorbell);
> -	if (err)
> -		return err;
> -
> -	return mana_create_txq(apc, net);
> +	return mana_cfg_vport(apc, gd->pdid, gd->doorbell, false);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the new exclusivity logic
makes it deterministically triggerable. If mana_cfg_vport() fails (which it
now will with -EBUSY if the RDMA driver currently holds the vport), does th=
is
leak the hardware vport registration?

The function returns the error directly without rolling back
mana_pf_register_hw_vport() on failure. Because mana_cfg_vport() can now be
forced to fail deterministically, could a user with CAP_NET_ADMIN repeatedly
toggle the Ethernet interface state while holding a raw QP, leaking a hardw=
are
vport registration each time and exhausting firmware resources?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523020258.1107=
742-1-longli@microsoft.com?part=3D1

