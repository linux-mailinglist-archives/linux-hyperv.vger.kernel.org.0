Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3854D52070B
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 May 2022 23:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiEIVy4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 May 2022 17:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiEIVxs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 May 2022 17:53:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976672CBF8C;
        Mon,  9 May 2022 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652132924; x=1683668924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OjuWDuA8wp2pAQhE78hbrB1ZqBopu0NlCqBoV3u9VOM=;
  b=XoBTw2hh+QTXB8T4ZVkdF914KbEpZdAeK63UZSnuaK7ACsQA53W1Bv95
   5hAHUXnngUNCDu9uj2MncyYIlTj3vqENLoD+no9uwphcHoNN/MN+PbTI8
   YKQE16xOcT7nO1hUiGcPaH8WtnKC7KgssxdGRu75Q8VaCoL+1MixrAeGN
   0=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 09 May 2022 14:48:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 14:48:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 14:48:33 -0700
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 14:48:31 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>
CC:     <jakeo@microsoft.com>, <dazhan@microsoft.com>,
        <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH 0/2] hyperv compose_msi_msg fixups
Date:   Mon, 9 May 2022 15:48:20 -0600
Message-ID: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

