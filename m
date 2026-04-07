Return-Path: <linux-hyperv+bounces-10050-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHqJNP801Wk32wcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10050-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 18:46:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E11CE3B1FD6
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F8D7303134F
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544D33B775B;
	Tue,  7 Apr 2026 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QElWm9F1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7A3CEB8A
	for <linux-hyperv@vger.kernel.org>; Tue,  7 Apr 2026 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580295; cv=none; b=MmYM39GDdFCs35j5yzSUBik/Bn0RW5bCktmpcFsy3JzdHGypGZXzUDhAkBs034mbRjuLBlsNf8zG12x75ObQuv9PUjh1b9GFclqUEUMmvImqnsRfsJ1EnvusJkD5Z2IkruGFP6o4kO2yfLRqfI7x2pVuaw12IIPq446C7qL9A4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580295; c=relaxed/simple;
	bh=J5Ndik0IlpSvfGEsulbwE+9Z1hXXElUUZ73I/FJe8LU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MrMl7NtAFdRUplxqz8UBR9GiSQvn2kTXtvqyB0SnyhRE8QoM72J3rJLT8J8hJL7Y7ZTpCKVCtD7Bea3M/PpDRaLSDg4nH/qCRV8ZlsMMq0wkyoUBS/r4F47d48wqBO+92iblbIxHj1hxu9VhNWBWtSaGjOgLBhORbwCq0KLadvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QElWm9F1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c741f038f7cso2665342a12.2
        for <linux-hyperv@vger.kernel.org>; Tue, 07 Apr 2026 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775580293; x=1776185093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuTv9ErC5B25TtXR4Ofe9PkbgeAKBehAyF2Qi4T6fa4=;
        b=QElWm9F15J41ZoI5xfSuhqKyuAH1thi0BYBYVvDP1+x8FcO7JDjpTKNOAtiQjWQwCq
         y+BR/NdMYWgP2v/y1byOGEnv4wP9aDdIh8N8uIpfPusuQFaC8/hpOVMemiDYoOQg56wZ
         rKaf2k/MzZsg2gVsbKqpkufinIDYZdjg8kUsbdjeRQctpLdB9Czu7pPLWDIEY5ADur6s
         JC67KGA6gc4s0302pS/Rv8O8N0TuzfByacqZnEH8alb34uEEcGG+Hln146TAs/pJ+sdD
         Xtspnf+lAODgxgHWpdgfEWswkuvlgN29GKO/yYnruDvNdpavBOJwPSvi2DlFumN7Ip+/
         5YRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580293; x=1776185093;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zuTv9ErC5B25TtXR4Ofe9PkbgeAKBehAyF2Qi4T6fa4=;
        b=EW8S/npcspfsg+D2Xg5ETC+gt35ON7zos9oauF4wgEJ7wbgty1x4Q+vllkSAK0wTLe
         2617ck1ctenZUoxFm8UjSu3S9Jk5XgwcAot3l8p6kenMOEpQdtv/fokgIN6CTH5dCpHP
         o8atOZjnew/jg8QzgrFlJuj17+mSgq4qpI+HDIps/xNhvaoraA1kag2X9xBr40izPEtj
         daixylEx5x6Z8UfqOHLCcQ/NukFEi4c1+7dZifo3ssmnXeVf4MxkWQVcN8XUvIVNDwcL
         Owa/9xKHo1K3/1OYgf74JsJdRaqKSyfh1q2xB0OGkWFhIBbWeHzlw1X5NeCx0dXyuOE1
         L6zA==
X-Forwarded-Encrypted: i=1; AJvYcCXYV8SYvDh8utKBl7pLZUFCePkOgjPsO5miNt9/rxmFE/tcszlhbWAD/cZWPRh4jhiulz0eFOW5sFV3evk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIg1b4gnm2sbPBVvHesQia4iDNnHnyX/haKrq02Ueamd30F0ck
	wRqAri9rlc0WvIz5F6jYIoE25Flwskoyfm9cUo443lwm63883FHz6yPcSudDLzTlWyiMv2HLS/Z
	uNjaIlQ==
X-Received: from pgbct4.prod.google.com ([2002:a05:6a02:2104:b0:c76:40b0:72ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7351:b0:39f:a42:9243
 with SMTP id adf61e73a8af0-39f2ed0efffmr18775803637.3.1775580293092; Tue, 07
 Apr 2026 09:44:53 -0700 (PDT)
Date: Tue, 7 Apr 2026 09:44:51 -0700
In-Reply-To: <adU0LAW1h8q9HsGu@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
 <87v7e3mbgj.fsf@redhat.com> <adU0LAW1h8q9HsGu@google.com>
Message-ID: <adU0g-trGz8CRjeM@google.com>
Subject: Re: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested virt
 due to cross-CPU raw TSC inconsistency
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Thomas Lefebvre <thomas.lefebvre3@gmail.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10050-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,outlook.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E11CE3B1FD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026, Sean Christopherson wrote:
> +Michael

Let's try that again.  Email address #1 bounced.

> On Tue, Apr 07, 2026, Vitaly Kuznetsov wrote:
> > Thomas Lefebvre <thomas.lefebvre3@gmail.com> writes:
> > > Under Hyper-V, raw RDTSC values are not consistent across vCPUs.
> > > The hypervisor corrects them only through the TSC page scale/offset.
> > > If pvclock_update_vm_gtod_copy() runs on CPU 0 and __get_kvmclock()
> > > later runs on CPU 1 where the raw TSC is lower, the unsigned
> > > subtraction wraps.
> > >
> >=20
> > According to the TLFS, reference TSC page is partition wide:
> >=20
> > "The hypervisor provides a partition-wide virtual reference TSC page
> > which is overlaid on the partition=E2=80=99s GPA space. A partition=E2=
=80=99s reference
> > time stamp counter page is accessed through the Reference TSC MSR."
> >=20
> > so if as you say RAW rdtsc value is inconsistent across vCPUs, I can
> > hardly see how we can use this time source at all, even without
> > KVM. scale/offset are the same for all vCPUs.
> >=20
> > I think the fix here is to avoid setting up Hyper-V TSC page clocksourc=
e
> > in L1. Unfortunately, with unsynchronized TSCs this will leave us the
> > only choice for a sane clocksource: raw HV_X64_MSR_TIME_REF_COUNT MSR
> > reads.
>=20
> This feels like either a Hyper-V bug or a Linux-as-a-guest bug.  For "Ref=
erence
> Counter"[1]:
>=20
>   The hypervisor maintains a per-partition reference time counter. It has=
 the
>   characteristic that successive accesses to it return strictly monotonic=
ally
>   increasing (time) values as seen by any and all virtual processors of a
>   partition. Furthermore, the reference counter is rate constant and unaf=
fected
>   by processor or bus speed transitions or deep processor power savings s=
tates. A
>   partition=E2=80=99s reference time counter is initialized to zero when =
the partition is
>   created. The reference counter for all partitions count at the same rat=
e, but
>   at any time, their absolute values will typically differ because partit=
ions
>   will have different creation times.
>  =20
>   The reference counter continues to count up as long as at least one vir=
tual
>   processor is not explicitly suspended.
>=20
>=20
> And then "Partition Reference Time Enlightenment"[2]:
>=20
>   The partition reference time enlightenment presents a reference time so=
urce to
>   a partition which does not require an intercept into the hypervisor. Th=
is
>   enlightenment is available only when the underlying platform provides s=
upport
>   of an invariant processor Time Stamp Counter (TSC), or iTSC. In such pl=
atforms,
>   the processor TSC frequency remains constant irrespective of changes in=
 the
>   processor=E2=80=99s clock frequency due to the use of power management =
states such as
>   ACPI processor performance states, processor idle sleep states (ACPI C-=
states),
>   etc.
>=20
>   The partition reference time enlightenment uses a virtual TSC value, an=
 offset
>   and a multiplier to enable a guest partition to compute the normalized
>   reference time since partition creation, in 100nS units. The mechanism =
also
>   allows a guest partition to atomically compute the reference time when =
the
>   guest partition is migrated to a platform with a different TSC rate, an=
d
>   provides a fallback mechanism to support migration to platforms without=
 the
>   constant rate TSC feature.
>=20
> My read of "Partition Reference Time Enlightenment" is that it should onl=
y be
> advertised if the TSC is synchronized and constant.  I can't figure out w=
here
> that feature is actually advertised though, because IIUC it's not the sam=
e as
> HV_ACCESS_TSC_INVARIANT, which says that the virtual TSC is guaranteed to=
 be
> invariant even across live migration.  And it's not HV_MSR_REFERENCE_TSC_=
AVAILABLE,
> because I'm pretty sure that just says HV_MSR_REFERENCE_TSC is available.
>=20
> Michael, help?
>=20
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/t=
lfs/timers#reference-counter
> [2] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/t=
lfs/timers#partition-reference-time-enlightenment

