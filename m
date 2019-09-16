Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E8CB4212
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Sep 2019 22:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391442AbfIPUni (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Sep 2019 16:43:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37184 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbfIPUni (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Sep 2019 16:43:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id i1so843431wro.4;
        Mon, 16 Sep 2019 13:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oEvxZvssX49R5a8dabCLJlXPjptDKkJzN4UZVHUANFI=;
        b=CHBypgUHaxf7cVBalNuSWPc2byC/r6Y5yDzGoGRIHv7tSnV3UT6tLe0c0xdiwKGbGo
         QkZpKz7FzejCnmY/WKqaCMLv82YbL+QFy1BRo5hvBEl2yjburhHJV124V6vE4LfZXTon
         ZS8CgNMchSN2QKEI2ocWoHeS/bIPwJw8ugXbrN/RXJw1d/Uvkub1i8zKF8lNwNx72cCt
         S/iX+ztSWK5oXs+K26YFnHp3GYBAiCRuNIRidwWjQMaQK+3zCsIvdL8MQsGXL6EjOv3r
         Om12OeMe8shwC9psKl215IB7Pa76t20tWn0CIhgCjQ919Y0Bb1RIRJ/Ndh/nuZbkuaK+
         /5kg==
X-Gm-Message-State: APjAAAUYsBlz4KfQzRwJCPjVgfBpMD9WyW4AfluFwTy0SRu6HpUJLpQb
        IuWzzZv49zQ+fLj9uwzXLPk=
X-Google-Smtp-Source: APXvYqyy42MRiZs7nxgMyo+9sMwrImohVM3ON2Adp8kT5iGWbgOjB+CDnQUW+D/FFxhanpK6U23gHQ==
X-Received: by 2002:a05:6000:105:: with SMTP id o5mr203431wrx.51.1568666616192;
        Mon, 16 Sep 2019 13:43:36 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:43:35 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v3 02/26] PCI: hv: Use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:34 +0300
Message-Id: <20190916204158.6889-3-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Replace the magic constant (6) with define PCI_STD_NUM_BARS representing
the number of PCI BARs.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/controller/pci-hyperv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 40b625458afa..1665c23b649f 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -307,7 +307,7 @@ struct pci_bus_relations {
 struct pci_q_res_req_response {
 	struct vmpacket_descriptor hdr;
 	s32 status;			/* negative values are failures */
-	u32 probed_bar[6];
+	u32 probed_bar[PCI_STD_NUM_BARS];
 } __packed;
 
 struct pci_set_power {
@@ -503,7 +503,7 @@ struct hv_pci_dev {
 	 * What would be observed if one wrote 0xFFFFFFFF to a BAR and then
 	 * read it back, for each of the BAR offsets within config space.
 	 */
-	u32 probed_bar[6];
+	u32 probed_bar[PCI_STD_NUM_BARS];
 };
 
 struct hv_pci_compl {
@@ -1327,7 +1327,7 @@ static void survey_child_resources(struct hv_pcibus_device *hbus)
 	 * so it's sufficient to just add them up without tracking alignment.
 	 */
 	list_for_each_entry(hpdev, &hbus->children, list_entry) {
-		for (i = 0; i < 6; i++) {
+		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 			if (hpdev->probed_bar[i] & PCI_BASE_ADDRESS_SPACE_IO)
 				dev_err(&hbus->hdev->device,
 					"There's an I/O BAR in this list!\n");
@@ -1401,7 +1401,7 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 	/* Pick addresses for the BARs. */
 	do {
 		list_for_each_entry(hpdev, &hbus->children, list_entry) {
-			for (i = 0; i < 6; i++) {
+			for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 				bar_val = hpdev->probed_bar[i];
 				if (bar_val == 0)
 					continue;
@@ -1558,7 +1558,7 @@ static void q_resource_requirements(void *context, struct pci_response *resp,
 			"query resource requirements failed: %x\n",
 			resp->status);
 	} else {
-		for (i = 0; i < 6; i++) {
+		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 			completion->hpdev->probed_bar[i] =
 				q_res_req->probed_bar[i];
 		}
-- 
2.21.0

