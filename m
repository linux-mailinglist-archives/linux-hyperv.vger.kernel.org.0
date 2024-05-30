Return-Path: <linux-hyperv+bounces-2260-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25BE8D46C9
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 10:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A469C281E87
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E791474DA;
	Thu, 30 May 2024 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6t/r9e7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E91487F1;
	Thu, 30 May 2024 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056759; cv=none; b=mTtL9U9akKKGXS3swfIaD/4aCcxWgOLRPQAPJoFdKNvvjgu0IgEcZmWH5Iyf8JjEYg5nTksETFxHBVDCnchf8N3Nmg0v8KAxaf2hNOnFrxScTbuljLfZj59uG1ZcdmqTTnVXu85lcPTzqCXnTjbvy5uhT9Ffiynz+afoLS9zLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056759; c=relaxed/simple;
	bh=uLA4wCaq7A2u/eyrQk8XHfRRjmbUeF0S9C9i4nJzoyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZ3lDtz+RkpsIyxVrqY28MbDhctzKQU5YnUMeiWwZYtou4jETyjlCsw74i1nAOl/PA5O6yXOlDrigp8sRjk9l+DoEbHGTEyM78oE8KE8HYxZR7cAWjgGW8SK5I2afYbWsKLdiDNGxlvdVeB6VYD2v6kHoc06EMkLYt2Rv9B5Y/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6t/r9e7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717056757; x=1748592757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uLA4wCaq7A2u/eyrQk8XHfRRjmbUeF0S9C9i4nJzoyc=;
  b=C6t/r9e7s7cCDivHk/6SLNoYOSXrDaFxqVQyeW5GQV5vh05ebEeeLmhc
   yu5gc2+Gex4/0qTDvo3QRJSTanXyJi3k/YtdXop1Mky+L3UQ+3fjhFIqn
   8cT9AsH0vdy9XQrPQuP+VEDywgyHtHtLMiuvWX2jUN93o3W3P6u6Ja0gz
   49Yae8bFcf3fuBA45gdq4fGYIVowbqTK9rUOJ/1z6eCdfoMTZJW4J8RpC
   MyIradlU8RzZr9OrFXWscUAdChV911yHqpYt8u56Cs1eeGZ8naYRgF/96
   6NYm+gsDNyWEbm/f1DoOZj2WxwQme/CrvnGehYsO5KdE9xe7zt8jEIIsv
   Q==;
X-CSE-ConnectionGUID: xwccT18YSNyahXu1A2I8pw==
X-CSE-MsgGUID: 7jU3fpDVS9SBflGGmLsyUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="17315060"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="17315060"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 01:12:36 -0700
X-CSE-ConnectionGUID: hZ7dxmihRoSeywTi4GgBJQ==
X-CSE-MsgGUID: Fypt2OqRRbuYKw1Z1ny1Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="36216189"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 30 May 2024 01:12:34 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCati-000Ezu-1l;
	Thu, 30 May 2024 08:12:30 +0000
Date: Thu, 30 May 2024 16:12:07 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Nagesh <adityanagesh@linux.microsoft.com>,
	adityanagesh@microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Aditya Nagesh <adityanagesh@linux.microsoft.com>
Subject: Re: [PATCH v5] Drivers: hv: Cosmetic changes for hv.c and balloon.c
Message-ID: <202405301550.DKuS2OzK-lkp@intel.com>
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
config: arm64-randconfig-002-20240530 (https://download.01.org/0day-ci/archive/20240530/202405301550.DKuS2OzK-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240530/202405301550.DKuS2OzK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405301550.DKuS2OzK-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/hv/hv_balloon.c: In function 'hot_add_req':
>> drivers/hv/hv_balloon.c:998:9: warning: "/*" within comment [-Wcomment]
     998 |         /*
         |          
>> drivers/hv/hv_balloon.c:980: error: unterminated #ifdef
     980 | #ifdef CONFIG_MEMORY_HOTPLUG
         | 
>> drivers/hv/hv_balloon.c:978:39: error: expected declaration or statement at end of input
     978 |         resp.hdr.size = sizeof(struct dm_hot_add_response);
         |                                       ^~~~~~~~~~~~~~~~~~~
>> drivers/hv/hv_balloon.c:974:34: warning: unused variable 'dm' [-Wunused-variable]
     974 |         struct hv_dynmem_device *dm = &dm_device;
         |                                  ^~
   drivers/hv/hv_balloon.c: At top level:
>> drivers/hv/hv_balloon.c:575:13: warning: 'post_status' declared 'static' but never defined [-Wunused-function]
     575 | static void post_status(struct hv_dynmem_device *dm);
         |             ^~~~~~~~~~~
>> drivers/hv/hv_balloon.c:577:13: warning: 'enable_page_reporting' declared 'static' but never defined [-Wunused-function]
     577 | static void enable_page_reporting(void);
         |             ^~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/hv_balloon.c:579:13: warning: 'disable_page_reporting' declared 'static' but never defined [-Wunused-function]
     579 | static void disable_page_reporting(void);
         |             ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/hv_balloon.c:967:13: warning: 'hot_add_req' defined but not used [-Wunused-function]
     967 | static void hot_add_req(struct work_struct *dummy)
         |             ^~~~~~~~~~~
>> drivers/hv/hv_balloon.c:496:22: warning: 'ha_pages_in_chunk' defined but not used [-Wunused-variable]
     496 | static unsigned long ha_pages_in_chunk;
         |                      ^~~~~~~~~~~~~~~~~
>> drivers/hv/hv_balloon.c:494:13: warning: 'balloon_up_send_buffer' defined but not used [-Wunused-variable]
     494 | static __u8 balloon_up_send_buffer[HV_HYP_PAGE_SIZE];
         |             ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/hv_balloon.c:493:13: warning: 'recv_buffer' defined but not used [-Wunused-variable]
     493 | static __u8 recv_buffer[HV_HYP_PAGE_SIZE];
         |             ^~~~~~~~~~~
>> drivers/hv/hv_balloon.c:478:12: warning: 'dm_ring_size' defined but not used [-Wunused-variable]
     478 | static int dm_ring_size = VMBUS_RING_SIZE(16 * 1024);
         |            ^~~~~~~~~~~~
>> drivers/hv/hv_balloon.c:476:17: warning: 'trans_id' defined but not used [-Wunused-variable]
     476 | static atomic_t trans_id = ATOMIC_INIT(0);
         |                 ^~~~~~~~
>> drivers/hv/hv_balloon.c:469:12: warning: 'hv_hypercall_multi_failure' defined but not used [-Wunused-variable]
     469 | static int hv_hypercall_multi_failure;
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/hv_balloon.c:467:22: warning: 'last_post_time' defined but not used [-Wunused-variable]
     467 | static unsigned long last_post_time;
         |                      ^~~~~~~~~~~~~~
>> drivers/hv/hv_balloon.c:455:13: warning: 'do_hot_add' defined but not used [-Wunused-variable]
     455 | static bool do_hot_add;
         |             ^~~~~~~~~~
>> drivers/hv/hv_balloon.c:453:13: warning: 'allow_hibernation' defined but not used [-Wunused-variable]
     453 | static bool allow_hibernation;
         |             ^~~~~~~~~~~~~~~~~


vim +980 drivers/hv/hv_balloon.c

1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   966  
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15  @967  static void hot_add_req(struct work_struct *dummy)
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   968  {
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   969  	struct dm_hot_add_response resp;
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   970  #ifdef CONFIG_MEMORY_HOTPLUG
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   971  	unsigned long pg_start, pfn_cnt;
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   972  	unsigned long rg_start, rg_sz;
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   973  #endif
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15  @974  	struct hv_dynmem_device *dm = &dm_device;
9aa8b50b2b3d3a7 K. Y. Srinivasan 2012-11-14   975  
9aa8b50b2b3d3a7 K. Y. Srinivasan 2012-11-14   976  	memset(&resp, 0, sizeof(struct dm_hot_add_response));
9aa8b50b2b3d3a7 K. Y. Srinivasan 2012-11-14   977  	resp.hdr.type = DM_MEM_HOT_ADD_RESPONSE;
9aa8b50b2b3d3a7 K. Y. Srinivasan 2012-11-14  @978  	resp.hdr.size = sizeof(struct dm_hot_add_response);
9aa8b50b2b3d3a7 K. Y. Srinivasan 2012-11-14   979  
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15  @980  #ifdef CONFIG_MEMORY_HOTPLUG
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   981  	pg_start = dm->ha_wrk.ha_page_range.finfo.start_page;
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   982  	pfn_cnt = dm->ha_wrk.ha_page_range.finfo.page_cnt;
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   983  
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   984  	rg_start = dm->ha_wrk.ha_region_range.finfo.start_page;
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   985  	rg_sz = dm->ha_wrk.ha_region_range.finfo.page_cnt;
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   986  
1aa0ebde593dfb1 Aditya Nagesh    2024-05-29   987  	if (rg_start == 0 && !dm->host_specified_ha_region) {
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   988  		/*
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   989  		 * Based on the hot-add page range being specified,
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   990  	}
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   991  
7f4f2302a11173d K. Y. Srinivasan 2013-03-18   992  	if (do_hot_add)
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   993  		resp.page_count = process_hot_add(pg_start, pfn_cnt,
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   994  						  rg_start, rg_sz);
549fd280b145e21 Vitaly Kuznetsov 2015-02-28   995  
549fd280b145e21 Vitaly Kuznetsov 2015-02-28   996  	dm->num_pages_added += resp.page_count;
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15   997  #endif
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  @998  	/*
7f4f2302a11173d K. Y. Srinivasan 2013-03-18   999  	 * The result field of the response structure has the
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1000  	 * following semantics:
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1001  	 *
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1002  	 * 1. If all or some pages hot-added: Guest should return success.
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1003  	 *
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1004  	 * 2. If no pages could be hot-added:
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1005  	 *
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1006  	 * If the guest returns success, then the host
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1007  	 * will not attempt any further hot-add operations. This
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1008  	 * signifies a permanent failure.
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1009  	 *
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1010  	 * If the guest returns failure, then this failure will be
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1011  	 * treated as a transient failure and the host may retry the
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1012  	 * hot-add operation after some delay.
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1013  	 */
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15  1014  	if (resp.page_count > 0)
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15  1015  		resp.result = 1;
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1016  	else if (!do_hot_add)
7f4f2302a11173d K. Y. Srinivasan 2013-03-18  1017  		resp.result = 1;
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15  1018  	else
9aa8b50b2b3d3a7 K. Y. Srinivasan 2012-11-14  1019  		resp.result = 0;
9aa8b50b2b3d3a7 K. Y. Srinivasan 2012-11-14  1020  
25bd2b2f1f05347 Dexuan Cui       2019-11-19  1021  	if (!do_hot_add || resp.page_count == 0) {
25bd2b2f1f05347 Dexuan Cui       2019-11-19  1022  		if (!allow_hibernation)
223e1e4d2c16fed Vitaly Kuznetsov 2018-03-04  1023  			pr_err("Memory hot add failed\n");
25bd2b2f1f05347 Dexuan Cui       2019-11-19  1024  		else
25bd2b2f1f05347 Dexuan Cui       2019-11-19  1025  			pr_info("Ignore hot-add request!\n");
25bd2b2f1f05347 Dexuan Cui       2019-11-19  1026  	}
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15  1027  
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15  1028  	dm->state = DM_INITIALIZED;
20138d6cb838aa0 K. Y. Srinivasan 2013-07-17  1029  	resp.hdr.trans_id = atomic_inc_return(&trans_id);
1cac8cd4d146b60 K. Y. Srinivasan 2013-03-15  1030  	vmbus_sendpacket(dm->dev->channel, &resp,
9aa8b50b2b3d3a7 K. Y. Srinivasan 2012-11-14  1031  			sizeof(struct dm_hot_add_response),
9aa8b50b2b3d3a7 K. Y. Srinivasan 2012-11-14  1032  			(unsigned long)NULL,
9aa8b50b2b3d3a7 K. Y. Srinivasan 2012-11-14  1033  			VM_PKT_DATA_INBAND, 0);
9aa8b50b2b3d3a7 K. Y. Srinivasan 2012-11-14  1034  }
9aa8b50b2b3d3a7 K. Y. Srinivasan 2012-11-14  1035  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

