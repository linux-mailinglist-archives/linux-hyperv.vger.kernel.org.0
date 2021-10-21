Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D9C4365AF
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Oct 2021 17:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhJUPRz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Oct 2021 11:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhJUPRj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Oct 2021 11:17:39 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CE0C061220;
        Thu, 21 Oct 2021 08:15:15 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h193so628802pgc.1;
        Thu, 21 Oct 2021 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bkdxL0wzVfK6U81ANaTN69N6MiyeE9mp/1NIRDs2HTI=;
        b=WDYFIyQjaIWLi9EqqahPeaZ3g9XaGJpJTvl7aIlSxv4+T2iLxZk6ihh0EcYRyY3Zv9
         KXonk4/f0cn1/TUNjAeZRwXlkun5SEm/pNPx1JurtUgfoG1hcrA7Vbf+y3SZcwNAhs27
         oyf2CEsoODVA2zAo/uaNQnMTxyGsyBkk6nqldQj8XvPEFv1FloLWaZsMhdRV5xSR3qQI
         BpLIKnaIy9a21t50pc8L7IGcPA6B9cN0riVUPf78VVm5ooHaUNsSW0Xh6unJ6RnCsqGz
         qOy6mK14quI9OCgP5LyUaUT9ZjyU+M7knF5DJTSkLQsJBk6xYSkKZpbV/uD8jtyZiw6U
         p4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bkdxL0wzVfK6U81ANaTN69N6MiyeE9mp/1NIRDs2HTI=;
        b=S5jyZ0FRI1ov6OhiVkk3bfA0pzM6C4HpuwexwBcmEzBv/DbhOtQyIbY3urQbFD7Dhy
         /EcO3wpURj6RUPqQ8WQu47/YekZIl/RU3UNntAF7WabbcPG6onemoXzd/Y5x606QC7Y8
         MUwu9RzwJlyfy5B3xZjVvHDqQUEm5Ymg15BrgdpHYtUy819gUF0sXKcN1i9FahdcOM/G
         sdjsDWYnwdvyhwbprI/i93NM23N0adSn4K+pzOK8/24KsVZLQMmPxZxZlIYZ8qVO7mcF
         zflcyl4mIO7B9CCDCaC3JGdXB1DfvXY2oL5tTTB1KFUCRKlF9MgkvtZ3aMX/r7/6lDVs
         aE9w==
X-Gm-Message-State: AOAM533SnIOg9niEdDSEMyGgubmVNp6Xo3EjLSnJHLZ/ImMtJZkMy0oj
        A+ZDBD8EHKCzs3Nw4p4Cua0=
X-Google-Smtp-Source: ABdhPJxWSg5WrH6K/IpSe2kzM6dJ/L3POzUlC9k52ws51b3rAzBHEtnS6HtA7ZVCDbXya2+WK5dIKw==
X-Received: by 2002:a63:2c91:: with SMTP id s139mr4832521pgs.116.1634829315039;
        Thu, 21 Oct 2021 08:15:15 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:15:14 -0700 (PDT)
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
Subject: [PATCH v3 24/25] PCI: hv: Use PCI_ERROR_RESPONSE to specify hardware read error
Date:   Thu, 21 Oct 2021 20:37:49 +0530
Message-Id: <0cbcf03e6a66aa1092862d3cde22e487855b9c2d.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
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
index 67c46e52c0dc..7e1102e3d7c6 100644
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

