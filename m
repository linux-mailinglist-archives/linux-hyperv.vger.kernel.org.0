Return-Path: <linux-hyperv+bounces-11682-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /wfBB6dqPWqb2wgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11682-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:51:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7B26C805A
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:51:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PL4pr566;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11682-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11682-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 796FC300E5D7
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD1C25785C;
	Thu, 25 Jun 2026 17:50:58 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5992F7EFD
	for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 17:50:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409858; cv=none; b=tfhdht6wXwIKDrMNtEcPyHgyjk/tfMKhL/US2tJURxbYb4ExMA5Z9Lqhd6FxLIv3H4smNzJ/bvyaOmeSx0ynyMgDK14TllmZYc0USyqM/jGYDPlgsmCFlWJoRm68D/NVUOjFSnuE9IUHGxOn5bJqYlI+8Wxjy/00UaV2H9EBFTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409858; c=relaxed/simple;
	bh=JskPsisDdF0VFqwJDY/IV1vyX3gklNHe1ipwC/9NiHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UgufC9mx52eZvUQOIoNb1QfXJZonqXvQJqJWNunJZsEa+xggDy3Mw3UMi0LeCecsZB4wUMrwSZbl5exAlzbW8u3PlkmkhKUMwaeCHXUSEWXSi3gg9L9Qy/BR7cwir7e4RE9bN5ILzEbgGR7f5NIFrteN/hZ4E0m4IAGp27sTCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL4pr566; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405101F000E9;
	Thu, 25 Jun 2026 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782409857;
	bh=3olMyBRRJ5c9LAGC9o7TBKD5FPKftb7Nb386CLXx+cw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PL4pr566cPi5Xq/i9LeEd91+LjsWulVqtvIHZXYDLrBhnXzqX00HxKxGT/HYtM5ym
	 Xx4vvunnTkcLICRjaZRD1wPzVhuZfwL1dFHId6QFbPNIAo1XUOrV79LqtroxJGKrK0
	 +yDOzkvFxo6ef828U3lFjQgTqxqgMBRWsmpGIJKtRua92qVau9Vp2gnhOL/a4m/bNZ
	 8ZVs6etJF7/2fxpBKUJ0SMLEN3/0ihQUndTtZPqibAMob7T0UbZO1rB2xKjECurd/h
	 ThpOYfnBCZ4KFlHZ1jNS7Z43bWf1e3mvI1K5ox94cE5urr+mIPhsJgBx4CAatNQnYa
	 o7KIt472W4JBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260625173500.1995481-5-kameroncarr@linux.microsoft.com>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
 <20260625173500.1995481-5-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 17:50:56 +0000
Message-Id: <20260625175057.405101F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11682-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kameroncarr@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A7B26C805A

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Using `kmalloc()` to allocate hypercall input/output pages violate=
s the strict page-alignment requirements of `set_memory_decrypted()`, causi=
ng silent failures on ARM64 and exposing slab metadata to the untrusted hos=
t on x86.
--

commit 02dd1b4271844f489855c82e06efdec7e95897e3
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

Drivers: hv: Mark shared memory as decrypted for CCA Realms

This commit extends the confidential VM shared memory decryption handling
for hypercall input/output pages to support Arm CCA Realm guests. It also
updates the memory allocation to round up to the nearest page size to satis=
fy
decryption requirements.

> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 6b67ac6167891..17048a0a18729 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c

[ ... ]

> @@ -489,7 +490,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	 * online and then taken offline
>  	 */
>  	if (!*inputarg) {
> -		mem =3D kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);
> +		mem =3D kmalloc(alloc_size, flags);
>  		if (!mem)
>  			return -ENOMEM;
> =20
> @@ -499,14 +500,16 @@ int hv_common_cpu_init(unsigned int cpu)
>  		}
> =20
>  		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			ret =3D set_memory_decrypted((unsigned long)mem, pgcount);
> +		    (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
> +		     hv_isolation_type_cca())) {
> +			ret =3D set_memory_decrypted((unsigned long)kasan_reset_tag(mem),
> +				alloc_size >> PAGE_SHIFT);

[Severity: High]
This is a pre-existing issue, but does using kmalloc() here guarantee the
required page alignment for set_memory_decrypted()?

When slub debugging (like redzoning) is enabled, kmalloc() can return an
unaligned address due to prepended metadata.

On arm64, set_memory_decrypted() requires a page-aligned address. If
given an unaligned address, it warns and returns 0 without decrypting.
This leaves the hypercall pages encrypted, which breaks guest-hypervisor
communication for CCA Realms.

On x86, set_memory_decrypted() masks the address to the page boundary.
Because this memory is from a slab cache, decrypting the entire underlying
physical page could expose other unrelated kernel slab objects on the same
page to the untrusted hypervisor.

>  			if (ret) {
>  				/* It may be unsafe to free 'mem' */
>  				return ret;
>  			}
> =20
> -			memset(mem, 0x00, pgcount * HV_HYP_PAGE_SIZE);
> +			memset(mem, 0x00, alloc_size);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625173500.1995=
481-1-kameroncarr@linux.microsoft.com?part=3D4

