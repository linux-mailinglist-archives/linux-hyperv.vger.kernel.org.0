Return-Path: <linux-hyperv+bounces-7194-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DA2BCF4EA
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Oct 2025 14:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DEC534BBC3
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Oct 2025 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEA426B942;
	Sat, 11 Oct 2025 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+AI6rwX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71F25F96B;
	Sat, 11 Oct 2025 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760184539; cv=none; b=kbc13T026IFSqX96CF0Mwmbbgu/lm+qPAG0PDkCY5+Vmt6gOeRquAyOIO8eDLq3VQWzMSCnaG7pgqHrFUyMK4Wf7inscMdzYhsYoBdIhvSoB01m8j1auyp6Id8xwtF28C2BT5hZzcto9D5cYrsz3oHVF3uFG6dR/Om0O9N4XQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760184539; c=relaxed/simple;
	bh=HzDha1bDCleO+Hcw70n/+eAgjNrBHJmlLvT0DS03OIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzC2v6qOtUlV3fDjHrtFWBjnGiKtFVNx1WrGPJoaKo/VMUOm8+A+qXyeg92R6REr7c1DWhu06ON35avdDZVWp4+GCQOj1cjOk31Hjqk8nM4eyWElWZcLj8Pyc5bRXQ5IM56x2DNNXdgd2seCtYHqk/+O1TDb2nyN279U2dr06xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+AI6rwX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760184533; x=1791720533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HzDha1bDCleO+Hcw70n/+eAgjNrBHJmlLvT0DS03OIc=;
  b=a+AI6rwX/bkqHjVFX8cFhJmq08/M6IrtjXIqwljSnaqnaX/Ui4gNwGY4
   SutOzQEVHtyu0wgPL+Y9kw+xTgZc/vcCK6wPXQxV24Ev31k7pE4ea16x3
   JGxhNip8wU81z9OO0XEWimAZ3dMfiay2qJROa+MivbdWHpEblWLk49KAL
   N5uty3Fg/3dZCTw/PNyChn1SfDeFMPL4YPlDei2eXI/RE7/QnTSjltZP7
   DPy79/9caq44qLnboVV9p5+cDMJOLeVgn/QlmixUzMwc+bKcF/KXxXZks
   lfNKQSdsxMMT5wMrjodBFEfPhH+LR3fF8+G1mNqV6sdvTvoRObuN+yNiF
   g==;
X-CSE-ConnectionGUID: PJto0Se6SUGTBGZuANiQFQ==
X-CSE-MsgGUID: UcolVEvrSw2RzXdkiJULow==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="72997284"
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="72997284"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 05:08:53 -0700
X-CSE-ConnectionGUID: yKzoTVSTShW3UGSNe+sIzw==
X-CSE-MsgGUID: 5+ipT8PjTQuR6BkH3h88kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="186472719"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Oct 2025 05:08:49 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7YP1-0003kd-1K;
	Sat, 11 Oct 2025 12:08:47 +0000
Date: Sat, 11 Oct 2025 20:07:57 +0800
From: kernel test robot <lkp@intel.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	anbelski@linux.microsoft.com, prapal@linux.microsoft.com
Subject: Re: [PATCH 2/2] hyperv: Enable clean shutdown for root partition
 with MSHV
Message-ID: <202510111934.lcAG5ZAN-lkp@intel.com>
References: <20251009160501.6356-3-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009160501.6356-3-prapal@linux.microsoft.com>

Hi Praveen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on arnd-asm-generic/master soc/for-next linus/master v6.17 next-20251010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-K-Paladugu/hyperv-Add-definitions-for-MSHV-sleep-state-configuration/20251010-122914
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20251009160501.6356-3-prapal%40linux.microsoft.com
patch subject: [PATCH 2/2] hyperv: Enable clean shutdown for root partition with MSHV
config: arm64-randconfig-003-20251011 (https://download.01.org/0day-ci/archive/20251011/202510111934.lcAG5ZAN-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510111934.lcAG5ZAN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510111934.lcAG5ZAN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hv/hv_common.c:944:50: error: too few arguments provided to function-like macro invocation
     944 |         acpi_os_set_prepare_sleep(&hv_acpi_sleep_handler);
         |                                                         ^
   include/linux/acpi.h:1165:9: note: macro 'acpi_os_set_prepare_sleep' defined here
    1165 | #define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
         |         ^
   drivers/hv/hv_common.c:944:2: error: use of undeclared identifier 'acpi_os_set_prepare_sleep'; did you mean 'acpi_os_enter_sleep'?
     944 |         acpi_os_set_prepare_sleep(&hv_acpi_sleep_handler);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         acpi_os_enter_sleep
   include/acpi/acpiosxf.h:326:13: note: 'acpi_os_enter_sleep' declared here
     326 | acpi_status acpi_os_enter_sleep(u8 sleep_state, u32 rega_value, u32 regb_value);
         |             ^
   drivers/hv/hv_common.c:945:2: error: call to undeclared function 'acpi_os_set_prepare_extended_sleep'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     945 |         acpi_os_set_prepare_extended_sleep(&hv_acpi_extended_sleep_handler);
         |         ^
>> drivers/hv/hv_common.c:944:2: warning: expression result unused [-Wunused-value]
     944 |         acpi_os_set_prepare_sleep(&hv_acpi_sleep_handler);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 3 errors generated.


vim +944 drivers/hv/hv_common.c

   939	
   940	int hv_sleep_notifiers_register(void)
   941	{
   942		int ret;
   943	
 > 944		acpi_os_set_prepare_sleep(&hv_acpi_sleep_handler);
 > 945		acpi_os_set_prepare_extended_sleep(&hv_acpi_extended_sleep_handler);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

