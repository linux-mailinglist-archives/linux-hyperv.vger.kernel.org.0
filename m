Return-Path: <linux-hyperv+bounces-2398-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A75D904F31
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 11:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76891F26978
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8763516E882;
	Wed, 12 Jun 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ji0uTgrt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37C16D9DD;
	Wed, 12 Jun 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184280; cv=none; b=bFN+0Zpi67qI1sc3mL4+WHIzvphudTbeYvHIXbC+Gl85JQZD9qmd+vRlQ+AhHwA/t7esb6po/x98tevAin6EJZrxA8tEiFz89nMEtfVkd49qpwAJwJ1dgf2l59XUY3AUClZh/sHYYibRDL/qsgMa3xXPqi9zwC1Frn/pb9dWnUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184280; c=relaxed/simple;
	bh=Qea/Jn12txiTuu1sQzZhiztNW21tvwMqG/CoQdaTdLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDBZ0n2OvfyX8USNNj0Ua3FSuMI9+tkKT4wBiAr5aO0I3Xu5zXp581j1eNWhdc84tncfRaZ2nYljlm/mbTcHK7agTVC6MMurU3xZE1koCXGb2HBoVgdhwYN40s8THIYBZWvm1A7GQVkXleS4NCqQwSr7fbz01E4YpTDlcdMj6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ji0uTgrt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718184279; x=1749720279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qea/Jn12txiTuu1sQzZhiztNW21tvwMqG/CoQdaTdLE=;
  b=Ji0uTgrtXzmB9eNKa9GjDTeC4+2EBQfjyduHVY9emfybV/mj76BUDE0o
   iOiBJ2EaVjI9KjNMuG2TlZ9L0Y5ReTN4x+/3jww8GXYALrkYZKYRIZIcI
   GbIFq4PPmABUzaf1FtvXIjvbAooRIvJxZ7IYuv9pX8WujYuLgevxyZZPO
   IB9KIuftEGEkYIk3FQ8bfbhyV/RazxwtnI4jLgAs977ecxCJBF1SY0eeQ
   fYZU+hwwLxqVLwaoI1WlVvgmN0wZYFv9vYuWw/kZq4PxOqB2t4HUiVaE2
   95Y4mg9/8xEH0IJhPGAtnWEN/E+G9Ja+KcDdblZUPscPnsyCTHdU2GjKI
   A==;
X-CSE-ConnectionGUID: 4kNUjFavRPehjHlHehY0rg==
X-CSE-MsgGUID: /U+stWlcRDmLh/GENKu0uQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15166827"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15166827"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 02:24:38 -0700
X-CSE-ConnectionGUID: i2TjnqRFRByO99lPQ1rpLg==
X-CSE-MsgGUID: 3Cah0xaYTqG0k8+PVw92kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="40201459"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 12 Jun 2024 02:24:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 195CE193; Wed, 12 Jun 2024 12:24:30 +0300 (EEST)
Date: Wed, 12 Jun 2024 12:24:30 +0300
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
Message-ID: <2kc27uzrsvpevtvos2harqj3bgfkizi5dhhxkigswlylpnogr5@lk6fi2okv53i>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
 <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
 <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
 <20240611194653.GGZmiprSNzK0JSJL17@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611194653.GGZmiprSNzK0JSJL17@fat_crate.local>

On Tue, Jun 11, 2024 at 09:46:53PM +0200, Borislav Petkov wrote:
> On Tue, Jun 11, 2024 at 06:47:05PM +0300, Kirill A. Shutemov wrote:
> > Borislav, given this code deduplication effort is not trivial, maybe we
> > can do it as a separate patchset on top of this one?
> 
> Sure, as long as it gets done and doesn't get delayed indefinitely by
> new and more important features enablement.

I will try to deliver it in timely manner.

> Usually, we do unifications and cleanups first - then new features but
> this kexec pile has been long in the making already...
> 
> > I also wounder if it makes sense to combine ident_map.c and
> > set_memory.c.  There's some overlap between the two.
> 
> Yeah, we have a bunch of different pagetable manipulating things, all
> with their peculiarities and unifying them and having a good set of APIs
> which everything else uses, is always a good thing.

Will give it a try.

> And since we're talking cleanups, there's another thing I've been
> looking at critically: CONFIG_X86_5LEVEL. Maybe it is time to get rid of
> it and make the 5level stuff unconditional. And get rid of a bunch of
> code since both vendors support 5level now...

Can do.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

