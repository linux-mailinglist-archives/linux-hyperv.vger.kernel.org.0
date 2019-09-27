Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF49C0E9E
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Sep 2019 01:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfI0XnQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 27 Sep 2019 19:43:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35327 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI0XnQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 27 Sep 2019 19:43:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so3116459lfl.2;
        Fri, 27 Sep 2019 16:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c8uGLij7T5Lhd9NNM8IRpienFCfZLI1fF2YsMfwjMb0=;
        b=nGEy3BShGtH9jG0mH+ZtDfICSzXbZwOQWP3jeLcW93g20Qkt/JnkUI6i/1tsHCXtQq
         5mAoANpqa1BecDWxVjyr6VZkOS0xU69VvudDeerrU1SJlAjtkmfBqoIUNfOAdtffnEhE
         muVvtwrXJZ7q+f+tGWt3q6xnFFSEFJlcmZlPS7sAYm2L92Hy9g9Q1tHwwOLte1K3e/KJ
         qg+R2okbKGnfOEB4wF3h91EF9ey9x2YUhje6aSw/jaVb+sXU1Hzj+IbrdnOVCoISAv9c
         bpCTkxGJVqijAc0U22vuNZ7U1So4HNUfhva14qO2qxIhHPiMl7k8XH9s0T4bIuk7ufse
         LUUg==
X-Gm-Message-State: APjAAAWaqLjk8krkp7T8bzcPm61xAYWxTdyPgbmKapb5dRQr/WVEYTiC
        qEUt/KnkRFuDjUHlq94YDZNuey8rsTY=
X-Google-Smtp-Source: APXvYqxaiyRdOlpBwWGF862QfV4eTAG1q+uwD8zL+weLda64/duQKMgTc/QRXQANLb7+8tTLId6QQQ==
X-Received: by 2002:ac2:4c8f:: with SMTP id d15mr4785336lfl.74.1569627792625;
        Fri, 27 Sep 2019 16:43:12 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id b67sm788812ljf.5.2019.09.27.16.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 16:43:12 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        x86@kernel.org, linux-s390@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND v3 01/26] PCI: Add define for the number of standard PCI BARs
Date:   Sat, 28 Sep 2019 02:43:08 +0300
Message-Id: <20190927234308.23935-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-3-efremov@linux.com>
References: <20190916204158.6889-3-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Code that iterates over all standard PCI BARs typically uses
PCI_STD_RESOURCE_END. However, it requires the "unusual" loop condition
"i <= PCI_STD_RESOURCE_END" rather than something more standard like
"i < PCI_STD_NUM_BARS".

This patch adds the definition PCI_STD_NUM_BARS which is equivalent to
"PCI_STD_RESOURCE_END + 1". To iterate through all possible BARs, loop
conditions changed to the *number* of BARs "i < PCI_STD_NUM_BARS",
instead of the index of the last valid BAR "i <= PCI_STD_RESOURCE_END"
or PCI_ROM_RESOURCE. The magic constant (6) is also replaced with new
define PCI_STD_NUM_BARS.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/pci-sysfs.c       |  4 ++--
 drivers/pci/pci.c             | 13 +++++++------
 drivers/pci/proc.c            |  4 ++--
 drivers/pci/quirks.c          |  4 ++--
 include/linux/pci.h           |  2 +-
 include/uapi/linux/pci_regs.h |  1 +
 6 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 965c72104150..3e26b8e03bd5 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1257,7 +1257,7 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
 {
 	int i;
 
-	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		struct bin_attribute *res_attr;
 
 		res_attr = pdev->res_attr[i];
@@ -1328,7 +1328,7 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 	int retval;
 
 	/* Expose the PCI resources from this device as files */
-	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 
 		/* skip empty resources */
 		if (!pci_resource_len(pdev, i))
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1b27b5af3d55..7d543986026b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -674,7 +674,7 @@ struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res)
 {
 	int i;
 
-	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		struct resource *r = &dev->resource[i];
 
 		if (r->start && resource_contains(r, res))
@@ -3768,7 +3768,7 @@ void pci_release_selected_regions(struct pci_dev *pdev, int bars)
 {
 	int i;
 
-	for (i = 0; i < 6; i++)
+	for (i = 0; i < PCI_STD_NUM_BARS; i++)
 		if (bars & (1 << i))
 			pci_release_region(pdev, i);
 }
@@ -3779,7 +3779,7 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
 {
 	int i;
 
-	for (i = 0; i < 6; i++)
+	for (i = 0; i < PCI_STD_NUM_BARS; i++)
 		if (bars & (1 << i))
 			if (__pci_request_region(pdev, i, res_name, excl))
 				goto err_out;
@@ -3827,7 +3827,7 @@ EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
 
 void pci_release_regions(struct pci_dev *pdev)
 {
-	pci_release_selected_regions(pdev, (1 << 6) - 1);
+	pci_release_selected_regions(pdev, (1 << PCI_STD_NUM_BARS) - 1);
 }
 EXPORT_SYMBOL(pci_release_regions);
 
@@ -3846,7 +3846,8 @@ EXPORT_SYMBOL(pci_release_regions);
  */
 int pci_request_regions(struct pci_dev *pdev, const char *res_name)
 {
-	return pci_request_selected_regions(pdev, ((1 << 6) - 1), res_name);
+	return pci_request_selected_regions(pdev,
+			((1 << PCI_STD_NUM_BARS) - 1), res_name);
 }
 EXPORT_SYMBOL(pci_request_regions);
 
@@ -3868,7 +3869,7 @@ EXPORT_SYMBOL(pci_request_regions);
 int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
 {
 	return pci_request_selected_regions_exclusive(pdev,
-					((1 << 6) - 1), res_name);
+				((1 << PCI_STD_NUM_BARS) - 1), res_name);
 }
 EXPORT_SYMBOL(pci_request_regions_exclusive);
 
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index fe7fe678965b..cb61ec2c24e8 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -248,13 +248,13 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 	}
 
 	/* Make sure the caller is mapping a real resource for this device */
-	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (dev->resource[i].flags & res_bit &&
 		    pci_mmap_fits(dev, i, vma,  PCI_MMAP_PROCFS))
 			break;
 	}
 
-	if (i >= PCI_ROM_RESOURCE)
+	if (i >= PCI_STD_NUM_BARS)
 		return -ENODEV;
 
 	if (fpriv->mmap_state == pci_mmap_mem &&
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44c4ae1abd00..998454b0ae8d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -475,7 +475,7 @@ static void quirk_extend_bar_to_page(struct pci_dev *dev)
 {
 	int i;
 
-	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		struct resource *r = &dev->resource[i];
 
 		if (r->flags & IORESOURCE_MEM && resource_size(r) < PAGE_SIZE) {
@@ -1810,7 +1810,7 @@ static void quirk_alder_ioapic(struct pci_dev *pdev)
 	 * The next five BARs all seem to be rubbish, so just clean
 	 * them out.
 	 */
-	for (i = 1; i < 6; i++)
+	for (i = 1; i < PCI_STD_NUM_BARS; i++)
 		memset(&pdev->resource[i], 0, sizeof(pdev->resource[i]));
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 82e4cd1b7ac3..cf7d16305243 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -76,7 +76,7 @@ enum pci_mmap_state {
 enum {
 	/* #0-5: standard PCI resources */
 	PCI_STD_RESOURCES,
-	PCI_STD_RESOURCE_END = 5,
+	PCI_STD_RESOURCE_END = PCI_STD_RESOURCES + PCI_STD_NUM_BARS - 1,
 
 	/* #6: expansion ROM resource */
 	PCI_ROM_RESOURCE,
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f28e562d7ca8..68b571d491eb 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -34,6 +34,7 @@
  * of which the first 64 bytes are standardized as follows:
  */
 #define PCI_STD_HEADER_SIZEOF	64
+#define PCI_STD_NUM_BARS	6	/* Number of standard BARs */
 #define PCI_VENDOR_ID		0x00	/* 16 bits */
 #define PCI_DEVICE_ID		0x02	/* 16 bits */
 #define PCI_COMMAND		0x04	/* 16 bits */
-- 
2.21.0

