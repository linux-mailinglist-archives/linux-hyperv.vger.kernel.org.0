Return-Path: <linux-hyperv+bounces-2843-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AA395DA34
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 02:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871FB1C2139A
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCB81388;
	Sat, 24 Aug 2024 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDYN8CSY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE1195;
	Sat, 24 Aug 2024 00:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458666; cv=none; b=ZHUyFv0aVY2DgaI6mfJHdZ3kjU6beMoYnos+cr0/hynO9nFwgi9Psh50A3oZH6VQedXt70vZb8gw1JS9op8IBa22Fv4CWxW9PSLG+bA+P20jqcvspF64KZZoOYYsyuqZyT/qE9xIajkv1OdVN1k6drciAoN+hMoGJnThCwuK6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458666; c=relaxed/simple;
	bh=wljoqGsA0TkAmF4SO4AeWOB8Rba0g9hk5wE0vU3p57Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmCNJvHv+rBejnpGrx5U5silzVJYVnZcgDIElXaRkfqgByjJPrwdBwKVLGz+lq9pKsVXqHXninTxBu8yQcubWt3P1yTHXBoHzsQogrV6GQULSdMY0NV77kjrMtNB1aW1fh/LfzHFQyoDi6VHAJARZH9UrOR4v8R12fsgjBLOMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDYN8CSY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724458665; x=1755994665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wljoqGsA0TkAmF4SO4AeWOB8Rba0g9hk5wE0vU3p57Q=;
  b=lDYN8CSYFnnqC5DzUh/oDXvhuvaQFI7a+B6LVSECynZz5pBnOs0+onwC
   47Jm3WzvlFHbN9a2k/CocWOmCKjECvdWwVx9v2LYzUjlVtcaoTsNZ2Tz6
   WW0PeI+McDSVXEwon7LDdGlllzOnAWU7j6Pnp3toWcPVohvGOe0+lVFaA
   puTw2nbh8OlnSfvi+0Ey9dWpOMf7heNS+louMHF6HGLpeKVjta6xtGxyF
   7oy7FhVmkUKz6jSVJmp8Z9TNcYs4vDks6JgZbKfJsNfMxOlYmvKLuQaEL
   Sifdy5prpON35iXjqovJakkoFajizR/MExdx/A0WvW8a8DV51cwcAE5Em
   Q==;
X-CSE-ConnectionGUID: 9AachcCeQIa92mfMnoS7uw==
X-CSE-MsgGUID: hJ0v65llSc2Sy/UC5DmHAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33574154"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33574154"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 17:17:44 -0700
X-CSE-ConnectionGUID: vp96dOqhTYKR2q1SNV/1bQ==
X-CSE-MsgGUID: E8vsjnpvQe2h08pJXqsk9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="99466060"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.124.1.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 17:17:42 -0700
Date: Fri, 23 Aug 2024 17:17:42 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org,
	lenb@kernel.org, kirill.shutemov@linux.intel.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 6/7] x86/hyperv: Reserve real mode when ACPI wakeup
 mailbox is available
Message-ID: <20240824001742.GA424@yjiang5-mobl.amr.corp.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
 <20240806221237.1634126-7-yunhong.jiang@linux.intel.com>
 <87a5ho2q6x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5ho2q6x.ffs@tglx>

On Wed, Aug 07, 2024 at 07:33:26PM +0200, Thomas Gleixner wrote:
> On Tue, Aug 06 2024 at 15:12, Yunhong Jiang wrote:
> > +static void __init hv_reserve_real_mode(void)
> > +{
> > +	phys_addr_t mem;
> > +	size_t size = real_mode_size_needed();
> > +
> > +	/*
> > +	 * We only need the memory to be <4GB since the 64-bit trampoline goes
> > +	 * down to 32-bit mode.
> > +	 */
> > +	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, SZ_4G);
> > +	if (!mem)
> > +		panic("No sub-4G memory is available for the trampoline\n");
> > +	set_real_mode_mem(mem);
> > +}
> 
> We really don't need another copy of reserve_real_mode(). See uncompiled
> patch below. It does not panic when the allocation fails, but why do you
> want to panic in that case? If it's not there then the system boots with
> a single CPU, so what.

I created a separated patch on my v2 patch set with "Originally-by:" tag
following suggestion at
https://lore.kernel.org/lkml/20240711081317.GD4587@noisy.programming.kicks-ass.net/

Please let me know if that's not the appropriate solution.
 
> 
> >  void __init hv_vtl_init_platform(void)
> >  {
> >  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> >  
> >  	if (wakeup_mailbox_addr) {
> >  		x86_platform.hyper.is_private_mmio = hv_is_private_mmio_tdx;
> > +		x86_platform.realmode_reserve = hv_reserve_real_mode;
> >  	} else {
> >  		x86_platform.realmode_reserve = x86_init_noop;
> >  		x86_platform.realmode_init = x86_init_noop;
> > @@ -259,7 +276,8 @@ int __init hv_vtl_early_init(void)
> >  		panic("XSAVE has to be disabled as it is not supported by this module.\n"
> >  			  "Please add 'noxsave' to the kernel command line.\n");
> >  
> > -	real_mode_header = &hv_vtl_real_mode_header;
> > +	if (!wakeup_mailbox_addr)
> > +		real_mode_header = &hv_vtl_real_mode_header;
> 
> Why is that not suffient to be done in hv_vtl_init_platform() inside the
> condition which clears x86_platform.realmode_reserve/init?
> 
> x86_platform.realmode_init() is invoked from an early initcall while
> hv_vtl_init_platform() is called during early boot.

I created a separated patch for this change on my v2 patch set, since it's a
a separated logic change. I added a Suggested-by: tag to the patch, hope it's
ok.

Thanks
--jyh

> 
> Thanks,
> 
>         tglx
> ---
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -31,12 +31,18 @@ struct x86_init_mpparse {
>   *				platform
>   * @memory_setup:		platform specific memory setup
>   * @dmi_setup:			platform specific DMI setup
> + * @realmode_limit:		platform specific address limit for the realmode trampoline
> + *				(default 1M)
> + * @reserve_bios:		platform specific address limit for reserving the BIOS area
> + *				(default 1M)
>   */
>  struct x86_init_resources {
>  	void (*probe_roms)(void);
>  	void (*reserve_resources)(void);
>  	char *(*memory_setup)(void);
>  	void (*dmi_setup)(void);
> +	unsigned long realmode_limit;
> +	unsigned long reserve_bios;
>  };
>  
>  /**
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -8,6 +8,7 @@
>  #include <linux/ioport.h>
>  #include <linux/export.h>
>  #include <linux/pci.h>
> +#include <linux/sizes.h>
>  
>  #include <asm/acpi.h>
>  #include <asm/bios_ebda.h>
> @@ -68,6 +69,8 @@ struct x86_init_ops x86_init __initdata
>  		.reserve_resources	= reserve_standard_io_resources,
>  		.memory_setup		= e820__memory_setup_default,
>  		.dmi_setup		= dmi_setup,
> +		.realmode_limit		= SZ_1M,
> +		.reserve_bios		= SZ_1M,
>  	},
>  
>  	.mpparse = {
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -45,7 +45,7 @@ void load_trampoline_pgtable(void)
>  
>  void __init reserve_real_mode(void)
>  {
> -	phys_addr_t mem;
> +	phys_addr_t mem, limit = x86_init.resources.realmode_limit;
>  	size_t size = real_mode_size_needed();
>  
>  	if (!size)
> @@ -54,17 +54,15 @@ void __init reserve_real_mode(void)
>  	WARN_ON(slab_is_available());
>  
>  	/* Has to be under 1M so we can execute real-mode AP code. */
> -	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, 1<<20);
> +	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, limit);
>  	if (!mem)
> -		pr_info("No sub-1M memory is available for the trampoline\n");
> +		pr_info("No memory below %lluM for the real-mode trampoline\n", limit >> 20);
>  	else
>  		set_real_mode_mem(mem);
>  
> -	/*
> -	 * Unconditionally reserve the entire first 1M, see comment in
> -	 * setup_arch().
> -	 */
> -	memblock_reserve(0, SZ_1M);
> +	/* Reserve the entire first 1M, if enabled. See comment in setup_arch(). */
> +	if (x86_init.resources.reserve_bios)
> +		memblock_reserve(0, x86_init.resources.reserve_bios);
>  }
>  
>  static void __init sme_sev_setup_real_mode(struct trampoline_header *th)

