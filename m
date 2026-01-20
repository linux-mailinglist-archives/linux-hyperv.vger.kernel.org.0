Return-Path: <linux-hyperv+bounces-8390-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMPtINj/b2mUUgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8390-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 23:21:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E924CE12
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 23:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBF8A8EEEED
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 21:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5648438BDA9;
	Tue, 20 Jan 2026 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qf/4opCa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B471B3A8FED;
	Tue, 20 Jan 2026 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943404; cv=none; b=cCCENc926QOhDt9JFPjJaN7qex5xxD9R/y4LbZwvmMbIiyWqFHm36+LKR/1HLQs0VjiymAODG7UPKJ3odJnbB8dYrfIJihxDbAsi9r0U7DFjiC/sSQwmGrKcDnTnRav0X7r3rpw8fV+xr5+93jddiYef5iO4FJExd4iPLGen+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943404; c=relaxed/simple;
	bh=ivHtQ6gh6IXT2hO8yZKcCr+q7hqDkcejJS3fvf52Ppo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4cQdZk9DOhFIiOYHvB7yKWchEuds5yOzzTqKsWT2zAeZPB4GULz20pr6RrQpyTM+YgSXjjozXHNbmNPkKcu/oWHH2O4S3QJw1DbUweWaOt2INTSlxwMLQrK8cOj4oVkLwMTLQriO6wj2Reny93Im6Vsi4/euzfMwmO/WJUyc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qf/4opCa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768943402; x=1800479402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ivHtQ6gh6IXT2hO8yZKcCr+q7hqDkcejJS3fvf52Ppo=;
  b=Qf/4opCa5ESpQw/lRu/NTfJuA2nWFDkuAr2Pe2lz7WJLivxv01l0ND/Z
   HMPSxuQ9WLHfFtTatWSdQnrwUnxUEFaHMsOciSXzJYUxqs0pvOC/GeRHC
   ME7xP2UgaN8WDL2/15YBWVK5hfbwjF3bNCqWbkGllW5U9baQLWvqAxmdl
   AFWk9fKxIJsIxpYkKyAjscNheDfO/2SHMNNaFQA+agpQHQL5CeGLVZZFw
   FG14Gm2ukPYJR/oOrtnI0jCo1eNdfB/gwbhS3I6z41IVhFptAT0J0V48x
   1jmrn1x/B//O4Ggk4U4Y3XqVyMY0VmS+pHCt4BdQWphD20ITPYwD6Z/HJ
   w==;
X-CSE-ConnectionGUID: IxF5pwnASuO1cPShdSJq6A==
X-CSE-MsgGUID: 1ee2jgbARveVhxGhBOmHig==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80791588"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="80791588"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 13:10:01 -0800
X-CSE-ConnectionGUID: AXjcRiQeSHCcT9bTnSKtZg==
X-CSE-MsgGUID: g2PZWbUQQhiY3dv6ggSIEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="237482957"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 Jan 2026 13:09:54 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viIz1-00000000PXR-2Z9s;
	Tue, 20 Jan 2026 21:09:51 +0000
Date: Wed, 21 Jan 2026 05:09:48 +0800
From: kernel test robot <lkp@intel.com>
To: Mukesh R <mrathor@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: Re: [PATCH v0 01/15] iommu/hyperv: rename hyperv-iommu.c to
 hyperv-irq.c
Message-ID: <202601210423.wwOrf2K8-lkp@intel.com>
References: <20260120064230.3602565-2-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064230.3602565-2-mrathor@linux.microsoft.com>
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-8390-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,git-scm.com:url]
X-Rspamd-Queue-Id: 38E924CE12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mukesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on pci/next pci/for-linus arm64/for-next/core clk/clk-next soc/for-next linus/master arnd-asm-generic/master v6.19-rc6 next-20260120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-R/iommu-hyperv-rename-hyperv-iommu-c-to-hyperv-irq-c/20260120-145832
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20260120064230.3602565-2-mrathor%40linux.microsoft.com
patch subject: [PATCH v0 01/15] iommu/hyperv: rename hyperv-iommu.c to hyperv-irq.c
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20260121/202601210423.wwOrf2K8-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260121/202601210423.wwOrf2K8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601210423.wwOrf2K8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iommu/intel/irq_remapping.c:6:
   include/linux/dmar.h:269:17: error: unknown type name '__u128'; did you mean '__u32'?
     269 |                 __u128 irte;
         |                 ^~~~~~
         |                 __u32
   drivers/iommu/intel/irq_remapping.c: In function 'modify_irte':
   drivers/iommu/intel/irq_remapping.c:181:17: error: unknown type name 'u128'
     181 |                 u128 old = irte->irte;
         |                 ^~~~
   In file included from arch/x86/include/asm/bug.h:193,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/barrier.h:5,
                    from include/asm-generic/bitops/generic-non-atomic.h:7,
                    from include/linux/bitops.h:28,
                    from include/linux/kernel.h:23,
                    from include/linux/interrupt.h:6,
                    from drivers/iommu/intel/irq_remapping.c:5:
   include/linux/atomic/atomic-arch-fallback.h:326:14: error: void value not ignored as it ought to be
     326 |         ___r = raw_cmpxchg128((_ptr), ___o, (_new)); \
         |              ^
   include/asm-generic/bug.h:110:32: note: in definition of macro 'WARN_ON'
     110 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4956:9: note: in expansion of macro 'raw_try_cmpxchg128'
    4956 |         raw_try_cmpxchg128(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~~
   drivers/iommu/intel/irq_remapping.c:182:26: note: in expansion of macro 'try_cmpxchg128'
     182 |                 WARN_ON(!try_cmpxchg128(&irte->irte, &old, irte_modified->irte));
         |                          ^~~~~~~~~~~~~~
   drivers/iommu/intel/irq_remapping.c: In function 'intel_ir_set_vcpu_affinity':
>> drivers/iommu/intel/irq_remapping.c:1270:40: warning: left shift count >= width of type [-Wshift-count-overflow]
    1270 |                                 ~(-1UL << PDA_HIGH_BIT);
         |                                        ^~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IRQ_REMAP
   Depends on [n]: IOMMU_SUPPORT [=y] && X86_64 [=n] && X86_IO_APIC [=y] && PCI_MSI [=y] && ACPI [=y]
   Selected by [y]:
   - HYPERV_IOMMU [=y] && IOMMU_SUPPORT [=y] && HYPERV [=y] && X86 [=y]


vim +1270 drivers/iommu/intel/irq_remapping.c

b106ee63abccbba drivers/iommu/intel_irq_remapping.c Jiang Liu           2015-04-13  1241  
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1242  static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1243  {
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1244  	struct intel_ir_data *ir_data = data->chip_data;
53527ea1b70224d drivers/iommu/intel/irq_remapping.c Sean Christopherson 2025-06-11  1245  	struct intel_iommu_pi_data *pi_data = info;
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1246  
ed1e48ea4370300 drivers/iommu/intel/irq_remapping.c Jacob Pan           2024-04-23  1247  	/* stop posting interrupts, back to the default mode */
53527ea1b70224d drivers/iommu/intel/irq_remapping.c Sean Christopherson 2025-06-11  1248  	if (!pi_data) {
2454823e97a63d8 drivers/iommu/intel/irq_remapping.c Sean Christopherson 2025-03-19  1249  		__intel_ir_reconfigure_irte(data, true);
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1250  	} else {
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1251  		struct irte irte_pi;
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1252  
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1253  		/*
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1254  		 * We are not caching the posted interrupt entry. We
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1255  		 * copy the data from the remapped entry and modify
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1256  		 * the fields which are relevant for posted mode. The
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1257  		 * cached remapped entry is used for switching back to
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1258  		 * remapped mode.
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1259  		 */
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1260  		memset(&irte_pi, 0, sizeof(irte_pi));
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1261  		dmar_copy_shared_irte(&irte_pi, &ir_data->irte_entry);
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1262  
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1263  		/* Update the posted mode fields */
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1264  		irte_pi.p_pst = 1;
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1265  		irte_pi.p_urgent = 0;
53527ea1b70224d drivers/iommu/intel/irq_remapping.c Sean Christopherson 2025-06-11  1266  		irte_pi.p_vector = pi_data->vector;
53527ea1b70224d drivers/iommu/intel/irq_remapping.c Sean Christopherson 2025-06-11  1267  		irte_pi.pda_l = (pi_data->pi_desc_addr >>
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1268  				(32 - PDA_LOW_BIT)) & ~(-1UL << PDA_LOW_BIT);
53527ea1b70224d drivers/iommu/intel/irq_remapping.c Sean Christopherson 2025-06-11  1269  		irte_pi.pda_h = (pi_data->pi_desc_addr >> 32) &
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09 @1270  				~(-1UL << PDA_HIGH_BIT);
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1271  
688124cc541f60d drivers/iommu/intel/irq_remapping.c Sean Christopherson 2025-03-19  1272  		ir_data->irq_2_iommu.posted_vcpu = true;
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1273  		modify_irte(&ir_data->irq_2_iommu, &irte_pi);
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1274  	}
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1275  
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1276  	return 0;
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1277  }
8541186faf3b596 drivers/iommu/intel_irq_remapping.c Feng Wu             2015-06-09  1278  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

