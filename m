Return-Path: <linux-hyperv+bounces-7681-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 034FEC69D35
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 15:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DCF432B307
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 14:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE314363C70;
	Tue, 18 Nov 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TA6D8mad"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC5363C61;
	Tue, 18 Nov 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474381; cv=none; b=bLj1SZR8LPHpXO9XRvRpEoTpVUD1J+h4FLREZglEeQmT3D9jD1YiDkSr2fX3zPuvkWVUSHJUutisfo+dru2MDVldZ1vLYgFvJBA4w85dPwpNrNLCOwA1KcSI2kMXQuflQRsjW3AJKt5XD7xAwzfcp95NPXcWkc3+zb97hkJC8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474381; c=relaxed/simple;
	bh=HqDBZlp+TkYDeUFB5b7sXoVV7Y23paoJopI3bJcnmCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msrirhNPY5tD3R0tx8FqLM9ckRO1k33bD/qhlUYqq/pF2qVqHbbMHBRucfH2dCAlHKREPmZb4zZD99pcEIXxwKnVSoTZcTdrvvmifdfslWFFOwOhy1WdJqLBsa2FDE/KR03TgokB+yyqiwymrPzWsYiGXbGVbpmAggIs6u4iVh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TA6D8mad; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763474380; x=1795010380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HqDBZlp+TkYDeUFB5b7sXoVV7Y23paoJopI3bJcnmCA=;
  b=TA6D8madZ6M3G0skjCWZBTl5tLbTsbwbuGb4Wl/pOLIkNiUQM5jR1CZr
   punWOIiS6CkTCvgaEQnwuZj2dA4WP/19xVVO9o1u8coXvWaO25PBh8Man
   FE6XYFncXKAkEONmtw1w10rL0mGIXctbOWFAA5Cc92zm0zFOasf2FxQ5A
   EyqBanJiAVNr2UrouR8v4xBX08sfGRmtt6zuYT97sklEba0NLOlbdNHwb
   jLO5HVewp2p7xmtwmaVU+a+Iz3hragAmPdPQELD9pkeQuJiiv/fBxgamp
   ArW7qRGdrxOh3h5B0/gUx0QcaZDFRddJI3AJmnm63HHQKHWdSDr4CsFi0
   A==;
X-CSE-ConnectionGUID: v4i66ZQATqqHmlf2d7RLMg==
X-CSE-MsgGUID: MY8ec6j+QdOME491cxX0nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76847216"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76847216"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 05:59:39 -0800
X-CSE-ConnectionGUID: 8f2/eroiRSifLkYmXOavsQ==
X-CSE-MsgGUID: hP/FUeyrRy2YTqvEMQG4rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="195676328"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Nov 2025 05:59:35 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLMF2-0001nr-0a;
	Tue, 18 Nov 2025 13:59:32 +0000
Date: Tue, 18 Nov 2025 21:59:08 +0800
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
Subject: Re: [PATCH v5 2/3] hyperv: Use reboot notifier to configure sleep
 state
Message-ID: <202511182118.ZOxiv0Fn-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20251117]
[cannot apply to tip/x86/core linus/master v6.18-rc6 v6.18-rc5 v6.18-rc4 v6.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-K-Paladugu/hyperv-Add-definitions-for-MSHV-sleep-state-configuration/20251118-051204
base:   next-20251117
patch link:    https://lore.kernel.org/r/20251117210855.108126-3-prapal%40linux.microsoft.com
patch subject: [PATCH v5 2/3] hyperv: Use reboot notifier to configure sleep state
config: arm64-randconfig-003-20251118 (https://download.01.org/0day-ci/archive/20251118/202511182118.ZOxiv0Fn-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251118/202511182118.ZOxiv0Fn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511182118.ZOxiv0Fn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hv/mshv_common.c:210:6: warning: no previous prototype for function 'hv_sleep_notifiers_register' [-Wmissing-prototypes]
     210 | void hv_sleep_notifiers_register(void)
         |      ^
   drivers/hv/mshv_common.c:210:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     210 | void hv_sleep_notifiers_register(void)
         | ^
         | static 
   1 warning generated.


vim +/hv_sleep_notifiers_register +210 drivers/hv/mshv_common.c

   209	
 > 210	void hv_sleep_notifiers_register(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

