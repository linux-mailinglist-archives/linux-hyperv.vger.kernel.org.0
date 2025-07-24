Return-Path: <linux-hyperv+bounces-6383-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA58BB1126E
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 22:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EC93BD3F8
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 20:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16249275B15;
	Thu, 24 Jul 2025 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEDgRHpi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49A2737E5
	for <linux-hyperv@vger.kernel.org>; Thu, 24 Jul 2025 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389473; cv=none; b=cSSNGo2CYeZXdedj5OxWSOu0B9FhNv8oAa33QWTHR61099zOCoQFZyG41cyuWe23JEh9aPfsUe+wlYxiygUssoqRNlikU1cMyzuNvEoiAzEbHj3tidrXK+WXSOXT+eSPnqWaoGsn1WD3zATauBa4fNqOz56a0y8Cug6pVzPYYD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389473; c=relaxed/simple;
	bh=3iJhYIBCliLx6cvM/xxvbhRa/DzQUN/C5dE3qUgVnlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=glcEqLX3mhjHSTB9Ewv/o4I6L8eNsG3E275Tv0XBSVSFTaM9mT6ozxUKwQz8g0ZWRIcW7LKs8Nxtej31i/Cqs1lhLvl5pxfFZ9v8DxoJZAzbmd8O0MozWn1DjTCVbFxq9yg16hs2RDDri83IB9ExMezPrU0d+R+kys8PSpfSg/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEDgRHpi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso2245108a91.1
        for <linux-hyperv@vger.kernel.org>; Thu, 24 Jul 2025 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753389471; x=1753994271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BadAfBHN4AUhi6edketoROygiJlH6yDIJ6nBg0r11k=;
        b=AEDgRHpiZSiaa2R157mKgOMG31T0HVziN7qk7TufZp1bkvwwAIZbCP0d0D5jsLvp9R
         1Rp8+5y6zqe9Ojrkf5YbiN/D+oaD22iI2y0yeyHGCNOH1k5FL13YyKGiimEoPvlL+eIP
         MZ8cMaoWTsFKiKZfnWUO0nj1RdUVDhkaH5YNP5KhIkBKsPuUAZo1JWJfkNS7jU5UUZYL
         rQp3gYS81Q+guaCJUjVx95rwWqfl7j8VaAvQcQV6f/jazpC8e7bf3xFsY7z2bTvHUxZj
         o2RO/hczvkRGw8PqRTX/ejvruh6KlB4jAgM/qMEexe2TZN6AUU2aXlM5ozKI2hoTtbob
         l9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753389471; x=1753994271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BadAfBHN4AUhi6edketoROygiJlH6yDIJ6nBg0r11k=;
        b=Tc/lx8fKBN8wJk1FR11CNlb07J9EOtJBu4rqHoU9jFdAHZFaOWiZce4ZDWguyYNySk
         0bC5rgCxB20Y0oWKmAV5MoVKRdCLCZJBh5kRkJsYPewlSZAdVPYBs491GWAZfWWhozzO
         5RDALzc5utGq9P9vECjs6jbvPrdUjekZtI2EKU19XW577aL/7LrG7anxkEevEXKQCDka
         o35gilyITKJRfnfcB+uF4T+O8SLnMf+oY0xmZsLrlF7zx67i/IMTf5N0gBqnuaNmHwYL
         QR+VtJl+PR2shyr/eSdaDnt27K74R62xV5fF6mk1sJiB7rmRchCUZ1uD1gO46f1yM7BU
         9ZdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQS44BvindFNTkR8v5XXnwcX/8iACTTdEBLYtNi73yvUxjh/Q5fUrbQ7n6nt7eK1AbYGGZgo2DbCX3U4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Df6AfFFQN3sB8DAEwcceiGKpTewlb9TP6OjxAfjmC+6GzeAQ
	H8HDZsljNkjhvc/q4MtNUOeo6O+l2H2e63rZtx4X1F5GrIf7k6GMVoI5EhThDcIjVlu2su4kurr
	GvN+rSA==
X-Google-Smtp-Source: AGHT+IHE6eAlwl7jscbkUzp5U5t1vNbnbqNXqGFHZeQed0+nu225pCuYGNqmuyqiKrC1WFWx4eys1B4+PuU=
X-Received: from pjyr5.prod.google.com ([2002:a17:90a:e185:b0:31c:2fe4:33be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5487:b0:311:f99e:7f4a
 with SMTP id 98e67ed59e1d1-31e507cddb3mr11188514a91.26.1753389470881; Thu, 24
 Jul 2025 13:37:50 -0700 (PDT)
Date: Thu, 24 Jul 2025 13:37:49 -0700
In-Reply-To: <20250714103441.496787279@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714102011.758008629@infradead.org> <20250714103441.496787279@infradead.org>
Message-ID: <aIKZnSuTXn9thrf7@google.com>
Subject: Re: [PATCH v3 16/16] objtool: Validate kCFI calls
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
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -361,6 +361,10 @@ SYM_FUNC_END(vmread_error_trampoline)
>  
>  .section .text, "ax"
>  
> +#ifndef CONFIG_X86_FRED
> +
>  SYM_FUNC_START(vmx_do_interrupt_irqoff)
>  	VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
>  SYM_FUNC_END(vmx_do_interrupt_irqoff)
> +
> +#endif

This can go in the previous patch, "x86/fred: KVM: VMX: Always use FRED for IRQs
when CONFIG_X86_FRED=y".

