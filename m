Return-Path: <linux-hyperv+bounces-11067-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPlzB1D4DWry4wUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11067-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 20:07:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE82595561
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 20:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A0313122548
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C223F6619;
	Wed, 20 May 2026 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tF4Y7bnv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A5E4F5E0
	for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299998; cv=none; b=uF2a9yDN9sxzhGxp1qncLKrbCpXPYIy5uhJtLZSuwX+s+o+jRWz+qRhSNzCFfH7xiKty/InQe0hvIMI+pB6lbqlQV7kW8ZIopH1hVFVr/iH0q9AUVfCuVG85kw/zmOwsxhVNWuQDOWtAeEqoN2FvqAv5lgOx0lnxMn9G85OVyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299998; c=relaxed/simple;
	bh=dO19ZIhQCWsYMmrxTaUpUGG1PvauafKv/vB6jcGBVQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cpCRRWL+duYyFQtHcqeIT/gZDIOUpq3D7YA4JUYlJ1XC+ANURFSDc9pTdkZVfJgAqIWVnJTr+kr27sw30rbZ3ZyyZzEi1Dqyr9N1XI9ogVdUJC0rczuf8aUaFfZB+7iKMStaFm5rBCXvZCunVTfToj4+BxYoesCZ/J1ra40uyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tF4Y7bnv; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83544d05c5aso2564720b3a.2
        for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779299996; x=1779904796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CN4Zn2M2jJcMvhiuUJl3O5eQtI7RDh/+btUc2M7YWms=;
        b=tF4Y7bnvmelvJ/9SA5mp9fpDR4nHjLtN1pq05uXBQ6E2xK7xhnND+XQATXdLIF/J/X
         3vztRLP7+jOz+5cjIGMUqq8xMYTCqVhtlTUNbqwaYUvSyC+V3kSUKxB4A0vdCbs82iDf
         0rtM0+vmeQmRJWZ4Zu4lAPXu206MmHYRBEICf1uKsPiUaOK84Cxliz2OVtMSKmaO2IOJ
         4sNn936iu/6Y5IEcScaSzJQg8JtX88GpFKiRgefblzQYcX6b5f4WMiSBnPkpnshpWqx+
         YJAHZxCFAPKJnCRQJO2A74bl6GVQBIgZohB1EkzSlTQyuJTuHSnjgFecx+PskIOeZqht
         kyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779299996; x=1779904796;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CN4Zn2M2jJcMvhiuUJl3O5eQtI7RDh/+btUc2M7YWms=;
        b=Ge3w5fL6HGU9z0XrzTVKy1Z4Ke79/4k0g1y7kCSfsTJu0f1Meyj7f+j1v9n5BoAQC8
         d8A3GNyvprtRWAyL2LKtmkEtBnBKC1/xKGPMLmJ4r0TJp5N/3em+ZIsjCn7O8UWQpxci
         aSABsj6Qb597jrIlyLAXlXNH162jWFW5WkvthUQnKwNMw5z6SOjquSpsj/jmhne+u/B+
         5jIkHVMlUdjkeyoYkuaBSVhvPaKli5gUTySJoPA9GmB9+dXoFv4LPdBS4hjrcDjbScTe
         7ODAtZo0dSx8S9xhv4uCcGLsfCY302VGQzP+ZWsPd4KHGNLYX5dBJanlf1RgebdRr4qc
         XumA==
X-Forwarded-Encrypted: i=1; AFNElJ+qyEZPzvZKwNmnMdKk9YHlgmflgSreVFa5noi7uxww3d7K8mU7HHPk7CQxTlcrXEdzH9eFIqjL05HGcuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEvuKNb7ad/MGlE3HcuYRuCi5f09NiUKoPwcX+A32IYNe+jAX1
	on1bUw9AV0z9R71mnLoV5/hqwdwxg/IXuxl/7r9W8FTNy9+A/BoDLUIycjh0vL0G6tPDU1omVuT
	raZKgNw==
X-Received: from pfblu4.prod.google.com ([2002:a05:6a00:7484:b0:83a:58c1:f5e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2449:b0:835:405a:7e72
 with SMTP id d2e1a72fcca58-83f33c24d1cmr24352155b3a.11.1779299995865; Wed, 20
 May 2026 10:59:55 -0700 (PDT)
Date: Wed, 20 May 2026 10:59:55 -0700
In-Reply-To: <7260682b21c28d1299e58400b9a2f4b8d23bd434.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <7260682b21c28d1299e58400b9a2f4b8d23bd434.camel@infradead.org>
Message-ID: <ag32mwLvHpWn2vCt@google.com>
Subject: Re: [PATCH v3 00/41] x86: Try to wrangle PV clocks vs. TSC
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11067-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BBE82595561
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026, David Woodhouse wrote:
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > Dave/Thomas/Peter/Boris, what's the going rate for bribes to take somet=
hing
> > like this through the tip tree?
> >=20
> > The bulk of the changes are in kvmclock and TSC, but pretty much every
> > hypervisor's guest-side code gets touched at some point.=C2=A0 I am rea=
onsably
> > confident in the correctness of the KVM changes.=C2=A0 Michael tested H=
yper-V in
> > v2, and while there were conflicts when rebasing, they were largely
> > superficial (and I've just jinxed myself).=C2=A0 For all other hypervis=
ors, assume
> > the code is compile-tested only, but those changes are all quite small =
and
> > straightforward.
> >=20
> > The only changes that are questionable/contentious are the last two pat=
ches,
> > which have KVM-as-a-guest use CPUID 0x16 to get the CPU frequency, even=
 on
> > AMD (that's the dubious part).=C2=A0 I very deliberately put them last,=
 so that
> > they can be dropped at will (I don't care terribly if those patches lan=
d).
> > To merge them, I would want explicit Acks from Paolo and David W.
> >=20
> > So, except for the last two patches, to get the stuff I really care abo=
ut
> > landed, I think/hope it's just the TSC and guest-side CoCo changes that=
 need
> > reviews/acks?
> >=20
> > The primary goal of this series is (or at least was, when I started) to
> > fix flaws with SNP and TDX guests where a PV clock provided by the untr=
usted
> > hypervisor is used instead of the secure/trusted TSC that is controlled=
 by
> > trusted firmware.
> >=20
> > The secondary goal is to draft off of the SNP and TDX changes to slight=
ly
> > modernize running under KVM.=C2=A0 Currently, KVM guests will use TSC f=
or
> > clocksource, but not sched_clock.=C2=A0 And they ignore Intel's CPUID-b=
ased TSC
> > and CPU frequency enumeration, even when using the TSC instead of kvmcl=
ock.
> > And if the host provides the core crystal frequency in CPUID.0x15, then=
 KVM
> > guests can use that for the APIC timer period instead of manually calib=
rating
> > the frequency.
> >=20
> > The tertiary goal is to clean up all of the PV clock code to deduplicat=
e logic
> > across hypervisors, and to hopefully make it all easier to maintain goi=
ng
> > forward.
>=20
> I booted this in qemu with -cpu host,+invtsc,+vmware-cpuid-freq
>=20
> I was expecting to see it eschew the kvmclock and use *only* the TSC.
> Is there even any need for 'tsc-early' given that it's *told* the TSC
> frequency in CPUID? Shouldn't it have detected that the TSC is known
> before init_tsc_clocksource() runs?
>
> And then it even spent some time at boot actually using the kvmclock as
> clocksource... when ideally I don't think it would even have *enabled*
> it at all?

Yeah, that's definitely the ideal state.  And I had all the same expectatio=
ns and
observations as you when digging in and testing this.  But unless this seri=
es
makes things worse, I want punt on achieving the ideal state for the moment=
, as
it's proving to be a big lift just to get to a not-awful state.

> [    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycle=
s: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [    0.000000] tsc: Detected 2400.000 MHz processor
> [    0.008205] TSC deadline timer available
> [    0.008270] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:=
 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.159085] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 19112604467 ns
> [    0.164074] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycle=
s: 0x22983777dd9, max_idle_ns: 440795300422 ns
> [    0.229087] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 1911260446275000 ns
> [    0.337095] clocksource: Switched to clocksource kvm-clock
> [    0.345246] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,=
 max_idle_ns: 2085701024 ns
> [    0.356201] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2=
2983777dd9, max_idle_ns: 440795300422 ns
> [    0.360560] clocksource: Switched to clocksource tsc
>=20



