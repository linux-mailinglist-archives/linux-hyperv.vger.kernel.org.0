Return-Path: <linux-hyperv+bounces-2316-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003B8FBB10
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 19:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B752289500
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660BD14A4FC;
	Tue,  4 Jun 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gWdLoPL0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD884A33;
	Tue,  4 Jun 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523878; cv=none; b=lkKVV48JZ+aXeOSzg0oomL2PLCEhM3NFuOlkIYRGlr1ubfLGs9W8Bl8FukiTApYLRoPX65C4C2VWbk7Cicgtx6HwLzmnwnnTk3UUTJyaePb0phiR851/XvYpX1bzjxFztDY2f4F/6CMpzLnURVr4usxITGuMjCZ8JnPeJNwPyjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523878; c=relaxed/simple;
	bh=E+MtxwwhVqCdGJffmyAZCA/EMI2HiYm5YWLiS0Lw7ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXlNHmM20utVuBi61Il763NeJj3JRq0gn0r6QMs72WbKJSeg7mZF6vtKPjAbO2IdDUZKTjMzLeej6ZKx3f0UCrltf+4cExNC0EXY6x8aOXGo35dHHEfjUpaNavPDhqwinOSLIgBlrAb46SI8vGnu7XGHRIH+ECtFeHFToWemiCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gWdLoPL0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 412E240E016E;
	Tue,  4 Jun 2024 17:57:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GcSvWKOLzVkh; Tue,  4 Jun 2024 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717523869; bh=JXZbniqiYmCh6nO8eOuM412v/bVplPF4NQw9IrGcNgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWdLoPL0Geu18Mg09ep22E8CJvmQKeIXM/qeFRd35Ee5DINk9hJ1k1uSdd+ZOYIVO
	 577lBvho2BI8wZgUCZ7BotNPN9ZSqJNOtt11EkNZ2loxtHuj8mbIkJFcl2qWeXJ0CG
	 uyQUAYVCQZTEUTmNrujRy260AyawFlCuPwcjaYet1+adCC00xHv70iET5PgQlYWJDf
	 DL16UmrcR6KGpH7E2N7lvUaxNbpIBQo3jNTJut7Xax9DEXl6iROBaVoTFWeI6C4y++
	 tiZAsXGByTnT2xL5rqqPNd/kvJ58OHLWgFy8HscK8we8+E1mhPhCwHInvpmyzzRJS2
	 Wz/ZBqVfp8zpns6YR83BDw1nG2AHceAXRgUqbdABY32fFb6BCBJGaFYaLz269a/j5B
	 DlKjsKQYNMarJVeLOYyqJLwyBBA17yNQadN9DTU+bf2J2IlDy6XkiNjl8MlbxR6lct
	 qNEHwEcdgyNtRx02O6juN14djEeE3l5mB6c873EcMJ66gTKaXCJVpeSkPe6IAK807h
	 N4tX9FAxP6X6ty3nug+8TCqm9+CkycFBJM7wdSfahJXtGG66JqySNhiMdBDpVeJME0
	 ZMChUXpW3VpwL9K5Y3GjTNasyDugQa60YGhSG0iEFji/ORi5QW3VcERJ8YpRHWCdSn
	 g9SttyT/p/diiD2uywWfVs64=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09B9640E0081;
	Tue,  4 Jun 2024 17:57:22 +0000 (UTC)
Date: Tue, 4 Jun 2024 19:57:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
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
Message-ID: <20240604175716.GGZl9VfDwv_JhmzwPH@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
 <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com>
 <20240604091503.GQZl7bF14qTSAjqUhN@fat_crate.local>
 <ehttxqgg7zhbgty5m5uxkduj3xf7soonrzfu4rfw7hccqgdydl@afki66pnree5>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ehttxqgg7zhbgty5m5uxkduj3xf7soonrzfu4rfw7hccqgdydl@afki66pnree5>

On Tue, Jun 04, 2024 at 06:21:27PM +0300, Kirill A. Shutemov wrote:
> What about this?

Yeah, LGTM.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

