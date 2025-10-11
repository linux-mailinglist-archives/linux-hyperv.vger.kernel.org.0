Return-Path: <linux-hyperv+bounces-7193-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF62BCF4CB
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Oct 2025 13:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D98B404B62
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Oct 2025 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E5026C386;
	Sat, 11 Oct 2025 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHa+X5QW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E5326057A;
	Sat, 11 Oct 2025 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760183878; cv=none; b=o+LyPd4mdd28CPC03BPeFYdFZhGEUfeDqg81FVOyTAWVAcrXAOwpomhN3H9G9H2HwNXiRj1/aBqoKZN4sx4cdT2Gh8fOxC2ZLjjXDazs3BGwlaNgRDqGUWSzcD7E7lRvaOo60xBnYnIsvDSdYxJIX1p1UO95RNFrIrWSfH32tu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760183878; c=relaxed/simple;
	bh=o55Ji3YrvmV81nih3mGmlOrX7PaVGbhKxiQnz6SeMO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOQAFocsGGMU3mPCvBKvSNuknbCgF5vjARYsmu/iHb7yxSon3+lAM5tz3CEcFPa31eAOnPRGVeXRtXvtxroDapGV9VrBo/A2jQRbtzkb4BMeJ5QNbGRy9yilgrtpherkNVqrvNg81/6m51zU8gj0HbDV0cdBQCqks6lOVhK9Dlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHa+X5QW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760183873; x=1791719873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o55Ji3YrvmV81nih3mGmlOrX7PaVGbhKxiQnz6SeMO8=;
  b=JHa+X5QW5yD8pnWhKFHAPEtf+Xd0FgoH48Oo5XeGgtTfGEAZa3abcgal
   YzNTg8bhPg62OOxXyGNAlfI6oD91uHUAd0VMtbxnsl3Vihuwzw+4opjyr
   WKpPMuk0id9E/DWEIrJq0QU94OxfR5adiJxjoeqJI0q6m0+5FhLbLSDA3
   CGAJJVgZCK+8zcXZ+jkMagjEJ3vsWqBXdU9X+62RJWLI3bkvbmKh+jv53
   WT+Q+H1xvgA6jr1SF2cc/GpB50tG8UVpiivbsnco3HIUuh1ZVgui3a/4i
   TKOUB9f5k68M3CU5IBptLYZOxOv0hKGcvSnLjF2urQQI+2dkMpSdFLDpe
   Q==;
X-CSE-ConnectionGUID: +S/2DfhjQByxfYyqOBWrIw==
X-CSE-MsgGUID: kO7RNXLcRYSwnUiFCcPVsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62305708"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62305708"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 04:57:53 -0700
X-CSE-ConnectionGUID: WtaS+6u7SDa5iGKGvttNQQ==
X-CSE-MsgGUID: wqyBrNl1QbeKIeLxGAgD/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="186294988"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Oct 2025 04:57:49 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7YEM-0003k7-1w;
	Sat, 11 Oct 2025 11:57:46 +0000
Date: Sat, 11 Oct 2025 19:57:05 +0800
From: kernel test robot <lkp@intel.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Cc: oe-kbuild-all@lists.linux.dev, anbelski@linux.microsoft.com,
	prapal@linux.microsoft.com
Subject: Re: [PATCH 2/2] hyperv: Enable clean shutdown for root partition
 with MSHV
Message-ID: <202510111908.EESLF0ZB-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on arnd-asm-generic/master soc/for-next linus/master v6.17 next-20251010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-K-Paladugu/hyperv-Add-definitions-for-MSHV-sleep-state-configuration/20251010-122914
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20251009160501.6356-3-prapal%40linux.microsoft.com
patch subject: [PATCH 2/2] hyperv: Enable clean shutdown for root partition with MSHV
config: arm64-randconfig-002-20251011 (https://download.01.org/0day-ci/archive/20251011/202510111908.EESLF0ZB-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510111908.EESLF0ZB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510111908.EESLF0ZB-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hv/hv_common.c: In function 'hv_sleep_notifiers_register':
>> drivers/hv/hv_common.c:944:57: error: macro "acpi_os_set_prepare_sleep" requires 3 arguments, but only 1 given
     944 |         acpi_os_set_prepare_sleep(&hv_acpi_sleep_handler);
         |                                                         ^
   In file included from drivers/hv/hv_common.c:16:
   include/linux/acpi.h:1165: note: macro "acpi_os_set_prepare_sleep" defined here
    1165 | #define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
         | 
>> drivers/hv/hv_common.c:944:9: error: 'acpi_os_set_prepare_sleep' undeclared (first use in this function); did you mean 'acpi_os_enter_sleep'?
     944 |         acpi_os_set_prepare_sleep(&hv_acpi_sleep_handler);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         acpi_os_enter_sleep
   drivers/hv/hv_common.c:944:9: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/hv/hv_common.c:945:9: error: implicit declaration of function 'acpi_os_set_prepare_extended_sleep'; did you mean 'acpi_os_set_prepare_sleep'? [-Werror=implicit-function-declaration]
     945 |         acpi_os_set_prepare_extended_sleep(&hv_acpi_extended_sleep_handler);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         acpi_os_set_prepare_sleep
   cc1: some warnings being treated as errors


vim +/acpi_os_set_prepare_sleep +944 drivers/hv/hv_common.c

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

