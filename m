Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501CB68E9C9
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Feb 2023 09:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjBHIXD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Feb 2023 03:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBHIXD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Feb 2023 03:23:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AFEB746;
        Wed,  8 Feb 2023 00:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675844582; x=1707380582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eT7LyT1k1N1zT8h2h1TIVWuk3jB5eyl3BSlItLElxuw=;
  b=gceGxfvgj/pRYd+OvN3pm45rr22v25Jc612QAJSOtzw5i9rKCdDhuhrN
   P07YijBybzQ9MBFZrOa+zeNmwhQw8WdC4wE8Hj69qKtA2ICyD67iVuEyT
   Bx08Q/Pc5haGm8znw1UskSiRT9By62+SbShEYwJHQDpvWZOKB9JOu34yb
   5fFYYmBsfFIHKsshyxea7MNP9Nc3WyVZevIHiZ/Rojakitf9zviLJJpEG
   8AB8fl6DyfImLTM8F8EbUm7bjbh8oFzVqvT4rXEV/+vJT9FAM7WNk2wyK
   oU3y/FBmcV7oDjFAWPpSyNJ3RNvUOR00ZM5SF5AMj3q5SxPJ1nt+h+ysH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331874274"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="331874274"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 00:23:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="996049097"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="996049097"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Feb 2023 00:22:57 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPfjE-0004JC-1f;
        Wed, 08 Feb 2023 08:22:56 +0000
Date:   Wed, 8 Feb 2023 16:22:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com, dphadke@linux.microsoft.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 6/6] Driver: VMBus: Add device tree support
Message-ID: <202302081621.odizDzHG-lkp@intel.com>
References: <1675756199-5917-7-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675756199-5917-7-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Saurabh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20230207]
[cannot apply to robh/for-next tip/timers/core brgl/gpio/for-next wsa/i2c/for-next linus/master v6.2-rc7 v6.2-rc6 v6.2-rc5 v6.2-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saurabh-Sengar/drivers-clocksource-hyper-v-non-ACPI-support-in-hyperv-clock/20230207-155113
patch link:    https://lore.kernel.org/r/1675756199-5917-7-git-send-email-ssengar%40linux.microsoft.com
patch subject: [PATCH v4 6/6] Driver: VMBus: Add device tree support
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20230208/202302081621.odizDzHG-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b3cd029f78e9c1f5cd1633e1ffc7c5a09deae98f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Saurabh-Sengar/drivers-clocksource-hyper-v-non-ACPI-support-in-hyperv-clock/20230207-155113
        git checkout b3cd029f78e9c1f5cd1633e1ffc7c5a09deae98f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hv/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hv/vmbus_drv.c:2691:21: warning: attribute declaration must precede definition [-Wignored-attributes]
   static const struct __maybe_unused of_device_id vmbus_of_match[] = {
                       ^
   include/linux/compiler_attributes.h:355:56: note: expanded from macro '__maybe_unused'
   #define __maybe_unused                  __attribute__((__unused__))
                                                          ^
   include/linux/mod_devicetable.h:268:8: note: previous definition is here
   struct of_device_id {
          ^
   1 warning generated.


vim +2691 drivers/hv/vmbus_drv.c

  2690	
> 2691	static const struct __maybe_unused of_device_id vmbus_of_match[] = {
  2692		{
  2693			.compatible = "microsoft,vmbus",
  2694		},
  2695		{
  2696			/* sentinel */
  2697		},
  2698	};
  2699	MODULE_DEVICE_TABLE(of, vmbus_of_match);
  2700	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
