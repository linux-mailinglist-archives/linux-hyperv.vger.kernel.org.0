Return-Path: <linux-hyperv+bounces-3898-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C49A3114C
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 17:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D841626E8
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08042254AE0;
	Tue, 11 Feb 2025 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJfVChW7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614B26BD8E
	for <linux-hyperv@vger.kernel.org>; Tue, 11 Feb 2025 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291303; cv=none; b=YVZt7qfJy6m6AiYDJivmIAQNQhHpZO690hU+kkxIuoor8F1aYPpW/nllvha803ymQ4KYvLa0zxC74qkd6CJxSLR15es+70uWd3rtFUWGYqlPLLDkDt4SvCTPvpv/BDQgq48xJAeNbynVgkh+YLFIXpvoZr6pJ6rx5sd4kiBxnMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291303; c=relaxed/simple;
	bh=yilJGqWW4RYMKFOjUyyusb+5EmeDe91eA1bXhwR/YFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o6wBZJX7lk5x4BJ+lTQ6dzWGUAlAU2NodYTCyLoO4TggJXQkh677YCLx2yzuZgeXI427pqUBpSsqwrrO//6ytiRhpQ+DY0UXZ+05u3MTnc4g0Q3iLBGyoxJNvXSfYbuDYAAyq1wgPvjXE4+UFmpHpwnRkyS+gKEH6FyKuVjSvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BJfVChW7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa480350a5so6307235a91.3
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Feb 2025 08:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739291301; x=1739896101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MEK/stSb+AMRyC9Zhx6OFHXRnHPVcvklj9Pc8LhwOQ=;
        b=BJfVChW7Y2jO/ywJh08g35IqukXtKRfHNnPeT6Bb3V/ctZQ55gghSQG/uMR3pK21Bs
         JvH9zAxfQCZnieEjFG21FepKyMy0VktvKZSM/wHgUVMek3KngJeRFAWXnlQAkLJT1fBO
         0kMJoJyBhJn5C60ZaCV+zrWIdUi6Zp+F0SaVohKpppry40OkTPtUxLz0BEJcAkrE4P3z
         coKYEgCgw68vqVQHOn3wKvdFlL+OtKZkDRqGA1tdPq6Qwq9gKRpKzP6HBbxvHQFo4dfz
         lyfP8pWshLNusB9L9qdUDpMa8h2AQPhbAQKAkjhxJAY7oMQSiK0mbyUUy75QWfWcg40P
         i1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739291301; x=1739896101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MEK/stSb+AMRyC9Zhx6OFHXRnHPVcvklj9Pc8LhwOQ=;
        b=Gon2kJXBn4bigyVf1ZRSS3YCPu6wM+Dh8zg2ANEzliuj2D8aqwlJ2j3ZwIs/tXVqqq
         WsUyengXR4VViA2+vtk5xntR9DU+VnkQ4yoad+2rGgT+/BnQwsimoZ7tEs713O1NPcBi
         wHHE8RaHq2qP64cLlTkbgvdiLJH+49vZxKLtyu/GVI+oPs3iPU67lR9bJ8VLKDaiiMq7
         jwKwd6p4PsIKF915iLxpmvU7Gf9l9In2FUX+ak720e/r1TnmlYHEdyAfBTbQNgkCJUUG
         BYwdO8HcvyG55r/4UEhRmXTYmMuh5sB84K0n5+JHzQ/iCv6+qnLdtdPmV7P9IgxbRz5i
         ROuA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Nv1sl00gymCX93+Zklsswmd3670HaXZSeiv/Z/Sl72DDtR+ohOuI0HalmNC1bZkDnk7ZDzHDDEsV2tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVoGNf5xdfAT5E2H26VYs1CbFIyuslRcMN7BRo5MD6k8lw5GHE
	mHsGegcfOKyOXmXMfO3CpTn8j7ct/lru4imUQMWafrHkwXYU/CgRkcP7y9omagDzbBFGe57kvOv
	8vw==
X-Google-Smtp-Source: AGHT+IEW6FT5SzWSOj0JB0UAPg+blRK0ibYMj54XT+2rd1e326WroNU4nUmkSnUDL4aqV/75Jp14hq1SYiM=
X-Received: from pfrc11.prod.google.com ([2002:aa7:8e0b:0:b0:730:7648:7a74])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:188f:b0:732:2170:b69a
 with SMTP id d2e1a72fcca58-7322170b72bmr3189092b3a.18.1739291301572; Tue, 11
 Feb 2025 08:28:21 -0800 (PST)
Date: Tue, 11 Feb 2025 16:28:20 +0000
In-Reply-To: <20250211143919.GBZ6thF2Ryx-D2YpDz@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250211143919.GBZ6thF2Ryx-D2YpDz@fat_crate.local>
Message-ID: <Z6t6pMgAjHckWMs_@google.com>
Subject: Re: [PATCH 00/16] x86/tsc: Try to wrangle PV clocks vs. TSC
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
> On Fri, Jan 31, 2025 at 06:17:02PM -0800, Sean Christopherson wrote:
> > And if the host provides the core crystal frequency in CPUID.0x15, then KVM
> > guests can use that for the APIC timer period instead of manually
> > calibrating the frequency.
> 
> Hmm, so that part: what's stopping the host from faking the CPUID leaf? I.e.,
> I would think that actually doing the work to calibrate the frequency would be
> more reliable/harder to fake to a guest than the guest simply reading some
> untrusted values from CPUID...

Not really.  Crafting an attack based on timing would be far more difficult than
tricking the guest into thinking the APIC runs at the "wrong" frequency.  The
APIC timer itself is controlled by the hypervisor, e.g. the host can emulate the
timer at the "wrong" freuquency on-demand.  Detecting that the guest is post-boot
and thus done calibrating is trivial.

> Or are we saying here: oh well, there are so many ways for a normal guest to
> be lied to so that we simply do the completely different approach and trust
> the HV to be benevolent when we're not dealing with confidential guests which
> have all those other things to keep the HV honest?

This.  Outside of CoCo, the hypervisor is 100% trusted.  And there's zero reason
for the hypervisor to lie, it can simply read/write all guest state.

