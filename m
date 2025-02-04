Return-Path: <linux-hyperv+bounces-3834-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E469A27B3D
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Feb 2025 20:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBF43A27FE
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Feb 2025 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9376218ABD;
	Tue,  4 Feb 2025 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONWNoLGI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB42217703
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Feb 2025 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697381; cv=none; b=VP+eMLN6iA9wcrwfbQIDscEYi7cTBUqnnNicKgc5JLGApMOIV3GHbjGl7qsHcYdhBZVUqz9M7z3z+zaAd6KPDAaur8VYlAHbT0GMEfK2DrhCQPNeF9ZtNfN8B+X1qxV3VGkpDzj1ZwvhYelpPA8aqgdqBKbi/+QG3YJZQuKQXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697381; c=relaxed/simple;
	bh=jR8glNKTcRvWQFyYWzpmeeHHaLx4f7ObdoeaqwwhgrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q0R2C8O6d+EIAtsPo3tb+PNQe0ZC9Fv0L/8OK1FaNZby00TGmX7X+doac2rahxYEEXOFAOQAuTWRSEi05giF/h0czSuum07tqOf6ag+zA1ofDih2hP3A+Bcbb5OLtW7wvn5z/4/07qkVIpOCcKcCTOhGqcyvVjWtEL5nOZAhyzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONWNoLGI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f816a85facso11206112a91.3
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Feb 2025 11:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738697379; x=1739302179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5e8UEnGVo+4lDc1cH0GoOuL8F0MUw58BGLx/3p+5fdQ=;
        b=ONWNoLGImy11X7wp005j3c0b3AXhnDVQAu9PRZCfl4/Hoz7uc3Bgi4E/aFM/exO727
         gTQwYXCSe1OPEwPw9KP6ZpUarjAhqpXjbujXYzsEoBVNRIDCQX+TpapGaFZOfTFSDk7N
         BXyEFfsh5Mz3YQV9vTYRKpL/FlHaT5EEXh3yr4bZRd3Gsf2AJyKfK6X4R0yfg1aEzPeF
         UA3Yut+cT5/O3Sc5e4louBnyGBuKa7yQUEQiAYtwv/StnOFI3wBPst0MM/xBkLduOzMP
         8ZduMrKyh6qZSdrqHLroL91d8MeCxC8dEB0EH2XO5FnaaBo9yWmochVH+p4xUkjtHQL1
         /7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697379; x=1739302179;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5e8UEnGVo+4lDc1cH0GoOuL8F0MUw58BGLx/3p+5fdQ=;
        b=mr8y0unnwL2XlHFIu0bKhraHYhDEHi2eRvYPI6lDTLee40U9+jknjqon2fNpsPfK9O
         TWo24ptE2d8DSMm+68lTGKpz8aJSfiOddGHU9PL3CQjOj1dx6/OiemJIQtWSHZqwHcaT
         CaCuqT//s+AaNGblEtVDAYg3TAAFWJ5RiV4TDvGfn5OQOL1pe+P2tRl/ltJmh51rbmbM
         W4qH6cawUEZspYl880tdHGCb8xPRPgAmabMsLg0AkCD9pSiGCSgsOMprGbxaAQYatqh+
         XJDFr9+9PxDOx+ou38D8QXbeUZfJ/kWlO4y3lONVMIFxVaY3wjWhrrJW0Yz7ORSmlf4Z
         6aoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCEDSkOSqHoUP3CYRnhhpuoS4iOcwcf9w/s8C3j2ScZNH1HkhduWRjBls0kPrZj+TE5DHcXI2rj3YKbWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2mnVYjGvwxYAcxQpLYs4tdj18YQhxcsIN4AdhxnFt2jlWY09m
	1keTf4lJTBKDzyLLAwfLI1bsbji36Cxfm2aDdUs7al0UJw/N5vQdMmVS2oxB6WMexZfSRsuG5Bh
	MOg==
X-Google-Smtp-Source: AGHT+IF+/fBR5/RvgfgkW+k0iOimknqvbfTCdp56sFN5T8R+lSkm/qjT6GD7VseImBDz4jdwECu7ieLsEjc=
X-Received: from pjbsw5.prod.google.com ([2002:a17:90b:2c85:b0:2d3:d4ca:5fb0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5245:b0:2ee:ab29:1a65
 with SMTP id 98e67ed59e1d1-2f83abb4f94mr39965711a91.4.1738697379406; Tue, 04
 Feb 2025 11:29:39 -0800 (PST)
Date: Tue, 4 Feb 2025 11:29:38 -0800
In-Reply-To: <85r04e5821.fsf@amd.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250201021718.699411-7-seanjc@google.com>
 <85r04e5821.fsf@amd.com>
Message-ID: <Z6JqopU5LkDIZPq6@google.com>
Subject: Re: [PATCH 06/16] x86/tdx: Override PV calibration routines with
 CPUID-based calibration
From: Sean Christopherson <seanjc@google.com>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, jailhouse-dev@googlegroups.com, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2025, Nikunj A Dadhania wrote:
> Sean Christopherson <seanjc@google.com> writes:
>=20
> > When running as a TDX guest, explicitly override the TSC frequency
> > calibration routine with CPUID-based calibration instead of potentially
> > relying on a hypervisor-controlled PV routine.  For TDX guests, CPUID.0=
x15
> > is always emulated by the TDX-Module, i.e. the information from CPUID i=
s
> > more trustworthy than the information provided by the hypervisor.
> >
> > To maintain backwards compatibility with TDX guest kernels that use nat=
ive
> > calibration, and because it's the least awful option, retain
> > native_calibrate_tsc()'s stuffing of the local APIC bus period using th=
e
> > core crystal frequency.  While it's entirely possible for the hyperviso=
r
> > to emulate the APIC timer at a different frequency than the core crysta=
l
> > frequency, the commonly accepted interpretation of Intel's SDM is that =
APIC
> > timer runs at the core crystal frequency when that latter is enumerated=
 via
> > CPUID:
> >
> >   The APIC timer frequency will be the processor=E2=80=99s bus clock or=
 core
> >   crystal clock frequency (when TSC/core crystal clock ratio is enumera=
ted
> >   in CPUID leaf 0x15).
> >
> > If the hypervisor is malicious and deliberately runs the APIC timer at =
the
> > wrong frequency, nothing would stop the hypervisor from modifying the
> > frequency at any time, i.e. attempting to manually calibrate the freque=
ncy
> > out of paranoia would be futile.
> >
> > Deliberately leave the CPU frequency calibration routine as is, since t=
he
> > TDX-Module doesn't provide any guarantees with respect to CPUID.0x16.
>=20
> Does TDX use kvmclock?

A TDX guest can.  That's up to the host (expose kvmclock) and the guest (en=
able
kvmclock).

> If yes, kvmclock would have registered the CPU frequency calibration rout=
ine:
>=20
> 	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_cpu_khz,
>  					  tsc_properties);
>=20
> so TDX will use kvm_get_cpu_khz(), which will either use CPUID.0x16 or
> PV clock, is this on the expected line ?

What do you mean by "is this on the expected line"?  If you are asking "is =
this
intended", then the answer is "yes, working as intended".  As above, the TD=
X-Module
doesn't emulate CPUID.0x16, so no matter what, the guest is relying on the =
untrusted
hypervisor to get the CPU frequency.  If someone thinks that TDX guests sho=
uld
assume the CPU runs as the same frequency as the TSC, a la SNP's Secure TSC=
, then
they are welcome to propose such a change.

