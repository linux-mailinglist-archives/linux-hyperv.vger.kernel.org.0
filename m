Return-Path: <linux-hyperv+bounces-2252-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 462358D358F
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 May 2024 13:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502DC1C22D33
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 May 2024 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E2E17B51C;
	Wed, 29 May 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cV5HUW53"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD1D17B42C;
	Wed, 29 May 2024 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716982174; cv=none; b=nZTYFHiOXh9hGM5/D4aTesvJpVDTqfnPvzga65HwGQNJReSs4dY6ILYXcDRxz9+PWi5/GEGo78xkVlB8ZcOQroSkHN0/emIPAH8nu6cXSbpZDU/HhwcsT+I4GDNlO3J+FOCHBy2K9zSzFMr0HNqoWrgJwiE4/Rme+TEpsZ+C4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716982174; c=relaxed/simple;
	bh=0kq3HVd0cRMqqq1TTQn0AHc8TM2K+7ozCdN3/9vOqeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAXQRrHD4GWUzWI5ZQHNMVvkU6/d4FoKhZqgqmzEqkZiP1nE7s09IBwYWrEn24IQp6BGVQfHKNu05B2clBML7N4QB/bAnsTP4Tz9eia3YjUK15LZBxclN4N8Ow3a4lpx/uc25EP4stuwrUpgWbVCGVCtfnX7wHlsvEMv1fZvau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cV5HUW53; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A795340E0241;
	Wed, 29 May 2024 11:29:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HmlNtBqr6uY6; Wed, 29 May 2024 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716982166; bh=7UQS7j6CCagVlyJn9Hmk6NwjSsENYGcwi4W7WCTkCBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cV5HUW531EDiz7oQ1FPuK0S/IzSZHeNkt/G9fyB4FwCoZzYhfNZGhG8APJHIv24qe
	 khz2nZDAkKxcjTfGkC9eVb5l4e070mmcM22lEeNo7kJxFVMeVktFnYLB/sTT7bEKZr
	 q2x4F4zVZ9l3wiNP0kaQzjBUHkhjdGxAl8BoERiiCG531K7Q3fspKbKSIR1OAZj4C7
	 VVc4Z7UATXIiJIZALj0I8+GIhy8DGf41W8PBJxQ295Tp618s3W5SdLtIxZPnirCkEY
	 X15kJQhqPzu+Oljl64c5vWHy+kSDPjCJ4f3tj2T8aQFtTBjaP1jzTuvtgaqcFlkImj
	 XqyO8dd9b1Tgg+XRWOvwmMiYTtsXg7QT4LQbXtk87ezRnBluiKD/0Y/lszFMz9lwBx
	 7NaGgzNgdtn1Tv+ksOwVGH6MzqT8+5H0T+wgZSOTU9CIvU78lIZClz9E3DGTIvty2A
	 GxRLH6houMcYoLFSa2lz6QKo8hRp7baOF+5IAt2cC/T9xlZoI+JTPC91J8aH/j0nLD
	 tCCvir3LafEQ0VmdfZzm1Fxz/GR2QyfkOvKjDxRgeu3ZahfpZaUVY4XFuohZTBjBNA
	 3MOy7IP2ggy/U48zEeNtCyRM+Xu9mV016oVlCwGq+tUc/+jIERc09SGV6E+/kfYwUu
	 Z26oM8yau0Hi7dXabPoG5JJo=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18D4340E0177;
	Wed, 29 May 2024 11:28:58 +0000 (UTC)
Date: Wed, 29 May 2024 13:28:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
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
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
Message-ID: <20240529112852.GBZlcRdI3oqBtjKxAV@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>

On Wed, May 29, 2024 at 02:17:29PM +0300, Kirill A. Shutemov wrote:
> > That jmp 1f becomes redundant now as it simply jumps 1 line below.
> > 
> 
> Nothing changed wrt this jump. It dates back to initial kexec
> implementation.
> 
> See 5234f5eb04ab ("[PATCH] kexec: x86_64 kexec implementation").
> 
> But I don't see functional need in it.
> 
> Anyway, it is outside of the scope of the patch.

Yap, Kirill did what Nikolay should've done - git archeology. Please
don't forget to do that next time.

And back in the day they didn't comment non-obvious things because
commenting is for losers. :-\

So that unconditional forward jump either flushes branch prediction on
some old uarch or something else weird, uarch-special.

I doubt we can remove it just like that.

Lemme add Andy - he should know.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

