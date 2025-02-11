Return-Path: <linux-hyperv+bounces-3902-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA4CA31350
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 18:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2466D7A052D
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2458626159D;
	Tue, 11 Feb 2025 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1kzZjwal"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9051E17C91
	for <linux-hyperv@vger.kernel.org>; Tue, 11 Feb 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295807; cv=none; b=rtYIKxOKdUq0uLr+rYvy8YwzfyUKM4Aos4ZqVXyhISRFPBUYK2PSso4FOeaGF2Rm5ibzOprTLV+A9/AeD0axFdMV0all7pYJVR26llaepMy+n59YGeFAt3y+u1m0+RH9aAESYTP5//To20KgteHjMN0LBfCQ6DZz0I023G0ga9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295807; c=relaxed/simple;
	bh=7JLxDrT3W6Nr5nwag7NkXl8otRQTU+qirxdskHYS1cQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H4udFNz1AhXbKuR3prgAjPNgFx2BFRQ0lk0Ru6yUA00k2oTqh3B4BeOVzZ6rghQOaYytVHUfoq39BVf/hDuO1LxsRHrS1R+JGzog8s4XpvSpFVut2b/RcEEj/yEnzRryPl3pHbA/NnRd7S7dLx+EXiHXuMZ9llHGc1sfy2PTBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1kzZjwal; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f7f00c75eso55811485ad.2
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Feb 2025 09:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739295805; x=1739900605; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4mrriPfgsPPxXSFmU/JBzChLIiRw5rZPULaSxSIiLc=;
        b=1kzZjwalaPl8jk092FszygdrR98spkNew2LzHWEsrt59VyjAqtduuEFBcLYkPQC+8W
         2WmKM3zQdlArcP9z2bSmL+97fvObWIPgsSXD29htY9ply93RCGXMO82DWVF6Z8IJhrS6
         WiDeqL+kBXaLiv5PvNwZkKlJwXNU9two1d5D+6x3kCokO0ZUTo5CCziLw48ukK+AyWBr
         syhZfHbg6h6lQMi9gWajakhfuaf+XVDKw1LQn21NTGZBHTjYSLfFhwY8IoGQt888t7ub
         jjnX9ACA/z7s4X40nWT4L+4VyhrBon3T5ZgGqrQnsHi6M2r3kJpK+4UuBJn6uwC46jIM
         C3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739295805; x=1739900605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4mrriPfgsPPxXSFmU/JBzChLIiRw5rZPULaSxSIiLc=;
        b=VJRuX9Ysrx7jSmmxfd223lQiPYU8B7ZGg3TFxT8V1wEKKJcvbNL3MJxSGxzT0/iAWr
         Up1rTS0EpQzqAgRpm7KGMOqXwwPIYwjMVv1KZBREbTn/ivmwNvERcdGBDfvlZtOOD1p8
         OPdkBB3eI9/blyu5L4jKkhSMJUq2sjbIDnW/US3GUKZUznHDtI17alZUKkMQ0X1gKnnN
         rGitODoXFyQz6flKJ24oYg6/wa5ZSYU96xB0txO+zBhuH9m2SEeCRQwjk23yejl/3x4B
         2613BFU38+lmejDmj1fslBk++OR7vF+uY0KUF79NmHA1M1PBSaxhbMX3agdYM+73geud
         ZDEA==
X-Forwarded-Encrypted: i=1; AJvYcCUSxSDrM7r02GBKRhXlgMyB0LwrSkrJ+AmiJbY6d0ZkdxK+lJ9U7PLDEgAJQ+GEhfryPWZ3YAFO+MgjEVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1QhiOfGw8jQ1tpa48RRvG4Nfh36A4OCKdDTk6uNz+fnya2UTB
	f0ELS0OvYyBrAcwevH+Mq5OEKnW8GtBNFvTD661tAU51aio1in96sxpDegwbu5XIQSB3pDeHewR
	6Cw==
X-Google-Smtp-Source: AGHT+IFvsE6NJWsYg5eZawythPvtd1Ryiyh5QdfSD0iYprnIkMmal30fbTQ5swLortjkJ0haAujEqXDb7dE=
X-Received: from pfbbj9.prod.google.com ([2002:a05:6a00:3189:b0:730:8ca0:1f9b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:998f:b0:1e1:becc:1c9c
 with SMTP id adf61e73a8af0-1ee5c7db2d5mr167479637.28.1739295804800; Tue, 11
 Feb 2025 09:43:24 -0800 (PST)
Date: Tue, 11 Feb 2025 09:43:23 -0800
In-Reply-To: <20250211173238.GDZ6uJtkVBi8_X7kia@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250201021718.699411-4-seanjc@google.com>
 <20250211173238.GDZ6uJtkVBi8_X7kia@fat_crate.local>
Message-ID: <Z6uMOyHD3C6-qCXz@google.com>
Subject: Re: [PATCH 03/16] x86/tsc: Add helper to register CPU and TSC freq
 calibration routines
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Nikunj A Dadhania <nikunj@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 11, 2025, Borislav Petkov wrote:
> On Fri, Jan 31, 2025 at 06:17:05PM -0800, Sean Christopherson wrote:
> 
> > Add a TODO to call out that AMD_MEM_ENCRYPT is a mess and doesn't depend on
> > HYPERVISOR_GUEST because it gates both guest and host code.
> 
> Why is it a mess?
> 
> I don't see it, frankly.

It conflates two very different things: host/bare metal support for memory
encryption, and SEV guest support.  For kernels that will never run in a VM,
pulling in all the SEV guest code just to enable host-side support for SME (and
SEV) is very undesirable.

And in this case, because AMD_MEM_ENCRYPT gates both host and guest code, it
can't depend on HYPERVISOR_GUEST like it should, because taking a dependency on
HYPERVISOR_GUEST to enable SME is obviously wrong.

