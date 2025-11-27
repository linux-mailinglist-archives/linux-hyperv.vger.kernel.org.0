Return-Path: <linux-hyperv+bounces-7888-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7516C8DE19
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 12:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271343B051D
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 11:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D1032BF44;
	Thu, 27 Nov 2025 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqPIGZoI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350A432BF4B;
	Thu, 27 Nov 2025 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241235; cv=none; b=oKhhn48jaK4hBAEjS8uoV/LLVSDB4ViQbLOxs1MMEYPVRlQuxBKeMKPtZUNU4er0yvlWg4PQEJshI7+uzugmkhusRioK4ckP5Yv4tKp4mpHRUk7ykaeht3DWCyiu6XEPiXOoskPRjBwHvJzStWhwyEgwBxKwehYzGNDvkvUyb8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241235; c=relaxed/simple;
	bh=dT5dgnRoPrC0AeAU/X1RLK/suvJYvfiAZrWAJS3CiRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJTNu8aYCmRIXLZ1t5lb6dG6IogYKW2Dpqft4WYYok/aoB8nblnptjnmzSBKrBcNhXPUv4Ev1RJutevPIjIRo+OxxRlmEl6/Hq9Kyj5yXLuFhhqiJBBsajB0L0IrLRDsqizD+0AGUEXPu2gsUjZUi6fZFwFNfLtiAkOZ7T5mSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqPIGZoI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764241233; x=1795777233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dT5dgnRoPrC0AeAU/X1RLK/suvJYvfiAZrWAJS3CiRY=;
  b=MqPIGZoINgHm2bOf1E1jNNvbEEQ0zyf12dHEQeqZPFvlceuVpOVYVagT
   ZSHuNkgXAQ7F90/Vfce/3u69aap8elMYJP9p/Ao4NL2jaP6oF9AVMHPhl
   6oIoLLOB2Uz/6iTT15/EICpHJ7BpYRL/hwR6J7BI60v8HWbmk24+3A6c/
   xUqaQltlx1Zxn4Ahq9CLlOPxQZ72ZFdORgxjHm/XkYpJHpTRLiPPHAdm1
   7IXMRZ/K8Zh4d8TG4CzEE9JR5j3FZ9Hu01jA/L1IMvwylb3obiEW+IILT
   HmyrcyixNEt5SQkAU4zGialbRJckpmj3wawI62uVYbVyKFYXowUMEYN3N
   A==;
X-CSE-ConnectionGUID: UTG94aq+Tj6ndNb3vkNj4w==
X-CSE-MsgGUID: ADf4gkv+QQqZv/N9SG+Ojg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66232521"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="66232521"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 03:00:32 -0800
X-CSE-ConnectionGUID: uRQST8YwQcmgCY8W+h6+4w==
X-CSE-MsgGUID: ik2gjc/UR5meKJv3oGscCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="197361790"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 27 Nov 2025 03:00:30 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOZjg-000000004eL-0qoO;
	Thu, 27 Nov 2025 11:00:28 +0000
Date: Thu, 27 Nov 2025 18:59:54 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/7] Drivers: hv: Fix huge page handling in memory
 region traversal
Message-ID: <202511271830.nH1cbyQI-lkp@intel.com>
References: <176412295155.447063.16512843211428609586.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176412295155.447063.16512843211428609586.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

Hi Stanislav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20251125]
[cannot apply to linus/master v6.18-rc7 v6.18-rc6 v6.18-rc5 v6.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Kinsburskii/Drivers-hv-Refactor-and-rename-memory-region-handling-functions/20251126-101138
base:   next-20251125
patch link:    https://lore.kernel.org/r/176412295155.447063.16512843211428609586.stgit%40skinsburskii-cloud-desktop.internal.cloudapp.net
patch subject: [PATCH v7 4/7] Drivers: hv: Fix huge page handling in memory region traversal
config: x86_64-randconfig-076-20251127 (https://download.01.org/0day-ci/archive/20251127/202511271830.nH1cbyQI-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251127/202511271830.nH1cbyQI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511271830.nH1cbyQI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hv/mshv_regions.c:288:12: warning: parameter 'flags' set but not used [-Wunused-but-set-parameter]
     288 |                                    u32 flags,
         |                                        ^
   1 warning generated.


vim +/flags +288 drivers/hv/mshv_regions.c

   286	
   287	static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
 > 288					   u32 flags,
   289					   u64 page_offset, u64 page_count)
   290	{
   291		if (PageTransCompound(region->pages[page_offset]))
   292			flags |= HV_UNMAP_GPA_LARGE_PAGE;
   293	
   294		return hv_call_unmap_gpa_pages(region->partition->pt_id,
   295					       region->start_gfn + page_offset,
   296					       page_count, 0);
   297	}
   298	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

