Return-Path: <linux-hyperv+bounces-8600-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG3yK9/JfGnaOgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8600-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 16:10:23 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6A1BBE34
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 16:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 809CD300AB30
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 15:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A605034F474;
	Fri, 30 Jan 2026 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6dXAS0d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11234314A83;
	Fri, 30 Jan 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769785821; cv=none; b=Z/5duLcaYeoHl2jQxzC9i+s7t5CE8k/LehIdkqdoOxYrwKiUUQwinEY2cgJNWgSe03z/gd6KssDsgk+QU4L8gj4rzfzn7sS2qGNs2Fuhsft0ZE+Ip84wZCVkWp70bbBbq2Ds1p/gBPA0RqOUNIOFkHfe0Ku7oJ1/5i8Bt0Oop1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769785821; c=relaxed/simple;
	bh=Tk+4n5bagQc1C4YDearYoI/yMNEgljf3iNZ/nmG4k8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEdIwUPDfyIPQrxWTXJxuFquh7MxEJKj8hy0071f9JXpGcZLrYfHVo2OA18JgMPjnulogVzbspOPGPacI8aB49ZeFn2VXBcQwxCq8thCf9TNvI/UTWUPs4337FSNbaS1DADFwYmxb6QT8BQCheKedf9QbP2glXbpV9qI6AFrgvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6dXAS0d; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769785820; x=1801321820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tk+4n5bagQc1C4YDearYoI/yMNEgljf3iNZ/nmG4k8Q=;
  b=L6dXAS0d1XUtMEh7aoHPEaRa9tOAdlmFEtC23v1wmcxsq/F4KaNHDS5/
   w+qLC4RRob0hTb/KrwL9aXRNPBcUeJaUY/tvZPYW6OtTQTaKKiQBohIV0
   DxECC82lgKRwxm/m/VEaDhGeGlFqBecG0G9sg46430dl0tRor8FrTcXVK
   gr7MKns7Dsqsen3EKCuPQrd3qMg7g0qyUE7G0M1J6cmsRRZTpKnJKyhh6
   5VC+Bq+G3BFsEYMhQx9mO8nTn7ygAwlYoHAXgFVUWW9TaORlb7Fgy4Zc4
   1Sc4YdZWcJHPIWS7lh9N2QqdbGsa9JtteiXU83Hz8nZ2y+zNLRKc6DqNA
   g==;
X-CSE-ConnectionGUID: fG3mwN9CRS69qHwSi14eMQ==
X-CSE-MsgGUID: rtQ/zqpdQEKj4i5v3i8Xbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="73636617"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="73636617"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 07:10:19 -0800
X-CSE-ConnectionGUID: uMyE01xhTGqOzOsd7xxxvg==
X-CSE-MsgGUID: V849l9CKQpS77pKHW9S/Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="209124436"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Jan 2026 07:10:15 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlq8U-00000000d4O-2luX;
	Fri, 30 Jan 2026 15:10:14 +0000
Date: Fri, 30 Jan 2026 23:09:39 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com
Cc: oe-kbuild-all@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mshv: Add support for integrated scheduler
Message-ID: <202601302238.nUbp7p58-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-8600-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 2B6A1BBE34
X-Rspamd-Action: no action

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.19-rc7 next-20260129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Kinsburskii/mshv-Add-support-for-integrated-scheduler/20260130-041014
base:   linus/master
patch link:    https://lore.kernel.org/r/176971725312.67225.3938191771112866951.stgit%40skinsburskii-cloud-desktop.internal.cloudapp.net
patch subject: [PATCH v2] mshv: Add support for integrated scheduler
config: x86_64-randconfig-002-20260130 (https://download.01.org/0day-ci/archive/20260130/202601302238.nUbp7p58-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260130/202601302238.nUbp7p58-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601302238.nUbp7p58-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hv/mshv_root_main.c: In function 'mshv_init_vmm_caps':
   drivers/hv/mshv_root_main.c:2255:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    2255 |         if (ret && hv_l1vh_partition())
         |         ^~
   drivers/hv/mshv_root_main.c:2257:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    2257 |                 return ret;
         |                 ^~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/blk_types.h:11,
                    from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:23,
                    from include/linux/resume_user_mode.h:8,
                    from include/linux/entry-virt.h:6,
                    from drivers/hv/mshv_root_main.c:11:
   drivers/hv/mshv_root_main.c: At top level:
>> include/linux/dev_printk.h:137:10: error: expected identifier or '(' before '{' token
     137 |         ({                                                              \
         |          ^
   include/linux/dev_printk.h:171:9: note: in expansion of macro 'dev_no_printk'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:2260:9: note: in expansion of macro 'dev_dbg'
    2260 |         dev_dbg(dev, "vmm_caps = %#llx\n", mshv_root.vmm_caps.as_uint64[0]);
         |         ^~~~~~~
   drivers/hv/mshv_root_main.c:2262:9: error: expected identifier or '(' before 'return'
    2262 |         return 0;
         |         ^~~~~~
   drivers/hv/mshv_root_main.c:2263:1: error: expected identifier or '(' before '}' token
    2263 | }
         | ^


vim +137 include/linux/dev_printk.h

af628aae8640c26 Greg Kroah-Hartman 2019-12-09   99  
ad7d61f159db739 Chris Down         2021-06-15  100  /*
ad7d61f159db739 Chris Down         2021-06-15  101   * Need to take variadic arguments even though we don't use them, as dev_fmt()
ad7d61f159db739 Chris Down         2021-06-15  102   * may only just have been expanded and may result in multiple arguments.
ad7d61f159db739 Chris Down         2021-06-15  103   */
ad7d61f159db739 Chris Down         2021-06-15  104  #define dev_printk_index_emit(level, fmt, ...) \
ad7d61f159db739 Chris Down         2021-06-15  105  	printk_index_subsys_emit("%s %s: ", level, fmt)
ad7d61f159db739 Chris Down         2021-06-15  106  
ad7d61f159db739 Chris Down         2021-06-15  107  #define dev_printk_index_wrap(_p_func, level, dev, fmt, ...)		\
ad7d61f159db739 Chris Down         2021-06-15  108  	({								\
ad7d61f159db739 Chris Down         2021-06-15  109  		dev_printk_index_emit(level, fmt);			\
ad7d61f159db739 Chris Down         2021-06-15  110  		_p_func(dev, fmt, ##__VA_ARGS__);			\
ad7d61f159db739 Chris Down         2021-06-15  111  	})
ad7d61f159db739 Chris Down         2021-06-15  112  
ad7d61f159db739 Chris Down         2021-06-15  113  /*
ad7d61f159db739 Chris Down         2021-06-15  114   * Some callsites directly call dev_printk rather than going through the
ad7d61f159db739 Chris Down         2021-06-15  115   * dev_<level> infrastructure, so we need to emit here as well as inside those
ad7d61f159db739 Chris Down         2021-06-15  116   * level-specific macros. Only one index entry will be produced, either way,
ad7d61f159db739 Chris Down         2021-06-15  117   * since dev_printk's `fmt` isn't known at compile time if going through the
ad7d61f159db739 Chris Down         2021-06-15  118   * dev_<level> macros.
ad7d61f159db739 Chris Down         2021-06-15  119   *
ad7d61f159db739 Chris Down         2021-06-15  120   * dev_fmt() isn't called for dev_printk when used directly, as it's used by
ad7d61f159db739 Chris Down         2021-06-15  121   * the dev_<level> macros internally which already have dev_fmt() processed.
ad7d61f159db739 Chris Down         2021-06-15  122   *
ad7d61f159db739 Chris Down         2021-06-15  123   * We also can't use dev_printk_index_wrap directly, because we have a separate
ad7d61f159db739 Chris Down         2021-06-15  124   * level to process.
ad7d61f159db739 Chris Down         2021-06-15  125   */
ad7d61f159db739 Chris Down         2021-06-15  126  #define dev_printk(level, dev, fmt, ...)				\
ad7d61f159db739 Chris Down         2021-06-15  127  	({								\
ad7d61f159db739 Chris Down         2021-06-15  128  		dev_printk_index_emit(level, fmt);			\
ad7d61f159db739 Chris Down         2021-06-15  129  		_dev_printk(level, dev, fmt, ##__VA_ARGS__);		\
ad7d61f159db739 Chris Down         2021-06-15  130  	})
ad7d61f159db739 Chris Down         2021-06-15  131  
c26ec799042a388 Geert Uytterhoeven 2024-02-28  132  /*
c26ec799042a388 Geert Uytterhoeven 2024-02-28  133   * Dummy dev_printk for disabled debugging statements to use whilst maintaining
c26ec799042a388 Geert Uytterhoeven 2024-02-28  134   * gcc's format checking.
c26ec799042a388 Geert Uytterhoeven 2024-02-28  135   */
c26ec799042a388 Geert Uytterhoeven 2024-02-28  136  #define dev_no_printk(level, dev, fmt, ...)				\
c26ec799042a388 Geert Uytterhoeven 2024-02-28 @137  	({								\
c26ec799042a388 Geert Uytterhoeven 2024-02-28  138  		if (0)							\
c26ec799042a388 Geert Uytterhoeven 2024-02-28  139  			_dev_printk(level, dev, fmt, ##__VA_ARGS__);	\
c26ec799042a388 Geert Uytterhoeven 2024-02-28  140  	})
c26ec799042a388 Geert Uytterhoeven 2024-02-28  141  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

