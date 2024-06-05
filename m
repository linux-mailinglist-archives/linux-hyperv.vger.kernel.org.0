Return-Path: <linux-hyperv+bounces-2322-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2679D8FCE55
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2024 15:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9A21C24A4E
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2024 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACE41D3653;
	Wed,  5 Jun 2024 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iG0rIBEp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFDD1D3651;
	Wed,  5 Jun 2024 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590111; cv=none; b=W0wP7zMQTjqdhUaOWy4b6OiJiAKqhwgVR5+mN+Y1ODkuDyEJFGES3fEJeY9uiA7Yv2rYIopZITR8ECyNvghazXmGZKZPtqCWNLMSbhE2vHdghPmL0m66FU+htjI+cc/oSIMDrmYyMduPCkrYQhNmk6eWU7e56O4VfOIbZt2vJD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590111; c=relaxed/simple;
	bh=UHHCuXxgr4YI01SKxX+c/bFPiTRBKJKPTARrf8CN9LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdsIykdupdVCNw6FTES+pylz9Nf0ZH9DzubP46R3AWUjGvKEZUeYE3TwV+BJ2/6V/T7h/BVyGcZqKjks3C32K2EvPW/tYPH+08Yng6CEEZ6kJFEviEdxHKS3OdvVpmSZxnN0Xn+RGKxoOtBvVje7i8z8MxtrHVS9yhsw/zEVq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iG0rIBEp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717590110; x=1749126110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UHHCuXxgr4YI01SKxX+c/bFPiTRBKJKPTARrf8CN9LM=;
  b=iG0rIBEpIqDlSNQ9xy3z1IUpZZhOjEOJQCLm3JOytg0QVLRLQTKMzy2t
   t08zE4bJupjrd4JEbQaDqlHiH4FIqfOp202xa1S4tadLX0Gwn7geVSIao
   M5OWxzym+YJjExTula0L2GSIAjTYMBqUJvYE5MSRrVfrtF3sADX6uomuS
   KTuUUKRSCZqwH9yJxgYnhGNk053Vog63ruOcPFRtkoOmObZzsotwTNUye
   smGS8SWdc06j9HrXqTAo6+TOdRCu8Q0JzBPsx1YWuyNr9PVnWvb4SSDXg
   rgXikCBVulhxt+d1mgODtQA+dWSumAv1TyfrVg4g/nmZs+Tn0C4cQgj/f
   w==;
X-CSE-ConnectionGUID: JP5Hg7PqSwC7Qq2DAG/WFA==
X-CSE-MsgGUID: BiSN2J+PSLq+MZpHu1INXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13998764"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="13998764"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 05:21:49 -0700
X-CSE-ConnectionGUID: CApkPYYZQBC0yiDEy7bMSw==
X-CSE-MsgGUID: 1fIP69SpRjaarDLU3PYGpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="68714614"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 05 Jun 2024 05:21:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5E1A81B6; Wed, 05 Jun 2024 15:21:42 +0300 (EEST)
Date: Wed, 5 Jun 2024 15:21:42 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>, adrian.hunter@intel.com, 
	ardb@kernel.org, ashish.kalra@amd.com, bhe@redhat.com, 
	dave.hansen@linux.intel.com, elena.reshetova@intel.com, haiyangz@microsoft.com, hpa@zytor.com, 
	jun.nakajima@intel.com, kai.huang@intel.com, kexec@lists.infradead.org, 
	kys@microsoft.com, linux-acpi@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, ltao@redhat.com, mingo@redhat.com, 
	peterz@infradead.org, rafael@kernel.org, rick.p.edgecombe@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	x86@kernel.org
Subject: Re: [PATCHv11.1 11/19] x86/tdx: Convert shared memory back to
 private on kexec
Message-ID: <alkew673cceojzmhsp3wj43yv76cek5ydh2iosfcphuv6ro26q@pj6whxcoetht>
References: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
 <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
 <noym2bqgxqcyhhdzoax7gvdfzhh7rtw7cv236fhzpqh3wqf76e@2jj733skv7y4>
 <78d33a31-0ef2-417b-a240-b2880b64518e@intel.com>
 <u3hg3fqc2nxsjtfugjmmzlahwriyqlebnkxrbzgrxlkj6l3k36@yd3yudglgevi>
 <20240604180554.GIZl9XgscEI3PUvR-W@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604180554.GIZl9XgscEI3PUvR-W@fat_crate.local>

On Tue, Jun 04, 2024 at 08:05:54PM +0200, Borislav Petkov wrote:
> On Tue, Jun 04, 2024 at 07:14:00PM +0300, Kirill A. Shutemov wrote:
> > 			/*
> > 			 * If tdx_enc_status_changed() fails, it leaves memory
> > 			 * in an unknown state. If the memory remains shared,
> > 			 * it can result in an unrecoverable guest shutdown on
> > 			 * the first accessed through a private mapping.
> 
> "access"

Okay.

> So this sentence above can go too, right?

I don't think so.

> Because that comment is in tdx_kexec_finish() and we're basically going
> off to kexec. So can a guest even access it through a private mapping?
> We're shutting down so nothing is running anymore...

This kernel can't. But the next kernel can.

If a page can be accessed via private mapping is determined by the
presence in Secure EPT. This state persist across kexec.

> > 			 * The kdump kernel boot is not impacted as it uses
> > 			 * a pre-reserved memory range that is always private.
> > 			 * However, gathering crash information could lead to
> > 			 * a crash if it accesses unconverted memory through
> > 			 * a private mapping.
> 
> When does the kexec kernel even get such a private mapping? It is not
> even up yet...

Crash kernel provides access to this memory via /proc/vmcore. Crash kernel
will assume all memory there is private.

> > 			 * pr_err() may assist in understanding such crashes.
> 
> "Print error info in order to leave bread crumbs for debugging." is what
> I'd say.

Okay.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

