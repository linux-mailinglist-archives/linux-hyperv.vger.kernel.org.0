Return-Path: <linux-hyperv+bounces-7682-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 444B8C6A72C
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 16:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 720954E4EED
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957D936828B;
	Tue, 18 Nov 2025 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRNoxx4k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CED36657D;
	Tue, 18 Nov 2025 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481291; cv=none; b=DCmTbJmq3c84E86dnGgYNor05GIxWHXTMqK//5ouZOFsYrNwGXZZtM4xYmDRPXdoeKJ8xgiUhN2ktpns/DrmhHFp+jCL2nNB4m20hI2zzIw2uCwtTDsiM1EBr/hIr5UjVEBJVWqiCg33JRMVF6YqDSSiSldQm2uufQQJNE/EUDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481291; c=relaxed/simple;
	bh=D07vP2bTR56TwC70J4fSsfq2NWntIX6r4PR2vKL2tCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA/58V2wk0srcUPrd99utFocWbz+uRtnj+364Ud0+gzOGY2FYf+ru9/RUNwOnz9YQm4PntZb/J5Pi8cM8KgiqiPgp89mFqVqB351Epw2PqNMam9QdoBcHV2ynVTdQ+/bjzQIVmc93lISfir4oeO/FVPjWIuCOBipKUQX3RXTFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRNoxx4k; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763481290; x=1795017290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D07vP2bTR56TwC70J4fSsfq2NWntIX6r4PR2vKL2tCk=;
  b=QRNoxx4kQoehgBI998+QeZ+EUUrYux1+nV1VbvSR0RCrgvojWoJG4RWs
   hLZtI/ylbjqGVLyaQ/sb/l3QeSZVGnK/d66uGkZ3jpcvNoyJuqdXr3lka
   2ZGydO/ka1nydzd2KjyXUwcQ100cfjrvc3tuwxB2FMBMm9T6vJTRrwYBi
   tedz6EKXzNjfXjMM8v5sFxID9NBxcLV8YB0wrXstbOihmRQJjDmZuB3mW
   z4LoDWYPmpeU1iexpE6oBFSkmuczKbmwm5uJ/atGYZjUdZRNpf7TIvt6I
   k/9lSo1msKtee6mIcdxunUxpnBlDaNA8KrirVIMF9MPdfLUZTGr2nf6/k
   w==;
X-CSE-ConnectionGUID: eQJRf1vZTXqUqwrzeV0Gbw==
X-CSE-MsgGUID: eFMyp2X4Sg+sPzVi65zh8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76184826"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76184826"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 07:54:49 -0800
X-CSE-ConnectionGUID: gydvxmQoQdqQG2JcwV1l0w==
X-CSE-MsgGUID: BmWiB7vEQWa3K3hG3Tn+nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="221695830"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Nov 2025 07:54:45 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLO2U-0001tp-1w;
	Tue, 18 Nov 2025 15:54:42 +0000
Date: Tue, 18 Nov 2025 23:53:55 +0800
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
Subject: Re: [PATCH v5 3/3] hyperv: Cleanly shutdown root partition with MSHV
Message-ID: <202511182353.5FvVmUhR-lkp@intel.com>
References: <20251117210855.108126-4-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117210855.108126-4-prapal@linux.microsoft.com>

Hi Praveen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20251117]
[cannot apply to tip/x86/core linus/master v6.18-rc6 v6.18-rc5 v6.18-rc4 v6.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-K-Paladugu/hyperv-Add-definitions-for-MSHV-sleep-state-configuration/20251118-051204
base:   next-20251117
patch link:    https://lore.kernel.org/r/20251117210855.108126-4-prapal%40linux.microsoft.com
patch subject: [PATCH v5 3/3] hyperv: Cleanly shutdown root partition with MSHV
config: arm64-randconfig-003-20251118 (https://download.01.org/0day-ci/archive/20251118/202511182353.5FvVmUhR-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251118/202511182353.5FvVmUhR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511182353.5FvVmUhR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hv/mshv_common.c:210:6: warning: no previous prototype for function 'hv_sleep_notifiers_register' [-Wmissing-prototypes]
     210 | void hv_sleep_notifiers_register(void)
         |      ^
   drivers/hv/mshv_common.c:210:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     210 | void hv_sleep_notifiers_register(void)
         | ^
         | static 
>> drivers/hv/mshv_common.c:224:6: warning: no previous prototype for function 'hv_machine_power_off' [-Wmissing-prototypes]
     224 | void hv_machine_power_off(void)
         |      ^
   drivers/hv/mshv_common.c:224:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     224 | void hv_machine_power_off(void)
         | ^
         | static 
   2 warnings generated.


vim +/hv_machine_power_off +224 drivers/hv/mshv_common.c

   219	
   220	/*
   221	 * Power off the machine by entering S5 sleep state via Hyper-V hypercall.
   222	 * This call does not return if successful.
   223	 */
 > 224	void hv_machine_power_off(void)
   225	{
   226		unsigned long flags;
   227		struct hv_input_enter_sleep_state *in;
   228	
   229		local_irq_save(flags);
   230		in = *this_cpu_ptr(hyperv_pcpu_input_arg);
   231		in->sleep_state = HV_SLEEP_STATE_S5;
   232	
   233		(void)hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);
   234		local_irq_restore(flags);
   235	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

