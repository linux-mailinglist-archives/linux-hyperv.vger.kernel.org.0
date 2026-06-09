Return-Path: <linux-hyperv+bounces-11546-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qXZ4IE7qJ2pM4wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11546-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 12:26:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E704065EDD5
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 12:26:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HOyTN9dU;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11546-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11546-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAF14316D4B7
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 10:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5E83F0AAD;
	Tue,  9 Jun 2026 10:14:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEFB3EFFC1
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 10:14:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000056; cv=none; b=flO17WPN0hFvM5hOGAVOauad5G7VClDJX6kLZhnozvPGA/CpZhosSbL2D7IM8Ftvqae7yAFlh1YGHeQpI6KBCnT4HRQIPpIUrTV8oM8gUT1381IkDMwgPhpeoh/jeJyXwj3DYrwMQ9lBEuZYEYc4SD/fPrEj6Xmz27xzroanz9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000056; c=relaxed/simple;
	bh=r9+sA4mgzUI/VVmC+86nvFsKSTpYS4yQX/50+YP4lEs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cM9WfgEJeflHUSeI4TQe0ADWheucCvv2XOzLJUft2LRcDV08VlHVrnRHZ/slpAzQShqCfw5x1num71/qmW4PcFggjUUv8zt6Y6fJR8+6Z7R9K3SfCpo8fqvH2smrHswX8hq/aP3Vm4ZeUtj7O01FbopkJz5IHi3zgzv3O8kRXPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOyTN9dU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521C91F00893;
	Tue,  9 Jun 2026 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781000054;
	bh=lw1V/qe3hFszeV0shg7z6tT4lCsPanmMJjlnx2urEFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HOyTN9dUHX0quS5HdI8D040xbPnBOaVp52UiQskuO+Nt0CVbrwFekCLswXbWsVkg2
	 qHik3QR3JBHLquiaJwQ3p2g6Dd4OqWOyUHe5xEwLo1qblBgZqEYjyOr76FTUOBxBLk
	 kSTQRHdy2xpcoW7PvxzNhkfXqUkBhSxMFMFmNU/smJOqcaNL5JFbos7sc4K1mOYUhn
	 KD3qN1uRayAMw5y8+DgwcATpBhH0KaH23Nol+1sp7xb6SdCO+qb/6JRIAUG+etTuGm
	 qSx8hwG9L0DH+dV1zLfsImqUb8tnBaiw+9X/CFu6bvEEySi+K6Qp2VIi0hZVFEJzWr
	 o8tIq76PVGDPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/2] net: mana: initialize gdma queue id to
 INVALID_QUEUE_ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <gargaditya@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260608101345.2267320-2-gargaditya@linux.microsoft.com>
References: <20260608101345.2267320-2-gargaditya@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:14:13 +0000
Message-Id: <20260609101414.521C91F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11546-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E704065EDD5

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The mana_gd_create_mana_eq function leaks a firmware DMA region ob=
ject on its error path if the EQ hardware creation fails.
--

commit 4c25a3c164c64bd1c7eed40e10b6c6526c99eb4c
Author: Aditya Garg <gargaditya@linux.microsoft.com>

net: mana: initialize gdma queue id to INVALID_QUEUE_ID

mana_gd_create_mana_wq_cq() leaves queue->id as 0 (from kzalloc_obj())
until mana_create_wq_obj() assigns the firmware-returned id. If creation
fails before that, cleanup calls mana_gd_destroy_cq() with id 0, NULLing
gc->cq_table[0] and silently breaking whichever real CQ owns that slot.

Initialize queue->id to INVALID_QUEUE_ID right after allocation, matching
mana_gd_create_eq(). The existing (id >=3D max_num_cqs) guard then
short-circuits cleanly.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> index d8e816882f02c..ac71ca8450bf4 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1192,6 +1192,8 @@ int mana_gd_create_mana_wq_cq(struct gdma_dev *gd,
>  	if (!queue)
>  		return -ENOMEM;
> =20
> +	queue->id =3D INVALID_QUEUE_ID;
> +
>  	gmi =3D &queue->mem_info;
>  	err =3D mana_gd_alloc_memory(gc, spec->queue_size, gmi);
>  	if (err) {

[Severity: High]
This is a pre-existing issue, but I noticed mana_gd_create_mana_eq() leaks a
firmware DMA region object on its error path if the EQ hardware creation fa=
ils.

In mana_gd_create_mana_eq(), mana_gd_create_dma_region() registers a DMA re=
gion
with the hardware and returns a valid handle. If the subsequent call to
mana_gd_create_eq() fails, execution jumps to the out label:

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_create_mana_eq() {
    ...
	err =3D mana_gd_create_eq(gd, spec, true, queue);
	if (err)
		goto out;
    ...
out:
	dev_err(gc->dev, "Failed to create queue type %d of size: %u, err: %d\n",
		spec->type, spec->queue_size, err);
	mana_gd_free_memory(gmi);
free_q:
	kfree(queue);
	return err;
}

Does this code need to call mana_gd_destroy_dma_region(gc,
gmi->dma_region_handle) in the error path?

Without it, does this leak the hardware DMA region resource and leave freed
physical pages mapped in the hardware, potentially creating a hardware
use-after-free scenario?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608101345.2267=
320-1-gargaditya@linux.microsoft.com?part=3D1

