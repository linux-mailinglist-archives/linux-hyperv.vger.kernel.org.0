Return-Path: <linux-hyperv+bounces-11786-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hgu8Ju5zRWojAgsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11786-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:09:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B936F14D3
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:09:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Au2/3tFQ";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11786-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11786-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D42230CAE0C
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0374C431E7B;
	Wed,  1 Jul 2026 19:56:54 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8283431E6D;
	Wed,  1 Jul 2026 19:56:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935813; cv=none; b=gaycBV0/O+iy4MZVTnSmVKox5kIqKSo1BujQqivK1FsVCjfsJFdyTCoFsbOYro1uTDU0tjhi3o36mrMzQY1Uh9zFwAM6aFrs1S4SODE4ulbk+XLvMqOgcyuYw0I01PfUP2LoNoBCidOPkNS0owOaIKpJcb2LSuX94t9nYzXlj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935813; c=relaxed/simple;
	bh=a7iaRvOquiQpkJK1Zd7auLUUbSQGKf8f8CZjv8dciwc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lkswXUJ6IBBGZvIKo+YEr3Twp02eh0Yuna/MwViZF4BKPEqBFB3/QWqw+Yd8J+1bh4g6iFODtP8zvA81Szlc8LqOCP3QS/PV9COr1mSQKC5Jei1GVUihrRRXJRryKa3NXr/myrWYqDuZRX2eH7PIUQKXDqutPO3anyaUfT78s0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au2/3tFQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEF11F000E9;
	Wed,  1 Jul 2026 19:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935812;
	bh=a7iaRvOquiQpkJK1Zd7auLUUbSQGKf8f8CZjv8dciwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Au2/3tFQW4xQfLPQ+Hl5/tDcApj/Jrkb14+gRwB2C5rCak2znQ1/V963/gg45703h
	 tZ04x/t189CFLSP0EZZmG/lSR9E5GljXilXD8ERZVTZFO80DfY4iVbpoBKi6qfVwZM
	 R3Q9N83fxeh+fTG7HNFwqWc/4U4gj/8etiUAteBdoie1Zi79kM7iIQrIO7UzCuJ2x2
	 EnqB8auo1iflKgrCUtHAsemeqkxNF24jQ/6iHyu8ZIaZqU5l3zkvAzQhAKn6LamQEy
	 XptHBqsgi9TxHPPR1a8Zm07hTI9D/HB6GSSxqu41sdCvJ7Y1VVb9pxsW+jbUJf5nwW
	 nnAN121vz0LDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/51] x86/sev: Mark TSC as reliable when configuring
 Secure TSC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260701193212.749551-6-seanjc@google.com>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 19:56:50 +0000
Message-Id: <20260701195652.5DEF11F000E9@smtp.kernel.org>
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
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11786-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:linux-hyperv@vger.kernel.org,m:kvm@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9B936F14D3

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a malicious hype=
rvisor can bypass Secure TSC calibration by injecting a fake UV system tabl=
e, forcing the guest to fall back to untrusted legacy timers.
- [High] This problem wasn't introduced by this patch, but if the calculate=
d Secure TSC frequency is 0, the kernel silently falls back to untrusted ti=
mers instead of terminating the VM.
--

Note: Due to system recitation restrictions, this report is provided as a f=
ree-form summary without direct diff quoting.

commit cdbd80de837f6d512a759452a18164ddd83b9b7b
Author: Sean Christopherson <seanjc@google.com>

x86/sev: Mark TSC as reliable when configuring Secure TSC

This commit moves the setting of the X86_FEATURE_TSC_RELIABLE flag from
sme_early_init() to snp_secure_tsc_init(). It consolidates the handling of
known-frequency and reliable TSC flags when overriding the TSC calibration
routine.

[Severity: High]
This isn't a bug introduced by this patch, but does the early return in
arch/x86/kernel/tsc.c:tsc_early_init() allow an untrusted hypervisor to
bypass Secure TSC initialization?

The tsc_early_init() function checks is_early_uv_system() before initializi=
ng
Secure TSC. The is_early_uv_system() check relies on the presence of
UV_SYSTEM_TABLE_GUID in the EFI configuration tables.

Because the hypervisor can provide tables to the guest firmware which may
expose them as EFI configuration tables, an untrusted hypervisor could inje=
ct
this specific GUID. Would this trick the kernel into returning early,
bypassing both Secure TSC and TDX TSC initialization, and causing the guest
to fall back to untrusted legacy timers?

[Severity: High]
This is also a pre-existing issue, but should the newly updated
arch/x86/coco/sev/core.c:snp_secure_tsc_init() validate that the calculated
frequency is non-zero before returning?

If the calculated frequency evaluates to 0, which could happen if the
hypervisor causes MSR_AMD64_GUEST_TSC_FREQ to read as 0 or if the secrets
factor is invalid, the function simply returns 0 instead of terminating
the VM.

The caller tsc_early_init() treats a return value of 0 as a failure to find
a trusted frequency and gracefully falls back to x86_init.hyper.get_tsc_khz=
()
or legacy timers. In a confidential computing threat model, should this
security-critical initialization fail closed and terminate the VM, rather
than falling back to the hypervisor-controlled time sources that Secure TSC
is designed to protect against?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701193212.7495=
51-1-seanjc@google.com?part=3D5

