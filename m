Return-Path: <linux-hyperv+bounces-10526-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePX4NLeF82kY4wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10526-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 18:39:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE184A5D9D
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 18:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7570300B100
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70813472780;
	Thu, 30 Apr 2026 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dz5o9OOH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D8646AF2B;
	Thu, 30 Apr 2026 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566834; cv=none; b=GkE0t9AIvha+A8xgYeBSHasiqy8qy3nOEzo1YHj5d53y/xIcmJdkkWUDELbpNlB8meZwARrEtM6Y08aA77fJ5+Ylw+rK1AXslk9ukL8G2zRXSVnBzA9BxAObDkxkm244VftWW/VeEugRpQaUBH8na3tI2SrbbzYmqVbX9Qpbavc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566834; c=relaxed/simple;
	bh=cfENCjc1fzzR6KbL+6+PAAkvtumH6My77uGSdh60sFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqusAnQKoLFsqRUgzwrxmy43R7Kn6fF8DH6P/5tKdZPHDN3Mz9ntCpNtn6hfSci10uzw6XQCXYl5ig9uRLOQwkYoUzEZrMzneoCoQd8YkCCVJI2JRoK0F90mg+5QqFxbKWfHCnJ25DkWOpvNjjBHHz/6uKwI8WCKMIXXK2vAQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dz5o9OOH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777566832; x=1809102832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cfENCjc1fzzR6KbL+6+PAAkvtumH6My77uGSdh60sFg=;
  b=dz5o9OOHBRiOVjwahPWla7r/T4wsp3a7wa/1Y2Mcs+063ooj9/Q2Ol3x
   hI1TnQ2Uzgc0BZj/FWredUq6WGboSgQG+IsCqYj3DLprE4jOgkfu1yH35
   YsV604jwIyE2DQT6lKYZFk7GcLaHFX42kUtXfHKGHQh1pows9Q4C96YgZ
   eetTINU0UHVyEwSiTHHqFV6jBglyh0+tOSJ+z9fEbWuG3F5gZUsZYRaVD
   Io2pAqEJdQV65y5vZPZE5UcPnpQc4TJ86th/onrYTKwPAkmfIa7mLGqN/
   eaSXBljGCthN9iqUXGVSCGaMTGJtxUBvC9r/7iww5bh6uFGmNaX1seY1K
   Q==;
X-CSE-ConnectionGUID: du4+MePWQEu5cx9OCmfPYw==
X-CSE-MsgGUID: MChYPw37QhqohImxjdUOiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78236273"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78236273"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 09:33:52 -0700
X-CSE-ConnectionGUID: eQNDi5mTSUy9Qg9nksZGIw==
X-CSE-MsgGUID: gnxf2RtZQkewiLYuAZR9QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="230278698"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Apr 2026 09:33:48 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIUKf-00000000CeW-2GTG;
	Thu, 30 Apr 2026 16:33:45 +0000
Date: Fri, 1 May 2026 00:33:18 +0800
From: kernel test robot <lkp@intel.com>
To: Dexuan Cui <decui@microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhklinux@outlook.com, matthew.ruffell@canonical.com,
	johansen@templeofstupid.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving
 fb_mmio on Gen2 VMs
Message-ID: <202605010002.dnnxVZFF-lkp@intel.com>
References: <20260416183529.838321-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416183529.838321-1-decui@microsoft.com>
X-Rspamd-Queue-Id: 2BE184A5D9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10526-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,vger.kernel.org,outlook.com,canonical.com,templeofstupid.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url]

Hi Dexuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.1-rc1 next-20260429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dexuan-Cui/Drivers-hv-vmbus-Improve-the-logc-of-reserving-fb_mmio-on-Gen2-VMs/20260424-033622
base:   linus/master
patch link:    https://lore.kernel.org/r/20260416183529.838321-1-decui%40microsoft.com
patch subject: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving fb_mmio on Gen2 VMs
config: i386-buildonly-randconfig-002-20260430 (https://download.01.org/0day-ci/archive/20260501/202605010002.dnnxVZFF-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260501/202605010002.dnnxVZFF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605010002.dnnxVZFF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hv/vmbus_drv.c:2403:40: warning: result of comparison of constant 4294967296 with expression of type 'resource_size_t' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
    2403 |                         if (!low_mmio_base || low_mmio_base >= SZ_4G ||
         |                                               ~~~~~~~~~~~~~ ^  ~~~~~
   1 warning generated.


vim +2403 drivers/hv/vmbus_drv.c

  2385	
  2386	static void __maybe_unused vmbus_reserve_fb(void)
  2387	{
  2388		resource_size_t start = 0, size;
  2389		resource_size_t low_mmio_base;
  2390		struct pci_dev *pdev;
  2391	
  2392		/* Hyper-V CoCo guests do not have a framebuffer device. */
  2393		if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
  2394			return;
  2395	
  2396		if (efi_enabled(EFI_BOOT)) {
  2397			/* Gen2 VM: get FB base from EFI framebuffer */
  2398			if (IS_ENABLED(CONFIG_SYSFB)) {
  2399				start = sysfb_primary_display.screen.lfb_base;
  2400				size = max_t(__u32, sysfb_primary_display.screen.lfb_size, 0x800000);
  2401	
  2402				low_mmio_base = hyperv_mmio->start;
> 2403				if (!low_mmio_base || low_mmio_base >= SZ_4G ||
  2404				    (start && start < low_mmio_base)) {
  2405					pr_warn("Unexpected low mmio base 0x%pa\n", &low_mmio_base);
  2406				} else {
  2407					/*
  2408					 * If the kdump kernel's lfb_base is 0,
  2409					 * fall back to the low mmio base.
  2410					 */
  2411					if (!start)
  2412						start = low_mmio_base;
  2413					/*
  2414					 * Reserve half of the space below 4GB for high
  2415					 * resolutions, but cap the reservation to 128MB.
  2416					 */
  2417					size = min((SZ_4G - start) / 2, SZ_128M);
  2418				}
  2419			}
  2420		} else {
  2421			/* Gen1 VM: get FB base from PCI */
  2422			pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
  2423					      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
  2424			if (!pdev)
  2425				return;
  2426	
  2427			if (pdev->resource[0].flags & IORESOURCE_MEM) {
  2428				start = pci_resource_start(pdev, 0);
  2429				size = pci_resource_len(pdev, 0);
  2430			}
  2431	
  2432			/*
  2433			 * Release the PCI device so hyperv_drm driver can grab it
  2434			 * later.
  2435			 */
  2436			pci_dev_put(pdev);
  2437		}
  2438	
  2439		if (!start)
  2440			return;
  2441	
  2442		/*
  2443		 * Make a claim for the frame buffer in the resource tree under the
  2444		 * first node, which will be the one below 4GB.  The length seems to
  2445		 * be underreported, particularly in a Generation 1 VM.  So start out
  2446		 * reserving a larger area and make it smaller until it succeeds.
  2447		 */
  2448		for (; !fb_mmio && (size >= 0x100000); size >>= 1)
  2449			fb_mmio = __request_region(hyperv_mmio, start, size, fb_mmio_name, 0);
  2450	
  2451		pr_info("hv_mmio=%pR,%pR fb=%pR\n", hyperv_mmio, hyperv_mmio->sibling, fb_mmio);
  2452	}
  2453	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

