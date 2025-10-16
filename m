Return-Path: <linux-hyperv+bounces-7228-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F7BBE406B
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47832548877
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B5E146585;
	Thu, 16 Oct 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bF7rs2ML"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC83451D7;
	Thu, 16 Oct 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626158; cv=none; b=tiHBse4SvSQ20Cg8IB/1tB8eoVtC8mTfqffACqsxVlVMf7axleLU0aZ6weMXODcaQ+DXp23vFue3qCY5apfs6kOgBZSSyeCQxtFFdUO+ryhAmwQmQtsvExXYQlpyzMRtvqc8fzSIUYmHaWLLEcsAgcev7rm4Z4JfePgCJR2FdBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626158; c=relaxed/simple;
	bh=myrWxcLfj7Q1eJAftl/1uoyikDP3bA6Cr9+RZGC02XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sefVyjz8qsGTqg9oBek0GVLgvBVDgLdsMohuckZuuvf3+9pIczUY38wzXT+FqVqNCOfFAacinQsZ14GdfUO+zDzkno8xXoaZTFWIJv7mEoEPynoXilygSqw0THwFErz+G1x35jn4VBY7L+g/QFZTtRLQCBYSpVvLDm7W5DJfPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bF7rs2ML; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760626152; x=1792162152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=myrWxcLfj7Q1eJAftl/1uoyikDP3bA6Cr9+RZGC02XI=;
  b=bF7rs2MLYqt5Upx9oGGgrDfXOFxK+jNB6vOPT/ibr2xztyL0DSoUZREQ
   eODGDIHeJj4TxCuIsQdyUEEGLfnaTV6JVi9J+hQMf1/NVBX0E4DB9X/uh
   qT4R4tJ6lG2ZYVwa1pjppjrOUqpHDw2/rxKCFG/CfyveIq9X/6kJ/NtA9
   dNOAF8jKLYMEawqQfcAb8n5nKT3ib5k+rUkDrncfVl636/QdMJ6EaWpgZ
   esXj+XF36MWDuxKtXzgx0syc2lBnpQFGH++5Gg6l7ML2AMQ9QQePhs5Qs
   /gTdAvLs/DL13XijzUNDb3jWltfXWr9iEYq4YhSvpZ/CNhELm546vj147
   A==;
X-CSE-ConnectionGUID: u9h+StnrTHOZxxzoowLkUw==
X-CSE-MsgGUID: wWnFHbLhSii4Bb4HbNSiWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62730937"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62730937"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 07:48:50 -0700
X-CSE-ConnectionGUID: 9j8a9H9bQ1yD4ixQhjGliA==
X-CSE-MsgGUID: GUZahzd0Tzi4Nu7ksTVMfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182883350"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 16 Oct 2025 07:48:47 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9PHZ-0004vF-1m;
	Thu, 16 Oct 2025 14:48:45 +0000
Date: Thu, 16 Oct 2025 22:47:57 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com
Cc: oe-kbuild-all@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] Drivers: hv: Add support for movable memory
 regions
Message-ID: <202510162231.7UOw1jQq-lkp@intel.com>
References: <176057443695.74314.10584965103467299030.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176057443695.74314.10584965103467299030.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc1 next-20251015]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Kinsburskii/Drivers-hv-Refactor-and-rename-memory-region-handling-functions/20251016-082944
base:   linus/master
patch link:    https://lore.kernel.org/r/176057443695.74314.10584965103467299030.stgit%40skinsburskii-cloud-desktop.internal.cloudapp.net
patch subject: [PATCH v5 5/5] Drivers: hv: Add support for movable memory regions
config: x86_64-buildonly-randconfig-002-20251016 (https://download.01.org/0day-ci/archive/20251016/202510162231.7UOw1jQq-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510162231.7UOw1jQq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510162231.7UOw1jQq-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/hmm.c: In function 'hmm_range_fault':
>> mm/hmm.c:667:21: error: implicit declaration of function 'mmu_interval_check_retry' [-Wimplicit-function-declaration]
     667 |                 if (mmu_interval_check_retry(range->notifier,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/mmu_interval_check_retry +667 mm/hmm.c

7b86ac3371b70c Christoph Hellwig 2019-08-28  634  
9a4903e49e495b Christoph Hellwig 2019-07-25  635  /**
9a4903e49e495b Christoph Hellwig 2019-07-25  636   * hmm_range_fault - try to fault some address in a virtual address range
f970b977e068aa Jason Gunthorpe   2020-03-27  637   * @range:	argument structure
9a4903e49e495b Christoph Hellwig 2019-07-25  638   *
be957c886d92aa Jason Gunthorpe   2020-05-01  639   * Returns 0 on success or one of the following error codes:
73231612dc7c90 Jérôme Glisse     2019-05-13  640   *
9a4903e49e495b Christoph Hellwig 2019-07-25  641   * -EINVAL:	Invalid arguments or mm or virtual address is in an invalid vma
9a4903e49e495b Christoph Hellwig 2019-07-25  642   *		(e.g., device file vma).
73231612dc7c90 Jérôme Glisse     2019-05-13  643   * -ENOMEM:	Out of memory.
9a4903e49e495b Christoph Hellwig 2019-07-25  644   * -EPERM:	Invalid permission (e.g., asking for write and range is read
9a4903e49e495b Christoph Hellwig 2019-07-25  645   *		only).
9a4903e49e495b Christoph Hellwig 2019-07-25  646   * -EBUSY:	The range has been invalidated and the caller needs to wait for
9a4903e49e495b Christoph Hellwig 2019-07-25  647   *		the invalidation to finish.
f970b977e068aa Jason Gunthorpe   2020-03-27  648   * -EFAULT:     A page was requested to be valid and could not be made valid
f970b977e068aa Jason Gunthorpe   2020-03-27  649   *              ie it has no backing VMA or it is illegal to access
74eee180b935fc Jérôme Glisse     2017-09-08  650   *
f970b977e068aa Jason Gunthorpe   2020-03-27  651   * This is similar to get_user_pages(), except that it can read the page tables
f970b977e068aa Jason Gunthorpe   2020-03-27  652   * without mutating them (ie causing faults).
74eee180b935fc Jérôme Glisse     2017-09-08  653   */
be957c886d92aa Jason Gunthorpe   2020-05-01  654  int hmm_range_fault(struct hmm_range *range)
74eee180b935fc Jérôme Glisse     2017-09-08  655  {
d28c2c9a487708 Ralph Campbell    2019-11-04  656  	struct hmm_vma_walk hmm_vma_walk = {
d28c2c9a487708 Ralph Campbell    2019-11-04  657  		.range = range,
d28c2c9a487708 Ralph Campbell    2019-11-04  658  		.last = range->start,
d28c2c9a487708 Ralph Campbell    2019-11-04  659  	};
a22dd506400d0f Jason Gunthorpe   2019-11-12  660  	struct mm_struct *mm = range->notifier->mm;
74eee180b935fc Jérôme Glisse     2017-09-08  661  	int ret;
74eee180b935fc Jérôme Glisse     2017-09-08  662  
42fc541404f249 Michel Lespinasse 2020-06-08  663  	mmap_assert_locked(mm);
74eee180b935fc Jérôme Glisse     2017-09-08  664  
a3e0d41c2b1f86 Jérôme Glisse     2019-05-13  665  	do {
a3e0d41c2b1f86 Jérôme Glisse     2019-05-13  666  		/* If range is no longer valid force retry. */
a22dd506400d0f Jason Gunthorpe   2019-11-12 @667  		if (mmu_interval_check_retry(range->notifier,
a22dd506400d0f Jason Gunthorpe   2019-11-12  668  					     range->notifier_seq))
2bcbeaefde2f03 Christoph Hellwig 2019-07-24  669  			return -EBUSY;
d28c2c9a487708 Ralph Campbell    2019-11-04  670  		ret = walk_page_range(mm, hmm_vma_walk.last, range->end,
7b86ac3371b70c Christoph Hellwig 2019-08-28  671  				      &hmm_walk_ops, &hmm_vma_walk);
be957c886d92aa Jason Gunthorpe   2020-05-01  672  		/*
be957c886d92aa Jason Gunthorpe   2020-05-01  673  		 * When -EBUSY is returned the loop restarts with
be957c886d92aa Jason Gunthorpe   2020-05-01  674  		 * hmm_vma_walk.last set to an address that has not been stored
be957c886d92aa Jason Gunthorpe   2020-05-01  675  		 * in pfns. All entries < last in the pfn array are set to their
be957c886d92aa Jason Gunthorpe   2020-05-01  676  		 * output, and all >= are still at their input values.
be957c886d92aa Jason Gunthorpe   2020-05-01  677  		 */
d28c2c9a487708 Ralph Campbell    2019-11-04  678  	} while (ret == -EBUSY);
73231612dc7c90 Jérôme Glisse     2019-05-13  679  	return ret;
74eee180b935fc Jérôme Glisse     2017-09-08  680  }
73231612dc7c90 Jérôme Glisse     2019-05-13  681  EXPORT_SYMBOL(hmm_range_fault);
8cad4713056612 Leon Romanovsky   2025-04-28  682  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

