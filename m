Return-Path: <linux-hyperv+bounces-11186-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO+MGt82FGpuKwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11186-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 13:47:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9205CA277
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 13:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 449C3302E90E
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 11:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E933C37F8C3;
	Mon, 25 May 2026 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWJaSFdA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECBC37FF5F;
	Mon, 25 May 2026 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779709443; cv=none; b=dt8J6IeK/RU0u7tlh2HWTzie6N/5Ktxdc9q6hO+v1zof3bFtHbiJRtzHc91GBhBhyvHP1us78zlf1aTHunrCIlRUwD8teUBf/M4yBYaIHNDbRwMrR+h0f3SwVyIN88TSDb6EYtaH7+HAGz8G/Kq8fRxV80EvbGkIbRwLqN7vJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779709443; c=relaxed/simple;
	bh=WecPQJfCrErCiVESIdsqsyUdYnPBMpehDox7J972gPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+xQ77G3qaYTVU+gDfEe/vJRBxuC8zBiimQ0pv8DUTULHicaVj5OXKASo2mjGzLFnm951nKN/ete7qmJhs9c3HI4+2C3pu09/mEGXvxknwZbzWLAtYUe9sL8ZjBFd9oRAYP47+WmShoIXf+zbMgcanVxWXXMM3UlTaKryWBj0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWJaSFdA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779709441; x=1811245441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WecPQJfCrErCiVESIdsqsyUdYnPBMpehDox7J972gPE=;
  b=NWJaSFdAnfztwyxmO8qr8t8ll28H/aqB0dgJhrQprlHaYXYyjTN9UrN8
   3l2z9ZOAgqAw8PeOy8OFzMEKsQQ9dAJDt3jT4LFMzHJjjHlW87epnSlQd
   ZyGRo5psLCsV7MD0QWLMp0ZRUep3omQzaQZroPFX471ruvKB794/hFen6
   mq+civkBes4cXKzFn6UshwAvToh9LvGHTp3sccuRpZTIdUEp88s9HKQKI
   WhTBB2ngEqXVHnzZjGhzxTbA1UUxeBCa/6ctzXY7eVu/MJDgCJnzrSIsj
   aZjiZyRAcORD8V/uJJpMCbokBELsXHwXbasdvsqtB/vEsaKOrMs8R4Raq
   g==;
X-CSE-ConnectionGUID: LAt7DdmfQT++CZOjw1L9zg==
X-CSE-MsgGUID: dVflHA2VQI6iMO06UBtQJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="84381702"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="84381702"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 04:43:59 -0700
X-CSE-ConnectionGUID: UcMbxQW7Sw2/vc+29vukHQ==
X-CSE-MsgGUID: cfo44RCpSy+bKieFXbF9JQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 May 2026 04:43:55 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wRTiq-000000001QI-1Msq;
	Mon, 25 May 2026 11:43:52 +0000
Date: Mon, 25 May 2026 19:42:54 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Kelley <mhklkml@zohomail.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] x86/hyperv: Refactor hv_smp_prepare_cpus()
Message-ID: <202605251945.TesslTvF-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11186-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,git-scm.com:url,01.org:url]
X-Rspamd-Queue-Id: BF9205CA277
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
config: x86_64-randconfig-076-20260524 (https://download.01.org/0day-ci/archive/20260525/202605251945.TesslTvF-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260525/202605251945.TesslTvF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605251945.TesslTvF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hv/hv_proc.c:303:55: error: call to undeclared function 'cpu_physical_id'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     303 |                 ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));
         |                                                                     ^
   1 error generated.

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

