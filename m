Return-Path: <linux-hyperv+bounces-7375-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688EFC1C2D5
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 17:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9805833F9
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EBD30DEA2;
	Wed, 29 Oct 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GP7DUozK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8D2E6CB8;
	Wed, 29 Oct 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752173; cv=none; b=E1/+cRc6Ze0ZmCX9SGNKj+kjlU4aj7HIyMgJj3rND+XqjnZoEwhrHaGNm9/CUb7ej4L4esWuzV1WFKJp8vLhM2T46lE5EKuuDQKCr2I4+XpfFXSvp5FOysjQj2mmRkMyoLbeWaBBRNV4D4nU82KTY2e2mgl29DdWpbTnM9q9Z+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752173; c=relaxed/simple;
	bh=NOtaDD0yEl9+6Z0oltjyvQBKR0NopvU+ncmTXk/MU/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZS4Kwq30+8uFI+Sf4hwM4SpYgeUkF0yppUMcsEGAYlU7p+i1duQ8Hcl9MKmCUmd6TM8X24RHIGoyl/KgyRIdtE1yLRvLzrc0TcoAqXofYXSALuMRzdrkkh2Snl/YGKvUQxwH0k15nUrhd9YSwb3tANcv3PahtOurA8a2rD21yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GP7DUozK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761752172; x=1793288172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NOtaDD0yEl9+6Z0oltjyvQBKR0NopvU+ncmTXk/MU/U=;
  b=GP7DUozKjAcZEYIl7te6iiSwV1qXysZCv+DYkJpJjyRtLTzV8tXxN2vi
   gzZ+7NASIXLmxR4gvQpJGyvd5H/s1rJcXq5ikVDUl4ZtSuE/QhTTM4S0h
   cJeBKOVdAz04fn9tGrh7uWqVsKNpNT2X112ov9r0sNtgxaGhoUrHkuXEl
   uyZY0K0VmD77sMaVncescRMRfDIvj1napjBr0hPKaoVOrc8eFQ/N7kaID
   cY5+OZdhiPjRXBy0un+z7vjfUkUiT7z9flWqCw52EMvb9lnNe5GbC6rlN
   oKyWP7HTj9FgU8DnMOIiBr1osStN4Y/sL06u/GNGmdqbBgxxYRGjxfB+q
   w==;
X-CSE-ConnectionGUID: QwZ9TW4ZTcq7CC77WleVFA==
X-CSE-MsgGUID: ftDLAsHhRHCbNEWD5gz4fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="67530229"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="67530229"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:36:11 -0700
X-CSE-ConnectionGUID: uSKz2MDCRv6d3icnoqm3VA==
X-CSE-MsgGUID: xejXBqrgTQyFdIeFEEo+vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="222912225"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 29 Oct 2025 08:36:07 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE8CW-000KjZ-2u;
	Wed, 29 Oct 2025 15:35:21 +0000
Date: Wed, 29 Oct 2025 23:34:46 +0800
From: kernel test robot <lkp@intel.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	muislam@microsoft.com
Cc: oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com, romank@linux.microsoft.com,
	Jinank Jain <jinankjain@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: Re: [PATCH] mshv: Extend create partition ioctl to support cpu
 features
Message-ID: <202510292330.LCHvPCLt-lkp@intel.com>
References: <1761685562-6272-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761685562-6272-1-git-send-email-nunodasneves@linux.microsoft.com>

Hi Nuno,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc3 next-20251029]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Das-Neves/mshv-Extend-create-partition-ioctl-to-support-cpu-features/20251029-050748
base:   linus/master
patch link:    https://lore.kernel.org/r/1761685562-6272-1-git-send-email-nunodasneves%40linux.microsoft.com
patch subject: [PATCH] mshv: Extend create partition ioctl to support cpu features
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20251029/202510292330.LCHvPCLt-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510292330.LCHvPCLt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510292330.LCHvPCLt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: include/uapi/linux/mshv.h: leak CONFIG_X86_64 to user-space
   make[3]: *** [scripts/Makefile.headersinst:63: usr/include/linux/mshv.h] Error 1
   make[3]: Target '__headers' not remade because of errors.
   make[2]: *** [Makefile:1378: headers] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

