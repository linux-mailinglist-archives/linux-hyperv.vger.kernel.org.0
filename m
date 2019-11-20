Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD851034FB
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Nov 2019 08:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfKTHRZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Nov 2019 02:17:25 -0500
Received: from mail-eopbgr720133.outbound.protection.outlook.com ([40.107.72.133]:51631
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727175AbfKTHRZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 02:17:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Khb9Gno50KEp7+JVEMyrdif5SYPdWDoZPTXXaqC0TCcMfWb4zmYWctD3dVI5XEtb0JJX1y4f41jtz2s8o4eaIBo92WabuvYLV2y3ogrE0MjuzBmS2nGFaJPIjlLMpvHRXTR63z65lMzBhDcKvHL0gZEM3csKChBeJSUgg589yFxhachBPjyFdexPDnuSpH1+ejDxfTSN76t4JrVMksNssVg44JeDsf6aqzA83gwg9SYHWw1DAIlMrKw/lV74p82mhJN4RAV1YoGnJeLHQkhMUgMRGgEqKfB2aLVowVuX8AQmX6C1xsglko5YjxlnWGR+N8ocm04ov7EO7iAn5LwWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cL1RFQTRnF5ayLm4bMmyJ37tBq6H+wHVCPEN/ID/wcI=;
 b=FTqfpDkhsR/YWltWMSuy8WCtPDQvF0Zdch+oQtGEKgT8kgTsQkLoceIM+KBQGPzyUmaJk1z1yx13KDcpfdbjykzITPpRnUiSKrBNV9M5G8v1aGT9wbFOCubDMzQknH6W55IOeO3csRdsV7oE8arktQo9ZP8zOiS49zDsO/1ZZvdBixujDID9vuVMv2+CKLtZxvrRNMkLNgpCwC7YDlolNXSc5zX6xKl3mIMfarV9tLaEb33BSWG/MneIXzWJaCRG5hWWBd6j78g44+hTqV66zjxZ2aX40CWn2VbF2EhDee9z3cxOYtGQOFBrxVNZuOAuCeUc4AgzvAL7aec4vv6Ajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cL1RFQTRnF5ayLm4bMmyJ37tBq6H+wHVCPEN/ID/wcI=;
 b=a4DbWPHbFteg77noxHkLtKneoIbPw2VT6nyyM9XyzGSvS+kKdtCJCYHpz0tSzzTK6KFLj6kaAg6z9NAg6F4XN1u2pDVzhW8GwT5GKVU6VD3Oy7fCCGGDkIhHw9y8HvxhdzoIi+BYEdqY3DFfcle1s+w4kn0/iABizVjr8VtotL0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) by
 BN8PR21MB1251.namprd21.prod.outlook.com (20.179.74.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Wed, 20 Nov 2019 07:17:20 +0000
Received: from BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d]) by BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d%2]) with mapi id 15.20.2495.006; Wed, 20 Nov 2019
 07:17:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 3/4] PCI: hv: Change pci_protocol_version to per-hbus
Date:   Tue, 19 Nov 2019 23:16:57 -0800
Message-Id: <1574234218-49195-4-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574234218-49195-1-git-send-email-decui@microsoft.com>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR2001CA0022.namprd20.prod.outlook.com
 (2603:10b6:301:15::32) To BN8PR21MB1137.namprd21.prod.outlook.com
 (2603:10b6:408:71::32)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR2001CA0022.namprd20.prod.outlook.com (2603:10b6:301:15::32) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 20 Nov 2019 07:17:18 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f33a61fd-a3d4-42d9-12e3-08d76d89ae4a
X-MS-TrafficTypeDiagnostic: BN8PR21MB1251:|BN8PR21MB1251:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB12517457AEC2C3ECA2290539BF4F0@BN8PR21MB1251.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(54534003)(10090500001)(36756003)(8936002)(50226002)(81166006)(81156014)(8676002)(14444005)(6436002)(6486002)(1511001)(86362001)(7736002)(2906002)(5660300002)(478600001)(10290500003)(4720700003)(6636002)(3846002)(6116002)(25786009)(3450700001)(66946007)(66556008)(66476007)(305945005)(316002)(386003)(6666004)(4326008)(6506007)(22452003)(26005)(16586007)(186003)(16526019)(107886003)(76176011)(51416003)(52116002)(66066001)(48376002)(47776003)(50466002)(446003)(11346002)(43066004)(956004)(2616005)(476003)(486006)(6512007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1251;H:BN8PR21MB1137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBXouDfOGn7ho25OxX4R9rHR82YM1/irY1BP+kJ7qTv3BAmtxqAqes3ZlFN1W7sRiUd+roUr+hSdBWsCzYbkCRXQybqu3pRDIIzuCWrM5JPS9NoOydNHcBaPRgKQwlJ1+clyWv55AUJTlD9VObCN07+XYMMzL/PVXZZVHjw2j0Dt54AI0NupWZD9OvMXCOHQRZZ/QuPJcdsblo51zioQOixVlq132/FfKRtP/uJjEDbNVfa0ua1huhG4kYvFsseYbH8NPuhjt44mI+SyzXTb3zevPtAi0TcUToYgqTIt3e2zw4MR9YOv2fGB053qZ1+d388XW4H4Gj06OIZ4yJBSVsR4aVjRSyacQ4LOp02TZIka0axChO0Q5AQ3R5wrDwVP6Ij3c9HYfnOWx7NAvSvAQx3KHYn44bFSEsJuPpCYObw/dWflly+zdARdSDUCNA4L
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33a61fd-a3d4-42d9-12e3-08d76d89ae4a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 07:17:20.1373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bb9iKIMChth9X7o06dg/4VCWeuu+0B++NN5QxhCXwmnqjwUYV9GNxAeWqLrPou+PeBBkc7+HEnhNtdhXYPDFvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1251
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A VM can have multiple Hyper-V hbus. It's incorrect to set the global
variable 'pci_protocol_version' when *every* hbus is initialized in
hv_pci_protocol_negotiation(). This is not an issue in practice since
every hbus should have the same value of hbus->protocol_version, but
we should make the variable per-hbus, so in case we have busses
with different protocol_versions, the driver can still work correctly.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

changes in v2: Improved the changelog by making it clear that this patch
fixes a potential bug if we have busses with different protocol_versions.

 drivers/pci/controller/pci-hyperv.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e71eb6e0bfdd..d7e05d436b5e 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -76,11 +76,6 @@ static enum pci_protocol_version_t pci_protocol_versions[] = {
 	PCI_PROTOCOL_VERSION_1_1,
 };
 
-/*
- * Protocol version negotiated by hv_pci_protocol_negotiation().
- */
-static enum pci_protocol_version_t pci_protocol_version;
-
 #define PCI_CONFIG_MMIO_LENGTH	0x2000
 #define CFG_PAGE_OFFSET 0x1000
 #define CFG_PAGE_SIZE (PCI_CONFIG_MMIO_LENGTH - CFG_PAGE_OFFSET)
@@ -462,6 +457,8 @@ enum hv_pcibus_state {
 
 struct hv_pcibus_device {
 	struct pci_sysdata sysdata;
+	/* Protocol version negotiated with the host */
+	enum pci_protocol_version_t protocol_version;
 	enum hv_pcibus_state state;
 	refcount_t remove_lock;
 	struct hv_device *hdev;
@@ -1225,7 +1222,7 @@ static void hv_irq_unmask(struct irq_data *data)
 	 * negative effect (yet?).
 	 */
 
-	if (pci_protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
+	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
 		/*
 		 * PCI_PROTOCOL_VERSION_1_2 supports the VP_SET version of the
 		 * HVCALL_RETARGET_INTERRUPT hypercall, which also coincides
@@ -1395,7 +1392,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	ctxt.pci_pkt.completion_func = hv_pci_compose_compl;
 	ctxt.pci_pkt.compl_ctxt = &comp;
 
-	switch (pci_protocol_version) {
+	switch (hbus->protocol_version) {
 	case PCI_PROTOCOL_VERSION_1_1:
 		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
 					dest,
@@ -2415,6 +2412,7 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev,
 				       enum pci_protocol_version_t version[],
 				       int num_version)
 {
+	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
 	struct pci_version_request *version_req;
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
@@ -2454,10 +2452,10 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev,
 		}
 
 		if (comp_pkt.completion_status >= 0) {
-			pci_protocol_version = version[i];
+			hbus->protocol_version = version[i];
 			dev_info(&hdev->device,
 				"PCI VMBus probing: Using version %#x\n",
-				pci_protocol_version);
+				hbus->protocol_version);
 			goto exit;
 		}
 
@@ -2741,7 +2739,7 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 	u32 wslot;
 	int ret;
 
-	size_res = (pci_protocol_version < PCI_PROTOCOL_VERSION_1_2)
+	size_res = (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2)
 			? sizeof(*res_assigned) : sizeof(*res_assigned2);
 
 	pkt = kmalloc(sizeof(*pkt) + size_res, GFP_KERNEL);
@@ -2760,7 +2758,7 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 		pkt->completion_func = hv_pci_generic_compl;
 		pkt->compl_ctxt = &comp_pkt;
 
-		if (pci_protocol_version < PCI_PROTOCOL_VERSION_1_2) {
+		if (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2) {
 			res_assigned =
 				(struct pci_resources_assigned *)&pkt->message;
 			res_assigned->message_type.type =
@@ -3182,7 +3180,7 @@ static int hv_pci_resume(struct hv_device *hdev)
 		return ret;
 
 	/* Only use the version that was in use before hibernation. */
-	version[0] = pci_protocol_version;
+	version[0] = hbus->protocol_version;
 	ret = hv_pci_protocol_negotiation(hdev, version, 1);
 	if (ret)
 		goto out;
-- 
2.19.1

