Return-Path: <linux-hyperv+bounces-6832-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83303B53C1A
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 21:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA66D188B46E
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76C62512EE;
	Thu, 11 Sep 2025 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRjvEgmp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3CF29405;
	Thu, 11 Sep 2025 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617546; cv=none; b=E8IkqzDqONUDOdCo+M6vMZWgt/yQx13sKiq1vLEKFQyKY2eqNwxkRfdmE07slMwlylNd5D404aPKslGbeq5rycT9Wn3GhRzytO54IVThtg9dT36SNXBYMhe/rqhLDKXqjbMmtzKmM5zy/McxF3Iz66Lt2Fg7ii56FFrFKui88DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617546; c=relaxed/simple;
	bh=B4sEFew1BWr5j/ulqzJXHYqIzI7kURE2ClIPq3QYhO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da1LunHJkWPiAvPcQcKQ48V0NDv9bRlpAH55D8q0uDFI/4vXjAyDIYdFXng4P1tXFB6fobrjttLszAf3ZtNazfYyvKRhz8JEvVktsfAYshVd6XGZhlOffaTWFp51Mn6ncmSsoHM1r1bIxqQzuuSti5KmGRURjUamjFW7dVznHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRjvEgmp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757617545; x=1789153545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B4sEFew1BWr5j/ulqzJXHYqIzI7kURE2ClIPq3QYhO8=;
  b=iRjvEgmp45szTjdMkSRD/NdoTl6QejHR1GatbLB9z09Vm3Bhfl72MR+V
   o+zcRfmqgGPrZjjfurcjNIMS/78W9WLb3G5AUY3yCA91R33g4qjh6Gb2F
   hqEHLtP5Wsk8fDkvia+W7TXMG7F6qvpEMp0zAiEq7u6tXSNt2KTAlWnsl
   8V0DCqtnfsmNrwlvqkRXIsS+9DDwR5nYJ/Gv4CKlWz0XfpyVoz2gx9TGT
   ELyf6Gv+GukcSpJdAxJ0uaSdFDt39AlI8zME5TG7hMHQ+7ef1oeZt1JAk
   0UM53pYjH9Xrh9TztbSBzJtv8nA2oNXqfjOnZRmVaU9TtOgIv/sqN3DJN
   w==;
X-CSE-ConnectionGUID: ZBOWhHz6Sp26sBy9OSETTA==
X-CSE-MsgGUID: uoTVkio0QhmvDbpfR/CPgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="71062914"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="71062914"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 12:05:44 -0700
X-CSE-ConnectionGUID: JW7mIxtHR5q+omIYp7vSdQ==
X-CSE-MsgGUID: aX4oCAlxQEeZge+n5CMjfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="174560150"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 12:05:41 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwmby-0000aD-0y;
	Thu, 11 Sep 2025 19:05:38 +0000
Date: Fri, 12 Sep 2025 03:05:26 +0800
From: kernel test robot <lkp@intel.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com, anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	Jinank Jain <jinankjain@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: Re: [PATCH v2 4/5] mshv: Allocate vp state page for
 HVCALL_MAP_VP_STATE_PAGE on L1VH
Message-ID: <202509120214.YMomVkdP-lkp@intel.com>
References: <1757546089-2002-5-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757546089-2002-5-git-send-email-nunodasneves@linux.microsoft.com>

Hi Nuno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.17-rc5 next-20250911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Das-Neves/mshv-Only-map-vp-vp_stats_pages-if-on-root-scheduler/20250911-071732
base:   linus/master
patch link:    https://lore.kernel.org/r/1757546089-2002-5-git-send-email-nunodasneves%40linux.microsoft.com
patch subject: [PATCH v2 4/5] mshv: Allocate vp state page for HVCALL_MAP_VP_STATE_PAGE on L1VH
config: x86_64-randconfig-072-20250911 (https://download.01.org/0day-ci/archive/20250912/202509120214.YMomVkdP-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250912/202509120214.YMomVkdP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509120214.YMomVkdP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hv/mshv_root_main.c:966:7: warning: variable 'vp' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     966 |                 if (ret)
         |                     ^~~
   drivers/hv/mshv_root_main.c:1030:11: note: uninitialized use occurs here
    1030 |                                vp->vp_intercept_msg_page, input_vtl_zero);
         |                                ^~
   drivers/hv/mshv_root_main.c:966:3: note: remove the 'if' if its condition is always false
     966 |                 if (ret)
         |                 ^~~~~~~~
     967 |                         goto unmap_ghcb_page;
         |                         ~~~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:955:7: warning: variable 'vp' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     955 |                 if (ret)
         |                     ^~~
   drivers/hv/mshv_root_main.c:1030:11: note: uninitialized use occurs here
    1030 |                                vp->vp_intercept_msg_page, input_vtl_zero);
         |                                ^~
   drivers/hv/mshv_root_main.c:955:3: note: remove the 'if' if its condition is always false
     955 |                 if (ret)
         |                 ^~~~~~~~
     956 |                         goto unmap_register_page;
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:946:7: warning: variable 'vp' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     946 |                 if (ret)
         |                     ^~~
   drivers/hv/mshv_root_main.c:1030:11: note: uninitialized use occurs here
    1030 |                                vp->vp_intercept_msg_page, input_vtl_zero);
         |                                ^~
   drivers/hv/mshv_root_main.c:946:3: note: remove the 'if' if its condition is always false
     946 |                 if (ret)
         |                 ^~~~~~~~
     947 |                         goto unmap_intercept_message_page;
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:917:20: note: initialize the variable 'vp' to silence this warning
     917 |         struct mshv_vp *vp;
         |                           ^
         |                            = NULL
   drivers/hv/mshv_root_main.c:41:20: warning: unused function 'hv_parent_partition' [-Wunused-function]
      41 | static inline bool hv_parent_partition(void)
         |                    ^~~~~~~~~~~~~~~~~~~
   4 warnings generated.


vim +966 drivers/hv/mshv_root_main.c

621191d709b1488 Nuno Das Neves 2025-03-14   911  
621191d709b1488 Nuno Das Neves 2025-03-14   912  static long
621191d709b1488 Nuno Das Neves 2025-03-14   913  mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
621191d709b1488 Nuno Das Neves 2025-03-14   914  			       void __user *arg)
621191d709b1488 Nuno Das Neves 2025-03-14   915  {
621191d709b1488 Nuno Das Neves 2025-03-14   916  	struct mshv_create_vp args;
621191d709b1488 Nuno Das Neves 2025-03-14   917  	struct mshv_vp *vp;
621191d709b1488 Nuno Das Neves 2025-03-14   918  	struct page *intercept_message_page, *register_page, *ghcb_page;
621191d709b1488 Nuno Das Neves 2025-03-14   919  	void *stats_pages[2];
621191d709b1488 Nuno Das Neves 2025-03-14   920  	long ret;
621191d709b1488 Nuno Das Neves 2025-03-14   921  
621191d709b1488 Nuno Das Neves 2025-03-14   922  	if (copy_from_user(&args, arg, sizeof(args)))
621191d709b1488 Nuno Das Neves 2025-03-14   923  		return -EFAULT;
621191d709b1488 Nuno Das Neves 2025-03-14   924  
621191d709b1488 Nuno Das Neves 2025-03-14   925  	if (args.vp_index >= MSHV_MAX_VPS)
621191d709b1488 Nuno Das Neves 2025-03-14   926  		return -EINVAL;
621191d709b1488 Nuno Das Neves 2025-03-14   927  
621191d709b1488 Nuno Das Neves 2025-03-14   928  	if (partition->pt_vp_array[args.vp_index])
621191d709b1488 Nuno Das Neves 2025-03-14   929  		return -EEXIST;
621191d709b1488 Nuno Das Neves 2025-03-14   930  
621191d709b1488 Nuno Das Neves 2025-03-14   931  	ret = hv_call_create_vp(NUMA_NO_NODE, partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves 2025-03-14   932  				0 /* Only valid for root partition VPs */);
621191d709b1488 Nuno Das Neves 2025-03-14   933  	if (ret)
621191d709b1488 Nuno Das Neves 2025-03-14   934  		return ret;
621191d709b1488 Nuno Das Neves 2025-03-14   935  
debba2f23756254 Jinank Jain    2025-09-10   936  	ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves 2025-03-14   937  				   HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
debba2f23756254 Jinank Jain    2025-09-10   938  				   input_vtl_zero, &intercept_message_page);
621191d709b1488 Nuno Das Neves 2025-03-14   939  	if (ret)
621191d709b1488 Nuno Das Neves 2025-03-14   940  		goto destroy_vp;
621191d709b1488 Nuno Das Neves 2025-03-14   941  
621191d709b1488 Nuno Das Neves 2025-03-14   942  	if (!mshv_partition_encrypted(partition)) {
debba2f23756254 Jinank Jain    2025-09-10   943  		ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves 2025-03-14   944  					   HV_VP_STATE_PAGE_REGISTERS,
debba2f23756254 Jinank Jain    2025-09-10   945  					   input_vtl_zero, &register_page);
621191d709b1488 Nuno Das Neves 2025-03-14   946  		if (ret)
621191d709b1488 Nuno Das Neves 2025-03-14   947  			goto unmap_intercept_message_page;
621191d709b1488 Nuno Das Neves 2025-03-14   948  	}
621191d709b1488 Nuno Das Neves 2025-03-14   949  
621191d709b1488 Nuno Das Neves 2025-03-14   950  	if (mshv_partition_encrypted(partition) &&
621191d709b1488 Nuno Das Neves 2025-03-14   951  	    is_ghcb_mapping_available()) {
debba2f23756254 Jinank Jain    2025-09-10   952  		ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves 2025-03-14   953  					   HV_VP_STATE_PAGE_GHCB,
debba2f23756254 Jinank Jain    2025-09-10   954  					   input_vtl_normal, &ghcb_page);
621191d709b1488 Nuno Das Neves 2025-03-14   955  		if (ret)
621191d709b1488 Nuno Das Neves 2025-03-14   956  			goto unmap_register_page;
621191d709b1488 Nuno Das Neves 2025-03-14   957  	}
621191d709b1488 Nuno Das Neves 2025-03-14   958  
1af6cc3b10421f1 Nuno Das Neves 2025-09-10   959  	/*
1af6cc3b10421f1 Nuno Das Neves 2025-09-10   960  	 * This mapping of the stats page is for detecting if dispatch thread
1af6cc3b10421f1 Nuno Das Neves 2025-09-10   961  	 * is blocked - only relevant for root scheduler
1af6cc3b10421f1 Nuno Das Neves 2025-09-10   962  	 */
1af6cc3b10421f1 Nuno Das Neves 2025-09-10   963  	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT) {
621191d709b1488 Nuno Das Neves 2025-03-14   964  		ret = mshv_vp_stats_map(partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves 2025-03-14   965  					stats_pages);
621191d709b1488 Nuno Das Neves 2025-03-14  @966  		if (ret)
621191d709b1488 Nuno Das Neves 2025-03-14   967  			goto unmap_ghcb_page;
621191d709b1488 Nuno Das Neves 2025-03-14   968  	}
621191d709b1488 Nuno Das Neves 2025-03-14   969  
621191d709b1488 Nuno Das Neves 2025-03-14   970  	vp = kzalloc(sizeof(*vp), GFP_KERNEL);
621191d709b1488 Nuno Das Neves 2025-03-14   971  	if (!vp)
621191d709b1488 Nuno Das Neves 2025-03-14   972  		goto unmap_stats_pages;
621191d709b1488 Nuno Das Neves 2025-03-14   973  
621191d709b1488 Nuno Das Neves 2025-03-14   974  	vp->vp_partition = mshv_partition_get(partition);
621191d709b1488 Nuno Das Neves 2025-03-14   975  	if (!vp->vp_partition) {
621191d709b1488 Nuno Das Neves 2025-03-14   976  		ret = -EBADF;
621191d709b1488 Nuno Das Neves 2025-03-14   977  		goto free_vp;
621191d709b1488 Nuno Das Neves 2025-03-14   978  	}
621191d709b1488 Nuno Das Neves 2025-03-14   979  
621191d709b1488 Nuno Das Neves 2025-03-14   980  	mutex_init(&vp->vp_mutex);
621191d709b1488 Nuno Das Neves 2025-03-14   981  	init_waitqueue_head(&vp->run.vp_suspend_queue);
621191d709b1488 Nuno Das Neves 2025-03-14   982  	atomic64_set(&vp->run.vp_signaled_count, 0);
621191d709b1488 Nuno Das Neves 2025-03-14   983  
621191d709b1488 Nuno Das Neves 2025-03-14   984  	vp->vp_index = args.vp_index;
621191d709b1488 Nuno Das Neves 2025-03-14   985  	vp->vp_intercept_msg_page = page_to_virt(intercept_message_page);
621191d709b1488 Nuno Das Neves 2025-03-14   986  	if (!mshv_partition_encrypted(partition))
621191d709b1488 Nuno Das Neves 2025-03-14   987  		vp->vp_register_page = page_to_virt(register_page);
621191d709b1488 Nuno Das Neves 2025-03-14   988  
621191d709b1488 Nuno Das Neves 2025-03-14   989  	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
621191d709b1488 Nuno Das Neves 2025-03-14   990  		vp->vp_ghcb_page = page_to_virt(ghcb_page);
621191d709b1488 Nuno Das Neves 2025-03-14   991  
1af6cc3b10421f1 Nuno Das Neves 2025-09-10   992  	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
621191d709b1488 Nuno Das Neves 2025-03-14   993  		memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
621191d709b1488 Nuno Das Neves 2025-03-14   994  
621191d709b1488 Nuno Das Neves 2025-03-14   995  	/*
621191d709b1488 Nuno Das Neves 2025-03-14   996  	 * Keep anon_inode_getfd last: it installs fd in the file struct and
621191d709b1488 Nuno Das Neves 2025-03-14   997  	 * thus makes the state accessible in user space.
621191d709b1488 Nuno Das Neves 2025-03-14   998  	 */
621191d709b1488 Nuno Das Neves 2025-03-14   999  	ret = anon_inode_getfd("mshv_vp", &mshv_vp_fops, vp,
621191d709b1488 Nuno Das Neves 2025-03-14  1000  			       O_RDWR | O_CLOEXEC);
621191d709b1488 Nuno Das Neves 2025-03-14  1001  	if (ret < 0)
621191d709b1488 Nuno Das Neves 2025-03-14  1002  		goto put_partition;
621191d709b1488 Nuno Das Neves 2025-03-14  1003  
621191d709b1488 Nuno Das Neves 2025-03-14  1004  	/* already exclusive with the partition mutex for all ioctls */
621191d709b1488 Nuno Das Neves 2025-03-14  1005  	partition->pt_vp_count++;
621191d709b1488 Nuno Das Neves 2025-03-14  1006  	partition->pt_vp_array[args.vp_index] = vp;
621191d709b1488 Nuno Das Neves 2025-03-14  1007  
621191d709b1488 Nuno Das Neves 2025-03-14  1008  	return ret;
621191d709b1488 Nuno Das Neves 2025-03-14  1009  
621191d709b1488 Nuno Das Neves 2025-03-14  1010  put_partition:
621191d709b1488 Nuno Das Neves 2025-03-14  1011  	mshv_partition_put(partition);
621191d709b1488 Nuno Das Neves 2025-03-14  1012  free_vp:
621191d709b1488 Nuno Das Neves 2025-03-14  1013  	kfree(vp);
621191d709b1488 Nuno Das Neves 2025-03-14  1014  unmap_stats_pages:
1af6cc3b10421f1 Nuno Das Neves 2025-09-10  1015  	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
621191d709b1488 Nuno Das Neves 2025-03-14  1016  		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
621191d709b1488 Nuno Das Neves 2025-03-14  1017  unmap_ghcb_page:
debba2f23756254 Jinank Jain    2025-09-10  1018  	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
debba2f23756254 Jinank Jain    2025-09-10  1019  		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
debba2f23756254 Jinank Jain    2025-09-10  1020  				       HV_VP_STATE_PAGE_GHCB, vp->vp_ghcb_page,
621191d709b1488 Nuno Das Neves 2025-03-14  1021  				       input_vtl_normal);
621191d709b1488 Nuno Das Neves 2025-03-14  1022  unmap_register_page:
debba2f23756254 Jinank Jain    2025-09-10  1023  	if (!mshv_partition_encrypted(partition))
debba2f23756254 Jinank Jain    2025-09-10  1024  		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves 2025-03-14  1025  				       HV_VP_STATE_PAGE_REGISTERS,
debba2f23756254 Jinank Jain    2025-09-10  1026  				       vp->vp_register_page, input_vtl_zero);
621191d709b1488 Nuno Das Neves 2025-03-14  1027  unmap_intercept_message_page:
debba2f23756254 Jinank Jain    2025-09-10  1028  	hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves 2025-03-14  1029  			       HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
debba2f23756254 Jinank Jain    2025-09-10  1030  			       vp->vp_intercept_msg_page, input_vtl_zero);
621191d709b1488 Nuno Das Neves 2025-03-14  1031  destroy_vp:
621191d709b1488 Nuno Das Neves 2025-03-14  1032  	hv_call_delete_vp(partition->pt_id, args.vp_index);
621191d709b1488 Nuno Das Neves 2025-03-14  1033  	return ret;
621191d709b1488 Nuno Das Neves 2025-03-14  1034  }
621191d709b1488 Nuno Das Neves 2025-03-14  1035  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

