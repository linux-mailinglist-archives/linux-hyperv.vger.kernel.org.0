Return-Path: <linux-hyperv+bounces-11541-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cnN7AoZEJ2qSuAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11541-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 00:39:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C39165B014
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 00:39:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rRKkkdlT;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11541-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11541-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42AFD302F683
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jun 2026 22:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDC53B2FE4;
	Mon,  8 Jun 2026 22:38:57 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1813B2FCE
	for <linux-hyperv@vger.kernel.org>; Mon,  8 Jun 2026 22:38:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958337; cv=none; b=M/yIVm4027CwgxF/qOe/HP4VbELzaVQdryVvlOGsD8v0kvNl/E713CsWwSzWkVJy/SWXO6otv278Ut6UoN+q891ylFIWvSPZJHCBI/C6ikq0N4KQdDnDk7NZjaR1X7E/rKQ1+bTjgAm6Tossfd51OUvztl+s0xiLdVcrpMLjMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958337; c=relaxed/simple;
	bh=g0z45+aYiJC51GAUvnfRAO2uYrqdMzpO8Z4vJI4yeCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hiHGBHwrMKo3CMwmCzVr02akMIYnbNSR6OMlVl1MlycHiSJqRU4z69+Wy9Vhh5qgaGqOAdkDszhmV6PysCh9X1SLUANC8u95cD49o2D3/yX7FMVi4wyQnpULkIequMsQgEeItSp1PF0dyBM/IWp9EmHsfVS4hNMXv2LKqdxgFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRKkkdlT; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0532a6588so46261195ad.0
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Jun 2026 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780958335; x=1781563135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/e8MVVf+gn1nbLHbwfdQ87xOkjbdduwr2NDuGKxrzw=;
        b=rRKkkdlTgxOw/XR5ERUnqkzpmbXai+ki2s8Px+pwOgnqGW4WnSpIqlT5DK4sRnwbwB
         2tW3kQl8wEtOTM97fer7Nky9ftFEaH2i0grKjn3MAuzFr0STXAdGbX6cZku7MWLYo2dv
         zToHu1Iu5ERH0SJDktD8JkFxXKM12iFg9vNlEXxIBOUaYSJ2hIZb5dQLBy8OakB87auF
         y/8dHnk/h+Xx77pSx3eKeIazoZ7H0s4a9igi/4il+/Y6KGgQp4m8Dzus+RFfLR8Sg+7e
         hKskDRh3gaApq4SFfkTJ5yKEK83QTPceN7N+QxieG069wt9ffI4EUOy9bxxI6kTPC58i
         HEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780958335; x=1781563135;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6/e8MVVf+gn1nbLHbwfdQ87xOkjbdduwr2NDuGKxrzw=;
        b=ePWKbp2Gul1McMNBgJ02Seutxsb8C7yyQ0+0YRoRrFgchh0pt6GyQRKmjAYLXrA7eZ
         tYlEYOzhOT/B7J5e1BDafAO49fJ09nKJuXN+Xm6jz3avDAfnL5+38v15bylJuQeE9pZw
         S2795sXIz+dwiC+9KISErtawk5lGopYcOjA1YPx16p73slwBr0U/j0w9P4jRgewy8wK9
         KsOh/8g0KN0S8RDMLlXcQlkuvCnWg+/u3mLPh7hMkg1+tuNm68ol5eoOGJGjhjEh2UfK
         yl2d1r5rPc9vKsaUVS8BcoqbycO7wpZWlcS5cQWj1RSxXDUsuiYFJUc1kE8WBMZSHm0Z
         Sj+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+pxkhs2psmmP2KoaLRayU+uTjRnHLE/bHpBsgmoJ+nplVpg1ApnXMSA7SWMFJ2ewdLPSwGZEFGYQZ0uA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5M3sejvrgBpzdwjvRdYeWfkiVBYDaJ8N/h2dkOmlhAVaoEuD8
	YE9BLXWxl7dIZgONK/xQ3sn9aIVO5aUq0WJftQVU/gcTqgrM1Nzh562dXEJp99VViBlpDqfOnRs
	Q+JuGKA==
X-Received: from pldv17.prod.google.com ([2002:a17:902:ca91:b0:2b0:ba5a:1fe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8d:b0:2be:fda1:42d9
 with SMTP id d9443c01a7336-2c1e7845a08mr176535715ad.0.1780958335144; Mon, 08
 Jun 2026 15:38:55 -0700 (PDT)
Date: Mon, 8 Jun 2026 15:38:54 -0700
In-Reply-To: <eef867eae15e30d08482ba16a1a32159745b64a7.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com> <20260529144435.704127-11-seanjc@google.com>
 <877boc554l.ffs@fw13> <eef867eae15e30d08482ba16a1a32159745b64a7.camel@infradead.org>
Message-ID: <aidEfvTMjLa2zt43@google.com>
Subject: Re: [PATCH v4 10/47] x86/tsc: Consolidate forcing of
 X86_FEATURE_TSC_KNOWN_FREQ for PV code
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11541-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,microsoft.com,broadcom.com,siemens.com,infradead.org,suse.com,google.com,zytor.com,intel.com,oracle.com,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amd.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_RECIPIENTS(0.00)[m:dwmw2@infradead.org,m:tglx@kernel.org,m:pbonzini@redhat.com,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:hpa@zytor.com,m:rick.p.edgecombe@intel.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:mhklinux@outlook.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C39165B014

On Sat, Jun 06, 2026, David Woodhouse wrote:
> On Sat, 2026-06-06 at 12:34 +0200, Thomas Gleixner wrote:
> > On Fri, May 29 2026 at 07:43, Sean Christopherson wrote:
> >=20
> > > Now that all paravirt code that explicitly specifies the TSC frequenc=
y
> > > also sets X86_FEATURE_TSC_KNOWN_FREQ, replace all of the one-off code
> > > and simply set X86_FEATURE_TSC_KNOWN_FREQ if the TSC frequency is kno=
wn.
> > >=20
> > > Do NOT force set TSC_KNOWN_FREQ if the "known" TSC frequency was prov=
ided
> > > by the user.=C2=A0 Per commit bd35c77e32e4 ("x86/tsc: Add tsc_early_k=
hz command
> > > line parameter"), one of the goals of the param is to allow the refin=
ed
> > > calibration work "to do meaningful error checking".
> > >=20
> > > Note, preferring the user-provided TSC frequency over the frequency f=
rom
> > > the hypervisor or trusted firmware, while simultaneously not treating=
 the
> > > user-provided frequency as gospel, is obviously incongruous.=C2=A0 Sw=
eep the
> > > problem under the rug for now to avoid opening a big can of worms tha=
t
> > > likely doesn't have a great answer.
> >=20
> > There is a good answer I think.
> >=20
> > early_tsc_khz exists to cater for the overclocking crowd. On their
> > modded systems the firmware supplied TSC frequency (CPUID/MSR) is not
> > matching reality anymore. So they work around that by supplying a close
> > enough tsc_early_khz and then they let the refined calibration work
> > figure it out.
> >=20
> > Arguably that's only relevant for bare metal systems and what's worse i=
s
> > that in virtual environments the refined calibration work can fail,
> > which renders the TSC unstable.
> >=20
> > So I'd rather say we change this logic to:
> >=20
> > =C2=A0=C2=A0 if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tsc_khz =3D x86_init.....();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 force(X86_FEATURE_TSC_KNOWN_FREQ);
> > =C2=A0=C2=A0 } else if (tsc_khz_early) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ....
> > =C2=A0=C2=A0 } else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0 }
> >=20
> > Along with:
> >=20
> > =C2=A0=C2=A0 if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tsc_khz_early)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("Ignoring non-=
sensical tsc_early_khz command line argument\n");
> >=20
> > or something daft like that.

Ya, I ended up in the same place once Sashiko pointed out that skipping the=
 SNP/TDX
setup was hazardous[*], and also once I realized that tsc_khz_early *comple=
mented*
the refinement instead of replacing it.

This is what I have locally:

        if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
                known_tsc_khz =3D snp_secure_tsc_init();
        else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
                known_tsc_khz =3D tdx_tsc_init();

        /*
         * If the TSC frequency wasn't provided by trusted firmware, try to=
 get
         * it from the hypervisor (which is untrusted when running as a CoC=
o guest).
         */
        if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
                known_tsc_khz =3D x86_init.hyper.get_tsc_khz();

        /*
         * Mark the TSC frequency as known if it was obtained from a hyperv=
isor
         * or trusted firmware.  Don't mark the frequency as known if the u=
ser
         * specified the frequency, as the user-provided frequency is inten=
ded
         * as a "starting point", not a known, guaranteed frequency.
         */
        if (known_tsc_khz && !tsc_early_khz)
                setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);

        /*
         * Ignore the user-provided TSC frequency if the exact frequency wa=
s
         * obtained from trusted firmware or the hypervisor, as the user-
         * provided frequency is intended as a "starting point", not a know=
n,
         * guaranteed frequency.
         */
        if (!known_tsc_khz)
                known_tsc_khz =3D tsc_early_khz;
        else if (tsc_early_khz)
                pr_err("Ignoring 'tsc_early_khz' in favor of firmware/hyper=
visor.\n");

[*] https://lore.kernel.org/all/ahnF-FehodVd474X@google.com

> > The kernel has for various reasons always tried to cater for the needs
> > of users who are plagued by bonkers firmware, but we have to stop to
> > prioritize or treating equal ancient and modded out of spec hardware.
> >=20
> > TBH, I consider that whole KVM clock nonsense to fall into the modded
> > out of spec hardware realm. Do a reality check:
> >=20
> > =C2=A0=C2=A0 How many production systems are out there still which run =
VMs on CPUs
> > =C2=A0=C2=A0 with a broken TSC and the lack of VM TSC scaling?
> >=20
> > I'm not saying that we should not support the few remaining systems
> > anymore, but our tendency to pretend that we can keep all of this
> > nonsense working and at the same time making progress is just a fallacy=
.

FWIW, I have the exact same sentiments about kvmclock, but I'm also trying =
my
best not to break folks that are happily running on what is effectively fla=
wed,
ancient "hardward".=20

> I don't know that we can take the KVM (and Xen) clock away from guests,
> but all of the *horrid* part about it is the way it attempts to cope
> with the possibility that the *host* timekeeping might flip away from
> TSC-based mode at any point in time. By the end of my outstanding
> cleanup series, that is the *only* thing the gtod_notifier remains for.
>=20
> If we can trust the hardware *and* the host kernel, then KVM could
> theoretically hardwire the kvmclock into 'master clock mode' where it
> basically just advertises the TSC=E2=86=92kvmclock relationship *once* to=
 all
> CPUs and it never changes.
>=20
> All the nonsense about updating it every time we enter a CPU could just
> go away completely.

But to Thomas' point, why bother?  For actual old hardware, kvmclock is wha=
t it
is.  For modern hardware, it's completely antiquated.

