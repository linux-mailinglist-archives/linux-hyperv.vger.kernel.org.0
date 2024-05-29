Return-Path: <linux-hyperv+bounces-2251-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7668D354C
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 May 2024 13:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853501F25B16
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 May 2024 11:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AB817B41D;
	Wed, 29 May 2024 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0tjEdwL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E8178CCD;
	Wed, 29 May 2024 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981459; cv=none; b=lqRD3CcLwIHBYZ2qXEXwgEPlYjtYn2pFTp2tZuhNxUvkNorL5ZjkoNYnt8sf+2c6lbheZXqj4HLj3BDepzcML9gB67GRMDdjkmjloIlLN4i8q6VWN0nFgr4qEaefpGmO/c1w58w5BMFj7gLtqGeYgJP4f/t/Zon1Nc27k/zumdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981459; c=relaxed/simple;
	bh=3SX+KJOmxPem9SO7R72o7juGuVC2oqAj0VD9rc9VaoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1UlO11JOeNGixnHtQ95/VfNEbhEgv2PoBYKcP24cpLc5lqqfdwCXuthXZ8bUHAI/nxeQQUgNQhUH1EfcVyETda6xXPRnh9Px1C4j8uZjQUZv/8oUqIPmC/oErcfhWXonEkUT0zOJ+lPsFIJKaEqgIux6t+P6yX76c0R9TKFP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0tjEdwL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716981458; x=1748517458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3SX+KJOmxPem9SO7R72o7juGuVC2oqAj0VD9rc9VaoM=;
  b=L0tjEdwL85J8CunwnnYYybj41fFjE6jO0ZXwhBiOU0VCk8fTN29JTl33
   BedTBY+tvMIn5jXhLfgMcl5qaHPr0uE8rxBHyzzdRZOjOsZTY6+xi8lRW
   nHCPGQGmVpFTD3hribqCwKYD29k7HlxAAKdBWKNNvTNdpdntS0veG3UYH
   ngoFJLdNyltrdjRpJgJFNxfby9lRNycEujrddlr33Tr0L67/yqCzHRqlK
   JX9Qx5A2LaCA7EoyuspKKIP/sE1ZAKDJoNLJisgqLdgnMbe5CBDWNSLHI
   DBdmnahfgiBzDZL+AzktUfjkT7F174Or464OurAkVzgeBY31eZWETghb+
   w==;
X-CSE-ConnectionGUID: xscD8hDwQp+G54BBVkc9ag==
X-CSE-MsgGUID: svlC32eMQP6mUZmi3Kswuw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13498238"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13498238"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 04:17:37 -0700
X-CSE-ConnectionGUID: O37lca9aTrCOFhvDkx9QKg==
X-CSE-MsgGUID: ezCnHFvXRqiqHhF2kf5l6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35874174"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 May 2024 04:17:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CA79320F; Wed, 29 May 2024 14:17:29 +0300 (EEST)
Date: Wed, 29 May 2024 14:17:29 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
Message-ID: <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>

On Wed, May 29, 2024 at 01:47:50PM +0300, Nikolay Borisov wrote:
> 
> 
> On 28.05.24 г. 12:55 ч., Kirill A. Shutemov wrote:
> > From: Borislav Petkov <bp@alien8.de>
> > 
> > That identity_mapped() functions was loving that "1" label to the point
> > of completely confusing its readers.
> > 
> > Use named labels in each place for clarity.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   arch/x86/kernel/relocate_kernel_64.S | 13 +++++++------
> >   1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 56cab1bb25f5..085eef5c3904 100644
> > --- a/arch/x86/kernel/relocate_kernel_64.S
> > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > @@ -148,9 +148,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> >   	 */
> >   	movl	$X86_CR4_PAE, %eax
> >   	testq	$X86_CR4_LA57, %r13
> > -	jz	1f
> > +	jz	.Lno_la57
> >   	orl	$X86_CR4_LA57, %eax
> > -1:
> > +.Lno_la57:
> > +
> >   	movq	%rax, %cr4
> >   	jmp 1f
> 
> That jmp 1f becomes redundant now as it simply jumps 1 line below.
> 

Nothing changed wrt this jump. It dates back to initial kexec
implementation.

See 5234f5eb04ab ("[PATCH] kexec: x86_64 kexec implementation").

But I don't see functional need in it.

Anyway, it is outside of the scope of the patch.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

