Return-Path: <linux-hyperv+bounces-11084-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKKuBeksDmrz7gUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11084-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 23:51:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2514D59B5C9
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 23:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E5363008D1F
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DCA372B4B;
	Wed, 20 May 2026 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mID9EuvA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7333644D1
	for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309876; cv=none; b=a3MUkVIxVwo6Bkgxy0/za9koIgBTiRokLwnl0j9xaGM23SoXTYKETxqX9RtBZirxSpj17H84G6wDRhjsINBTQ4eVXhZcAqxD3HAlPA1aGikHVFS247PVUhfyJu/jLgg1H+3iPbmrnsqJKfs79g/5MSSKFFX7dKlGUHzG8f+KYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309876; c=relaxed/simple;
	bh=IW0P0lI7zkBdW6OLQZ3hQpRobomfyoPHqaWIuK3lA7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zy/ReFIZXsrZYkwGnaFUE1LulJfqTQdeLO14gkadExNynC7Jd8exwkgQ590tniE+R2c7KE+IrmThgQ+3hMAKIBeSdV+RrUOF6tW4os+T6vbzACEq5os4YtbLoLKjHwn2GPnSnjBEU3LQWEHP+7fIj8BeIbxL5egt7l+dKO8P2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mID9EuvA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83cecc22d5fso2710011b3a.2
        for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779309874; x=1779914674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mknx5aOiI2gHqgCD2H8iHmrBA38hthuUh1cz4/8g/LE=;
        b=mID9EuvAW0u/A4WfZOo77IBVr2CLCReaozhsEMfWMdwNPu7hOi9jDKoPGF7Svq4R9C
         FftY5EMM3Ow/CAVCa7cxgNh4qwSJkpuUmMjVz45ub+o4BPr8211K7lrdxYKtLQE7PKNu
         kTo4yNjTgLadFSTPKVAYXFZ3fnHtrD1OfPZ2fko81laSTF+hMZv+idRSlUbsN4eby+09
         QPqOUacZNUGcUmXeGXOXGZN+yf5EMQscqSGOH/kxBv/BCXWK1zSpTiYGU+5vtyP3ZPud
         fvMBpsaRdz6KA2wt+AP0MZa14Uf9XBXkCWftdAn0VxyARcTifIgFQrggklAAXNJV0PIi
         vVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779309874; x=1779914674;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mknx5aOiI2gHqgCD2H8iHmrBA38hthuUh1cz4/8g/LE=;
        b=VSf1UC0q/Kz/a4u+rNRn9oKKlW5ZWtQB//PvTo9oNOOL0tOLrn2hsvvJqPv6gMrq4v
         HvDDfUlf6WQdLzQy/h35+o5cBi3uMURQm0Rg+of+SPPnr7qyo2FnW0g1nWjOuF3cbRy9
         uvAh6LPEoM9vHiPJ7/nq0MKRGnMJRI1n+GPL+WfduKZQh0jC9RHAbEdgqAva7Tn/Q1Me
         E6XvhVCnowd6gpA+e1KcI/tqhmC+hJS8V8xg3ZuD7K2NviXheOU6CIdTpmfqC+3rZMDk
         JQ0qDxZiEPlZi59kEcUFPbKvK6GnlgiIbBwzxHv2CzHKadeGYkhVSoyN+o/f5sWDMsko
         eibw==
X-Forwarded-Encrypted: i=1; AFNElJ8H2sLfl4VlUh4sl8VaUrZ3gqUQ+dQbPUEFwhQGGPp2hcviYmqovIVv+5Sed/K2cIgX8keiICv5bzMUBgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdveAyN96EoIPIUAB+4pkBPeMfTaIUtiZxl0J4+SKAaK2+oqG
	aMRD1EmX/ne0ec8Cfk76YPgwv/y2c6ZTtEZkT/GzwNRQuvphvSuRmaT0UXcn1NmwC5jTHQ3lDSS
	G7Xi8gw==
X-Received: from pfbmd16.prod.google.com ([2002:a05:6a00:7710:b0:838:4903:1f13])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c86:b0:837:eaa9:381f
 with SMTP id d2e1a72fcca58-8414aaf9e7emr187969b3a.0.1779309873801; Wed, 20
 May 2026 13:44:33 -0700 (PDT)
Date: Wed, 20 May 2026 13:44:33 -0700
In-Reply-To: <44e0d60548d317fd59895f18bd17220dfb2f834b.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-3-seanjc@google.com>
 <44e0d60548d317fd59895f18bd17220dfb2f834b.camel@infradead.org>
Message-ID: <ag4dMc2B3JQi4vxU@google.com>
Subject: Re: [PATCH v3 02/41] x86/tsc: Add helper to register CPU and TSC freq
 calibration routines
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11084-lists,linux-hyperv=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[34];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2514D59B5C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026, David Woodhouse wrote:
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index b5991d53fc0e..e9e7394140dd 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> > @@ -321,8 +321,8 @@ void __init kvmclock_init(void)
> > =C2=A0	flags =3D pvclock_read_flags(&hv_clock_boot[0].pvti);
> > =C2=A0	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
> > =C2=A0
> > -	x86_platform.calibrate_tsc =3D kvm_get_tsc_khz;
> > -	x86_platform.calibrate_cpu =3D kvm_get_tsc_khz;
> > +	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz);
> > +
> > =C2=A0	x86_platform.get_wallclock =3D kvm_get_wallclock;
> > =C2=A0	x86_platform.set_wallclock =3D kvm_set_wallclock;
> > =C2=A0#ifdef CONFIG_X86_LOCAL_APIC
>=20
> Can we move those (and maybe everything in the context there too) up
> *before* the check for no-kvmclock at the top of the function?

Oof, I was going to say "no", but disabling kvmclock is exactly the workaro=
und
I've told people to use to get the kernel to use the TSC instead of kvmcloc=
k.

> Probably in a separate patch.

Ya.  I think this?

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 08ee4bc304c8..92a1ebf31e4d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -27,6 +27,7 @@ static int kvmclock_vsyscall __initdata =3D 1;
 static int msr_kvm_system_time __ro_after_init;
 static int msr_kvm_wall_clock __ro_after_init;
 static u64 kvm_sched_clock_offset __ro_after_init;
+static unsigned int kvm_tsc_khz_cpuid __ro_after_init;
=20
 static int __init parse_no_kvmclock(char *arg)
 {
@@ -207,7 +208,7 @@ static unsigned long kvm_get_tsc_khz(void)
                lapic_timer_period =3D apic_khz * 1000 / HZ;
 #endif
=20
-       return kvm_para_tsc_khz() ? : pvclock_tsc_khz(this_cpu_pvti());
+       return kvm_tsc_khz_cpuid ? : pvclock_tsc_khz(this_cpu_pvti());
 }
=20
 static unsigned long kvm_get_cpu_khz(void)
@@ -387,9 +388,39 @@ void __init kvmclock_init(void)
        enum tsc_properties tsc_properties =3D TSC_FREQUENCY_KNOWN;
        bool stable =3D false;
=20
-       if (!kvm_para_available() || !kvmclock)
+       if (!kvm_para_available())
                return;
=20
+       /*
+        * If the TSC counts at a constant frequency across P/T states, cou=
nts
+        * in deep C-states, and the TSC hasn't been marked unstable, treat=
 the
+        * TSC reliable, as guaranteed by KVM.  Note, the TSC unstable chec=
k
+        * exists purely to honor the TSC being marked unstable via command
+        * line, any runtime detection of an unstable will happen after thi=
s.
+        */
+       if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
+           boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
+           !check_tsc_unstable())
+               tsc_properties =3D TSC_FREQ_KNOWN_AND_RELIABLE;
+
+       kvm_tsc_khz_cpuid =3D kvm_para_tsc_khz();
+
+       /*
+        * If provided, use the TSC (and APIC bus) frequency provided in KV=
M's
+        * PV CPUID leaf even if kvmclock itself is disabled via command li=
ne.
+        * The PV CPUID information isn't dependent on kvmclock in any way,=
 and
+        * in fact using the precise information is *more* important when t=
he
+        * user has explicitly disabled kvmclock to force the kernel to use=
 the
+        * TSC as its clocksource.
+        */
+       if (!kvmclock) {
+               if (kvm_tsc_khz_cpuid)
+                       tsc_register_calibration_routines(kvm_get_tsc_khz,
+                                                         kvm_get_cpu_khz,
+                                                         tsc_properties);
+               return;
+       }
+
        if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
                msr_kvm_system_time =3D MSR_KVM_SYSTEM_TIME_NEW;
                msr_kvm_wall_clock =3D MSR_KVM_WALL_CLOCK_NEW;
@@ -424,21 +455,14 @@ void __init kvmclock_init(void)
        }
=20
        /*
-        * If the TSC counts at a constant frequency across P/T states, cou=
nts
-        * in deep C-states, and the TSC hasn't been marked unstable, prefe=
r
-        * the TSC over kvmclock for sched_clock and drop kvmclock's rating=
 so
-        * that TSC is chosen as the clocksource.  Note, the TSC unstable c=
heck
-        * exists purely to honor the TSC being marked unstable via command
-        * line, any runtime detection of an unstable will happen after thi=
s.
+        * If the TSC is reliable (see above), prefer the TSC over kvmclock=
 for
+        * sched_clock and drop kvmclock's rating so that TSC is chosen as =
the
+        * clocksource.
         */
-       if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
-           boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
-           !check_tsc_unstable()) {
+       if (tsc_properties & TSC_RELIABLE)
                kvm_clock.rating =3D 299;
-               tsc_properties =3D TSC_FREQ_KNOWN_AND_RELIABLE;
-       } else {
+       else
                kvm_sched_clock_init(stable);
-       }
=20
        tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_cpu_khz,
                                          tsc_properties);

