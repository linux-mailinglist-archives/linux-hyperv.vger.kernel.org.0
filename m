Return-Path: <linux-hyperv+bounces-2307-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC08FB135
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 13:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A65F283916
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 11:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0978C14535B;
	Tue,  4 Jun 2024 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfHqDHji"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C04E38B;
	Tue,  4 Jun 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501059; cv=none; b=hjGZravtFPYqUijdEhdyXJvb1boxvoSebm9fO/6mKk42OeMqQ6oc0nuukJFXHJxyes9OBjOsXIk1VU7c782DhEIh0LdMOikcJ+YMrATc8iaSBdi8oWuLtR1OxlCRrDrqz+0NXrwWp58W7WTUfZw2wkKpaJwkIpTBnCYQYVXvuuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501059; c=relaxed/simple;
	bh=+79NxtRrC/0Jr576Mg64H7DNWoxUsEFj3cHOtoY3sP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssOmuL6KQk5Pwicyykzr2AFzTQScbMeLW1gSs0VLZS4IrBKOCDMo90osCiHxgu4SxFwTsCzQYWPj389MTuMyV3cenm3PX28HKnKZAwoKnYgqOeWeNfnb819Sx0+1Q6nekwYu2jU+R7aEiq+upO3nMXnsSrtnkm/Wu4RJP5SmF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfHqDHji; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717501058; x=1749037058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+79NxtRrC/0Jr576Mg64H7DNWoxUsEFj3cHOtoY3sP4=;
  b=SfHqDHjioWGJcwDHN84TD3nB1wCJHxWWgmkQvNkmvToAgrtbrg6lUWlE
   +JsbSKkuYDQvyIawHEARRJeJ/1E46+4UXBxYLPTZpdv5nX+D4Az0YlyI5
   r+tIPZW/VrWsd8xRlecnoldRUSu799n0l4G7RixT9C7y2bL3eRj33nZ+j
   IP7o9XB5JoCcy4C7C7immyuAUnnTMphk4H+f5d5Y6Bw0D+aF9Lh5fO1fq
   CjTQS1xyrAlrrY6X43CatM/XbB/SviGOkKmNPxXHCv1CT6qJ5BzfbkUQx
   nmHJVfNCH94yn0UC/LLO9KXsYVQCjorYjHP5si1WB+RCCm3EyWAgyFUMQ
   g==;
X-CSE-ConnectionGUID: Ob9yP0NSQr+DPZGReDFXGw==
X-CSE-MsgGUID: 0HldjUCDSiiBmeSlaD1EVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24667692"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="24667692"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 04:37:38 -0700
X-CSE-ConnectionGUID: OJHjun/qStSoESeRMY/MDQ==
X-CSE-MsgGUID: Gj42TwrPR1a0+hwsHQ0ldw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37334051"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jun 2024 04:37:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E3848268; Tue, 04 Jun 2024 14:37:32 +0300 (EEST)
Date: Tue, 4 Jun 2024 14:37:32 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Enhance code generation for TDCALL and SEAMCALL
 wrappers
Message-ID: <crv2ak76xudopm7xnbg6zp2ntw4t2gni3vlowm7otl7xyu72oz@rt2ncbmodsth>
References: <20240602115444.1863364-1-kirill.shutemov@linux.intel.com>
 <8992921e-7343-4279-9953-0c042d8baf90@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8992921e-7343-4279-9953-0c042d8baf90@intel.com>

On Mon, Jun 03, 2024 at 06:37:45AM -0700, Dave Hansen wrote:
> On 6/2/24 04:54, Kirill A. Shutemov wrote:
> > Sean observed that the compiler is generating inefficient code to clear
> > the tdx_module_args struct for TDCALL and SEAMCALL wrappers. The
> > compiler is generating numerous instructions at each call site to clear
> > the unused fields of the structure.
> > 
> > To address this issue, avoid using C99-initializer and instead
> > explicitly use string instructions to clear the struct.
> > 
> > With Clang, this change results in a savings of approximately 3K with my
> > configuration:
> > 
> > add/remove: 0/0 grow/shrink: 0/21 up/down: 0/-3187 (-3187)
> > 
> > With GCC, the savings are less significant at around 300 bytes:
> > 
> > add/remove: 0/0 grow/shrink: 3/22 up/down: 17/-313 (-296)
> > 
> > GCC tends to generate string instructions more frequently to clear the
> > struct.
> 
> <shrug>
> 
> I don't think moving away from perfectly normal C struct initialization
> is worth it for 300 bytes of text in couple of slow paths.
> 
> If someone out there is using clang, is confident that it is doing the
> right thing and not just being silly, _and_ is horribly bothered by its
> code generation, then please speak up.

Conceptually, I like my previous attempt more. But it is much more
intrusive and I am not sure it is worth the risk.

This patch feels like hack around compiler.

Sean, do you have any comments?

> > +static __always_inline void tdx_arg_init(struct tdx_module_args *args)
> > +{
> > +	asm ("rep stosb"
> > +	     : "+D" (args)
> > +	     : "c" (sizeof(*args)), "a" (0)
> > +	     : "memory");
> > +}
> 
> The inline assembly also has the side-effect of tripping up the
> compiler.  The compiler can't optimize across these at all and it
> probably has the effect of bloating the code.

It can, but it is limited. Compiler has to flush registers content back to
memory before asm() and cannot assume anything that read from memory
before the asm() is still valid after.
 
> Oh, and if we're going to leave this weirdo initialization idiom for
> TDX, it needs to be well commented:
> 
> /*
>  * Using normal " = {};" to initialize tdx_module_args results in
>  * bloated hard-to-read assembly.  Zero it using the most compact way
>  * available.
>  */
> 
> Eh?

Okay.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

