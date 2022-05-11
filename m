Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6BB523716
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 May 2022 17:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343540AbiEKPW3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 May 2022 11:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbiEKPW1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 May 2022 11:22:27 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B3A37BF4;
        Wed, 11 May 2022 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652282545; x=1683818545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OjuWDuA8wp2pAQhE78hbrB1ZqBopu0NlCqBoV3u9VOM=;
  b=dYQXk2L1JTYnJ7zzmk7KWVTnC9DVyrWJv52KkP9see6g0gZENfPdjel+
   LVzBcwsIVyjQeTKa/5QxiGdJLtC1yDOQCrUybbbx/dPEU4v6rS4QBxwgN
   iHXQ8ho105YnHxAfPq3dhbKcdQ4Cu6MS2yqaUcNJl7SDAalPHdX5DyADL
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 May 2022 08:22:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 08:22:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 08:22:25 -0700
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 08:22:24 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>
CC:     <jakeo@microsoft.com>, <dazhan@microsoft.com>,
        <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v2 0/2] hyperv compose_msi_msg fixups
Date:   Wed, 11 May 2022 09:22:11 -0600
Message-ID: <1652282533-21502-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

While multi-MSI appears to work with pci-hyperv.c, there was a concern about
how linux was doing the ITRE allocations.  Patch 2 addresses the concern.

However, patch 2 exposed an issue with how compose_msi_msg() was freeing a
previous allocation when called for the Nth time.  Imagine a driver using
pci_alloc_irq_vectors() to request 32 MSIs.  This would cause compose_msi_msg()
to be called 32 times, once for each MSI.  With patch 2, MSI0 would allocate
the ITREs needed, and MSI1-31 would use the cached information.  Then the driver
uses request_irq() on MSI1-17.  This would call compose_msi_msg() again on those
MSIs, which would again use the cached information.  Then unmask() would be
called to retarget the MSIs to the right VCPU vectors.  Finally, the driver
calls request_irq() on MSI0.  This would call conpose_msi_msg(), which would
free the block of 32 MSIs, and allocate a new block.  This would undo the
retarget of MSI1-17, and likely leave those MSIs targeting invalid VCPU vectors.
This is addressed by patch 1, which is introduced first to prevent a regression.

Jeffrey Hugo (2):
  PCI: hv: Reuse existing ITRE allocation in compose_msi_msg()
  PCI: hv: Fix interrupt mapping for multi-MSI

 drivers/pci/controller/pci-hyperv.c | 76 ++++++++++++++++++++++++++++---------
 1 file changed, 59 insertions(+), 17 deletions(-)

-- 
2.7.4

