Return-Path: <linux-hyperv+bounces-2085-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86FA8BE87F
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 May 2024 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E993284680
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 May 2024 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE13168AE8;
	Tue,  7 May 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMeGXue2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A2816ABC4
	for <linux-hyperv@vger.kernel.org>; Tue,  7 May 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098570; cv=none; b=qt1d+acNdcNbic9b7IM2tuQI565pNJOrCyLDqiG5RDCdhEzx6FmyOA9wg+uLwZrEaKg9B1bOgLZvvFB/jTvZjZkWOvGGCbmluZAdQVlMinEGKTCa+KaZ/XlnT4UgeQPRFX82xoDiJZmnP1PK6RlW0a6TFYEWUWh2Y9+tr+xEdlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098570; c=relaxed/simple;
	bh=n4oL9QdCVInqGhf/IejBHhOJycGpmskHhXQcPvV0+5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lK7yvi5kPSvrZUUq8UDGGX7XKALDLx10+Re5sc7zNVdBzuZp3VWlibN9xlX3aqY1RLy6QvovRqjgeJil5cDPatPZT+4a4bQuWBiiU+xzPjvUF+XZf3CkmKTjVuq3sg1kBk+APJe8Voc1sziPOFjaLy9UMwaO8LbmA9PKchVL8j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMeGXue2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de61a10141fso4638255276.1
        for <linux-hyperv@vger.kernel.org>; Tue, 07 May 2024 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715098568; x=1715703368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWxS0mCdKrqU6bVOz4n3NTmQy0CRO7Urzkw5a/fWZlQ=;
        b=uMeGXue2xAiO8uSusy505x4973sRuVnPct94e5Cm2OQalOkV7vjyNrPO67Zr/vC7wP
         YpAyg4pYPeVIBfb++egKABY8H7nYzv47k9KyfxJf8SkimcuHBDCvgo2iciZr8k6yDQ3H
         +sKHpl9zwTVagTolmTyDNn0QDXKvkrI6sH0AIyyN9r1kMI2Sm0AiY630D1Dwuo3Nvlyv
         eskfWdD3kraqjff94Bi5xRxWpwSQpf499jXnWgRxk9897sxPdyz5hz057kUh6sRrP//3
         auAcQscoQb2UY63/ImrOfBvfYOSoNzdQRAeSPhuFJUkFZ4VV3m5OwkDiiOMMo/STzzRb
         94sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098568; x=1715703368;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IWxS0mCdKrqU6bVOz4n3NTmQy0CRO7Urzkw5a/fWZlQ=;
        b=v4MXXlAQ3YED36M6MJ+6ar3ljUixorBfSxBtgOC4UIdQVw9zmSkoxo3dUlvGdFX9O3
         Sz8llupylvVVvOytcvZOs0FzWLm5pPVDVYYpgick3Ptp+zAeoAnFtf0hvkoDuNBrnO+3
         48gsb4brIyzqtPk/UcB6ltKDo6Rlr75KwhDcQNBWL8jL7d/IX9XOkZES+3CX0r2V2RdK
         jh5ghgztv+lQyRG8h9CGh0z5LJYVSG/9/xfxPFA576TiezZGFSO1yrXaQ8Rz5yBmpTKw
         DGUxi5+1AXvLhMmJ0MGEp6PE6NvFXU+xiz0nV0e9n2Q+nYKQJdz4gov/SiS6wZ8x5+LC
         Whog==
X-Forwarded-Encrypted: i=1; AJvYcCV1+5k4FbNK9d54yZ30U32C1AwLEFRn7cD8fEg6suOAv2x76NXdhDsiABAdWPToeNTGVBhdRbf80Tx03cGx0R2y1EzfL9uq6wiQ2LU9
X-Gm-Message-State: AOJu0YzcdCQp8M01KsK6GEM57HKjqCt20eNfF2lm/UeHq9yMpOfvHUB3
	5ythvXKgLPrksJDlUfnMZH1tJU75wVj35IZUNr2SnGeFpUOpz9PDeJfhy/wYWTLHF6VcxVf/F0C
	MkQ==
X-Google-Smtp-Source: AGHT+IEEPkTwPJaOTGouRKDc7DVHMnqTRjb0yesgQ4YUUdFhPv8WpJzXBwRvcXmUBR39ssSE6I5KsNiqYrA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:707:b0:dbe:30cd:8fcb with SMTP id
 3f1490d57ef6-debb9c0032emr11950276.0.1715098567940; Tue, 07 May 2024 09:16:07
 -0700 (PDT)
Date: Tue, 7 May 2024 09:16:06 -0700
In-Reply-To: <20240507.ieghomae0UoC@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net> <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com> <20240506.ohwe7eewu0oB@digikod.net>
 <ZjmFPZd5q_hEBdBz@google.com> <20240507.ieghomae0UoC@digikod.net>
Message-ID: <ZjpTxt-Bxia3bRwB@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>, 
	Angelina Vu <angelinavu@linux.microsoft.com>, 
	Anna Trikalinou <atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
	James Morris <jamorris@linux.microsoft.com>, John Andersen <john.s.andersen@intel.com>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, 
	"Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
	"=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>, Thara Gopinath <tgopinath@microsoft.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	"=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>, dev@lists.cloudhypervisor.org, 
	kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
	virtualization@lists.linux-foundation.org, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> > Actually, potential bad/crazy idea.  Why does the _host_ need to define=
 policy?
> > Linux already knows what assets it wants to (un)protect and when.  What=
's missing
> > is a way for the guest kernel to effectively deprivilege and re-authent=
icate
> > itself as needed.  We've been tossing around the idea of paired VMs+vCP=
Us to
> > support VTLs and SEV's VMPLs, what if we usurped/piggybacked those idea=
s, with a
> > bit of pKVM mixed in?
> >=20
> > Borrowing VTL terminology, where VTL0 is the least privileged, userspac=
e launches
> > the VM at VTL0.  At some point, the guest triggers the deprivileging se=
quence and
> > userspace creates VTL1.  Userpace also provides a way for VTL0 restrict=
 access to
> > its memory, e.g. to effectively make the page tables for the kernel's d=
irect map
> > writable only from VTL1, to make kernel text RO (or XO), etc.  And VTL0=
 could then
> > also completely remove its access to code that changes CR0/CR4.
> >=20
> > It would obviously require a _lot_ more upfront work, e.g. to isolate t=
he kernel
> > text that modifies CR0/CR4 so that it can be removed from VTL0, but tha=
t should
> > be doable with annotations, e.g. tag relevant functions with __magic or=
 whatever,
> > throw them in a dedicated section, and then free/protect the section(s)=
 at the
> > appropriate time.
> >=20
> > KVM would likely need to provide the ability to switch VTLs (or whateve=
r they get
> > called), and host userspace would need to provide a decent amount of th=
e backend
> > mechanisms and "core" policies, e.g. to manage VTL0 memory, teardown (t=
urn off?)
> > VTL1 on kexec(), etc.  But everything else could live in the guest kern=
el itself.
> > E.g. to have CR pinning play nice with kexec(), toss the relevant kexec=
() code into
> > VTL1.  That way VTL1 can verify the kexec() target and tear itself down=
 before
> > jumping into the new kernel.=20
> >=20
> > This is very off the cuff and have-wavy, e.g. I don't have much of an i=
dea what
> > it would take to harden kernel text patching, but keeping the policy in=
 the guest
> > seems like it'd make everything more tractable than trying to define an=
 ABI
> > between Linux and a VMM that is rich and flexible enough to support all=
 the
> > fancy things Linux does (and will do in the future).
>=20
> Yes, we agree that the guest needs to manage its own policy.  That's why
> we implemented Heki for KVM this way, but without VTLs because KVM
> doesn't support them.
>=20
> To sum up, is the VTL approach the only one that would be acceptable for
> KVM? =20

Heh, that's not a question you want to be asking.  You're effectively askin=
g me
to make an authorative, "final" decision on a topic which I am only passing=
ly
familiar with.

But since you asked it... :-)  Probably?

I see a lot of advantages to a VTL/VSM-like approach:

 1. Provides Linux-as-a guest the flexibility it needs to meaningfully adva=
nce
    its security, with the least amount of policy built into the guest/host=
 ABI.

 2. Largely decouples guest policy from the host, i.e. should allow the gue=
st to
    evolve/update it's policy without needing to coordinate changes with th=
e host.

 3. The KVM implementation can be generic enough to be reusable for other f=
eatures.

 4. Other groups are already working on VTL-like support in KVM, e.g. for V=
SM
    itself, and potentially for VMPL/SVSM support.

IMO, #2 is a *huge* selling point.  Not having to coordinate changes across
multiple code bases and/or organizations and/or maintainers is a big win fo=
r
velocity, long term maintenance, and probably the very viability of HEKI.

Providing the guest with the tools to define and implement its own policy m=
eans
end users don't have to way for some third party, e.g. CSPs, to deploy the
accompanying host-side changes, because there are no host-side changes.

And encapsulating everything in the guest drastically reduces the friction =
with
changes in the kernel that interact with hardening, both from a technical a=
nd a
social perspective.  I.e. giving the kernel (near) complete control over it=
s
destiny minimizes the number of moving parts, and will be far, far easier t=
o sell
to maintainers.  I would expect maintainers to react much more favorably to=
 being
handed tools to harden the kernel, as opposed to being presented a set of A=
PIs
that can be used to make the kernel compliant with _someone else's_ vision =
of
what kernel hardening should look like.

E.g. imagine a new feature comes along that requires overriding CR0/CR4 pin=
ning
in a way that doesn't fit into existing policy.  If the VMM is involved in
defining/enforcing the CR pinning policy, then supporting said new feature =
would
require new guest/host ABI and an updated host VMM in order to make the new
feature compatible with HEKI.  Inevitably, even if everything goes smoothly=
 from
an upstreaming perspective, that will result in guests that have to choose =
between
HEKI and new feature X, because there is zero chance that all hosts that ru=
n Linux
as a guest will be updated in advance of new feature X being deployed.

And if/when things don't go smoothly, odds are very good that kernel mainta=
iners
will eventually tire of having to coordinate and negotiate with QEMU and ot=
her
VMMs, and will become resistant to continuing to support/extend HEKI.

> If yes, that would indeed require a *lot* of work for something we're not
> sure will be accepted later on.

Yes and no.  The AWS folks are pursuing VSM support in KVM+QEMU, and SVSM s=
upport
is trending toward the paired VM+vCPU model.  IMO, it's entirely feasible t=
o
design KVM support such that much of the development load can be shared bet=
ween
the projects.  And having 2+ use cases for a feature (set) makes it _much_ =
more
likely that the feature(s) will be accepted.

And similar to what Paolo said regarding HEKI not having a complete story, =
I
don't see a clear line of sight for landing host-defined policy enforcement=
, as
there are many open, non-trivial questions that need answers. I.e. upstream=
ing
HEKI in its current form is also far from a done deal, and isn't guaranteed=
 to
be substantially less work when all is said and done.

