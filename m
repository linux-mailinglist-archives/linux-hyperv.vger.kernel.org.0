Return-Path: <linux-hyperv+bounces-8388-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EhDAgHub2m+UQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8388-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 22:05:05 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E104BEF2
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 22:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 969F79433D3
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jan 2026 19:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB2046AEC7;
	Tue, 20 Jan 2026 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PYDqAKB1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73E30E0F4;
	Tue, 20 Jan 2026 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936132; cv=none; b=YWcYGxMD5PwzKZRkcZ67FpcoLm05w9ePEn2LmM3R/9tbTl5/qD3xR8E/OZyiFgXPLdn6e1D6sX1SZeDbV67DI51aVeuxmtHbbU9aKKHiHRwUmfqN4tHQKrUamt6IwmXo244w70OkuoGBB6hNbCmp6L14zv5zFlD4yPCUYbpbP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936132; c=relaxed/simple;
	bh=suq092sxUq1UZDCmvSjB4EIKq0NWnio2m/MOEmqo3HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs2Yy7owjnspUZTGLQjrKLCUFB7s5+Qy+yu5Rx7mGoTdefcVVCDXgCC6Xwc8zjjYzrrr331m9pBI1ANrALAcSnw6CUK9fIIQW0YqFbzNdGps6TSmTh4nzgLZqw1ix+uYpW+urP9EUtKD0Gxq9jCeR2sf++DngID2am2Ab6iX4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PYDqAKB1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768936131; x=1800472131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=suq092sxUq1UZDCmvSjB4EIKq0NWnio2m/MOEmqo3HM=;
  b=PYDqAKB18VxL8n+qx/lznWGeA8rSNU0rjH+7CB1gUMbmhg4WcFbNEbW7
   diOCe1eTeZylh10obxDXFM480lxmERdUbhAZYBkgkYhgjIXKluT/B/Xtd
   KBD1cF0xmsz0oPoVsenzElzpbZZDy6mu6wq9a4rjCtADKcBf6sMOArBKO
   +35dCNC6nPMO6gYgAMOIPHAqNqz7hIlMjED7sR2UEsr5OPxWp9pvRa6aI
   0VabahKIwfVuCVS+qL+86fxiRM7oNCrDBa5OjWv2GYi8GZhU4aAfieGTb
   DLlT+PPbh18rFy/YRMbdy3JYIKyzU5H6rLlybtvRzXOvUCh/NcwkTQWEd
   w==;
X-CSE-ConnectionGUID: a60yO9WeQ9SH3U6yW64yQQ==
X-CSE-MsgGUID: lw/gln8lTZ27BfHt5RyJJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="57716900"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="57716900"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:08:49 -0800
X-CSE-ConnectionGUID: S/qzfxi6Tjynf60TUbjybw==
X-CSE-MsgGUID: oFTL2pAKTTqSKELIV4YUSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="206450650"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 Jan 2026 11:08:43 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viH5k-00000000POH-2pR0;
	Tue, 20 Jan 2026 19:08:40 +0000
Date: Wed, 21 Jan 2026 03:08:24 +0800
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
Message-ID: <202601210208.mg3YUkif-lkp@intel.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[intel.com:server fail,01.org:server fail,git-scm.com:server fail,dfw.mirrors.kernel.org:server fail];
	FREEMAIL_CC(0.00)[lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-8388-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 53E104BEF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mukesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on pci/next pci/for-linus arm64/for-next/core clk/clk-next soc/for-next linus/master arnd-asm-generic/master v6.19-rc6 next-20260119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-R/iommu-hyperv-rename-hyperv-iommu-c-to-hyperv-irq-c/20260120-145832
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20260120064230.3602565-2-mrathor%40linux.microsoft.com
patch subject: [PATCH v0 01/15] iommu/hyperv: rename hyperv-iommu.c to hyperv-irq.c
config: i386-randconfig-001-20260120 (https://download.01.org/0day-ci/archive/20260121/202601210208.mg3YUkif-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260121/202601210208.mg3YUkif-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601210208.mg3YUkif-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/acpi/pci_root.c:20:
>> include/linux/dmar.h:269:17: error: unknown type name '__u128'; did you mean '__u32'?
     269 |                 __u128 irte;
         |                 ^~~~~~
         |                 __u32

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IRQ_REMAP
   Depends on [n]: IOMMU_SUPPORT [=y] && X86_64 [=n] && X86_IO_APIC [=y] && PCI_MSI [=n] && ACPI [=y]
   Selected by [y]:
   - HYPERV_IOMMU [=y] && IOMMU_SUPPORT [=y] && HYPERV [=y] && X86 [=y]


vim +269 include/linux/dmar.h

2ae21010694e56 Suresh Siddha   2008-07-10  200  
2ae21010694e56 Suresh Siddha   2008-07-10  201  struct irte {
b1fe7f2cda2a00 Peter Zijlstra  2023-05-31  202  	union {
b1fe7f2cda2a00 Peter Zijlstra  2023-05-31  203  		struct {
2ae21010694e56 Suresh Siddha   2008-07-10  204  			union {
3bf17472226b00 Thomas Gleixner 2015-06-09  205  				/* Shared between remapped and posted mode*/
2ae21010694e56 Suresh Siddha   2008-07-10  206  				struct {
3bf17472226b00 Thomas Gleixner 2015-06-09  207  					__u64	present		: 1,  /*  0      */
3bf17472226b00 Thomas Gleixner 2015-06-09  208  						fpd		: 1,  /*  1      */
3bf17472226b00 Thomas Gleixner 2015-06-09  209  						__res0		: 6,  /*  2 -  6 */
3bf17472226b00 Thomas Gleixner 2015-06-09  210  						avail		: 4,  /*  8 - 11 */
3bf17472226b00 Thomas Gleixner 2015-06-09  211  						__res1		: 3,  /* 12 - 14 */
3bf17472226b00 Thomas Gleixner 2015-06-09  212  						pst		: 1,  /* 15      */
3bf17472226b00 Thomas Gleixner 2015-06-09  213  						vector		: 8,  /* 16 - 23 */
3bf17472226b00 Thomas Gleixner 2015-06-09  214  						__res2		: 40; /* 24 - 63 */
3bf17472226b00 Thomas Gleixner 2015-06-09  215  				};
3bf17472226b00 Thomas Gleixner 2015-06-09  216  
3bf17472226b00 Thomas Gleixner 2015-06-09  217  				/* Remapped mode */
3bf17472226b00 Thomas Gleixner 2015-06-09  218  				struct {
3bf17472226b00 Thomas Gleixner 2015-06-09  219  					__u64	r_present	: 1,  /*  0      */
3bf17472226b00 Thomas Gleixner 2015-06-09  220  						r_fpd		: 1,  /*  1      */
3bf17472226b00 Thomas Gleixner 2015-06-09  221  						dst_mode	: 1,  /*  2      */
3bf17472226b00 Thomas Gleixner 2015-06-09  222  						redir_hint	: 1,  /*  3      */
3bf17472226b00 Thomas Gleixner 2015-06-09  223  						trigger_mode	: 1,  /*  4      */
3bf17472226b00 Thomas Gleixner 2015-06-09  224  						dlvry_mode	: 3,  /*  5 -  7 */
3bf17472226b00 Thomas Gleixner 2015-06-09  225  						r_avail		: 4,  /*  8 - 11 */
3bf17472226b00 Thomas Gleixner 2015-06-09  226  						r_res0		: 4,  /* 12 - 15 */
3bf17472226b00 Thomas Gleixner 2015-06-09  227  						r_vector	: 8,  /* 16 - 23 */
3bf17472226b00 Thomas Gleixner 2015-06-09  228  						r_res1		: 8,  /* 24 - 31 */
3bf17472226b00 Thomas Gleixner 2015-06-09  229  						dest_id		: 32; /* 32 - 63 */
3bf17472226b00 Thomas Gleixner 2015-06-09  230  				};
3bf17472226b00 Thomas Gleixner 2015-06-09  231  
3bf17472226b00 Thomas Gleixner 2015-06-09  232  				/* Posted mode */
3bf17472226b00 Thomas Gleixner 2015-06-09  233  				struct {
3bf17472226b00 Thomas Gleixner 2015-06-09  234  					__u64	p_present	: 1,  /*  0      */
3bf17472226b00 Thomas Gleixner 2015-06-09  235  						p_fpd		: 1,  /*  1      */
3bf17472226b00 Thomas Gleixner 2015-06-09  236  						p_res0		: 6,  /*  2 -  7 */
3bf17472226b00 Thomas Gleixner 2015-06-09  237  						p_avail		: 4,  /*  8 - 11 */
3bf17472226b00 Thomas Gleixner 2015-06-09  238  						p_res1		: 2,  /* 12 - 13 */
3bf17472226b00 Thomas Gleixner 2015-06-09  239  						p_urgent	: 1,  /* 14      */
3bf17472226b00 Thomas Gleixner 2015-06-09  240  						p_pst		: 1,  /* 15      */
3bf17472226b00 Thomas Gleixner 2015-06-09  241  						p_vector	: 8,  /* 16 - 23 */
3bf17472226b00 Thomas Gleixner 2015-06-09  242  						p_res2		: 14, /* 24 - 37 */
3bf17472226b00 Thomas Gleixner 2015-06-09  243  						pda_l		: 26; /* 38 - 63 */
2ae21010694e56 Suresh Siddha   2008-07-10  244  				};
2ae21010694e56 Suresh Siddha   2008-07-10  245  				__u64 low;
2ae21010694e56 Suresh Siddha   2008-07-10  246  			};
2ae21010694e56 Suresh Siddha   2008-07-10  247  
2ae21010694e56 Suresh Siddha   2008-07-10  248  			union {
3bf17472226b00 Thomas Gleixner 2015-06-09  249  				/* Shared between remapped and posted mode*/
2ae21010694e56 Suresh Siddha   2008-07-10  250  				struct {
3bf17472226b00 Thomas Gleixner 2015-06-09  251  					__u64	sid		: 16,  /* 64 - 79  */
3bf17472226b00 Thomas Gleixner 2015-06-09  252  						sq		: 2,   /* 80 - 81  */
3bf17472226b00 Thomas Gleixner 2015-06-09  253  						svt		: 2,   /* 82 - 83  */
3bf17472226b00 Thomas Gleixner 2015-06-09  254  						__res3		: 44;  /* 84 - 127 */
3bf17472226b00 Thomas Gleixner 2015-06-09  255  				};
3bf17472226b00 Thomas Gleixner 2015-06-09  256  
3bf17472226b00 Thomas Gleixner 2015-06-09  257  				/* Posted mode*/
3bf17472226b00 Thomas Gleixner 2015-06-09  258  				struct {
3bf17472226b00 Thomas Gleixner 2015-06-09  259  					__u64	p_sid		: 16,  /* 64 - 79  */
3bf17472226b00 Thomas Gleixner 2015-06-09  260  						p_sq		: 2,   /* 80 - 81  */
3bf17472226b00 Thomas Gleixner 2015-06-09  261  						p_svt		: 2,   /* 82 - 83  */
3bf17472226b00 Thomas Gleixner 2015-06-09  262  						p_res3		: 12,  /* 84 - 95  */
3bf17472226b00 Thomas Gleixner 2015-06-09  263  						pda_h		: 32;  /* 96 - 127 */
2ae21010694e56 Suresh Siddha   2008-07-10  264  				};
2ae21010694e56 Suresh Siddha   2008-07-10  265  				__u64 high;
2ae21010694e56 Suresh Siddha   2008-07-10  266  			};
2ae21010694e56 Suresh Siddha   2008-07-10  267  		};
b1fe7f2cda2a00 Peter Zijlstra  2023-05-31  268  #ifdef CONFIG_IRQ_REMAP
b1fe7f2cda2a00 Peter Zijlstra  2023-05-31 @269  		__u128 irte;
b1fe7f2cda2a00 Peter Zijlstra  2023-05-31  270  #endif
b1fe7f2cda2a00 Peter Zijlstra  2023-05-31  271  	};
b1fe7f2cda2a00 Peter Zijlstra  2023-05-31  272  };
423f085952fd72 Thomas Gleixner 2010-10-10  273  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

