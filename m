Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A604AA7D1
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 10:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbiBEJPY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Feb 2022 04:15:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:45429 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236403AbiBEJPX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Feb 2022 04:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644052523; x=1675588523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2kLr/umGsI4Xu60tkXutyS9LhMVOCQqk8XihJAwvpRg=;
  b=Nqv9BWwszN2sMcc0RUeD6X9yzqMh6ZkpX5GIpUNpb227SyHfk3kC5GV9
   vVtLelQCCwFWWvR77c3Rn6JXoG97t3fPnPzJON1lHjalPYR5BjQwiNW9l
   EaC//bVuo5P6ZrHyXRPoy6pXCqaWrOVNOUP4AYORhQGMUbBB2Bdnuq3Qd
   b7JsSM06Tj4YNBk6Cj41BxJzz7T/YIwonmbeB7zaVH7uQDn6NujmBNyt2
   82wkD2cT23oFx7xY8gYmyGK6qax50wBQH9ZkOeAgaIVbtQi7LAkGjGMF4
   2nJZk1l990OR7OKAidVQcjRh9svVlOgMYfLm9jR+HYWhQqp3/rmbLr+Qx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="247333413"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="247333413"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 01:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="481078562"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Feb 2022 01:15:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGHA7-000YpZ-HM; Sat, 05 Feb 2022 09:15:19 +0000
Date:   Sat, 5 Feb 2022 17:14:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Iouri Tarassov <iourit@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 01/24] drivers: hv: dxgkrnl: Driver initialization and
 creation of dxgadapter
Message-ID: <202202051759.oGUDauQC-lkp@intel.com>
References: <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Iouri,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc2 next-20220204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Iouri-Tarassov/Driver-for-Hyper-v-virtual-compute-device/20220205-103726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0457e5153e0e8420134f60921349099e907264ca
config: x86_64-randconfig-a011-20220131 (https://download.01.org/0day-ci/archive/20220205/202202051759.oGUDauQC-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 78c6b90000292eb37aac5dead6ab26611cd76f42)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7a6280c6fb18da7243d3de07abe09b4c3d1938e2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Iouri-Tarassov/Driver-for-Hyper-v-virtual-compute-device/20220205-103726
        git checkout 7a6280c6fb18da7243d3de07abe09b4c3d1938e2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/misc/d3dkmthk.h:25:4: error: unknown type name '__u32'
                           __u32 instance  :  6;
                           ^
   ./usr/include/misc/d3dkmthk.h:26:4: error: unknown type name '__u32'
                           __u32 index     : 24;
                           ^
   ./usr/include/misc/d3dkmthk.h:27:4: error: unknown type name '__u32'
                           __u32 unique    : 2;
                           ^
   ./usr/include/misc/d3dkmthk.h:29:3: error: unknown type name '__u32'
                   __u32 v;
                   ^
   ./usr/include/misc/d3dkmthk.h:53:2: error: unknown type name '__u32'
           __u32 a;
           ^
   ./usr/include/misc/d3dkmthk.h:54:2: error: unknown type name '__u32'
           __u32 b;
           ^
   ./usr/include/misc/d3dkmthk.h:70:2: error: unknown type name '__u32'
           __u32                           num_sources;
           ^
   ./usr/include/misc/d3dkmthk.h:71:2: error: unknown type name '__u32'
           __u32                           present_move_regions_preferred;
           ^
   ./usr/include/misc/d3dkmthk.h:75:2: error: unknown type name '__u32'
           __u32                           num_adapters;
           ^
   ./usr/include/misc/d3dkmthk.h:76:2: error: unknown type name '__u32'
           __u32                           reserved;
           ^
>> ./usr/include/misc/d3dkmthk.h:77:2: error: unknown type name '__u64'
           __u64                           *adapters;
           ^
   ./usr/include/misc/d3dkmthk.h:93:4: error: unknown type name '__u32'
                           __u32           write_operation         :1;
                           ^
   ./usr/include/misc/d3dkmthk.h:94:4: error: unknown type name '__u32'
                           __u32           do_not_retire_instance  :1;
                           ^
   ./usr/include/misc/d3dkmthk.h:95:4: error: unknown type name '__u32'
                           __u32           offer_priority          :3;
                           ^
   ./usr/include/misc/d3dkmthk.h:96:4: error: unknown type name '__u32'
                           __u32           reserved                :27;
                           ^
   ./usr/include/misc/d3dkmthk.h:98:3: error: unknown type name '__u32'
                   __u32                   value;
                   ^
   ./usr/include/misc/d3dkmthk.h:103:2: error: unknown type name '__u32'
           __u32                           allocation_index;
           ^
   ./usr/include/misc/d3dkmthk.h:106:4: error: unknown type name '__u32'
                           __u32           slot_id:24;
                           ^
   ./usr/include/misc/d3dkmthk.h:107:4: error: unknown type name '__u32'
                           __u32           reserved:8;
                           ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
