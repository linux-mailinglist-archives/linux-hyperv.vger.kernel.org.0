Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5E4A1485
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2019 11:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfH2JRS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Aug 2019 05:17:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42818 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfH2JRS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Aug 2019 05:17:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id m44so3229882edd.9;
        Thu, 29 Aug 2019 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pj7f+sDqW2TJkX8VbNnafBgnm3E9qPWWRCV6G6c4Ssk=;
        b=k19WPym2o2hprt/FjqTEoD+WYq5/IEJe/Spr+nkG5i2lRprzlHI9uhkIDyV+dja7GZ
         P1qXN6rHGLT+/x5UZsC/MGB9WuoV4SQ+lZyUpMVZD1r0ISvOXrUay0hUwX5Okor0TwVa
         vVO9WrnZ4ebvj2+uAl7tC3ts8NoOVzZVJ3W8WpAsuHAFkUhtkwGZVkXYb4EAmNHCmoVI
         G/gGacO0too7Ax8OzJfdppUlXaAjdqNXDSWW70YPycQeyvzUMqIIPVcUPoqI9cNr2hv6
         a1VtiJAOUTNTAug9UyfKQXPNmLj5ImX8F3nyn/fiMCzelQ99e6bqZtNCY6mGqQRojlSf
         07SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Pj7f+sDqW2TJkX8VbNnafBgnm3E9qPWWRCV6G6c4Ssk=;
        b=KzN1xMFlYF+sf5gOue5iTDGePkYaso9WYB0UXcxD8A5fjdXYeLgkGAR9JUMoxg2fUE
         gfQz4IywO4OEazJ4HhAuRRDrd2WXP3NROJM0A+OzbQLv+jsBEZjPSJL/z5b+ri+Jn6p6
         YlXh42Ot+qTA4jhW/M/ivMJc+vd5fp3aumqyQNI+96tGUBTVLowO0iaEpJ7KsNd7SjZb
         Pa55K3JgKsF3Ipd2BYfogin9D+nVGGLSsYD5MgxmkvOzQwVJdu+fhQEBpQbJ0XFUEeIQ
         QfdfrXSa2HHE9uMqFEm3Xzb+jHC9lpIdAf0FG0Z3Y4YFXK03Fx/MxRoAWlj/JOvDCXJs
         +jgQ==
X-Gm-Message-State: APjAAAVZ4fIO+/aObIA9uWUaxZXd8lQY7wEWfclUy5zxPytGFFm0pKFT
        KixZX2TTlszQFv0BP2TjWJI=
X-Google-Smtp-Source: APXvYqyZGI6MDjRDplO415Nr0UzGhWhWlXrOAglxeH0HyAkVvixfKKnKPi3OjQdVoxU4rgxKIk+UPQ==
X-Received: by 2002:a50:bf4f:: with SMTP id g15mr8455764edk.92.1567070236167;
        Thu, 29 Aug 2019 02:17:16 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id h6sm334213eds.48.2019.08.29.02.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 02:17:15 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [PATCH v3] PCI: hv: Make functions static
Date:   Thu, 29 Aug 2019 11:17:13 +0200
Message-Id: <20190829091713.27130-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190828221846.6672-1-kw@linux.com>
References: <20190828221846.6672-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Functions hv_read_config_block(), hv_write_config_block()
and hv_register_block_invalidate() are not used anywhere
else and are local to drivers/pci/controller/pci-hyperv.c,
and do not need to be in global scope, so make these static.

Resolve following compiler warning that can be seen when
building with warnings enabled (W=1):

drivers/pci/controller/pci-hyperv.c:933:5: warning:
 no previous prototype for ‘hv_read_config_block’
  [-Wmissing-prototypes]

drivers/pci/controller/pci-hyperv.c:1013:5: warning:
 no previous prototype for ‘hv_write_config_block’
  [-Wmissing-prototypes]

drivers/pci/controller/pci-hyperv.c:1082:5: warning:
 no previous prototype for ‘hv_register_block_invalidate’
  [-Wmissing-prototypes]

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Changes in v3:
  Commit message has been wrapped to fit 75 columns.
  Addressed formatting based on feedback from v2.

Changes in v2:
  Update commit message to include compiler warning.

 drivers/pci/controller/pci-hyperv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index f1f300218fab..ba988fe033b5 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -930,8 +930,9 @@ static void hv_pci_read_config_compl(void *context, struct pci_response *resp,
  *
  * Return: 0 on success, -errno on failure
  */
-int hv_read_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
-			 unsigned int block_id, unsigned int *bytes_returned)
+static int hv_read_config_block(struct pci_dev *pdev, void *buf,
+				unsigned int len, unsigned int block_id,
+				unsigned int *bytes_returned)
 {
 	struct hv_pcibus_device *hbus =
 		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
@@ -1010,8 +1011,8 @@ static void hv_pci_write_config_compl(void *context, struct pci_response *resp,
  *
  * Return: 0 on success, -errno on failure
  */
-int hv_write_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
-			  unsigned int block_id)
+static int hv_write_config_block(struct pci_dev *pdev, void *buf,
+				 unsigned int len, unsigned int block_id)
 {
 	struct hv_pcibus_device *hbus =
 		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
@@ -1079,9 +1080,9 @@ int hv_write_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
  *
  * Return: 0 on success, -errno on failure
  */
-int hv_register_block_invalidate(struct pci_dev *pdev, void *context,
-				 void (*block_invalidate)(void *context,
-							  u64 block_mask))
+static int hv_register_block_invalidate(
+	struct pci_dev *pdev, void *context,
+	void (*block_invalidate)(void *context, u64 block_mask))
 {
 	struct hv_pcibus_device *hbus =
 		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
@@ -1097,7 +1098,6 @@ int hv_register_block_invalidate(struct pci_dev *pdev, void *context,
 
 	put_pcichild(hpdev);
 	return 0;
-
 }
 
 /* Interrupt management hooks */
-- 
2.22.1

