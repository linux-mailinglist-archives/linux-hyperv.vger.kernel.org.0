Return-Path: <linux-hyperv+bounces-11470-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J48gGSiPIGo65AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11470-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 22:31:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF17B63B20E
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 22:31:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l6fAziPK;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11470-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11470-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 254C4303DAB8
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jun 2026 20:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035CD401A16;
	Wed,  3 Jun 2026 20:28:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51143E4C98;
	Wed,  3 Jun 2026 20:28:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780518528; cv=none; b=S7nNEL4wT2N9XM65Q45LLquc8uXP9POhs6wgBbaJ3JbPUZ2mKzndMzVfY6YEsg6e7M06kLbPQgagGFsoYmQg1N1qqpqVf+kgd1jxBgj7cXBg4e8F3olHuvAPBzswXjmwy9+t+kkerKGjeysOIm8e3KWrQjqvMO59/nkrj+VQxzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780518528; c=relaxed/simple;
	bh=ISjCl5c5Cx6ds0zGhdTFigzZgDuQY0AM3UQUCrhiB3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t9eHDNsxzxe9eLLkv5l/dVajIpsBKSfTQ5x01Fb9H3rZg7nvtO7EIGbSfQiddeoNS3IOKRmK1v0u7bNr4r6QQQRSDzZGZNYc3RjkY4jrvl4syC/4xvdawTiW5C+vrUVNzunu8s3YQ0SzuqMCoqniEXkXT+saCRRtowsaZqtivIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6fAziPK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523F91F00893;
	Wed,  3 Jun 2026 20:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780518527;
	bh=FmDbDJFXJN7UzGQmOFzTUSdYjNQ1F/mppcHPImRrsCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l6fAziPKFozSHeljUpLHMNx6FN/CcSbR35SA9pn+njTLBJ2E57RODiq9NX8yM1J2V
	 qqhmxUsxQyTl8fdTFRvYW/Dht6DF2I4fZ9LagvyO0/Bs0JrUiGzvuQMO0T0V3G9iSZ
	 vjkFKEmSbg88WxIBpVHQoo/1jPxFPGmLsFhWzCFUdnQvsbzpWsHRBtKJUgYTZfRPos
	 5NB+W+C81N/vvKZ6u1oEql/aE4Oc8YOz8zWXUjJaKDpzRKzQrNwc8RRieWnXXEAfBD
	 x6mAcuLAKVt8uqSV8HrmxevwJTbee24d3TK6R+oafqF/hyrTOMK15Yx2AnOqfYOxjj
	 Kt6Jdo9NSxPOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v10 2/2] net: mana: force full-page RX buffers
 via ethtool private flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260602202801.1873742-3-dipayanroy@linux.microsoft.com>
References: <20260602202801.1873742-3-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 20:28:46 +0000
Message-Id: <20260603202847.523F91F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11470-lists,linux-hyperv=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dipayanroy@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF17B63B20E

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Forcing `apc->port_is_up =3D true` on the `mana_attach` error path=
 causes a double-destroy of the hardware vport when the interface is later =
brought down.
- [Medium] Latent bug: Changes to future private flags will be silently ign=
ored if MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF is not simultaneously toggled.
--

commit d7983f6668f209a0b7bfb427c64d5517b326c7b1
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: force full-page RX buffers via ethtool private flag

Adds an ethtool private flag full-page-rx to bypass page_pool fragment
allocation and force one RX buffer per page. Includes logic in
mana_set_priv_flags to dynamically reconfigure the port on flag change.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c

[ ... ]

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
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
When additional private flags are added in the future, will changes to those
new flags be silently ignored if MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF isn't
also toggled?

Since this assignment is nested inside the FULL_PAGE_RXBUF check, changing
only a future new flag will bypass this assignment and the function will
return success while discarding the new flag state.

Should this assignment be moved outside the flag-specific conditional block?

> +
> +		if (!apc->port_is_up) {

[ ... ]

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
                        ^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does forcing port_is_up to true here cause a double-destroy of the hardware
vport when the interface is later brought down?

If mana_attach fails, it cleans up any partial state by destroying the vpor=
t.

Leaving the port artificially marked as up means a subsequent interface down
event or reset worker will see apc->port_is_up as true and call
mana_detach with from_close set to true.

This bypasses the netif_device_present check and triggers a second call to
mana_destroy_vport, which could drop apc->vport_use_count below zero and
send a duplicate deregister message to the firmware for the already-freed
hw_vport_handle.

> +			schedule_port_reset =3D true;
> +		}
> +	}
> +
> +out:
> +	mana_pre_dealloc_rxbufs(apc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602202801.1873=
742-1-dipayanroy@linux.microsoft.com?part=3D2

