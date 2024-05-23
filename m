Return-Path: <linux-hyperv+bounces-2208-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350978CD1C3
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 May 2024 14:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628D5B21446
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 May 2024 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9DB13D256;
	Thu, 23 May 2024 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kU5uEFs+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B0413CF92;
	Thu, 23 May 2024 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465992; cv=none; b=pudvbgCJniIbZ+eL0waL8jGnFgIZEQBs3ePJ9NjDuDwNak6LO3OEMM4qNwlPloE56awQPX4GZGWehmQtz5z9UIh/L4LsXsyXikP0gqAEQWN9JR1kMHT1IVpHzOUVkF7g92aTbQIb5uYiUn69BltXRnJEyXF8bcIIZblb7KSe48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465992; c=relaxed/simple;
	bh=RsCi9zpX9ZWOnbJAJ30H+QRO1giMwJefX62MyVsW714=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqkxliKtDkjfH9rMCt1I3O9zjw0bM9A/5xjbQazoV9CFEwlEat5H1FoOo3VsjRU3IkE7igjBG4I1TSSGgZ/0F5UfBYQ9hqmz4PpAotvmpvhxYLGx//GZMY9CGkd/Sv5SodeCnRzeqAG3ErJtzpwl2YXkBk4yEjuKdFEwBC3LVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kU5uEFs+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716465991; x=1748001991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RsCi9zpX9ZWOnbJAJ30H+QRO1giMwJefX62MyVsW714=;
  b=kU5uEFs+VrC5+m6tyD1kV1m/Qh+8wXKjkB1HD7ifOho7++MfLPLdB+Yv
   FXhIdukDchj+jFHSR2VK8Je5dN+jseADKqpoAD2sqB6pVLb2YGICpHRFa
   hvli44+35pCga0cD14B2UwU0M6ta1CxU6EWcx2orm2jCdavzoh7wDRibB
   4L4D4J3hfgKO8ulVEyXxxe6qJhnCXy1nADO9VehiL/IMF+97AAXeAGuaf
   SW9I5IDxaXxXE304EZFWmLyMHnIQvMPDNi/VAWRZDlIdn7Dm3E+mL9xEm
   dY6TwTvE2+6yS8CqgUAYD5jXnc6M4yAz3+wDHJmmBajK3n78C8qvjOElc
   A==;
X-CSE-ConnectionGUID: Z3pH4CfES9GFDHa6xjJQ9Q==
X-CSE-MsgGUID: AFAjXgNpT3mtUSeSxcPoCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12609427"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="12609427"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 05:06:31 -0700
X-CSE-ConnectionGUID: dNRZz+K8R9Sl4I+hdoIOAA==
X-CSE-MsgGUID: EMuejiKDRSWP1TJHjJZKpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="38425148"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 23 May 2024 05:06:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 62D45E7; Thu, 23 May 2024 15:06:23 +0300 (EEST)
Date: Thu, 23 May 2024 15:06:23 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, bp@alien8.de, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, haiyangz@microsoft.com, 
	hpa@zytor.com, kys@microsoft.com, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de, 
	wei.liu@kernel.org, Jason@zx2c4.com, mhklinux@outlook.com, thomas.lendacky@amd.com, 
	tytso@mit.edu, ardb@kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com, 
	Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [RFC PATCH] clocksource: hyper-v: Enable the tsc_page for a TDX
 VM in TD mode
Message-ID: <7yos4yh6te7zcwga3swddpyjyxlif2c5vqad2rouwf7euw47df@jvouxfoakct6>
References: <20240523022441.20879-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523022441.20879-1-decui@microsoft.com>

On Wed, May 22, 2024 at 07:24:41PM -0700, Dexuan Cui wrote:
> A TDX VM on Hyper-V may run in TD mode or Partitioned TD mode (L2). For
> the former, the VM has not enabled the Hyper-V TSC page (which is defined
> in drivers/clocksource/hyperv_timer.c: "... tsc_pg __bss_decrypted ...")
> because, for such a VM, the hypervisor requires that the page should be
> shared, but currently the __bss_decrypted is not working for such a VM
> yet.

I don't see how it is safe. It opens guest clock for manipulations form
VMM. Could you elaborate on security implications?

> Hyper-V TSC page can work as a clocksource device similar to KVM pv
> clock, and it's also used by the Hyper-V timer code to get the current
> time: see hv_init_tsc_clocksource(), which sets the global function
> pointer hv_read_reference_counter to read_hv_clock_tsc(); when
> Hyper-V TSC page is not enabled, hv_read_reference_counter defaults to
> be drivers/hv/hv_common.c: __hv_read_ref_counter(), which is suboptimal
> as it uses the slow MSR interface to get the time info.

Why can't the guest just read the TSC directly? Why do we need the page?
I am confused.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

