Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0473F738D5C
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jun 2023 19:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjFURk7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Jun 2023 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjFURkz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Jun 2023 13:40:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4791BD4;
        Wed, 21 Jun 2023 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369249; x=1718905249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Ay13nCNIILT6crueQ5vPOUj5FPygFq/XDGj0VzeZVw=;
  b=DT1js8EpueFC8CNKweJ9DyYXQtpaPz0nyzoiU1a8k0BUqRxmEgFFdt61
   L34fyBHbw1ODPmHAMck+0lEuC3iZ12b7YjlmRUn+Pi1qdBxmJQ8cdkv5K
   JJwUhMNsFLphKZEAGAsciy+5aO+uQh8rt+mvXpdGep6yNhHc1js/u2sAS
   3Zes4YWC3M5sZlH66W+mYxk+vJuJpQH06ujdMIyqBC1yyJlGlw8wK2CaJ
   Yt4cD0UhaJAAYhfb/H0QeSX0oJFDkJF5Sj+JDhNiVnKdYIOQLk4TNk7pq
   /bpGQsxOMm/vGNgLKSF1+API//dsDTkc4JYcPdjZj7SyrSoppUVnq3t7g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="359120619"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="359120619"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:40:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="717746113"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="717746113"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2023 10:40:32 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        iommu@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, steve.wahl@hpe.com,
        mike.travis@hpe.com, dimitri.sivanich@hpe.com,
        russ.anderson@hpe.com, dvhart@infradead.org, andy@infradead.org,
        joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, peterz@infradead.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, xin3.li@intel.com, seanjc@google.com,
        jiangshanlai@gmail.com, jgg@ziepe.ca, yangtiezhu@loongson.cn
Subject: [PATCH v2 0/3] Do IRQ move cleanup with a timer instead of an IPI
Date:   Wed, 21 Jun 2023 10:12:45 -0700
Message-Id: <20230621171248.6805-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

No point to waste a vector for cleaning up the leftovers of a moved
interrupt. Aside of that this must be the lowest priority of all vectors
which makes FRED systems utilizing vectors 0x10-0x1f more complicated
than necessary.

Schedule a timer instead.


Changes since v1:
* Add a lockdep_assert_held() statement to get rid of a bad comment
  that claims __vector_cleanup() needs to be called with vector_lock
  held. (Peter Zijlstra).


Thomas Gleixner (2):
  x86/vector: Rename send_cleanup_vector() to vector_schedule_cleanup()
  x86/vector: Replace IRQ_MOVE_CLEANUP_VECTOR with a timer callback

Xin Li (1):
  tools: Get rid of IRQ_MOVE_CLEANUP_VECTOR from tools

 arch/x86/include/asm/hw_irq.h                 |   4 +-
 arch/x86/include/asm/idtentry.h               |   1 -
 arch/x86/include/asm/irq_vectors.h            |   7 --
 arch/x86/kernel/apic/vector.c                 | 106 ++++++++++++++----
 arch/x86/kernel/idt.c                         |   1 -
 arch/x86/platform/uv/uv_irq.c                 |   2 +-
 drivers/iommu/amd/iommu.c                     |   2 +-
 drivers/iommu/hyperv-iommu.c                  |   4 +-
 drivers/iommu/intel/irq_remapping.c           |   2 +-
 tools/arch/x86/include/asm/irq_vectors.h      |   7 --
 .../beauty/tracepoints/x86_irq_vectors.sh     |   2 +-
 11 files changed, 90 insertions(+), 48 deletions(-)

-- 
2.34.1

