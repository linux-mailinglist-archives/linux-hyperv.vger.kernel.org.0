Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE8056D296
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Jul 2022 03:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiGKBc0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 10 Jul 2022 21:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiGKBcQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 10 Jul 2022 21:32:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B5167F9;
        Sun, 10 Jul 2022 18:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657503134; x=1689039134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3XFw5pHl23q7RVJHre/Vnf2UPYe38ywJSOW5Zmw8tTU=;
  b=GaZ09lufuVWQQ0sgzbux0UykaeI8buTgX44xdcP/UTK/P64+OcfoeM5w
   RH6h351aS8lFfV9eidJjXa6QrbHFLRbA6J7eLiCYofyHi4j07LpeYl/9d
   6EZejIHFOkUfmEZvv+b+BMi5mmz6pY6QhBCxauILqvJ2UXFlHBzflXns6
   QE5nr2mqecJlVNUUcAS/JNku+syR5xa97u5t/x4kJjXkBEwkHfHoYSWiD
   P/3gge4ia9POlE0N/8ufpqKb9Qo35KOuiGbptbv42O2sUQOR0GwquI7M+
   G3vlsX6+z6+jf7fKLCGa8Baj51jBO86YdgrG19f1Y/i3WSDs+pU9Vo5TV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="285683166"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="285683166"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 18:32:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="594712070"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2022 18:32:10 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAiHM-00005U-Vj;
        Mon, 11 Jul 2022 01:32:04 +0000
Date:   Mon, 11 Jul 2022 09:31:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Shradha Gupta <shradhagupta@microsoft.com>,
        Praveen Kumar <kumarpraveen@microsoft.com>
Subject: Re: [PATCH v2] Drivers: hv: vm_bus: Handle vmbus rescind calls after
 vmbus is suspended
Message-ID: <202207110545.MC79d9J7-lkp@intel.com>
References: <20220710181458.GA20827@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710181458.GA20827@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Shradha,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19-rc5 next-20220708]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shradha-Gupta/Drivers-hv-vm_bus-Handle-vmbus-rescind-calls-after-vmbus-is-suspended/20220711-021702
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5867f3b88bb54016c42cdde510c184255488a12b
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220711/202207110545.MC79d9J7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7fbe63d321d3e0c099e90e8d8c36921c58c8868f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shradha-Gupta/Drivers-hv-vm_bus-Handle-vmbus-rescind-calls-after-vmbus-is-suspended/20220711-021702
        git checkout 7fbe63d321d3e0c099e90e8d8c36921c58c8868f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hv/vmbus_drv.c: In function 'vmbus_bus_resume':
>> drivers/hv/vmbus_drv.c:2539:36: warning: unused variable 'hv_cpu' [-Wunused-variable]
    2539 |         struct hv_per_cpu_context *hv_cpu = per_cpu_ptr(
         |                                    ^~~~~~


vim +/hv_cpu +2539 drivers/hv/vmbus_drv.c

  2536	
  2537	static int vmbus_bus_resume(struct device *dev)
  2538	{
> 2539		struct hv_per_cpu_context *hv_cpu = per_cpu_ptr(
  2540				hv_context.cpu_context, VMBUS_CONNECT_CPU);
  2541		struct vmbus_channel_msginfo *msginfo;
  2542		size_t msgsize;
  2543		int ret;
  2544	
  2545		vmbus_connection.ignore_any_offer_msg = false;
  2546	
  2547		/*
  2548		 * We only use the 'vmbus_proto_version', which was in use before
  2549		 * hibernation, to re-negotiate with the host.
  2550		 */
  2551		if (!vmbus_proto_version) {
  2552			pr_err("Invalid proto version = 0x%x\n", vmbus_proto_version);
  2553			return -EINVAL;
  2554		}
  2555	
  2556		msgsize = sizeof(*msginfo) +
  2557			  sizeof(struct vmbus_channel_initiate_contact);
  2558	
  2559		msginfo = kzalloc(msgsize, GFP_KERNEL);
  2560	
  2561		if (msginfo == NULL)
  2562			return -ENOMEM;
  2563	
  2564		ret = vmbus_negotiate_version(msginfo, vmbus_proto_version);
  2565	
  2566		kfree(msginfo);
  2567	
  2568		if (ret != 0)
  2569			return ret;
  2570	
  2571		WARN_ON(atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) == 0);
  2572	
  2573		vmbus_request_offers();
  2574	
  2575		if (wait_for_completion_timeout(
  2576			&vmbus_connection.ready_for_resume_event, 10 * HZ) == 0)
  2577			pr_err("Some vmbus device is missing after suspending?\n");
  2578	
  2579		/* Reset the event for the next suspend. */
  2580		reinit_completion(&vmbus_connection.ready_for_suspend_event);
  2581	
  2582		return 0;
  2583	}
  2584	#else
  2585	#define vmbus_bus_suspend NULL
  2586	#define vmbus_bus_resume NULL
  2587	#endif /* CONFIG_PM_SLEEP */
  2588	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
