Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527004273BE
	for <lists+linux-hyperv@lfdr.de>; Sat,  9 Oct 2021 00:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbhJHW3c (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 18:29:32 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:40901 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhJHW3b (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 18:29:31 -0400
Received: by mail-wr1-f41.google.com with SMTP id i12so21246021wrb.7;
        Fri, 08 Oct 2021 15:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czFz26TUpS008YGLjPJ2Pa8iufQcGRqEsfBe/MkTKGU=;
        b=sSdr5/zkXPd0DXAYycVA3SG2vIvM2vRwkmgLHhfW7q9UjyhRXlNpLkqq10SVhF+TOK
         1XxXDcqfWKLiJon/p2Ydwg+ftYifqlcL89TVheZ04UuFjd7O3xetnDQCZ69OmN7qlbYZ
         rvFgSMz8weodCfJiegFAdN4H2fDygoXw5OGK2RlhOaLEY0QpcXiRd5jJ4ehV2q78IQ33
         c1tuvSu8y5rdEiHYlTILgmc4MVJEABtpnayv+idPsb1MGL0wyeUpWOUyVqIk5laU2COS
         vz7ntNKupQ9fMrT/Y8sxoKc1bx2DmRNrwfTRK0Cj8U1U+da/AI0U3hQcxC1QbLGTaLA9
         THdQ==
X-Gm-Message-State: AOAM533jO39xFl3bmKzAeffi3dccARG1QY1Ayz6SRrkIy5vG/e1RT+uL
        9iUFSoq0iCNZSJDHR1wK+5k=
X-Google-Smtp-Source: ABdhPJxrQlnZz3Rvdgngn6POTEAbYZH0nFyW1f4PMActlBm6V+wpXKsV2Byc16g06QdvjnOQarnHrQ==
X-Received: by 2002:a5d:56cc:: with SMTP id m12mr7245683wrw.22.1633732054641;
        Fri, 08 Oct 2021 15:27:34 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b15sm549577wrr.90.2021.10.08.15.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 15:27:34 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI: hv: Remove unnecessary integer promotion from dev_err()
Date:   Fri,  8 Oct 2021 22:27:30 +0000
Message-Id: <20211008222732.2868493-1-kw@linux.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Internally, printk() et al already correctly handles the standard
integer promotions, so there is no need to explicitly "%h" modifier as
part of a format string such as "%hx".

Thus, drop the "%h" modifier as it's completely unnecessary (N.B. this
wouldn't be true for the sscanf() function family), and match preferred
coding style.

Related:
  commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary
  commit 70eb2275ff8e ("checkpatch: add warning for unnecessary use of %h[xudi] and %hh[xudi]")
  https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pci-hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 67c46e52c0dc..6733cb14e775 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3126,14 +3126,14 @@ static int hv_pci_probe(struct hv_device *hdev,
 
 	if (dom == HVPCI_DOM_INVALID) {
 		dev_err(&hdev->device,
-			"Unable to use dom# 0x%hx or other numbers", dom_req);
+			"Unable to use dom# 0x%x or other numbers", dom_req);
 		ret = -EINVAL;
 		goto free_bus;
 	}
 
 	if (dom != dom_req)
 		dev_info(&hdev->device,
-			 "PCI dom# 0x%hx has collision, using 0x%hx",
+			 "PCI dom# 0x%x has collision, using 0x%x",
 			 dom_req, dom);
 
 	hbus->bridge->domain_nr = dom;
-- 
2.33.0

