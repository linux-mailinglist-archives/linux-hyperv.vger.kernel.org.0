Return-Path: <linux-hyperv+bounces-7400-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A9AC29016
	for <lists+linux-hyperv@lfdr.de>; Sun, 02 Nov 2025 15:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14A194E1BAD
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Nov 2025 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A0821773D;
	Sun,  2 Nov 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1yrFrh9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA772610;
	Sun,  2 Nov 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762092860; cv=none; b=jyLgPv9AxpWNM0jExK8gij6CWjU1/ezNUE0IABFmehOnPM0l2qq9OpX/Jstg+yAKJvdf5Vw23z8xgXIAiQOzQ71pMq1SRoMddzORY90JF5PAro4PdYSjOCjRjEya1JspP7IxoYv0EVIIYECPjwA7Ad1g85AjD+UWcv6MfwLKOaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762092860; c=relaxed/simple;
	bh=37V5674L4iSlmwmX1WKaEKq5LWlrQ37iJ549idwApFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6rzmfUHKQFLI1lQ+icNK2GPy6DSeyJFSZO8d5b5iCTiDOst2iFBBltunRZ2agVTDpWvna00tQibySQqvZKnjstjh9UdRGRTsdLtUMdI7LL4QUuM+Ykw2wvE5C6NbT9FINKYaAoMh1g4+eNc6pEeV0tUJQD9FqmOpeVKGVCVjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1yrFrh9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762092859; x=1793628859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=37V5674L4iSlmwmX1WKaEKq5LWlrQ37iJ549idwApFg=;
  b=N1yrFrh9wnJzA/YG8Sz/2xW/qnM6joMnCI+8uOtQ2X0krLavWf+syrVw
   S1yk33Q7nfidJ7xDsJsjQ7Sx/jvns3OKZSe9uzYXSHdoY91X7oEUQZeLO
   IP+bvmidVT71Pgq2fB+CC6eG39luqvxUBKBbMB9oKPCjcY+Z8pJ8sbuxb
   4nGWRHyiR9lDUbV4N6GlqCX1h5xxGXy8OsHQrzxdtJ8Apn/lle5nUExcB
   JLgblwmWL9HBnwY6FcadLQUYjyTzpqxkovmC27RM/S64a1PF0/ouUDmsY
   twnlpb9dLaYGerR/yhr1QNBeMlRJJM2qLHZY8STKRyIajE/roaC+OQSg5
   g==;
X-CSE-ConnectionGUID: dhyz7f8DRS+C+iGIycW/lA==
X-CSE-MsgGUID: EN7mRigVSiCTK1syxjUqKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="64285538"
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="64285538"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 06:14:18 -0800
X-CSE-ConnectionGUID: hHrgI88dRcO1f3ZEFdjbBA==
X-CSE-MsgGUID: ctZC3L/uT3O2PD1m6SSX4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="186533464"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 02 Nov 2025 06:14:14 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFYqS-000PIW-26;
	Sun, 02 Nov 2025 14:14:12 +0000
Date: Sun, 2 Nov 2025 22:13:42 +0800
From: kernel test robot <lkp@intel.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	muislam@microsoft.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com, romank@linux.microsoft.com,
	Jinank Jain <jinankjain@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: Re: [PATCH v2] mshv: Extend create partition ioctl to support cpu
 features
Message-ID: <202511022246.Tn2DmYLd-lkp@intel.com>
References: <1761860431-11208-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761860431-11208-1-git-send-email-nunodasneves@linux.microsoft.com>

Hi Nuno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.18-rc3 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Das-Neves/mshv-Extend-create-partition-ioctl-to-support-cpu-features/20251031-054134
base:   linus/master
patch link:    https://lore.kernel.org/r/1761860431-11208-1-git-send-email-nunodasneves%40linux.microsoft.com
patch subject: [PATCH v2] mshv: Extend create partition ioctl to support cpu features
config: arm64-randconfig-001-20251102 (https://download.01.org/0day-ci/archive/20251102/202511022246.Tn2DmYLd-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251102/202511022246.Tn2DmYLd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511022246.Tn2DmYLd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hv/mshv_root_main.c:1875:47: warning: unused variable 'disabled_xsave' [-Wunused-variable]
    1875 |         union hv_partition_processor_xsave_features *disabled_xsave;
         |                                                      ^~~~~~~~~~~~~~
   1 warning generated.


vim +/disabled_xsave +1875 drivers/hv/mshv_root_main.c

  1864	
  1865	static_assert(MSHV_NUM_CPU_FEATURES_BANKS <=
  1866		      HV_PARTITION_PROCESSOR_FEATURES_BANKS);
  1867	
  1868	static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
  1869						struct hv_partition_creation_properties *cr_props,
  1870						union hv_partition_isolation_properties *isol_props)
  1871	{
  1872		int i;
  1873		struct mshv_create_partition_v2 args;
  1874		union hv_partition_processor_features *disabled_procs;
> 1875		union hv_partition_processor_xsave_features *disabled_xsave;
  1876	
  1877		/* First, copy orig struct in case user is on previous versions */
  1878		if (copy_from_user(&args, user_arg,
  1879				   sizeof(struct mshv_create_partition)))
  1880			return -EFAULT;
  1881	
  1882		if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
  1883		     args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
  1884			return -EINVAL;
  1885	
  1886		disabled_procs = &cr_props->disabled_processor_features;
  1887	
  1888		/* Disable all processor features first */
  1889		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
  1890			disabled_procs->as_uint64[i] = -1;
  1891	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

