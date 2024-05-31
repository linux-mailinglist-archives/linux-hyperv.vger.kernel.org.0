Return-Path: <linux-hyperv+bounces-2266-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904C18D657E
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 May 2024 17:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2ACF1C25946
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 May 2024 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E637375817;
	Fri, 31 May 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q6PLaDRJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B082173502;
	Fri, 31 May 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168523; cv=none; b=d8dfh4gi1ixO1u5Eq8GyDTa1QH1HTb2l4UWEnYFgCt5KjGClgUPKE1784pN6pDzPm2ABod76Qos0+LEkHyuYy0LFW8wClfyaMvaXDSc7jpZza9ZLb23H1h9YQQiCvmeJ4Bh86lqL3VaNJmXILeDFrlqgSy05SOTc0qhUYVb7N0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168523; c=relaxed/simple;
	bh=KuFosQ9xJS3QXwL9rRdDEjEMEUkYQVI21lZRTP74w5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiNmm65nPXEDhDp56xITCm2WqlDnWH+ZXAjxrYVkkdlBO0Zwxj+Z/7EXEkXp4KdmQ9BO6KX8+4U6qN3X+Zhh8NPrsvRNq3lp1lAKz2Y+4EJFDQQHNlX3+OYgRK+uUSFEJSSj3P11PXl3zdTLths0cXoINfGAlCCJdO8YOBsoHFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Q6PLaDRJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2049540E0192;
	Fri, 31 May 2024 15:15:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FSUEfZbijwTn; Fri, 31 May 2024 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717168515; bh=CimpYdG8QQl3X2QgMhhHzMQn8EofMmTYe+oEbL8ZrvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6PLaDRJ86E0OGNAGCUojT3CX1WrSdqZh8RMU8h1+IyOWZ5wR7SbnPUJ9+JopYOFv
	 q6Fp7di+pKi+J6Crq/DKHAQ+2EGmF+N1koju13pL4DfyJYqefqB3sQqgJYx5+HGISW
	 6VTzbQeP6POrjfvVR4P5rrQ4oMqOWFKQMIaeAOFhJuA0/PMPI9HWMMxKWusnekNmCP
	 QoYmcSSfNhePOXGbxoOtwzrcQYoBCx9bspLdrll9T0F+xNAgYMNOVZnjGuqkMGspDP
	 RN/A/cW8YUxtgTdzfkaxdOMYbTI7Uh2v4FI/FEVyho3WEtZMnSoTAzFSg1vHRQ64A7
	 cstm5aWVt74OCKGk5mh9a4lKEnCEVC39eTqTx8O7vMWhhRHSwHkN5CpUvbi/5XWzaY
	 TO9nnirQSbxwiRXDOUP09aArD1c1hXdVDCEGCKIOKLRFL47YJnlcsdICo8O558IfgS
	 BXElZk75qTe+R78bwi/7qQnfjxrvjasBQoFstD5smrSvO1W7O3NNBxNjMWkFAm6JFd
	 aap8w2d0O7pwC1loUtrtasJ1MhDev3vvHWwJsG53Bva9khDOU5UmXgkROfJBQMpaNA
	 8uawK2joAgByCDPLKKjLV+41+FquZPhLac+8bRKLlYLRPDhtPFDm4ptYa0YYyOxThQ
	 eHGxqsqNGnZSsEix9vDbesbc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9041840E01E8;
	Fri, 31 May 2024 15:14:48 +0000 (UTC)
Date: Fri, 31 May 2024 17:14:42 +0200
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
Subject: Re: [PATCHv11 11/19] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-12-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240528095522.509667-12-kirill.shutemov@linux.intel.com>

On Tue, May 28, 2024 at 12:55:14PM +0300, Kirill A. Shutemov wrote:
> +static void tdx_kexec_finish(void)
> +{
> +	unsigned long addr, end;
> +	long found = 0, shared;
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	addr = PAGE_OFFSET;
> +	end  = PAGE_OFFSET + get_max_mapped();
> +
> +	while (addr < end) {
> +		unsigned long size;
> +		unsigned int level;
> +		pte_t *pte;
> +
> +		pte = lookup_address(addr, &level);
> +		size = page_level_size(level);
> +
> +		if (pte && pte_decrypted(*pte)) {
> +			int pages = size / PAGE_SIZE;
> +
> +			/*
> +			 * Touching memory with shared bit set triggers implicit
> +			 * conversion to shared.
> +			 *
> +			 * Make sure nobody touches the shared range from
> +			 * now on.
> +			 */
> +			set_pte(pte, __pte(0));
> +

Format the below into a comment here:

/* 

The only thing one can do at this point on failure is panic. It is
reasonable to proceed, especially for the crash case because the
kexec-ed kernel is using a different page table so there won't be
a mismatch between shared/private marking of the page so it doesn't
matter.

Also, even if the failure is real and the page cannot be touched as
private, the kdump kernel will boot fine as it uses pre-reserved memory.
What happens next depends on what the dumping process does and there's
a reasonable chance to produce useful dump on crash.

Regardless, the print leaves a trace in the log to give a clue for
debug.

One possible reason for the failure is if kdump raced with memory
conversion. In this case shared bit in page table got set (or not
cleared form shared->private conversion), but the page is actually
private. So this failure is not going to affect the kexec'ed kernel.

*/

<---

> +			if (!tdx_enc_status_changed(addr, pages, true)) {
> +				pr_err("Failed to unshare range %#lx-%#lx\n",
> +				       addr, addr + size);
> +			}
> +
> +			found += pages;
> +		}
> +
> +		addr += size;
> +	}
> +
> +	__flush_tlb_all();
> +
> +	shared = atomic_long_read(&nr_shared);
> +	if (shared != found) {
> +		pr_err("shared page accounting is off\n");
> +		pr_err("nr_shared = %ld, nr_found = %ld\n", shared, found);
> +	}
> +}

...

>  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>  {
> -	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> -		return __set_memory_enc_pgtable(addr, numpages, enc);
> +	int ret = 0;
>  
> -	return 0;
> +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> +		if (!down_read_trylock(&mem_enc_lock))
> +			return -EBUSY;
> +
> +		ret = __set_memory_enc_pgtable(addr, numpages, enc);
> +
> +		up_read(&mem_enc_lock);
> +	}

So CC_ATTR_MEM_ENCRYPT is set for SEV* guests too. You need to change
that code here to take the lock only on TDX, where you want it, not on
the others.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

