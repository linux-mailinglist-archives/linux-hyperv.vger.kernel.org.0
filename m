Return-Path: <linux-hyperv+bounces-2246-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A40208D1D5B
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 15:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60B11C22181
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 13:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4A616C879;
	Tue, 28 May 2024 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UHVe+VJL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E2131E3C;
	Tue, 28 May 2024 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904101; cv=none; b=qH2m6rmoNgNJrhacGbH1haptkTA6sHEcOpBXtnkiKc/Z4nGX2QheQwfB8ciyOZk1AD+4oNzA7ymgfnwyzY78WPHHt5geCFhSiKxQD84DOEShtuYaS5GN4jJPn+AMX2yeOOcZcVT58ZgTDY38CPXnQ4XbWET3Cn4FbXO93lhwQtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904101; c=relaxed/simple;
	bh=9aFLJYx1hIAqcxpFsUeOvsy64ziF3w0rQBQVlCme1Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3vOtPbV+rSNjmQ7n76IDhFOZWWm9Ahs2YJx+p8C3XXsvoo1OqYa2c7/sQQ0ujKVAAXcPkJWZFfkdLhmk5kIxI9W1VMNDx0xX5KhZfU5nszhHKB2dTNVwMTfTrOCG7EJaVV7yrnRRKuMWnX7nE5MhjSTB0qVOLX1DO8gB+X71xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UHVe+VJL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7FD7E40E01E8;
	Tue, 28 May 2024 13:48:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CWC8d6f-MDCs; Tue, 28 May 2024 13:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716904086; bh=Guy/h4AS3sgPsJ1ZoSa+dXWo2WOj/mHMhGiRjv7+LKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHVe+VJLKxqmmtkpxms4dUr0g/20OaUMpQ+JRwZRuN1GSfREbHsKJk+wWNo3sBASH
	 vViwlJqr0X3E50WR/RV2rb9br0vG7P4HHCH+X992vEcu8o8VsXdOmeuyfkfzoRk5Id
	 mgzRod/x6CXL2OrgSEKzUVLq8Uu+vHMoXNjAgq196nD2B3h+A/Tw27OwxJebUsH6uE
	 ijScMkhRN+y/S96jP/wtRYQSKM/SYysV+8dzCx6FOYVYob4GUH/b9wd0fB5Hg5CtQ6
	 IKtuoxENR6sgoU7MP53+xCfRN09gw1R31Hzmebne7xKPw0EUGPFOJZrOO1HX1X6Tq6
	 Bqct9q38hnC59egLzl+drAo7XKWQqQTUBT5/DjFEO036M7T0dZKdEadmeKJPsX6qXo
	 39ffhazzPIfSkpdril9twBshfoyvbb1EPnKelclQpzgWk0dl27wyKIn76sUM1R95Xq
	 ss4FKsfTLH7ncDroEpTC6jg8+W17ilVa/IviXbOgLEZTADalBxOE/TQEoEEy/LWHI3
	 lIlJ10Yqxydv1RkkysonL81mOsbiVkj0UQ2B01qSOiVfNrB8x2TMWJ9mGUzbujVkb9
	 bEbNGx+hklBRDxaaRRN1F5gGFwwkpY94w/BnLkhbtNxmwdA2zwdecVb4DnRC2XzFjU
	 DMFJEQBguDr6la4S4voQfyOU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A1B840E0177;
	Tue, 28 May 2024 13:47:39 +0000 (UTC)
Date: Tue, 28 May 2024 15:47:32 +0200
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
Subject: Re: [PATCHv11 01/19] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Message-ID: <20240528134732.GHZlXgdO88f3j0Biu9@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240528095522.509667-2-kirill.shutemov@linux.intel.com>

On Tue, May 28, 2024 at 12:55:04PM +0300, Kirill A. Shutemov wrote:
> In order to prepare for the expansion of support for the ACPI MADT
> wakeup method, move the relevant code into a separate file.
> 
> Introduce a new configuration option to clearly indicate dependencies
> without the use of ifdefs.
> 
> There have been no functional changes.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Tao Liu <ltao@redhat.com>
> ---
>  arch/x86/Kconfig                   |  7 +++
>  arch/x86/include/asm/acpi.h        |  5 ++
>  arch/x86/kernel/acpi/Makefile      |  1 +
>  arch/x86/kernel/acpi/boot.c        | 86 +-----------------------------
>  arch/x86/kernel/acpi/madt_wakeup.c | 82 ++++++++++++++++++++++++++++
>  5 files changed, 96 insertions(+), 85 deletions(-)
>  create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

