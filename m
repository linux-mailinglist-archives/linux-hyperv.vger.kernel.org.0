Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1AF52404C
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 May 2022 00:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348786AbiEKWc2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 May 2022 18:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348781AbiEKWc2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 May 2022 18:32:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A83162A18;
        Wed, 11 May 2022 15:32:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bv19so6764244ejb.6;
        Wed, 11 May 2022 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwwdzpkKA/5a/A+4LO9ZvV1pjE5U2RxOYQVsqDC2miw=;
        b=Cayh2z/x7yieoDh3/gvJTxqxoUWH9bSKVu3/dVygQBIHDnrbyJVxafqO0pnYBrx/bW
         YCWNvrHx4wlgNDljpy+bMxa1Jf+MUfKTlDoSfRb6kIlkRVQtt7usSiAjLZZ73sXVaktT
         rrV3CF3l7sSq1pc+3xujkFSwjfk2DtKYvV4xVVNe5jqs/gwExY2+6jOkfqM7LdKSEAZS
         qGUIypybtqGBlqIJW4kKUXrSiK0aZl+BUgh3dzNrywjQl9I1YPeiatRC4zGx6WJcjMZL
         MM1SjUeAHXURAC0BeT+gIe+jk/+9c7/I0ZOkcpyke4wnkWMRMuh/2SInY/t71V5kTKWF
         06Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwwdzpkKA/5a/A+4LO9ZvV1pjE5U2RxOYQVsqDC2miw=;
        b=lCCfGfsKCBnpEJGw4O5uPOL8mIb9YnWKSFXjhb31/ONc5H06EaVvsv2lCfce/2g7fe
         yYE/NV1ATccyuir7sDlPWLxjV2u2fAgHUvx42LxiyBc/pb01EK5ScT7oMY2MJfeTCfIN
         neSiASkohCKgQwVeSimzjzmfTPgY49+r7ivt/3mBR+Gf3j7D5YmRxZ3TtUik7T8hwq9S
         q2uPQaS1C3miYtdnJP6YjzULaVzIpxDeDGSypb4/frWE9SOvgkaLW0e9Db5whE1kiYHE
         uykfw6eNaN2cgJZGSSUEUbz3lRSfAm8O4CBF2QXQh5Z9W5mQzoD5aloQ6UUsUZLszR27
         57zA==
X-Gm-Message-State: AOAM5305AvzibINdgYS4LvR2MtiJatIsni1oJkzw/uqvcNF26ffCixO1
        +FwgoknG1n9KjqFEox5eq9s=
X-Google-Smtp-Source: ABdhPJyfGOwR5ohpXrvzm1yDamW4AwEtBc/hn18zguFMB2xIWic537pYhAiKHVMViA24kKmnrBka1A==
X-Received: by 2002:a17:907:e8e:b0:6f4:64aa:5813 with SMTP id ho14-20020a1709070e8e00b006f464aa5813mr27155074ejc.648.1652308345040;
        Wed, 11 May 2022 15:32:25 -0700 (PDT)
Received: from anparri.mshome.net (host-79-30-69-23.retail.telecomitalia.it. [79.30.69.23])
        by smtp.gmail.com with ESMTPSA id f1-20020a1709064dc100b006fa84a0af2asm1468456ejw.16.2022.05.11.15.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:32:24 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 1/2] PCI: hv: Add validation for untrusted Hyper-V values
Date:   Thu, 12 May 2022 00:32:06 +0200
Message-Id: <20220511223207.3386-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511223207.3386-1-parri.andrea@gmail.com>
References: <20220511223207.3386-1-parri.andrea@gmail.com>
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

For additional robustness in the face of Hyper-V errors or malicious
behavior, validate all values that originate from packets that Hyper-V
has sent to the guest in the host-to-guest ring buffer.  Ensure that
invalid values cannot cause data being copied out of the bounds of the
source buffer in hv_pci_onchannelcallback().

While at it, remove a redundant validation in hv_pci_generic_compl():
hv_pci_onchannelcallback() already ensures that all processed incoming
packets are "at least as large as [in fact larger than] a response".

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 33 +++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e439b810f974b..a06e2cf946580 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -981,11 +981,7 @@ static void hv_pci_generic_compl(void *context, struct pci_response *resp,
 {
 	struct hv_pci_compl *comp_pkt = context;
 
-	if (resp_packet_size >= offsetofend(struct pci_response, status))
-		comp_pkt->completion_status = resp->status;
-	else
-		comp_pkt->completion_status = -1;
-
+	comp_pkt->completion_status = resp->status;
 	complete(&comp_pkt->host_event);
 }
 
@@ -1606,8 +1602,13 @@ static void hv_pci_compose_compl(void *context, struct pci_response *resp,
 	struct pci_create_int_response *int_resp =
 		(struct pci_create_int_response *)resp;
 
+	if (resp_packet_size < sizeof(*int_resp)) {
+		comp_pkt->comp_pkt.completion_status = -1;
+		goto out;
+	}
 	comp_pkt->comp_pkt.completion_status = resp->status;
 	comp_pkt->int_desc = int_resp->int_desc;
+out:
 	complete(&comp_pkt->comp_pkt.host_event);
 }
 
@@ -2291,12 +2292,14 @@ static void q_resource_requirements(void *context, struct pci_response *resp,
 	struct q_res_req_compl *completion = context;
 	struct pci_q_res_req_response *q_res_req =
 		(struct pci_q_res_req_response *)resp;
+	s32 status;
 	int i;
 
-	if (resp->status < 0) {
+	status = (resp_packet_size < sizeof(*q_res_req)) ? -1 : resp->status;
+	if (status < 0) {
 		dev_err(&completion->hpdev->hbus->hdev->device,
 			"query resource requirements failed: %x\n",
-			resp->status);
+			status);
 	} else {
 		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 			completion->hpdev->probed_bar[i] =
@@ -2848,7 +2851,8 @@ static void hv_pci_onchannelcallback(void *context)
 			case PCI_BUS_RELATIONS:
 
 				bus_rel = (struct pci_bus_relations *)buffer;
-				if (bytes_recvd <
+				if (bytes_recvd < sizeof(*bus_rel) ||
+				    bytes_recvd <
 					struct_size(bus_rel, func,
 						    bus_rel->device_count)) {
 					dev_err(&hbus->hdev->device,
@@ -2862,7 +2866,8 @@ static void hv_pci_onchannelcallback(void *context)
 			case PCI_BUS_RELATIONS2:
 
 				bus_rel2 = (struct pci_bus_relations2 *)buffer;
-				if (bytes_recvd <
+				if (bytes_recvd < sizeof(*bus_rel2) ||
+				    bytes_recvd <
 					struct_size(bus_rel2, func,
 						    bus_rel2->device_count)) {
 					dev_err(&hbus->hdev->device,
@@ -2876,6 +2881,11 @@ static void hv_pci_onchannelcallback(void *context)
 			case PCI_EJECT:
 
 				dev_message = (struct pci_dev_incoming *)buffer;
+				if (bytes_recvd < sizeof(*dev_message)) {
+					dev_err(&hbus->hdev->device,
+						"eject message too small\n");
+					break;
+				}
 				hpdev = get_pcichild_wslot(hbus,
 						      dev_message->wslot.slot);
 				if (hpdev) {
@@ -2887,6 +2897,11 @@ static void hv_pci_onchannelcallback(void *context)
 			case PCI_INVALIDATE_BLOCK:
 
 				inval = (struct pci_dev_inval_block *)buffer;
+				if (bytes_recvd < sizeof(*inval)) {
+					dev_err(&hbus->hdev->device,
+						"invalidate message too small\n");
+					break;
+				}
 				hpdev = get_pcichild_wslot(hbus,
 							   inval->wslot.slot);
 				if (hpdev) {
-- 
2.25.1

