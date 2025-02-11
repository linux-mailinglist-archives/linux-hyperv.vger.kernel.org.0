Return-Path: <linux-hyperv+bounces-3904-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC1EA3148B
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 20:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4865A164AF6
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 19:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8989262D00;
	Tue, 11 Feb 2025 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+9jUF1d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C50025A327
	for <linux-hyperv@vger.kernel.org>; Tue, 11 Feb 2025 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739300615; cv=none; b=Is3K7wuVa1b9qWDvHBFtS0+++FqssXYOxxaE2g9T88ND+VdrPwFsUxa/r5TlinS0hjk1mME8dR9E3iEZtYiqGMHJ9HZfZ7WhN8PHYUHDJymsxrzBm6ZlgRVg7fLlZZ8HWbcyHVTkFOqoh3LuCUL2z9Bg7z6D+JuAIEehhjG2BOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739300615; c=relaxed/simple;
	bh=aFRbjSre0n/PpbhfPdOu1q5jYzsALXfM3ldTnjaDe4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y4rrr53aFYfHPWOc8+53iLtYdjuSYnz3Lf1zQ6ZK3F6GqqHoLWWCIZ4ZyH+tyY7RMXg0/2O9XSupZixQTy4ZqIYoKYlqc/KQTfEYITatIqXrjC/A+h8+aAfbNYopohRphrcMhDTOz/HZgZ3B0ckPg76govdrb2h+ZD9m6jUd41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+9jUF1d; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f818a6d75so87059735ad.2
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Feb 2025 11:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739300613; x=1739905413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6RZHwu8fSUx1PRlASdGoMqhsw6pMz1JSKazfVdmFy0=;
        b=q+9jUF1dp8fOhBh0u/9JltV1yPnW1ywnhgEDOTJFIe1TtXi+JNS56XKxP3IhbTSKcM
         MN7HL26FTuOzviCSghyORszxraETEmkLudxSBdFPFni3qpqXJCU8wMtqTHb8i+kEmsnE
         Nyv7CjaJPqZg4akjmcXLBTCGiutIJ63iLfLNhNGGhycg8y5ZCBtn5+ZZDKo6CoJ0VvFD
         e8ZCSh1lQcHJ1pFvodN/qzGB4Wo9LsxI/z/ltuDmnloTCCVCTQBhbotAmwNoClrinkqt
         1PYP5SVRqyOoSD3wN6A4lUx+VBD2Mar58hlZCMbIenvgRNgloUHjl2klp9fW6fRJmgjt
         fhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739300613; x=1739905413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6RZHwu8fSUx1PRlASdGoMqhsw6pMz1JSKazfVdmFy0=;
        b=F0APvM8U5tGz+M5xOsLd/N77PINBbcdC8PIvkDwMXdkDZjw5vBFymt0CVbo5jiu50k
         z6ilu1M0aerqAu3rMDHyrzL2MwJHqasZo6L6/f+QKCH80Aiq+BuAaebfurK2iVoKTHcQ
         UxtwUZPXJ8K8RpjJcEkFp7DSd718KChii0/Ja+FvacHfhTv0LcXxTC2LXK0hBHJxjaeR
         +jK/8RWqvSw6JZyEakf58HuQtj2mkrKgsRdHcwaRC8q8A62nwZRo1AwdS5uqQRrJdNIR
         juih2Mv5mcX1Qhl7yENTy3eOxseIBK1Uxv2i2es//vGdpEKsN5P04ljRbTyCI9Iige+Y
         9vkw==
X-Forwarded-Encrypted: i=1; AJvYcCVgPaeUJWl9eUugbRK7aIIQFfG+QPPt1RJ771Ta4k38x/z6YOkVBnSPqQcMsBaCoL5W+ZM1zNDhhkkvgEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8iuhADONC72vd1NN062lDaxb9r+z5pPI9VHhM2940BgeRwEJ
	SXDwLfU/ciQpNQ75cZrl3mM28WZon2pGqxu5xUxI2fYxWbceCLmpMaIzgPFPxjbbOgOm83xeLjs
	8hA==
X-Google-Smtp-Source: AGHT+IF83FAVS6JbAJzhSAAsNQR7sGHkfYmlENylg6JcCsQBTAIdcwm5DyQRH0pv2Gc0GyUcz7M5iSbKK64=
X-Received: from pfbbh7.prod.google.com ([2002:a05:6a00:3087:b0:730:7b6c:d5d1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:258e:b0:1e0:d6ef:521a
 with SMTP id adf61e73a8af0-1ee5c732f01mr650938637.1.1739300613311; Tue, 11
 Feb 2025 11:03:33 -0800 (PST)
Date: Tue, 11 Feb 2025 11:03:32 -0800
In-Reply-To: <20250211184021.GFZ6uZlZWPVTI5qO1_@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250201021718.699411-2-seanjc@google.com>
 <20250211150114.GCZ6tmOqV4rI04HVuY@fat_crate.local> <Z6uIGwxx9HzZQ-N7@google.com>
 <20250211184021.GFZ6uZlZWPVTI5qO1_@fat_crate.local>
Message-ID: <Z6ufBMy4u0jcmIl0@google.com>
Subject: Re: [PATCH 01/16] x86/tsc: Add a standalone helpers for getting TSC
 info from CPUID.0x15
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
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
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 11, 2025, Borislav Petkov wrote:
> On Tue, Feb 11, 2025 at 09:25:47AM -0800, Sean Christopherson wrote:
> > Because obviously optimizing code that's called once during boot is super
> > critical?
> 
> Because let's stick 'em where they belong and keep headers containing only
> small, trivial and inlineable functions.

LOL, sorry, I was being sarcastic and poking fun at myself.  I completely agree
there's no reason to make them inline.

