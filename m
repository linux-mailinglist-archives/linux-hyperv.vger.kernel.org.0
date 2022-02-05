Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B5C4AA6FB
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 06:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiBEFxV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Feb 2022 00:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243150AbiBEFxV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Feb 2022 00:53:21 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Feb 2022 21:53:20 PST
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E91C061347;
        Fri,  4 Feb 2022 21:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644040400; x=1675576400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=im2bmAajx3GGQlxqhChgLpRvbkWNIxqhs1d8c6yRotE=;
  b=g2ODuW4Oy9qj74Uoh31Pp5jTgeQeSa7LGaCo8SrNsEfyCe6A8w935I8X
   +NGQV3N0cz5S0ViOQ3sxgFasuqC/Udb9FLimBpMyIyzAE+0SMZsij0FMV
   yKstkjfhVdmKg+ujbr/Yse+PNIqVTFocw46PCsJ9ZYOG/17qLZAu9FfdU
   X4QyPaMokJK2M2ueEe4dZ3cnoPe0knxI+ZfqCh8GwEi9kbdIclsH171hI
   2V80+CUSUM893O/MibT10/hrQmarBy6XuNCpweHoWIDfJHecI9dUitNfB
   uJo8ywc2NhOt0Njxuq0qNb+/RUHZ9TNsVvVxxbgfEWbDur27E2BjsuTo8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="311790664"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="311790664"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 21:52:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="600427573"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Feb 2022 21:52:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGDzZ-000Yew-9o; Sat, 05 Feb 2022 05:52:13 +0000
Date:   Sat, 5 Feb 2022 13:52:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Iouri Tarassov <iourit@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 01/24] drivers: hv: dxgkrnl: Driver initialization and
 creation of dxgadapter
Message-ID: <202202051359.j7N6kn2E-lkp@intel.com>
References: <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
config: x86_64-randconfig-a004-20220131 (https://download.01.org/0day-ci/archive/20220205/202202051359.j7N6kn2E-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/7a6280c6fb18da7243d3de07abe09b4c3d1938e2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Iouri-Tarassov/Driver-for-Hyper-v-virtual-compute-device/20220205-103726
        git checkout 7a6280c6fb18da7243d3de07abe09b4c3d1938e2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/misc/d3dkmthk.h:25:4: error: unknown type name '__u32'
      25 |    __u32 instance :  6;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:26:4: error: unknown type name '__u32'
      26 |    __u32 index : 24;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:27:4: error: unknown type name '__u32'
      27 |    __u32 unique : 2;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:29:3: error: unknown type name '__u32'
      29 |   __u32 v;
         |   ^~~~~
   ./usr/include/misc/d3dkmthk.h:53:2: error: unknown type name '__u32'
      53 |  __u32 a;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:54:2: error: unknown type name '__u32'
      54 |  __u32 b;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:70:2: error: unknown type name '__u32'
      70 |  __u32    num_sources;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:71:2: error: unknown type name '__u32'
      71 |  __u32    present_move_regions_preferred;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:75:2: error: unknown type name '__u32'
      75 |  __u32    num_adapters;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:76:2: error: unknown type name '__u32'
      76 |  __u32    reserved;
         |  ^~~~~
>> ./usr/include/misc/d3dkmthk.h:77:2: error: unknown type name '__u64'
      77 |  __u64    *adapters;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:93:4: error: unknown type name '__u32'
      93 |    __u32  write_operation  :1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:94:4: error: unknown type name '__u32'
      94 |    __u32  do_not_retire_instance :1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:95:4: error: unknown type name '__u32'
      95 |    __u32  offer_priority  :3;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:96:4: error: unknown type name '__u32'
      96 |    __u32  reserved  :27;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:98:3: error: unknown type name '__u32'
      98 |   __u32   value;
         |   ^~~~~
   ./usr/include/misc/d3dkmthk.h:103:2: error: unknown type name '__u32'
     103 |  __u32    allocation_index;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:106:4: error: unknown type name '__u32'
     106 |    __u32  slot_id:24;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:107:4: error: unknown type name '__u32'
     107 |    __u32  reserved:8;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:109:3: error: unknown type name '__u32'
     109 |   __u32   value;
         |   ^~~~~
   ./usr/include/misc/d3dkmthk.h:111:2: error: unknown type name '__u32'
     111 |  __u32    driver_id;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:112:2: error: unknown type name '__u32'
     112 |  __u32    allocation_offset;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:113:2: error: unknown type name '__u32'
     113 |  __u32    patch_offset;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:114:2: error: unknown type name '__u32'
     114 |  __u32    split_offset;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:118:2: error: unknown type name '__u32'
     118 |  __u32    legacy_mode:1;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:119:2: error: unknown type name '__u32'
     119 |  __u32    request_vSync:1;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:120:2: error: unknown type name '__u32'
     120 |  __u32    disable_gpu_timeout:1;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:121:2: error: unknown type name '__u32'
     121 |  __u32    gdi_device:1;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:122:2: error: unknown type name '__u32'
     122 |  __u32    reserved:28;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:127:2: error: unknown type name '__u32'
     127 |  __u32    reserved3;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:130:2: error: unknown type name '__u64'
     130 |  __u64    command_buffer;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:131:2: error: unknown type name '__u32'
     131 |  __u32    command_buffer_size;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:132:2: error: unknown type name '__u32'
     132 |  __u32    reserved;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:133:2: error: unknown type name '__u64'
     133 |  __u64    allocation_list;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:134:2: error: unknown type name '__u32'
     134 |  __u32    allocation_list_size;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:135:2: error: unknown type name '__u32'
     135 |  __u32    reserved1;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:136:2: error: unknown type name '__u64'
     136 |  __u64    patch_location_list;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:137:2: error: unknown type name '__u32'
     137 |  __u32    patch_location_list_size;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:138:2: error: unknown type name '__u32'
     138 |  __u32    reserved2;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:158:4: error: unknown type name '__u32'
     158 |    __u32  null_rendering:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:159:4: error: unknown type name '__u32'
     159 |    __u32  initial_data:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:160:4: error: unknown type name '__u32'
     160 |    __u32  disable_gpu_timeout:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:161:4: error: unknown type name '__u32'
     161 |    __u32  synchronization_only:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:162:4: error: unknown type name '__u32'
     162 |    __u32  hw_queue_supported:1;
--
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:365:2: error: unknown type name '__u64'
     365 |  __u64    allocation_info;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:367:2: error: unknown type name '__u32'
     367 |  __u32    reserved2;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:368:2: error: unknown type name '__u64'
     368 |  __u64    private_runtime_resource_handle;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:374:4: error: unknown type name '__u32'
     374 |    __u32  assume_not_in_use:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:375:4: error: unknown type name '__u32'
     375 |    __u32  synchronous_destroy:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:376:4: error: unknown type name '__u32'
     376 |    __u32  reserved:29;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:377:4: error: unknown type name '__u32'
     377 |    __u32  system_use_only:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:379:3: error: unknown type name '__u32'
     379 |   __u32   value;
         |   ^~~~~
   ./usr/include/misc/d3dkmthk.h:386:2: error: unknown type name '__u64'
     386 |  __u64    allocations;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:387:2: error: unknown type name '__u32'
     387 |  __u32    alloc_count;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:394:4: error: unknown type name '__u32'
     394 |    __u32  cant_trim_further:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:395:4: error: unknown type name '__u32'
     395 |    __u32  must_succeed:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:396:4: error: unknown type name '__u32'
     396 |    __u32  reserved:30;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:398:3: error: unknown type name '__u32'
     398 |   __u32   value;
         |   ^~~~~
   ./usr/include/misc/d3dkmthk.h:404:2: error: unknown type name '__u32'
     404 |  __u32    alloc_count;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:405:2: error: unknown type name '__u64'
     405 |  __u64    allocation_list;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:406:2: error: unknown type name '__u64'
     406 |  __u64    priority_list;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:408:2: error: unknown type name '__u64'
     408 |  __u64    paging_fence_value;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:409:2: error: unknown type name '__u64'
     409 |  __u64    num_bytes_to_trim;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:415:4: error: unknown type name '__u32'
     415 |    __u32  evict_only_if_necessary:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:416:4: error: unknown type name '__u32'
     416 |    __u32  not_written_to:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:417:4: error: unknown type name '__u32'
     417 |    __u32  reserved:30;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:419:3: error: unknown type name '__u32'
     419 |   __u32   value;
         |   ^~~~~
   ./usr/include/misc/d3dkmthk.h:425:2: error: unknown type name '__u32'
     425 |  __u32    alloc_count;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:426:2: error: unknown type name '__u64'
     426 |  __u64    allocations;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:428:2: error: unknown type name '__u32'
     428 |  __u32    reserved;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:429:2: error: unknown type name '__u64'
     429 |  __u64    num_bytes_to_trim;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:435:4: error: unknown type name '__u64'
     435 |    __u64 write:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:436:4: error: unknown type name '__u64'
     436 |    __u64 execute:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:437:4: error: unknown type name '__u64'
     437 |    __u64 zero:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:438:4: error: unknown type name '__u64'
     438 |    __u64 no_access:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:439:4: error: unknown type name '__u64'
     439 |    __u64 system_use_only:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:440:4: error: unknown type name '__u64'
     440 |    __u64 reserved:59;
         |    ^~~~~
>> ./usr/include/misc/d3dkmthk.h:440:10: error: width of 'reserved' exceeds its type
     440 |    __u64 reserved:59;
         |          ^~~~~~~~
   ./usr/include/misc/d3dkmthk.h:442:3: error: unknown type name '__u64'
     442 |   __u64  value;
         |   ^~~~~
   ./usr/include/misc/d3dkmthk.h:457:4: error: unknown type name '__u64'
     457 |    __u64  base_address;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:458:4: error: unknown type name '__u64'
     458 |    __u64  size;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:460:4: error: unknown type name '__u64'
     460 |    __u64  allocation_offset;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:461:4: error: unknown type name '__u64'
     461 |    __u64  allocation_size;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:464:4: error: unknown type name '__u64'
     464 |    __u64  base_address;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:465:4: error: unknown type name '__u64'
     465 |    __u64  size;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:467:4: error: unknown type name '__u64'
     467 |    __u64  allocation_offset;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:468:4: error: unknown type name '__u64'
     468 |    __u64  allocation_size;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:470:4: error: unknown type name '__u64'
     470 |    __u64  driver_protection;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:473:4: error: unknown type name '__u64'
     473 |    __u64 base_address;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:474:4: error: unknown type name '__u64'
     474 |    __u64 size;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:478:4: error: unknown type name '__u64'
     478 |    __u64 source_address;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:479:4: error: unknown type name '__u64'
     479 |    __u64 size;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:480:4: error: unknown type name '__u64'
     480 |    __u64 dest_address;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:495:2: error: unknown type name '__u32'
     495 |  __u32     num_operations;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:496:2: error: unknown type name '__u64'
     496 |  __u64     operations;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:497:2: error: unknown type name '__u32'
     497 |  __u32     reserved0;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:498:2: error: unknown type name '__u32'
     498 |  __u32     reserved1;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:499:2: error: unknown type name '__u64'
     499 |  __u64     reserved2;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:500:2: error: unknown type name '__u64'
     500 |  __u64     fence_value;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:503:4: error: unknown type name '__u32'
     503 |    __u32   do_not_wait:1;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:504:4: error: unknown type name '__u32'
     504 |    __u32   reserved:31;
         |    ^~~~~
   ./usr/include/misc/d3dkmthk.h:506:3: error: unknown type name '__u32'
     506 |   __u32    value;
         |   ^~~~~
   ./usr/include/misc/d3dkmthk.h:508:2: error: unknown type name '__u32'
     508 |  __u32     reserved3;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:513:2: error: unknown type name '__u64'
     513 |  __u64     base_address;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:514:2: error: unknown type name '__u64'
     514 |  __u64     minimum_address;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:515:2: error: unknown type name '__u64'
     515 |  __u64     maximum_address;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:517:2: error: unknown type name '__u64'
     517 |  __u64     offset_in_pages;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:518:2: error: unknown type name '__u64'
     518 |  __u64     size_in_pages;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:520:2: error: unknown type name '__u64'
     520 |  __u64     driver_protection;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:521:2: error: unknown type name '__u32'
     521 |  __u32     reserved0;
         |  ^~~~~
   ./usr/include/misc/d3dkmthk.h:522:2: error: unknown type name '__u64'
     522 |  __u64     reserved1;
..

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
