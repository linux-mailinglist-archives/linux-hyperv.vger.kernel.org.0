Return-Path: <linux-hyperv+bounces-5530-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 192A5AB8716
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 14:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA591BC4F03
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69873299AB2;
	Thu, 15 May 2025 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8SOZwAc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1E298C21;
	Thu, 15 May 2025 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313511; cv=none; b=qq/3JNJuglA/xui6ZL6ULaC1DBqOcMqmsVM/vf/3eGy380Sa7BLNVB39nmrVGmoq14l8q3fBoIlpD0nhbL+o5ZLWW/kowFGujjEUByRaMVQ/M31DuTsXjIObWKNc9Mo4skItEp6YP51+ta0O6NSQhsis8qpFltHMhzaXk7rsS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313511; c=relaxed/simple;
	bh=UfCtjCjLMy3EXaRycOntxcaM3apBDdPoyB7FMimlPQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Inx6BhVwAWtAuqzuVCyL2qqKR/+ogJx+VC5c+/zJfYgKY6IHQWyjfdVbIN5N15wKsoVd/Ij4q2PD6lLU7vjKI21Fh05YHJIaQDB7lqW9FzOaiBMlTbNcjTEwmwj03vKfoxbY5R6TUguDEUqEYsFh0wuvs16BPAFRFJGXM/m49F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8SOZwAc; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so644934a12.2;
        Thu, 15 May 2025 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313509; x=1747918309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsUnEpTB9TgvbJe08iwx+kPzreYFJA/xHaoOoYwMSYw=;
        b=K8SOZwAc2TTrrdOmXiFJtLzlE33mifPPJIWtbMAwkp3YJ1sMeUy6bXhE62J9x87/E7
         5Ul3Dai8MWaZ8GqMjQCUtj7LHoYA5KfXvqNaP4BE1pxYgwLyIKO/NR9v3KLoGy/TayTP
         l6anXLbL8hHm9F2z3TstalR1GF1ciB5QocKg6iFEOH+CWdEsDxkH8a8dZhiY8AwW16an
         gH2hBJEgmlkNEs2Z7s7SRwwQKkJUCgZDmcOoMOMS+eOW90h43BQDwDJKlGSqem48rQwi
         Q6GWNqzFIKeyYX0zL/+hqQ6cWtwO/DMd/35rJ4gqWmxmcYxDahiWK4hO3WyoE1UYSMFz
         KT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313509; x=1747918309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsUnEpTB9TgvbJe08iwx+kPzreYFJA/xHaoOoYwMSYw=;
        b=WBNxtFsBmzcN0arRmknX73lZjTo5USswpuQOBjxlCUqok4+dE15pCsLqyEKD968kS0
         ludIgWFfjCVqVkY31y58RuDx35HlWjbCW3aGNRZApc24QwSv3QywhWtfIYDbXZiRKzB1
         2sEp5Jn9fpJMD+iQOyxkvXP26KN+Fpnj7zyVSfp2el4+DvQ43Y8G1JKNpMCkkFdyOFBl
         /f8VmtTfUamhsCI15B/KnyKLvtWnQLFwJ/mi1nG186wnKuMbJUGtZBNwics9HM5J/EHJ
         /xUczf5PSYFu0boZxcCy9VnLBKyTOlv3cDJ1gFEDue8k6cF06gIuHB6CXCW83k4uj1H/
         MOWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6Ylg3QpwgGjCjdJ4IVrl9WlYcvDuQPFJ/wwY8CXtNZFO6+Ud/yRs2RpFHK56lecMoHpcy4NUapwMBEKs=@vger.kernel.org, AJvYcCX9DVQ1/VZIttfDKoBW51hjjcqHwF6614rYwOfmMKkQvppXCr3qHTTk7fNfa0m2NMwwoaUhtBr4a5tM1h43@vger.kernel.org
X-Gm-Message-State: AOJu0YxDJ0vXyGAN60jE2mr8LLrEnwoO7EsP1dBPlWOPa0Sl/AHVXk8O
	G04ZdqkE2Z/kNU0ipNJGbj67UD5EbH/AJlAAU9f5fqIefYcNZ6/dbCdumXsaK8FXPVlT3RDNBpp
	BQa3rVlxY0wogH8G7WDMPp2IOc7E=
X-Gm-Gg: ASbGnct+ykpZb3PDCInPLWR4JxlY5p09twAEde27Ha6kEaoTpMUWj9N6UILOv2DIRmZ
	j/9w3LhcO7s7BJMACXFulF5yUx4YukgYJYQ2k1vigFzwHm4FSNvH+pQDtWpWRZD22atzU5aZCcA
	6JszAT9fZUIqP+mVa5YH/P3V9mIGKVpG5nahErUUbhoxQWplU3RF4=
X-Google-Smtp-Source: AGHT+IHmtTntsE+sfyZwvw5nINLePGfaCPfUPxiD3EwklQw3lSH9rnreveUf94kj+UB+XCwKB297vGNrhQeqiaUwzxM=
X-Received: by 2002:a17:90b:560f:b0:308:7270:d6ea with SMTP id
 98e67ed59e1d1-30e2e633452mr10796896a91.30.1747313508929; Thu, 15 May 2025
 05:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506130712.156583-1-ltykernel@gmail.com> <SN6PR02MB4157DD818BB2269809AEBBC0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157DD818BB2269809AEBBC0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 15 May 2025 20:51:11 +0800
X-Gm-Features: AX0GCFsIeyWW9s8zrkVlSWBSWiwDw-5SaUxpUcvOQ76LvVHr0Sci75eMLxZmNkw
Message-ID: <CAMvTesCjTTO4S9wYRNw2BprHJ-+rCnQjZOJBXtBiK3810onT5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>, 
	"kvijayab@amd.com" <kvijayab@amd.com>, "yuehaibing@huawei.com" <yuehaibing@huawei.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "tiala@microsoft.com" <tiala@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:54=E2=80=AFAM Michael Kelley <mhklinux@outlook.c=
om> wrote:
>
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Tuesday, May 6, 2025 6:07 AM
> >
>
> For consistency with other patches, use "x86/hyperv" as the Subject prefi=
x.
> I'd suggest being slightly more precise and saying "Hyper-V guests" inste=
ad
> of "Hyper-V platform". So,
>
> x86/hyperv: Add AMD Secure AVIC support for Hyper-V guests
>
Hi Michael:
       Thanks for your review.  Good idea ! Will update in the next version=
.

> > Secure AVIC is a new hardware feature in the AMD64
> > architecture to allow SEV-SNP guests to prevent the
> > hypervisor from generating unexpected interrupts to
> > a vCPU or otherwise violate architectural assumptions
> > around APIC behavior.
> >
> > Each vCPU has a guest-allocated APIC backing page of
> > size 4K, which maintains APIC state for that vCPU.
> > APIC backing page's ALLOWED_IRR field indicates the
>
> s/APIC backing/The APIC backing/
>
> > interrupt vectors which the guest allows the hypervisor
> > to send.
> >
> > This patchset is to enable the feature for Hyper-V
> > platform. Patch "Expose x2apic_savic_update_vector()"
>
> s/platform/guests/
>
> > is to expose new fucntion and device driver and arch
>
> "is to expose the new function. Device driver and arch"
>
> > code may update AVIC backing page ALLOWED_IRR field to
>
> s/update AVIC/update the AVIC/
>
> > allow Hyper-V inject associated vector.
>
> s/Hyper-V inject associated/Hyper-V to inject the associated/
>
> >
> > This patchset is based on the AMD patchset "AMD: Add
> > Secure AVIC Guest Support"
> > https://lkml.org/lkml/2025/4/17/585
> >
> > Tianyu Lan (6):
> >   x86/Hyper-V: Not use hv apic driver when Secure AVIC is available
> >   x86/x2apic-savic: Expose x2apic_savic_update_vector()
> >   drivers/hv: Allow vmbus message synic interrupt injected from Hyper-V
> >   x86/Hyper-V: Allow Hyper-V to inject Hyper-V vectors
> >   x86/Hyper-V: Not use auto-eoi when Secure AVIC is available
> >   x86/x2apic-savic: Not set APIC backing page if Secure AVIC is not
> >     enabled.
> >
> >  arch/x86/hyperv/hv_apic.c           |  3 +++
> >  arch/x86/hyperv/hv_init.c           | 12 ++++++++++++
> >  arch/x86/include/asm/apic.h         |  9 +++++++++
> >  arch/x86/kernel/apic/x2apic_savic.c | 13 ++++++++++++-
> >  arch/x86/kernel/cpu/mshyperv.c      |  3 +++
> >  drivers/hv/hv.c                     |  2 ++
> >  6 files changed, 41 insertions(+), 1 deletion(-)
> >
> > --
> > 2.25.1
> >
>


--=20
Thanks
Tianyu Lan

