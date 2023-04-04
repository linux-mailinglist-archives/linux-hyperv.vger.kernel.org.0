Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459496D5F1F
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Apr 2023 13:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjDDLgf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Apr 2023 07:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbjDDLgd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Apr 2023 07:36:33 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 383A3420E;
        Tue,  4 Apr 2023 04:35:58 -0700 (PDT)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id C077B209A868;
        Tue,  4 Apr 2023 04:35:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C077B209A868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680608151;
        bh=Xb9yuM7R3oQ9NGgUVXpfb5wLOmXOn+CR7TrZ/4l7qqo=;
        h=From:To:Cc:Subject:Date:From;
        b=rvQv8WqiXyc1xM/K7HQGFRvxtzOHIyOVnKmRSnqnIOxAKKv6T29e8EON04+yt5ZaF
         3N62HcinnlpAAR5QpC+f4/4OrNNEI9EY3DV+B5eHHff8BmMmkKVevFiynlQwTwbojB
         SgXazHdLuIXX+CG0FCK6LPvFcZys+/7LgXU4CPl0=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
To:     jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, nunodasneves@linux.microsoft.com
Subject: [PATCH] PCI: hv: Use nested hypercall for retargeting interrupts
Date:   Tue,  4 Apr 2023 11:35:46 +0000
Message-Id: <20230404113546.856813-1-jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In case of nested MSHV, retargeting interrupt hypercall should be sent
to L0 hypervisor instead of L1 hypervisor.

Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index f33370b75628..2123f632ecf7 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -704,8 +704,14 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 		}
 	}
 
-	res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size << 17),
-			      params, NULL);
+	if (hv_nested)
+		res = hv_do_nested_hypercall(HVCALL_RETARGET_INTERRUPT |
+					     (var_size << 17),
+					     params, NULL);
+	else
+		res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT |
+				      (var_size << 17),
+				      params, NULL);
 
 exit_unlock:
 	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
-- 
2.34.1

