Return-Path: <linux-hyperv+bounces-10990-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEW5MxDtB2rmPAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10990-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 06:05:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F855A1B9
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 06:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE37B3019919
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 04:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370EB239E9B;
	Sat, 16 May 2026 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mInEw8mQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148CA12B143
	for <linux-hyperv@vger.kernel.org>; Sat, 16 May 2026 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778904334; cv=none; b=oXQ22n/H3GgFOHC402L470com6IUA0FZaG6SRp4ofEVoj3LJmJq9SQbQpddekkOQebsRIepLG2FTXy8t4TsaKFwCgM5a74bv1EBZeLbT9ql6EvkaE2oZ4As6iU+v/Xl2kS//22vqkd0sAh0TwWatrXL/oCNB0Ls6W3zmnLz0w2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778904334; c=relaxed/simple;
	bh=LZ/FaQSw/adFN5x6lhsuoaV3q3HNG6O2DtcVJTM/LDE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bkiL+oFg0d35/GYgQJHZShdvMbjpSKVmIJ+quLB0E8qZ7Y0TmGJIHg/7CJibg1G9A7KldDQCtDVxeagSkSVETepCYU3bmg4ELPwT5GGVTbCoCVXSKZFCZsOQhcYmPFPCHlXYRflkul6JbW6h7SEmXS+Yn3xwKoYjrVFOMsLjEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mInEw8mQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84C0C19425;
	Sat, 16 May 2026 04:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778904333;
	bh=LZ/FaQSw/adFN5x6lhsuoaV3q3HNG6O2DtcVJTM/LDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mInEw8mQBgBM4BZgHjP04TLqobnTC9pXF+YWA/cIzpPfmP5ivORKVyYJD2jMEVaeA
	 Pyj+lzwHS1t2lAE2plqOLyHmYQz4Tlqp6gm+Fh9vTkPTgZat132nn4VKQdz7VFtmG4
	 AuA3TbcTEnQGDnrV4gaGSKdAlOVfqRd22uKAW1iXFaGErmwDZ5lVCL/U0xLTYy3weE
	 8DyuCo92v1ZIuNvJ6COsgaL2ixz5ljcyjy2iksNRsNeU9yel+ww9vMNq0aDpQ2LfpJ
	 U4xHzDKARyISaUv/hy+/JB8NwN9FSIfb8Y13o6DZlzurVRddqjnXzf1WzDfot4yqqI
	 l0GeZOD8RYV4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v10 5/6] net: mana: Allocate interrupt context
 for each EQ when creating vPort
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515040508.491748-6-longli@microsoft.com>
References: <20260515040508.491748-6-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 04:05:33 +0000
Message-Id: <20260516040533.C84C0C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 7C6F855A1B9
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
	TAGGED_FROM(0.00)[bounces-10990-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The RDMA driver (mana_ib) fails to initialize because it does not =
allocate GIC references for its EQs.
--

commit 9f615e81497dbea890c8df0a9aa9efd643e9a6a7
Author: Long Li <longli@microsoft.com>

net: mana: Allocate interrupt context for each EQ when creating vPort

This commit updates the driver to use GIC functions to create a dedicated
interrupt context or acquire a shared interrupt context for each EQ when
setting up a vPort. The caller is now responsible for acquiring and
releasing the GIC reference across the EQ create/destroy lifecycle.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -1684,12 +1690,22 @@ int mana_create_eq(struct mana_port_context *apc)
>  		debugfs_create_dir("EQs", apc->mana_port_debugfs);
> =20
>  	for (i =3D 0; i < apc->num_queues; i++) {
> -		spec.eq.msix_index =3D (i + 1) % gc->num_msix_usable;
> +		msi =3D (i + 1) % gc->num_msix_usable;
> +
> +		gic =3D mana_gd_get_gic(gc, !gc->msi_sharing, &msi);
> +		if (!gic) {
> +			err =3D -ENOMEM;
> +			goto out;
> +		}
> +		spec.eq.msix_index =3D msi;

Will this change to the initialization logic break the RDMA driver (mana_ib=
)?

Since the caller is now required to manually acquire a GIC reference via
mana_gd_get_gic() before creating EQs, and mana_ib hasn't been updated to
do this, won't it trigger a WARN_ON(!gic) inside mana_gd_register_irq() and
fail device initialization?

I noticed this was fixed later in the patch series by commit 'RDMA/mana_ib:
Allocate interrupt contexts on EQs', but could this break bisectability her=
e?

> +
>  		err =3D mana_gd_create_mana_eq(gd, &spec, &apc->eqs[i].eq);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515040508.4917=
48-1-longli@microsoft.com?part=3D5

