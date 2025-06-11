Return-Path: <linux-hyperv+bounces-5865-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCB4AD5640
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 15:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558A31BC332C
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 12:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC4D28313F;
	Wed, 11 Jun 2025 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AR569d5I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034BB281357
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Jun 2025 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646742; cv=none; b=hKF0g1KRcVankv9K0ghrpNopVv61pz5eg2ult0nQVfoIYpMahRvA7OT8zHsivn6M3kDK4A/T0i1ExYu53zKegfDp4ZwZ2krbQgQgirgq45Hzz3cQwziOUHI0Dbi6P+khLBZBwVEEH359cKJiOibr1MDae4AaJGB6U1LtxXf5elE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646742; c=relaxed/simple;
	bh=a2tnsV+oorpD96ckvy193k53s6Jk34v+Ogifp++7l3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NlseKxAbxBs7IU99YfQZ6xn01ZM5x93k54kQDYtNKX6gZD5248C/REJpx46ugNp+OtgKoSegqx3Y8koTczWuL2+YQPxGtnxlAN4Opcjzc3cQgob0YmEpxnnxwLPZhTPoRLG4VkCPM8KTrM9Vx3Vc36L0Pmgm7tzDsJq5z/kEWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AR569d5I; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-310e7c24158so6354493a91.3
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Jun 2025 05:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749646738; x=1750251538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7qyDxfambCUeuVJ579d13LTUju7h5fRgxZwQlTMLrA=;
        b=AR569d5ILcR68f7Pxq+LwHL6RLFU05NqwYpOdaJ+Qe3OQXO+ptf3U/4rAxU3AN00o1
         CO1NogIZTZJUC3zY+9FP7OHtWuWFe3Z3Z5a44yoSr19Ykjfuxlgn9wrvtH9uK5yxE8iB
         dUQCSybEc1Q4m2JgIPQQiRQxqpmsXh1VQvlI127wfVbYjVoN6Gz/cxuhGk8oPeawHQZj
         KGfj/ckfORUQQUiT4MjphLHHjexsBpzDuNOawuiWmjowG8sWlhgD6mX6zuyLYqArNDhm
         dnkZS1xSKCxBd4UhDZyBYLVODaztffrV0Fzvvj+cix5CEEbGynwKCWljB3UZDItqmbj8
         vi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646738; x=1750251538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7qyDxfambCUeuVJ579d13LTUju7h5fRgxZwQlTMLrA=;
        b=vOtkFGXe83CO+HyFVOgAUH4TJiVBhdrKmiuf0lRYDwQz9cresQ+KVYTgGySsRLt5Vd
         gftnbvY/oFVAlJcHWao5Asu4tuekTZJvFkSVzaoFlN3RpWDbDPB00LfCxlNx7m5IDDPW
         jp04j+VHMxj2Dn1gYena2dJlVqcwCUsYM54w4yIWETQlqCuBU1kYHnay6ZPnX9Q3gxVp
         lhYF1R4lfS9mqKVVQXZ2dSKGq3fxXoifgiL3NjXPJ3np8XkBEzXB01B4hWhZ7Mi23+Kw
         vcd2qj3Mka5kRslYqdRrwLHB02AVhh+UEnGWU58F4GeXy3Cy4Rbyb30tMJfqGpP+VuAR
         M2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/CREac1Be6rkYGpnMvOuqjDV03xE9OcRzNUvUVKzd+KVL2tgvZ4Cld+hhpSYy9uJ4aesIGuX3bEmn+g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBIIDTuRMRvzwVxqlVRUwO3g8ByOXNBb1vvxSZtw0C3f3DyQQ
	n0n9Jn2XJXJp/FFPQZvsooqk6LM++YCR8AXk59Xx7awM6eLVBNiRgA6BvOEPuDA9mLMZIoPIQXw
	ejtAAtA==
X-Google-Smtp-Source: AGHT+IFdzlhprq4olNF24x13BTaUWLzAfJB7XPYxrgkrprbcAns4rzVG+UdGiB00+0oVMZb22058wK4h5o8=
X-Received: from pjg4.prod.google.com ([2002:a17:90b:3f44:b0:311:2058:21e7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:540c:b0:311:df4b:4b93
 with SMTP id 98e67ed59e1d1-313b1ea41c8mr3910557a91.7.1749646738303; Wed, 11
 Jun 2025 05:58:58 -0700 (PDT)
Date: Wed, 11 Jun 2025 05:58:56 -0700
In-Reply-To: <20250611100459.92900-4-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611100459.92900-1-namjain@linux.microsoft.com> <20250611100459.92900-4-namjain@linux.microsoft.com>
Message-ID: <aEl9kO81-kp0hhw0@google.com>
Subject: Re: [PATCH 3/6] KVM: x86: hyper-v: Fix warnings for missing export.h
 header inclusion
From: Sean Christopherson <seanjc@google.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Konstantin Taranov <kotaranov@microsoft.com>, 
	Leon Romanovsky <leon@kernel.org>, Long Li <longli@microsoft.com>, 
	Shiraz Saleem <shirazsaleem@microsoft.com>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Erni Sri Satya Vennela <ernis@linux.microsoft.com>, 
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 11, 2025, Naman Jain wrote:
> Fix below warning in Hyper-V drivers

KVM is quite obviously not a Hyper-V driver.

> that comes when kernel is compiled with W=1 option. Include export.h in
> driver files to fix it.  * warning: EXPORT_SYMBOL() is used, but #include
> <linux/export.h> is missing

NAK.  I agree with Heiko[*], this is absurd.  And if the W=1 change isn't reverted
for some reason, I'd rather "fix" all of KVM in one shot, not update random files
just because of their name.

Sorry.

[*] https://lore.kernel.org/all/20250611075533.8102A57-hca@linux.ibm.com

> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/kvm/hyperv.c       | 1 +
>  arch/x86/kvm/kvm_onhyperv.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 24f0318c50d7..09f9de4555dd 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -33,6 +33,7 @@
>  #include <linux/sched/cputime.h>
>  #include <linux/spinlock.h>
>  #include <linux/eventfd.h>
> +#include <linux/export.h>
>  
>  #include <asm/apicdef.h>
>  #include <asm/mshyperv.h>
> diff --git a/arch/x86/kvm/kvm_onhyperv.c b/arch/x86/kvm/kvm_onhyperv.c
> index ded0bd688c65..ba45f8364187 100644
> --- a/arch/x86/kvm/kvm_onhyperv.c
> +++ b/arch/x86/kvm/kvm_onhyperv.c
> @@ -5,6 +5,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/kvm_host.h>
> +#include <linux/export.h>
>  #include <asm/mshyperv.h>
>  
>  #include "hyperv.h"
> -- 
> 2.34.1
> 

