Return-Path: <linux-hyperv+bounces-5413-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9596AAE6C1
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 18:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A041889141
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF87D28B509;
	Wed,  7 May 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEU8Fffk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD84201266;
	Wed,  7 May 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635364; cv=none; b=UeMqpmbTzOl/S8ZmgGHQXPi7YoKE/yo/pj16bYhZSumwVda9Kko5c6aBplgz0LXM5akZ6hVn5jyvYi8mYkDT2EorSypjwiIv7NdmF9omjq4KkXIliErkaOwaC7sh2SKuih9lJw/ZW25bHokmyi8BTaawZEBI9IVHJT9HMSt+L0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635364; c=relaxed/simple;
	bh=LjPYYfMdxis7ITOMKVHr/CAOCVAW0IbwVEhXnZ55sxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiCkSymYBwhEpBRdf16jS2CuWuJxfLBU4nTniqmkTJa8W4h5hUkZY8lXdwetz9YRQFl9sPiK53RjBnk/QPRg/bs7dNKVMaDe86nLw7gF30XPdxXX7vjRowxH/M6sbFu3NCJPNklEmCZ4BUzgVnIeEKhPrSM2Hxrp6cTqhED5ZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEU8Fffk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746635363; x=1778171363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LjPYYfMdxis7ITOMKVHr/CAOCVAW0IbwVEhXnZ55sxo=;
  b=gEU8FffkmbhHbSNC5TcWOrtyETQHVIzGyNrkiJwr5CTFH9ASAHEPMckD
   cSDvJJL3H0sy6REDaoP1dT21KyUaOlrV1feQ1YtlfOI+r4x0Q1HtpesGo
   e5HdZPrnIQZ7lvoDauDEYYC7VpqWv+YX5e1kn9zDp9A7WLrpAJ1muIV5u
   T6xZjCBks4bq870OZ/1AN72LAm0nctVhnMXvpzIxjGSy5dikg/F9+uASf
   H1L0l4XsDXDU9rfCRUhI5r8n2zLmrBnj83fCBg99T9FCDkiPY23/JB5o5
   WetBkqCacPHyuZ/cVqFGbcBpZUyrBF4TlAXlymkumYqGY/cQZkqUqlDK2
   A==;
X-CSE-ConnectionGUID: 7PHRl6zrRW6VOl20qfxf1A==
X-CSE-MsgGUID: uTFjb2zaTAyKoF4cJDaQFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48536568"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="48536568"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 09:29:22 -0700
X-CSE-ConnectionGUID: /qLkKdV/RSK4Bax55Pv+ug==
X-CSE-MsgGUID: q2i/ICsATHi57GGk/T2P3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="141201293"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 May 2025 09:29:16 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uChdx-0008AL-1P;
	Wed, 07 May 2025 16:29:13 +0000
Date: Thu, 8 May 2025 00:28:49 +0800
From: kernel test robot <lkp@intel.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net: mana: Allow MANA driver to allocate PCI vector
 dynamically
Message-ID: <202505080049.7AvfzOGc-lkp@intel.com>
References: <1744817781-3243-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744817781-3243-1-git-send-email-shradhagupta@linux.microsoft.com>

Hi Shradha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.15-rc5 next-20250507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shradha-Gupta/PCI-hv-enable-pci_hyperv-to-allow-dynamic-vector-allocation/20250416-233828
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/1744817781-3243-1-git-send-email-shradhagupta%40linux.microsoft.com
patch subject: [PATCH 2/2] net: mana: Allow MANA driver to allocate PCI vector dynamically
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250508/202505080049.7AvfzOGc-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505080049.7AvfzOGc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505080049.7AvfzOGc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/microsoft/mana/gdma_main.c:500:2: warning: variable 'gic' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
     500 |         list_for_each(pos, &gc->irq_contexts) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:687:27: note: expanded from macro 'list_for_each'
     687 |         for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/microsoft/mana/gdma_main.c:510:7: note: uninitialized use occurs here
     510 |         if (!gic)
         |              ^~~
   drivers/net/ethernet/microsoft/mana/gdma_main.c:500:2: note: remove the condition if it is always true
     500 |         list_for_each(pos, &gc->irq_contexts) {
         |         ^
   include/linux/list.h:687:27: note: expanded from macro 'list_for_each'
     687 |         for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
         |                                  ^
   drivers/net/ethernet/microsoft/mana/gdma_main.c:475:30: note: initialize the variable 'gic' to silence this warning
     475 |         struct gdma_irq_context *gic;
         |                                     ^
         |                                      = NULL
   drivers/net/ethernet/microsoft/mana/gdma_main.c:541:2: warning: variable 'gic' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
     541 |         list_for_each(pos, &gc->irq_contexts) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:687:27: note: expanded from macro 'list_for_each'
     687 |         for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/microsoft/mana/gdma_main.c:551:7: note: uninitialized use occurs here
     551 |         if (!gic)
         |              ^~~
   drivers/net/ethernet/microsoft/mana/gdma_main.c:541:2: note: remove the condition if it is always true
     541 |         list_for_each(pos, &gc->irq_contexts) {
         |         ^
   include/linux/list.h:687:27: note: expanded from macro 'list_for_each'
     687 |         for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
         |                                  ^
   drivers/net/ethernet/microsoft/mana/gdma_main.c:523:30: note: initialize the variable 'gic' to silence this warning
     523 |         struct gdma_irq_context *gic;
         |                                     ^
         |                                      = NULL
   2 warnings generated.


vim +500 drivers/net/ethernet/microsoft/mana/gdma_main.c

   470	
   471	static int mana_gd_register_irq(struct gdma_queue *queue,
   472					const struct gdma_queue_spec *spec)
   473	{
   474		struct gdma_dev *gd = queue->gdma_dev;
   475		struct gdma_irq_context *gic;
   476		struct gdma_context *gc;
   477		unsigned int msi_index;
   478		struct list_head *pos;
   479		unsigned long flags, flag_irq;
   480		struct device *dev;
   481		int err = 0, count;
   482	
   483		gc = gd->gdma_context;
   484		dev = gc->dev;
   485		msi_index = spec->eq.msix_index;
   486	
   487		if (msi_index >= gc->num_msix_usable) {
   488			err = -ENOSPC;
   489			dev_err(dev, "Register IRQ err:%d, msi:%u nMSI:%u",
   490				err, msi_index, gc->num_msix_usable);
   491	
   492			return err;
   493		}
   494	
   495		queue->eq.msix_index = msi_index;
   496	
   497		/* get the msi_index value from the list*/
   498		count = 0;
   499		spin_lock_irqsave(&gc->irq_ctxs_lock, flag_irq);
 > 500		list_for_each(pos, &gc->irq_contexts) {
   501			if (count == msi_index) {
   502				gic = list_entry(pos, struct gdma_irq_context, gic_list);
   503				break;
   504			}
   505	
   506			count++;
   507		}
   508		spin_unlock_irqrestore(&gc->irq_ctxs_lock, flag_irq);
   509	
   510		if (!gic)
   511			return -1;
   512	
   513		spin_lock_irqsave(&gic->lock, flags);
   514		list_add_rcu(&queue->entry, &gic->eq_list);
   515		spin_unlock_irqrestore(&gic->lock, flags);
   516	
   517		return 0;
   518	}
   519	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

