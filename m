Return-Path: <linux-hyperv+bounces-11888-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h/nMJUkMUGrysQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11888-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 23:02:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 068D5735A49
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 23:02:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NiubuluB;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11888-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11888-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA5683009574
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jul 2026 21:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FB733ADA3;
	Thu,  9 Jul 2026 21:01:58 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA011B6CE9
	for <linux-hyperv@vger.kernel.org>; Thu,  9 Jul 2026 21:01:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630918; cv=none; b=neouFoEwdGv4RZo/t+IZX1NsZgEgMkSGVgwmGiGW7FTk2N504qbo6YNAt8BHFqjffBfLrUu0RSr9DD9eOB4r8maAy9i9ofgfcigpN0X9N7ZSQocbOb2Us93fXKc8+w31DFe5Sux+tc+Bn5DfGcH5K4ghWpbSUjAT89pZkdjkNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630918; c=relaxed/simple;
	bh=u8p5yPLGygzcDPPs5+zlW6RL4dWqLpcIouzgP6dwj0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rV9OhIMl1eycKYdNRPu0UzeJJrTBg39HcNR3qMHF4Z45ljxdkWkGI6wwoUCXyfMJOWqlIDPpQZDQ39jPFJojwZiO7tRHZmO+ZCgfT25LrclDhOp452ZN643BPSn5CIn+3mDBcG7Nt9NUwuadAxZzJj4rNr/IKCH3oNzbcxk6Rrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiubuluB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4629D1F000E9;
	Thu,  9 Jul 2026 21:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783630916;
	bh=OpzH7WROO/It71+mlehgB3gItu/le5D4n2t2Vk6NQrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NiubuluB33eBJ0K7Io2eK+svVCcxNpE2RvLVJ9BggarPUXSiK+wgZZDMqJU0vFd4g
	 zYAqSbkYrsEvztLjXba/0UTP+OYVoo6UuMoWdctmT0gVPfdIHrEQ0uoXG9TM7No25v
	 DLhLT7DK0vnIRXlJFxtVYabZVkLgHFSdCojaP/uFlxNzRlseT/wyJHOJRBag596PHC
	 22W1pD4LYt/RRuOhgm+9YwV1jKDKTIrVFo3UP4VxnyMDHOmHKeI/4ssyKEy9uD1Hd5
	 cfzhxI7tzPR950gFtH1wd+CQRlPHfqqL9HIymEMVFo7pbPcWWc8Ld50+OfvebXwUbY
	 CqBaFYfcXti+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3] net: mana: Add handler for sriov configure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haiyang Zhang" <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260708205924.2408673-1-haiyangz@linux.microsoft.com>
References: <20260708205924.2408673-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 21:01:55 +0000
Message-Id: <20260709210156.4629D1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11888-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 068D5735A49

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `pci_disable_sriov()` in the PF's `shutdown` path forces t=
he teardown of already-shut-down VFs, triggering a `dev_WARN_ONCE` stack tr=
ace that can cause a kernel panic on shutdown.
--

--- Patch [1]: [PATCH net-next v3] net: mana: Add handler for sriov configu=
re ---
commit 4f33a45546e7a470eda04866cd0e6294bcfd526c
Author: Haiyang Zhang <haiyangz@microsoft.com>

net: mana: Add handler for sriov configure

This patch adds an SR-IOV configuration handler to the mana driver, allowing
it to request or disable VFs. It also adds SR-IOV disable calls to the
device remove and shutdown paths.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> index e8b7ffb47eb98..dff66a2a4f598 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
[ ... ]
> @@ -2488,6 +2490,8 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
> =20
>  	dev_info(&pdev->dev, "Shutdown was called\n");
> =20
> +	pci_disable_sriov(pdev);
> +

[Severity: High]
Will this trigger a kernel warning during system shutdown when VFs are acti=
ve?

During system shutdown, the driver core calls device_shutdown() iterating in
reverse creation order. First, it calls mana_gd_shutdown() on the VFs, which
partially tears down the VF and disables the PCI device:

mana_gd_shutdown()
    ...
    pci_disable_device(pdev);=20

Next, device_shutdown() calls mana_gd_shutdown() on the PF. Calling
pci_disable_sriov() here destroys the VF PCI devices and unregisters them
from the bus, which synchronously forces a call to the VF's remove callback:

mana_gd_remove()
    ...
    pci_disable_device(pdev);=20

Since pci_disable_device() is called unconditionally at the end of both
mana_gd_shutdown() and mana_gd_remove(), this second call detects that the
device is already disabled and fires a warning. On production systems with
panic_on_warn=3D1, this converts a normal shutdown into a kernel panic.

>  	mana_rdma_remove(&gc->mana_ib);
>  	mana_remove(&gc->mana, true);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708205924.2408=
673-1-haiyangz@linux.microsoft.com?part=3D1

