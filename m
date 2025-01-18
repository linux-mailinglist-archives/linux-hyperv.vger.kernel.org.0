Return-Path: <linux-hyperv+bounces-3720-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C89A15E03
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Jan 2025 17:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB961884CCA
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Jan 2025 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D501A238C;
	Sat, 18 Jan 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTMUt138"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA419F485;
	Sat, 18 Jan 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737217240; cv=none; b=EQOpd5l1ySZO1YMlBS5XNRSzThzjeHJlL3GhoV86gZRS2rjZlVWQbboM4EtlkKYFPOMlHAbWB1lSPdCXF20cxGA3NIyLoJ5pPoz/Cv573Mp6qTKA45MUC1grY+/4DBW37hAIauEFppgZ7rsYQjsXxh13aBrufUFppJF+fR789hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737217240; c=relaxed/simple;
	bh=E1T9oqD8aJVCIjrPRbuov/XGWcAKXN4X1EoJY6MK4Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUZ+Bs+owN6qruCVn0J8DO+lN0j6zz8MlxXtQR9nAd7v7hEJlZjgcLTAC68+LpPq5w3teaTNYkZ6cICh/JvABnvwLxlPnhsU5EfOD8rQcFukguTit1xMXsM4UOSVCUd3md5GWSOcER+sluBUT/gcuxY5t+WedMCrFV/tWvs0WZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTMUt138; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737217239; x=1768753239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E1T9oqD8aJVCIjrPRbuov/XGWcAKXN4X1EoJY6MK4Lo=;
  b=hTMUt138pOG4JK31sNECeBmBYWEhVFzUTmsszVnLlD33AWLGygVZ7bCM
   YDf9OmK3LiN8qt69BIPTthz9gI5NLQ3YeooEm/ll9ywiBQmEQ5lc+SiBk
   ccdgYOr66frux/HOI6SOLxlZpCrYDu4HYTGyxXu5ybNSV8q/EUyOJtRL3
   XYDVv21/Mt0vAfCmsWkqGU/BDAi4UK5jP7kEADXT8uncsHomj9LZfATQA
   hk+h8CC37hEOzBqikQP7e7KrpCNCQxxR3fo9PlZ2R6VHwf+c4kMNO94b5
   O4+Su+/soKrr+hhGUltg6j5kaQf/uQ5qKq3arLd8S70gjS9oQjX0cbd16
   g==;
X-CSE-ConnectionGUID: eRH9XmFtQU+epToKoThO4Q==
X-CSE-MsgGUID: oGL/JNS6Ssi52g7vG/0Xpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11319"; a="41396066"
X-IronPort-AV: E=Sophos;i="6.13,215,1732608000"; 
   d="scan'208";a="41396066"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2025 08:20:38 -0800
X-CSE-ConnectionGUID: EP1rpWieRcyhDE1ZqeJpzQ==
X-CSE-MsgGUID: POYbcqp9SPq7LIs2y2kuFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,215,1732608000"; 
   d="scan'208";a="111069483"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 18 Jan 2025 08:20:35 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZBYl-000Ubl-2X;
	Sat, 18 Jan 2025 16:20:31 +0000
Date: Sun, 19 Jan 2025 00:19:39 +0800
From: kernel test robot <lkp@intel.com>
To: Roman Kisel <romank@linux.microsoft.com>, bp@alien8.de,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mingo@redhat.com, ssengar@linux.microsoft.com, tglx@linutronix.de,
	wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	apais@microsoft.com, benhill@microsoft.com, sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: Re: [PATCH hyperv-next 2/2] x86/hyperv: VTL mode callback for
 restarting the system
Message-ID: <202501182304.lZJpR7pL-lkp@intel.com>
References: <20250117210702.1529580-3-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117210702.1529580-3-romank@linux.microsoft.com>

Hi Roman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2e03358be78b65d28b66e17aca9e0c8700b0df78]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Kisel/x86-hyperv-VTL-mode-emergency-restart-callback/20250118-050923
base:   2e03358be78b65d28b66e17aca9e0c8700b0df78
patch link:    https://lore.kernel.org/r/20250117210702.1529580-3-romank%40linux.microsoft.com
patch subject: [PATCH hyperv-next 2/2] x86/hyperv: VTL mode callback for restarting the system
config: x86_64-buildonly-randconfig-003-20250118 (https://download.01.org/0day-ci/archive/20250118/202501182304.lZJpR7pL-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250118/202501182304.lZJpR7pL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501182304.lZJpR7pL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/hyperv/hv_vtl.c:48:46: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
      48 | static void  __noreturn hv_vtl_restart(char *)
         |                                              ^
   1 warning generated.


vim +48 arch/x86/hyperv/hv_vtl.c

    46	
    47	/* The only way to restart is triple fault */
  > 48	static void  __noreturn hv_vtl_restart(char *)
    49	{
    50		hv_vtl_emergency_restart();
    51	}
    52	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

