Return-Path: <linux-hyperv+bounces-9019-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKTaDrgToWnKqAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9019-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 04:47:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2071B260F
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 04:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C8EB301E5CE
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 03:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87773358CB;
	Fri, 27 Feb 2026 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEoJDqEf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A02DA763;
	Fri, 27 Feb 2026 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772164016; cv=none; b=gEUAe2ua6fztNQeoAxGVxMbTn1VSd5Vhu05gDGT/0Whex3vdS1beqewWzRG00Fa5+p2aeHzfleL/QG8vmgRk8QKRgzzHFgf3OE4fgthKkyUlbW6rSeToxKGSOTa6kuVqmz8NhkDYow9IhRxxSH1JmhPZfBpOC3gK5iiE6Adl3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772164016; c=relaxed/simple;
	bh=wcUT+cFUznrslqVlUXBbtdjKxuc0NfM5XLdeH09DJqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p78iA6RtE6f7zHULo1xOtBE2h2FR9TIBM9n0unzawTlKyfGncKrZK3XOZ1O1fVqiohWzj30v2HEg7Z2wmv7f0Ogaj1UMwdVTxnselSKNxk3eu5isNM2OiALWCHbnLjy8tml4GQ4WJpaNaAUEdKl0Cty22QE3br+nt9wxtx0trIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEoJDqEf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772164014; x=1803700014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wcUT+cFUznrslqVlUXBbtdjKxuc0NfM5XLdeH09DJqg=;
  b=ZEoJDqEfDWp7ukngiHd2IEJoRhKh40xwhrjCmN0fTdry8XfkjKbavgoV
   G6GH4bZnkSWOfRpvIgjtjxXr1Sob6i40LvbvY9NLXeljPUrWI7uLfgqJz
   FUtwt48TgEQG9ZkTxPM8sJwKUmYpLaeTfJBUe1mCNr4wUBXYsKjqX6U4r
   qFn4D9peCdAwJGg4Zo0WaGMEUU/E5niZhTGVwsZkGUqQKLmgU9iDYeWYu
   0K63qc74NIjwRkQfQH8kio37LUaxhP9RQdjF+n3vRYkgtnxmk/yyEF5NU
   xGhmny9YJpohDjBup+OQwREF2yKtLwpJIfGoxSnZ/wJMeIEDtvlJyi/pm
   A==;
X-CSE-ConnectionGUID: yIESsudjRzOkSX7aeTRviA==
X-CSE-MsgGUID: 7I9PdaPRRAe3Znha9mzC4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="83950449"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="83950449"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 19:46:53 -0800
X-CSE-ConnectionGUID: 3Zm2WNi7Qo2jvAqvv56RHQ==
X-CSE-MsgGUID: 1xwTpUFySSuY8zL+53aHDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="215902058"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 26 Feb 2026 19:46:51 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvooR-00000000AAh-2a0o;
	Fri, 27 Feb 2026 03:46:47 +0000
Date: Fri, 27 Feb 2026 11:45:59 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Introduce tracing support
Message-ID: <202602271123.ilt6wmeA-lkp@intel.com>
References: <177213348504.92223.5330421592610811972.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177213348504.92223.5330421592610811972.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-9019-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: DB2071B260F
X-Rspamd-Action: no action

Hi Stanislav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.0-rc1 next-20260226]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Kinsburskii/mshv-Introduce-tracing-support/20260227-031942
base:   linus/master
patch link:    https://lore.kernel.org/r/177213348504.92223.5330421592610811972.stgit%40skinsburskii-cloud-desktop.internal.cloudapp.net
patch subject: [PATCH] mshv: Introduce tracing support
config: x86_64-randconfig-072-20260227 (https://download.01.org/0day-ci/archive/20260227/202602271123.ilt6wmeA-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602271123.ilt6wmeA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602271123.ilt6wmeA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hv/mshv_root_main.c:1106:6: warning: variable 'vp' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1106 |         if (ret)
         |             ^~~
   drivers/hv/mshv_root_main.c:1177:41: note: uninitialized use occurs here
    1177 |         trace_mshv_create_vp(partition->pt_id, vp->vp_index, ret);
         |                                                ^~
   drivers/hv/mshv_root_main.c:1106:2: note: remove the 'if' if its condition is always false
    1106 |         if (ret)
         |         ^~~~~~~~
    1107 |                 goto unmap_ghcb_page;
         |                 ~~~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:1100:7: warning: variable 'vp' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1100 |                 if (ret)
         |                     ^~~
   drivers/hv/mshv_root_main.c:1177:41: note: uninitialized use occurs here
    1177 |         trace_mshv_create_vp(partition->pt_id, vp->vp_index, ret);
         |                                                ^~
   drivers/hv/mshv_root_main.c:1100:3: note: remove the 'if' if its condition is always false
    1100 |                 if (ret)
         |                 ^~~~~~~~
    1101 |                         goto unmap_register_page;
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:1091:7: warning: variable 'vp' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1091 |                 if (ret)
         |                     ^~~
   drivers/hv/mshv_root_main.c:1177:41: note: uninitialized use occurs here
    1177 |         trace_mshv_create_vp(partition->pt_id, vp->vp_index, ret);
         |                                                ^~
   drivers/hv/mshv_root_main.c:1091:3: note: remove the 'if' if its condition is always false
    1091 |                 if (ret)
         |                 ^~~~~~~~
    1092 |                         goto unmap_intercept_message_page;
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:1084:6: warning: variable 'vp' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1084 |         if (ret)
         |             ^~~
   drivers/hv/mshv_root_main.c:1177:41: note: uninitialized use occurs here
    1177 |         trace_mshv_create_vp(partition->pt_id, vp->vp_index, ret);
         |                                                ^~
   drivers/hv/mshv_root_main.c:1084:2: note: remove the 'if' if its condition is always false
    1084 |         if (ret)
         |         ^~~~~~~~
    1085 |                 goto destroy_vp;
         |                 ~~~~~~~~~~~~~~~
   drivers/hv/mshv_root_main.c:1062:20: note: initialize the variable 'vp' to silence this warning
    1062 |         struct mshv_vp *vp;
         |                           ^
         |                            = NULL
   4 warnings generated.


vim +1106 drivers/hv/mshv_root_main.c

621191d709b1488 Nuno Das Neves        2025-03-14  1056  
621191d709b1488 Nuno Das Neves        2025-03-14  1057  static long
621191d709b1488 Nuno Das Neves        2025-03-14  1058  mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
621191d709b1488 Nuno Das Neves        2025-03-14  1059  			       void __user *arg)
621191d709b1488 Nuno Das Neves        2025-03-14  1060  {
621191d709b1488 Nuno Das Neves        2025-03-14  1061  	struct mshv_create_vp args;
621191d709b1488 Nuno Das Neves        2025-03-14  1062  	struct mshv_vp *vp;
19c515c27cee3bb Jinank Jain           2025-10-10  1063  	struct page *intercept_msg_page, *register_page, *ghcb_page;
2de4516aa8f7269 Stanislav Kinsburskii 2026-01-28  1064  	struct hv_stats_page *stats_pages[2];
621191d709b1488 Nuno Das Neves        2025-03-14  1065  	long ret;
621191d709b1488 Nuno Das Neves        2025-03-14  1066  
621191d709b1488 Nuno Das Neves        2025-03-14  1067  	if (copy_from_user(&args, arg, sizeof(args)))
621191d709b1488 Nuno Das Neves        2025-03-14  1068  		return -EFAULT;
621191d709b1488 Nuno Das Neves        2025-03-14  1069  
621191d709b1488 Nuno Das Neves        2025-03-14  1070  	if (args.vp_index >= MSHV_MAX_VPS)
621191d709b1488 Nuno Das Neves        2025-03-14  1071  		return -EINVAL;
621191d709b1488 Nuno Das Neves        2025-03-14  1072  
621191d709b1488 Nuno Das Neves        2025-03-14  1073  	if (partition->pt_vp_array[args.vp_index])
621191d709b1488 Nuno Das Neves        2025-03-14  1074  		return -EEXIST;
621191d709b1488 Nuno Das Neves        2025-03-14  1075  
621191d709b1488 Nuno Das Neves        2025-03-14  1076  	ret = hv_call_create_vp(NUMA_NO_NODE, partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves        2025-03-14  1077  				0 /* Only valid for root partition VPs */);
621191d709b1488 Nuno Das Neves        2025-03-14  1078  	if (ret)
621191d709b1488 Nuno Das Neves        2025-03-14  1079  		return ret;
621191d709b1488 Nuno Das Neves        2025-03-14  1080  
19c515c27cee3bb Jinank Jain           2025-10-10  1081  	ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves        2025-03-14  1082  				   HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
19c515c27cee3bb Jinank Jain           2025-10-10  1083  				   input_vtl_zero, &intercept_msg_page);
621191d709b1488 Nuno Das Neves        2025-03-14  1084  	if (ret)
621191d709b1488 Nuno Das Neves        2025-03-14  1085  		goto destroy_vp;
621191d709b1488 Nuno Das Neves        2025-03-14  1086  
621191d709b1488 Nuno Das Neves        2025-03-14  1087  	if (!mshv_partition_encrypted(partition)) {
19c515c27cee3bb Jinank Jain           2025-10-10  1088  		ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves        2025-03-14  1089  					   HV_VP_STATE_PAGE_REGISTERS,
19c515c27cee3bb Jinank Jain           2025-10-10  1090  					   input_vtl_zero, &register_page);
621191d709b1488 Nuno Das Neves        2025-03-14  1091  		if (ret)
621191d709b1488 Nuno Das Neves        2025-03-14  1092  			goto unmap_intercept_message_page;
621191d709b1488 Nuno Das Neves        2025-03-14  1093  	}
621191d709b1488 Nuno Das Neves        2025-03-14  1094  
621191d709b1488 Nuno Das Neves        2025-03-14  1095  	if (mshv_partition_encrypted(partition) &&
621191d709b1488 Nuno Das Neves        2025-03-14  1096  	    is_ghcb_mapping_available()) {
19c515c27cee3bb Jinank Jain           2025-10-10  1097  		ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves        2025-03-14  1098  					   HV_VP_STATE_PAGE_GHCB,
19c515c27cee3bb Jinank Jain           2025-10-10  1099  					   input_vtl_normal, &ghcb_page);
621191d709b1488 Nuno Das Neves        2025-03-14  1100  		if (ret)
621191d709b1488 Nuno Das Neves        2025-03-14  1101  			goto unmap_register_page;
621191d709b1488 Nuno Das Neves        2025-03-14  1102  	}
621191d709b1488 Nuno Das Neves        2025-03-14  1103  
621191d709b1488 Nuno Das Neves        2025-03-14  1104  	ret = mshv_vp_stats_map(partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves        2025-03-14  1105  				stats_pages);
621191d709b1488 Nuno Das Neves        2025-03-14 @1106  	if (ret)
621191d709b1488 Nuno Das Neves        2025-03-14  1107  		goto unmap_ghcb_page;
621191d709b1488 Nuno Das Neves        2025-03-14  1108  
bf4afc53b77aeaa Linus Torvalds        2026-02-21  1109  	vp = kzalloc_obj(*vp);
621191d709b1488 Nuno Das Neves        2025-03-14  1110  	if (!vp)
621191d709b1488 Nuno Das Neves        2025-03-14  1111  		goto unmap_stats_pages;
621191d709b1488 Nuno Das Neves        2025-03-14  1112  
621191d709b1488 Nuno Das Neves        2025-03-14  1113  	vp->vp_partition = mshv_partition_get(partition);
621191d709b1488 Nuno Das Neves        2025-03-14  1114  	if (!vp->vp_partition) {
621191d709b1488 Nuno Das Neves        2025-03-14  1115  		ret = -EBADF;
621191d709b1488 Nuno Das Neves        2025-03-14  1116  		goto free_vp;
621191d709b1488 Nuno Das Neves        2025-03-14  1117  	}
621191d709b1488 Nuno Das Neves        2025-03-14  1118  
621191d709b1488 Nuno Das Neves        2025-03-14  1119  	mutex_init(&vp->vp_mutex);
621191d709b1488 Nuno Das Neves        2025-03-14  1120  	init_waitqueue_head(&vp->run.vp_suspend_queue);
621191d709b1488 Nuno Das Neves        2025-03-14  1121  	atomic64_set(&vp->run.vp_signaled_count, 0);
621191d709b1488 Nuno Das Neves        2025-03-14  1122  
621191d709b1488 Nuno Das Neves        2025-03-14  1123  	vp->vp_index = args.vp_index;
19c515c27cee3bb Jinank Jain           2025-10-10  1124  	vp->vp_intercept_msg_page = page_to_virt(intercept_msg_page);
621191d709b1488 Nuno Das Neves        2025-03-14  1125  	if (!mshv_partition_encrypted(partition))
621191d709b1488 Nuno Das Neves        2025-03-14  1126  		vp->vp_register_page = page_to_virt(register_page);
621191d709b1488 Nuno Das Neves        2025-03-14  1127  
621191d709b1488 Nuno Das Neves        2025-03-14  1128  	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
621191d709b1488 Nuno Das Neves        2025-03-14  1129  		vp->vp_ghcb_page = page_to_virt(ghcb_page);
621191d709b1488 Nuno Das Neves        2025-03-14  1130  
621191d709b1488 Nuno Das Neves        2025-03-14  1131  	memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
621191d709b1488 Nuno Das Neves        2025-03-14  1132  
ff225ba9ad71c4c Nuno Das Neves        2026-01-28  1133  	ret = mshv_debugfs_vp_create(vp);
ff225ba9ad71c4c Nuno Das Neves        2026-01-28  1134  	if (ret)
ff225ba9ad71c4c Nuno Das Neves        2026-01-28  1135  		goto put_partition;
ff225ba9ad71c4c Nuno Das Neves        2026-01-28  1136  
621191d709b1488 Nuno Das Neves        2025-03-14  1137  	/*
621191d709b1488 Nuno Das Neves        2025-03-14  1138  	 * Keep anon_inode_getfd last: it installs fd in the file struct and
621191d709b1488 Nuno Das Neves        2025-03-14  1139  	 * thus makes the state accessible in user space.
621191d709b1488 Nuno Das Neves        2025-03-14  1140  	 */
621191d709b1488 Nuno Das Neves        2025-03-14  1141  	ret = anon_inode_getfd("mshv_vp", &mshv_vp_fops, vp,
621191d709b1488 Nuno Das Neves        2025-03-14  1142  			       O_RDWR | O_CLOEXEC);
621191d709b1488 Nuno Das Neves        2025-03-14  1143  	if (ret < 0)
ff225ba9ad71c4c Nuno Das Neves        2026-01-28  1144  		goto remove_debugfs_vp;
621191d709b1488 Nuno Das Neves        2025-03-14  1145  
621191d709b1488 Nuno Das Neves        2025-03-14  1146  	/* already exclusive with the partition mutex for all ioctls */
621191d709b1488 Nuno Das Neves        2025-03-14  1147  	partition->pt_vp_count++;
621191d709b1488 Nuno Das Neves        2025-03-14  1148  	partition->pt_vp_array[args.vp_index] = vp;
621191d709b1488 Nuno Das Neves        2025-03-14  1149  
33c08ba966cf231 Stanislav Kinsburskii 2026-02-26  1150  	goto out;
621191d709b1488 Nuno Das Neves        2025-03-14  1151  
ff225ba9ad71c4c Nuno Das Neves        2026-01-28  1152  remove_debugfs_vp:
ff225ba9ad71c4c Nuno Das Neves        2026-01-28  1153  	mshv_debugfs_vp_remove(vp);
621191d709b1488 Nuno Das Neves        2025-03-14  1154  put_partition:
621191d709b1488 Nuno Das Neves        2025-03-14  1155  	mshv_partition_put(partition);
621191d709b1488 Nuno Das Neves        2025-03-14  1156  free_vp:
621191d709b1488 Nuno Das Neves        2025-03-14  1157  	kfree(vp);
621191d709b1488 Nuno Das Neves        2025-03-14  1158  unmap_stats_pages:
d62313bdf5961b5 Jinank Jain           2025-10-10  1159  	mshv_vp_stats_unmap(partition->pt_id, args.vp_index, stats_pages);
621191d709b1488 Nuno Das Neves        2025-03-14  1160  unmap_ghcb_page:
19c515c27cee3bb Jinank Jain           2025-10-10  1161  	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
19c515c27cee3bb Jinank Jain           2025-10-10  1162  		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
19c515c27cee3bb Jinank Jain           2025-10-10  1163  				       HV_VP_STATE_PAGE_GHCB, ghcb_page,
621191d709b1488 Nuno Das Neves        2025-03-14  1164  				       input_vtl_normal);
621191d709b1488 Nuno Das Neves        2025-03-14  1165  unmap_register_page:
19c515c27cee3bb Jinank Jain           2025-10-10  1166  	if (!mshv_partition_encrypted(partition))
19c515c27cee3bb Jinank Jain           2025-10-10  1167  		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves        2025-03-14  1168  				       HV_VP_STATE_PAGE_REGISTERS,
19c515c27cee3bb Jinank Jain           2025-10-10  1169  				       register_page, input_vtl_zero);
621191d709b1488 Nuno Das Neves        2025-03-14  1170  unmap_intercept_message_page:
19c515c27cee3bb Jinank Jain           2025-10-10  1171  	hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
621191d709b1488 Nuno Das Neves        2025-03-14  1172  			       HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
19c515c27cee3bb Jinank Jain           2025-10-10  1173  			       intercept_msg_page, input_vtl_zero);
621191d709b1488 Nuno Das Neves        2025-03-14  1174  destroy_vp:
621191d709b1488 Nuno Das Neves        2025-03-14  1175  	hv_call_delete_vp(partition->pt_id, args.vp_index);
33c08ba966cf231 Stanislav Kinsburskii 2026-02-26  1176  out:
33c08ba966cf231 Stanislav Kinsburskii 2026-02-26  1177  	trace_mshv_create_vp(partition->pt_id, vp->vp_index, ret);
621191d709b1488 Nuno Das Neves        2025-03-14  1178  	return ret;
621191d709b1488 Nuno Das Neves        2025-03-14  1179  }
621191d709b1488 Nuno Das Neves        2025-03-14  1180  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

