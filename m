Return-Path: <linux-hyperv+bounces-2281-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A28D841E
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jun 2024 15:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156501C20DB7
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jun 2024 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A8E82893;
	Mon,  3 Jun 2024 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4mVGPXY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF72209B;
	Mon,  3 Jun 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421869; cv=none; b=a/shoZ9w6oX1qnyg+3rNlXbK7u3hau5Axsnz0aWtILludn2CItKXRojAtIwMa98sLuH3yUC61wTqW3USqVG2Kt9ax/w3J4NHHo99luRdOeFhfHph5bQvuQKnn6eAwRE8gMs3xXElu4J+Z1UUw5LI4OZuf42En9NmVTzoU7RQPC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421869; c=relaxed/simple;
	bh=HlV1JYmTkGuDRNbsB9qr/fO7nygHIol5hw422pO5L4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6Ps8OlkxUD/4t5rZJxN4EEYQoCnCq87osM6bH+rpenOI2WAuslElEyq6QljUcteASBv3+m0gHBryUj6SvpJGI2zJVnEXW9N8rvxwLu96aMCo/GlVGR+k9Pbu8Pe5HFlFxSF+ubBy85HSE+lEtSIaJFymjH1LkJAnPKTmz1JTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4mVGPXY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717421868; x=1748957868;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HlV1JYmTkGuDRNbsB9qr/fO7nygHIol5hw422pO5L4M=;
  b=E4mVGPXYtprinpWFDcxUdmsMUESXDQqPRImq2D90CxZF8G4Ri+llMWTN
   D/nZAxPQC+5m/OZtmLFxPg5WliRy9DX0vkkPhdmUBURxhWjUFfGispWkR
   PdzlD5sI8IYgjNW6yczMBl4074o+O8SMLVJQomWCjLmo02S8nCrKj3NcN
   Js5l1zuOlpYeWa2dGLrUgn3wkY1rqLaStlj/rx2mNs0hlcZuDs/cf+O/6
   6x+1zncNLLsP1aNlFxbvwRkxEq10hI0UzFrxndvgkIp0adR83v9bCi2Zu
   CWv5eY2s099YaT+rWISaSEJb2E0Pwpx5ZTseRRga1clFzDgMSFGPF6ATx
   Q==;
X-CSE-ConnectionGUID: 2SONHhRuSL2+jSiL/yO8/g==
X-CSE-MsgGUID: nIst8LprSHixydGorTiRZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25312981"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="25312981"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 06:37:47 -0700
X-CSE-ConnectionGUID: e3PY2hWTRwGwd4Jzk9FnEg==
X-CSE-MsgGUID: eaPVAzSiQQmJ8pD3Nwl74Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="36862228"
Received: from ibganev-desk.amr.corp.intel.com (HELO [10.125.108.143]) ([10.125.108.143])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 06:37:46 -0700
Message-ID: <8992921e-7343-4279-9953-0c042d8baf90@intel.com>
Date: Mon, 3 Jun 2024 06:37:45 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tdx: Enhance code generation for TDCALL and SEAMCALL
 wrappers
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20240602115444.1863364-1-kirill.shutemov@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240602115444.1863364-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/24 04:54, Kirill A. Shutemov wrote:
> Sean observed that the compiler is generating inefficient code to clear
> the tdx_module_args struct for TDCALL and SEAMCALL wrappers. The
> compiler is generating numerous instructions at each call site to clear
> the unused fields of the structure.
> 
> To address this issue, avoid using C99-initializer and instead
> explicitly use string instructions to clear the struct.
> 
> With Clang, this change results in a savings of approximately 3K with my
> configuration:
> 
> add/remove: 0/0 grow/shrink: 0/21 up/down: 0/-3187 (-3187)
> 
> With GCC, the savings are less significant at around 300 bytes:
> 
> add/remove: 0/0 grow/shrink: 3/22 up/down: 17/-313 (-296)
> 
> GCC tends to generate string instructions more frequently to clear the
> struct.

<shrug>

I don't think moving away from perfectly normal C struct initialization
is worth it for 300 bytes of text in couple of slow paths.

If someone out there is using clang, is confident that it is doing the
right thing and not just being silly, _and_ is horribly bothered by its
code generation, then please speak up.

> +static __always_inline void tdx_arg_init(struct tdx_module_args *args)
> +{
> +	asm ("rep stosb"
> +	     : "+D" (args)
> +	     : "c" (sizeof(*args)), "a" (0)
> +	     : "memory");
> +}

The inline assembly also has the side-effect of tripping up the
compiler.  The compiler can't optimize across these at all and it
probably has the effect of bloating the code.

Oh, and if we're going to leave this weirdo initialization idiom for
TDX, it needs to be well commented:

/*
 * Using normal " = {};" to initialize tdx_module_args results in
 * bloated hard-to-read assembly.  Zero it using the most compact way
 * available.
 */

Eh?

