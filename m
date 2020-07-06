Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338802158B7
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jul 2020 15:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgGFNmi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Jul 2020 09:42:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729123AbgGFNmi (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Jul 2020 09:42:38 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6609C6407B0CAE54E335;
        Mon,  6 Jul 2020 21:42:34 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 6 Jul 2020 21:42:24 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH -next] PCI: hv: Make some functions static
Date:   Mon, 6 Jul 2020 21:52:34 +0800
Message-ID: <20200706135234.80758-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

sparse report build warning as follows:

drivers/pci/controller/pci-hyperv.c:941:5: warning:
 symbol 'hv_read_config_block' was not declared. Should it be static?
drivers/pci/controller/pci-hyperv.c:1021:5: warning:
 symbol 'hv_write_config_block' was not declared. Should it be static?
drivers/pci/controller/pci-hyperv.c:1090:5: warning:
 symbol 'hv_register_block_invalidate' was not declared. Should it be static?

Those functions are not used outside of this file, so mark them static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/controller/pci-hyperv.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index bf40ff09c99d..5c496b93cea9 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -938,8 +938,9 @@ static void hv_pci_read_config_compl(void *context, struct pci_response *resp,
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
@@ -1018,8 +1019,8 @@ static void hv_pci_write_config_compl(void *context, struct pci_response *resp,
  *
  * Return: 0 on success, -errno on failure
  */
-int hv_write_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
-			  unsigned int block_id)
+static int hv_write_config_block(struct pci_dev *pdev, void *buf,
+				unsigned int len, unsigned int block_id)
 {
 	struct hv_pcibus_device *hbus =
 		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
@@ -1087,9 +1088,9 @@ int hv_write_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
  *
  * Return: 0 on success, -errno on failure
  */
-int hv_register_block_invalidate(struct pci_dev *pdev, void *context,
-				 void (*block_invalidate)(void *context,
-							  u64 block_mask))
+static int hv_register_block_invalidate(struct pci_dev *pdev, void *context,
+					void (*block_invalidate)(void *context,
+								 u64 block_mask))
 {
 	struct hv_pcibus_device *hbus =
 		container_of(pdev->bus->sysdata, struct hv_pcibus_device,

