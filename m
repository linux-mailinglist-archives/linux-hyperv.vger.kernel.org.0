Return-Path: <linux-hyperv+bounces-2394-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F6C904525
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 21:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72120286207
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 19:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB1813D8BA;
	Tue, 11 Jun 2024 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gZjVbghD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277231CD06;
	Tue, 11 Jun 2024 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135257; cv=none; b=JZwqhk6xF5jYRSAirPh+YCct3am4C/U4RE4VBc+GPipBCczxAw8thA4VDPhRwQRATQpY05Kz2tU8FKtARFG+wUwTWn9Qr8apYYNFl84uy8UBGOBHfgfmblmXkbgJgjcbGL417kyJec7nzmSDoVbFTVkHASd0C8LgKMYeo+XCYjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135257; c=relaxed/simple;
	bh=P8tRXS5Qm+J/JCdOjw/TVF0tn8jwvJSRwemvRKueNxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpXuh+wBUyxgRNhr5hHmAKiVcomfTVqrrRp7cpJhq7zvqhtLy2TW3+SGnGzfQFakPWIuR/QipPeBVTEPpheVq35LrCwwAiy4lGvnt9Gs4YB1Wm0I32DPrZj4qM7ogpYV9CfmQyN/bg/Pu61yD3jx2DdD08C227UZWFMtPPS09h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gZjVbghD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4ABFD40E016E;
	Tue, 11 Jun 2024 19:47:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7egZOOhYrnUo; Tue, 11 Jun 2024 19:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718135247; bh=KC/Wq1TdqELiVMasu/6IhWJ5RKEy2WZabJ1TgN7EDpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZjVbghDzG0nP5cUPybv4xjwXUw/XCKD2xi82Zv94c+xqXlSD2qHLWA4ec+ncBc9A
	 /a1LbzPD4bLO4EEN+CZY0NKOfHQcj1PykJZpMpMtxZEEOLM67AkxoxXoXosQ9lZlna
	 n7Nmi4ZPJGPeJs8K8LXnGz5e87NPVyAFi/gcG6STb1244NJSEKC7RqhedZN5nkS4Sy
	 /1yrO2GhIB+OjkfoTp0Jr+TB0qblLFXFBW+G8xnDCwMwPS1xtl4ZfIDiYfbfIwPCwq
	 HGCaTWzWkwQL2y7YyBWx6sM+HiiMq5xtYbL9BaOrv73UP3014pZLRW9Clf13aqUkNB
	 C8aX9ijV3RVLiLTdDlnp8Oapk+TFfOVcFewxvRyJpkpM4wmlMsWUwp+lZWPuLot5hm
	 2ttdOPqCnCNqZG+Z7gmSdGZA3LZ1VtpyumKmA3/zTqSpse2Sy4OWv96IySCJ7gCP0A
	 0ytFhs8/2PQce2RpYFem1c7BlZIAzvMeTr5lDdAusNnYS2qDbwouFUUyVLcfOFdQk4
	 XTgYvmOwdub7dCaPBGoiIrg294eaJ5nrLZ0/bKBf0m69dTyc0zoDe5URK34OLqCh58
	 5gpieItixDx5YAcr6EowJ4PnUifObwQoY8BAFo4X0/JYOs7rG3nPSPUm7XE4dYkEAv
	 zipMkDI2v+o+y2TApZy/pnJg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5670640E0031;
	Tue, 11 Jun 2024 19:47:00 +0000 (UTC)
Date: Tue, 11 Jun 2024 21:46:53 +0200
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
Message-ID: <20240611194653.GGZmiprSNzK0JSJL17@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
 <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
 <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>

On Tue, Jun 11, 2024 at 06:47:05PM +0300, Kirill A. Shutemov wrote:
> Borislav, given this code deduplication effort is not trivial, maybe we
> can do it as a separate patchset on top of this one?

Sure, as long as it gets done and doesn't get delayed indefinitely by
new and more important features enablement.

Usually, we do unifications and cleanups first - then new features but
this kexec pile has been long in the making already...

> I also wounder if it makes sense to combine ident_map.c and
> set_memory.c.  There's some overlap between the two.

Yeah, we have a bunch of different pagetable manipulating things, all
with their peculiarities and unifying them and having a good set of APIs
which everything else uses, is always a good thing.

And since we're talking cleanups, there's another thing I've been
looking at critically: CONFIG_X86_5LEVEL. Maybe it is time to get rid of
it and make the 5level stuff unconditional. And get rid of a bunch of
code since both vendors support 5level now...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

