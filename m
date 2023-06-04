Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BC072140E
	for <lists+linux-hyperv@lfdr.de>; Sun,  4 Jun 2023 04:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjFDCGN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 3 Jun 2023 22:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFDCGM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 3 Jun 2023 22:06:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F05DD;
        Sat,  3 Jun 2023 19:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685844370; x=1717380370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H17Z52NC1fO7RmCPvzwNM5L0g6cLDt+b4SXw0TWfuCI=;
  b=l7vZlKjQM9SWBL5qNY9qmbWa2NLooAqUh1omOLqx+exCV67fMETUNpfY
   VQ/1EVHOTie56hP/9lsX6hk1eNYbMAV8hKsO+vEgonvhPSiKdFN8Fae7A
   716AFz6XAbzq+XCidGAAw+kswRJIoOo23ACW+b6o6Pc7XYWyNMHSjrM3Q
   zTAP4DraXJKF0yIkGFPFhb16ztUF32qt+Z6WXeil8cpIK88RnnsqIaggJ
   6kK0bqdkqM2x7HnRXOkLHQ0sLLP9nOAoLIvF6eKvPMu9MG47W5clye8Zr
   9ZNlxR0kr7KC3zu8kNFo3lE31Yft0cdCyZFihlGyzLYRMwYO4V1s4R9KJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="359453116"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="359453116"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 19:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="852563279"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="852563279"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jun 2023 19:06:07 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5d8A-0002ER-1R;
        Sun, 04 Jun 2023 02:06:06 +0000
Date:   Sun, 4 Jun 2023 10:05:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        mikelley@microsoft.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/5] uio: Add hv_vmbus_client driver
Message-ID: <202306040910.13oLufQd-lkp@intel.com>
References: <1685692629-31351-2-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685692629-31351-2-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Saurabh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.4-rc4 next-20230602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saurabh-Sengar/uio-Add-hv_vmbus_client-driver/20230602-160029
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/1685692629-31351-2-git-send-email-ssengar%40linux.microsoft.com
patch subject: [PATCH 1/5] uio: Add hv_vmbus_client driver
config: i386-randconfig-c001-20230604 (https://download.01.org/0day-ci/archive/20230604/202306040910.13oLufQd-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306040910.13oLufQd-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/uio/uio_hv_vmbus_client.c:195:1-6: WARNING: invalid free of devm_ allocated data

vim +195 drivers/uio/uio_hv_vmbus_client.c

   158	
   159	static int uio_hv_vmbus_probe(struct hv_device *dev, const struct hv_vmbus_device_id *dev_id)
   160	{
   161		struct uio_hv_vmbus_dev *pdata;
   162		int ret = 0;
   163		char *name = NULL;
   164	
   165		pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
   166		if (!pdata)
   167			return -ENOMEM;
   168	
   169		name = kasprintf(GFP_KERNEL, "%pUl", &dev->dev_instance);
   170	
   171		/* Fill general uio info */
   172		pdata->info.name = name; /* /sys/class/uio/uioX/name */
   173		pdata->info.version = DRIVER_VERSION;
   174		pdata->info.irqcontrol = uio_hv_vmbus_irqcontrol;
   175		pdata->info.open = uio_hv_vmbus_open;
   176		pdata->info.release = uio_hv_vmbus_release;
   177		pdata->info.irq = UIO_IRQ_CUSTOM;
   178		pdata->info.priv = pdata;
   179		pdata->device = dev;
   180	
   181		ret = uio_register_device(&dev->device, &pdata->info);
   182		if (ret) {
   183			dev_err(&dev->device, "uio_hv_vmbus register failed\n");
   184			goto fail;
   185		}
   186	
   187		ret = sysfs_create_file(&dev->device.kobj, &dev_attr_ring_size.attr);
   188		if (ret)
   189			dev_notice(&dev->device, "sysfs create ring size file failed; %d\n", ret);
   190	
   191		hv_set_drvdata(dev, pdata);
   192		return 0;
   193	
   194	fail:
 > 195		kfree(pdata);
   196		return ret;
   197	}
   198	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
