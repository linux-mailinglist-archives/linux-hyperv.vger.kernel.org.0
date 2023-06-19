Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF11736030
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 01:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjFSXng (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jun 2023 19:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFSXne (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jun 2023 19:43:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D504A186;
        Mon, 19 Jun 2023 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687218213; x=1718754213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2IydA7aDSW7WAlkvgWIB7B8MuolrT6i4fpDMP7/KzxQ=;
  b=Ou8khvC0mKcie3XfRCeAvE+vLIfcT9X74jf+zmIyB6SgoyFaa/0JqQzW
   PMK4fZgKQRXFhNmnT4zgg+xLlMaPx4uGl8+jYzXeESePiQiOrVGhSyTGJ
   rrmmm6P+jKFurl7nWDceTlhnIbTHAt2ucNuJwFDsHwCAvdiQMxbz8YqIx
   RUMmozqOhiaCeXXV8YVAr1YV9bn2Lig939B5wWa29lrtQQ7K6BhoYCoxe
   QdYOI2Aha+KMa32TBdko7GrFzXkFbKqBIypSYQYuOL5Uqe9CLRrUWIEeN
   xOZ8eZDzKHQy9ccXZspL2b6CRDESUfLkXPjJ1jr++VwsdGHs8t0QWOW+U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="340071423"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="340071423"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 16:43:33 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="747789680"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="747789680"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga001.jf.intel.com with ESMTP; 19 Jun 2023 16:43:31 -0700
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
Subject: [PATCH 0/3] Do IRQ move cleanup with a timer instead of an IPI
Date:   Mon, 19 Jun 2023 16:16:08 -0700
Message-Id: <20230619231611.2230-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Thomas Gleixner (2):
  x86/vector: Rename send_cleanup_vector() to vector_schedule_cleanup()
  x86/vector: Replace IRQ_MOVE_CLEANUP_VECTOR with a timer callback

Xin Li (1):
  tools: Get rid of IRQ_MOVE_CLEANUP_VECTOR from tools

 arch/x86/include/asm/hw_irq.h                 |   4 +-
 arch/x86/include/asm/idtentry.h               |   1 -
 arch/x86/include/asm/irq_vectors.h            |   7 --
 arch/x86/kernel/apic/vector.c                 | 109 ++++++++++++++----
 arch/x86/kernel/idt.c                         |   1 -
 arch/x86/platform/uv/uv_irq.c                 |   2 +-
 drivers/iommu/amd/iommu.c                     |   2 +-
 drivers/iommu/hyperv-iommu.c                  |   4 +-
 drivers/iommu/intel/irq_remapping.c           |   2 +-
 tools/arch/x86/include/asm/irq_vectors.h      |   7 --
 .../beauty/tracepoints/x86_irq_vectors.sh     |   2 +-
 11 files changed, 92 insertions(+), 49 deletions(-)

-- 
2.34.1

