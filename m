Return-Path: <linux-hyperv+bounces-2063-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E87C8BA1B4
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 May 2024 22:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7361C20D0D
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 May 2024 20:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722CD17334D;
	Thu,  2 May 2024 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckinjorO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11DE2208E;
	Thu,  2 May 2024 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714683002; cv=none; b=cU5P6H+zhWaJf0Up/x7y4OQ4QUeAO+TkLgF/eSzdcwcDvfGhF8HXFScjEElEAz+GqM6PAydGfmov8hxjovpDXNV7zY+UGtKAViosVuu0p04hTXA6XV3hTQhVuZQUdPVLsc2Njj2ot3If1Y0GYIzHwwXQd0S/wX/kLqnJae0KecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714683002; c=relaxed/simple;
	bh=0SgizC1Y0lmfxm5NoqKC6RLPpXXXmFw026aeWK/JY1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXm9i3jtaOKFaYjZcIX5P8Jc8N70lY6Wu5c4AhxzG49fU+dEeS/vAe0eTnlmf9UUvuMjsZVWhoPg+FrqiffE97AFAs4eEoNo8askt4KgCAhweXf9tk0qV1nBHJ4xE/tSBNwJPXn/Q+wEyplUhRdP6SLG2eLwJi/SYuUmsv+TjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckinjorO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714683001; x=1746219001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0SgizC1Y0lmfxm5NoqKC6RLPpXXXmFw026aeWK/JY1E=;
  b=ckinjorO0ln3XnWW11rN7yn1vq1SGi9uXpx9L3C/cM31VbvXD3TRLoe5
   8lzz1tUOPAlPfeRE9dbKEMnpjyfUwDay+W+eXMBOZioXa1jEvz3R/7JtD
   DRgS6mwfJHpJ63VtQDxQOrVY/61/JR8CqLRiWATX1M5pNn0lnBUZrq0kI
   5njVJq+z8LJqdZ1BcvRzpKXUviRz7+65LfOc+WqsrJI9fys5AVe+MGxDh
   jmOXRZOsAjUpvsBZEosKAfyZ+PTIbDKRRT0S7sX6cPW30TQ19Yx+TH1ei
   SThRDPLjYmgBcdrxkSErDdiaq9pbMnSwdnGV0VRUHgB8Y5v2Zf7/BMr5B
   w==;
X-CSE-ConnectionGUID: 8/m6VqLvT5iIHjSLWp9lOA==
X-CSE-MsgGUID: Tfnb/P0sRP+TAvmc9czHcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="27960317"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27960317"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 13:50:00 -0700
X-CSE-ConnectionGUID: YvSG6rCISFqpWzwKjhrCTg==
X-CSE-MsgGUID: zqdyjlYTQwiVgj1YjeZ76A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27748040"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 02 May 2024 13:49:58 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2dNL-000Ayy-3A;
	Thu, 02 May 2024 20:49:55 +0000
Date: Fri, 3 May 2024 04:49:20 +0800
From: kernel test robot <lkp@intel.com>
To: mhkelley58@gmail.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, david@redhat.com
Subject: Re: [PATCH v2 2/2] hv_balloon: Enable hot-add for memblock sizes >
 128 MiB
Message-ID: <202405030421.x7E4hUI7-lkp@intel.com>
References: <20240501151458.2807-2-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501151458.2807-2-mhklinux@outlook.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.9-rc6 next-20240502]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/mhkelley58-gmail-com/hv_balloon-Enable-hot-add-for-memblock-sizes-128-MiB/20240501-232643
base:   linus/master
patch link:    https://lore.kernel.org/r/20240501151458.2807-2-mhklinux%40outlook.com
patch subject: [PATCH v2 2/2] hv_balloon: Enable hot-add for memblock sizes > 128 MiB
config: i386-randconfig-011-20240502 (https://download.01.org/0day-ci/archive/20240503/202405030421.x7E4hUI7-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405030421.x7E4hUI7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405030421.x7E4hUI7-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/hv/hv_balloon.o: in function `init_balloon_drv':
>> drivers/hv/hv_balloon.c:2147:(.init.text+0x4): undefined reference to `memory_block_size_bytes'


vim +2147 drivers/hv/hv_balloon.c

  2136	
  2137	static int __init init_balloon_drv(void)
  2138	{
  2139		/*
  2140		 * Hot-add must operate in chunks that are of size
  2141		 * equal to the memory block size because that's
  2142		 * what the core add_memory() interface requires.
  2143		 * The Hyper-V interface requires that the memory block
  2144		 * size be a power of 2, which is guaranteed by the
  2145		 * check in memory_dev_init().
  2146		 */
> 2147		ha_pages_in_chunk = memory_block_size_bytes() / PAGE_SIZE;
  2148	
  2149		return vmbus_driver_register(&balloon_drv);
  2150	}
  2151	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

