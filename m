Return-Path: <linux-hyperv+bounces-7680-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA79C69A0D
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 14:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA6CE366C1A
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666434F263;
	Tue, 18 Nov 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXEwEs0o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3D633E357;
	Tue, 18 Nov 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473118; cv=none; b=Ygzyq/Q3PA1Be8eLknsqPrBrnhp9FDGq2JZjpId1U99O0anS5VnfgNEA9Yaj6BgBAxj+tnuzCdLvjf+ZY7xc2SoiXBTCwn+IrhaF9aab1Nd/DZCwyRbyoGGkDntJ4fGEBp/KvTZtUuNLOGK1W+Kmkel1G4aRSs2h4TjyiHCGc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473118; c=relaxed/simple;
	bh=xD0xIfmUHSfSojyeEaG/jjEVDerEQblrgY/8iTDoxqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V47vyvPAno58QQdWRIWZKc2Sw/iSYNufMJ+HLDfBE82PpyLIxLj5gBymuPY1J0ftr/KXdGY+62frnj1yluDrJ7K0cKBBoDJ6X8WlOj0l83+RRUkvECvSpwpKlaDya3Nr1aYJpYN0GmqrqFt/ERWDdk//VDhKxFta80mY+pdeYWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXEwEs0o; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763473118; x=1795009118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xD0xIfmUHSfSojyeEaG/jjEVDerEQblrgY/8iTDoxqA=;
  b=IXEwEs0opqwk6eprR9n1wd3KYvzwu/gHIgiuxcK0aGS/hCd3MrNJyOEs
   X134h5IUfNSZ+tRHq67lfIDDXlmMlpA+ZMBJzLR7Rpzp+t7DIhK8Fop2J
   ct1MBJ6CpBFloHkGWHHYv18dtejls+ic4MA3c7feZE3cqcwyDm92oP5HF
   R8LSE3AYQF1rUTT9ho32sWf+mdVq9+W1kR/wsN3+nF6HB2KmIg9zdwtB3
   gUWxTJNWDPEIHNOJbAEAdaNrsC4p8Rq7H/jrZ1YEu9KaJLSk5vbdU1Fik
   EcsIo1nSh4ISDxZuyLh0Txj1dCKpm6rIFDkVX09Hq+P8CeJYOjAneWjyp
   w==;
X-CSE-ConnectionGUID: XFySQbBBTcuWmfMHLrVQrA==
X-CSE-MsgGUID: 9TFhQShwQkGQs2xBVad+/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76596172"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76596172"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 05:38:37 -0800
X-CSE-ConnectionGUID: 9tv8qQwUS/GoN9FDnQEVMw==
X-CSE-MsgGUID: MCAAgdcMS7qiBUiN8o3zfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190423584"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 Nov 2025 05:38:32 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLLug-0001mf-1f;
	Tue, 18 Nov 2025 13:38:30 +0000
Date: Tue, 18 Nov 2025 21:38:28 +0800
From: kernel test robot <lkp@intel.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Cc: oe-kbuild-all@lists.linux.dev, anbelski@linux.microsoft.com,
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v5 2/3] hyperv: Use reboot notifier to configure sleep
 state
Message-ID: <202511182134.X8qi5PeT-lkp@intel.com>
References: <20251117210855.108126-3-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117210855.108126-3-prapal@linux.microsoft.com>

Hi Praveen,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251117]
[cannot apply to tip/x86/core linus/master v6.18-rc6 v6.18-rc5 v6.18-rc4 v6.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-K-Paladugu/hyperv-Add-definitions-for-MSHV-sleep-state-configuration/20251118-051204
base:   next-20251117
patch link:    https://lore.kernel.org/r/20251117210855.108126-3-prapal%40linux.microsoft.com
patch subject: [PATCH v5 2/3] hyperv: Use reboot notifier to configure sleep state
config: i386-randconfig-141-20251118 (https://download.01.org/0day-ci/archive/20251118/202511182134.X8qi5PeT-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251118/202511182134.X8qi5PeT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511182134.X8qi5PeT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hv/mshv_common.c:210:6: error: redefinition of 'hv_sleep_notifiers_register'
     210 | void hv_sleep_notifiers_register(void)
         |      ^
   arch/x86/include/asm/mshyperv.h:188:20: note: previous definition is here
     188 | static inline void hv_sleep_notifiers_register(void) {};
         |                    ^
   1 error generated.


vim +/hv_sleep_notifiers_register +210 drivers/hv/mshv_common.c

   209	
 > 210	void hv_sleep_notifiers_register(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

