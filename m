Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F69D33D
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2019 17:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbfHZPmE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Aug 2019 11:42:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39347 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbfHZPmE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Aug 2019 11:42:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id i63so16330401wmg.4;
        Mon, 26 Aug 2019 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BuKiLPPx3WZb18KjEBPIDucn0EvSVWkRKmbpGZhpx+A=;
        b=VAzJwDRuBaxBdFubOwbTnTfVQq9MfH+ytDLchNHQMQQ8ecq0q+LhTNcNoavQ2Wauko
         /Uom0aUGQJx4//eKpLCL7XH1BGeJ9vlNyjDopVVydGi2EkiElRo1cR61XIJZ55g4rZ/A
         DDjYzCg83uMzyPlVufvjb/rxD+Ae/xWjgEKVwvzn63/I/51EPNQqyti8fuBDuAFvnRWu
         z9heqT0thRiVuJPSDiFqEHCagGXCv22RDjSKExEMA9Jc42PM6cnE1zqi5zVNWmUuEHfb
         c40Y34Nq//Zc01oyzKHysavfyTdaowaXPSobtolIetIWGpZtOH/mrgyYraDEaAHubCES
         5scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=BuKiLPPx3WZb18KjEBPIDucn0EvSVWkRKmbpGZhpx+A=;
        b=n+LhylHAOMM9Y1eGfW4Hs1OJzvqR9bPlm6cZtT81h1bB2fxvhks50KZQXOLT+twXuy
         EMWoGt1gYYEAxcW0n23cT8k+FQB4nbctG5ATKL0nlyn91ndbVYFXZbZs92C1Jo2NXzG1
         sXVTe+GlZ+ab/l97xf55lIY4NY8zJ9JGizXKetFgZ4dn09T0Imh1Bb2/crzTY9DFPa1z
         Lu12AJAnzAMOmLNN1Drbux/32zW3hsSk89r7CE1XzauDFO/l5M3lbzUGAUoJDRkKC+G4
         NEtsHd/tOYHVn4v30Hm+jFVnhrE25fMEcdwq6+b4CCPlsgMEVuOF7d1QBLp485h3ZN+Q
         KJrg==
X-Gm-Message-State: APjAAAU2K4Sms0iZW46mchjklg3z0RAID2NAx5OSiCPlbkEFzjyY/L57
        bxi3ht2jd3UJ8iDSkVxjHh0=
X-Google-Smtp-Source: APXvYqzvHRKG3k5WDrYTTbUuQ0IVTK+v4eHtFzB3In8kqXePOoZn326xQ7UkwrF+Hh0HO/fH8WqJ1Q==
X-Received: by 2002:a1c:c018:: with SMTP id q24mr22317873wmf.162.1566834121939;
        Mon, 26 Aug 2019 08:42:01 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id g26sm12148959wmh.32.2019.08.26.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:42:00 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [PATCH] PCI: hv: Make functions only used locally static in pci-hyperv.c
Date:   Mon, 26 Aug 2019 17:41:59 +0200
Message-Id: <20190826154159.9005-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Functions hv_read_config_block(), hv_write_config_block()
and hv_register_block_invalidate() are not used anywhere
else and are local to drivers/pci/controller/pci-hyperv.c,
and do not need to be in global scope, so make these static.

Resolve compiler warning that can be seen when building with
warnings enabled (W=1).

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/pci/controller/pci-hyperv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index f1f300218fab..c9642e429c2d 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -930,7 +930,7 @@ static void hv_pci_read_config_compl(void *context, struct pci_response *resp,
  *
  * Return: 0 on success, -errno on failure
  */
-int hv_read_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
+static int hv_read_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
 			 unsigned int block_id, unsigned int *bytes_returned)
 {
 	struct hv_pcibus_device *hbus =
@@ -1010,7 +1010,7 @@ static void hv_pci_write_config_compl(void *context, struct pci_response *resp,
  *
  * Return: 0 on success, -errno on failure
  */
-int hv_write_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
+static int hv_write_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
 			  unsigned int block_id)
 {
 	struct hv_pcibus_device *hbus =
@@ -1079,7 +1079,7 @@ int hv_write_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
  *
  * Return: 0 on success, -errno on failure
  */
-int hv_register_block_invalidate(struct pci_dev *pdev, void *context,
+static int hv_register_block_invalidate(struct pci_dev *pdev, void *context,
 				 void (*block_invalidate)(void *context,
 							  u64 block_mask))
 {
-- 
2.22.1

