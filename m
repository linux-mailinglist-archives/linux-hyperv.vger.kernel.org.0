Return-Path: <linux-hyperv+bounces-7988-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AF7CABEC3
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Dec 2025 04:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2E8A304C9ED
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Dec 2025 03:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2CF2E7198;
	Mon,  8 Dec 2025 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/v4wGQE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3CB273D8F;
	Mon,  8 Dec 2025 03:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765163101; cv=none; b=Y0tPywWA6FTyooocEbAbx52xSu5+BFREts8j/T95R0QkZAqGAqbrbnjVHwWHIWsGjloOrY9xS43S0L0/xrj9j0gjGoLDG9K2WBi+uad7xC2rJTpjEFT/+BrAoINkbkcvRtEMJrTLOTc+i+lSSOnJMoeEHuj0J1QpsIZj8tznet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765163101; c=relaxed/simple;
	bh=fA6lTbgQDY3+JQPsBJw1SsIrNj/2jqzT56e6yGhqve0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpTIym9HIZqH98lxmsUbN0UYFWLwYRAENbqBNgeu+V6AjeItyJAtdFptHolZY7+NjAe64wOaTTvMcnst/9w2QeimaUWHsQ58qs3fRKbFOzFoJQ2oI/aORBYTP1IyTVpsNIw7eZiIMayapt57m86hIcB/yNKH/09WZHdND3IFG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/v4wGQE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765163091; x=1796699091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fA6lTbgQDY3+JQPsBJw1SsIrNj/2jqzT56e6yGhqve0=;
  b=G/v4wGQE8qNDVNCqYvpHBmeq2xbRJvuYhxIJYWvF2CDAn8LRQuIZZ+Wy
   RwrHZUW1ler+BBitEQw/TcypnNXuMUKSYYW20nCloQT2l/3DrUZwAwqpi
   ziPUk513N8/zcwUNdAjep4qZ/jzZdvkatwDNve1EQRa5/Z4L6vgn+k80J
   kHF88KRRUHCp7GfEIElG80fznGQmZIsKpR9fhiU7ga/a3ykw4RcU1MLwG
   TL/0sizmCTrWNJ739TcRglow0P0JfVHzuPEaMWnjI8ocDyh2/6PkqaHIC
   u41hCJXzOhN0ypXj06+MPcHZ2jwvb9GmsHBZgmVdNnxkcNKoZ1f8Dpwyq
   A==;
X-CSE-ConnectionGUID: H/g3vEZTSDigpwh6TVxXDQ==
X-CSE-MsgGUID: cxPa9mr+Qc+9DnklqLm7AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="77722168"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="77722168"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 19:04:51 -0800
X-CSE-ConnectionGUID: 0hbwR9+5S5yHuWy1oYbDvg==
X-CSE-MsgGUID: Vk90ca2hRSGRlAwKOT3XhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="195851869"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Dec 2025 19:04:47 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSRYK-00000000JsV-3ugb;
	Mon, 08 Dec 2025 03:04:44 +0000
Date: Mon, 8 Dec 2025 11:04:20 +0800
From: kernel test robot <lkp@intel.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	skinsburskii@linux.microsoft.com
Cc: oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, mhklinux@outlook.com,
	prapal@linux.microsoft.com, mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Jinank Jain <jinankjain@microsoft.com>
Subject: Re: [PATCH v2 3/3] mshv: Add debugfs to view hypervisor statistics
Message-ID: <202512081050.0AW9Ecvg-lkp@intel.com>
References: <1764961122-31679-4-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1764961122-31679-4-git-send-email-nunodasneves@linux.microsoft.com>

Hi Nuno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20251205]
[cannot apply to linus/master v6.18 v6.18-rc7 v6.18-rc6 v6.18]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Das-Neves/mshv-Ignore-second-stats-page-map-result-failure/20251206-033756
base:   next-20251205
patch link:    https://lore.kernel.org/r/1764961122-31679-4-git-send-email-nunodasneves%40linux.microsoft.com
patch subject: [PATCH v2 3/3] mshv: Add debugfs to view hypervisor statistics
config: x86_64-randconfig-002-20251208 (https://download.01.org/0day-ci/archive/20251208/202512081050.0AW9Ecvg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251208/202512081050.0AW9Ecvg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512081050.0AW9Ecvg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hv/mshv_root_main.c: In function 'mshv_parent_partition_init':
>> drivers/hv/mshv_root_main.c:2369:1: warning: label 'destroy_irqds_wq' defined but not used [-Wunused-label]
    2369 | destroy_irqds_wq:
         | ^~~~~~~~~~~~~~~~


vim +/destroy_irqds_wq +2369 drivers/hv/mshv_root_main.c

  2299	
  2300	static int __init mshv_parent_partition_init(void)
  2301	{
  2302		int ret;
  2303		struct device *dev;
  2304		union hv_hypervisor_version_info version_info;
  2305	
  2306		if (!hv_parent_partition() || is_kdump_kernel())
  2307			return -ENODEV;
  2308	
  2309		if (hv_get_hypervisor_version(&version_info))
  2310			return -ENODEV;
  2311	
  2312		ret = misc_register(&mshv_dev);
  2313		if (ret)
  2314			return ret;
  2315	
  2316		dev = mshv_dev.this_device;
  2317	
  2318		if (version_info.build_number < MSHV_HV_MIN_VERSION ||
  2319		    version_info.build_number > MSHV_HV_MAX_VERSION) {
  2320			dev_err(dev, "Running on unvalidated Hyper-V version\n");
  2321			dev_err(dev, "Versions: current: %u  min: %u  max: %u\n",
  2322				version_info.build_number, MSHV_HV_MIN_VERSION,
  2323				MSHV_HV_MAX_VERSION);
  2324		}
  2325	
  2326		mshv_root.synic_pages = alloc_percpu(struct hv_synic_pages);
  2327		if (!mshv_root.synic_pages) {
  2328			dev_err(dev, "Failed to allocate percpu synic page\n");
  2329			ret = -ENOMEM;
  2330			goto device_deregister;
  2331		}
  2332	
  2333		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
  2334					mshv_synic_init,
  2335					mshv_synic_cleanup);
  2336		if (ret < 0) {
  2337			dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
  2338			goto free_synic_pages;
  2339		}
  2340	
  2341		mshv_cpuhp_online = ret;
  2342	
  2343		ret = mshv_retrieve_scheduler_type(dev);
  2344		if (ret)
  2345			goto remove_cpu_state;
  2346	
  2347		if (hv_root_partition())
  2348			ret = mshv_root_partition_init(dev);
  2349		if (ret)
  2350			goto remove_cpu_state;
  2351	
  2352		mshv_init_vmm_caps(dev);
  2353	
  2354		ret = mshv_debugfs_init();
  2355		if (ret)
  2356			goto exit_partition;
  2357	
  2358		ret = mshv_irqfd_wq_init();
  2359		if (ret)
  2360			goto exit_debugfs;
  2361	
  2362		spin_lock_init(&mshv_root.pt_ht_lock);
  2363		hash_init(mshv_root.pt_htable);
  2364	
  2365		hv_setup_mshv_handler(mshv_isr);
  2366	
  2367		return 0;
  2368	
> 2369	destroy_irqds_wq:
  2370		mshv_irqfd_wq_cleanup();
  2371	exit_debugfs:
  2372		mshv_debugfs_exit();
  2373	exit_partition:
  2374		if (hv_root_partition())
  2375			mshv_root_partition_exit();
  2376	remove_cpu_state:
  2377		cpuhp_remove_state(mshv_cpuhp_online);
  2378	free_synic_pages:
  2379		free_percpu(mshv_root.synic_pages);
  2380	device_deregister:
  2381		misc_deregister(&mshv_dev);
  2382		return ret;
  2383	}
  2384	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

