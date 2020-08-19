Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6416B24A904
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Aug 2020 00:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgHSWUN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Aug 2020 18:20:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:55927 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgHSWUM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Aug 2020 18:20:12 -0400
IronPort-SDR: 2S2kTevimqqvFTJpV6HPlMm9tzkfunytZH/5ksofdd6/ESPAREtmL6cFgat1xbwrCsDejXq1h8
 PJEr2BK5fP0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="219512962"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="219512962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 15:20:12 -0700
IronPort-SDR: 9/d8CMzysNFwq9y5DmtgYn/TEPkHkC8RW/gAwyQVIvDOL+WwJUKtSsxkC3Kgr+qVkJ1lm8A3w1
 fyFhOF0kJmeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="310917914"
Received: from lkp-server01.sh.intel.com (HELO 4cedd236b688) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Aug 2020 15:20:10 -0700
Received: from kbuild by 4cedd236b688 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k8WRF-0000cp-DI; Wed, 19 Aug 2020 22:20:09 +0000
Date:   Thu, 20 Aug 2020 06:19:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] hv_utils: HOST_TIMESYNC_DELAY_THRESH can be static
Message-ID: <20200819221954.GA5103@4c77203cfb20>
References: <20200819174527.47156-1-viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819174527.47156-1-viremana@linux.microsoft.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 hv_util.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 1357861fd8aee8..35d126e6f012db 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -290,7 +290,7 @@ static inline u64 reftime_to_ns(u64 reftime)
 /*
  * Hard coded threshold for host timesync delay: 600 seconds
  */
-const u64 HOST_TIMESYNC_DELAY_THRESH = 600 * NSEC_PER_SEC;
+static const u64 HOST_TIMESYNC_DELAY_THRESH = 600 * NSEC_PER_SEC;
 
 static int hv_get_adj_host_time(struct timespec64 *ts)
 {
