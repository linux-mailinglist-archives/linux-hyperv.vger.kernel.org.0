Return-Path: <linux-hyperv+bounces-6031-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB0FAEC1AD
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Jun 2025 23:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A016E036E
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Jun 2025 21:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EC62EE270;
	Fri, 27 Jun 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzxmAYGA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8581F3BA9;
	Fri, 27 Jun 2025 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751058292; cv=none; b=lYqdjxNZU64z07sKm7tWQc8cwbTlmvDZFEd0ZDFj/S08dIbgdxJgh77YRsStkFHmGz9pyJ+3xrvZUnQTO5gvDjXkaE3N5IuvVs/9beukWn5/i4OsrwAQ6CckmLKjrKzOWvXH+LtnBCmOsEHCKd08WwKTBndNI+6bJUde/5EUbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751058292; c=relaxed/simple;
	bh=mq9KQCan7JFRFTHlAnoG3cKyo0JGbSZs98TC5zf0rPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYag7VMXM6gHLTDUCZWua6MBWeghwFvXQu7YaYsk5dxKfpMi+T2VbDf+nF2sbTJHJcV+QFfLexODxuQxqNxSIyZ2IdRHDW9xYv86/n/kP6C93M8MjJVmYbFczDQHJ4sGBYLI5+YG7C1b4EcHrUS/ps5dgCAPc8jETYS8TjCjc/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzxmAYGA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751058289; x=1782594289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mq9KQCan7JFRFTHlAnoG3cKyo0JGbSZs98TC5zf0rPw=;
  b=DzxmAYGAx4eVTLxPsO8WLBJ9zvwqlN5TH6Vpp+o0WylmFwQ+onVnS8S6
   gxEfn53crLvu7CzrLCE+eqbP+L7wjJ3VGO48DIhQFshhtUYIkFY1YbJ9v
   NIk+MzVxlTgzFDQK/hFRUgiZB+re2vDCKYkWom6R+abm6LYLWYfNGtQsN
   G1q48qyu797Qv2DcgxzLHMWsndpaIlTlQmM9f5z+MxPCFJdxCAx4g/BoP
   UeF8Rp+nFC1EvaBObHJrhGX9Dx/HqQy4K1gvQ2BKkcNzDpFHTTFSvgDPC
   zj+QyJyj6Yo5YX11jdUGxV5MNA2Qc8E5iScUMqjYZaDgtGGiNfokXTFS9
   A==;
X-CSE-ConnectionGUID: 7Ay+XGljRBiXLpYH3wlhZA==
X-CSE-MsgGUID: p4hTCNsWSyKNIieCE0wM+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53534868"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="53534868"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 14:04:49 -0700
X-CSE-ConnectionGUID: RygQbJXHRM2F9TXTm3WCjw==
X-CSE-MsgGUID: Xx2vBOxzTdCS9EH4kU37Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="152291990"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 27 Jun 2025 14:04:44 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVGFW-000WXi-1X;
	Fri, 27 Jun 2025 21:04:42 +0000
Date: Sat, 28 Jun 2025 05:03:47 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Marc Zyngier <maz@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 1/1] x86/hyperv: Switch to msi_create_parent_irq_domain()
Message-ID: <202506280404.eZJ6vN93-lkp@intel.com>
References: <0eafade05acb51022242635750cd4990f3adb0ac.1750947640.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eafade05acb51022242635750cd4990f3adb0ac.1750947640.git.namcao@linutronix.de>

Hi Nam,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/master]
[also build test ERROR on linus/master v6.16-rc3 next-20250627]
[cannot apply to tip/x86/core tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nam-Cao/x86-hyperv-Switch-to-msi_create_parent_irq_domain/20250626-225420
base:   tip/master
patch link:    https://lore.kernel.org/r/0eafade05acb51022242635750cd4990f3adb0ac.1750947640.git.namcao%40linutronix.de
patch subject: [PATCH 1/1] x86/hyperv: Switch to msi_create_parent_irq_domain()
config: i386-randconfig-014-20250628 (https://download.01.org/0day-ci/archive/20250628/202506280404.eZJ6vN93-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506280404.eZJ6vN93-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506280404.eZJ6vN93-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/irqchip/irq-msi-lib.c:7:
>> include/linux/irqchip/irq-msi-lib.h:25:39: warning: 'struct msi_domain_info' declared inside parameter list will not be visible outside of this definition or declaration
      25 |                                struct msi_domain_info *info);
         |                                       ^~~~~~~~~~~~~~~
>> drivers/irqchip/irq-msi-lib.c:28:39: warning: 'struct msi_domain_info' declared inside parameter list will not be visible outside of this definition or declaration
      28 |                                struct msi_domain_info *info)
         |                                       ^~~~~~~~~~~~~~~
>> drivers/irqchip/irq-msi-lib.c:26:6: error: conflicting types for 'msi_lib_init_dev_msi_info'; have 'bool(struct device *, struct irq_domain *, struct irq_domain *, struct msi_domain_info *)' {aka '_Bool(struct device *, struct irq_domain *, struct irq_domain *, struct msi_domain_info *)'}
      26 | bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqchip/irq-msi-lib.h:23:6: note: previous declaration of 'msi_lib_init_dev_msi_info' with type 'bool(struct device *, struct irq_domain *, struct irq_domain *, struct msi_domain_info *)' {aka '_Bool(struct device *, struct irq_domain *, struct irq_domain *, struct msi_domain_info *)'}
      23 | bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-msi-lib.c: In function 'msi_lib_init_dev_msi_info':
>> drivers/irqchip/irq-msi-lib.c:30:56: error: 'struct irq_domain' has no member named 'msi_parent_ops'
      30 |         const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
         |                                                        ^~
>> drivers/irqchip/irq-msi-lib.c:31:37: error: invalid use of undefined type 'struct msi_domain_info'
      31 |         struct irq_chip *chip = info->chip;
         |                                     ^~
>> drivers/irqchip/irq-msi-lib.c:43:38: error: invalid use of undefined type 'const struct msi_parent_ops'
      43 |         if (domain->bus_token == pops->bus_select_token) {
         |                                      ^~
   drivers/irqchip/irq-msi-lib.c:51:30: error: invalid use of undefined type 'const struct msi_parent_ops'
      51 |         required_flags = pops->required_flags;
         |                              ^~
   drivers/irqchip/irq-msi-lib.c:54:20: error: invalid use of undefined type 'struct msi_domain_info'
      54 |         switch(info->bus_token) {
         |                    ^~
   In file included from arch/x86/include/asm/bug.h:103,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/barrier.h:5,
                    from include/asm-generic/bitops/generic-non-atomic.h:7,
                    from include/linux/bitops.h:28,
                    from include/linux/of.h:15,
                    from include/linux/irqdomain.h:14,
                    from include/linux/irqchip/irq-msi-lib.h:9:
   drivers/irqchip/irq-msi-lib.c:68:38: error: invalid use of undefined type 'struct msi_domain_info'
      68 |                 if (WARN_ON_ONCE(info->flags))
         |                                      ^~
   include/asm-generic/bug.h:117:32: note: in definition of macro 'WARN_ON_ONCE'
     117 |         int __ret_warn_on = !!(condition);                      \
         |                                ^~~~~~~~~
   drivers/irqchip/irq-msi-lib.c:72:21: error: invalid use of undefined type 'struct msi_domain_info'
      72 |                 info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
         |                     ^~
>> drivers/irqchip/irq-msi-lib.c:72:31: error: 'MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS' undeclared (first use in this function)
      72 |                 info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-msi-lib.c:72:31: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/irqchip/irq-msi-lib.c:72:65: error: 'MSI_FLAG_FREE_MSI_DESCS' undeclared (first use in this function)
      72 |                 info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
         |                                                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/irqchip/irq-msi-lib.c:76:36: error: 'MSI_FLAG_PCI_MSI_MASK_PARENT' undeclared (first use in this function)
      76 |                 required_flags &= ~MSI_FLAG_PCI_MSI_MASK_PARENT;
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-msi-lib.c:91:13: error: invalid use of undefined type 'struct msi_domain_info'
      91 |         info->flags                     &= pops->supported_flags;
         |             ^~
   drivers/irqchip/irq-msi-lib.c:91:48: error: invalid use of undefined type 'const struct msi_parent_ops'
      91 |         info->flags                     &= pops->supported_flags;
         |                                                ^~
   drivers/irqchip/irq-msi-lib.c:93:13: error: invalid use of undefined type 'struct msi_domain_info'
      93 |         info->flags                     |= required_flags;
         |             ^~
   drivers/irqchip/irq-msi-lib.c:96:36: error: invalid use of undefined type 'const struct msi_parent_ops'
      96 |         if (!chip->irq_eoi && (pops->chip_flags & MSI_CHIP_FLAG_SET_EOI))
         |                                    ^~
>> drivers/irqchip/irq-msi-lib.c:96:51: error: 'MSI_CHIP_FLAG_SET_EOI' undeclared (first use in this function)
      96 |         if (!chip->irq_eoi && (pops->chip_flags & MSI_CHIP_FLAG_SET_EOI))
         |                                                   ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-msi-lib.c:98:36: error: invalid use of undefined type 'const struct msi_parent_ops'
      98 |         if (!chip->irq_ack && (pops->chip_flags & MSI_CHIP_FLAG_SET_ACK))
         |                                    ^~
>> drivers/irqchip/irq-msi-lib.c:98:51: error: 'MSI_CHIP_FLAG_SET_ACK' undeclared (first use in this function)
      98 |         if (!chip->irq_ack && (pops->chip_flags & MSI_CHIP_FLAG_SET_ACK))
         |                                                   ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-msi-lib.c:113:46: error: invalid use of undefined type 'struct msi_domain_info'
     113 |         if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
         |                                              ^~
>> drivers/irqchip/irq-msi-lib.c:113:56: error: 'MSI_FLAG_NO_AFFINITY' undeclared (first use in this function)
     113 |         if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
         |                                                        ^~~~~~~~~~~~~~~~~~~~
>> drivers/irqchip/irq-msi-lib.c:114:42: error: 'msi_domain_set_affinity' undeclared (first use in this function); did you mean 'msi_domain_get_virq'?
     114 |                 chip->irq_set_affinity = msi_domain_set_affinity;
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~
         |                                          msi_domain_get_virq
   In file included from drivers/irqchip/irq-msi-lib.c:5:
   drivers/irqchip/irq-msi-lib.c: At top level:
   drivers/irqchip/irq-msi-lib.c:117:19: error: conflicting types for 'msi_lib_init_dev_msi_info'; have 'bool(struct device *, struct irq_domain *, struct irq_domain *, struct msi_domain_info *)' {aka '_Bool(struct device *, struct irq_domain *, struct irq_domain *, struct msi_domain_info *)'}
     117 | EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:76:28: note: in definition of macro '__EXPORT_SYMBOL'
      76 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:90:41: note: in expansion of macro '_EXPORT_SYMBOL'
      90 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
         |                                         ^~~~~~~~~~~~~~
   drivers/irqchip/irq-msi-lib.c:117:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     117 | EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);
         | ^~~~~~~~~~~~~~~~~
   include/linux/irqchip/irq-msi-lib.h:23:6: note: previous declaration of 'msi_lib_init_dev_msi_info' with type 'bool(struct device *, struct irq_domain *, struct irq_domain *, struct msi_domain_info *)' {aka '_Bool(struct device *, struct irq_domain *, struct irq_domain *, struct msi_domain_info *)'}
      23 | bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-msi-lib.c: In function 'msi_lib_irq_domain_select':
   drivers/irqchip/irq-msi-lib.c:134:45: error: 'struct irq_domain' has no member named 'msi_parent_ops'
     134 |         const struct msi_parent_ops *ops = d->msi_parent_ops;
         |                                             ^~
   drivers/irqchip/irq-msi-lib.c:144:29: error: invalid use of undefined type 'const struct msi_parent_ops'
     144 |         if (bus_token == ops->bus_select_token)
         |                             ^~
   drivers/irqchip/irq-msi-lib.c:147:22: error: invalid use of undefined type 'const struct msi_parent_ops'
     147 |         return !!(ops->bus_select_mask & busmask);
         |                      ^~
>> drivers/irqchip/irq-msi-lib.c:148:1: warning: control reaches end of non-void function [-Wreturn-type]
     148 | }
         | ^


vim +26 drivers/irqchip/irq-msi-lib.c

72e257c6f05803 Thomas Gleixner   2024-06-23    8  
72e257c6f05803 Thomas Gleixner   2024-06-23    9  /**
72e257c6f05803 Thomas Gleixner   2024-06-23   10   * msi_lib_init_dev_msi_info - Domain info setup for MSI domains
72e257c6f05803 Thomas Gleixner   2024-06-23   11   * @dev:		The device for which the domain is created for
72e257c6f05803 Thomas Gleixner   2024-06-23   12   * @domain:		The domain providing this callback
72e257c6f05803 Thomas Gleixner   2024-06-23   13   * @real_parent:	The real parent domain of the domain to be initialized
72e257c6f05803 Thomas Gleixner   2024-06-23   14   *			which might be a domain built on top of @domain or
72e257c6f05803 Thomas Gleixner   2024-06-23   15   *			@domain itself
72e257c6f05803 Thomas Gleixner   2024-06-23   16   * @info:		The domain info for the domain to be initialize
72e257c6f05803 Thomas Gleixner   2024-06-23   17   *
72e257c6f05803 Thomas Gleixner   2024-06-23   18   * This function is to be used for all types of MSI domains above the root
72e257c6f05803 Thomas Gleixner   2024-06-23   19   * parent domain and any intermediates. The topmost parent domain specific
72e257c6f05803 Thomas Gleixner   2024-06-23   20   * functionality is determined via @real_parent.
72e257c6f05803 Thomas Gleixner   2024-06-23   21   *
72e257c6f05803 Thomas Gleixner   2024-06-23   22   * All intermediate domains between the root and the device domain must
72e257c6f05803 Thomas Gleixner   2024-06-23   23   * have either msi_parent_ops.init_dev_msi_info = msi_parent_init_dev_msi_info
72e257c6f05803 Thomas Gleixner   2024-06-23   24   * or invoke it down the line.
72e257c6f05803 Thomas Gleixner   2024-06-23   25   */
72e257c6f05803 Thomas Gleixner   2024-06-23  @26  bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
72e257c6f05803 Thomas Gleixner   2024-06-23   27  			       struct irq_domain *real_parent,
72e257c6f05803 Thomas Gleixner   2024-06-23  @28  			       struct msi_domain_info *info)
72e257c6f05803 Thomas Gleixner   2024-06-23   29  {
72e257c6f05803 Thomas Gleixner   2024-06-23  @30  	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
1c000dcaad2bef Thomas Gleixner   2025-02-17  @31  	struct irq_chip *chip = info->chip;
8c41ccec839c62 Thomas Gleixner   2024-06-23   32  	u32 required_flags;
72e257c6f05803 Thomas Gleixner   2024-06-23   33  
72e257c6f05803 Thomas Gleixner   2024-06-23   34  	/* Parent ops available? */
72e257c6f05803 Thomas Gleixner   2024-06-23   35  	if (WARN_ON_ONCE(!pops))
72e257c6f05803 Thomas Gleixner   2024-06-23   36  		return false;
72e257c6f05803 Thomas Gleixner   2024-06-23   37  
72e257c6f05803 Thomas Gleixner   2024-06-23   38  	/*
72e257c6f05803 Thomas Gleixner   2024-06-23   39  	 * MSI parent domain specific settings. For now there is only the
72e257c6f05803 Thomas Gleixner   2024-06-23   40  	 * root parent domain, e.g. NEXUS, acting as a MSI parent, but it is
72e257c6f05803 Thomas Gleixner   2024-06-23   41  	 * possible to stack MSI parents. See x86 vector -> irq remapping
72e257c6f05803 Thomas Gleixner   2024-06-23   42  	 */
72e257c6f05803 Thomas Gleixner   2024-06-23  @43  	if (domain->bus_token == pops->bus_select_token) {
72e257c6f05803 Thomas Gleixner   2024-06-23   44  		if (WARN_ON_ONCE(domain != real_parent))
72e257c6f05803 Thomas Gleixner   2024-06-23   45  			return false;
72e257c6f05803 Thomas Gleixner   2024-06-23   46  	} else {
72e257c6f05803 Thomas Gleixner   2024-06-23   47  		WARN_ON_ONCE(1);
72e257c6f05803 Thomas Gleixner   2024-06-23   48  		return false;
72e257c6f05803 Thomas Gleixner   2024-06-23   49  	}
72e257c6f05803 Thomas Gleixner   2024-06-23   50  
8c41ccec839c62 Thomas Gleixner   2024-06-23   51  	required_flags = pops->required_flags;
8c41ccec839c62 Thomas Gleixner   2024-06-23   52  
72e257c6f05803 Thomas Gleixner   2024-06-23   53  	/* Is the target domain bus token supported? */
72e257c6f05803 Thomas Gleixner   2024-06-23   54  	switch(info->bus_token) {
8c41ccec839c62 Thomas Gleixner   2024-06-23   55  	case DOMAIN_BUS_PCI_DEVICE_MSI:
8c41ccec839c62 Thomas Gleixner   2024-06-23   56  	case DOMAIN_BUS_PCI_DEVICE_MSIX:
8c41ccec839c62 Thomas Gleixner   2024-06-23   57  		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_MSI)))
8c41ccec839c62 Thomas Gleixner   2024-06-23   58  			return false;
8c41ccec839c62 Thomas Gleixner   2024-06-23   59  
496436f4a514a3 Thomas Gleixner   2024-06-23   60  		break;
496436f4a514a3 Thomas Gleixner   2024-06-23   61  	case DOMAIN_BUS_DEVICE_MSI:
496436f4a514a3 Thomas Gleixner   2024-06-23   62  		/*
496436f4a514a3 Thomas Gleixner   2024-06-23   63  		 * Per device MSI should never have any MSI feature bits
496436f4a514a3 Thomas Gleixner   2024-06-23   64  		 * set. It's sole purpose is to create a dumb interrupt
496436f4a514a3 Thomas Gleixner   2024-06-23   65  		 * chip which has a device specific irq_write_msi_msg()
496436f4a514a3 Thomas Gleixner   2024-06-23   66  		 * callback.
496436f4a514a3 Thomas Gleixner   2024-06-23   67  		 */
496436f4a514a3 Thomas Gleixner   2024-06-23   68  		if (WARN_ON_ONCE(info->flags))
496436f4a514a3 Thomas Gleixner   2024-06-23   69  			return false;
496436f4a514a3 Thomas Gleixner   2024-06-23   70  
496436f4a514a3 Thomas Gleixner   2024-06-23   71  		/* Core managed MSI descriptors */
496436f4a514a3 Thomas Gleixner   2024-06-23  @72  		info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
64a855324311dd Thomas Gleixner   2024-06-23   73  		fallthrough;
64a855324311dd Thomas Gleixner   2024-06-23   74  	case DOMAIN_BUS_WIRED_TO_MSI:
496436f4a514a3 Thomas Gleixner   2024-06-23   75  		/* Remove PCI specific flags */
496436f4a514a3 Thomas Gleixner   2024-06-23  @76  		required_flags &= ~MSI_FLAG_PCI_MSI_MASK_PARENT;
8c41ccec839c62 Thomas Gleixner   2024-06-23   77  		break;
72e257c6f05803 Thomas Gleixner   2024-06-23   78  	default:
72e257c6f05803 Thomas Gleixner   2024-06-23   79  		/*
72e257c6f05803 Thomas Gleixner   2024-06-23   80  		 * This should never be reached. See
72e257c6f05803 Thomas Gleixner   2024-06-23   81  		 * msi_lib_irq_domain_select()
72e257c6f05803 Thomas Gleixner   2024-06-23   82  		 */
72e257c6f05803 Thomas Gleixner   2024-06-23   83  		WARN_ON_ONCE(1);
72e257c6f05803 Thomas Gleixner   2024-06-23   84  		return false;
72e257c6f05803 Thomas Gleixner   2024-06-23   85  	}
72e257c6f05803 Thomas Gleixner   2024-06-23   86  
72e257c6f05803 Thomas Gleixner   2024-06-23   87  	/*
72e257c6f05803 Thomas Gleixner   2024-06-23   88  	 * Mask out the domain specific MSI feature flags which are not
72e257c6f05803 Thomas Gleixner   2024-06-23   89  	 * supported by the real parent.
72e257c6f05803 Thomas Gleixner   2024-06-23   90  	 */
72e257c6f05803 Thomas Gleixner   2024-06-23   91  	info->flags			&= pops->supported_flags;
72e257c6f05803 Thomas Gleixner   2024-06-23   92  	/* Enforce the required flags */
8c41ccec839c62 Thomas Gleixner   2024-06-23   93  	info->flags			|= required_flags;
72e257c6f05803 Thomas Gleixner   2024-06-23   94  
72e257c6f05803 Thomas Gleixner   2024-06-23   95  	/* Chip updates for all child bus types */
1c000dcaad2bef Thomas Gleixner   2025-02-17  @96  	if (!chip->irq_eoi && (pops->chip_flags & MSI_CHIP_FLAG_SET_EOI))
1c000dcaad2bef Thomas Gleixner   2025-02-17   97  		chip->irq_eoi = irq_chip_eoi_parent;
1c000dcaad2bef Thomas Gleixner   2025-02-17  @98  	if (!chip->irq_ack && (pops->chip_flags & MSI_CHIP_FLAG_SET_ACK))
1c000dcaad2bef Thomas Gleixner   2025-02-17   99  		chip->irq_ack = irq_chip_ack_parent;
72e257c6f05803 Thomas Gleixner   2024-06-23  100  
72e257c6f05803 Thomas Gleixner   2024-06-23  101  	/*
72e257c6f05803 Thomas Gleixner   2024-06-23  102  	 * The device MSI domain can never have a set affinity callback. It
72e257c6f05803 Thomas Gleixner   2024-06-23  103  	 * always has to rely on the parent domain to handle affinity
72e257c6f05803 Thomas Gleixner   2024-06-23  104  	 * settings. The device MSI domain just has to write the resulting
72e257c6f05803 Thomas Gleixner   2024-06-23  105  	 * MSI message into the hardware which is the whole purpose of the
72e257c6f05803 Thomas Gleixner   2024-06-23  106  	 * device MSI domain aside of mask/unmask which is provided e.g. by
72e257c6f05803 Thomas Gleixner   2024-06-23  107  	 * PCI/MSI device domains.
06526443a34c06 Marc Zyngier      2025-05-13  108  	 *
06526443a34c06 Marc Zyngier      2025-05-13  109  	 * The exception to the rule is when the underlying domain
06526443a34c06 Marc Zyngier      2025-05-13  110  	 * tells you that affinity is not a thing -- for example when
06526443a34c06 Marc Zyngier      2025-05-13  111  	 * everything is muxed behind a single interrupt.
72e257c6f05803 Thomas Gleixner   2024-06-23  112  	 */
06526443a34c06 Marc Zyngier      2025-05-13 @113  	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
1c000dcaad2bef Thomas Gleixner   2025-02-17 @114  		chip->irq_set_affinity = msi_domain_set_affinity;
72e257c6f05803 Thomas Gleixner   2024-06-23  115  	return true;
72e257c6f05803 Thomas Gleixner   2024-06-23  116  }
72e257c6f05803 Thomas Gleixner   2024-06-23  117  EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);
72e257c6f05803 Thomas Gleixner   2024-06-23  118  
72e257c6f05803 Thomas Gleixner   2024-06-23  119  /**
72e257c6f05803 Thomas Gleixner   2024-06-23  120   * msi_lib_irq_domain_select - Shared select function for NEXUS domains
72e257c6f05803 Thomas Gleixner   2024-06-23  121   * @d:		Pointer to the irq domain on which select is invoked
72e257c6f05803 Thomas Gleixner   2024-06-23  122   * @fwspec:	Firmware spec describing what is searched
72e257c6f05803 Thomas Gleixner   2024-06-23  123   * @bus_token:	The bus token for which a matching irq domain is looked up
72e257c6f05803 Thomas Gleixner   2024-06-23  124   *
72e257c6f05803 Thomas Gleixner   2024-06-23  125   * Returns:	%0 if @d is not what is being looked for
72e257c6f05803 Thomas Gleixner   2024-06-23  126   *
72e257c6f05803 Thomas Gleixner   2024-06-23  127   *		%1 if @d is either the domain which is directly searched for or
72e257c6f05803 Thomas Gleixner   2024-06-23  128   *		   if @d is providing the parent MSI domain for the functionality
72e257c6f05803 Thomas Gleixner   2024-06-23  129   *			 requested with @bus_token.
72e257c6f05803 Thomas Gleixner   2024-06-23  130   */
72e257c6f05803 Thomas Gleixner   2024-06-23  131  int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
72e257c6f05803 Thomas Gleixner   2024-06-23  132  			      enum irq_domain_bus_token bus_token)
72e257c6f05803 Thomas Gleixner   2024-06-23  133  {
72e257c6f05803 Thomas Gleixner   2024-06-23  134  	const struct msi_parent_ops *ops = d->msi_parent_ops;
72e257c6f05803 Thomas Gleixner   2024-06-23  135  	u32 busmask = BIT(bus_token);
72e257c6f05803 Thomas Gleixner   2024-06-23  136  
880799fc7a3a12 Maxime Chevallier 2024-08-23  137  	if (!ops)
880799fc7a3a12 Maxime Chevallier 2024-08-23  138  		return 0;
880799fc7a3a12 Maxime Chevallier 2024-08-23  139  
72e257c6f05803 Thomas Gleixner   2024-06-23  140  	if (fwspec->fwnode != d->fwnode || fwspec->param_count != 0)
72e257c6f05803 Thomas Gleixner   2024-06-23  141  		return 0;
72e257c6f05803 Thomas Gleixner   2024-06-23  142  
72e257c6f05803 Thomas Gleixner   2024-06-23  143  	/* Handle pure domain searches */
72e257c6f05803 Thomas Gleixner   2024-06-23  144  	if (bus_token == ops->bus_select_token)
72e257c6f05803 Thomas Gleixner   2024-06-23  145  		return 1;
72e257c6f05803 Thomas Gleixner   2024-06-23  146  
880799fc7a3a12 Maxime Chevallier 2024-08-23  147  	return !!(ops->bus_select_mask & busmask);
72e257c6f05803 Thomas Gleixner   2024-06-23 @148  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

