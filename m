Return-Path: <linux-hyperv+bounces-3829-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DACA2664F
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2025 23:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B31C1886A11
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2025 22:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777B41FFC79;
	Mon,  3 Feb 2025 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPJ2uRMi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE03B1D798E
	for <linux-hyperv@vger.kernel.org>; Mon,  3 Feb 2025 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738620203; cv=none; b=nClqkI79FkYVXZ2D+X7yw7xzIETlz86tsMnUBXtMSxfoJPtM0s6SAJd7vVSdAHx1shmuBF2Ef+h04A3kvZ6Rgaq4vwVpGW213dO3dCy8/eptj747bSV+HLahj+ViqN8zHknBrEOEuN3pIRTTPMdlnEp5egAgUuDPcumrGb73FoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738620203; c=relaxed/simple;
	bh=eUs8Te/3qXoZlaU+lsAvePAAnsKpOkJeJh7kJfdkLCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sIclL+RZ17FLRa+k7oKbCRd6GoI1hiQ0Vux1zc9tT0GsCMaRzNgcK5NY8112dearoPGPadedbp8WDLtxmFaTPV21MssEzxCR23L8boMmnTU7m8YoLd/+c87jU8mnTp2m5gVQ5WnrJtWVELLD9jgwdkeFboighi5WxIeGRzmnPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPJ2uRMi; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f03af09e9so599045ad.3
        for <linux-hyperv@vger.kernel.org>; Mon, 03 Feb 2025 14:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738620201; x=1739225001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKyU5o4qg4MzJLbHNBTuIVedrQGzcqdvvxUHOUnfSU8=;
        b=WPJ2uRMiUJgM3bQQsNM0Pkc059XwMwbqMjwDrLf12HbZazcBH6CoADNUnHYoD+jAs9
         Rz+YAr0JLfqY2XYXrNhfRt+Zossr5jIUb6Pqiw6aXH+Q5UTRDPKLWNQ0OXD9BBEQq9+W
         qUJS9XK6OoJh9bBXWhk4zGremufxG+KfWicSX5TbiFEgPnT2Th9+MZ8aHV0GKmNvc2Xd
         Y3N8uuxzAYuG3RuSDRiNs77a9c9f58rwxduJW8XD6iPtSAB7pDPRq9PtkyHsYOFnpOTo
         piNErgqNgahCjZXwYAzpEpBCIPfZZ79SHj+DC3GIb9SqgrE+dQZdaovkGtBSYGJWqzzQ
         Lvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738620201; x=1739225001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKyU5o4qg4MzJLbHNBTuIVedrQGzcqdvvxUHOUnfSU8=;
        b=sA3mBbWCxC9Ery3hBZMb3hFkBHatN7dZ4CUj3fzeCW1f1mPCCtW6U1LwJnGoW537bU
         f2hwvEqhCC873JVNnPwjsPl9P4JMI+IjE/E1fDF63fesvOSGiKUEDzJbYM38V5BXEM2d
         8crZ4mtOiLApAxhjfKVmilFN8HcZasJPhuobXfFaev2GEW+xXLoiB+Z2uLC0GrDJBo98
         Ehd/PU9UWstgifQVEU9UjCN2dBtFMgsZqFi1djftXUfq3tGsmpHvAEBUpeCjLwo0vwhX
         mgNpQbRZwdKnV1SFqlDa1xrTqY/JDqWi5dh/1LukNfBG1SJlTkehTJ3aXS3cVpSpy5gY
         U31A==
X-Forwarded-Encrypted: i=1; AJvYcCWRaJIWjxqZbrz5EOXJYvga21M0F9KzJ2SbToDKmF3OA/ZExWWKhsEURiBAE3wb3BUdUlt9o8JWMKZF7+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDSuP03sUk5sNE/2EzqLVrH0mrnhpte+MTMm5UJZ5z9qmhe7wM
	DqWbuRTPSIcgOQzyKLMWbYSeSsWnBMjWgns6633DjHkUwYonPwQm/KnlvDkAhIoPbAS0/PqC0Qw
	ibA==
X-Google-Smtp-Source: AGHT+IFdBp/YFKt3tvbP89npJlfJHjx2Z4+9Qkgevwe01Rjz28QPVaPLsqR/RKs2uDbYm8l82lXHNvJ4gI0=
X-Received: from pfbfb39.prod.google.com ([2002:a05:6a00:2da7:b0:728:e945:d2c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:acc:b0:71d:f2e3:a878
 with SMTP id d2e1a72fcca58-72fd0bc6c50mr33717772b3a.5.1738620200924; Mon, 03
 Feb 2025 14:03:20 -0800 (PST)
Date: Mon, 3 Feb 2025 14:03:19 -0800
In-Reply-To: <855xlra7yh.fsf@amd.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250201021718.699411-2-seanjc@google.com>
 <855xlra7yh.fsf@amd.com>
Message-ID: <Z6E9JyybI6SUWlcG@google.com>
Subject: Re: [PATCH 01/16] x86/tsc: Add a standalone helpers for getting TSC
 info from CPUID.0x15
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
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 03, 2025, Nikunj A Dadhania wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > Extract retrieval of TSC frequency information from CPUID into standalone
> > helpers so that TDX guest support and kvmlock can reuse the logic.  Provide
> 
> s/kvmlock/kvmclock
> 
> > a version that includes the multiplier math as TDX in particular does NOT
> > want to use native_calibrate_tsc()'s fallback logic that derives the TSC
> > frequency based on CPUID.0x16 when the core crystal frequency isn't known.
> >
> > No functional change intended.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> 
> ...
> 
> > +
> > +static inline int cpuid_get_tsc_freq(unsigned int *tsc_khz,
> > +				     unsigned int *crystal_khz)
> 
> Should we add this in patch 6/16 where it is being used for the first time ?

No strong preference on my end.  I put it here mostly to keep each patch focused
on a single subsystem where possible, since the series touches so many areas.  I
also wanted to show the "full" API in a single patch, but I agree that adding a
helper without a user is generally undesirable.

