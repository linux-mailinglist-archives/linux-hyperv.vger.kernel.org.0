Return-Path: <linux-hyperv+bounces-777-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B58E7E5BD6
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 17:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0F71C208D3
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA431945C;
	Wed,  8 Nov 2023 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPWK41NJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5801944B
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 16:59:43 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605DB1FF5
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 08:59:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9caf486775so8232070276.2
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Nov 2023 08:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699462782; x=1700067582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpEPwj1+3M0yPZeVquG+vKJ0idoDjxiUbhXJ8UOhbv8=;
        b=XPWK41NJ9TP55vaeDEW2CT2aoqip51D1Wxgzh9niv3qPYTbggkIAnTWPUA/ipAbpCI
         zQ/H0ERgHA1Ag6evaNHjKRoaY5K41wFKS4ZtftcNRKilR9Lm7N7vatAljEFFZAktKRvY
         Y0FGXdypJCyqfYL6FiUBPNb5whllsbXRiRpbnnzodj8KCuppIJZCobxXf4e8oeBHEKk9
         ZJP4yv6ZT+roRS0V8e6X8zMqRMBbMu5KRWdeLUlAFxFz0rIR5fxFd8PelzUQtHChoHDp
         MjFzulTvHZlRdC1qows4uqHyNzT1pV8sCGc4bgFAJ8CKTmqoaNXuapgJvOuvW3iDipoX
         n1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699462782; x=1700067582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpEPwj1+3M0yPZeVquG+vKJ0idoDjxiUbhXJ8UOhbv8=;
        b=SBRi3784FC+8JeLr5aYVHjoPdp0SrwgVWXtL714yC7ZAXYDiQsNyHSoUtfNPD3bJ/0
         02b/07oCbM4SffuBc7YkcQiUmLw5IktksQjKp1db24RomwEOAY2Xqr7WunNO9FGvYtZn
         K0bKfrD+OK6UBXQgYQbOMc1Gd20AotopI5j16HiHNnfzt9v/kjhzK/pn33Ysk1Z9VuUW
         Ea7d7/0iQxv5P93zKkSth8Rf0kvcBGpP0iDMTKXpSOcy++HfZFBbH1isTf16ikedqG2Q
         UkG9hQsYeOBn35hHV0WN1KnRwN+2aZRoH3XKt/3M4gDipDHNnR320KSyo8M1VuGPtDl1
         EhBw==
X-Gm-Message-State: AOJu0Ywrxd0TnK4lSvmu9kRmbDxdRcYj0sct6HdHAqdwAKRU3dZNsjVj
	DZL5yYSdikAVODevCvdZY2XrwKjBrlQ=
X-Google-Smtp-Source: AGHT+IFJxSqbqH04V4CdJrSt2ML48nciNEkXKyUcY0n7jXVYIpLnHLDjSshRNYH2nl7Ej/GNN7RSKDGvir0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d384:0:b0:d9a:c27e:5f37 with SMTP id
 e126-20020a25d384000000b00d9ac27e5f37mr43658ybf.3.1699462782601; Wed, 08 Nov
 2023 08:59:42 -0800 (PST)
Date: Wed, 8 Nov 2023 08:59:41 -0800
In-Reply-To: <20231108111806.92604-19-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-19-nsaenz@amazon.com>
Message-ID: <ZUu-fZl3ZK2Vy8M8@google.com>
Subject: Re: [RFC 18/33] KVM: x86: Decouple kvm_get_memory_attributes() from
 struct kvm's mem_attr_array
From: Sean Christopherson <seanjc@google.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com, 
	anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com, 
	corbert@lwn.net, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 08, 2023, Nicolas Saenz Julienne wrote:
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 631fd532c97a..4242588e3dfb 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2385,9 +2385,10 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
>  }
>  
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> -static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
> +static inline unsigned long
> +kvm_get_memory_attributes(struct xarray *mem_attr_array, gfn_t gfn)

Do not wrap before the function name.  Linus has a nice explanation/rant on this[*].

[*] https://lore.kernel.org/all/CAHk-=wjoLAYG446ZNHfg=GhjSY6nFmuB_wA8fYd5iLBNXjo9Bw@mail.gmail.com

