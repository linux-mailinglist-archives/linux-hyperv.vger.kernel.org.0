Return-Path: <linux-hyperv+bounces-2258-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9FB8D42AC
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 03:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0612AB23B75
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 01:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA58EAF9;
	Thu, 30 May 2024 01:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eA8o/RIC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59660FC0E;
	Thu, 30 May 2024 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031264; cv=none; b=ateiYWdqm97tROQ2rced8NpWi0b3j0VSue9KP4FbseC4WdDS27YOMm379i5P+OX20GMCnX1IxIKXXi8RKu+kBowyIO9yrtvy2RXn03v/yu809C6GCGBm9fknFKcTnxLicLJeBXTioIeq0j0MOEHtIXq0yOElJK0JIb+Cf/oTvUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031264; c=relaxed/simple;
	bh=XjvxQ58QFqkAqBkQUJiK8TAuqi7nU98sT/Ve+TJkfko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubIh72cqooOIZv5cswTfZecng0PIzWToVPy3S18NkAglv9/WknQ0rPxi12FgoGRz/eHlsMDTRr8EPYIRiQwpnarMgrij3kkUmXcwE8mL9AV0TGR/IfsZ0ktdJOasKFmSpP1Pc1x/lOAWuBSG+/EwzMjevt+JMk2777hNblh3bFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eA8o/RIC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717031261; x=1748567261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XjvxQ58QFqkAqBkQUJiK8TAuqi7nU98sT/Ve+TJkfko=;
  b=eA8o/RIC/Wp1mjs0mIXeJ7inAk6dSukPVDdj/HbchcGt7Z9VzTegMFKh
   PSdMu9DKvfxmRhdrRv8BQTfD61SPkjK4gy3ye3G7bx7SqKDt83mE4Ji02
   fSCGjNtUM/60qRJgutqBDP144ambmnLqyTOGLI54zmE+OEjhtSFXT0KDX
   HI/QG+Yf3QFLjfAY2QeIxrY+kcJMnh6cf8+fT3oSbCd0FSQ1UhADn47CK
   1A6W/LnqdjUqMqCe85wKdLMsrb1yD5xVH58Us6VXxQj6I2S2F86XHkmFN
   mK6tDvK4lVmX7y86Lihcds1sXrPQXlOzssEUhCh1dYvOUNXoFiN3qNRlL
   Q==;
X-CSE-ConnectionGUID: 5HA+QtC3QvqbBYzgTBUtYQ==
X-CSE-MsgGUID: Rn3mw1NJQZOKGUW0Irsbrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24894757"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="24894757"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 18:07:41 -0700
X-CSE-ConnectionGUID: tT7J4lPYQyS5VelxkbE4pQ==
X-CSE-MsgGUID: +7OOO/vLR1aQxcOyIYeVnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="73089445"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 29 May 2024 18:07:39 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCUGV-000EOj-30;
	Thu, 30 May 2024 01:07:35 +0000
Date: Thu, 30 May 2024 09:06:51 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Nagesh <adityanagesh@linux.microsoft.com>,
	adityanagesh@microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Aditya Nagesh <adityanagesh@linux.microsoft.com>
Subject: Re: [PATCH v5] Drivers: hv: Cosmetic changes for hv.c and balloon.c
Message-ID: <202405300835.7RLpoY4A-lkp@intel.com>
References: <1716998695-32135-1-git-send-email-adityanagesh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716998695-32135-1-git-send-email-adityanagesh@linux.microsoft.com>

Hi Aditya,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240529]
[cannot apply to linus/master v6.10-rc1 v6.9 v6.9-rc7 v6.10-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Nagesh/Drivers-hv-Cosmetic-changes-for-hv-c-and-balloon-c/20240530-000928
base:   next-20240529
patch link:    https://lore.kernel.org/r/1716998695-32135-1-git-send-email-adityanagesh%40linux.microsoft.com
patch subject: [PATCH v5] Drivers: hv: Cosmetic changes for hv.c and balloon.c
config: i386-buildonly-randconfig-004-20240530 (https://download.01.org/0day-ci/archive/20240530/202405300835.7RLpoY4A-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240530/202405300835.7RLpoY4A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405300835.7RLpoY4A-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hv/hv_balloon.c:980:2: error: unterminated conditional directive
     980 | #ifdef CONFIG_MEMORY_HOTPLUG
         |  ^
>> drivers/hv/hv_balloon.c:2129:23: error: expected '}'
    2129 | MODULE_LICENSE("GPL");
         |                       ^
   drivers/hv/hv_balloon.c:968:1: note: to match this '{'
     968 | {
         | ^
   2 errors generated.


vim +980 drivers/hv/hv_balloon.c

1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   966  
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   967  static void hot_add_req(struct work_struct *dummy)
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   968  {
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   969  	struct dm_hot_add_response resp;
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   970  #ifdef CONFIG_MEMORY_HOTPLUG
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   971  	unsigned long pg_start, pfn_cnt;
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   972  	unsigned long rg_start, rg_sz;
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   973  #endif
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   974  	struct hv_dynmem_device *dm = &dm_device;
9aa8b50b2b3d3a K. Y. Srinivasan 2012-11-14   975  
9aa8b50b2b3d3a K. Y. Srinivasan 2012-11-14   976  	memset(&resp, 0, sizeof(struct dm_hot_add_response));
9aa8b50b2b3d3a K. Y. Srinivasan 2012-11-14   977  	resp.hdr.type = DM_MEM_HOT_ADD_RESPONSE;
9aa8b50b2b3d3a K. Y. Srinivasan 2012-11-14   978  	resp.hdr.size = sizeof(struct dm_hot_add_response);
9aa8b50b2b3d3a K. Y. Srinivasan 2012-11-14   979  
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15  @980  #ifdef CONFIG_MEMORY_HOTPLUG
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   981  	pg_start = dm->ha_wrk.ha_page_range.finfo.start_page;
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   982  	pfn_cnt = dm->ha_wrk.ha_page_range.finfo.page_cnt;
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   983  
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   984  	rg_start = dm->ha_wrk.ha_region_range.finfo.start_page;
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   985  	rg_sz = dm->ha_wrk.ha_region_range.finfo.page_cnt;
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   986  
1aa0ebde593dfb Aditya Nagesh    2024-05-29   987  	if (rg_start == 0 && !dm->host_specified_ha_region) {
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   988  		/*
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   989  		 * Based on the hot-add page range being specified,
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   990  	}
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   991  
7f4f2302a11173 K. Y. Srinivasan 2013-03-18   992  	if (do_hot_add)
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   993  		resp.page_count = process_hot_add(pg_start, pfn_cnt,
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   994  						  rg_start, rg_sz);
549fd280b145e2 Vitaly Kuznetsov 2015-02-28   995  
549fd280b145e2 Vitaly Kuznetsov 2015-02-28   996  	dm->num_pages_added += resp.page_count;
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15   997  #endif
7f4f2302a11173 K. Y. Srinivasan 2013-03-18   998  	/*
7f4f2302a11173 K. Y. Srinivasan 2013-03-18   999  	 * The result field of the response structure has the
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1000  	 * following semantics:
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1001  	 *
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1002  	 * 1. If all or some pages hot-added: Guest should return success.
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1003  	 *
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1004  	 * 2. If no pages could be hot-added:
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1005  	 *
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1006  	 * If the guest returns success, then the host
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1007  	 * will not attempt any further hot-add operations. This
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1008  	 * signifies a permanent failure.
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1009  	 *
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1010  	 * If the guest returns failure, then this failure will be
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1011  	 * treated as a transient failure and the host may retry the
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1012  	 * hot-add operation after some delay.
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1013  	 */
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15  1014  	if (resp.page_count > 0)
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15  1015  		resp.result = 1;
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1016  	else if (!do_hot_add)
7f4f2302a11173 K. Y. Srinivasan 2013-03-18  1017  		resp.result = 1;
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15  1018  	else
9aa8b50b2b3d3a K. Y. Srinivasan 2012-11-14  1019  		resp.result = 0;
9aa8b50b2b3d3a K. Y. Srinivasan 2012-11-14  1020  
25bd2b2f1f0534 Dexuan Cui       2019-11-19  1021  	if (!do_hot_add || resp.page_count == 0) {
25bd2b2f1f0534 Dexuan Cui       2019-11-19  1022  		if (!allow_hibernation)
223e1e4d2c16fe Vitaly Kuznetsov 2018-03-04  1023  			pr_err("Memory hot add failed\n");
25bd2b2f1f0534 Dexuan Cui       2019-11-19  1024  		else
25bd2b2f1f0534 Dexuan Cui       2019-11-19  1025  			pr_info("Ignore hot-add request!\n");
25bd2b2f1f0534 Dexuan Cui       2019-11-19  1026  	}
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15  1027  
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15  1028  	dm->state = DM_INITIALIZED;
20138d6cb838aa K. Y. Srinivasan 2013-07-17  1029  	resp.hdr.trans_id = atomic_inc_return(&trans_id);
1cac8cd4d146b6 K. Y. Srinivasan 2013-03-15  1030  	vmbus_sendpacket(dm->dev->channel, &resp,
9aa8b50b2b3d3a K. Y. Srinivasan 2012-11-14  1031  			sizeof(struct dm_hot_add_response),
9aa8b50b2b3d3a K. Y. Srinivasan 2012-11-14  1032  			(unsigned long)NULL,
9aa8b50b2b3d3a K. Y. Srinivasan 2012-11-14  1033  			VM_PKT_DATA_INBAND, 0);
9aa8b50b2b3d3a K. Y. Srinivasan 2012-11-14  1034  }
9aa8b50b2b3d3a K. Y. Srinivasan 2012-11-14  1035  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

