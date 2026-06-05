Return-Path: <linux-hyperv+bounces-11504-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TPN+CFGFImqbZgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11504-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 10:14:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C33C6464DE
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 10:14:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nPFRoWIF;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11504-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11504-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44C9A3006B6D
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2026 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB95E48B37E;
	Fri,  5 Jun 2026 08:02:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB647ECD1
	for <linux-hyperv@vger.kernel.org>; Fri,  5 Jun 2026 08:02:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646529; cv=none; b=jg3wPj+spGoLY9T9ifdNLj+CIMUVSS1HaK1tKEOuj1Z2I2wa8IDk/1oO1gAS40TfuU//gHgxlciTKIYRXkyTw2N5e2URv/xQyyosk5sqcySkokMJsh2YP1xOQPkZwAgXdJXiANNP/npsh2ohTxI3zETgQh+8Eb6EOsmcyv0ltsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646529; c=relaxed/simple;
	bh=X7A6lIB2SDPcikgyEWPFmrxrDn+vcl+vPxaZSubUAPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MFE9PnzHKZ+a5pnpIKZW4lqfYWs2/14ZsBWkyJNU7Nu0iJifYpyX2Xt1IA4kKG2UsPp13khfVqJyiaizosRyx5fAdpDtFJvHcVU60C0JVYR2Z6lZ7V62VcrED26mB76RDxCwBM55RPMc8ZnbgQ0WOMCMS6FHa1+69k+1GT6k1h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPFRoWIF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283311F00893;
	Fri,  5 Jun 2026 08:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646528;
	bh=3c2Rmt7T4i+TG48UjHMBdsdpSpIpS0On4iK17jXoDjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nPFRoWIFOq07XT5Jxn1BRvcKlA9zQzEDXawiPq+tgFunlmknLB9Sjw+7uROx86/Yk
	 imtQLkqPsFVzBaGpGL9mdY3UXm3CQFeUPg1aR7fF4bzMSofZixDfotWsQ8p3jRe0JO
	 y8B9NXXdqel7B974MXI/tkdMWiXTWASzn1BQUqi2tamqrvqkjp8jhWrzcpAhwI8/+x
	 OT8GViU07FeqK5HOLjo0oa1tRVhA93iIgATBFzuPsRisnZoXCs6nO0ePrmMgXa97PF
	 4vP0A+Oixo0nW2ve7VJTsqAKNvxix1uGlzzwNo7Ipm1J1QLtIyjcs8/rnDUmoQj0vX
	 Lr1KDl+aBdhXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] net: mana: guard TX wq object destroy with
 INVALID_MANA_HANDLE check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <gargaditya@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260604080137.1995269-3-gargaditya@linux.microsoft.com>
References: <20260604080137.1995269-3-gargaditya@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 08:02:07 +0000
Message-Id: <20260605080208.283311F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11504-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gargaditya@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C33C6464DE

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In `mana_create_vport()`, if `mana_create_txq()` fails, the functi=
on returns the error directly without unwinding the previously successful `=
mana_cfg_vport()` and `mana_pf_register_hw_vport()`. Similarly, if `mana_cf=
g_vport()` fails, it returns the error without unwinding `mana_pf_register_=
hw_vport()`. This leaks firmware vPort registrations and leaves `apc->vport=
_use_count > 0`, leading to a permanent `-EBUSY` error on all future attemp=
ts to open the device.
--

commit 22337dc3f6a86510c8d8b1e096424ad2f6000592
Author: Aditya Garg <gargaditya@linux.microsoft.com>

net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check

This commit fixes an issue where mana_destroy_txq() attempts to destroy a
WQ object using INVALID_MANA_HANDLE if allocation fails earlier. It adds
a check to verify the handle is valid before calling mana_destroy_wq_obj().

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index db14357d3732e..4a2cd800111e7 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2351,7 +2351,8 @@ static void mana_destroy_txq(struct mana_port_conte=
xt *apc)
>  			netif_napi_del_locked(napi);
>  			apc->tx_qp[i]->txq.napi_initialized =3D false;
>  		}
> -		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
> +		if (apc->tx_qp[i]->tx_object !=3D INVALID_MANA_HANDLE)
> +			mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
> =20
>  		mana_deinit_cq(apc, &apc->tx_qp[i]->tx_cq);
> =20

[Severity: High]
This is a pre-existing issue, but while reviewing the error paths that lead
to mana_destroy_txq(), I noticed a potential resource leak in
mana_create_vport().

If mana_create_txq() fails, the function returns the error directly without
unwinding the previously successful mana_cfg_vport() and
mana_pf_register_hw_vport():

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_create_vport() {
    ...
	err =3D mana_cfg_vport(apc, gd->pdid, gd->doorbell);
	if (err)
		return err;

	return mana_create_txq(apc, net);
}

The same applies if mana_cfg_vport() fails, as it returns the error without
unwinding mana_pf_register_hw_vport().

Because mana_alloc_queues() propagates this error without calling
mana_destroy_vport() or unwinding the partial initialization:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_alloc_queues() {
    ...
	err =3D mana_create_vport(apc, ndev);
	if (err) {
		netdev_err(ndev, "Failed to create vPort %u : %d\n", apc->port_idx, err);
		return err;
	}
    ...
}

Does this leak firmware vPort registrations and leave apc->vport_use_count =
> 0,
leading to a permanent -EBUSY error on all future attempts to open the devi=
ce?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604080137.1995=
269-1-gargaditya@linux.microsoft.com?part=3D2

