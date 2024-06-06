Return-Path: <linux-hyperv+bounces-2333-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B838FE6B0
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2024 14:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18775B214EC
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2024 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E59195B0A;
	Thu,  6 Jun 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwRFQG9r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217A7195B08;
	Thu,  6 Jun 2024 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677595; cv=none; b=E0sM+3RWgBV2o5UxQFdzIUyOL+uNYw3KaYTliEL5o6lKItLEYkWBIdsNJ2MHGBCnZL61+nkW4sUcGvI32y+bPBg1qNBTB5X0poi7F9v4Pq27jK+1bnWFuLxtt4c5Np085xmUzzHL38wFrLVehoSnygBddavRLRhAWTQW5opZB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677595; c=relaxed/simple;
	bh=8j0QTwBVqBlEew+vXzNvM2j0bxIyUPIq7t89df/Ovig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOgF8CmHDcuLH9saR+cYsD50KdUhStJ9P1g/+luhkcOkNqLI9mx8hHHtVjPUCjMLos6MBbkExHFhhL7PWBsDGods08IkKv4oBkh55WABj7+O6PjLz31NxBRTskXUx6cvs+lG0qZgGS5JmWizciQEmvAIuGTQr60tK00qBOqoaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwRFQG9r; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717677594; x=1749213594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8j0QTwBVqBlEew+vXzNvM2j0bxIyUPIq7t89df/Ovig=;
  b=jwRFQG9rzCvzAebTGvIRpq64S4GhVy2/nx2NA5zPhxs7+qU2yDAkLDCK
   NLxR9AlfQ6T8R0al2BovCpH8qEL4tdcN026MB5gu5XxiG/TN2JlFcXuig
   wwTKS67tZfbxMBcv8sYvY1Aqhd2CVbtwNK8j0cZTBCbghEeRiauwDj1/T
   4xYA62szx7H7+JZvh6ReADssXT4bffhUMoGneJ+ZdtyfJ1T1WLGnVJXeK
   EK/BfTnOkq/nb9cupcd4ojzuwI1BvDc5BvBTpJa1B2xOmcH4HqgKXGRmu
   ozcciifKEgZF4hlMyC5q7I0jCVsaEMpNJPRfqGCD+IQrNsV3ya99lyfB9
   Q==;
X-CSE-ConnectionGUID: mg0+IGHyS52Mj63PWZvW0w==
X-CSE-MsgGUID: P5ETKNCfRBaPjk47uwqfOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="31839965"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="31839965"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 05:39:53 -0700
X-CSE-ConnectionGUID: uwimgMbWSnCttp4dnD+tsw==
X-CSE-MsgGUID: fBNz2Le5QS25iPTszSSU9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="37812017"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 06 Jun 2024 05:39:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E8F782A4; Thu, 06 Jun 2024 15:39:45 +0300 (EEST)
Date: Thu, 6 Jun 2024 15:39:45 +0300
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
Message-ID: <thox3qsdozhcl3xk5zmdjhz6xdkhhz6xefknj2ib427q4qw22q@uizbc32vuu55>
References: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
 <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
 <noym2bqgxqcyhhdzoax7gvdfzhh7rtw7cv236fhzpqh3wqf76e@2jj733skv7y4>
 <78d33a31-0ef2-417b-a240-b2880b64518e@intel.com>
 <u3hg3fqc2nxsjtfugjmmzlahwriyqlebnkxrbzgrxlkj6l3k36@yd3yudglgevi>
 <20240604180554.GIZl9XgscEI3PUvR-W@fat_crate.local>
 <alkew673cceojzmhsp3wj43yv76cek5ydh2iosfcphuv6ro26q@pj6whxcoetht>
 <20240605162419.GJZmCRM8V6xooyvm9H@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605162419.GJZmCRM8V6xooyvm9H@fat_crate.local>

On Wed, Jun 05, 2024 at 06:24:19PM +0200, Borislav Petkov wrote:
> On Wed, Jun 05, 2024 at 03:21:42PM +0300, Kirill A. Shutemov wrote:
> > If a page can be accessed via private mapping is determined by the
> > presence in Secure EPT. This state persist across kexec.
> 
> I just love it how I tickle out details each time I touch this comment
> because we three can't write a single concise and self-contained
> explanation. :-(
> 
> Ok, next version:
> 
> "Private mappings persist across kexec. If tdx_enc_status_changed() fails

s/Private mappings persist /Memory encryption state persists /

> in the first kernel, it leaves memory in an unknown state.
> 
> If that memory remains shared, accessing it in the *next* kernel through
> a private mapping will result in an unrecoverable guest shutdown.
> 
> The kdump kernel boot is not impacted as it uses a pre-reserved memory
> range that is always private.  However, gathering crash information
> could lead to a crash if it accesses unconverted memory through
> a private mapping which is possible when accessing that memory through
> /proc/vmcore, for example.
> 
> In all cases, print error info in order to leave enough bread crumbs for
> debugging."
> 
> I think this is getting in the right direction as it actually makes
> sense now.

Otherwise looks good to me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

