Return-Path: <linux-hyperv+bounces-5657-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4323BAC2E17
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 May 2025 09:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABB11BA12F2
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 May 2025 07:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F071DF723;
	Sat, 24 May 2025 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdtUCsrr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29B14AD2D;
	Sat, 24 May 2025 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748071716; cv=none; b=lEnwg0Si4vC6tfyY+JMAiiaCDb3bgbuiTVUFMD6skIbdZ4sRHpFylyf11XoXdoKcafwMoxBqqk2mTMfUDPmfrh0jx/lyEiGjCyzGxT++u6dCnLh4nVFJ53tbGtDLl8d6jp2MsyKmH6Lbn6AhraR/ompnX7DLTwN20WlVqGW3S8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748071716; c=relaxed/simple;
	bh=08Ha9ZQm/alwbTSKW0NzYSY0G7SJtdgIjtObu/iwA7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYzsT/oLswEJQaXVC6NB2SGmgZsvRBEkCzExXdeXc4avypJCbDV7xONhDv1YQlMZ78rXPmdkhpcYuUOeskk0t3UR5v5kKdGEsFizpJHGex9MfF0ZxHiP4xt5TPm/TyEmYXT4Av+6MxgimTuW3RzamK5F4F2R1dsQFjyQduQmiv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdtUCsrr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748071715; x=1779607715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=08Ha9ZQm/alwbTSKW0NzYSY0G7SJtdgIjtObu/iwA7I=;
  b=bdtUCsrrFeMd7/8lD/z5AckFs2OGQZotraxrQM3ft8MDFRjSi9Bt/ymx
   Z1ig1mC385+Q4AdIYP+I7v865zI2m3sPCv/teFH3UpSVW8FoQL9+fiRN0
   r645hgQ+Pl7F1LifLXDBaDOYRpNyUbRQhLSbqjRBsavNQRqZzE+jpuoyc
   thsPP3Q1XZQq7PmG8OC9kh0e/ZFzROaVQpTlJCjw69y4UKXzgHVAeyD2l
   VzXI8e+UgCeXkiwSf3GJQX8izBQsPq1bD+EEZRJet6uW023XVClNlCGED
   oYog3eKePN4a6+YK3YZH1T961/uMvWrQ4HWsmTbBYYScVmoOPF4UuAxfP
   w==;
X-CSE-ConnectionGUID: FVaYBiajQEy3HtuaCrUrWg==
X-CSE-MsgGUID: qdV1amjKT1S2VogjOGHCaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50271793"
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="50271793"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 00:28:34 -0700
X-CSE-ConnectionGUID: E2J9CX0ERb6Kjnh+WjoNBg==
X-CSE-MsgGUID: Oi0FgC3LQQ++LyK+M10u1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="141381350"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 24 May 2025 00:28:30 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIjIx-000R1I-2w;
	Sat, 24 May 2025 07:28:27 +0000
Date: Sat, 24 May 2025 15:28:27 +0800
From: kernel test robot <lkp@intel.com>
To: mhkelley58@gmail.com, simona@ffwll.ch, deller@gmx.de,
	haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, weh@microsoft.com, tzimmermann@suse.de,
	hch@lst.de, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 3/4] fbdev/deferred-io: Support contiguous kernel
 memory framebuffers
Message-ID: <202505241553.VSXoFOvX-lkp@intel.com>
References: <20250523161522.409504-4-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523161522.409504-4-mhklinux@outlook.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.15-rc7 next-20250523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/mhkelley58-gmail-com/mm-Export-vmf_insert_mixed_mkwrite/20250524-001707
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250523161522.409504-4-mhklinux%40outlook.com
patch subject: [PATCH v3 3/4] fbdev/deferred-io: Support contiguous kernel memory framebuffers
config: arm-randconfig-001-20250524 (https://download.01.org/0day-ci/archive/20250524/202505241553.VSXoFOvX-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250524/202505241553.VSXoFOvX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505241553.VSXoFOvX-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "vmf_insert_pfn" [drivers/video/fbdev/core/fb.ko] undefined!
>> ERROR: modpost: "vmf_insert_mixed_mkwrite" [drivers/video/fbdev/core/fb.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

