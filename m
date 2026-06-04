Return-Path: <linux-hyperv+bounces-11477-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VEnGAF/6IGpy+AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11477-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 06:09:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4476163CCA4
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 06:09:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=c7WTGYxD;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11477-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11477-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1816930277DD
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 04:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ADF388881;
	Thu,  4 Jun 2026 04:08:48 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAB22F388
	for <linux-hyperv@vger.kernel.org>; Thu,  4 Jun 2026 04:08:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780546128; cv=none; b=DA8I7Hxkyb/mJI6cT8dBGeDbu0P7LHIUNe1cA8GRMtjvhUNvQuNnMsZra4Xu/DxuJ14cUOYDm95DKXKcHa2MP3PQRJ5r2WG1ORmQ8NRxn4eq3359DB5yd5NrWcZXv42gCq7zeM2/SvDJKTeipCvs1Yx44hb+UNVcEtoSPQYj5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780546128; c=relaxed/simple;
	bh=aayq66RQR6J4gmKuinU7AJoqHbGx1E31wEpWAz+hPHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FUH7Ln2Jg+pZR7W73z45IHOsUwOGCmkgztvuyhF+6fLfIGYYSDLlwQq5diYz4nOCT56lgQfjYl/J+nM9Cyn2SU31YlkLgUmXFgovdNmzIf4Xz/3Lmg9BqIjb0RBkGXD0Wy50GT5taKlsQcceXhziun9eh6l7Bs0hiaatT3mFNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7WTGYxD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529DD1F00893;
	Thu,  4 Jun 2026 04:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780546127;
	bh=VYjuVaIujWcRzgPdRuD0FUdPFJmHvdgYcYHlyxQbCp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c7WTGYxDqyufY30CW/yozm5JXiXYgK9AxEGOby3O6tu6e+HRKQpPOh1+f9/oPO8JN
	 rDRHi9yQeKOz3xec1jKBALngvyHdyklBAJ7NrcPQvZgmg3c6kIOcQM+32KRpJwtXjJ
	 08vL31vAMzLjV4fNLrzkbC/ehbKbx0NPEl07pNE3NtEuV7R73IYAN3NXfDbZ/NsOfp
	 2RohBKWdz+3HlH0Bhq3FDp8qBW5+sK3YA59l53WB6GonQEWMYBrtiX/KDDjYLmc9P4
	 4a+5QD2Atj9nO8j+s3ZPVkialFY9AUQzjH1R8ZsehPjlVEFmZwPSd7CG1ZS/+LQNuD
	 PEUoun+x5dqug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] cdx: use generic driver_override infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260604035239.1711889-5-runyu.xiao@seu.edu.cn>
References: <20260604035239.1711889-5-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 04:08:46 +0000
Message-Id: <20260604040847.529DD1F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11477-lists,linux-hyperv=lfdr.de];
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
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4476163CCA4

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Stale kernel-doc entry for removed `@driver_override` member in `st=
ruct cdx_device`.
--

commit c9a2a632f33a0544d4ef0145d2020070218d6838
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

cdx: use generic driver_override infrastructure

This commit switches the CDX subsystem to use the generic driver-core
driver_override infrastructure. It removes the private driver_override
storage and uses device_match_driver_override() to prevent races during
bus matching.

Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel=
.org/

[ ... ]

> diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
> index b1ba97f6c9ad6..f1a107b232daa 100644
> --- a/include/linux/cdx/cdx_bus.h
> +++ b/include/linux/cdx/cdx_bus.h
> @@ -165,7 +165,6 @@ struct cdx_device {
>  	bool enabled;
>  	u32 msi_dev_id;
>  	u32 num_msi;
> -	const char *driver_override;

[Severity: Low]
Does this leave a stale kernel-doc entry for @driver_override in the
struct cdx_device documentation block?

The struct documentation still references the removed field:

 * @driver_override: driver name to force a match; do not set directly,
 *                   because core frees it; use driver_set_override() to
 *                   set or clear it.

This might trigger an excess kerneldoc parameter warning during the kernel
build (with W=3D1).

>  	struct mutex irqchip_lock;
>  	bool msi_write_pending;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604035239.1711=
889-1-runyu.xiao@seu.edu.cn?part=3D4

