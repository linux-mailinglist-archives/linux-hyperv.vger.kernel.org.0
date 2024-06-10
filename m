Return-Path: <linux-hyperv+bounces-2373-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD79902365
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jun 2024 16:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46F41F23B1C
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jun 2024 14:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E94132118;
	Mon, 10 Jun 2024 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mth3Ocsv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822BD12FF65;
	Mon, 10 Jun 2024 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028125; cv=none; b=CumOXARXhz/G6SmpQQSTJsnVX5XgBuwkN9j3n6GSsC/OVown/cBPFARrhvMZJ/pX7Eor7Q9eciVAmnyEwrKjA/ftZBZ1sFZdJ2azbYPH8Cb05BVjG8+JM4ADAiPEgcr5j+D1EcX2fJm006MfbdphnPACG7wEQnhyBdd2SNNNikc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028125; c=relaxed/simple;
	bh=g0xcEy+pFWVYmhSOSWpyQFktSP+xBDDKruU8/KgTUqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2QGWzE0YjIM8o63k8ueyac+Mx3gcnMxSs3NvRvOQPcczZ6Z7ziuvxOiLkRGdRBvoSw06bRNdBCyUyyNkXmPxCaupvc3aOZT8LVP5L6Vuvha6p+horEhPXNhlzTJy0iWRg5xSuNnvkScisKJKU5FmF00VEsJChfiHa5kVoiKCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mth3Ocsv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718028124; x=1749564124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g0xcEy+pFWVYmhSOSWpyQFktSP+xBDDKruU8/KgTUqM=;
  b=Mth3Ocsvhu3cmKQBj+MdtjQbQKvti1mOMmDkKNADJKQSP5S5DeG2opnG
   YHUvha0DjoCC+3l3WPWv0XUpbtD7ufyaePRV66z6JRq2QHXgKoK4EDBvT
   P/Bh01fNQ+h5fCjmoIdrhH8XTkzy5pafz5S6DG3ubzgP/XLr8fj42Hr2r
   4tT5aBquczFL/XtaFbB/rsYIa59nNDOY6jP5CvqSaeFsCr5S39I5k0bt3
   NrF6Ap7un0meM2FjMhUyJKp9sHnnTZloaztO+b3wviWq3/TWgWsgxrCet
   3eg0XcukgARNYaGYNNZpUcNVNo/Qb6QJR4/DX8WDiEadxxhmjU2waU1Yt
   g==;
X-CSE-ConnectionGUID: Y+ZhnCu7S7eMHancxKuZuA==
X-CSE-MsgGUID: NIqTQJHaSze8kv3JqESw/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="11998244"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="11998244"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 07:02:03 -0700
X-CSE-ConnectionGUID: 9ErXJ/nuQHmHPs8IKgjiRA==
X-CSE-MsgGUID: OUlS4SOxTGyzDSRbYOqyxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39736967"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 10 Jun 2024 07:01:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AC1CC20B; Mon, 10 Jun 2024 17:01:55 +0300 (EEST)
Date: Mon, 10 Jun 2024 17:01:55 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 18/19] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
Message-ID: <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>

On Mon, Jun 10, 2024 at 03:40:20PM +0200, Borislav Petkov wrote:
> On Fri, Jun 07, 2024 at 06:14:28PM +0300, Kirill A. Shutemov wrote:
> >   I was able to address this issue by switching cpa_lock to a mutex.
> >   However, this solution will only work if the callers for set_memory
> >   interfaces are not called from an atomic context. I need to verify if
> >   this is the case.
> 
> Dunno, I'd be nervous about this. Althouth from looking at
> 
>    ad5ca55f6bdb ("x86, cpa: srlz cpa(), global flush tlb after splitting big page and before doing cpa")
> 
> I don't see how "So that we don't allow any other cpu" can't be done
> with a mutex. Perhaps the set_memory* interfaces should be usable in as
> many contexts as possible.
> 
> Have you run this with lockdep enabled?

Yes, it booted to the shell just fine. However, that doesn't prove
anything. The set_memory_* function has many obscured cases.

> > - The function __flush_tlb_all() in kernel_(un)map_pages_in_pgd() must be
> >   called with preemption disabled. Once again, I am unsure why this has
> >   not caused issues in the EFI case.
> 
> It could be because EFI does all that setup on the BSP only before the
> others have arrived but I don't remember anymore... It is more than
> a decade ago when I did this...

Are you okay with this? Disabling preemption looks strange, but I don't
see a better option.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

