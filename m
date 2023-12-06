Return-Path: <linux-hyperv+bounces-1247-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD59680632C
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Dec 2023 01:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C1B210C0
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Dec 2023 00:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69108360;
	Wed,  6 Dec 2023 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xR8t6mUk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFB31A4
	for <linux-hyperv@vger.kernel.org>; Tue,  5 Dec 2023 16:07:17 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d340a9cf07so95618357b3.3
        for <linux-hyperv@vger.kernel.org>; Tue, 05 Dec 2023 16:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701821237; x=1702426037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B09jNl/6ew1fQLf1zTOLuFX5OzlF3p6K7osCTShEz6M=;
        b=xR8t6mUk4YlLTCwB3wzAVW+pbILw5/x9O7C9Ot8cC5Eacn2DbevSTZUw1/uk8+IUH3
         ffDD6LfXxy26tQN5nZ4m39/EejSIRlbTV4iqOHFSpdCOfyzh739uRUElkDNCbyoZuwMv
         AHB0kMv9w7K++aVN+nE15SYKf7zPrbiahaCSr0uRgHu8ePf3J22npjoBHA4mTmvilEdj
         iwZdtCjfY0NkJV7Tlyggt7tWKF3O0IUUgHh3WP7o3GyRpwTrhQa3VYU3Cx51Wpwfx4Il
         pdiv6B2MkJUK+vU10QGQM+bRZ4/HzOK+a/BXGCDcvrocDdU0hhW2R5Qpw3CajRXprFqM
         P+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701821237; x=1702426037;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B09jNl/6ew1fQLf1zTOLuFX5OzlF3p6K7osCTShEz6M=;
        b=uCIiJqw1wtfw2eXDVxtOm1PHs/w6lZ8H5VZIDosJDowIlumB7kZYYgIn8KI94tnQJh
         YJZ+MQYkCmC7WhL/IJexYjMswmUEKVMuXLxofyiC1umYu7NptX1Gef6jN2CwoZ/lv+Vg
         2Xxeu5tk+Jqawl1+MibetKjCotOwqUo9LbPKrQJQsbXUhep7l4G7NaiVW9EJfwtdjldL
         CKiSeaIOdWQ8Kuoa0RTEy6s5wH99aRLvW7UqlbRR3IjnIRENeCCju7a5NIvzrkOmD2Qp
         CZhjqagH7aPWaLOkf8V7RSeD0icN/6+2EyMGiB3vZfP/5MJqIwlk+aP96CCLFK1nmfup
         mppw==
X-Gm-Message-State: AOJu0YxaXX8nrqkX88koydye0u8koCt+3O6HftKPTqk9iUr8MzKGk6q9
	HN4oBV0gSUL9VcX1XnbWm1dJHHGz+WE=
X-Google-Smtp-Source: AGHT+IGlfl1pdAmtDrLxND8bxut+yVt9lXSa4fXaozYVUGEQmSGwKI62StziH/FVo2cPUM7O/ofYJDYTrcI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2f0b:b0:5d4:3013:25d4 with SMTP id
 ev11-20020a05690c2f0b00b005d4301325d4mr282162ywb.5.1701821237087; Tue, 05 Dec
 2023 16:07:17 -0800 (PST)
Date: Tue, 5 Dec 2023 16:07:15 -0800
In-Reply-To: <fc09fec34a89ba7655f344a31174d078a8248182.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-6-nsaenz@amazon.com>
 <f4495d1f697cf9a7ddfb786eaeeac90f554fc6db.camel@redhat.com>
 <CXD4TVV5QWUK.3SH495QSBTTUF@amazon.com> <ZWoKlJUKJGGhRRgM@google.com>
 <CXD5HJ5LQMTE.11XP9UB9IL8LY@amazon.com> <ZWocI-2ajwudA-S5@google.com>
 <CXD7AW5T9R7G.2REFR2IRSVRVZ@amazon.com> <ZW94T8Fx2eJpwKQS@google.com> <fc09fec34a89ba7655f344a31174d078a8248182.camel@redhat.com>
Message-ID: <ZW-7Mwev4Ilf541L@google.com>
Subject: Re: [RFC 05/33] KVM: x86: hyper-v: Introduce VTL call/return
 prologues in hypercall page
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com, 
	anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com, 
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, 
	x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023, Maxim Levitsky wrote:
> On Tue, 2023-12-05 at 11:21 -0800, Sean Christopherson wrote:
> > On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> > > On Fri Dec 1, 2023 at 5:47 PM UTC, Sean Christopherson wrote:
> > > > On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> > > > > On Fri Dec 1, 2023 at 4:32 PM UTC, Sean Christopherson wrote:
> > > > > > On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> > > > > > > > To support this I think that we can add a userspace msr fil=
ter on the HV_X64_MSR_HYPERCALL,
> > > > > > > > although I am not 100% sure if a userspace msr filter overr=
ides the in-kernel msr handling.
> > > > > > >=20
> > > > > > > I thought about it at the time. It's not that simple though, =
we should
> > > > > > > still let KVM set the hypercall bytecode, and other quirks li=
ke the Xen
> > > > > > > one.
> > > > > >=20
> > > > > > Yeah, that Xen quirk is quite the killer.
> > > > > >=20
> > > > > > Can you provide pseudo-assembly for what the final page is supp=
osed to look like?
> > > > > > I'm struggling mightily to understand what this is actually try=
ing to do.
> > > > >=20
> > > > > I'll make it as simple as possible (diregard 32bit support and th=
at xen
> > > > > exists):
> > > > >=20
> > > > > vmcall             <-  Offset 0, regular Hyper-V hypercalls enter=
 here
> > > > > ret
> > > > > mov rax,rcx  <-  VTL call hypercall enters here
> > > >=20
> > > > I'm missing who/what defines "here" though.  What generates the CAL=
L that points
> > > > at this exact offset?  If the exact offset is dictated in the TLFS,=
 then aren't
> > > > we screwed with the whole Xen quirk, which inserts 5 bytes before t=
hat first VMCALL?
> > >=20
> > > Yes, sorry, I should've included some more context.
> > >=20
> > > Here's a rundown (from memory) of how the first VTL call happens:
> > >  - CPU0 start running at VTL0.
> > >  - Hyper-V enables VTL1 on the partition.
> > >  - Hyper-V enabled VTL1 on CPU0, but doesn't yet switch to it. It pas=
ses
> > >    the initial VTL1 CPU state alongside the enablement hypercall
> > >    arguments.
> > >  - Hyper-V sets the Hypercall page overlay address through
> > >    HV_X64_MSR_HYPERCALL. KVM fills it.
> > >  - Hyper-V gets the VTL-call and VTL-return offset into the hypercall
> > >    page using the VP Register HvRegisterVsmCodePageOffsets (VP regist=
er
> > >    handling is in user-space).
> >=20
> > Ah, so the guest sets the offsets by "writing" HvRegisterVsmCodePageOff=
sets via
> > a HvSetVpRegisters() hypercall.
>=20
> No, you didn't understand this correctly.=20
>=20
> The guest writes the HV_X64_MSR_HYPERCALL, and in the response hyperv fil=
ls

When people say "Hyper-V", do y'all mean "root partition"?  If so, can we j=
ust
say "root partition"?  Part of my confusion is that I don't instinctively k=
now
whether things like "Hyper-V enables VTL1 on the partition" are talking abo=
ut the
root partition (or I guess parent partition?) or the hypervisor.  Functiona=
lly it
probably doesn't matter, it's just hard to reconcile things with the TLFS, =
which
is written largely to describe the hypervisor's behavior.

> the hypercall page, including the VSM thunks.
>
> Then the guest can _read_ the offsets, hyperv chose there by issuing anot=
her hypercall.=20

Hrm, now I'm really confused.  Ah, the TLFS contradicts itself.  The blurb =
for
AccessVpRegisters says:

  The partition can invoke the hypercalls HvSetVpRegisters and HvGetVpRegis=
ters.

And HvSetVpRegisters confirms that requirement:

  The caller must either be the parent of the partition specified by Partit=
ionId,
  or the partition specified must be =E2=80=9Cself=E2=80=9D and the partiti=
on must have the
  AccessVpRegisters privilege

But it's absent from HvGetVpRegisters:

  The caller must be the parent of the partition specified by PartitionId o=
r the
  partition specifying its own partition ID.

> In the current implementation, the offsets that the kernel choose are fir=
st
> exposed to the userspace via new ioctl, and then the userspace exposes th=
ese
> offsets to the guest via that 'another hypercall' (reading a pseudo parti=
tion
> register 'HvRegisterVsmCodePageOffsets')
>=20
> I personally don't know for sure anymore if the userspace or kernel based
> hypercall page is better here, it's ugly regardless :(

Hrm.  Requiring userspace to intercept the WRMSR will be a mess because the=
n KVM
will have zero knowledge of the hypercall page, e.g. userspace would be for=
ced to
intercept HV_X64_MSR_GUEST_OS_ID as well.  That's not the end of the world,=
 but
it's not exactly ideal either.

What if we exit to userspace with a new kvm_hyperv_exit reason that require=
s
completion?  I.e. punt to userspace if VSM is enabled, but still record the=
 data
in KVM?  Ugh, but even that's a mess because kvm_hv_set_msr_pw() is deep in=
 the
WRMSR emulation call stack and can't easily signal that an exit to userspac=
e is
needed.  Blech.

