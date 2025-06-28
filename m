Return-Path: <linux-hyperv+bounces-6045-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D8BAEC838
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 17:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1CA174E2F
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 15:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BE4212B2B;
	Sat, 28 Jun 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eC1XPplo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD5121019C;
	Sat, 28 Jun 2025 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751123980; cv=none; b=TX9DGAz9mpQXad/Uwc4EF48g5Q4UqILMcW60i4i26QbZgV8oiRieGjPWC6fbiH5XuR6wEe8YchIZFTEtTXnzm3zJXao6eQ1P/5TRXl33Gz26iBt83uFAj5muIvnbiaGSgAmitMWWH+qnfVcsYk7+uRaqYXUhu8bVijN1fZz/tIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751123980; c=relaxed/simple;
	bh=XK4HMbYqe5lBvehgeZ5b6wX+d1FRmOk1MWPacl29n0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zm0eE5/pmUF0oibkokvXYZsk3tKafycETmL/WkyZwzD7exETn12HJR+6+kSVc7AXmeP+V50RAvHuXShE6uu93IVd/LreZ73416qVK7U1rVrUwvi3lTZ6SxzPaNvNBhcp7jol2g28E53GsjODljGRgUt+B8aDQebUQnGo786qBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eC1XPplo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751123978; x=1782659978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XK4HMbYqe5lBvehgeZ5b6wX+d1FRmOk1MWPacl29n0c=;
  b=eC1XPplohapn1ZhA+rczmlrGJo57H4HPdKZK7y8n4sIJYmDPihGTDpby
   q+VC4J2HnBla9g4+Z69Z42ZQrLZ2p1q+RscRlQWVr9H0zABtdSoxVgpOX
   t/uNFOlT4khlTB9xpZk34UeFc756cq4f7a8TIVX9rQ4/ypvebdbORnQKO
   LQ6HTHV9e4B6Xtchp6RFJNUPeQzmaMkg1YpRGkJE/Gob5BZHyViXpazGa
   khtTwKw/vG7MDgmfFiL4laRPwN0OlcYSyPwlRUDS3COpR/8XCiKGy81qA
   evBFFL6DwLIIkiP+p8W7h99gZYoD+asg8QDtkHRFpsVvOyQC2jZdpbMTA
   w==;
X-CSE-ConnectionGUID: Zzae07yOQYSTo0L1wK+dZw==
X-CSE-MsgGUID: l8tMK0DPSQSLPM1Iqw7/xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11478"; a="53501275"
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="53501275"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 08:19:37 -0700
X-CSE-ConnectionGUID: qZzmuQ/CSxKgMqtwIDYTGQ==
X-CSE-MsgGUID: +ojCm4X1Q7eZcWX/PGcXxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="157444417"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 Jun 2025 08:19:33 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVXL0-000X8c-2z;
	Sat, 28 Jun 2025 15:19:30 +0000
Date: Sat, 28 Jun 2025 23:18:36 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 1/1] x86/hyperv: Switch to msi_create_parent_irq_domain()
Message-ID: <202506282256.cHlEHrdc-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/master]
[also build test WARNING on linus/master v6.16-rc3 next-20250627]
[cannot apply to tip/x86/core tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nam-Cao/x86-hyperv-Switch-to-msi_create_parent_irq_domain/20250626-225420
base:   tip/master
patch link:    https://lore.kernel.org/r/0eafade05acb51022242635750cd4990f3adb0ac.1750947640.git.namcao%40linutronix.de
patch subject: [PATCH 1/1] x86/hyperv: Switch to msi_create_parent_irq_domain()
config: x86_64-buildonly-randconfig-002-20250628 (https://download.01.org/0day-ci/archive/20250628/202506282256.cHlEHrdc-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506282256.cHlEHrdc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506282256.cHlEHrdc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/irqchip/irq-msi-lib.c:7:
>> include/linux/irqchip/irq-msi-lib.h:25:18: warning: declaration of 'struct msi_domain_info' will not be visible outside of this function [-Wvisibility]
      25 |                                struct msi_domain_info *info);
         |                                       ^
>> drivers/irqchip/irq-msi-lib.c:28:18: warning: declaration of 'struct msi_domain_info' will not be visible outside of this function [-Wvisibility]
      28 |                                struct msi_domain_info *info)
         |                                       ^
   drivers/irqchip/irq-msi-lib.c:26:6: error: conflicting types for 'msi_lib_init_dev_msi_info'
      26 | bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
         |      ^
   include/linux/irqchip/irq-msi-lib.h:23:6: note: previous declaration is here
      23 | bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
         |      ^
   drivers/irqchip/irq-msi-lib.c:30:51: error: no member named 'msi_parent_ops' in 'struct irq_domain'
      30 |         const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
         |                                             ~~~~~~~~~~~  ^
   drivers/irqchip/irq-msi-lib.c:31:30: error: incomplete definition of type 'struct msi_domain_info'
      31 |         struct irq_chip *chip = info->chip;
         |                                 ~~~~^
   drivers/irqchip/irq-msi-lib.c:28:18: note: forward declaration of 'struct msi_domain_info'
      28 |                                struct msi_domain_info *info)
         |                                       ^
   drivers/irqchip/irq-msi-lib.c:43:31: error: incomplete definition of type 'const struct msi_parent_ops'
      43 |         if (domain->bus_token == pops->bus_select_token) {
         |                                  ~~~~^
   include/linux/irqdomain.h:27:8: note: forward declaration of 'struct msi_parent_ops'
      27 | struct msi_parent_ops;
         |        ^
   drivers/irqchip/irq-msi-lib.c:51:23: error: incomplete definition of type 'const struct msi_parent_ops'
      51 |         required_flags = pops->required_flags;
         |                          ~~~~^
   include/linux/irqdomain.h:27:8: note: forward declaration of 'struct msi_parent_ops'
      27 | struct msi_parent_ops;
         |        ^
   drivers/irqchip/irq-msi-lib.c:54:13: error: incomplete definition of type 'struct msi_domain_info'
      54 |         switch(info->bus_token) {
         |                ~~~~^
   drivers/irqchip/irq-msi-lib.c:28:18: note: forward declaration of 'struct msi_domain_info'
      28 |                                struct msi_domain_info *info)
         |                                       ^
   drivers/irqchip/irq-msi-lib.c:68:24: error: incomplete definition of type 'struct msi_domain_info'
      68 |                 if (WARN_ON_ONCE(info->flags))
         |                                  ~~~~^
   include/asm-generic/bug.h:117:25: note: expanded from macro 'WARN_ON_ONCE'
     117 |         int __ret_warn_on = !!(condition);                      \
         |                                ^~~~~~~~~
   drivers/irqchip/irq-msi-lib.c:28:18: note: forward declaration of 'struct msi_domain_info'
      28 |                                struct msi_domain_info *info)
         |                                       ^
   drivers/irqchip/irq-msi-lib.c:72:7: error: incomplete definition of type 'struct msi_domain_info'
      72 |                 info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
         |                 ~~~~^
   drivers/irqchip/irq-msi-lib.c:28:18: note: forward declaration of 'struct msi_domain_info'
      28 |                                struct msi_domain_info *info)
         |                                       ^
   drivers/irqchip/irq-msi-lib.c:72:17: error: use of undeclared identifier 'MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS'
      72 |                 info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
         |                               ^
   drivers/irqchip/irq-msi-lib.c:72:51: error: use of undeclared identifier 'MSI_FLAG_FREE_MSI_DESCS'
      72 |                 info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
         |                                                                 ^
   drivers/irqchip/irq-msi-lib.c:76:22: error: use of undeclared identifier 'MSI_FLAG_PCI_MSI_MASK_PARENT'
      76 |                 required_flags &= ~MSI_FLAG_PCI_MSI_MASK_PARENT;
         |                                    ^
   drivers/irqchip/irq-msi-lib.c:91:6: error: incomplete definition of type 'struct msi_domain_info'
      91 |         info->flags                     &= pops->supported_flags;
         |         ~~~~^
   drivers/irqchip/irq-msi-lib.c:28:18: note: forward declaration of 'struct msi_domain_info'
      28 |                                struct msi_domain_info *info)
         |                                       ^
   drivers/irqchip/irq-msi-lib.c:91:23: error: incomplete definition of type 'const struct msi_parent_ops'
      91 |         info->flags                     &= pops->supported_flags;
         |                                            ~~~~^
   include/linux/irqdomain.h:27:8: note: forward declaration of 'struct msi_parent_ops'
      27 | struct msi_parent_ops;
         |        ^
   drivers/irqchip/irq-msi-lib.c:93:6: error: incomplete definition of type 'struct msi_domain_info'
      93 |         info->flags                     |= required_flags;
         |         ~~~~^
   drivers/irqchip/irq-msi-lib.c:28:18: note: forward declaration of 'struct msi_domain_info'
      28 |                                struct msi_domain_info *info)
         |                                       ^
   drivers/irqchip/irq-msi-lib.c:96:29: error: incomplete definition of type 'const struct msi_parent_ops'
      96 |         if (!chip->irq_eoi && (pops->chip_flags & MSI_CHIP_FLAG_SET_EOI))
         |                                ~~~~^
   include/linux/irqdomain.h:27:8: note: forward declaration of 'struct msi_parent_ops'
      27 | struct msi_parent_ops;
         |        ^
   drivers/irqchip/irq-msi-lib.c:96:44: error: use of undeclared identifier 'MSI_CHIP_FLAG_SET_EOI'
      96 |         if (!chip->irq_eoi && (pops->chip_flags & MSI_CHIP_FLAG_SET_EOI))
         |                                                   ^
   drivers/irqchip/irq-msi-lib.c:98:29: error: incomplete definition of type 'const struct msi_parent_ops'
      98 |         if (!chip->irq_ack && (pops->chip_flags & MSI_CHIP_FLAG_SET_ACK))
         |                                ~~~~^
   include/linux/irqdomain.h:27:8: note: forward declaration of 'struct msi_parent_ops'
      27 | struct msi_parent_ops;
         |        ^
   drivers/irqchip/irq-msi-lib.c:98:44: error: use of undeclared identifier 'MSI_CHIP_FLAG_SET_ACK'
      98 |         if (!chip->irq_ack && (pops->chip_flags & MSI_CHIP_FLAG_SET_ACK))
         |                                                   ^
   drivers/irqchip/irq-msi-lib.c:113:39: error: incomplete definition of type 'struct msi_domain_info'
     113 |         if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
         |                                          ~~~~^
   drivers/irqchip/irq-msi-lib.c:28:18: note: forward declaration of 'struct msi_domain_info'
      28 |                                struct msi_domain_info *info)


vim +25 include/linux/irqchip/irq-msi-lib.h

496436f4a514a3 drivers/irqchip/irq-msi-lib.h Thomas Gleixner 2024-06-23  19  
72e257c6f05803 drivers/irqchip/irq-msi-lib.h Thomas Gleixner 2024-06-23  20  int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
72e257c6f05803 drivers/irqchip/irq-msi-lib.h Thomas Gleixner 2024-06-23  21  			      enum irq_domain_bus_token bus_token);
72e257c6f05803 drivers/irqchip/irq-msi-lib.h Thomas Gleixner 2024-06-23  22  
72e257c6f05803 drivers/irqchip/irq-msi-lib.h Thomas Gleixner 2024-06-23  23  bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
72e257c6f05803 drivers/irqchip/irq-msi-lib.h Thomas Gleixner 2024-06-23  24  			       struct irq_domain *real_parent,
72e257c6f05803 drivers/irqchip/irq-msi-lib.h Thomas Gleixner 2024-06-23 @25  			       struct msi_domain_info *info);
72e257c6f05803 drivers/irqchip/irq-msi-lib.h Thomas Gleixner 2024-06-23  26  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

