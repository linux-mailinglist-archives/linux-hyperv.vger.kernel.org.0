Return-Path: <linux-hyperv+bounces-2278-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB388D7D91
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jun 2024 10:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93C828360F
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jun 2024 08:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BEE679E5;
	Mon,  3 Jun 2024 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hlyJZUhO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F3A5FBB7;
	Mon,  3 Jun 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717404007; cv=none; b=KL9R0ImTdPCS7zlnObnxx/fXXXxv7bSHgN8qoz1bWJSCZUw62IUZNxPizS2LsZnHZbUb9h1G+9JVeWRrHUfwFcxP8FbzkjLUEuzidHDyQHoRnHtOM6mfa1omNPdJBckThuOkyj9XVivlSNFObEe0zyxDoY6jj6NiZtRW7Hc5/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717404007; c=relaxed/simple;
	bh=sm2WphO+53+X7EoyS+a9MQSq6fuBiYPK6PgONkDv8VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl7NIKOP8sUhMsE504y3R1LwmMZARc2x/hgTI50U9a3gzCTLop0epOLLnrnNG21QECBnIFMQh0Ccvv9H6k6FQdykh67GxwdmLZzdpw0Xq2DsmGzOgfBUbek1UdTm+hvA77OdLn15v5rrk/jiSDbRKHpk2oqQ3B+q5QCJrJJC6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hlyJZUhO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BCCDB40E0176;
	Mon,  3 Jun 2024 08:40:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NaOQH7nJ-Lsa; Mon,  3 Jun 2024 08:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717403999; bh=EOQSXaPODkDHM7VjIgumTPn4fUWhW0OISBcc5f5uwf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hlyJZUhOM5L/0fr7gI4M49zSnf9pySr1xNLlxUn5xkCo2v/KR1abmWweu4eKySSOR
	 Ddkrz51/6ck9sJKXv2KJ82JJM5E3rbokzSoAiN9zFc13Segfnjtm7uJ0UzCBpRPLZX
	 XvO8FDnIXMuqtOF9YoUIPk4jpJG3sYTqai0fW7GmmggZ3SQYtMMTg5Afxc03yCpdcM
	 /hWCWvzkpT0Emis2MSqsDf14Qc6eRiuikyEF71hYPfJgYvtJ5zc+/ngnAthIakGohD
	 vfTsbSzCohMb1reYEJj4NGFvo2R9jeN+92FQ/Vmmd3fdq9GhksZDFP58zTI6rqdk8K
	 UmRgn/KUJlsPlGo6JnkuLY+aEIFb2vKNg9vcoIP+fb/wEY2ZDYiVjIRKDQ2S+pCGVH
	 tZpqg+iaLWdhSwagcJV3lWZb9waRWJtkWmCxz2HYnLIrOOgjkg8EB+BegCXdPlWycG
	 ejxKyLFAeLN2YuKpFyB+MnNSZfSDAhaBT+k6V+TZmX9G8ZUOHWSCSKQAS07oqIBcUd
	 7bJmBJVETY8dRat62n1ZSUo65yvHlI2WVl8AId0w0kbsrekIItlWnoToHh3nKvTjRP
	 1GI55x8Yyi3iq4dQtwZREUu57fQHyR6bz3BKIYNlrAXwRoqv1ZWjFw12xQ3zN7KuIA
	 H6x3+IwzZ7iJGr6GHScdaDsE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F37A40E0081;
	Mon,  3 Jun 2024 08:39:32 +0000 (UTC)
Date: Mon, 3 Jun 2024 10:39:30 +0200
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
Message-ID: <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240528095522.509667-19-kirill.shutemov@linux.intel.com>

On Tue, May 28, 2024 at 12:55:21PM +0300, Kirill A. Shutemov wrote:
> MADT Multiprocessor Wakeup structure version 1 brings support of CPU

s/of /for /

> offlining: BIOS provides a reset vector where the CPU has to jump to
> for offlining itself. The new TEST mailbox command can be used to test
> whether the CPU offlined itself which means the BIOS has control over
> the CPU and can online it again via the ACPI MADT wakeup method.
> 
> Add CPU offling support for the ACPI MADT wakeup method by implementing

Unknown word [offling] in commit message.

Please introduce a spellchecker into your patch creation workflow.

> custom cpu_die(), play_dead() and stop_this_cpu() SMP operations.
> 
> CPU offlining makes is possible to hand over secondary CPUs over kexec,

s/is /it /

> not limiting the second kernel to a single CPU.

...

> +/*
> + * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
> + * the same place as in the kernel page tables. asm_acpi_mp_play_dead() switches
> + * to the identity mapping and the function has be present at the same spot in
> + * the virtual address space before and after switching page tables.
> + */
> +static int __init init_transition_pgtable(pgd_t *pgd)

This looks like a generic helper which should be in set_memory.c. And
looking at that file, there's populate_pgd() which does pretty much the
same thing, if I squint real hard.

Let's tone down the duplication.

> +{
> +	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
> +	unsigned long vaddr, paddr;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +
> +	vaddr = (unsigned long)asm_acpi_mp_play_dead;
> +	pgd += pgd_index(vaddr);
> +	if (!pgd_present(*pgd)) {
> +		p4d = (p4d_t *)alloc_pgt_page(NULL);
> +		if (!p4d)
> +			return -ENOMEM;
> +		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
> +	}
> +	p4d = p4d_offset(pgd, vaddr);
> +	if (!p4d_present(*p4d)) {
> +		pud = (pud_t *)alloc_pgt_page(NULL);
> +		if (!pud)
> +			return -ENOMEM;
> +		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
> +	}
> +	pud = pud_offset(p4d, vaddr);
> +	if (!pud_present(*pud)) {
> +		pmd = (pmd_t *)alloc_pgt_page(NULL);
> +		if (!pmd)
> +			return -ENOMEM;
> +		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
> +	}
> +	pmd = pmd_offset(pud, vaddr);
> +	if (!pmd_present(*pmd)) {
> +		pte = (pte_t *)alloc_pgt_page(NULL);
> +		if (!pte)
> +			return -ENOMEM;
> +		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
> +	}
> +	pte = pte_offset_kernel(pmd, vaddr);
> +
> +	paddr = __pa(vaddr);
> +	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
> +
> +	return 0;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

