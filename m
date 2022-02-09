Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD5B4AE716
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Feb 2022 03:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiBICln (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Feb 2022 21:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiBIChl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Feb 2022 21:37:41 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92866C061355;
        Tue,  8 Feb 2022 18:37:40 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id z18so606374iln.2;
        Tue, 08 Feb 2022 18:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J2A+sjZnS5cRMoX3xrf2NiPs/KWZ3vKvmI0duGN4ktY=;
        b=S8cMgrKplxI50Aumzypa+57fs1D2jx+SSXm19HgRZ1KkM/J7s5Bit0ZDnxpGQkfnCm
         kYhc1+m+fPk5w64tsFAJlyRtiOh+6rK6xJjVIkzj2Fg3quIEHYo9nhCHyX6ny7wTlXoA
         rw6++R8VC+iZXy9c8xTS+BfttUupCo5Tm/0n1/FnsFsMSV48dLxUuse6+unLrf/woFzM
         I/j7wszoIl0+JhmQzkGjEW9NmiZ1Mj1TzCU16xa1HQfLXkXEmLA4RjnUrMWp8b9oYjLI
         Tto1xS1Yy9Qyeqa/+vPUi/kIsh+PE7GvUcFecVTc55q/JR3muPZrIp1UH4qZmeV9WGtn
         yE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J2A+sjZnS5cRMoX3xrf2NiPs/KWZ3vKvmI0duGN4ktY=;
        b=b2r5TZ6pVRShWYdIc0d3NMNm3EH6kTD2FjGrT5CG6sDHfE8I47AnCIVicLC2zw+Ech
         tW98Eq9DBNye0fKzt+aX+YB3Cye4gS2qlMpg3aTJEjCcpyLxUMFbCSbnVTG6VvBC1J5t
         w8OtPs93o/GUZKNVIa+3/nRvZybyH+SJGZH5Itg77WKZEm/vHBi9To8/I7n6xOkVUZht
         vA6dMFb760e+KJ8TxmBL99QkbgWEfWRV4IhSAKhfaQx/ca8EekJCKzExsXBdp0YmH+6G
         GVUbM9r+Rxt4zNXWvvqw6RpP+fkr1i1ag6wRzf3hD22JwRPOldX+On8TigBAauqC/vvt
         dG2w==
X-Gm-Message-State: AOAM533R+BBHY5N88LUy69AGxXwGQcgQx2/EksWPpRc2fM/He8MzEXi3
        sFQ5wq8x9k2Ou5JuEe0IdGQ=
X-Google-Smtp-Source: ABdhPJzO/bwJZAuNb/YObVBnUoezD2/wuk46qw3zm3oPQ0zePvcUEqZbtucXf7YxO+GRY3zW3EEJ8Q==
X-Received: by 2002:a05:6e02:1aa2:: with SMTP id l2mr65090ilv.111.1644374258027;
        Tue, 08 Feb 2022 18:37:38 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p5sm8957352iof.50.2022.02.08.18.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:37:37 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1FF9227C0054;
        Tue,  8 Feb 2022 21:37:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 08 Feb 2022 21:37:36 -0500
X-ME-Sender: <xms:7ygDYjr7dx3TR8Q-fRFbaegqjzVPWZMZYv2TxueDedGvDmEB85KdNg>
    <xme:7ygDYtovOoWQe4OCsCAFASQR92NIDYQg-14X3R6QIWN8AMnEXspcO8N2PITUvKA4B
    -Wa_n7t-oGWnUiTfw>
X-ME-Received: <xmr:7ygDYgOUHCE7QkWmVsKloXRIP6mF-OlH5D6NKGf2yQjj76ZuwOyFf-gB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheekgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeijefhledvtdegudfhffeugeetveeluefgkeevhfeuudeuudfgveevhfetvdeuvden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvg
X-ME-Proxy: <xmx:7ygDYm4jzRc-M5hmb86t7Mbohn9y40_vJq62PExmC7lsAak20b8GkQ>
    <xmx:7ygDYi6u2LkEKybkab_lWDVOdr1FwqgUmFS-VggvsKwDY_cHGhNmyQ>
    <xmx:7ygDYugZDsVYd2Y2Qy9EzVc0T99jB1AbgXPICSajc8Ksz0ZHsxl6Qg>
    <xmx:7ygDYiz5HXC2wyrtVIbrimxH8rIlMSDm28FHsgwvLqgK9gg7YVQAhE4ZOqc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Feb 2022 21:37:34 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] PCI: hv: Avoid the retarget interrupt hypercall in irq_unmask() on ARM64
Date:   Wed,  9 Feb 2022 10:37:20 +0800
Message-Id: <20220209023722.2866009-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.35.1
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

On ARM64 Hyper-V guests, SPIs are used for the interrupts of virtual PCI
devices, and SPIs can be managed directly via GICD registers. Therefore
the retarget interrupt hypercall is not needed on ARM64.

The retarget interrupt hypercall related code is now put in a helper
function and only called on x86.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 20ea2ee330b8..80aa33ef5bf0 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1457,7 +1457,7 @@ static void hv_irq_mask(struct irq_data *data)
 }
 
 /**
- * hv_irq_unmask() - "Unmask" the IRQ by setting its current
+ * __hv_irq_unmask() - "Unmask" the IRQ by setting its current
  * affinity.
  * @data:	Describes the IRQ
  *
@@ -1466,7 +1466,7 @@ static void hv_irq_mask(struct irq_data *data)
  * is built out of this PCI bus's instance GUID and the function
  * number of the device.
  */
-static void hv_irq_unmask(struct irq_data *data)
+static void __hv_irq_unmask(struct irq_data *data)
 {
 	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
 	struct hv_retarget_device_interrupt *params;
@@ -1569,6 +1569,13 @@ static void hv_irq_unmask(struct irq_data *data)
 	if (!hv_result_success(res) && hbus->state != hv_pcibus_removing)
 		dev_err(&hbus->hdev->device,
 			"%s() failed: %#llx", __func__, res);
+}
+
+static void hv_irq_unmask(struct irq_data *data)
+{
+	/* Only use a hypercall on x86 */
+	if (IS_ENABLED(CONFIG_X86))
+		__hv_irq_unmask(data);
 
 	if (data->parent_data->chip->irq_unmask)
 		irq_chip_unmask_parent(data);
-- 
2.35.1

