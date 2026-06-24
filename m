Return-Path: <linux-hyperv+bounces-11657-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AYqoN7UUPGqEjggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11657-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jun 2026 19:32:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ECE6C05AE
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jun 2026 19:32:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A7E+HkSn;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11657-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11657-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08ADB3008A6D
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jun 2026 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAC73033FB;
	Wed, 24 Jun 2026 17:32:35 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC251FFC48
	for <linux-hyperv@vger.kernel.org>; Wed, 24 Jun 2026 17:32:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322355; cv=none; b=UMrtJJNlV/v+CZhGsZ+g4B25nFNjEE6Ty6BQ/HUWtQTTVF5FtM6Su24fYts4wQ9pCPsUOjXtwDCyouBZ+42NLGdofe15BB8gvIpEA+qcKjyqvBGZeCKz1AUhQIIhavKLIDOFonZWsWxzKNZNazFhC2TWZpXaSvYDoHVwZZlIwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322355; c=relaxed/simple;
	bh=x1n9GnLzZCe5B8fcZwuvBiMcOLWXu00Lc+dt8XLXQU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iJ4IL0QWDf8UoNrVccJag3ngtHTZ0lD2sjLE9uIyio1il/a8GLNE+n/6B4pUDnyQhTUaUKaUuKObSNR9IL/NE2XTcHMXsJYZVx1DnC079eBwS2pYJf0TktyDAbD1Rdj8FVpBgqM85EI4fn+5daavRsrzMaOuzCRwUZnialmt5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7E+HkSn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD181F000E9;
	Wed, 24 Jun 2026 17:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322354;
	bh=dJwINGebrg9lSGSRim9MjZBjXfIZmw3BG9jbex0V2Cw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A7E+HkSnakHyX/uANAyA/iMeGvW9u9sc0biLMb7MBWxceOMuPhpdk5sdP1FjxQpWd
	 U9r/dI2qjnRWGmIBBDaSCBWpxXJvnEbgngP8f3Qi9OuzhTSzHXYaxD/NNA2WO7GsL1
	 r08IrsUcEHqXlDYaZXo0t28WR4Q99u/Sm8s+Fz+h/gi7+ZSUl+1ds4I1ECPpTzC+YC
	 o9FCjMAo8Qoy1dSXqZQBOxvRuzauG6ElAeFGTqDVn1boenLtFTE29EJ3rTiNXOI1h2
	 F6uWdaUvqfdT7AzF5jAUpV4jp/X6CwoATq85XTNlVzecwSx0HJstKM90lUK0GB4eEA
	 XkU7sGb+KgPQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] hyperv: mshv: zero VTL hypercall output page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260624172157.2790-1-alhouseenyousef@gmail.com>
References: <20260624172157.2790-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 17:32:33 +0000
Message-Id: <20260624173234.1FD181F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11657-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39ECE6C05AE

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch only p=
artially fixes the information leak. While it zeroes the `out` page, the in=
put bounce page `in` is still allocated without the `__GFP_ZERO` flag. If a=
 user provides an `hvcall.input_size` that is smaller than the input size e=
xpected by the hypercall (specified by `hvcall.control`), `copy_from_user()=
` will only partially initialize the `in` page. The remainder of the page w=
ill contain uninitialized, stale kernel memory. This full page is then pass=
ed to the hypervisor. If the hypervisor processes these uninitialized bytes=
 and reflects them into the `out` page or alters its observable behavior ba=
sed on them, sensitive kernel data is leaked to userspace.
--

commit d8767fa45f0b927a8630a3fee3fba738b9ae7851
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

hyperv: mshv: zero VTL hypercall output page
   =20
This patch zeroes the hypercall output page to avoid copying stale memory
to userspace and adds NULL pointer checks for the page allocations.

> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 0d3d4161974f8..0365d207cb110 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -1147,7 +1147,11 @@ static int mshv_vtl_hvcall_call(struct mshv_vtl_hv=
call_fd *fd,
>  	 * TODO: Take care of this when CVM support is added.
>  	 */
>  	in =3D (void *)__get_free_page(GFP_KERNEL);

[Severity: High]
This isn't a bug introduced by this patch, but should the "in" page also
be allocated with __GFP_ZERO to prevent leaking stale kernel memory?

If userspace provides an hvcall.input_size that is smaller than what the
hypercall expects, copy_from_user() will only partially initialize the
"in" page. The remainder of the page will contain uninitialized kernel
memory which is then passed to the hypervisor in hv_do_hypercall(). If the
hypervisor reflects this input or alters behavior based on it, could this
result in an information leak?

> -	out =3D (void *)__get_free_page(GFP_KERNEL);
> +	out =3D (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!in || !out) {
> +		ret =3D -ENOMEM;
> +		goto free_pages;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624172157.2790=
-1-alhouseenyousef@gmail.com?part=3D1

