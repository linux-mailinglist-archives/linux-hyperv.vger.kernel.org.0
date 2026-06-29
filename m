Return-Path: <linux-hyperv+bounces-11698-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 65j6KrgPQmpuzgkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11698-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 08:24:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD876D650E
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 08:24:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="dLOAGF/z";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11698-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11698-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC0B3002293
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 06:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866F389107;
	Mon, 29 Jun 2026 06:24:54 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8228C86C;
	Mon, 29 Jun 2026 06:24:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714294; cv=none; b=g/IQi/Lt3VGEFL2YELW4eRzLDATEUt+MdMOezIbliY3tLckOi+EPHwc48VPGtw7MJFb8yIin38FCZQYV6TaDpM8uJ8HWgtqG4+PD0g2d0AoY4mFjn+8UqyY02uJbTK6QrvGXab3VNIkZtEmjYnv01HWtNWjST4m7riwqD2MTMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714294; c=relaxed/simple;
	bh=gnb858Rm7GrMh702A4NS8Nje13i23mUpj7S8mCYrx6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SwQc7ibKb6hlmKd59IyJA6NJCups4xvufN8cakhw1QONND9Sye5UwMpyB9/2vCac7bsVMOpMzu7x665x3WKq34OXcc8vAh1GVFUcAv9SjIe0qsFW4BaaPDiB7j87S2dHHMmxY5RlZZgzatyUqMdSZEXN+2hi3s5ZeRhQHUrMSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLOAGF/z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFEA1F000E9;
	Mon, 29 Jun 2026 06:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782714293;
	bh=aM/fEHBwOE0lymo4oDwfQufex/DqafXe9rPrJOipAI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dLOAGF/zWXVpvbByDN51dBCN04lFjULPGmO1TrJJXfr9mpg5POkpw+J9O6JKN26IL
	 bOhRyDSpSrJCTjQdC1DcGXd134nSy7sZIy+ylcvZ1LLOsFZRYvOP3d/ETRe6//8CWB
	 hZbMjtCUY551GbR+jYfFTBdHRl5bk7uRPyxGon5mffPtfcCQ3G41mBcpWlicljyMIR
	 QzhNPdP+DAabiI6i6dN1hYKD27A1iCv1Wr/uuNjMKlZ/JOUXBnRkjNFmTPvaL+F7fa
	 i4tVWI+nsZA719wCMn3m9W8SK6A7IQTMrHeu4CJcqN9h9MQGvkZEqCnwomB0AyuR41
	 ec1SdnX1yqfCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 31/32] treewide: convert rdmsrq() from a macro to an
 inline function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, linux-hwmon@vger.kernel.org, cassel@kernel.org, linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260629060526.3638272-32-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <20260629060526.3638272-32-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:24:49 +0000
Message-Id: <20260629062452.8DFEA1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11698-lists,linux-hyperv=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgross@suse.com,m:dri-devel@lists.freedesktop.org,m:linux-hyperv@vger.kernel.org,m:kvm@vger.kernel.org,m:dlemoal@kernel.org,m:linux-ide@vger.kernel.org,m:linux-hwmon@vger.kernel.org,m:cassel@kernel.org,m:linux-perf-users@vger.kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BD876D650E

> Today rdmsrq() is a macro using its second parameter as the target for
> storing the read MSR value.
>=20
> Convert rdmsrq() to an inline function returning the MSR value.
>=20
> The users have been converted using the following semantic patch:
>=20
>   // Options: --include-headers
>=20
>   virtual patch
>   virtual report
>=20
>   @@
>   expression msr, val;
>   @@
>   (
>   - rdmsrq(msr,val)
>   + val =3D rdmsrq(msr)
>   )
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629060526.3638=
272-1-jgross@suse.com?part=3D31


