Return-Path: <linux-hyperv+bounces-2249-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A878D34BD
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 May 2024 12:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F8D1C23315
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 May 2024 10:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F3C17B51C;
	Wed, 29 May 2024 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="B+WjQjKe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591C17B4E5;
	Wed, 29 May 2024 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716979426; cv=none; b=MUq3iQflzkaAYmafmcmoqTs8gbfmIkn/N9SEPsnB9wFDGnguBahaRJ/EuKmADsMzM+mVlp0ep2CDQcOunrOphdPOr1RBzsVDgUzM1gw4kMth2G6nblt7poQg+1we7DvZj6asaI9DqdkAvP4ePUBk0v57GUJN1dwAlB5BTIs41LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716979426; c=relaxed/simple;
	bh=up394OjV6Mya4etDTOCYaWlZ31SgZg4PVph4Q7LohxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pb1kEHHY6d9YmDzlkVB3BbGasBp32Wz8F8jN49tzQW8rCKh9FMiKJHyZQ1t0IBok3G1Smd5gmBKCqQuZ2QbBkaTNFKF0MU87tmTQ0nOfow0er2MXNZRfxetmt+7SnMB7YdTfsKapmjoq7ztEx+snfU7lAMu/luOyTiOvK3hh2C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=B+WjQjKe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2054A40E02AF;
	Wed, 29 May 2024 10:43:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AwDXIKgAyAXx; Wed, 29 May 2024 10:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716979412; bh=e1AAoC8VPH2JOJ+ljlTpXygxtyAhC2c5XbpDeQh3FuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+WjQjKeqTyuu8CI7MMsYGxCJTuSJtxQJpcVNv0maCOvgyWtzobmD/5owgf8vb56c
	 /01mD/zxJ2v/pmRbVrzodj7rSYLw3WgMDWCMa2Mon2eonhgEolnoHq3NNDDJo8OvuP
	 7X+bJC26zES1rQyM2SFu4Osr/uUMGIlE9EQ4IaTQNWdkTrmbsXxNYGFaVfHtOe3QnO
	 2CjOpnysup14rg3wkX13EkLKmZ61lVddVg7RBRQ0OPd+oKkzB8uLLUVkDegzNvblrm
	 5KqASPmbnDv4UxzBpmHDLNfVX8aIMg3fi7jAsJ8VE+R0rBb614mLWKU77OtTBCb6ZN
	 H02+Ts10dftT//q3g4bdKJHn05rKN/yoANx3s3ew6XP1/K+2dUAwnQ+4z2lXcWWaVd
	 6DIe3crIOrv8Ntogwes2bnjdnbUlH401beIUfosBDHh/d9Lxgye+gkwimySbQyNI/E
	 jfEqBWFwSt7zpJLEqTmxdhH5LgOoMMI6vhcSiB2oHZ+4bhOP2vo+mz0vi23xxmVJ8Q
	 YB38fbImDcMkOOOTkOxSSu2w1pehpE/fkKPaFPmdzZmcH02c05Exm7WcMHrmIuYgb+
	 kOM2aDXxW4yWyT62Y6fYBD3oTOfukx1d3ofe98oFoDI+W+1v8DUsHUHbUcrALP9htz
	 uHf3ICtv+3vCpq1w51ajQHoM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4DA940E0241;
	Wed, 29 May 2024 10:43:03 +0000 (UTC)
Date: Wed, 29 May 2024 12:42:57 +0200
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
	Nikolay Borisov <nik.borisov@suse.com>, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 10/19] x86/mm: Add callbacks to prepare encrypted
 memory for kexec
Message-ID: <20240529104257.GIZlcGsTkJHVBblkrY@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-11-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240528095522.509667-11-kirill.shutemov@linux.intel.com>

On Tue, May 28, 2024 at 12:55:13PM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index 28ac3cb9b987..6cade48811cc 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -149,12 +149,21 @@ struct x86_init_acpi {
>   * @enc_status_change_finish	Notify HV after the encryption status of a range is changed
>   * @enc_tlb_flush_required	Returns true if a TLB flush is needed before changing page encryption status
>   * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
> + * @enc_kexec_begin		Begin the two-step process of conversion shared memory back

s/conversion/converting/

> + *				to private. It stops the new conversions from being started
> + *				and waits in-flight conversions to finish, if possible.

Good.

Now add "The @crash parameter denotes whether the function is being
called in the crash shutdown path."

> + * @enc_kexec_finish		Finish the two-step process of conversion shared memory to

s/conversion/converting/

> + *				private. All memory is private after the call.

"... when the function returns."

> + *				It called with all CPUs but one shutdown and interrupts
> + *				disabled.

"It is called on only one CPU while the others are shut down and with
interrupts disabled."

>   */
>  struct x86_guest {
>  	int (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
>  	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
>  	bool (*enc_tlb_flush_required)(bool enc);
>  	bool (*enc_cache_flush_required)(void);
> +	void (*enc_kexec_begin)(bool crash);
> +	void (*enc_kexec_finish)(void);
>  };
>  
>  /**
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index f06501445cd9..74f6305eb9ec 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -128,6 +128,18 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>  #ifdef CONFIG_HPET_TIMER
>  	hpet_disable();
>  #endif
> +
> +	/*
> +	 * Non-crash kexec calls enc_kexec_begin() while scheduling is still
> +	 * active. This allows the callback to wait until all in-flight
> +	 * shared<->private conversions are complete. In a crash scenario,
> +	 * enc_kexec_begin() get call after all but one CPU has been shut down

"gets called" ... "have been shut down"

> +	 * and interrupts have been disabled. This only allows the callback to

only?

> +	 * detect a race with the conversion and report it.
> +	 */
> +	x86_platform.guest.enc_kexec_begin(true);
> +	x86_platform.guest.enc_kexec_finish();
> +

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

