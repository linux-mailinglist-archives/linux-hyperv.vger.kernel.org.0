Return-Path: <linux-hyperv+bounces-3013-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D9F978710
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2024 19:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0391F21BC7
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2024 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D3579DC7;
	Fri, 13 Sep 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d19BrIOi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48282D83;
	Fri, 13 Sep 2024 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249455; cv=none; b=nO4x9/UglDMxlHyDXDu+vsM/js2jFP3fvMXLk7CiaoY11DQhZ33LbqNf0qbKrrv4c6N/anxSHSvJVX8XVgrheBM/NdoPI4SIBiTGo5MBAPORbVlaPp9mYFwN8qO9GojS6XfNitSxjZzAmXfg5CVr5O5ArYlyAsThdU1dYnx8bMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249455; c=relaxed/simple;
	bh=jGzGLS5jc1tgtr1VvrVQOwCVcOgKD27bW3hONB0me0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcA71fIYfz+/dRdFulUNRK+Cwypu5bpB1aVaTIR/SPDYycaSYThMkuSKpzwXKN/vYnuupqH/zGE/+aYjvTLmkkVMrdASnp/A0E4YdPpoWubNTf4C9uOeMM9kcfHFxVFhZl7m6kDbvezqYqoe9T6/xT81T65h8QwTZmUEx78damE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d19BrIOi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726249454; x=1757785454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jGzGLS5jc1tgtr1VvrVQOwCVcOgKD27bW3hONB0me0s=;
  b=d19BrIOiJWvB28tQvjgBwlX5DGQJL9gmcx6UewE0VmB3AgT5ZhpC+AC6
   oY91oDS2jWkn1n2SRa8+W7Y891B437rvgSibfIH5O81Y8StQMOTXqgxIl
   PFrA1Y8tLkUzp8aPfF8Nbinb9sCHZbLyz5hlfLBbVj/HgjQeRqcrTANNe
   FFX/ymiL+ZKlcu21qX//Ip6CTp1Wl3Cp0vqKdZIVoQLDbzIYi3ohETIoI
   UddVMWdufjHQeYolaRSM5y2cvJJZTk79a+N+y+ur4bsy/mm/IP3j4WLQh
   /cME/hyPlhWsXf7ZHj6cNiX+TolAECJFiVQxVuyp3rAF3tqXg9kWZ3q/6
   Q==;
X-CSE-ConnectionGUID: D8T5PTAtTjKyymi0V7ts4g==
X-CSE-MsgGUID: nY9kI+vqQwGXsAFxLkv5MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="35829380"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="35829380"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:44:13 -0700
X-CSE-ConnectionGUID: CpJnrJr1RpeKBeAlx1cR5Q==
X-CSE-MsgGUID: mnDRyL3fS8Kw/nImH3rKAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="67761067"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 13 Sep 2024 10:44:10 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spAL2-0006lY-0W;
	Fri, 13 Sep 2024 17:44:08 +0000
Date: Sat, 14 Sep 2024 01:43:10 +0800
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
Message-ID: <202409140137.5jZxplAp-lkp@intel.com>
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
config: i386-randconfig-003-20240913 (https://download.01.org/0day-ci/archive/20240914/202409140137.5jZxplAp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409140137.5jZxplAp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409140137.5jZxplAp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hv/vmbus_drv.c:985:27: error: 'vmbus_freeze' undeclared here (not in a function); did you mean 'vmbus_remove'?
     985 |         .suspend_noirq  = vmbus_freeze,
         |                           ^~~~~~~~~~~~
         |                           vmbus_remove


vim +985 drivers/hv/vmbus_drv.c

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

