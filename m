Return-Path: <linux-hyperv+bounces-8885-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3E5NIq1slWkKRAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8885-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 08:39:25 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFB9153BAB
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 08:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EF653008C0F
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 07:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFE3289811;
	Wed, 18 Feb 2026 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TI7W0zgO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776E738D;
	Wed, 18 Feb 2026 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771400363; cv=none; b=gPrN0mWGdRrjf1Jvgd9Jk3HJLKmHesPHm9ioQCWFarUFV7ORcWzn02TJduNY//xn/kKEbSOmpi1uP3Ofh19jPOEVMCo2gr0O2Jpc0zyoubpVn1ZQcqx7D3J+xuTXoxE4sxSdF827yAALcd8BcWXfdm07r0PkAibq9CGuQvqelIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771400363; c=relaxed/simple;
	bh=oe94NrlhNaLUYosfRZJjfYGHbavdfS6Qsp4FmmEJTYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7xribgq0w+6eMQQQSD6f3b+Fh7efxGHIRsQCKVYKMQqJzJyOP3WsDb9Amr9EyiJW13pETQPqsmE3NhBEwjNkOC01U52KzVqb4yCBn42mg5u84AOE5TJhP2Ia2T/qXnF7DSKuBAP7Ul+OEs33NbarXP4LTJGlwH02mtwSsP63U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TI7W0zgO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771400362; x=1802936362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oe94NrlhNaLUYosfRZJjfYGHbavdfS6Qsp4FmmEJTYY=;
  b=TI7W0zgOt+8TmP9LoOg3Qs3geSbQcNqXtLq1mW3hnIh//aEmTQ+2b+k8
   /4aeSlLslVOjzSLhStuo+mosBu6gv3zRN3v6ASbrlsgGRpmOi8lbZ7WJi
   +2e3B58GCVs2Qph5jtUqV6en1fhGa5dl/EWKV3gZa1EdSt82S93JGiiHy
   LlDE9LMDCU6dHMWPoE8PpLt+noTmXceSj/o21IPSTl0MJbLT7HNIKTyMU
   SjW7qDnqbIyFmB2YMZup+N/k/bPfxhcBT8JNhuwdOwDVIDAVyTNlQ4cgn
   BeGelZ/PbLc6jQPV4xNtTTytOJconG5/AWzfpL9lYh/c2Hh5JjP0ixLRC
   Q==;
X-CSE-ConnectionGUID: MatkTcxFTuWcF07HgbNM/Q==
X-CSE-MsgGUID: ONCIBo1KSSyHPVAbktKz1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="76311990"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="76311990"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 23:39:21 -0800
X-CSE-ConnectionGUID: DI9xhy3ETuSAEaR+BvIQKg==
X-CSE-MsgGUID: Naa0cveETci5cTNobP+s4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="251810720"
Received: from igk-lkp-server01.igk.intel.com (HELO e5404a91d123) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 17 Feb 2026 23:39:18 -0800
Received: from kbuild by e5404a91d123 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsc9T-000000003XR-1SUo;
	Wed, 18 Feb 2026 07:39:15 +0000
Date: Wed, 18 Feb 2026 08:38:28 +0100
From: kernel test robot <lkp@intel.com>
To: Mukesh R <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com
Subject: Re: [PATCH v2] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
Message-ID: <202602180851.Pi2PY5LX-lkp@intel.com>
References: <20260217231158.1184736-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231158.1184736-1-mrathor@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8885-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: 0DFB9153BAB
X-Rspamd-Action: no action

Hi Mukesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on linus/master v6.19 next-20260217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-R/x86-hyperv-Reserve-3-interrupt-vectors-used-exclusively-by-mshv/20260218-071406
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20260217231158.1184736-1-mrathor%40linux.microsoft.com
patch subject: [PATCH v2] x86/hyperv: Reserve 3 interrupt vectors used exclusively by mshv
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260218/202602180851.Pi2PY5LX-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260218/202602180851.Pi2PY5LX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602180851.Pi2PY5LX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/mshyperv.c:485:13: warning: 'hv_reserve_irq_vectors' defined but not used [-Wunused-function]
     485 | static void hv_reserve_irq_vectors(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~


vim +/hv_reserve_irq_vectors +485 arch/x86/kernel/cpu/mshyperv.c

   480	
   481	/*
   482	 * Reserve vectors hard coded in the hypervisor. If used outside, the hypervisor
   483	 * will either crash or hang or attempt to break into debugger.
   484	 */
 > 485	static void hv_reserve_irq_vectors(void)
   486	{
   487		#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
   488		#define HYPERV_DBG_ASSERT_VECTOR	0x2C
   489		#define HYPERV_DBG_SERVICE_VECTOR	0x2D
   490	
   491		if (cpu_feature_enabled(X86_FEATURE_FRED))
   492			return;
   493	
   494		if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
   495		    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
   496		    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
   497			BUG();
   498	
   499		pr_info("Hyper-V:reserve vectors: %d %d %d\n", HYPERV_DBG_ASSERT_VECTOR,
   500			HYPERV_DBG_SERVICE_VECTOR, HYPERV_DBG_FASTFAIL_VECTOR);
   501	}
   502	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

