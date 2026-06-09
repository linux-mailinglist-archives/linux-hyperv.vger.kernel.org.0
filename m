Return-Path: <linux-hyperv+bounces-11554-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i7IvEn8IKGqv7gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11554-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 14:35:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D86660179
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 14:35:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=DU+WTCSR;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11554-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11554-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D91FE301FD40
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836803FBEC6;
	Tue,  9 Jun 2026 12:28:28 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3D408602
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 12:28:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008108; cv=none; b=BTxinfiKRKpnKE3Is8xk68NIUtoYfCzbzB1dVOSX7tnIb7Jqj9Gxra7on79WuZBcIG/9OJ1qANa1ZTEyxvnyesoPK3ZuvC9asIWwV6cno/eSHMSA4y9obT0VVtHHXkm8hYGm9I2QskLRtiNQKwjkvdzhjeUZLiRUzMk00aC3/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008108; c=relaxed/simple;
	bh=lGEDaxP9s5MVbkz0GqDIcVYCTfkJX1Q1PY4dt58kBow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U1aVjhpyqyv2Ns1WCNGJcbibNrktnNe5R+VKXHZqkA3PLtCXgFTwrdA3k+Uu/m+xLS0zjuo0NsdsWzCshARTyc55NpUGrUQN/qB/9+8m24me0gJaIx+Ns/V8cF3PmD9H0oLvvfhF6qXrAgaqqQx1iVKrdKwmdDA6IpnMu97bnX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DU+WTCSR; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8425a9979e1so3773236b3a.2
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Jun 2026 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781008107; x=1781612907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unmnrNbCXlEEjkFhHM3DLJAuHv468WBx57rOjaror7w=;
        b=DU+WTCSRssJwa5wdtrb4CWbSufN3OC0Prz86X0WlYIDJI+tJgnlOg6zPqp+N4CDzFW
         FCKi8B17p5aS0Yi2MEADjSiwugwoaxswbwIQZWQQsj/6H2MlT8ZMYahbTTpYWOukY6wV
         RnU6+HrAcEJmpcuwuQjFkHITFNwhE/5j0PEr4p1RAt+ZrGr9lb3NAVHMY5LwMHBoRbAq
         XP8exaSCqWeLrDm3/eOnLqNfmPA/qnThrR5vMvCgaY8BrDwlhkr1e77FyWj6XdJm2bBo
         TPZ6hLalYkmWqS2mNlsvmbBa42aYETE+dDZgwqd5HCCFBsQa3T3E0ViAPj5Gaubcljli
         jq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781008107; x=1781612907;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=unmnrNbCXlEEjkFhHM3DLJAuHv468WBx57rOjaror7w=;
        b=CCAM2S840HEpi8VWZKvirjNVrnFRAKrk0Ru+16dTFCYyCNuTPljynJ+bzEO7HxJ4Sd
         hP4/aHjKo+3lO1USJB51hnTSla5GMOukEWvaP6KZwsS9Gbv2jIpta6ToJM7XFdd0ZzeL
         OcY7eeyLr0Wp22I+SCgNRYNPqT3AOOUad5nCl7JS717Gddh3jkuiTCK8mdxuy1Ep7AFy
         Ek06jgigzpCVIYGEVx4BLGjYUHb0oC1sRNK3R6zNZj8Qhz0HGOlO1b6BhmdqTREnuJAy
         l+YTFq1f6V6q77EtIcRxH2tDWpnjrXRlVWaC5ltztwxT/UdWELkoql0/Zm0e2JOxQcB+
         VIrg==
X-Forwarded-Encrypted: i=1; AFNElJ8d90aRWsfUkhmh/buSe0HKmoOJ9xBz5t3qaXpV7+zf+JgjHNl3rhIz76vzVVeJ+Pz5yzOdolrInnRrZBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZ3CTtqSmtrNfEpepDTT5hLz1+yMZDcrn6+v7t8UrEzY8Q2X6
	OMjA6N8RgHwjsTLLPA68ap8xVZsMxlirmtw2hHeBVDsbFUoScAcmtoQjjw2zprN67fNQxGuTker
	aLwBhyg==
X-Received: from pfjf5.prod.google.com ([2002:a05:6a00:22c5:b0:842:4720:4013])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2910:b0:842:6fce:6171
 with SMTP id d2e1a72fcca58-8430a62f307mr3223335b3a.3.1781008106459; Tue, 09
 Jun 2026 05:28:26 -0700 (PDT)
Date: Tue, 9 Jun 2026 05:28:24 -0700
In-Reply-To: <87a4t440js.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com> <20260529144435.704127-11-seanjc@google.com>
 <877boc554l.ffs@fw13> <eef867eae15e30d08482ba16a1a32159745b64a7.camel@infradead.org>
 <aidEfvTMjLa2zt43@google.com> <87a4t440js.ffs@fw13>
Message-ID: <aigG6NdLZtbc7prD@google.com>
Subject: Re: [PATCH v4 10/47] x86/tsc: Consolidate forcing of
 X86_FEATURE_TSC_KNOWN_FREQ for PV code
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11554-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:dwmw2@infradead.org,m:pbonzini@redhat.com,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:hpa@zytor.com,m:rick.p.edgecombe@intel.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,alien8.de,linux.intel.com,kernel.org,microsoft.com,broadcom.com,siemens.com,suse.com,google.com,zytor.com,intel.com,oracle.com,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amd.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86D86660179

On Tue, Jun 09, 2026, Thomas Gleixner wrote:
> On Mon, Jun 08 2026 at 15:38, Sean Christopherson wrote:
> > On Sat, Jun 06, 2026, David Woodhouse wrote:
> >> > Along with:
> >> >=20
> >> > =C2=A0=C2=A0 if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tsc_khz_early)
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("Ignoring n=
on-sensical tsc_early_khz command line argument\n");
> >> >=20
> >> > or something daft like that.
> >
> > Ya, I ended up in the same place once Sashiko pointed out that skipping=
 the SNP/TDX
> > setup was hazardous[*], and also once I realized that tsc_khz_early *co=
mplemented*
> > the refinement instead of replacing it.
> >
> > This is what I have locally:
> >
> >         if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> >                 known_tsc_khz =3D snp_secure_tsc_init();
> >         else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
> >                 known_tsc_khz =3D tdx_tsc_init();
> >
> >         /*
> >          * If the TSC frequency wasn't provided by trusted firmware, tr=
y to get
> >          * it from the hypervisor (which is untrusted when running as a=
 CoCo guest).
> >          */
> >         if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
> >                 known_tsc_khz =3D x86_init.hyper.get_tsc_khz();
> >
> >         /*
> >          * Mark the TSC frequency as known if it was obtained from a hy=
pervisor
> >          * or trusted firmware.  Don't mark the frequency as known if t=
he user
> >          * specified the frequency, as the user-provided frequency is i=
ntended
> >          * as a "starting point", not a known, guaranteed frequency.
> >          */
> >         if (known_tsc_khz && !tsc_early_khz)
> >                 setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>=20
> If the frequenct is known via the above then you want to set the
> KNOWN_FREQ feature bit unconditionally. SNP/TDX/hypervisor override the
> command line argument as you print below.

Doh, forgot to remove that check when I shuffled things around.  Thank you!

