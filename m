Return-Path: <linux-hyperv+bounces-2200-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE58CA012
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 17:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEF92817DF
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ADF5579A;
	Mon, 20 May 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdn13D9X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA829524D4;
	Mon, 20 May 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220201; cv=none; b=H6KHOgM1T2HfzcNC3sYjcLHkw1s+X0CZ5UvowSYz4Ld/bsn0xS7n80dj0jnMzv10PUO/XVQmjl5dnNDuZ8fklauDQYkULCzYWTSf69hCq9hMfBqCezbq2UaOSvfVbKAGL5YNgtPhJHwhBBrCureaS5TU6rVftMxUlESuDf+oulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220201; c=relaxed/simple;
	bh=/Hv/Tvt+mjskzW/v0Nvmm5epDut+0/V3/duT6eFV8Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA7SUXaGrQATITdcNAxWWZgllJT9LPym8HnYRHwGh0ksymEsFm0wRB5l9wNc1/gjQZRYJQYQ9OjGtJy3RoEFN7ODrFrDybesqBI5VNKD29QTYPvmoTWNul++7nblNppiQLEKs7ggK14wP5JkJuYIFvZTI7UW6J/haxeW8Jv5Ktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdn13D9X; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716220200; x=1747756200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Hv/Tvt+mjskzW/v0Nvmm5epDut+0/V3/duT6eFV8Lw=;
  b=fdn13D9X7eD9CrpmfSXcjJWInFHREvhjYuWxEw7diSaXkhF0gHqzuAz+
   pYwdIahyRcu9ujiyOw4qdMs+P+P6fWtrmNUuCcwMYtUXoZggDI5C9MVDk
   pmli1Qj9Xb9j6YMz+ju3e0PJvEnqFYqbSf1ko/00zdIWpG3VQe1nh3iJ2
   0zpo7eJUYsnsMNikZTRIsoq2RcKkTWtThqMfEKzCnwoS8V2N2LRCDLFXX
   qJoS2J+l2Ka84Ipy9oPi73A6l03y8S4OCL/SrlBsz6RIqUhiL4UdbZ9TC
   VzmGuSzO3etKQogVZB20EEj0As1KYkgXsMSa/VcAIaBOmP66Ir6+p3Poc
   Q==;
X-CSE-ConnectionGUID: XyxLenMxSU206ql/CCH31A==
X-CSE-MsgGUID: 4kI5+T3ARBiLkT0CtT5s1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="22933856"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="22933856"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 08:49:59 -0700
X-CSE-ConnectionGUID: UPx/fXBOQJ+mZF/dXMut6g==
X-CSE-MsgGUID: HQ3KmcNWQ/ij/80tHVuXog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="33015046"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.60]) ([10.125.109.60])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 08:49:59 -0700
Message-ID: <c7fac9ea-328e-437f-8fbc-d61f269e4928@intel.com>
Date: Mon, 20 May 2024 08:49:58 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] x86/tdx: Introduce tdvmcall_trampoline()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20240517141938.4177174-1-kirill.shutemov@linux.intel.com>
 <20240517141938.4177174-2-kirill.shutemov@linux.intel.com>
 <395850c4-f8a3-46ed-9b0c-b1f47386610c@intel.com>
 <itsl2xhcrwotxrjpm7msfzc7mp73wk47pnwgyfcvbrioj3p3hn@2e7c4p4gtwh4>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <itsl2xhcrwotxrjpm7msfzc7mp73wk47pnwgyfcvbrioj3p3hn@2e7c4p4gtwh4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/24 03:32, Kirill A. Shutemov wrote:
>> In other words, I think this as the foundational justification for the
>> rest of the series leaves a little to be desired.
> See the patch below. Is it what you had in mind?
> 
> This patch saves ~2K of code, comparing to ~3K for my patchset:
> 
> add/remove: 0/0 grow/shrink: 1/17 up/down: 8/-2266 (-2258)
> 
> But it is considerably simpler.
> 
>  arch/x86/boot/compressed/tdx.c    |  32 ++++----
>  arch/x86/coco/tdx/tdx-shared.c    |   3 +-
>  arch/x86/coco/tdx/tdx.c           | 159 +++++++++++++++++++++-----------------
>  arch/x86/hyperv/ivm.c             |  32 ++++----
>  arch/x86/include/asm/shared/tdx.h |  25 ++++--
>  5 files changed, 142 insertions(+), 109 deletions(-)

The diffstat is a bit misleading because those extra lines really add
very little complexity. The only real risk is that folks end up leaving
the args structure uninitialized, but there are a number of ways to
mitigate that risk.

> +static __always_inline void tdx_arg_init(struct tdx_module_args *args)
> +{
> +	asm ("rep stosb"
> +	     : "+D" (args)
> +	     : "c" (sizeof(*args)), "a" (0)
> +	     : "memory");
> +}

There are a bunch of ways to do this.  This one certainly isn't _bad_,
but I'd be open to doing it other ways if folks have more ideas.

Either way, I very much prefer this approach to adding a bunch more
assembly and making things less self-documenting.  I also suspect you
can get some more text size shrinkage from selectively uninlining a few
things.

