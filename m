Return-Path: <linux-hyperv+bounces-8599-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LkaEAt3fGmWNAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8599-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 10:16:59 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5105EB8CB7
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 10:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89CE5300F9F0
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C48326D76;
	Fri, 30 Jan 2026 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLeZoEVi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4B18A6D4;
	Fri, 30 Jan 2026 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764610; cv=none; b=dAkmH3DxNxvM3vDDrfi/z0NKBqdzlL+cgfHi/CzwniacQjoXXdQFai10MDuV1TVHlrOszrToYvcRWvn7tnYp26LpK9B2wyFjJ3JY9TfNRh1BVtJKw9pFz5HEijiziSDb2vUGTq+FAhHWyFZwrXy+HUCTZVy8q97/h+xr84g7QB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764610; c=relaxed/simple;
	bh=BBsy+STOjQXoX+872fpKKMUeLGy7GrZywVTivm6NlU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM83bGn6NyiHQNGaqgQBcpXFXdSHo/TAJQfTs3MVPwCf78IEQ+nI8+FHcqOMhlrnjorFqbCtVaee/9SykbWsixXvYE8MgDd3mbB2DOlvaTOaZObwN6QcqubVf9xSaO0ng9qZTM3VJn9OzwPrt52NTo7NxRaon+qpkU5M/uCvPQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLeZoEVi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769764608; x=1801300608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BBsy+STOjQXoX+872fpKKMUeLGy7GrZywVTivm6NlU8=;
  b=TLeZoEViYWUNIgirXw15puSuRy2ImhFcfMapJnEHjyQdlbjnXAXQDB2t
   BoY/52rHBqi8Gc/XvhnUO9EdT9W0VC5dQjlk17RACoqwCix3hhcQPHHel
   Zw32uyr6gr/Z7woY79iDzeTS50c1IPotA82SJHrF8PTB+A+Fc1/6HFH2L
   1Vb9dYwONsjuvb4mUnIzEwb8IrnROGkTfKUBRxvoZz+2isBRmk606rU1b
   WJIZ4PeXanWfVBCAJPy/JYdXNotRsfOG6r0owi3EDlQDtFaQetvpZ8qIl
   JR31HViMV+Ujnap791ykzPr2/A2nbzZhJq4hIqNNrzDQB1EhROrI5juCu
   A==;
X-CSE-ConnectionGUID: BslWkVq1QJmmMvYVFlDOMg==
X-CSE-MsgGUID: wqudDHnzRXeaV1gwp4JRUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70992407"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="70992407"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 01:16:47 -0800
X-CSE-ConnectionGUID: jwbqCRiKSuulYSBh9+RPlg==
X-CSE-MsgGUID: g6H9NWmVRMeHNXpaXaA9kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="208407269"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 30 Jan 2026 01:16:45 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlkcM-00000000cQm-297A;
	Fri, 30 Jan 2026 09:16:42 +0000
Date: Fri, 30 Jan 2026 17:15:43 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mshv: Add support for integrated scheduler
Message-ID: <202601301732.2k4q81GI-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-8599-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 5105EB8CB7
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
config: x86_64-buildonly-randconfig-004-20260130 (https://download.01.org/0day-ci/archive/20260130/202601301732.2k4q81GI-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260130/202601301732.2k4q81GI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601301732.2k4q81GI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hv/mshv_root_main.c:2260:2: error: expected identifier or '('
    2260 |         dev_dbg(dev, "vmm_caps = %#llx\n", mshv_root.vmm_caps.as_uint64[0]);
         |         ^
   include/linux/dev_printk.h:171:2: note: expanded from macro 'dev_dbg'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^
   include/linux/dev_printk.h:137:3: note: expanded from macro 'dev_no_printk'
     137 |         ({                                                              \
         |          ^
>> drivers/hv/mshv_root_main.c:2260:2: error: expected ')'
   include/linux/dev_printk.h:171:2: note: expanded from macro 'dev_dbg'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^
   include/linux/dev_printk.h:137:3: note: expanded from macro 'dev_no_printk'
     137 |         ({                                                              \
         |          ^
   drivers/hv/mshv_root_main.c:2260:2: note: to match this '('
   include/linux/dev_printk.h:171:2: note: expanded from macro 'dev_dbg'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^
   include/linux/dev_printk.h:137:2: note: expanded from macro 'dev_no_printk'
     137 |         ({                                                              \
         |         ^
   drivers/hv/mshv_root_main.c:2262:2: error: expected identifier or '('
    2262 |         return 0;
         |         ^
>> drivers/hv/mshv_root_main.c:2263:1: error: extraneous closing brace ('}')
    2263 | }
         | ^
   4 errors generated.


vim +2260 drivers/hv/mshv_root_main.c

621191d709b148 Nuno Das Neves                  2025-03-14  2246  
21480aa03ff5bc Stanislav Kinsburskii           2026-01-29  2247  static int __init mshv_init_vmm_caps(struct device *dev)
fd612d97a458f0 Purna Pavan Chandra Aekkaladevi 2025-10-10  2248  {
21480aa03ff5bc Stanislav Kinsburskii           2026-01-29  2249  	int ret;
21480aa03ff5bc Stanislav Kinsburskii           2026-01-29  2250  
21480aa03ff5bc Stanislav Kinsburskii           2026-01-29  2251  	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
fd612d97a458f0 Purna Pavan Chandra Aekkaladevi 2025-10-10  2252  						HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
fd612d97a458f0 Purna Pavan Chandra Aekkaladevi 2025-10-10  2253  						0, &mshv_root.vmm_caps,
21480aa03ff5bc Stanislav Kinsburskii           2026-01-29  2254  						sizeof(mshv_root.vmm_caps));
21480aa03ff5bc Stanislav Kinsburskii           2026-01-29  2255  	if (ret && hv_l1vh_partition())
21480aa03ff5bc Stanislav Kinsburskii           2026-01-29  2256  		dev_err(dev, "Failed to get VMM capabilities: %d\n", ret);
21480aa03ff5bc Stanislav Kinsburskii           2026-01-29  2257  		return ret;
21480aa03ff5bc Stanislav Kinsburskii           2026-01-29  2258  	}
fd612d97a458f0 Purna Pavan Chandra Aekkaladevi 2025-10-10  2259  
fd612d97a458f0 Purna Pavan Chandra Aekkaladevi 2025-10-10 @2260  	dev_dbg(dev, "vmm_caps = %#llx\n", mshv_root.vmm_caps.as_uint64[0]);
21480aa03ff5bc Stanislav Kinsburskii           2026-01-29  2261  
21480aa03ff5bc Stanislav Kinsburskii           2026-01-29  2262  	return 0;
fd612d97a458f0 Purna Pavan Chandra Aekkaladevi 2025-10-10 @2263  }
fd612d97a458f0 Purna Pavan Chandra Aekkaladevi 2025-10-10  2264  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

