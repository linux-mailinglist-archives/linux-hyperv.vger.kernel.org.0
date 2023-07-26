Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7877D763A88
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jul 2023 17:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbjGZPMh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Jul 2023 11:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjGZPMb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Jul 2023 11:12:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8385C2D73;
        Wed, 26 Jul 2023 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690384299; x=1721920299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xfcbdunn8MVYthWj9IRX2o+ue4q+jU9XBsqmvhqwWJs=;
  b=CnrpEgVqddNstHVCQvItaLUIY9Dz1jP6tljxKHtt1ep/6Er0rpfBZhNG
   8aj4KD8KwgMUvQQNPiMUN+q/KJLoCmSgsdihof0fhDsA/zUxlM/kG+1Ya
   EG4vAEEnYHi7UW3zXH6Rob4YrMqnMmOwoIhDy2c+s4SOqeJgWkTGaXyzA
   c/RixVrMHkt66SoB024Bv107O4ZkTsgikxoQsky8BJ12AC3LfarZ7mElc
   RR1UsIcaPkBuEV55rtpNcBmMo5OGr2tyS/ZjQo2EMV4XVS1jp909G4dI5
   vMRgXNh3SXWiWW7LK614pGjhObIRgkVmC8jONkCaxBOiCR3AUXml6C0Ln
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="434309019"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="434309019"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 08:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="720501450"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="720501450"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2023 08:11:26 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOgAa-00013L-1j;
        Wed, 26 Jul 2023 15:11:21 +0000
Date:   Wed, 26 Jul 2023 23:11:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     sharmaajay@linuxonhyperv.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [Patch v2 3/5] RDMA/mana_ib : Add error eq and notification from
 SoC
Message-ID: <202307262214.QoyNnN8T-lkp@intel.com>
References: <1690343820-20188-4-git-send-email-sharmaajay@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690343820-20188-4-git-send-email-sharmaajay@linuxonhyperv.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.5-rc3 next-20230726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sharmaajay-linuxonhyperv-com/RDMA-mana-ib-Rename-all-mana_ib_dev-type-variables-to-mib_dev/20230726-115925
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/1690343820-20188-4-git-send-email-sharmaajay%40linuxonhyperv.com
patch subject: [Patch v2 3/5] RDMA/mana_ib : Add error eq and notification from SoC
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230726/202307262214.QoyNnN8T-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307262214.QoyNnN8T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307262214.QoyNnN8T-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/mana/main.c:508:6: warning: no previous prototype for 'mana_ib_soc_event_handler' [-Wmissing-prototypes]
     508 | void mana_ib_soc_event_handler(void *ctx, struct gdma_queue *queue,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/mana_ib_soc_event_handler +508 drivers/infiniband/hw/mana/main.c

   507	
 > 508	void mana_ib_soc_event_handler(void *ctx, struct gdma_queue *queue,
   509					struct gdma_event *event)
   510	{
   511		struct mana_ib_dev *mib_dev = (struct mana_ib_dev *)ctx;
   512	
   513		switch (event->type) {
   514		case GDMA_EQE_SOC_EVENT_NOTIFICATION:
   515			ibdev_info(&mib_dev->ib_dev, "Received SOC Notification");
   516			break;
   517		case GDMA_EQE_SOC_EVENT_TEST:
   518			ibdev_info(&mib_dev->ib_dev, "Received SoC Test");
   519			break;
   520		default:
   521			ibdev_err(&mib_dev->ib_dev, "Received unsolicited evt %d",
   522				event->type);
   523		}
   524	}
   525	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
