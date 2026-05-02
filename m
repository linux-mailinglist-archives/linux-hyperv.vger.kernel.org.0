Return-Path: <linux-hyperv+bounces-10574-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ9DAW349WnQQwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10574-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 15:13:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB8A4B219A
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 15:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF3233004069
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5EB35F61E;
	Sat,  2 May 2026 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqA5ECgm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C12C11EE;
	Sat,  2 May 2026 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777727591; cv=none; b=NgluTXeOnDJGTsJouKLOdgH4UV3WQc1fl08NsAq7I8VJ2Nv1xK2sleDDq1+qppqFv4pd4az2da4KwyCRTxECK1DF9GPhLcb5OA9156qqiJTa6XdsnhvqecXr7CKtBgw0/87h2cvsOBIMgdPCve/8CswBIrTCJSnNybNvR+oj474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777727591; c=relaxed/simple;
	bh=OEYzZwVgmxjww23jVhcXnWxvryJn1l+RP9EXg/6jilI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTHjERAfeLLIpIx5tuxzHTCzvHeaWPWXgXKCSVZ5H9GJaXMpe+Hg7Eg4G1m+w44v5pe2PcQq7Or/f5k273r11up4sJzxMPtHHJD5kYtTMZMVa8Y6+2euploS00SL+JlQ9mVR+SxmvrYSLAOro1uaWhk6WK8nVIiM2zjAkGVX9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqA5ECgm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777727590; x=1809263590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OEYzZwVgmxjww23jVhcXnWxvryJn1l+RP9EXg/6jilI=;
  b=nqA5ECgm6KZUzZdF35zBa0Dva6pPpQNJiSPGIhnFWL6cm1RehxxuT07n
   MEI6luukt/kuCV214c/IkWpr8hx/lBFSADMxlAyLjcnDvZfIZe4mUsL6M
   2ooMyj2LIs5SkXPQpT05O+XZFmW0MOr8jprmXjE5BZgDX27ypP7zayD7H
   vNKEx96Ev1mtpUxsXkJSVU3RKIjmN4FARzeoJd8pYO+4vqxMOxgjRXkep
   WjJyNXx13zII2AozzE1OZNWrbakJKoQNUw9yVl2Yy1SsgrzxSs7lk+kbT
   zMCNazM29SyZCTtZIwhkfCb/zSw9pJ8cIllpG9lzTi7piuIN+Snx08YPA
   Q==;
X-CSE-ConnectionGUID: NA5HI9S0RLi7W08whneLWQ==
X-CSE-MsgGUID: zXKoOVwiR2+DSoKvvNhHAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="78690505"
X-IronPort-AV: E=Sophos;i="6.23,211,1770624000"; 
   d="scan'208";a="78690505"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 06:13:09 -0700
X-CSE-ConnectionGUID: 7fsP/q4VRWqc2gUNP50meA==
X-CSE-MsgGUID: YbZWX4F2Q9aIApSsvKH2tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,211,1770624000"; 
   d="scan'208";a="236876449"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 02 May 2026 06:13:07 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJA9Z-000000001Pf-0W9u;
	Sat, 02 May 2026 13:13:05 +0000
Date: Sat, 2 May 2026 21:12:50 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com
Cc: oe-kbuild-all@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Add dedicated ioctl for GVA to GPA translation
Message-ID: <202605022145.mMqA1AEU-lkp@intel.com>
References: <177741648871.626779.11067281081219290277.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177741648871.626779.11067281081219290277.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Rspamd-Queue-Id: 0BB8A4B219A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-10574-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url]

Hi Stanislav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.1-rc1 next-20260430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Kinsburskii/mshv-Add-dedicated-ioctl-for-GVA-to-GPA-translation/20260429-094326
base:   linus/master
patch link:    https://lore.kernel.org/r/177741648871.626779.11067281081219290277.stgit%40skinsburskii-cloud-desktop.internal.cloudapp.net
patch subject: [PATCH] mshv: Add dedicated ioctl for GVA to GPA translation
config: x86_64-randconfig-123-20260430 (https://download.01.org/0day-ci/archive/20260502/202605022145.mMqA1AEU-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260502/202605022145.mMqA1AEU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605022145.mMqA1AEU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hv/mshv_root_main.c:958:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned int enum hv_translate_gva_result_code *[addressable] result @@
   drivers/hv/mshv_root_main.c:958:30: sparse:     expected void [noderef] __user *to
   drivers/hv/mshv_root_main.c:958:30: sparse:     got unsigned int enum hv_translate_gva_result_code *[addressable] result
>> drivers/hv/mshv_root_main.c:961:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long [usertype] *[addressable] gpa @@
   drivers/hv/mshv_root_main.c:961:30: sparse:     expected void [noderef] __user *to
   drivers/hv/mshv_root_main.c:961:30: sparse:     got unsigned long long [usertype] *[addressable] gpa

vim +958 drivers/hv/mshv_root_main.c

   913	
   914	static long
   915	mshv_vp_ioctl_translate_gva(struct mshv_vp *vp, void __user *user_args)
   916	{
   917		struct mshv_partition *partition = vp->vp_partition;
   918		struct mshv_translate_gva args;
   919		struct hv_translate_gva_result_ex result;
   920		u64 gfn, gpa;
   921		int ret;
   922	
   923		if (copy_from_user(&args, user_args, sizeof(args)))
   924			return -EFAULT;
   925	
   926		do {
   927			ret = hv_call_translate_virtual_address_ex(vp->vp_index,
   928								   partition->pt_id,
   929								   args.flags, args.gva,
   930								   &gfn, &result);
   931			if (ret)
   932				return ret;
   933	
   934			if (mshv_gpa_fault_retryable(result.result_code)) {
   935				struct mshv_mem_region *region;
   936				bool faulted;
   937	
   938				region = mshv_partition_region_by_gfn_get(partition,
   939									  gfn);
   940				if (!region)
   941					return -EFAULT;
   942	
   943				faulted = false;
   944				if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
   945					faulted = mshv_region_handle_gfn_fault(region,
   946									       gfn);
   947				mshv_region_put(region);
   948	
   949				if (!faulted)
   950					return -EFAULT;
   951	
   952				cond_resched();
   953			}
   954		} while (mshv_gpa_fault_retryable(result.result_code));
   955	
   956		gpa = (gfn << PAGE_SHIFT) | (args.gva & ~PAGE_MASK);
   957	
 > 958	        if (copy_to_user(args.result, &result, sizeof(*args.result)))
   959	                return -EFAULT;
   960	
 > 961		if (copy_to_user(args.gpa, &gpa, sizeof(*args.gpa)))
   962			return -EFAULT;
   963	
   964		return 0;
   965	}
   966	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

