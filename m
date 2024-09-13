Return-Path: <linux-hyperv+bounces-3012-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F08978652
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2024 19:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5542823A6
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2024 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA3F7DA64;
	Fri, 13 Sep 2024 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YC61bJFt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7E6BB4B;
	Fri, 13 Sep 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246933; cv=none; b=g1g9Ibd038k0k/ekq95BKvtKOj+m2cpiefA3UQJAFzvH/VccS7aSkTovJtiYn2zMab5IDeuOYUWpemdQfciqonjLnJnpuTfEcGRLsUzR8b66HIRMyxX6rmu1SAtjtO+tOp85kgzPTYdVlUHQgC5OwbEUH6jG3Ifn02cnTReZswo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246933; c=relaxed/simple;
	bh=iU+uC45aK3oxV1shXS6vt5137cEYJgyIhw/8iZFvqHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dukijcysQEi1noGOZmJiA3a75/4H283rvsyYJno50zFmuQEyyReQBp5iPmNB1umFXDmhBsEM+kHONSnDkQnf1yTfJ7jkCwpw4Yfk9FmoE2qK83KhghfOPg+9Qa65lHSqMXJgnsWCsjC7XQG1ETCP8sslH6jGYoHgmyt3F+woHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YC61bJFt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726246932; x=1757782932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iU+uC45aK3oxV1shXS6vt5137cEYJgyIhw/8iZFvqHc=;
  b=YC61bJFtDbc7pNw8YMKfP20CmUK83nhYZneQV+19cs9dF25CYJT+oz92
   1+VcojxywW52QxgOARwMZqo9QhvME1PEmn1aCus910XQ2K3D+2o07ZE52
   uzjkD/oS4rsJrIp6orJrQEAjoX47QPQgWaazTAmR+rjkA17TpCd5VKzuQ
   BBpHq1a71+vnboZSnDgN+Cj9iTDi2Ao2OgNnp+P+KboHzMpYhqhbHbDd4
   +rbJY4+T0HnxBOjyD/MdT3+Dh/BJrrUFwccmd4TLPan7njLBEPOMPefxV
   ckrNVbskJ0mr2i5k2DdQzfglBqD4+BK+QFcWt7sVgDHGtDqa15g3sJg+0
   Q==;
X-CSE-ConnectionGUID: +RljoJbhQReXe9iqunD4og==
X-CSE-MsgGUID: +lkJMYGGQpagOtAW1a500g==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="13515309"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="13515309"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:02:11 -0700
X-CSE-ConnectionGUID: AGhsvv91SAiQc4j9Az2hlw==
X-CSE-MsgGUID: JmSBjxDHRLuUjUB61DfkmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="98972511"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Sep 2024 10:02:08 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sp9gL-0006im-28;
	Fri, 13 Sep 2024 17:02:05 +0000
Date: Sat, 14 Sep 2024 01:01:55 +0800
From: kernel test robot <lkp@intel.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com,
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
Message-ID: <202409140042.imFE8dSL-lkp@intel.com>
References: <1726176470-13133-2-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726176470-13133-2-git-send-email-ernis@linux.microsoft.com>

Hi Erni,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on dtor-input/next dtor-input/for-linus linus/master v6.11-rc7 next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Erni-Sri-Satya-Vennela/Drivers-hv-vmbus-Disable-Suspend-to-Idle-for-VMBus/20240913-053127
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/1726176470-13133-2-git-send-email-ernis%40linux.microsoft.com
patch subject: [PATCH 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
config: x86_64-randconfig-161-20240913 (https://download.01.org/0day-ci/archive/20240914/202409140042.imFE8dSL-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409140042.imFE8dSL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409140042.imFE8dSL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hv/vmbus_drv.c:985:20: error: use of undeclared identifier 'vmbus_freeze'
     985 |         .suspend_noirq  = vmbus_freeze,
         |                           ^
   drivers/hv/vmbus_drv.c:1913:42: warning: shift count >= width of type [-Wshift-count-overflow]
    1913 |         dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
         |                                                 ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   1 warning and 1 error generated.


vim +/vmbus_freeze +985 drivers/hv/vmbus_drv.c

   973	
   974	/*
   975	 * Note: we must use the "noirq" ops: see the comment before vmbus_bus_pm.
   976	 *
   977	 * suspend_noirq/resume_noirq are set to NULL to support Suspend-to-Idle: we
   978	 * shouldn't suspend the vmbus devices upon Suspend-to-Idle, otherwise there
   979	 * is no way to wake up a Generation-2 VM.
   980	 *
   981	 * The other 4 ops are for hibernation.
   982	 */
   983	
   984	static const struct dev_pm_ops vmbus_pm = {
 > 985		.suspend_noirq  = vmbus_freeze,
   986		.resume_noirq	= NULL,
   987		.freeze_noirq	= vmbus_suspend,
   988		.thaw_noirq	= vmbus_resume,
   989		.poweroff_noirq	= vmbus_suspend,
   990		.restore_noirq	= vmbus_resume,
   991	};
   992	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

