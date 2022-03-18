Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5CE4DE046
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Mar 2022 18:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbiCRRub (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Mar 2022 13:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbiCRRu3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Mar 2022 13:50:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1303E17AD91;
        Fri, 18 Mar 2022 10:49:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id pv16so18539339ejb.0;
        Fri, 18 Mar 2022 10:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hOptq36EIaU+7q/z3r7gSJIR1VIBf62WxlBwqnGeHM=;
        b=Q9Zp/bmNqbsb5ocpQ4GYdoBy7Ut80KfaLQ7f0GnovInyg/48dKi+BhbPuNvCz/O00p
         z+T6CdHE9GxTyAawJ0YYONT7DC1pH0ELKIweetFnYE1NzRJ+fWBJps7mNE2x6dy7lqIr
         kx/bLIFg7HR6SSQgsxVWKcmoAWX40gYxu7qelAp0/C66YEDozKDF4RLsJAjJnxIIwmFq
         RVcUOUy5c83eK+351qQVy8d5K3cMPDjfBkyFSF3MYY5hrOoHTSQrbrBY6KRka0JYvmFi
         DUVLqaUtUF/emCQydwgkYET7QODfIfbJCtJbwRxYHIzLmcgOwoBHsW0IgX1Eb1UHesVr
         aZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hOptq36EIaU+7q/z3r7gSJIR1VIBf62WxlBwqnGeHM=;
        b=JNHXDrSMvljkThj7PknZF+J5Dklp9L2kBYRPjGJesFrWB6Lt6iyuKMmdYZlaaDi1Jt
         nrwyiKzwIO8Ig+cBgD56yIgIEVuLH11wh5shwhhqRT0WWlFMQW79vKYEvPIrofiE2TdF
         wFR6ij6PyMcyWbKY8kUYa8ikVwIo5ZtXXc2nEdJWuEyl5xVde7yVpZ0qZrQ7Q3NCvvl7
         6BB/qn2RSOPAusGM9H9tOb4rv4dUw50bne99rggUrCBAKqC1UcMIk3FtyegIxXybX6I8
         Z5NLQwJJ5+MpOlHt9AXfT8bPRm7WOIF1unIY+nFd3m6Q+p6uYhnVdZEGR4yA98SQv+/q
         L9pw==
X-Gm-Message-State: AOAM533eopgZPJwT2c8SQ1O/dPCgIgPglCcwBIYSROP4LbW33jNxeYq7
        GmB/Ta9pUrQFpuDiOfAVEL0=
X-Google-Smtp-Source: ABdhPJx1eh824v53InGX+pX0Ffn435EWSbrG8usub1KO5A2ZNV/rdTimyy5ESNEFnVXGCHPrWuec/A==
X-Received: by 2002:a17:906:3a15:b0:6cf:ea4e:a1cc with SMTP id z21-20020a1709063a1500b006cfea4ea1ccmr10241365eje.753.1647625745510;
        Fri, 18 Mar 2022 10:49:05 -0700 (PDT)
Received: from anparri.mshome.net (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id y15-20020a170906518f00b006df87a2bb16sm3218730ejk.89.2022.03.18.10.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 10:49:05 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 2/2] PCI: hv: Fix synchronization between channel callback and hv_compose_msi_msg()
Date:   Fri, 18 Mar 2022 18:48:48 +0100
Message-Id: <20220318174848.290621-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318174848.290621-1-parri.andrea@gmail.com>
References: <20220318174848.290621-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dexuan wrote:

  "[...]  when we disable AccelNet, the host PCI VSP driver sends a
   PCI_EJECT message first, and the channel callback may set
   hpdev->state to hv_pcichild_ejecting on a different CPU.  This can
   cause hv_compose_msi_msg() to exit from the loop and 'return', and
   the on-stack variable 'ctxt' is invalid.  Now, if the response
   message from the host arrives, the channel callback will try to
   access the invalid 'ctxt' variable, and this may cause a crash."

Schematically:

  Hyper-V sends PCI_EJECT msg
    hv_pci_onchannelcallback()
      state = hv_pcichild_ejecting
                                       hv_compose_msi_msg()
                                         alloc and init comp_pkt
                                         state == hv_pcichild_ejecting
  Hyper-V sends VM_PKT_COMP msg
    hv_pci_onchannelcallback()
      retrieve address of comp_pkt
                                         'free' comp_pkt and return
      comp_pkt->completion_func()

Dexuan also showed how the crash can be triggered after introducing
suitable delays in the driver code, thus validating the 'assumption'
that the host can still normally respond to the guest's compose_msi
request after the host has started to eject the PCI device.

Fix the synchronization by leveraging the IDR lock.  Retrieve the
address of the completion packet *and call the completion function
within a same critical section: if an address (request ID) is found
in the channel callback, the critical section precedes the removal
of the address in hv_compose_msi_msg().

Fixes: de0aa7b2f97d3 ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
Reported-by: Wei Hu <weh@microsoft.com>
Reported-by: Dexuan Cui <decui@microsoft.com>
Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index fbc62aab08fdc..dddd7e4d0352d 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -495,7 +495,8 @@ struct hv_pcibus_device {
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
 
-	spinlock_t idr_lock; /* Serialize accesses to the IDR */
+	/* Serialize accesses to the IDR; see also hv_pci_onchannelcallback(). */
+	spinlock_t idr_lock;
 	struct idr idr; /* Map guest memory addresses */
 
 	struct list_head children;
@@ -2797,16 +2798,24 @@ static void hv_pci_onchannelcallback(void *context)
 			}
 			spin_lock_irqsave(&hbus->idr_lock, flags);
 			comp_packet = (struct pci_packet *)idr_find(&hbus->idr, req_id);
-			spin_unlock_irqrestore(&hbus->idr_lock, flags);
 			if (!comp_packet) {
+				spin_unlock_irqrestore(&hbus->idr_lock, flags);
 				dev_warn_ratelimited(&hbus->hdev->device,
 						     "Request ID not found\n");
 				break;
 			}
 			response = (struct pci_response *)buffer;
+			/*
+			 * Call ->completion_func() within the critical section to make
+			 * sure that the packet pointer is still valid during the call:
+			 * here 'valid' means that there's a task still waiting for the
+			 * completion, and that the packet data is still on the waiting
+			 * task's stack/has not already been freed by the waiting task.
+			 */
 			comp_packet->completion_func(comp_packet->compl_ctxt,
 						     response,
 						     bytes_recvd);
+			spin_unlock_irqrestore(&hbus->idr_lock, flags);
 			break;
 
 		case VM_PKT_DATA_INBAND:
-- 
2.25.1

