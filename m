Return-Path: <linux-hyperv+bounces-2385-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B1390406A
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 17:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B434B2195C
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4072A383A3;
	Tue, 11 Jun 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYkp1Kud"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C51D556;
	Tue, 11 Jun 2024 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120835; cv=none; b=YcfTAQ/uVMw9J1rmksWExg8LuWusjes5kQZr0ORHSUvROQc0iraboB+mxJMRxSazKr+RkkIvIVWubx4pMiIN1g1fyzj7jhJj6IvgOHXxTj8WJX7ZrQiaHjQyKI3pqVzHPlE5PT51b5J/wPkann++ydf4j+wpIz+W620N+zqI7m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120835; c=relaxed/simple;
	bh=TX63nz8clG540zRkwgoV3FmdB4+YRQdt53SWeHOoP00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMfhowaNVU3Fy847tLnr54eRenfKZWgkhZP53pQNeBqt7vixjiwpQXbmeRDTE/sekd4u/We14ZIfxsIxM9uWQyWOlbUst5Rzt9DrWwrykowWFnAcGfO11wJyniWoXjLq2WJ1KlkgxGced+aoWOmD7JkyNTb81N69LQnJai/GFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYkp1Kud; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718120834; x=1749656834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TX63nz8clG540zRkwgoV3FmdB4+YRQdt53SWeHOoP00=;
  b=bYkp1KudJS2Qqo7E7IicJWoTwk0wIalcy9qCBLjjzk5G8nZ2YC64NBEm
   8pIRwburt9oeHMhBifWeDACPkMr0eQ5USk9TQr5lHbOzc7nFK94eFoXj9
   Flx1dkZL1M3Zv8d6EmeDMCX05GQzjMMpnO+gJDpPkar0MQSijajmH0cti
   74gwPQrCXrQRgNGf6ooILN/gfO/tG8tlJxrPZlxEgQdlLGL1XGjjR5bVP
   JmfaOgvxWegS1zO59kW7AFSyjOR/1RVaS2/tnoksGfBvrGHDJV3XH4Qbl
   41pOkjVu5JqtrA8Q4Qpf1q8HjMWyoBMowu9q53V7KeDf4ZcCn96KwUOSE
   w==;
X-CSE-ConnectionGUID: ndKEnYFsR+mkUHqF193RJw==
X-CSE-MsgGUID: nG4uWHBFRHiW49YIdqCkPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="25419712"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="25419712"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 08:47:13 -0700
X-CSE-ConnectionGUID: MtakBbo6Q/Wi2hPQzssvAQ==
X-CSE-MsgGUID: 9gL7YP+hS4+lRn7WhutdGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="76942409"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 11 Jun 2024 08:47:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6E61F169; Tue, 11 Jun 2024 18:47:05 +0300 (EEST)
Date: Tue, 11 Jun 2024 18:47:05 +0300
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
Message-ID: <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
 <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>

On Mon, Jun 10, 2024 at 05:01:55PM +0300, Kirill A. Shutemov wrote:
> On Mon, Jun 10, 2024 at 03:40:20PM +0200, Borislav Petkov wrote:
> > On Fri, Jun 07, 2024 at 06:14:28PM +0300, Kirill A. Shutemov wrote:
> > >   I was able to address this issue by switching cpa_lock to a mutex.
> > >   However, this solution will only work if the callers for set_memory
> > >   interfaces are not called from an atomic context. I need to verify if
> > >   this is the case.
> > 
> > Dunno, I'd be nervous about this. Althouth from looking at
> > 
> >    ad5ca55f6bdb ("x86, cpa: srlz cpa(), global flush tlb after splitting big page and before doing cpa")
> > 
> > I don't see how "So that we don't allow any other cpu" can't be done
> > with a mutex. Perhaps the set_memory* interfaces should be usable in as
> > many contexts as possible.
> > 
> > Have you run this with lockdep enabled?
> 
> Yes, it booted to the shell just fine. However, that doesn't prove
> anything. The set_memory_* function has many obscured cases.
> 
> > > - The function __flush_tlb_all() in kernel_(un)map_pages_in_pgd() must be
> > >   called with preemption disabled. Once again, I am unsure why this has
> > >   not caused issues in the EFI case.
> > 
> > It could be because EFI does all that setup on the BSP only before the
> > others have arrived but I don't remember anymore... It is more than
> > a decade ago when I did this...
> 
> Are you okay with this? Disabling preemption looks strange, but I don't
> see a better option.

Borislav, given this code deduplication effort is not trivial, maybe we
can do it as a separate patchset on top of this one?

I also wounder if it makes sense to combine ident_map.c and set_memory.c.
There's some overlap between the two.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

