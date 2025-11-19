Return-Path: <linux-hyperv+bounces-7705-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A6745C70959
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 19:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F39B9351FF6
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA03B3101C4;
	Wed, 19 Nov 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDJrTc39"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9A3115B1;
	Wed, 19 Nov 2025 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763575590; cv=none; b=BCITVf9NL4MaI1CW+916BjGP8B82O1cgGLlz4KCwW69Ds5/TODkfzeVn78LC06YZRjmSdV0RpDaKGsGfw/s4HeT0OHKHsVouFqo8ng/RpVUQEg/EjyNDR8An9mVo6YyNJ0lDQapPrE5YMglVBTcn6FFxJteOXV1t7K3J5qqXf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763575590; c=relaxed/simple;
	bh=/yMBB+YnKjaBihGQbwnxOGWlkUC7LbOZo1L3UYSKBMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWEZe8ALSjMnQ+ikTTjREj7GBsnM0Xk8rDATXlZj/lrv12dmdlSqYFvjwoyjnD1exq9VTlJbVqbCgjvYOZJyMr+g+kVLWvzYb8RBSgtLLE+XfJAtyW+xB9q+2ccm7Xks6abGm0XSRRdY1eeIRWY6HNQ2MWwm9+FRYB7IDgWyokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDJrTc39; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763575587; x=1795111587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/yMBB+YnKjaBihGQbwnxOGWlkUC7LbOZo1L3UYSKBMA=;
  b=QDJrTc39+bFJp5HBSJKlSJ5PAkAPakSeucXhc9bWJ+T+DQaWaxJsj13A
   T+J5nt5s7aX0fY8nVDhpF7Ydou9v78yqvdwEpMWUWBU5dYoq7gnl6nEMk
   ofDtJCixK714hAC4JYBJmwlW8RAMRVgRmUpDi/aEjaQG9RPhtPc8MeBjt
   e3wrQcMhzQuUCU+8uI8CmPo/cJv6zTcV6KoRbO//ZgOn3ztUmkW0WSNTa
   iVcd0A/w0pqhVHM/jc2X5iGsALCn+b9ticPT3OUEHMWeLlk8QizxaC/fo
   KBPY60uqhO5fS6ozGzyCHh9GtfGlXHK0N4NFQZYt0Ri5VIWdlGtRR9Bge
   w==;
X-CSE-ConnectionGUID: 6jzUCD8SRwmwOk5mLfXhxg==
X-CSE-MsgGUID: vkd6yoWUSCaCn26hbJGIQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="76239275"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="76239275"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 10:06:23 -0800
X-CSE-ConnectionGUID: OPmsxhofSCSAKIg8vcefKA==
X-CSE-MsgGUID: goYpJ1rcSM+xTA5MDtWOSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="228448157"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Nov 2025 10:06:21 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLmZO-0003A3-2j;
	Wed, 19 Nov 2025 18:06:18 +0000
Date: Thu, 20 Nov 2025 02:06:17 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com
Cc: oe-kbuild-all@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] Drivers: hv: Add support for movable memory
 regions
Message-ID: <202511200145.iDV1mUnj-lkp@intel.com>
References: <176339837995.27330.14240947043073674139.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176339837995.27330.14240947043073674139.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc6]
[cannot apply to next-20251119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Kinsburskii/Drivers-hv-Refactor-and-rename-memory-region-handling-functions/20251118-010501
base:   linus/master
patch link:    https://lore.kernel.org/r/176339837995.27330.14240947043073674139.stgit%40skinsburskii-cloud-desktop.internal.cloudapp.net
patch subject: [PATCH v6 5/5] Drivers: hv: Add support for movable memory regions
config: x86_64-randconfig-076-20251119 (https://download.01.org/0day-ci/archive/20251120/202511200145.iDV1mUnj-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511200145.iDV1mUnj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511200145.iDV1mUnj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/vdso/const.h:5,
                    from include/linux/const.h:4,
                    from include/uapi/linux/kernel.h:6,
                    from include/linux/cache.h:5,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/resume_user_mode.h:6,
                    from include/linux/entry-virt.h:6,
                    from drivers/hv/mshv_root_main.c:11:
   In function 'mshv_region_handle_gfn_fault',
       inlined from 'mshv_handle_gpa_intercept' at drivers/hv/mshv_root_main.c:742:9,
       inlined from 'mshv_vp_handle_intercept' at drivers/hv/mshv_root_main.c:755:10,
       inlined from 'mshv_vp_ioctl_run_vp' at drivers/hv/mshv_root_main.c:769:22,
       inlined from 'mshv_vp_ioctl' at drivers/hv/mshv_root_main.c:958:7:
>> include/linux/compiler_types.h:602:45: error: call to '__compiletime_assert_1093' declared with attribute error: BUILD_BUG failed
     602 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/uapi/linux/const.h:49:44: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                            ^
   include/vdso/align.h:9:33: note: in expansion of macro '__ALIGN_KERNEL'
       9 | #define ALIGN_DOWN(x, a)        __ALIGN_KERNEL((x) - ((a) - 1), (a))
         |                                 ^~~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:691:23: note: in expansion of macro 'ALIGN_DOWN'
     691 |         page_offset = ALIGN_DOWN(gfn - region->start_gfn,
         |                       ^~~~~~~~~~
   include/linux/compiler_types.h:590:9: note: in expansion of macro '__compiletime_assert'
     590 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:602:9: note: in expansion of macro '_compiletime_assert'
     602 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
         |                     ^~~~~~~~~~~~~~~~
   include/linux/huge_mm.h:113:28: note: in expansion of macro 'BUILD_BUG'
     113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
         |                            ^~~~~~~~~
   include/linux/huge_mm.h:117:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
     117 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
         |                          ^~~~~~~~~~~~~~~
   include/linux/huge_mm.h:118:26: note: in expansion of macro 'HPAGE_PMD_ORDER'
     118 | #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
         |                          ^~~~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:40:49: note: in expansion of macro 'HPAGE_PMD_NR'
      40 | #define MSHV_MAP_FAULT_IN_PAGES                 HPAGE_PMD_NR
         |                                                 ^~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:692:34: note: in expansion of macro 'MSHV_MAP_FAULT_IN_PAGES'
     692 |                                  MSHV_MAP_FAULT_IN_PAGES);
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~


vim +/__compiletime_assert_1093 +602 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  588  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  589  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  590  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  591  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  592  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  593   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  594   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  595   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  596   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  597   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  598   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  599   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  600   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  601  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @602  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  603  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

