Return-Path: <linux-hyperv+bounces-6544-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACC7B28B58
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 Aug 2025 09:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D95A24EB7
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 Aug 2025 07:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C3E21FF38;
	Sat, 16 Aug 2025 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhP7xOm5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9F1FF1C4;
	Sat, 16 Aug 2025 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755328972; cv=none; b=Aua1NhtZmitQzSVI7WWswg9wCW/SrDMHhrms2KmGRL6lnklWGJqohTNs70utLYWkuFUD7TvQeFuTHStklSR9bk8ByYEU6C1vrl6TdL6jbxA+iXyTXdODjlYvoqNg2lA/HulaJWuyynvnyOvvKuun98L4d6R0sDJ9sNFoSVSldOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755328972; c=relaxed/simple;
	bh=RktG3mJqHtP7HemL3r/r9u2zJXZn1GV5rAd1YQbSD60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5DPzKohvW7p3n8oi2Vo+VkePY0zCazXJfdFH37jqRpgXoxxcfk5YVhdJqqz9N/PuvkqhTWUso9d7CM1f5IIvBvnROMdsdpjIfAcdyzOQ89nIXAJHZ3XHNKnDgnWut7EOeDN1jzTf0m1ScmCF42/Ra9Vxgm+hB9VE1ddEpb70PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhP7xOm5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755328971; x=1786864971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RktG3mJqHtP7HemL3r/r9u2zJXZn1GV5rAd1YQbSD60=;
  b=MhP7xOm5XWBxVyEv0QX+kwKM2aIjxJDbcjZSWKK8/6+HNH+isiOnqy4V
   EA45u7zgbihF3IXFoGqzsnuL/19tgBKiz/7dkB/ZPX1WkBb4O+yKx+f/B
   bx/gppjbsIwtiMNzI4CZjHBZmtTVe+kFCYNqo037VLy8CaDD+XuNNAtHk
   7LC8ieEjzsYw4jWmiGiht+rR4M7nmjd0Lxj3WVzjLJRbrjjpWO4BVFAX0
   E/ptvQiQALGzZ5jPyYP5QFnRZDxbRE7zoAH5ido+IsELMkdEoCM3z7QKM
   y5ah7IWjPhSgCKhBXgWUAy9m83BvudiTazTBhlnkzCjq1LgVhrL4Xifm+
   Q==;
X-CSE-ConnectionGUID: lCyQorQ4Ru+w+dWX3/ux5g==
X-CSE-MsgGUID: heqREVKKTmK0bLDw6GPBIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57350579"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57350579"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 00:22:50 -0700
X-CSE-ConnectionGUID: ySHHbVpPQRCbMrfyeMv0Zw==
X-CSE-MsgGUID: NuP/qYHYTZuGYdpC79nLdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="190888765"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 16 Aug 2025 00:22:47 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unBFU-000CfM-2t;
	Sat, 16 Aug 2025 07:22:44 +0000
Date: Sat, 16 Aug 2025 15:22:30 +0800
From: kernel test robot <lkp@intel.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, linux-hyperv@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, Li Tian <litian@redhat.com>,
	Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH] x86/hyperv: Fix kdump on Azure CVMs
Message-ID: <202508161430.0GC3nT8J-lkp@intel.com>
References: <20250815133725.1591863-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815133725.1591863-1-vkuznets@redhat.com>

Hi Vitaly,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on linus/master v6.17-rc1]
[cannot apply to next-20250815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vitaly-Kuznetsov/x86-hyperv-Fix-kdump-on-Azure-CVMs/20250815-214053
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20250815133725.1591863-1-vkuznets%40redhat.com
patch subject: [PATCH] x86/hyperv: Fix kdump on Azure CVMs
config: arm64-randconfig-003-20250816 (https://download.01.org/0day-ci/archive/20250816/202508161430.0GC3nT8J-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508161430.0GC3nT8J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508161430.0GC3nT8J-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hv/vmbus_drv.c: In function 'hv_kexec_handler':
>> drivers/hv/vmbus_drv.c:2786:2: error: implicit declaration of function 'hv_ivm_clear_host_access' [-Werror=implicit-function-declaration]
     hv_ivm_clear_host_access();
     ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/hv_ivm_clear_host_access +2786 drivers/hv/vmbus_drv.c

  2778	
  2779	static void hv_kexec_handler(void)
  2780	{
  2781		hv_stimer_global_cleanup();
  2782		vmbus_initiate_unload(false);
  2783		/* Make sure conn_state is set as hv_synic_cleanup checks for it */
  2784		mb();
  2785		cpuhp_remove_state(hyperv_cpuhp_online);
> 2786		hv_ivm_clear_host_access();
  2787	};
  2788	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

