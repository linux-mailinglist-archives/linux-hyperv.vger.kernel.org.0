Return-Path: <linux-hyperv+bounces-7418-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E5FC39BEB
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 10:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA73C3B12D4
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C04930B502;
	Thu,  6 Nov 2025 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3RYq7mk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF2D30AD0E;
	Thu,  6 Nov 2025 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420010; cv=none; b=HMQYRWbMFq0SxKGoPLUmQ9WSu/PcWY/mX+E8MakNJg8ay41OFFqE4ZYyod4LU/m2y8BKwiPRZY9RQcHmlnQv8C/6h04JM/urRAG9ELcCNYYziAF0e+pUKjnzMkByqwis6uappuFIRfoc3GEoxTs2Q4FXDST9cH9O3swIIN6pjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420010; c=relaxed/simple;
	bh=CnL3lN9mkZ8LWgkzjBndu8y6E24o67CkMmSKjFPAyK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMTZZclwMdKDFHNGYkTS02Ht7w/HGQZjL8HjoE9Vi9oBbrRR90jqis+aVSeNzDt6yLUsuI6GJm4PSUbVASAuXlC/2J+R5dHwN5btrXCZh2rB9ZzCcfq+wq3cuZxjYFzcCtzJv1SSpKMbcos/goSRlF2i5BlQLIfH9RdboQ4xaFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3RYq7mk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762420008; x=1793956008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CnL3lN9mkZ8LWgkzjBndu8y6E24o67CkMmSKjFPAyK4=;
  b=d3RYq7mkQ0r/Z13X+54PlZb61CNXzf3Lr6cGZ7sdwViAcXpcAfdOqfZr
   738t2bVelW6O95djV93eT+/VKhwAtH5s16gakhHkuVVniJu20Hj9yEtuO
   2EUOgpKH9/ws/ktN3fXxpYIqT1AlKOhuB8vXCeqxhma7NajeTeegXdSKJ
   N8t4daZa2g7H5Yh7eWuF7btYX2dDFIejyxCCTvGEk9w2QiUTM8PNydKmj
   W9K16CQrMmtklq2XKcpdrsuGbk/PMFOVHr7g5FSXFGtj0i94vipj0/jnB
   W4UczDkX1xE0RY5uMIfWh9Q7FqTvDBqMuEoV15b0n0YZxxdEjPFTf+E7f
   Q==;
X-CSE-ConnectionGUID: 0RZOmoxaTDaImBaLsqpQnQ==
X-CSE-MsgGUID: dU0295/XTEacdreXuK8jcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64702268"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64702268"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 01:06:48 -0800
X-CSE-ConnectionGUID: R3RHKMRLSFevXho5L2LLYg==
X-CSE-MsgGUID: qxSppPrRS0ixYHtcy9KRvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="186958135"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 06 Nov 2025 01:06:44 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGvx3-000ThY-2V;
	Thu, 06 Nov 2025 09:06:41 +0000
Date: Thu, 6 Nov 2025 17:06:39 +0800
From: kernel test robot <lkp@intel.com>
To: Ally Heev <allyheev@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
	Ally Heev <allyheev@gmail.com>
Subject: Re: [PATCH] net: ethernet: fix uninitialized pointers with free attr
Message-ID: <202511061627.TYBaNPrX-lkp@intel.com>
References: <20251105-aheev-uninitialized-free-attr-net-ethernet-v1-1-f6ea84bbd750@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-aheev-uninitialized-free-attr-net-ethernet-v1-1-f6ea84bbd750@gmail.com>

Hi Ally,

kernel test robot noticed the following build errors:

[auto build test ERROR on c9cfc122f03711a5124b4aafab3211cf4d35a2ac]

url:    https://github.com/intel-lab-lkp/linux/commits/Ally-Heev/net-ethernet-fix-uninitialized-pointers-with-free-attr/20251105-192022
base:   c9cfc122f03711a5124b4aafab3211cf4d35a2ac
patch link:    https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-net-ethernet-v1-1-f6ea84bbd750%40gmail.com
patch subject: [PATCH] net: ethernet: fix uninitialized pointers with free attr
config: x86_64-randconfig-015-20251106 (https://download.01.org/0day-ci/archive/20251106/202511061627.TYBaNPrX-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511061627.TYBaNPrX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511061627.TYBaNPrX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/objtool_types.h:7,
                    from include/linux/objtool.h:5,
                    from arch/x86/include/asm/bug.h:7,
                    from include/linux/bug.h:5,
                    from include/linux/vfsdebug.h:5,
                    from include/linux/fs.h:5,
                    from include/linux/debugfs.h:15,
                    from drivers/net/ethernet/microsoft/mana/gdma_main.c:4:
   drivers/net/ethernet/microsoft/mana/gdma_main.c: In function 'irq_setup':
>> include/linux/stddef.h:8:14: error: invalid initializer
       8 | #define NULL ((void *)0)
         |              ^
   drivers/net/ethernet/microsoft/mana/gdma_main.c:1508:55: note: in expansion of macro 'NULL'
    1508 |         cpumask_var_t cpus __free(free_cpumask_var) = NULL;
         |                                                       ^~~~


vim +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

