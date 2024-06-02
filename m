Return-Path: <linux-hyperv+bounces-2275-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FE08D7629
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Jun 2024 16:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7F81F2148F
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Jun 2024 14:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9063640877;
	Sun,  2 Jun 2024 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRaN60GA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A61E864;
	Sun,  2 Jun 2024 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717338064; cv=none; b=VHWhDmH3VRa+0fHp+B4gnKPWHDywsB74beUpjQRpo6M3WezZsxRsj+mZKshdtHTEQ+FBrZvDquQc6O/1Yv1YECHl+4UtD+l97vE0L/HZi/hDxlBZfN5NbozVZPpt50FF9s+ynnf0g+ZVnn9y5T2cmlHwzzoR5IXCYeuXLpyR7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717338064; c=relaxed/simple;
	bh=HHQSybEJxUEGfYcVhVIrgQp0w28pkdQd7EvfJc/M9y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8iwnidfypXwEd4+AkLlC87kPLQOroLb+QAd41XWRAopV5f1+VmEMKl54uoxQx/bzWQbS4Wa8g5nvvWJsbfhbcMxyctgkjAw+kpKIARIMDdCNEhw5SoMaPQH1ROIKnwOyv/jz786ZnxNhU3eeHYEXabygNVuo/no4XWIxfKDZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRaN60GA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717338063; x=1748874063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HHQSybEJxUEGfYcVhVIrgQp0w28pkdQd7EvfJc/M9y4=;
  b=KRaN60GAGZyOjUNO3g0xz+gK5q0gMkxFJ2LBHc7wYNg0VEOqYI7YO/Qq
   Pka3bqfqiB//2meE7xQrWQ6qVgYMQ4tc7kPB8Xmmqzwla1XuD7QSYTIQc
   BTf5T3dRrklBAz5lPOpxuaOVWAD6VpcOz/M8M1nh70AsFeUl628SHgS2H
   e2vOmNVJuVFh6XIW2lpg5Hut4X/dFRlwsZ35W3s03bnfbZXaNxHpA/kb+
   COLcifD9GawiGJXUoszHouVWTa0mvW+rvKU+CL69H/LTZzDfagDu94ulI
   +0Q/tuzBpJ0HKvSto0qReYIC0XPW8Fo6lXVuajdBAyowQuuvwhz4x8vtZ
   Q==;
X-CSE-ConnectionGUID: MNRyaDBSSret6HRQT6553Q==
X-CSE-MsgGUID: aWI4htLaT9WMFn1LpuJ9fA==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17629013"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="17629013"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 07:21:02 -0700
X-CSE-ConnectionGUID: ke8Ahaw5T768IbxDwu8Qog==
X-CSE-MsgGUID: wlmiIkyFSpy2c6mxIJT/Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="36560562"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 02 Jun 2024 07:20:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B8B441CB; Sun, 02 Jun 2024 17:20:54 +0300 (EEST)
Date: Sun, 2 Jun 2024 17:20:54 +0300
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
Subject: Re: [PATCHv11 11/19] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <tur63s5trxwwnwfs43f4jcc6pfostpw6cchwhrgo7tsfzicozn@mvqrntyi6x4w>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-12-kirill.shutemov@linux.intel.com>
 <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>

On Fri, May 31, 2024 at 05:14:42PM +0200, Borislav Petkov wrote:
> On Tue, May 28, 2024 at 12:55:14PM +0300, Kirill A. Shutemov wrote:
> > +static void tdx_kexec_finish(void)
> > +{
> > +	unsigned long addr, end;
> > +	long found = 0, shared;
> > +
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	addr = PAGE_OFFSET;
> > +	end  = PAGE_OFFSET + get_max_mapped();
> > +
> > +	while (addr < end) {
> > +		unsigned long size;
> > +		unsigned int level;
> > +		pte_t *pte;
> > +
> > +		pte = lookup_address(addr, &level);
> > +		size = page_level_size(level);
> > +
> > +		if (pte && pte_decrypted(*pte)) {
> > +			int pages = size / PAGE_SIZE;
> > +
> > +			/*
> > +			 * Touching memory with shared bit set triggers implicit
> > +			 * conversion to shared.
> > +			 *
> > +			 * Make sure nobody touches the shared range from
> > +			 * now on.
> > +			 */
> > +			set_pte(pte, __pte(0));
> > +
> 
> Format the below into a comment here:
> 
> /* 
> 
> The only thing one can do at this point on failure is panic. It is
> reasonable to proceed, especially for the crash case because the
> kexec-ed kernel is using a different page table so there won't be
> a mismatch between shared/private marking of the page so it doesn't
> matter.

Page tables would not make a difference here. We will switch to identity
mappings soon. And kexec-ed kernel will build new page tables from
scratch.

I will drop the part after "It is reasonable to proceed".


-- 
  Kiryl Shutsemau / Kirill A. Shutemov

