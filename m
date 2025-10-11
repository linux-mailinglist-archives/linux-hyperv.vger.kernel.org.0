Return-Path: <linux-hyperv+bounces-7192-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7F5BCED9A
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Oct 2025 03:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CFF421127
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Oct 2025 01:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140A970810;
	Sat, 11 Oct 2025 01:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feGZXzzh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD323AC1C;
	Sat, 11 Oct 2025 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760145175; cv=none; b=Up/AoV8H1j1TN5bap+7A0BHwc10VuoTAUSfRlJL06ll3Ig3AXYwPJHeexhXPt1rGoCInah8Lhgy+JdM4+zsCvd3t2rBuczuhitI65w6fGSNULwPtYWO7vTM187JWeLc4NT1z3tbHH//qHGl35PDUf6+QPVBzF4OOu67vinMXdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760145175; c=relaxed/simple;
	bh=2yr4MNhJ2DynXk5xGVrSco7oWPHvtBHXmPYgMBX2uoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1KTyF5Uxly0g1D+pj+qGR2b9iGierBXKQuEIggtHNEbt8hGA4BloIawrxo5A2hUXb7LgQpjIivho29FhkaE3oNXLtuTHR8C3+rv+G/GzfMIvzwpvDI0oChPB2jRoMGNa1DiXwGrmOKdKH8PcLKCjIiNhriG9MS4Rmv86f1fG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=feGZXzzh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760145173; x=1791681173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2yr4MNhJ2DynXk5xGVrSco7oWPHvtBHXmPYgMBX2uoQ=;
  b=feGZXzzh84IFy8Hua8CXL7LJ9g9eEZgh0fNSM0pd4Jy9LYnnPWZU9nCn
   pvGjv1Al2IEsTDm99GrlZwItgvtJrhaALh2i03KQonAzbdFHV5BgFOi0t
   31Himo8XHX33zwg0eDoM5Z83Qp+da2VNJ0itc5Q6Ia9vyerKUWPasMV5p
   AVWzp5contqCtgPBTiBWubVHTjqJtjl1j5roGREKVweN+TEwjXCQBrxVj
   JlkEjfgMZStjy91RB7RuT1DHZqNQppcf3ijqcaZbwWsd7TM2xs/vwUSqB
   LTZDTZ4OaE48q3FbjUmFpdb/sOWS/W9982qj8rLJuvS0H3TtG529ZlWvG
   g==;
X-CSE-ConnectionGUID: 3ln4uwltREuFYEhNkPQShg==
X-CSE-MsgGUID: 5X6D37QNSJKfNzsTZPxZYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="66220392"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="66220392"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 18:12:53 -0700
X-CSE-ConnectionGUID: Q4dkzTb3TSyEga/NA6ryLw==
X-CSE-MsgGUID: nAR+8PPyQLGUmxA+UFQIdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="204783188"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Oct 2025 18:12:50 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7OAC-0003Mt-0x;
	Sat, 11 Oct 2025 01:12:48 +0000
Date: Sat, 11 Oct 2025 09:12:24 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] Drivers: hv: Add support for movable memory
 regions
Message-ID: <202510110819.km2ehSaB-lkp@intel.com>
References: <175976319844.16834.4747024333732752980.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175976319844.16834.4747024333732752980.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on next-20251010]
[cannot apply to v6.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Kinsburskii/Drivers-hv-Refactor-and-rename-memory-region-handling-functions/20251010-111917
base:   linus/master
patch link:    https://lore.kernel.org/r/175976319844.16834.4747024333732752980.stgit%40skinsburskii-cloud-desktop.internal.cloudapp.net
patch subject: [PATCH v4 5/5] Drivers: hv: Add support for movable memory regions
config: x86_64-buildonly-randconfig-001-20251011 (https://download.01.org/0day-ci/archive/20251011/202510110819.km2ehSaB-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110819.km2ehSaB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110819.km2ehSaB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/hmm.c:667:7: error: call to undeclared function 'mmu_interval_check_retry'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     667 |                 if (mmu_interval_check_retry(range->notifier,
         |                     ^
   1 error generated.


vim +/mmu_interval_check_retry +667 mm/hmm.c

7b86ac3371b70c3 Christoph Hellwig 2019-08-28  634  
9a4903e49e495bf Christoph Hellwig 2019-07-25  635  /**
9a4903e49e495bf Christoph Hellwig 2019-07-25  636   * hmm_range_fault - try to fault some address in a virtual address range
f970b977e068aa5 Jason Gunthorpe   2020-03-27  637   * @range:	argument structure
9a4903e49e495bf Christoph Hellwig 2019-07-25  638   *
be957c886d92aa9 Jason Gunthorpe   2020-05-01  639   * Returns 0 on success or one of the following error codes:
73231612dc7c907 Jérôme Glisse     2019-05-13  640   *
9a4903e49e495bf Christoph Hellwig 2019-07-25  641   * -EINVAL:	Invalid arguments or mm or virtual address is in an invalid vma
9a4903e49e495bf Christoph Hellwig 2019-07-25  642   *		(e.g., device file vma).
73231612dc7c907 Jérôme Glisse     2019-05-13  643   * -ENOMEM:	Out of memory.
9a4903e49e495bf Christoph Hellwig 2019-07-25  644   * -EPERM:	Invalid permission (e.g., asking for write and range is read
9a4903e49e495bf Christoph Hellwig 2019-07-25  645   *		only).
9a4903e49e495bf Christoph Hellwig 2019-07-25  646   * -EBUSY:	The range has been invalidated and the caller needs to wait for
9a4903e49e495bf Christoph Hellwig 2019-07-25  647   *		the invalidation to finish.
f970b977e068aa5 Jason Gunthorpe   2020-03-27  648   * -EFAULT:     A page was requested to be valid and could not be made valid
f970b977e068aa5 Jason Gunthorpe   2020-03-27  649   *              ie it has no backing VMA or it is illegal to access
74eee180b935fcb Jérôme Glisse     2017-09-08  650   *
f970b977e068aa5 Jason Gunthorpe   2020-03-27  651   * This is similar to get_user_pages(), except that it can read the page tables
f970b977e068aa5 Jason Gunthorpe   2020-03-27  652   * without mutating them (ie causing faults).
74eee180b935fcb Jérôme Glisse     2017-09-08  653   */
be957c886d92aa9 Jason Gunthorpe   2020-05-01  654  int hmm_range_fault(struct hmm_range *range)
74eee180b935fcb Jérôme Glisse     2017-09-08  655  {
d28c2c9a487708b Ralph Campbell    2019-11-04  656  	struct hmm_vma_walk hmm_vma_walk = {
d28c2c9a487708b Ralph Campbell    2019-11-04  657  		.range = range,
d28c2c9a487708b Ralph Campbell    2019-11-04  658  		.last = range->start,
d28c2c9a487708b Ralph Campbell    2019-11-04  659  	};
a22dd506400d0f4 Jason Gunthorpe   2019-11-12  660  	struct mm_struct *mm = range->notifier->mm;
74eee180b935fcb Jérôme Glisse     2017-09-08  661  	int ret;
74eee180b935fcb Jérôme Glisse     2017-09-08  662  
42fc541404f2497 Michel Lespinasse 2020-06-08  663  	mmap_assert_locked(mm);
74eee180b935fcb Jérôme Glisse     2017-09-08  664  
a3e0d41c2b1f86b Jérôme Glisse     2019-05-13  665  	do {
a3e0d41c2b1f86b Jérôme Glisse     2019-05-13  666  		/* If range is no longer valid force retry. */
a22dd506400d0f4 Jason Gunthorpe   2019-11-12 @667  		if (mmu_interval_check_retry(range->notifier,
a22dd506400d0f4 Jason Gunthorpe   2019-11-12  668  					     range->notifier_seq))
2bcbeaefde2f038 Christoph Hellwig 2019-07-24  669  			return -EBUSY;
d28c2c9a487708b Ralph Campbell    2019-11-04  670  		ret = walk_page_range(mm, hmm_vma_walk.last, range->end,
7b86ac3371b70c3 Christoph Hellwig 2019-08-28  671  				      &hmm_walk_ops, &hmm_vma_walk);
be957c886d92aa9 Jason Gunthorpe   2020-05-01  672  		/*
be957c886d92aa9 Jason Gunthorpe   2020-05-01  673  		 * When -EBUSY is returned the loop restarts with
be957c886d92aa9 Jason Gunthorpe   2020-05-01  674  		 * hmm_vma_walk.last set to an address that has not been stored
be957c886d92aa9 Jason Gunthorpe   2020-05-01  675  		 * in pfns. All entries < last in the pfn array are set to their
be957c886d92aa9 Jason Gunthorpe   2020-05-01  676  		 * output, and all >= are still at their input values.
be957c886d92aa9 Jason Gunthorpe   2020-05-01  677  		 */
d28c2c9a487708b Ralph Campbell    2019-11-04  678  	} while (ret == -EBUSY);
73231612dc7c907 Jérôme Glisse     2019-05-13  679  	return ret;
74eee180b935fcb Jérôme Glisse     2017-09-08  680  }
73231612dc7c907 Jérôme Glisse     2019-05-13  681  EXPORT_SYMBOL(hmm_range_fault);
8cad47130566123 Leon Romanovsky   2025-04-28  682  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

