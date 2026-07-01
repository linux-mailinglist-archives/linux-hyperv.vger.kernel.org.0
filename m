Return-Path: <linux-hyperv+bounces-11791-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DtBDO0N0RWo7AgsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11791-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:10:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BCF6F1510
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:10:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ZVKkUoRW;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11791-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11791-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 295C03048C18
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 20:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AA73B6341;
	Wed,  1 Jul 2026 20:09:47 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FFF2D94BA
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 20:09:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936587; cv=none; b=PfR2sVmg6SJy2ixV5qwAf6wNaE4sXXH++PMrcmJ0zBTSNdW29zLd/Q6UGQ/a05RX9Tf41hD1Cp4byzQOoIADYNCyFyW4NIgbLp0L6pmHSGAf7e+5tjxKTDOZD8pjKNPgSsZqDIfJ+yJofF9/9X2Jmd1zkcAZT1mJ4/lBNp4G+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936587; c=relaxed/simple;
	bh=2Qfo1mE8wNpeyfoDzEnCqeGtUr1juI8OSN/sfUaQCvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mbRdDWK2p3sLXfZxlLCBaRbMgA8Joek7YKlCqM/j0dI4w5K1IbEd1IwssMn4Beb0cF1tJ9LdAKXFUue0BpkOYAat04UO9sVQFYg1jgxI3WH9/HLs0Dh+Hl4loz8FW7PFNFLO7XRn7UQ9GyKgI7QjtDl3MjxaYkljJBxuCGAn7Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZVKkUoRW; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9a700dc0eso8919195ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 13:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782936585; x=1783541385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zS9s/5w9enyucVDs4i1VhSIv4uqANToyaiocSAVztyc=;
        b=ZVKkUoRW15wwMlC38XyzrS7e8BexpI/bJtkNsN917ugZKE28u01RF52ak1BNRDc+GD
         /WibBd6nVm0ELciJSgNyRFNZxt8OCVgXEAQmjhHgbBPI7Fs9Brhi6LGPVkCs3Eb5Qc+5
         tY3JKTldJaboszJAggTm33JTJdaQZD48idNOFyfyceZLK/T5Plgf+5i125H2PmEqRsg2
         kV53W3HrBaJPqlmwntHzb96LvcGdNrkgXeK5YExzW0nvIdvrmx/SAgjPLj75YvKDHQ1M
         u6XCckoH0qUp0ohKsqd2v+YQtzwAvhIHhsX4BE2WVwBBHgNAgevVJU4R0dS2Rk/tRqCA
         hSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936585; x=1783541385;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zS9s/5w9enyucVDs4i1VhSIv4uqANToyaiocSAVztyc=;
        b=lKL+AmZ+f2efgGl1JdksqPYQk+XKCvrUv2vERFXqWjH4aqAGBvkRATufDJ8QG6GM1u
         EwvTbdbwdZip4ETf8toIo+lYNKA++Nsw2g9LWIyjomJ2Zswn+rq/Mzkee0C81gwjGTIc
         SkXAcXWC0kd20qzwiy5C34nfxRUcbj9Nkc+xsdvdxOD1f8X7xK4U0B6LFNC4UzNDiOUf
         cMVG0DymQizhJbRX2i8H68iV0sDPc/FUbEmDsWt2QEFguPdBtOqZAzEfcHWzvNdBmAbg
         x8r/LxTjv+NTF2nmL2PvppUWuGK/8IDZjum6FKFo60198PrMbWjkBkdOh144imVOQTQx
         a+3w==
X-Forwarded-Encrypted: i=1; AHgh+RqCF5HFSVHfxByqXhWYoErzvtF90DO/UyzYrjuh2Voj6lsVaGtcJiKRoVvEl9oQXTx7B6g3l56Qq+qbcUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwARh3CYbACHKbzWwVR0+5KSGqw8lzPIbtqPFOWQNBUAS2Sw8io
	paeb1JFDXM2FURa2kTO+a7WrBC355fMn3W7Ors+kM9RU9LZLY5sggBcZJrmCaBbgcCL9G2rYlMe
	psta8+Q==
X-Received: from plbmk12.prod.google.com ([2002:a17:903:2bcc:b0:2c8:219a:17e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2d2:b0:2ca:b8d:e65e
 with SMTP id d9443c01a7336-2ca7e90cb3cmr33810795ad.37.1782936584763; Wed, 01
 Jul 2026 13:09:44 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:09:44 -0700
In-Reply-To: <20260701195337.2E1F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com> <20260701193212.749551-7-seanjc@google.com>
 <20260701195337.2E1F01F000E9@smtp.kernel.org>
Message-ID: <akV0CHxODhM4Q2zv@google.com>
Subject: Re: [PATCH v5 06/51] x86/sev: Don't override CPU frequency
 calibration for SNP's Secure TSC
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
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
	TAGGED_FROM(0.00)[bounces-11791-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76BCF6F1510

On Wed, Jul 01, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The patch removes the `calibrate_cpu` override to allow the CP=
U base frequency to differ from the TSC frequency, but fails to account for=
 `determine_cpu_tsc_frequencies()` which will forcefully clobber `cpu_khz` =
if it diverges by more than 10%.
> --
>=20
> commit 6d3b9e81661ead5f25434666266aec6514dadaa8
> Author: Sean Christopherson <seanjc@google.com>
>=20
> x86/sev: Don't override CPU frequency calibration for SNP's Secure TSC
>=20
> This commit removes the override of the kernel's CPU frequency calibratio=
n
> routine when registering SNP's Secure TSC. It aims to decouple the CPU ba=
se
> frequency from the TSC frequency, as exposing APERF/MPERF requires an
> accurate CPU frequency.
>=20
> > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> > --- a/arch/x86/coco/sev/core.c
> > +++ b/arch/x86/coco/sev/core.c
> > @@ -2046,7 +2046,6 @@ void __init snp_secure_tsc_init(void)
> > =20
> >  	snp_tsc_freq_khz =3D SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets-=
>tsc_factor);
> > =20
> > -	x86_platform.calibrate_cpu =3D securetsc_get_tsc_khz;
>=20
> [Severity: Medium]
> Will this removal be sufficient to decouple cpu_khz from tsc_khz if they
> diverge significantly?

No, but IMO it's a step in the right direction.

> Looking at determine_cpu_tsc_frequencies() in arch/x86/kernel/tsc.c, ther=
e
> is a generic sanity check that enforces a 10% limit on the difference
> between the two frequencies:
>=20
> arch/x86/kernel/tsc.c:determine_cpu_tsc_frequencies() {
>     ...
>     else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
>         cpu_khz =3D tsc_khz;
>     ...
> }
>=20
> If the true host CPU frequency diverges from the guest TSC frequency by m=
ore
> than 10%, won't this logic forcefully overwrite the correct cpu_khz back =
to
> tsc_khz, unintentionally undoing the fix for the APERF/MPERF calculation?

Probably, but this series is already boiling a pretty large lake, I think t=
he
ocean can be left for a future cleanup.

