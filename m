Return-Path: <linux-hyperv+bounces-2399-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A42B904F4C
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F390B21CF8
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461EE16DEB2;
	Wed, 12 Jun 2024 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qsc+AJ2q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A26016D339;
	Wed, 12 Jun 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184625; cv=none; b=LbN6dpEabf2gawCysIl3c5BH/7h7iiT5Kn55QgkR+ld2lCSJCSgHXuBKm/Y3Z4B/rAb/Rm7hpyipFckU9AvFoPvySRAhvYGeuVJ9DLHqlGm4EW9MzA5CYQKSBYPslwiS7YAai1lv1dvH3jVonuUm3EhGJxrEKN2bVbWIBwSSWWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184625; c=relaxed/simple;
	bh=J/44THBA/dPfsljbhs1f2PJSH+f7JSY48xLWZSBEbX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RenNrPG5QkoxXh0Ds7B9awuxEMpNQblOnOOfwzrRCY8TNRpXBcqDB/8SGZMD3e/StuMOtvPJFsa4KQ8epXGit2rLKPtL6OiXWwA6PkuPp+q9B/24Awyb6zLnQzpDx+fnfkRhwqLRxfadwx/1gNWdnWxfpWkc6ssEGfSMYYTQnaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Qsc+AJ2q; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E7E8D40E0176;
	Wed, 12 Jun 2024 09:30:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4kBlhHtppWTH; Wed, 12 Jun 2024 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718184617; bh=bAaBH5qaA/JFcGMfRi72p+tRzwYREYvEMYDRH3DvGZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qsc+AJ2qmMEYH1GmdJ83828PmwbIvMP3sUK4daOukV73GEF20NSxER0+reGrO19uM
	 enPkC9nyrprHCoS67qACrJZ6AC236TaKczMgkdfP9ndjVzVMRLBuqJpPl/zUbgIL4F
	 j7TPT3ohwQ7tErya9eEnipyOdJEg0ctVbZWs+4m632GkVdYeVdekf/qkXvTScifNaY
	 dX27wFRjeZKQ43p1zAbp64UfA4b/jwZsIqc6R9v1ljrqd/5holDsEmLEsEvM03Iv8d
	 70HThSZKGtLrQyaaGH7jj9EK0D4oghYcQSt0vGljohHLJyQ+SAjaV97ukJbGIET8/X
	 Jo9m12QCRFBdDMUXlImk41mbjLSd38G5IY8tlP1WLH3qu2eiguVk57A+GFIFhSGLG1
	 sJXAeb5KSTM5QCxuKRIKgn7CeddxcPEVgnn0uCEMTRhmfjUyh99Y1TJ+AdytrJJXbg
	 g7gH6jyMdp7VFB6YFc70bdkKU41w2xcKniRlcbgYbPtyvGM3H04nCbHyo7QNv/xpw7
	 7XoPxWQnXjNhbBxnnlYyg41SnrbZyzZMjarQGWA0IIHJhMtKjxfJfHPlUZZWWHTevP
	 3M+3mbFDLsLdTSSTsgPEc2QHFfqberzfPrWjfguIc/dgowqsvgMAtAh8XTehTAIo/L
	 NqKts/+d049xpp32sa3U8rLY=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BBEAB40E0081;
	Wed, 12 Jun 2024 09:29:49 +0000 (UTC)
Date: Wed, 12 Jun 2024 11:29:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 18/19] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
Message-ID: <20240612092943.GCZmlqh7O662JB-yGu@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
 <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
 <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
 <20240611194653.GGZmiprSNzK0JSJL17@fat_crate.local>
 <2kc27uzrsvpevtvos2harqj3bgfkizi5dhhxkigswlylpnogr5@lk6fi2okv53i>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2kc27uzrsvpevtvos2harqj3bgfkizi5dhhxkigswlylpnogr5@lk6fi2okv53i>

On Wed, Jun 12, 2024 at 12:24:30PM +0300, Kirill A. Shutemov wrote:
> I will try to deliver it in timely manner.

:-P

> > Yeah, we have a bunch of different pagetable manipulating things, all
> > with their peculiarities and unifying them and having a good set of APIs
> > which everything else uses, is always a good thing.
> 
> Will give it a try.
> 
> > And since we're talking cleanups, there's another thing I've been
> > looking at critically: CONFIG_X86_5LEVEL. Maybe it is time to get rid of
> > it and make the 5level stuff unconditional. And get rid of a bunch of
> > code since both vendors support 5level now...
> 
> Can do.

Much appreciated, thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

