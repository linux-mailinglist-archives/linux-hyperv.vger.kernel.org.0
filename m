Return-Path: <linux-hyperv+bounces-11478-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HV5lO4X7IGqK+AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11478-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 06:13:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A5C63CCBA
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 06:13:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l5ApU5rv;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11478-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11478-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF65A300BC8F
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 04:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA96230BD5;
	Thu,  4 Jun 2026 04:13:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD1A22F388
	for <linux-hyperv@vger.kernel.org>; Thu,  4 Jun 2026 04:13:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780546431; cv=none; b=OI+/rd6RO3wKtI3JGTwHgOFpru0kwtwnS3a7a1s+gC9tReGyxL3ptGmrZwibMQOiZ99s90d7vXkBNF85eb1LH0jwxVjGzqLWQ5/wZgXabBMM+H+e9WCZlg0o//wVnONPa1MAzAA9CfChTx0zU3gokcsI/8y7zVEigFucs8wCFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780546431; c=relaxed/simple;
	bh=B1UqxZdUd3ybtc1AoGqFQ2cq8W0cFDnxFKHisFRB7CA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ufdazpPVaCKbKPfpRu1o3wxR9muCZ1+CQn1pO0tbuXBGmm+d4HPgrmpYk3R3Mn/8X0L62BFeEUmHEQUGkwNLMN+s7GqgtMOZ+liKu6tM7n3gftvS0xzysiZrFJ6SUQWua1Uo+bLqzbJfVOt2yJg6q9+8mRSDRQiW1RV2TgCjR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5ApU5rv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA16B1F00893;
	Thu,  4 Jun 2026 04:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780546429;
	bh=AXPEZi7JZ4yYj5ttzn7MYbNVk36WA4NP67B6zy4477Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l5ApU5rvHO7LtlZ7lptTqPRqr+VWgRitqTYyEq+2I6DoNwxBXFK9HzX86DdbopEMG
	 NTpE7JIDRZTDvy43DfB4tDbWTRwO9nz3WGvPWJ3LCsW5uUJZPyIPjQGaWAqiNUKmZq
	 OnTvAHatsHb1uf8ibCmlVnNDI+N2QMcMbL/CNcwpcgeAFj8G3/ZM6SgEBAPv9CcpaR
	 ExUTVqa0rIZiA1DLTh8VTJ5n0GvkrSBN9DGHqmJ/neR/3B2N38VlJRfCoJlhesKp4Y
	 K6T7bGXaJuwKv7P3YbnDS9UGMx4VxxiHBXBmB0xcgCUDdMk8vuLgP8GlTw84+gR0W1
	 9eL9pKnp6kANw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] vmbus: use generic driver_override
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260604035239.1711889-4-runyu.xiao@seu.edu.cn>
References: <20260604035239.1711889-4-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 04:13:49 +0000
Message-Id: <20260604041349.BA16B1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11478-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,smtp.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6A5C63CCBA

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A time-of-check to time-of-use (TOCTOU) race condition in `vmbus_p=
robe()` allows `drv->probe` to be called with a NULL `dev_id`, leading to a=
 NULL pointer dereference in drivers like `storvsc_probe()`.
--

commit 76d8c5c515ad429741f331c31ec380bf773956cb
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

vmbus: use generic driver_override infrastructure

This commit switches the vmbus subsystem to use the generic driver core
driver_override infrastructure rather than bus-private storage. It removes
the private driver_override storage and updates the match path to use
device_match_driver_override() for locked reads, preventing the match
logic from inspecting freed memory during concurrent updates.

Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel=
.org/

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index d28ff45d4cfdd..a81e2b0976367 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
[ ... ]
> @@ -708,9 +679,11 @@ static const struct hv_vmbus_device_id *hv_vmbus_get=
_id(const struct hv_driver *
>  {
>  	const guid_t *guid =3D &dev->dev_type;
>  	const struct hv_vmbus_device_id *id;
> +	int ret;
> =20
>  	/* When driver_override is set, only bind to the matching driver */
> -	if (dev->driver_override && strcmp(dev->driver_override, drv->name))
> +	ret =3D device_match_driver_override(&dev->device, &drv->driver);
> +	if (ret =3D=3D 0)
>  		return NULL;

[Severity: High]
This is a pre-existing issue, but does this behavior still leave a
time-of-check to time-of-use race condition open when called later
during probing?

The driver core __driver_attach() calls driver_match_device() locklessly,
which delegates to vmbus_match() and eventually hv_vmbus_get_id(). If a
matching driver name is written to the driver_override sysfs attribute (or
a matching dynamic ID is present), it returns a match.

Before __driver_attach() acquires the device lock to call
driver_probe_device(), a concurrent sysfs write can clear the
driver_override attribute or remove the dynamic ID.

Inside vmbus_probe(), which executes with the device lock held,
hv_vmbus_get_id() is called again. Because the state was changed
concurrently, it can evaluate to NULL:

drivers/hv/vmbus_drv.c:vmbus_probe() {
    ...
    dev_id =3D hv_vmbus_get_id(drv, dev);
    if (drv->probe) {
        ret =3D drv->probe(dev, dev_id);
    ...
}

Since vmbus_probe() lacks a NULL check for dev_id, it directly calls
drv->probe(dev, dev_id) with dev_id equal to NULL.

Sub-drivers like storvsc_probe() then unconditionally dereference dev_id
(for example, checking dev_id->driver_data), which results in a kernel pani=
c.

Could a NULL check for dev_id be added in vmbus_probe() to fully prevent
this race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604035239.1711=
889-1-runyu.xiao@seu.edu.cn?part=3D3

