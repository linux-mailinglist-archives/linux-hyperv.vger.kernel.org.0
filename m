Return-Path: <linux-hyperv+bounces-8598-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBFTHCdHfGn8LgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8598-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 06:52:39 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF60B77E6
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 06:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB028300C268
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 05:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EFE3783DB;
	Fri, 30 Jan 2026 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7LUwIzI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B012874E9;
	Fri, 30 Jan 2026 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769752357; cv=none; b=EX6JF/KaUEdsip9xVKs/7/qC+M8QweFPji5t1DfXH7vPp3WtPUm3PZfvGCW0u4pAQVnR6UX/GdhQNYmsBr3rc3BlqXkufYfvm5iQHEUWiOWx45zRODQMlT1AVRY0+9Z004HL8edRQ5HgsAuLvX7+ve0SLb1Z+u3DdnYk4K+Sld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769752357; c=relaxed/simple;
	bh=9ayXIsHcKJtGatNJ5F6AW00zSHoqpxpTsNBom1CuDLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEWroiW35cfge5kIxbRUomNYSKb5TmlRinsFOtX34v7Zeydj6GMe4384+04hCvItbh1sghIjXPjDMHIHEGy7cURqEHinKgY6i8yu5nuaFVBB5qlODhd60aSGg02SFVaPuElwCD9kL6Ug3EWugkIP5VtzvG3xGpqgNQv1+mVyRQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7LUwIzI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769752355; x=1801288355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ayXIsHcKJtGatNJ5F6AW00zSHoqpxpTsNBom1CuDLQ=;
  b=l7LUwIzIQnzFei0L4PNlQNn4EsdzWNyrZxoJY4W9IsDOWNx2YpS9Mu2h
   +m5QUo/Cvlg+1d2m1iZZP+oGCybXcY/bz2212rcJtdX8rArcDO4kW2+0Z
   yngwnpBBkQrcpwxEF/qTeCap+Xvs8L9yA9+YdIa5EDK0QIYWMEqcuThsO
   D/w/7XpVkJnoGmumhT0zZfOBIg494TPKPd5UmNgvzEUOPgnWAYXGY6P0o
   oCpd5gCj2AgsJ55LC8/bU407Ju2eGHe0/ro9Uu09Nb/ChUHUaHzjEoT5s
   /mjEjHV7X2FuhGda8BEqvj4ZjM+i2rg83MKsbjBigT8Y+T+ecVOkDa0eX
   A==;
X-CSE-ConnectionGUID: AhWc4P5pTe+SZUDuRRwleg==
X-CSE-MsgGUID: EwrgD8j+SPyGOiqKRpWzUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70718660"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="70718660"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:52:35 -0800
X-CSE-ConnectionGUID: pIfDgLSPTQqhHJkUIh1xjg==
X-CSE-MsgGUID: VTohgTu3RBGrkTKHaeXOfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="209192306"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 29 Jan 2026 21:52:32 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlhQj-00000000cEW-380R;
	Fri, 30 Jan 2026 05:52:29 +0000
Date: Fri, 30 Jan 2026 13:51:40 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com
Cc: oe-kbuild-all@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mshv: Add support for integrated scheduler
Message-ID: <202601301357.SWdA3gzf-lkp@intel.com>
References: <176971725312.67225.3938191771112866951.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176971725312.67225.3938191771112866951.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-8598-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: DCF60B77E6
X-Rspamd-Action: no action

Hi Stanislav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.19-rc7 next-20260129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Kinsburskii/mshv-Add-support-for-integrated-scheduler/20260130-041014
base:   linus/master
patch link:    https://lore.kernel.org/r/176971725312.67225.3938191771112866951.stgit%40skinsburskii-cloud-desktop.internal.cloudapp.net
patch subject: [PATCH v2] mshv: Add support for integrated scheduler
config: x86_64-randconfig-014-20260130 (https://download.01.org/0day-ci/archive/20260130/202601301357.SWdA3gzf-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260130/202601301357.SWdA3gzf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601301357.SWdA3gzf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hv/mshv_root_main.c: In function 'mshv_init_vmm_caps':
>> drivers/hv/mshv_root_main.c:2255:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    2255 |         if (ret && hv_l1vh_partition())
         |         ^~
   drivers/hv/mshv_root_main.c:2257:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    2257 |                 return ret;
         |                 ^~~~~~
   In file included from include/linux/printk.h:621,
                    from include/asm-generic/bug.h:31,
                    from arch/x86/include/asm/bug.h:193,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/segment.h:6,
                    from arch/x86/include/asm/ptrace.h:5,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from include/linux/sched.h:13,
                    from include/linux/resume_user_mode.h:6,
                    from include/linux/entry-virt.h:6,
                    from drivers/hv/mshv_root_main.c:11:
   drivers/hv/mshv_root_main.c: At top level:
   include/linux/dynamic_debug.h:228:58: error: expected identifier or '(' before 'do'
     228 | #define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {   \
         |                                                          ^~
   include/linux/dynamic_debug.h:259:9: note: in expansion of macro '__dynamic_func_call_cls'
     259 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:261:9: note: in expansion of macro '_dynamic_func_call_cls'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:284:9: note: in expansion of macro '_dynamic_func_call'
     284 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:2260:9: note: in expansion of macro 'dev_dbg'
    2260 |         dev_dbg(dev, "vmm_caps = %#llx\n", mshv_root.vmm_caps.as_uint64[0]);
         |         ^~~~~~~
   include/linux/dynamic_debug.h:234:3: error: expected identifier or '(' before 'while'
     234 | } while (0)
         |   ^~~~~
   include/linux/dynamic_debug.h:259:9: note: in expansion of macro '__dynamic_func_call_cls'
     259 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:261:9: note: in expansion of macro '_dynamic_func_call_cls'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:284:9: note: in expansion of macro '_dynamic_func_call'
     284 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:2260:9: note: in expansion of macro 'dev_dbg'
    2260 |         dev_dbg(dev, "vmm_caps = %#llx\n", mshv_root.vmm_caps.as_uint64[0]);
         |         ^~~~~~~
   drivers/hv/mshv_root_main.c:2262:9: error: expected identifier or '(' before 'return'
    2262 |         return 0;
         |         ^~~~~~
   drivers/hv/mshv_root_main.c:2263:1: error: expected identifier or '(' before '}' token
    2263 | }
         | ^


vim +/if +2255 drivers/hv/mshv_root_main.c

  2246	
  2247	static int __init mshv_init_vmm_caps(struct device *dev)
  2248	{
  2249		int ret;
  2250	
  2251		ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
  2252							HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
  2253							0, &mshv_root.vmm_caps,
  2254							sizeof(mshv_root.vmm_caps));
> 2255		if (ret && hv_l1vh_partition())
  2256			dev_err(dev, "Failed to get VMM capabilities: %d\n", ret);
  2257			return ret;
  2258		}
  2259	
  2260		dev_dbg(dev, "vmm_caps = %#llx\n", mshv_root.vmm_caps.as_uint64[0]);
  2261	
  2262		return 0;
  2263	}
  2264	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

