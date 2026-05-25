Return-Path: <linux-hyperv+bounces-11180-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJHJKpD8E2qDIQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11180-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 09:38:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5511D5C7359
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 09:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1DCC3006689
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8553D3D11;
	Mon, 25 May 2026 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHhBi01h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7F3D25D8;
	Mon, 25 May 2026 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694728; cv=none; b=SdKQIdljEaTB3gpxc/dtBJ/Pj7aXIyQL/Qsbc4tbPhQ3FZRC2o4ZUCfvBpCg0AzE3f7rqZtV3OHO5JlFASxCRkT0QG0XtykohB5idY9b9t/gRz4LLxPBJiJrIXfpT24M7P4kylASEZ8mFYwdD6K1iX1gmHB9VRALRalOoGnM9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694728; c=relaxed/simple;
	bh=nKqtSJgxnHFTkrcccM59rL3lptufu+7u672ok4yxBsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXGUApAo98VkiWh0hiEpiJeLgxuz/3sCswzNRcpZ+mnLAaFn7tQfprvKwZ9l3JfLubhDpY8+R3RAIqzRK82hmOIcOrbWGCpmCBWL3xMGbcU18LtKSW0rZWzVkv6Gq0cjXTZ5HvFvXsL2ojn0/uEb9ZFevx7iJP6c7D+w9Bew6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHhBi01h; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779694727; x=1811230727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nKqtSJgxnHFTkrcccM59rL3lptufu+7u672ok4yxBsk=;
  b=hHhBi01h+5PmE7u54oZlQq8RfVf2CkrOddrX4f2+Iw/1vrzOLuk9edFj
   1qd/enxYpBG0xuuncWKjtS09+RQ0MOlbLZf4wY/Kb95ohn0xZAsFYJmK/
   BN0ycDTCrwlWAU9/LVm9EDLgKitjn/et56UHAY7gW2+yn+MyGd1eJ+oLa
   U+7O2PIAZcCnz+4Hpfo4/itkgl65p0osM4EZ/hC9QVwfQFiSzZMKu2Wjc
   D7QXRSndWjR5mZNsEWjLi+CuJgZ/ei8K5ST/U8KzsqO+DookkHXLSGrAF
   SUBcyIZns1wla0kHSgXeDENZBfKBEv054D42jfL5ZIt3/LYW34BFTHPFL
   g==;
X-CSE-ConnectionGUID: RdsJo093SdqjIVBqBXuC5w==
X-CSE-MsgGUID: 3I5xJYWDQ/CUSba6LQNPHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="80421634"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="80421634"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 00:38:46 -0700
X-CSE-ConnectionGUID: W8d7wfxhS7aM7UqGp73cXA==
X-CSE-MsgGUID: UgSqjgRhQfy95JyVj7Oa3A==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 May 2026 00:38:43 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wRPtX-000000001EM-3ZB2;
	Mon, 25 May 2026 07:38:39 +0000
Date: Mon, 25 May 2026 15:37:51 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Kelley <mhklkml@zohomail.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] x86/hyperv: Refactor hv_smp_prepare_cpus()
Message-ID: <202605251528.eVtKHPbX-lkp@intel.com>
References: <20260521192336.99623-1-mhklkml@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521192336.99623-1-mhklkml@zohomail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11180-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5511D5C7359
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/master]
[also build test ERROR on linus/master v7.1-rc5 next-20260522]
[cannot apply to tip/x86/core arnd-asm-generic/master tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Kelley/x86-hyperv-Refactor-hv_smp_prepare_cpus/20260522-032610
base:   tip/master
patch link:    https://lore.kernel.org/r/20260521192336.99623-1-mhklkml%40zohomail.com
patch subject: [PATCH 1/1] x86/hyperv: Refactor hv_smp_prepare_cpus()
config: x86_64-buildonly-randconfig-006-20260525 (https://download.01.org/0day-ci/archive/20260525/202605251528.eVtKHPbX-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260525/202605251528.eVtKHPbX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605251528.eVtKHPbX-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hv/hv_proc.c: In function 'hv_smp_prep_cpus':
>> drivers/hv/hv_proc.c:303:69: error: implicit declaration of function 'cpu_physical_id' [-Wimplicit-function-declaration]
     303 |                 ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));
         |                                                                     ^~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_STMFX
   Depends on [n]: HAS_IOMEM [=y] && I2C [=y] && OF [=n]
   Selected by [y]:
   - PINCTRL_STMFX [=y] && PINCTRL [=y] && I2C [=y] && HAS_IOMEM [=y]


vim +/cpu_physical_id +303 drivers/hv/hv_proc.c

   290	
   291	void hv_smp_prep_cpus(void)
   292	{
   293	#ifdef CONFIG_X86_64
   294		int i, ret;
   295	
   296		/* If AP LPs exist, we are in a kexec'd kernel and VPs already exist */
   297		if (num_present_cpus() == 1 || hv_lp_exists(1))
   298			return;
   299	
   300		for_each_present_cpu(i) {
   301			if (i == 0)
   302				continue;
 > 303			ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

