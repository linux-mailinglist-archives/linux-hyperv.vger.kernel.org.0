Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE77A0D72
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2019 00:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfH1WSv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Aug 2019 18:18:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50184 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfH1WSv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Aug 2019 18:18:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so1655978wml.0;
        Wed, 28 Aug 2019 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAM+t57qqYuwniU8bRaWennUhmMsaEkJJTB53gDhRV0=;
        b=PzPFLhXrn053PrK+Im4s20CBgdlwWdD5vf7c2qvmraHFMtcRNGOax3ZxrfVOJLsNi3
         RJxiH4tXGWBYfSPw6+3I8vtZeTD9tB4tL0CWcferER8wbL3pZmfcEHByNB++kckMWtm1
         II4sQzdAzkx/TuyjLqLbRum/n+kGKqk1HoLpww7xpOX4pesNCxdw87AVciQtgsL0JmzZ
         xmvPJQu0b6mL3cjmfkbnKxZMnd2hgW6BydXPxjMO+te/8BKnN0g44Zl5h0htIrgf01KB
         5ohsIvfvswNN96W6dWfQD6sl2Iq0UoM2C4aBYqAqPzwEO1SQ/4UmYLuhm+PIBFWs/e7p
         L2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EAM+t57qqYuwniU8bRaWennUhmMsaEkJJTB53gDhRV0=;
        b=Shz/4ZIcs2eHXJcpaJQEO9tnJpU9DEZTExq+ZtmeeJzoo8VRUAkPFQcpfAzgE23nn1
         dlOOWo2n+XnFqV+Xl8ZHHiyirXiEICBBa5DwjAl4w3GKKiYoMsVnvmwiJLIgGMA9ER6+
         nokJIZwEAGzSw0RKAMJElivz6/TFKFsfXSv/5OMw91DMHcXpZRSPYXBeY8iNzgh82UsJ
         0tAjQCzkOGpNz9sToXruanMG4CRoVRWlBm7Zu189PKkTMQ/s29q37W/PXnLVWYwCOKUN
         TgSojQVEg40ER5/l39CZW6nVrIHzhlhWhl8kc+vwYf7EIC0kJ9SWYt6Rdrxz4gylcqpr
         IhKA==
X-Gm-Message-State: APjAAAW9TUFMuZULABqMlaH+ZpjkfOrv9s0tWRTZ5mhBI8GdL0B8yzhb
        J6792m8AF3e6k8m3TuWwyUA=
X-Google-Smtp-Source: APXvYqytiyMA527g+v36HgxoxNOILeUCUvgDIlxBt4nYEzP9HjFrZBhYtT/kswy2sO7/NmcFjIJFGg==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr7122619wmh.69.1567030729551;
        Wed, 28 Aug 2019 15:18:49 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id 7sm411012wmj.46.2019.08.28.15.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 15:18:48 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [PATCH v2] PCI: hv: Make functions only used locally static in pci-hyperv.c
Date:   Thu, 29 Aug 2019 00:18:46 +0200
Message-Id: <20190828221846.6672-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190826154159.9005-1-kw@linux.com>
References: <20190826154159.9005-1-kw@linux.com>
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

drivers/pci/controller/pci-hyperv.c:933:5: warning: no previous prototype for ‘hv_read_config_block’ [-Wmissing-prototypes]
 int hv_read_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
     ^
drivers/pci/controller/pci-hyperv.c:1013:5: warning: no previous prototype for ‘hv_write_config_block’ [-Wmissing-prototypes]
 int hv_write_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
     ^
drivers/pci/controller/pci-hyperv.c:1082:5: warning: no previous prototype for ‘hv_register_block_invalidate’ [-Wmissing-prototypes]
 int hv_register_block_invalidate(struct pci_dev *pdev, void *context,
     ^
Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Changes in v2:
  Update commit message to include compiler warning.

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

