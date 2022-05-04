Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0824C519FF8
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 May 2022 14:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350012AbiEDMym (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 May 2022 08:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350014AbiEDMyl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 May 2022 08:54:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625D234BBC;
        Wed,  4 May 2022 05:51:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m20so2657939ejj.10;
        Wed, 04 May 2022 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LWMLRl/nejAQqwkUPN49QZ3sNLiM7r5iydC5e7d7ZCE=;
        b=Y2YMJmyA4GJT/NBglkZGWWDMuIJUriIcSFXQxWi3ymQAkry+aaMrYS/Mxj6BVBzXcv
         nYn1Iae0pz127DDTzZ+p+/jUEAl+07uJ8f8p4u+1k4ktwrnQ/F//p83ChIRjjnmY/d9E
         9gs0T5D5qFIzfY2Zojn/uBeXLAoMNkKCHc2uueo1oj/joK0eTO8zLgicKSK1zgzO+JD2
         POEhThRVcVRWNz0mkp2saKmjkcpcWirXK6Q7zX6SN46J3P6jl1KCm3q46r44xBxnhE/1
         LZmZx+kPwyI11q/s1OBPVv/l/Eg49EjeJLbeGtY95Ex/Jh7fZYHwXc4AAtpYucE5u28q
         d3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LWMLRl/nejAQqwkUPN49QZ3sNLiM7r5iydC5e7d7ZCE=;
        b=l99eHmffI91vqAcETV14GUxIq8hwWuAE3UaAbmV3l02bWPd7d68aVl+43AOfT1RkS1
         CjC9rKdp3b6tGr96DUH8gZLQCZVrbaby0qLkJpymWoLtQBhCZsbhuije3Zw9YxOaRcy4
         6sd/xwWGu2jvJ/T3f4uNCoIwOatZfSKYv0PpgGW29RQg3XZyBV3kCc9TZDX3KSunh5T0
         P8yENqdlybrPoZatHxTexGeFszVAemDo9PUt+pC0CMSkbUfb4TzDLpzGs1PFjfYGR7G1
         nko4m3jLq5tu7a495DaimCc7r+MuFz4iQ4clZUv8eyXZI6VnAtY1KxeGUYyrBHP81HPe
         TW6g==
X-Gm-Message-State: AOAM530vEH6pbWKfbdXAr7/KyO5eiJUNcs1N/63xlfTKZTueqt6AmHzo
        geYm10s9Qb966H/HW/IHqF8=
X-Google-Smtp-Source: ABdhPJxQFO9hsfj++nySLOl3J67KZBM6x6PGsMwBl/IkFtxg5LpUxJHBPGtJhDK+VEg7YO8MaNjlLw==
X-Received: by 2002:a17:907:a042:b0:6f3:b4fc:be3d with SMTP id gz2-20020a170907a04200b006f3b4fcbe3dmr20094586ejc.318.1651668663895;
        Wed, 04 May 2022 05:51:03 -0700 (PDT)
Received: from anparri.mshome.net (host-2-117-178-169.business.telecomitalia.it. [2.117.178.169])
        by smtp.gmail.com with ESMTPSA id hz7-20020a1709072ce700b006f3ef214dc9sm5743045ejc.47.2022.05.04.05.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:51:03 -0700 (PDT)
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
Subject: [PATCH 1/2] PCI: hv: Add validation for untrusted Hyper-V values
Date:   Wed,  4 May 2022 14:50:38 +0200
Message-Id: <20220504125039.2598-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504125039.2598-1-parri.andrea@gmail.com>
References: <20220504125039.2598-1-parri.andrea@gmail.com>
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
 drivers/pci/controller/pci-hyperv.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cf2fe5754fde4..9a3e17b682eb7 100644
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
 
@@ -1602,8 +1598,13 @@ static void hv_pci_compose_compl(void *context, struct pci_response *resp,
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
 
@@ -2806,7 +2807,8 @@ static void hv_pci_onchannelcallback(void *context)
 			case PCI_BUS_RELATIONS:
 
 				bus_rel = (struct pci_bus_relations *)buffer;
-				if (bytes_recvd <
+				if (bytes_recvd < sizeof(*bus_rel) ||
+				    bytes_recvd <
 					struct_size(bus_rel, func,
 						    bus_rel->device_count)) {
 					dev_err(&hbus->hdev->device,
@@ -2820,7 +2822,8 @@ static void hv_pci_onchannelcallback(void *context)
 			case PCI_BUS_RELATIONS2:
 
 				bus_rel2 = (struct pci_bus_relations2 *)buffer;
-				if (bytes_recvd <
+				if (bytes_recvd < sizeof(*bus_rel2) ||
+				    bytes_recvd <
 					struct_size(bus_rel2, func,
 						    bus_rel2->device_count)) {
 					dev_err(&hbus->hdev->device,
@@ -2834,6 +2837,11 @@ static void hv_pci_onchannelcallback(void *context)
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
@@ -2845,6 +2853,11 @@ static void hv_pci_onchannelcallback(void *context)
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

