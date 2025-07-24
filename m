Return-Path: <linux-hyperv+bounces-6382-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2E6B11264
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 22:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41241D0014D
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 20:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0040279907;
	Thu, 24 Jul 2025 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lrmsMLvm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34317231A55
	for <linux-hyperv@vger.kernel.org>; Thu, 24 Jul 2025 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389074; cv=none; b=sJzuAeNoSKJ0oQUL+JDhBdBVC/4jHg0ivqn0pdaR8TcPckYEQoPwo3q6k+BEuQN2Wc3XiZTnS16RSE58IFVvWLtBKx67GilNWlK5K/mB/v4Qqa8jxv9Zn3UT2ySmlK5qzIdpXTZ2sFtKIH+qHsj6AZiRgWOUV+P20q2+dV5UWRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389074; c=relaxed/simple;
	bh=xr4h4NT0jwcMU2B5nPm5uz55z+/LrSO92SZvY/onUEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jtOjwTbAMezxDsbpaOY+W4dRb59OkckVS8jCyfrcsdG2B48RrgcHy06bFZi7qLr4EcMEygrOJkX1hlXobjjVr6KDgwyyUowZAvDxwftJta/HTM/+LlEcqBpgQlqrdOlLV3am6LhsFSeYug01RnCLL9hzwjDXSLIX8Tni8GaWp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lrmsMLvm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74b29ee4f8bso1280048b3a.2
        for <linux-hyperv@vger.kernel.org>; Thu, 24 Jul 2025 13:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753389072; x=1753993872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDiDRr/Nq67IcbEOn/9DxcYykCFSVaBcSB5snb6HDUg=;
        b=lrmsMLvm0fjaR+f46uNsslvtNlSUtsAUUvLdaxI4hrs6t9NnDcfbDpi5/bNSwLADjn
         vshMUnVZ3aNFY2aGjszxvhOo9UwUcho7xIg8wBt3DwkmrwtiXXAOQS+l9HozpzlmxHW2
         4XTsgN2BBd6AMsEtXCJioH9HfyjI5im6C/+WvYlvqokaHazD8+OQKVi+K9JHQUoICk8c
         y1j9dtkfKMUJ6q7/NjVKYSaMRXtm31Ru1edtpYv7eGOTL656wkp1rIHadEvLJPoSgqWY
         +XWzaB/Umop9MIl+Qr+m8If1wdcSOmiNttGdBDJjfc9HEpptT6fDgqFv9f999EZUuN+C
         AwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753389072; x=1753993872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDiDRr/Nq67IcbEOn/9DxcYykCFSVaBcSB5snb6HDUg=;
        b=N1P1x+P3/pAzqh3Dt2nX7KzpqqCRjNShNonjr+oR08Xzkw7pSOSRvF2p3EH77U2R86
         yYQc/cjbS7SLvCThhdzmvm5JTP8E9RWhVchlCUI22pEjMo+jMSk38PcNymydIcxIDPKJ
         wJc0CChv3bKCgPvXfp+ofspGPRP3nJjdLQZ5C1JY/63qrpdnzWQUNq0HjeEPKORBS/KF
         tHS+bU16VaB4YrB1xL+PGyHjHgxQRYs8tD1AtqYFVRX6+SkERsz8diOJ4f99ZLc1Ge63
         V+XEZEWrdj89ftEPexXxEyk6JKpP0CVI6ekXZI6O4IfOPrqcT2z+yw/PprrN8DvU++TG
         ayjw==
X-Forwarded-Encrypted: i=1; AJvYcCWkAB7WMFa4AlbbPTFNH5MU3zUzpU4lpko0bgKsFVSiJTo/WOYdaTUtTTDhVUohfrbI8xhtrwWl6B1bjqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJLERj2vcL2U1zf5FTVZxY5x2anzMPNf6H8o5OuJZy/6w/y4h
	eI55XnrZ2S1MhpQAFdV3cPrMJHiLj9UTCV/ZrHNCB1Rv1SJJc9OGKoRukW/Dtbr8LG5zOPx9M4h
	968qgng==
X-Google-Smtp-Source: AGHT+IFa2gMK2RpRyNs7pkOkWZnaVUgjRpZNHMpdUN+cIzXcMHUn31YL9+KEzJOBPLlJHnzq/CppzAI6uwA=
X-Received: from pfbcj15.prod.google.com ([2002:a05:6a00:298f:b0:747:7188:c30])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22c6:b0:748:2d1d:f7b3
 with SMTP id d2e1a72fcca58-760356fb061mr12488600b3a.22.1753389072461; Thu, 24
 Jul 2025 13:31:12 -0700 (PDT)
Date: Thu, 24 Jul 2025 13:31:11 -0700
In-Reply-To: <20250714102011.758008629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714102011.758008629@infradead.org>
Message-ID: <aIKYD1Csd4IjmD54@google.com>
Subject: Re: [PATCH v3 00/16] objtool: Detect and warn about indirect calls in
 __nocfi functions
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, pbonzini@redhat.com, 
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	gregkh@linuxfoundation.org, jpoimboe@kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	samitolvanen@google.com, ojeda@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 14, 2025, Peter Zijlstra wrote:
> 
> Hi!
> 
> On kCFI (CONFIG_CFI_CLANG=y) builds all indirect calls should have the CFI
> check on (with very few exceptions). Not having the CFI checks undermines the
> protection provided by CFI and will make these sites candidates for people
> wanting to steal your cookies.
> 
> Specifically the ABI changes are so that doing indirect calls without the CFI
> magic, to a CFI adorned function is not compatible (although it happens to work
> for some setups, it very much does not for FineIBT).
> 
> Rust people tripped over this the other day, since their 'core' happened to
> have some no_sanitize(kcfi) bits in, which promptly exploded when ran with
> FineIBT on.
> 
> Since this is very much not a supported model -- on purpose, have objtool
> detect and warn about such constructs.
> 
> This effort [1] found all existing [2] non-cfi indirect calls in the kernel.
> 
> Notably the KVM fastop emulation stuff -- which is completely rewritten -- the
> generated code doesn't look horrific, but is slightly more verbose. I'm running
> on the assumption that instruction emulation is not super performance critical
> these days of zero VM-exit VMs etc. Paolo noted that pre-Westmere (2010) cares
> about this.

Yeah, I'm confident the fastop stuff isn't performance critical.  I'm skeptical
that fastops were _ever_ about raw performance.  

Running with EPT disabled to force emulation of Big RM, with OVMF and a 64-bit
Linux guest, I get literally zero hits on fastop().  With SeaBIOS and a 32-bit
Linux guest, booting a 24 vCPU VM hits <40 fastops.

Maybe there are some super legacy workloads that still heavily utilize Big RM,
but if they exist, I've no idea what they are, and AFAICT that was never the
motivation.

As highlighted in the original cover letter[*], fastops reduced the code footprint
of kvm/emulate.o by ~2500 bytes.  And as called out by commit e28bbd44dad1 ("KVM:
x86 emulator: framework for streamlining arithmetic opcodes"), executing a proxy
for the to-be-emulated instruction is all about functional correctness, e.g. to
ensure arithmetic RFLAGS match exactly.  Nothing suggests that performance was ever
a motivating factor.

I strongly suspect that the "fastop" name was a fairly arbitrary choice, and the
framework needed to be called _something_.  And then everyone since has assumed
that the motivation for fastops was to go fast, when in fact that was just a happy
side effect of the implementation.

https://lore.kernel.org/all/1356179217-5526-1-git-send-email-avi.kivity@gmail.com


So, with the _EX goof fixed, and "KVM: x86:" for all the relevant KVM patches:

Acked-by: Sean Christopherson <seanjc@google.com>


P.S. Thanks a ton for cleaning this up!

