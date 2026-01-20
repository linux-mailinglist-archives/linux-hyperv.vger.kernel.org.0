Return-Path: <linux-hyperv+bounces-8389-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGo3NGrqb2m+UQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8389-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 21:49:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 833B14BBCD
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 21:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA9D58E644A
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 19:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4BB40B6E4;
	Tue, 20 Jan 2026 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsiLtTZr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334263A4F5F;
	Tue, 20 Jan 2026 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938844; cv=none; b=rhjro2byxtqJuht0KQAAnurC1ynoMo/sEqz/vqpIYB1UmOcCKZqR9y8tJnOmvfGQEVdkHgTNedWgpg+KEdALJ4hDo9WckmU/UIuT8TB4s6MkoLjfcjxxBY2/bqOk/FPte72RbeGoOk02feG7XlWBDmD15Rw7ah9HSYHmQ1I3XUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938844; c=relaxed/simple;
	bh=kfSaGevMQFowY+aKVSV83hPV0nA0s1ZbBBUZe878q3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MME+EcQu6tGOxWxuPvK6vSOARxL2vzXdGIkVwt74B2xFGHY+lChFltomkW/pOA+hcJkPPRxGY7/dhF0NL+PNU8oDgKJGL22HxlJ5JOQirLO+d8ZhNEeYMOVfRUeI4E4dFrXxjZ+AmpN51qh9x0mzwzwotfQYrKWpw4HDGD6hxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsiLtTZr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768938842; x=1800474842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kfSaGevMQFowY+aKVSV83hPV0nA0s1ZbBBUZe878q3Q=;
  b=dsiLtTZrDUZ71NQM+F4z2nLBVii/u77axuh7BFBPo8dDfOOjnmhgnS2k
   U+nUZDBU/x0CobzhvgP36LsMnWOUG1JZWTnHX1k0kQzgl7NesYNEtJ2wm
   5TCbCKjhLyTBSRGpCCSA+w4VB3h+fV4dqW1oDCcaQo0jRWeHfiRk9dPwl
   7ChZYFhH21gWoJKZ/MlTcc4hIF2oWIcxoUZMnzP+Qd28z+FBpWpd6VRFG
   rui07pi/NpROoeO9CoN2B6a2IFAAcBPMzslJsUgFaZvemi0zczZDM7a0N
   LKISD3qyNefwZY+ffh/VVJdYW0Vg+CNgXDtj8l+yArLxXGZ5U8PHRt8zT
   A==;
X-CSE-ConnectionGUID: GD+L4g5MQ0CpUquQ7BSG9A==
X-CSE-MsgGUID: pJ5F1aelS5a4WH0GRbC8UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80881361"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="80881361"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:53:55 -0800
X-CSE-ConnectionGUID: ij5CQKEaTmqLtcKeWjAPfw==
X-CSE-MsgGUID: 3aSxQKx6TVefUIwROoJlkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="206130616"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Jan 2026 11:53:49 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viHnO-00000000PSX-1Fbu;
	Tue, 20 Jan 2026 19:53:46 +0000
Date: Wed, 21 Jan 2026 03:52:58 +0800
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
Subject: Re: [PATCH v0 15/15] mshv: Populate mmio mappings for PCI passthru
Message-ID: <202601210255.2ZZOLtMV-lkp@intel.com>
References: <20260120064230.3602565-16-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064230.3602565-16-mrathor@linux.microsoft.com>
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
	TAGGED_FROM(0.00)[bounces-8389-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url]
X-Rspamd-Queue-Id: 833B14BBCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mukesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on pci/next pci/for-linus arm64/for-next/core soc/for-next linus/master v6.19-rc6]
[cannot apply to clk/clk-next arnd-asm-generic/master next-20260119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-R/iommu-hyperv-rename-hyperv-iommu-c-to-hyperv-irq-c/20260120-145832
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20260120064230.3602565-16-mrathor%40linux.microsoft.com
patch subject: [PATCH v0 15/15] mshv: Populate mmio mappings for PCI passthru
config: x86_64-randconfig-003-20260120 (https://download.01.org/0day-ci/archive/20260121/202601210255.2ZZOLtMV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260121/202601210255.2ZZOLtMV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601210255.2ZZOLtMV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hv/mshv_root_main.c:60:19: warning: 'setup_hv_full_mmio' defined but not used [-Wunused-function]
      60 | static int __init setup_hv_full_mmio(char *str)
         |                   ^~~~~~~~~~~~~~~~~~


vim +/setup_hv_full_mmio +60 drivers/hv/mshv_root_main.c

    58	
    59	bool hv_nofull_mmio;   /* don't map entire mmio region upon fault */
  > 60	static int __init setup_hv_full_mmio(char *str)
    61	{
    62		hv_nofull_mmio = true;
    63		return 0;
    64	}
    65	__setup("hv_nofull_mmio", setup_hv_full_mmio);
    66	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

