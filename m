Return-Path: <linux-hyperv+bounces-6372-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43615B0FE15
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 02:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE423A3521
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 00:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC9DC2E0;
	Thu, 24 Jul 2025 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbdPVhoh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AD24A21
	for <linux-hyperv@vger.kernel.org>; Thu, 24 Jul 2025 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316202; cv=none; b=kjr83ELKUf1GUO28LgAgtOeBXTcX6EJzq2c2pDP7i+gbgqwXhIxISotdcu4eJjItrZx7kkt3kNlqF84U0Jdii58uGhcaCPJ/pZDq+3cBqxRZYvnRCFp7N5BgsA5Pk7OAFPp362HfEqhUODQmnuoISPY0kaJ+iyJSqlVKfKcQ/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316202; c=relaxed/simple;
	bh=pTqHQJPkx65su/NuAJ3No9eSQcZxl1N1hB4cgR2bU/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lwgxzKTMZ6i06LL6/fXrsZ/9jhGRMB5A08nA9Y2ZFCE+VfQpP5Ep9++07gq2VnZ0SIwvCMBAW2Ql4n5McaldEs2YvTt6G3Iq/8utlnX5PFJrs9+p8BqFNtONhYV28Gwj+UFGHJ/ToE9+rllFM+0I91+sNhCEJ92GwM02mI1AunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NbdPVhoh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso372784a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Jul 2025 17:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753316200; x=1753921000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPZ6P7qny163Me6EPudgKXJwV0FhWmeseWBHotelotw=;
        b=NbdPVhohvZZDn7cBTTvNgo+/lnWLy52I5gTmj1TuCwn/YyMtOwnp1L//eBiouGBwR3
         NTHXSqTFdtWxoV1wMZm62mkr3aVRlIyHWaEap8yz3MCTwa89dtkjcQpbgSyAorUf0Fzz
         QaxkPj7L/b7Ub2j1jeqMCYYuCOUGqO/DssqiEXkE3hRgMGJw04eaE16VfmkGgtwn6TKa
         fMSioBLWAnJFr2jvglxAS2x5O2+q15hwKgyEjhFutaqUjYIghX7k6pkKG6n7DMkZiFh+
         olfYQbVrtoYZZxxbo4hewvwTNDEm62Dj1XUjsD+iZ7Nb+eeuRRvQSihiWZZXgQnsoF7O
         Ei0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753316200; x=1753921000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPZ6P7qny163Me6EPudgKXJwV0FhWmeseWBHotelotw=;
        b=ljGx3C1EQGWD338xiKtRAJfnSxQD6QUu8B4mwuQQi0AFpcKyc8qeaRjucUrKXJQfnN
         LSpHqDR02855px5Xr2VyWtyIO3VXevu49M1ZPq2l6jMY+WIZTGLnGJJhpywlj12FeSz1
         Jhoy6O21H5I2MMqiPytUBeci7hLSQOMfakIxykpbTYuqq5gP69rsjnacJ/+LV5is//Ci
         vgyboLmsb8w6LtYwTfXGeJ+I90feNmxN+gd60WB9IJwLqtc/FFaJCTABdobux2pbnmZN
         J1E9InVBsuM2lJ96QIRhG1/Mfyk2Zo4y4f5C2IHa5I5hTJsNhjPJwnOlw/Cn5UqHYtzh
         Z7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUFj0Lji15+MZOEib7QO05nT75auWaXRXrbJFE2CbfKzAB09AdlDyE/2UJ4dmdVAZ9WqgKm+6EM+GGbeWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+kAaX+e3R+CqWiyk72dLxVOyYFrDVNQ0HLg2rlTCg44QQO06K
	/KTzEE3VLbCGGHlzHlDr6UWsV9/nSW4keCPtZMp2nPyTkuHLu//nTPV+o9/2m3tvAW8zuuU5NeS
	Fxr1Awg==
X-Google-Smtp-Source: AGHT+IG46sVTGrQfC+1ZcgLyXUFOMidiHD1ofE0XoALXwfSqQrVszox75E3QvJ62kfppObrtzgyM9Vs3LX8=
X-Received: from pjtd18.prod.google.com ([2002:a17:90b:52:b0:2fe:800f:23a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:240b:b0:31e:60ac:bf65
 with SMTP id 98e67ed59e1d1-31e60acc86emr1085678a91.27.1753316200082; Wed, 23
 Jul 2025 17:16:40 -0700 (PDT)
Date: Wed, 23 Jul 2025 17:16:38 -0700
In-Reply-To: <20250714103440.394654786@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714102011.758008629@infradead.org> <20250714103440.394654786@infradead.org>
Message-ID: <aIF7ZhWZxlkcpm4y@google.com>
Subject: Re: [PATCH v3 07/16] x86/kvm/emulate: Introduce EM_ASM_1SRC2
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

For all of the KVM patches, please use

  KVM: x86:

"x86/kvm" is used for guest-side code, and while I hope no one will conflate this
with guest code, the consistency is helpful.

On Mon, Jul 14, 2025, Peter Zijlstra wrote:
> Replace the FASTOP1SRC2*() instructions.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kvm/emulate.c |   34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -317,6 +317,24 @@ static int em_##op(struct x86_emulate_ct
>  	ON64(case 8: __EM_ASM_1(op##q, rax); break;) \
>  	EM_ASM_END
>  
> +/* 1-operand, using "c" (src2) */
> +#define EM_ASM_1SRC2(op, name) \
> +	EM_ASM_START(name) \
> +	case 1: __EM_ASM_1(op##b, cl); break; \
> +	case 2: __EM_ASM_1(op##w, cx); break; \
> +	case 4: __EM_ASM_1(op##l, ecx); break; \
> +	ON64(case 8: __EM_ASM_1(op##q, rcx); break;) \
> +	EM_ASM_END
> +
> +/* 1-operand, using "c" (src2) with exception */
> +#define EM_ASM_1SRC2EX(op, name) \
> +	EM_ASM_START(name) \
> +	case 1: __EM_ASM_1_EX(op##b, cl); break; \
> +	case 2: __EM_ASM_1_EX(op##w, cx); break; \
> +	case 4: __EM_ASM_1_EX(op##l, ecx); break; \
> +	ON64(case 8: __EM_ASM_1(op##q, rcx); break;) \

This needs to be __EM_ASM_1_EX().  Luckily, KVM-Unit-Tests actually has testcase
for divq (somewhere in the morass of testcases).  I also now have an extension to
the fastops selftest to explicitly test all four flavors of div-by-zero; I'll get
it posted tomorrow.

(also, don't also me how long it took me to spot the copy+paste typo; I was full
 on debugging the exception fixup code before I realized my local diff looked
 "odd", *sigh*)

