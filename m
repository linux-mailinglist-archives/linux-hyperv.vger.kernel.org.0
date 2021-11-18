Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0AA455D9A
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Nov 2021 15:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhKROMs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Nov 2021 09:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbhKROMr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Nov 2021 09:12:47 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1711C061570;
        Thu, 18 Nov 2021 06:09:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so5828730pjb.1;
        Thu, 18 Nov 2021 06:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otIBlbR4NTHUrEp/WYu2Y03OTgd+6umgzibtCvzje0s=;
        b=gVoIOcI852I7EU2zy3TSd3RJe/detUUq1Ve0b3AIMbrSUDE/Vy/VCFqYM7pe6sx8Cc
         gux7B4/DgiCaPuKEKCRsNwXS3JqSk7yWtMgvSSDQNuLhRhinw2yjJQ8qvYnBRmQVs7hP
         DryNQCHnbGa+5OjqEqJEYooh8gr/jtHaOiJn/fyQcg5IKPy5uACoLLey4/+t6tFGKzMD
         1iYCeMTAxrjLbn6W5Y9jOt0vLOzQoK3qvpRDHqUPhd2HgPd4azd0UhfMVxtaD3R2tLJY
         X3NUgIFIZhBqq9W+UX92825pbxcVAf+dFZPcsAZ+3ZabFsJUl/XE7AXu5cukLw8htrMN
         1JNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otIBlbR4NTHUrEp/WYu2Y03OTgd+6umgzibtCvzje0s=;
        b=4YsSu1O1rp7loKIFO5w9XqH0u8GHcErjcFtT5f+Zrl/6lgquwWcbBnzIAMJw+dMHPZ
         YAIk8BP48mGQcL0wiS+HPqoYIHcN9tUYWQvNmsWqmEBnqKQXWqrWkUMf7XrbroEHBI9t
         kCYsIjQT5xsGUQRQZgd3EuT5M2uXVJVdwMa7U3dBDQCoiQLYtBSvZFKArD/8lIoxJcEJ
         P6aN/+p3n/Asw07Xg9ia9lrBQkQtSUwqyNxQyowFr33XLvRpyOcFG/sTrOPWA5Zc32Yf
         E1Y4h8wQBRivlnEx0bMqxHg3IYuMioS1S7hapcG29YOVlqqfE0jhEC1/XN8LOwCgbiqC
         OjDA==
X-Gm-Message-State: AOAM533KLyCG7hDeL9tEYvfQGTcRI6EesJhHrB2ce6njiEcz4yq6J9nM
        cGoV8SijwoN3QRQlV5ActCY=
X-Google-Smtp-Source: ABdhPJx1zPuGcWopRuFR6Vd9E6bpdnVaEtb9yWanVmd73lNDx+Q1NhxffyXrU/L5bDlA9BloyDAtFg==
X-Received: by 2002:a17:90b:128d:: with SMTP id fw13mr10927636pjb.50.1637244587334;
        Thu, 18 Nov 2021 06:09:47 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:09:47 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS)
Subject: [PATCH v4 24/25] PCI: hv: Use PCI_ERROR_RESPONSE to specify hardware read error
Date:   Thu, 18 Nov 2021 19:33:34 +0530
Message-Id: <12124f41cab7d8aa944de05f85d9567bfe157704.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Include PCI_ERROR_RESPONSE along with 0xFFFFFFFF in the comment to
specify a hardware error. This makes MMIO read errors easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6733cb14e775..1f961d0b5d6b 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1774,7 +1774,7 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 	 * If the memory enable bit is already set, Hyper-V silently ignores
 	 * the below BAR updates, and the related PCI device driver can not
 	 * work, because reading from the device register(s) always returns
-	 * 0xFFFFFFFF.
+	 * 0xFFFFFFFF (PCI_ERROR_RESPONSE).
 	 */
 	list_for_each_entry(hpdev, &hbus->children, list_entry) {
 		_hv_pcifront_read_config(hpdev, PCI_COMMAND, 2, &command);
-- 
2.25.1

