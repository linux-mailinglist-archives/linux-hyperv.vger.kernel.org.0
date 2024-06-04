Return-Path: <linux-hyperv+bounces-2305-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C44A88FAE83
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 11:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E131F2503D
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 09:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE1514374E;
	Tue,  4 Jun 2024 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iSXAQOJn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111514372F;
	Tue,  4 Jun 2024 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492555; cv=none; b=tdYdlxQT2Wi3cxm78CNiiNrfmElY6rDzz5mxLnMgc3c+rKMhHFCY5QyNjqq7V/NNCN60gJhM5bH5LIw4RgM4nLZMYODMhrgYZohkAyxVnL/vrMuq1Cv4Lg3J9VY7fPy4tyooCCyBkJZFfVESDXmpKKAHMPFXSB/aXCWRWTLtqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492555; c=relaxed/simple;
	bh=Z6h+FaQ2mydG81kK5UyAdLTDhUweVtTAlyL20v2DzGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwy+zrChoDHFaoCzRs9GAJgD/hyJjRdzPx3me0JGoeGn0N0oUHVQ4veFv640V3VaRFrUXg3YJpM74DODZ1rvWwzsdifp8xgbrwOacFA0nTN4OsBcAXHg+0Je7lIiQ8KQuv4vYESGuxgtaBsgKCcoLbUHnQb/llKmCkSmYBf2z5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iSXAQOJn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A3B6840E0176;
	Tue,  4 Jun 2024 09:15:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ulBYaKGPw-vH; Tue,  4 Jun 2024 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717492540; bh=m7NFIk8+6rvmt15s5vCen1cbEwqjokjsUgs57ILsKtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSXAQOJn+SPDaD84vEh7wouOYiZfNCaoiWTp8IPjbiadFjeUbQ8PgOq9mgi7jWbuB
	 Rm3LQjYTbnpdicihxVy1yB07uSul8gr+Z1gaL7WeDAiwfwqkFMzX+2TGECuiXmhDA4
	 iSlqfTMjYs9AfTUpI055P9dnTsOjXQmdcnM5TeuC0Mbgo5lc56brjSNqBpHib4ypnO
	 gCmeqhMFDjnpAFTpEriJjZiYIQSt6rWHxHZP91+aq119WX55MnsAV/sDeoUt4lWHJ8
	 KFxtXI6OcP1YDtpUUwXpwY9rTFm6SOFEm9YUAQrKWrjC0TErYpKinePUPvrMt/AjaG
	 nhHNfSE9qW+YOI94ONFGWjwJqvQV3wtQUoBLS6TWKQFxhe4OUMqebRCfFLLNCYXcEV
	 U4g3HjizjUXvjeZLEQ55FODZEJkRqyH/e8O+n0MpgewAno8Fovq7xeyInc2IQS3L8A
	 k96/PUr5SRZjrEXHGz3hIay6/6WYwAPA5Ut5ILbQCy33psGebm4rsFuXUK5NG3Odlh
	 wWFWvJWDPZXAr+gwwH0jpG8nriHspHEfS6rXaK8FHG5wDXAo0FmyJUSTTPB6KHfG3Q
	 WhBJ+sqT/SIm6U9Ic2kvopPHvEQpFhwhmfiB1F3kgoVGjpbH+8W7qL4xFSLk/KWhG2
	 UKgi1KIS3RI6wwRh5/Bu5Muw=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A28D540E016C;
	Tue,  4 Jun 2024 09:15:12 +0000 (UTC)
Date: Tue, 4 Jun 2024 11:15:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
Message-ID: <20240604091503.GQZl7bF14qTSAjqUhN@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
 <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com>

On Mon, Jun 03, 2024 at 05:24:00PM -0700, H. Peter Anvin wrote:
> Trying one more time; sorry (again) if someone receives this in duplicate.
> 
> > > > 
> > > > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > > > index 56cab1bb25f5..085eef5c3904 100644
> > > > --- a/arch/x86/kernel/relocate_kernel_64.S
> > > > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > > > @@ -148,9 +148,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> > > >    	 */
> > > >    	movl	$X86_CR4_PAE, %eax
> > > >    	testq	$X86_CR4_LA57, %r13
> > > > -	jz	1f
> > > > +	jz	.Lno_la57
> > > >    	orl	$X86_CR4_LA57, %eax
> > > > -1:
> > > > +.Lno_la57:
> > > > +
> > > >    	movq	%rax, %cr4
> 
> If we are cleaning up this code... the above can simply be:
> 
> 	andl $(X86_CR4_PAE | X86_CR4_LA54), %r13
> 	movq %r13, %cr4
> 
> %r13 is dead afterwards, and the PAE bit *will* be set in %r13 anyway.

Yeah, with a proper comment. The testing of bits is not really needed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

