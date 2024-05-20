Return-Path: <linux-hyperv+bounces-2197-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26938C9B69
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 12:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920691F2242E
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A64543AA1;
	Mon, 20 May 2024 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fd6EO12v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70E50286;
	Mon, 20 May 2024 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201363; cv=none; b=SH1KsHTU75XqNRkfp6MuDlY1g5LpcLgHgYHktJcfHrnP+FJOjfkr9XwFUBzxVk1PyMR2WpuDOpf8JK9nG1D1U8kMX5g70RswSs8fF3qy49EiIt1iv5Sg44KIFjOcOZt3J51vbdjbXUY2IP6JyP15dylcZD8XX50GUIEkAnnppBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201363; c=relaxed/simple;
	bh=syda7rkpQQnrGgjV/E2QmFzu1fbgMQWQf+ASj41Ru3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAbBrwvuIEQu1JOv9ZYj+mwtJiFXi/OK9aFLOJuADH/kBJAHNuvndK3NXs3hYKCMxf+7bsqbj5D1Sq6mNxS34R+8/JH45ZfcBU5mTUCBrAV8cm+90inGL/EoO40AW3LyQMpYE3RLaHCnHLnYV6NRTSKqCiWUvZu2EajwUQ5KKUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fd6EO12v; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716201362; x=1747737362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=syda7rkpQQnrGgjV/E2QmFzu1fbgMQWQf+ASj41Ru3Q=;
  b=fd6EO12vUbH3Q10DNh6OqvHz775rCIHYHxjQKGFYyC6PuxRXUbitHikd
   j2wcKPOmi3YFzhC42S0VNuB8Q2sEObrumBhN7PhI0J2h5DoJkZ1YOsWkq
   sr5ThtAuzxSy9zZw10YvTSrHnobvUUidUtPiP9vrDjZbij5Ug2yXd8y1T
   hy5YyoOR947HWgYW7vU0QmOfIxFvVzl6HWqCAgeN066BIlFqSUOWfHxBJ
   +iXhkgOTGyUT6DoGNbKQnY7rVreYIw3X2sBzqEH/y/tOfsCKUD5pHZfiJ
   40qJ6TeZVrOTCLku7d4A3sIGwYpicpGsukPXS34h2ik5792o+qLPUZoT4
   w==;
X-CSE-ConnectionGUID: fHAW2mC7Sl+gO1OujUAv+w==
X-CSE-MsgGUID: dkGsCD1rS/K60+A+rrqOzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="34836384"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="34836384"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 03:36:01 -0700
X-CSE-ConnectionGUID: 46FNNeaMSFGrbq2vToqboA==
X-CSE-MsgGUID: q8r12nkES3agOfd9DnoX6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32624402"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 20 May 2024 03:35:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 206232AD; Mon, 20 May 2024 13:35:56 +0300 (EEST)
Date: Mon, 20 May 2024 13:35:56 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 02/20] x86/tdx: Add macros to generate TDVMCALL wrappers
Message-ID: <je6a3ftfcfwhiz26kcy5wkcini6mfjd7czrvmyn245hzbb7aeb@53hvyzvjgzip>
References: <20240517141938.4177174-1-kirill.shutemov@linux.intel.com>
 <20240517141938.4177174-3-kirill.shutemov@linux.intel.com>
 <58b02adc-7389-4fcd-a443-1856af7886b7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b02adc-7389-4fcd-a443-1856af7886b7@redhat.com>

On Fri, May 17, 2024 at 06:54:15PM +0200, Paolo Bonzini wrote:
> On 5/17/24 16:19, Kirill A. Shutemov wrote:
> > Introduce a set of macros that allow to generate wrappers for TDVMCALL
> > leafs. The macros uses tdvmcall_trmapoline() and provides SYSV-complaint
> > ABI on top of it.
> 
> Not really SYSV-compliant, more like "The macros use asm() to call
> tdvmcall_trampoline with its custom parameter passing convention".

Sounds better, thanks.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

