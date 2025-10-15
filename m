Return-Path: <linux-hyperv+bounces-7219-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1607BBDC99E
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Oct 2025 07:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFF4C4E5E76
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Oct 2025 05:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C557A2FDC5D;
	Wed, 15 Oct 2025 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrCmE8kR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589F14B96E;
	Wed, 15 Oct 2025 05:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506261; cv=none; b=WP+YHc4qSGpZnSHjyLs8juEdWm9dhyhx2Waed1Dojr4PR2/J+YbfAkg++jxMn0qvqG8tdGwvwC3CKLL5gmcnViGidr6pPz+2LW5p30fsVBZ5RFRkA7RNE4c53oebccBtItOtM1IFCYp4/bivXQy1GbszGHic4QvJcrh8UQyJkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506261; c=relaxed/simple;
	bh=UdFVOB8YwL0d1UrDbtT+D6OMH5FrPX5LdCbM/cY0tvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW1EkuAEm+YKq9wurEGgNWDMANOe9B49QNAgLjkPCssOdLPte4VmoWJDN9WVGo0IP1lLcm76iVSRxaTxgN+hOPvuT2QmEH0a4z4BDWeGWqWMlDqVgoOqA+VIvM5moEqJkDdLM50XQStSH3FrcsiX0222JtKpWq1XseMJ4oeVE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrCmE8kR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760506260; x=1792042260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UdFVOB8YwL0d1UrDbtT+D6OMH5FrPX5LdCbM/cY0tvg=;
  b=BrCmE8kRM88mitizmAAxZbW+0zASVL4Xkt5U2TWS2zRdKiC6mAkMbVLG
   JaWJkR1XpzmxL07SXMtx1hy2CFhucSGsdGqA8snfDPcyJIxX65LhrOaMK
   vXHZF7Eaji+WCzzhHqKgCBbcmiQ2VZ6w7N1L33cZx+BPvmJTbW4EXuRGh
   4BUem/y2FGGiTX6fI/oOs8XDk2hHxWqidHpouKQRCk6nIj4yAG99QnEwp
   AnR6vA5kwegoPaoBydY2coNKcYYT7p9c7t+Ga/xnnivzhpAumGm9ZmrHu
   DyxUsRAXlK5aw/Fw9/fivXLqvk8Y3M9/F2WnCF+xAd6XMvJBJPzLZK+xK
   A==;
X-CSE-ConnectionGUID: Ee87s+KXSi2GSaktAa3z6w==
X-CSE-MsgGUID: TnVzDlK3Sfe+jZqWi+6jPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73274122"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="73274122"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:30:59 -0700
X-CSE-ConnectionGUID: uGf6XeUXTMCo8JDM4txokg==
X-CSE-MsgGUID: /dOghRkNQGyfgjw0vbzMjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181206716"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 14 Oct 2025 22:30:55 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8u5D-0003Tl-26;
	Wed, 15 Oct 2025 05:30:02 +0000
Date: Wed, 15 Oct 2025 13:23:42 +0800
From: kernel test robot <lkp@intel.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	anbelski@linux.microsoft.com, prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v2 2/2] hyperv: Enable clean shutdown for root partition
 with MSHV
Message-ID: <202510151359.vRXcys2P-lkp@intel.com>
References: <20251014164150.6935-3-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014164150.6935-3-prapal@linux.microsoft.com>

Hi Praveen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on linus/master v6.18-rc1 next-20251014]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-K-Paladugu/hyperv-Add-definitions-for-MSHV-sleep-state-configuration/20251015-004650
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20251014164150.6935-3-prapal%40linux.microsoft.com
patch subject: [PATCH v2 2/2] hyperv: Enable clean shutdown for root partition with MSHV
config: i386-randconfig-006-20251015 (https://download.01.org/0day-ci/archive/20251015/202510151359.vRXcys2P-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251015/202510151359.vRXcys2P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510151359.vRXcys2P-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hv/hv_common.c:944:5: warning: no previous prototype for function 'hv_sleep_notifiers_register' [-Wmissing-prototypes]
     944 | int hv_sleep_notifiers_register(void)
         |     ^
   drivers/hv/hv_common.c:944:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     944 | int hv_sleep_notifiers_register(void)
         | ^
         | static 
   1 warning generated.


vim +/hv_sleep_notifiers_register +944 drivers/hv/hv_common.c

   943	
 > 944	int hv_sleep_notifiers_register(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

