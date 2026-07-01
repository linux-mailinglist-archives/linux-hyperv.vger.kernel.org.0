Return-Path: <linux-hyperv+bounces-11790-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RdjKDLZzRWoQAgsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11790-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:08:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE3A6F1497
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:08:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=hbcjFVp1;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11790-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11790-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6223F30073E5
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 20:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F7A3B5F50;
	Wed,  1 Jul 2026 20:07:55 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66198395AE2
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 20:07:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936475; cv=none; b=NjGnAowMsiQpCYaHacqCyCSG8YNKejY0G2UqdN4gMhmB2bhKsm0AjOU81cigaAg4cxS3MU2hq2T1uKE26A4lt/9z1FkyaB6H3k6Y0b24LQe8+2Lf9BIbmp1eC/XiA3as8tFWpXg1pRawaXRd2kA/4j65/VzDF12GWRf7n/IgjCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936475; c=relaxed/simple;
	bh=1pQS/g2MnpCZt3mZlreri9StbMherxh7veCc3q9wdMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ce5ypacWNbR1iA1ZDQbq6c4uenWVNU6Nq2mdCcN6IhTSYoblbHvPTWBfmnN9I9L+X6VKGmkqylnDecZ/ElocWrCnelAFOyj2OPQj7hj0laJz8VSVgoUXNR/wVA/PSyq0wF7YWMPmRzcIUSuF5HG4xwks0APAlUVppAQvQONiFlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hbcjFVp1; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37e1f96b248so1340577a91.3
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 13:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782936474; x=1783541274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOdt1MjTdK+8K0oNK35IqiS1Sh21G9xWYtRVhtEsR+w=;
        b=hbcjFVp1c1dIix0uACLc02T7BEiA470Amjj9hNaHEmGodozAM0pTmxG5P4b5FXeeKs
         BxBBafs88ROJMrq1hTM0QmE+BJwYSXj2KCRC+Fn2lz+t3VctmXLK+124bK8+sShQdnig
         XNlspR4iQrOsWpS70oFod+4vYa8B43bx3YvSZB4VUpt1iivzxVKxGPp7wXoNs72mMHZh
         Ql6S01yJDMIDZC4JecEQxtBgUXj6oPeFs3HdxK9tLjm+XvoRmj1HX9cZh5uMiXVsX77M
         nhO0r7M8UWI9zW1h716R9E5cw81tIJETB3ZMGl6OEQWHcUsNoW50MFqkV9Dpr0w00VQv
         4Rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936474; x=1783541274;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UOdt1MjTdK+8K0oNK35IqiS1Sh21G9xWYtRVhtEsR+w=;
        b=b5QApT4n5xjICudR1Ea5Wmk+HqgL/E3yctqW+6n+dttcFp4NimDP67P24kvMSXx8k+
         qo6fY3EDGEmfiHT9nMEbiLXiyhCZZ4jXXQX8LaTgisYTZw3FpGpatWMQxJU5SlQEMvzi
         cCqJPf8uMa2oOOzkhq2F6Ir4OcrI5+9+raXPuFc8UhvY8ilwp2zLtnYIT5Y1B3tVNN91
         lUVogsjsXTFCRBj9pexsehGh/uX3RNRdUhjWf3Fe62OZ1klK79b5mL5Fy2NCEZhLjIkP
         3ajn0AvNTb529tg37vaG7dZ13vJojMKcqA5KnI9mtohgRsu1zgxLtQUiUW0b5//KMK2l
         Bkew==
X-Gm-Message-State: AOJu0YyUpf8itZoMrb3DdjXvzlba22ib+i7oHOiLeUxhuoA778mYAz9m
	YSMMZID+hiyN2uRnLDKY7jDkGYJvs/yQWsiGOP7F5fOQPhs1wdnxJ4Yr7oEWHmf2EgYspnkFVeD
	Lc0vMfQ==
X-Received: from pjam22.prod.google.com ([2002:a17:90a:1596:b0:37c:c540:67c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:264a:b0:37f:9ce0:af35
 with SMTP id 98e67ed59e1d1-380aa227dd0mr2771100a91.32.1782936473365; Wed, 01
 Jul 2026 13:07:53 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:07:52 -0700
In-Reply-To: <20260701195652.5DEF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com> <20260701193212.749551-6-seanjc@google.com>
 <20260701195652.5DEF11F000E9@smtp.kernel.org>
Message-ID: <akVzmNTJrsW_U6g8@google.com>
Subject: Re: [PATCH v5 05/51] x86/sev: Mark TSC as reliable when configuring
 Secure TSC
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11790-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:kvm@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FE3A6F1497

On Wed, Jul 01, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> commit cdbd80de837f6d512a759452a18164ddd83b9b7b
> Author: Sean Christopherson <seanjc@google.com>
>=20
> x86/sev: Mark TSC as reliable when configuring Secure TSC
>=20
> This commit moves the setting of the X86_FEATURE_TSC_RELIABLE flag from
> sme_early_init() to snp_secure_tsc_init(). It consolidates the handling o=
f
> known-frequency and reliable TSC flags when overriding the TSC calibratio=
n
> routine.
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but does the early return in
> arch/x86/kernel/tsc.c:tsc_early_init() allow an untrusted hypervisor to
> bypass Secure TSC initialization?
>=20
> The tsc_early_init() function checks is_early_uv_system() before initiali=
zing
> Secure TSC. The is_early_uv_system() check relies on the presence of
> UV_SYSTEM_TABLE_GUID in the EFI configuration tables.
>=20
> Because the hypervisor can provide tables to the guest firmware which may
> expose them as EFI configuration tables, an untrusted hypervisor could in=
ject
> this specific GUID. Would this trick the kernel into returning early,
> bypassing both Secure TSC and TDX TSC initialization, and causing the gue=
st
> to fall back to untrusted legacy timers?

I suppose so?  But that's a problem best handled in a dedicated, separate p=
atch.

>=20
> [Severity: High]
> This is also a pre-existing issue, but should the newly updated
> arch/x86/coco/sev/core.c:snp_secure_tsc_init() validate that the calculat=
ed
> frequency is non-zero before returning?
>=20
> If the calculated frequency evaluates to 0, which could happen if the
> hypervisor causes MSR_AMD64_GUEST_TSC_FREQ to read as 0 or if the secrets
> factor is invalid, the function simply returns 0 instead of terminating
> the VM.

The hypervisor can't do that?  If it can, that too should be addressed sepa=
rately.

> The caller tsc_early_init() treats a return value of 0 as a failure to fi=
nd
> a trusted frequency and gracefully falls back to x86_init.hyper.get_tsc_k=
hz()
> or legacy timers. In a confidential computing threat model, should this
> security-critical initialization fail closed and terminate the VM, rather
> than falling back to the hypervisor-controlled time sources that Secure T=
SC
> is designed to protect against?
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701193212.74=
9551-1-seanjc@google.com?part=3D5

