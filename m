Return-Path: <linux-hyperv+bounces-2308-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D148FB6D7
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 17:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBEB1F227D9
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F2E1448CB;
	Tue,  4 Jun 2024 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXoiHDmd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD384C91;
	Tue,  4 Jun 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514497; cv=none; b=BYoF5jXCg56RdlMpSgeLPaVzfu1PZ8OFsw7SOOP0ZbZruN7vrxDotA2ANKcWzobDyrPrWR+j762KI7Ft5FIsGvQ9NuRW84TTkIQh3iN4F5dOQ8j9QugSCKSWK3H0hQuI24CR9wex1aDEf7qCoJp9YARuXdeGRq+wY1RN/SNRBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514497; c=relaxed/simple;
	bh=E+b2QUNEozOByn7XosVfo22ORgGbyZc8ikuTipiKM4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiK2uAPSXHrrgdtcZLuMO2xQoAl7DVK9UxLMpVQpVau8LPNd9/cm/jpW2ajwN/mhVw+Kx+oLdinJdwwdYPj5b7P9ylEsL94eCAy1wRnOhGYeVFxw5WUZmtouK1snDwobpH8v2ZvRAi8y3gLSQ/e7d+1UO74QBzjdSlLa+raAZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXoiHDmd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717514496; x=1749050496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E+b2QUNEozOByn7XosVfo22ORgGbyZc8ikuTipiKM4k=;
  b=hXoiHDmdIIDt7oH+vv72yY0weWDB0w54GmappIpLswjEfnjD7TZyX1Gs
   oNBUSVW0bXddTi+A+2i2V0ZP59KCJzeVI0JvCUyqYeSAJIDzMfCXADmMS
   jNTG6y3TOHai1NqBzanwy9F2Xiexvib2Dvjb7blQ8RKRpcgFr62GCS94H
   oWGzg9Mi7J/+qDVDjRIbaSg3V3+sRn8dHTJANim9RWbfaulyybf3CNi2s
   7dnQj39T0IPDfgj6s3i1VJOOMaWU8lu7gxZr3VwWQ5jsjOPoo+gU8snH4
   n7Ik2l9JZSuvWwIJ7QW+7yk21bioYVusfwif8zHc64keDXSAshOZdPivV
   g==;
X-CSE-ConnectionGUID: fPvQ0T/TTJ6zN0YNCYBeKA==
X-CSE-MsgGUID: uSm3LrPUTbGsE+C+2EfbBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13876561"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="13876561"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 08:21:35 -0700
X-CSE-ConnectionGUID: 80QFIjp6QEKsJylgelC6zA==
X-CSE-MsgGUID: hyN/V+NqSJm6vfhx7CCozg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37214950"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 04 Jun 2024 08:21:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A67F32DC; Tue, 04 Jun 2024 18:21:27 +0300 (EEST)
Date: Tue, 4 Jun 2024 18:21:27 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
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
Message-ID: <ehttxqgg7zhbgty5m5uxkduj3xf7soonrzfu4rfw7hccqgdydl@afki66pnree5>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
 <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com>
 <20240604091503.GQZl7bF14qTSAjqUhN@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604091503.GQZl7bF14qTSAjqUhN@fat_crate.local>

On Tue, Jun 04, 2024 at 11:15:03AM +0200, Borislav Petkov wrote:
> On Mon, Jun 03, 2024 at 05:24:00PM -0700, H. Peter Anvin wrote:
> > Trying one more time; sorry (again) if someone receives this in duplicate.
> > 
> > > > > 
> > > > > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > > > > index 56cab1bb25f5..085eef5c3904 100644
> > > > > --- a/arch/x86/kernel/relocate_kernel_64.S
> > > > > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > > > > @@ -148,9 +148,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> > > > >    	 */
> > > > >    	movl	$X86_CR4_PAE, %eax
> > > > >    	testq	$X86_CR4_LA57, %r13
> > > > > -	jz	1f
> > > > > +	jz	.Lno_la57
> > > > >    	orl	$X86_CR4_LA57, %eax
> > > > > -1:
> > > > > +.Lno_la57:
> > > > > +
> > > > >    	movq	%rax, %cr4
> > 
> > If we are cleaning up this code... the above can simply be:
> > 
> > 	andl $(X86_CR4_PAE | X86_CR4_LA54), %r13
> > 	movq %r13, %cr4
> > 
> > %r13 is dead afterwards, and the PAE bit *will* be set in %r13 anyway.
> 
> Yeah, with a proper comment. The testing of bits is not really needed.

I think it is better fit the next patch.

What about this?

From b45fe48092abad2612c2bafbb199e4de80c99545 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 10 Feb 2023 12:53:11 +0300
Subject: [PATCHv11.1 06/19] x86/kexec: Keep CR4.MCE set during kexec for TDX guest

TDX guests run with MCA enabled (CR4.MCE=1b) from the very start. If
that bit is cleared during CR4 register reprogramming during boot or
kexec flows, a #VE exception will be raised which the guest kernel
cannot handle it.

Therefore, make sure the CR4.MCE setting is preserved over kexec too and
avoid raising any #VEs.

The change doesn't affect non-TDX-guest environments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 085eef5c3904..9c2cf70c5f54 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -5,6 +5,8 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/stringify.h>
+#include <asm/alternative.h>
 #include <asm/page_types.h>
 #include <asm/kexec.h>
 #include <asm/processor-flags.h>
@@ -145,14 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Machine check exception on TDX guest, if it was enabled before.
+	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
+	 *
+	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
+	 * PAE is always set in the original CR4.
 	 */
-	movl	$X86_CR4_PAE, %eax
-	testq	$X86_CR4_LA57, %r13
-	jz	.Lno_la57
-	orl	$X86_CR4_LA57, %eax
-.Lno_la57:
-
-	movq	%rax, %cr4
+	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
+	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
+	movq	%r13, %cr4
 
 	jmp 1f
 1:
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

