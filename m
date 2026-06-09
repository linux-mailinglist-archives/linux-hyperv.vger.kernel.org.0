Return-Path: <linux-hyperv+bounces-11567-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lP0/OC5bKGqzCgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11567-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 20:27:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1F066350B
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 20:27:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nOwcS0NO;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11567-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11567-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 168E5302977A
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 18:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3773CF212;
	Tue,  9 Jun 2026 18:20:22 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749435F612
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 18:20:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029222; cv=none; b=fHQHpq9Cyo7PLpsNNaixAFkir6ZAMS52BwROSEv74Dbj0ZG364DzvahBpVcZVdZWGstpQsLXjE2MKX+tVauA3vgLiG6RgBhrbqtayK2K0LE4i3bmzQjpk9DQq1uOaDKElXuQmdhvqKXQ4LTAeh8ztsry7QeWFuAJXagrCqwgsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029222; c=relaxed/simple;
	bh=iQOVA/XJ80BxRy+lkmoMm1g4YcsdXHXufoCDdnfJomw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mzn6ZH0PFL3ddJ8CVZ/EAhKcPO1BqiHEZFmF4PWnVDJ7Yfv7JvM1jUA7Nj158gZnwEsKLTHYoc7ifAsBDuthnqPV3xexJ4uNH7yQU21P/tx/Z3A7sYNWygpxYGaGflnKFEj2qGXMJ3she62pe7z9EDhXK8MX/dm8ZESS9tSGLEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOwcS0NO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF961F00893;
	Tue,  9 Jun 2026 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781029221;
	bh=iovQDQJTejzASxJKYxLgbOTPFdKvlfF5FjEGL3qLAA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nOwcS0NOytZrca234kuniYDrE+ipOwFN0ZB7I4Zp0y/ulnpTX+Qt8mdl00r83zjTa
	 Vx6xIVSSBzNbBfrJRdgU2s3k1eIiODRkkR3jdZ7+4KH++7S538r8Pj/A6VgsEQZYdN
	 4ODqlemMOtJLesn5OzueBs3cu5yIzRml5OQFpii16e+9AmVGioKvWKF1vqtfmB8KQD
	 6cN5YCd/bLr/1rzoHZd8c3wQJ7g/OOPvknXx3s2aNT8IG3E/pwY7KKn/JZmM05A58O
	 d1fcX5ayV+EZcwWflbdvLzNe7WGEmikLbGzlhozw5jqOzETzvygWxahI/0qJ/1cl2Q
	 hGpooWOCzJIRQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/6] arm64: rsi: Add RSI host call structure and
 helper function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260609181030.2378391-2-kameroncarr@linux.microsoft.com>
References: <20260609181030.2378391-2-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:20:20 +0000
Message-Id: <20260609182021.6AF961F00893@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11567-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F1F066350B

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `struct rsi_host_call` ABI definition relies on implicit compil=
er padding, failing to explicitly represent the RES0 field required by the =
CCA RMM specification.
--

commit 8a89052b48f09110c7f3fe9050a30fbf2d54c237
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

arm64: rsi: Add RSI host call structure and helper function

This commit introduces the rsi_host_call structure and a helper function to
facilitate hypercall routing through the RSI interface for Hyper-V guests in
an Arm CCA Realm.

> diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rs=
i_smc.h
> index e19253f96c940..ffea93340ed7f 100644
> --- a/arch/arm64/include/asm/rsi_smc.h
> +++ b/arch/arm64/include/asm/rsi_smc.h

[ ... ]

> @@ -142,6 +142,12 @@ struct realm_config {
>  	 */
>  } __aligned(0x1000);
> =20
> +struct rsi_host_call {
> +	u16 immediate;
> +	u64 gprs[31];
> +} __aligned(256);

[Severity: Low]
This isn't a bug, but does this structure definition leave a 6-byte implicit
padding hole between immediate and gprs?

The Arm CCA RMM specification requires this 48-bit region to be reserved and
zeroed. While current allocations might safely zero this memory, could a
future stack allocation of this structure leave the padding bytes
uninitialized?

Would it be safer to add an explicit padding field to enforce the correct
layout and prevent potential leaks of uninitialized Realm memory to the
untrusted Host?

> +static_assert(sizeof(struct rsi_host_call) =3D=3D 256);
> +
>  #endif /* __ASSEMBLER__ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609181030.2378=
391-1-kameroncarr@linux.microsoft.com?part=3D1

