Return-Path: <linux-hyperv+bounces-7178-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC501BCE24F
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 19:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680943ADA6D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 17:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D03621883E;
	Fri, 10 Oct 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHr4oDbM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CAC20C038;
	Fri, 10 Oct 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118552; cv=none; b=nx0982qqQ+zGDk2gzejLduQd8/HyxK+lIBMfB7BDpwy5dZObQ6xQTpfEc6QHNyk8j/dNVaZrxo72dHCVUQcUkDTgAY5lnE7v0i5s133jKYbuzOjEz+7inmE2g4cgdhTWMSATla6mEvwuK3rpzaXswJAhKcIBs6zLN7PUvbYooxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118552; c=relaxed/simple;
	bh=jB96dFec28WttUWT3FydnbC7l8PWKIZqF/cFBSnSRhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndb4x3duaLgcE/+ggjyO6j8dvVX1DO+e9hM1/fVBAzZMxftyiUFE05FgI9g5Hd2pgRmz1Mc/BIFUTW/+2ha4ko3ZKCWUhoFDLh/LSdLVs4G1N6Am7TlpItmwQOhudGWcoMN0GvfJR6XV85ktFM1hBqBUzkTcrPjhg6NoQDpvzrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHr4oDbM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760118551; x=1791654551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jB96dFec28WttUWT3FydnbC7l8PWKIZqF/cFBSnSRhQ=;
  b=BHr4oDbM9TZNsGLMFOBdasDxC3QKAmjXpC9KlzSGLGz+jQCRyxj472h7
   YxkkBRam4YOievZDf4OkgIyKG1baA+9FcjOZMMkPB3eq2bf5N3eSycCsJ
   WtWgi9bznvUncZ+NeoAU4Ahat2Qflv6z5YLeVCMz/hld1m1vg+FSapTj/
   DLdv+VLiANOqoXuowzKFctrY2Dh/WxPlp6pkG3/xpyrB8C76OcrUapEhd
   8jruvL5Jhc/XcAKk1O6w6iLNpmmN0l6ae0fh25LycoxjuUvwaQrlljNrF
   e1d29cCJW1JfSnl0BRq4cpM2pOACI1lGvoLS8LDLSaFD7b/sc3s0x6wWI
   Q==;
X-CSE-ConnectionGUID: fNdFSXVOTFSQi/CTN2eUDQ==
X-CSE-MsgGUID: wew0UFrvTUCNqIDjU+0FVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="84966873"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="84966873"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 10:49:10 -0700
X-CSE-ConnectionGUID: jbFMM9y+Tq6PDv7R2R2lFQ==
X-CSE-MsgGUID: 8/lLxlpUSH+LiY0FGuR4qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="204716167"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Oct 2025 10:49:07 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7HEn-00031v-11;
	Fri, 10 Oct 2025 17:49:05 +0000
Date: Sat, 11 Oct 2025 01:48:34 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] Drivers: hv: Add support for movable memory
 regions
Message-ID: <202510110134.RmOV83Fz-lkp@intel.com>
References: <175976319844.16834.4747024333732752980.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175976319844.16834.4747024333732752980.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

Hi Stanislav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20251010]
[cannot apply to v6.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Kinsburskii/Drivers-hv-Refactor-and-rename-memory-region-handling-functions/20251010-111917
base:   linus/master
patch link:    https://lore.kernel.org/r/175976319844.16834.4747024333732752980.stgit%40skinsburskii-cloud-desktop.internal.cloudapp.net
patch subject: [PATCH v4 5/5] Drivers: hv: Add support for movable memory regions
config: x86_64-randconfig-006-20251010 (https://download.01.org/0day-ci/archive/20251011/202510110134.RmOV83Fz-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110134.RmOV83Fz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110134.RmOV83Fz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hv/mshv_root_main.c:1410:11: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1410 |         else if (!mutex_trylock(&region->mutex))
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:1434:12: note: uninitialized use occurs here
    1434 |         WARN_ONCE(ret,
         |                   ^~~
   include/asm-generic/bug.h:152:18: note: expanded from macro 'WARN_ONCE'
     152 |         DO_ONCE_LITE_IF(condition, WARN, 1, format)
         |                         ^~~~~~~~~
   include/linux/once_lite.h:28:27: note: expanded from macro 'DO_ONCE_LITE_IF'
      28 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   drivers/hv/mshv_root_main.c:1410:7: note: remove the 'if' if its condition is always false
    1410 |         else if (!mutex_trylock(&region->mutex))
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1411 |                 goto out_fail;
         |                 ~~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:1406:9: note: initialize the variable 'ret' to silence this warning
    1406 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +1410 drivers/hv/mshv_root_main.c

  1377	
  1378	/**
  1379	 * mshv_region_interval_invalidate - Invalidate a range of memory region
  1380	 * @mni: Pointer to the mmu_interval_notifier structure
  1381	 * @range: Pointer to the mmu_notifier_range structure
  1382	 * @cur_seq: Current sequence number for the interval notifier
  1383	 *
  1384	 * This function invalidates a memory region by remapping its pages with
  1385	 * no access permissions. It locks the region's mutex to ensure thread safety
  1386	 * and updates the sequence number for the interval notifier. If the range
  1387	 * is blockable, it uses a blocking lock; otherwise, it attempts a non-blocking
  1388	 * lock and returns false if unsuccessful.
  1389	 *
  1390	 * NOTE: Failure to invalidate a region is a serious error, as the pages will
  1391	 * be considered freed while they are still mapped by the hypervisor.
  1392	 * Any attempt to access such pages will likely crash the system.
  1393	 *
  1394	 * Return: true if the region was successfully invalidated, false otherwise.
  1395	 */
  1396	static bool
  1397	mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
  1398					const struct mmu_notifier_range *range,
  1399					unsigned long cur_seq)
  1400	{
  1401		struct mshv_mem_region *region = container_of(mni,
  1402							struct mshv_mem_region,
  1403							mni);
  1404		u64 page_offset, page_count;
  1405		unsigned long mstart, mend;
  1406		int ret;
  1407	
  1408		if (mmu_notifier_range_blockable(range))
  1409			mutex_lock(&region->mutex);
> 1410		else if (!mutex_trylock(&region->mutex))
  1411			goto out_fail;
  1412	
  1413		mmu_interval_set_seq(mni, cur_seq);
  1414	
  1415		mstart = max(range->start, region->start_uaddr);
  1416		mend = min(range->end, region->start_uaddr +
  1417			   (region->nr_pages << HV_HYP_PAGE_SHIFT));
  1418	
  1419		page_offset = HVPFN_DOWN(mstart - region->start_uaddr);
  1420		page_count = HVPFN_DOWN(mend - mstart);
  1421	
  1422		ret = mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
  1423					      page_offset, page_count);
  1424		if (ret)
  1425			goto out_fail;
  1426	
  1427		mshv_region_invalidate_pages(region, page_offset, page_count);
  1428	
  1429		mutex_unlock(&region->mutex);
  1430	
  1431		return true;
  1432	
  1433	out_fail:
  1434		WARN_ONCE(ret,
  1435			  "Failed to invalidate region %#llx-%#llx (range %#lx-%#lx, event: %u, pages %#llx-%#llx, mm: %#llx): %d\n",
  1436			  region->start_uaddr,
  1437			  region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
  1438			  range->start, range->end, range->event,
  1439			  page_offset, page_offset + page_count - 1, (u64)range->mm, ret);
  1440		return false;
  1441	}
  1442	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

