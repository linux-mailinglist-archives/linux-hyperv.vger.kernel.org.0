Return-Path: <linux-hyperv+bounces-11545-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /pxlDnfGJ2qx1wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11545-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 09:53:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8970965D632
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 09:53:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="fhT/BnDr";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11545-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11545-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDF6530812AB
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 07:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB703E5EF8;
	Tue,  9 Jun 2026 07:48:12 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDFA3E5EE3;
	Tue,  9 Jun 2026 07:48:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991292; cv=none; b=EEaRFHt0w7kNcCfULhcLp5Qyu86gnx4HdIST2JRfYADdZTRkZY69v9e88hJPwa6l6RdiYKfx7MqKJqsZcZ86kHzGZJWwqkT3vA1zzwhmaRiFD3IdgstbY9DuxSncZ3hd1BplMYnEJZ5+aLY/GUdALUeLxKCvaDojLQlhSFKJgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991292; c=relaxed/simple;
	bh=ZBX5eahzd46CUbwIFun4qVkUb3QTM+g7fn0ziOL7Zx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i+xLbsH5B/AdRFAIAZXqVCbK4/yx/OJdO/iJH+K29HTkXq1o9U+a+YFQFRKutJaRjDPzyh85f7/Veo9++YOdY33qWBpME9NO8rNgIDGLDIJYHJuD58DXV6/fcKDHlotI15aip+Jpr6AQg9J56WlmDCvAgLpEvWbyVhfBh/mvzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhT/BnDr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB4D1F00893;
	Tue,  9 Jun 2026 07:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780991290;
	bh=iiljLo4Dj3SESslIfwzIuSptLw3aAN39KXfU2xj2Ngk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fhT/BnDr+KIL6FSHMueMDrXiAeihxCx9XYmV4sQEsCrgZ1a/wLUlA82c1I6chu2MM
	 rwKusfZOsEM3kx5pEdK9ggrNvlOkxF1bXbC0sEg1cxOzYdFCuBBw2Q4HB3K+Tk2mgF
	 cv0n962KH23nlUg4uss93akTXM5KJMfq8JYgGQ0evU2dHo+DKQ9+YcNw/k+9RPPLKp
	 J47WOewPhoa36WNJqXt4oaEjhDK0itmBDVBlKuYN0GyqnPG07ArrFllQqbbqboqHCC
	 oIieu3huEj6Hct6nh+p+M18BgnBSbKYb1ebIk/0iA2wklf1pZ6SvQa5gkT9+Y/gL8Z
	 WvHbYAtwWzDSg==
From: Thomas Gleixner <tglx@kernel.org>
To: Sean Christopherson <seanjc@google.com>, David Woodhouse
 <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, Tom
 Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 10/47] x86/tsc: Consolidate forcing of
 X86_FEATURE_TSC_KNOWN_FREQ for PV code
In-Reply-To: <aidEfvTMjLa2zt43@google.com>
References: <20260529144435.704127-1-seanjc@google.com>
 <20260529144435.704127-11-seanjc@google.com> <877boc554l.ffs@fw13>
 <eef867eae15e30d08482ba16a1a32159745b64a7.camel@infradead.org>
 <aidEfvTMjLa2zt43@google.com>
Date: Tue, 09 Jun 2026 09:48:07 +0200
Message-ID: <87a4t440js.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11545-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[redhat.com,alien8.de,linux.intel.com,kernel.org,microsoft.com,broadcom.com,siemens.com,infradead.org,suse.com,google.com,zytor.com,intel.com,oracle.com,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amd.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:dwmw2@infradead.org,m:pbonzini@redhat.com,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:hpa@zytor.com,m:rick.p.edgecombe@intel.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8970965D632

On Mon, Jun 08 2026 at 15:38, Sean Christopherson wrote:
> On Sat, Jun 06, 2026, David Woodhouse wrote:
>> > Along with:
>> >=20
>> > =C2=A0=C2=A0 if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tsc_khz_early)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("Ignoring non=
-sensical tsc_early_khz command line argument\n");
>> >=20
>> > or something daft like that.
>
> Ya, I ended up in the same place once Sashiko pointed out that skipping t=
he SNP/TDX
> setup was hazardous[*], and also once I realized that tsc_khz_early *comp=
lemented*
> the refinement instead of replacing it.
>
> This is what I have locally:
>
>         if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
>                 known_tsc_khz =3D snp_secure_tsc_init();
>         else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
>                 known_tsc_khz =3D tdx_tsc_init();
>
>         /*
>          * If the TSC frequency wasn't provided by trusted firmware, try =
to get
>          * it from the hypervisor (which is untrusted when running as a C=
oCo guest).
>          */
>         if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
>                 known_tsc_khz =3D x86_init.hyper.get_tsc_khz();
>
>         /*
>          * Mark the TSC frequency as known if it was obtained from a hype=
rvisor
>          * or trusted firmware.  Don't mark the frequency as known if the=
 user
>          * specified the frequency, as the user-provided frequency is int=
ended
>          * as a "starting point", not a known, guaranteed frequency.
>          */
>         if (known_tsc_khz && !tsc_early_khz)
>                 setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);

If the frequenct is known via the above then you want to set the
KNOWN_FREQ feature bit unconditionally. SNP/TDX/hypervisor override the
command line argument as you print below.

>         /*
>          * Ignore the user-provided TSC frequency if the exact frequency =
was
>          * obtained from trusted firmware or the hypervisor, as the user-
>          * provided frequency is intended as a "starting point", not a kn=
own,
>          * guaranteed frequency.
>          */
>         if (!known_tsc_khz)
>                 known_tsc_khz =3D tsc_early_khz;
>         else if (tsc_early_khz)
>                 pr_err("Ignoring 'tsc_early_khz' in favor of firmware/hyp=
ervisor.\n");

>> All the nonsense about updating it every time we enter a CPU could just
>> go away completely.
>
> But to Thomas' point, why bother?  For actual old hardware, kvmclock is w=
hat it
> is.  For modern hardware, it's completely antiquated.

I agree, but we are not forced to make it a first class citizen to the
detriment of sane systems.

Thanks,

        tglx

