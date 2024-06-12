Return-Path: <linux-hyperv+bounces-2397-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B6904F1B
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 11:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6521C21982
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7B016D9D2;
	Wed, 12 Jun 2024 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvC5e96l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED0416D4EF;
	Wed, 12 Jun 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184156; cv=none; b=Jb4fLLEcVkNXegebsC2fh7sam2k4qpICFoAgTMhBDiMNv60IvvlO7nw3bxPgu8pKCUtxio/f9mTI3QQxH9LKEuJyAYRw+pCbku/D16ynK01kkX3yOgUas2j4qC4kIK0v4IEu0XqN/ejGRnSA7vF6omXo637Gb2Kwg/y8NClBQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184156; c=relaxed/simple;
	bh=7QifDfrNsx1fq4Zn54nkhEExNwXSNVLR0i6Op1TRZJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tptqZyocjljSFPOmZKPC6G2CjnTJBng4WAf9CY2NBzTLEcj1l8bMlXKGaF3Ld9EKGgCB33ZuUlVU0UVs8LERwQFdBYSGvgOHYNxfUAV8sDGLDIvc+JPXKZONOxauxMyE9uOiKntLO+RGMgYdtUSnByIIGDQ9VqV43cB84PFgI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvC5e96l; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718184155; x=1749720155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7QifDfrNsx1fq4Zn54nkhEExNwXSNVLR0i6Op1TRZJI=;
  b=kvC5e96lZeYTPVgV3qvBaeV7Mt9Wh+eOaQp1H+xFUUuvx8nBg+C3/fAD
   F+9TA8Xa+hZo4QKzr1OpeXseiE+kIHAPtU5WXxqMQzpkyuPZA97C/gyN4
   7Cb88KddkOzZp9TJwL9V/eDzO3TuU3lRLZTMZG4RwuBRG4z1FqNilfmAT
   S+zrVUPwV50zW4SsILwMuKKHBCe2xhK+k7VJmOIdGj2xIFtsLpAgsfJO9
   uUak//4s4e+2M4xjOWC7VdJZiW1ScvV0QhnvgKmDNf5H1ydtDsORhDvN7
   CYQDtDNA48Y+mG71viP1UsJi/69dBf/qgSds/uDp5v9RAbKaPSnISWFAW
   Q==;
X-CSE-ConnectionGUID: QKvvp6miSzuRFAJPOLZ98Q==
X-CSE-MsgGUID: GHfnlU84Q/KxfIMcCkP4dg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14810225"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="14810225"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 02:22:34 -0700
X-CSE-ConnectionGUID: l+tjhQPjQImOMdvNQ7mk4A==
X-CSE-MsgGUID: Isa6/PTmSJC0RRJHVa41FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="70530128"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 12 Jun 2024 02:22:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 07C52193; Wed, 12 Jun 2024 12:22:26 +0300 (EEST)
Date: Wed, 12 Jun 2024 12:22:26 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Borislav Petkov <bp@alien8.de>, Nikolay Borisov <nik.borisov@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
Message-ID: <nxllu5wfhvfvorxbbt6ll3lc2mr47lw7sduszfawhtryqgtyrd@3qgtci7ocah6>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
 <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com>
 <20240604091503.GQZl7bF14qTSAjqUhN@fat_crate.local>
 <ehttxqgg7zhbgty5m5uxkduj3xf7soonrzfu4rfw7hccqgdydl@afki66pnree5>
 <5c8b3ee9-64c2-4ff3-9cca-ba2672b9635e@zytor.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c8b3ee9-64c2-4ff3-9cca-ba2672b9635e@zytor.com>

On Tue, Jun 11, 2024 at 11:26:17AM -0700, H. Peter Anvin wrote:
> On 6/4/24 08:21, Kirill A. Shutemov wrote:
> > 
> >  From b45fe48092abad2612c2bafbb199e4de80c99545 Mon Sep 17 00:00:00 2001
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Date: Fri, 10 Feb 2023 12:53:11 +0300
> > Subject: [PATCHv11.1 06/19] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
> > 
> > TDX guests run with MCA enabled (CR4.MCE=1b) from the very start. If
> > that bit is cleared during CR4 register reprogramming during boot or
> > kexec flows, a #VE exception will be raised which the guest kernel
> > cannot handle it.
> > 
> > Therefore, make sure the CR4.MCE setting is preserved over kexec too and
> > avoid raising any #VEs.
> > 
> > The change doesn't affect non-TDX-guest environments.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   arch/x86/kernel/relocate_kernel_64.S | 17 ++++++++++-------
> >   1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 085eef5c3904..9c2cf70c5f54 100644
> > --- a/arch/x86/kernel/relocate_kernel_64.S
> > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > @@ -5,6 +5,8 @@
> >    */
> >   #include <linux/linkage.h>
> > +#include <linux/stringify.h>
> > +#include <asm/alternative.h>
> >   #include <asm/page_types.h>
> >   #include <asm/kexec.h>
> >   #include <asm/processor-flags.h>
> > @@ -145,14 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> >   	 * Set cr4 to a known state:
> >   	 *  - physical address extension enabled
> >   	 *  - 5-level paging, if it was enabled before
> > +	 *  - Machine check exception on TDX guest, if it was enabled before.
> > +	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
> > +	 *
> > +	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
> > +	 * PAE is always set in the original CR4.
> >   	 */
> > -	movl	$X86_CR4_PAE, %eax
> > -	testq	$X86_CR4_LA57, %r13
> > -	jz	.Lno_la57
> > -	orl	$X86_CR4_LA57, %eax
> > -.Lno_la57:
> > -
> > -	movq	%rax, %cr4
> > +	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
> > +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
> > +	movq	%r13, %cr4
> 
> If this is the case, I don't really see a reason to clear MCE per se as I'm
> guessing a machine check here will be fatal anyway? It just changes the
> method of death.

Andrew had a strong opinion on method of death here.

https://lore.kernel.org/all/1144340e-dd95-ee3b-dabb-579f9a65b3c7@citrix.com

> Also, is there a reason to save %cr4, run code, and *then* clear the
> relevant bits? Wouldn't it be better to sanitize %cr4 as soon as possible?

You mean set new CR4 directly in relocate_kernel() before switching CR3?
I guess it is possible.

But I can say I see huge benefit of changing it. Such change would have
own risks.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

