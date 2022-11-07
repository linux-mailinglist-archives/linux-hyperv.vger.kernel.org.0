Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EF961FB14
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Nov 2022 18:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiKGRTO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Nov 2022 12:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiKGRTN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Nov 2022 12:19:13 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3615D21247;
        Mon,  7 Nov 2022 09:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1667841528;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Er6sltuM2Fse7dB2YDgaDzGDuUEcxEqcKb82Mwnf7dU=;
    b=tmSu+KeARLzZDRjdk4eWbJYgb7vcLX/tXvmJpmoyrj9ntXS2buc5u9DyMKtu+e7h+L
    VG5T6w7dzV2hUUxsPNwDEUccinzXkDk3KXq7eLcuZnO3mXaE4uScSfY0KVzR6oMSJaYT
    tH4cZSu5OqAOjXjcj2YKWVqtQIycVsO7rxhCx9VUc53rcpwBYYjkGr6bmugLf7GckvpG
    fvxnkA6ryws787T4Xiw5LHRMFqB3pI0FJRoJB2+Xeu7Q46ou/uoSqvGxHOt8ejoq+HF6
    X9ZcXZZ1XisOPTvXfrgK4SpQkYcYx6hcrYh6q4tePmFWbIIOWXOX7LyazwCB7RCUL1Xv
    FaBw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAg4wrVv7EJ8tYgyIiB0X4jURJx/8eeVDQqGGs4HbcQ=="
X-RZG-CLASS-ID: mo00
Received: from sender
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id gb94dfyA7HImrap
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 7 Nov 2022 18:18:48 +0100 (CET)
From:   Olaf Hering <olaf@aepfle.de>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1] PCI: hv: update comment in x86 specific hv_arch_irq_unmask
Date:   Mon,  7 Nov 2022 17:18:31 +0000
Message-Id: <20221107171831.25283-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The function hv_set_affinity was removed in commit 831c1ae7 ("PCI: hv:
Make the code arch neutral by adding arch specific interfaces").

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 drivers/pci/controller/pci-hyperv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e7c6f6629e7c..f62215ed3eba 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -735,9 +735,9 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 	 * during hibernation does not matter (at this time all the devices
 	 * have been frozen). Note: the correct affinity info is still updated
 	 * into the irqdata data structure in migrate_one_irq() ->
-	 * irq_do_set_affinity() -> hv_set_affinity(), so later when the VM
-	 * resumes, hv_pci_restore_msi_state() is able to correctly restore
-	 * the interrupt with the correct affinity.
+	 * irq_do_set_affinity(), so later when the VM resumes,
+	 * hv_pci_restore_msi_state() is able to correctly restore the
+	 * interrupt with the correct affinity.
 	 */
 	if (!hv_result_success(res) && hbus->state != hv_pcibus_removing)
 		dev_err(&hbus->hdev->device,
