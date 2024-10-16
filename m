Return-Path: <linux-hyperv+bounces-3144-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2287B9A0010
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Oct 2024 06:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDF91F2485F
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Oct 2024 04:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E06187FFE;
	Wed, 16 Oct 2024 04:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYt+p17I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED2176237;
	Wed, 16 Oct 2024 04:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052199; cv=none; b=IgdDCZkrAKVN2Sou3H0HtlAVCiU0Iwfzfj7pbwnupqTJz+0k8CDgy7xliM9Q+qsFiL6RKhP0BEpjUPqIzWHqePgELEZw7JNQloir37cPo2ZHXC5u+ZF6mpQxvGFv/uccIf9Z559ybNxGmZw2MyggwwrOTeIHwU5Zlws+zHPblos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052199; c=relaxed/simple;
	bh=fApJPViSnVnUPduPjqML3pPIe4dfeyPrEvIDA+ILuiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTRyZiRppIW0gpB0FHFzvtSsTRW40pb97DT11L0ZAHKQaXntQUiyP/qNAquQHDbY075V8Hhnou/LY+BerNm9iacz15nq/QSijwy+7Lf/HNT+I4ZSNhWD0PxztodV+aiggaZzw4qKpJefk+j5476FIY/9g1QIjYW9bteSrG1NI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYt+p17I; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729052198; x=1760588198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fApJPViSnVnUPduPjqML3pPIe4dfeyPrEvIDA+ILuiA=;
  b=QYt+p17I3de3wwNpXfcoCR+7bA5xFeJKIK30m10Hvr/YPoJ6Is5e40Xz
   e1pVbqJbzE+C3KKb3OzsE1Rdmjcsi+d0RkUzFFEARSWwvmtMmc4meRdYx
   bHiz9pxV5DORoJ08rei41Y7lYlPQ0/GvBHT6yKt+BomTAoiiVQMWchbzA
   H3vw2TyCYIl5UAUfMJ8zkzwkyMOMUlTKgrGwvL52Je60haKkLlV8oe9/a
   ijm5R1XVNdORxBDg+Pf1dIIAphtGUOlEK3GHz6RUuYkx8eADeZf4UhMrc
   IWxv3baruMF5qdrM00xY8GnoiMHBxW9ly470wN+76KsCZe4vEjOK/cxTm
   Q==;
X-CSE-ConnectionGUID: OuT3cbdwRYW9JM2LCGbhpw==
X-CSE-MsgGUID: dxAAIt/ZQJyHFaw7E+s9Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32173958"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32173958"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 21:16:36 -0700
X-CSE-ConnectionGUID: OBgDhTGyQ7u54DHtik8BXw==
X-CSE-MsgGUID: OPbKD1XCSzKn+RXSNqqFSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="83180175"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 Oct 2024 21:16:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0vSY-000KGn-1p;
	Wed, 16 Oct 2024 04:16:30 +0000
Date: Wed, 16 Oct 2024 12:16:18 +0800
From: kernel test robot <lkp@intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hv: hyperv.h: Annotate vmbus_channel_gpadl_header with
 __counted_by()
Message-ID: <202410161148.ODpoEJF0-lkp@intel.com>
References: <20241015101829.94876-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015101829.94876-2-thorsten.blum@linux.dev>

Hi Thorsten,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/pstore]
[also build test WARNING on kees/for-next/kspp linus/master v6.12-rc3 next-20241015]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thorsten-Blum/hv-hyperv-h-Annotate-vmbus_channel_gpadl_header-with-__counted_by/20241015-182055
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/20241015101829.94876-2-thorsten.blum%40linux.dev
patch subject: [PATCH] hv: hyperv.h: Annotate vmbus_channel_gpadl_header with __counted_by()
config: arm64-randconfig-001-20241016 (https://download.01.org/0day-ci/archive/20241016/202410161148.ODpoEJF0-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bfe84f7085d82d06d61c632a7bad1e692fd159e4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410161148.ODpoEJF0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410161148.ODpoEJF0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/hyperv/hv_core.c:13:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm64/hyperv/hv_core.c:14:
>> include/linux/hyperv.h:646:2: warning: 'counted_by' should not be applied to an array with element of unknown size because 'struct gpa_range' is a struct type with a flexible array member. This will be an error in a future compiler version [-Wbounds-safety-counted-by-elt-type-unknown-size]
     646 |         struct gpa_range range[] __counted_by(rangecount);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   6 warnings generated.


vim +646 include/linux/hyperv.h

   633	
   634	/*
   635	 * The number of PFNs in a GPADL message is defined by the number of
   636	 * pages that would be spanned by ByteCount and ByteOffset.  If the
   637	 * implied number of PFNs won't fit in this packet, there will be a
   638	 * follow-up packet that contains more.
   639	 */
   640	struct vmbus_channel_gpadl_header {
   641		struct vmbus_channel_message_header header;
   642		u32 child_relid;
   643		u32 gpadl;
   644		u16 range_buflen;
   645		u16 rangecount;
 > 646		struct gpa_range range[] __counted_by(rangecount);
   647	} __packed;
   648	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

