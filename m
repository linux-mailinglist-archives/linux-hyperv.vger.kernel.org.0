Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590B4108864
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2019 06:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfKYFeu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Nov 2019 00:34:50 -0500
Received: from mail-eopbgr680091.outbound.protection.outlook.com ([40.107.68.91]:28903
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfKYFeu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Nov 2019 00:34:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETa1cVpVZC1TU7kNWt8mRKgv/pCsUGZwRcl+3FdvcaQAaby3gYjBQdDMraq4YsWP0cBQiCmO/rUIXHl/XPR3uhemeFx8xK8etELbiUCfu4gJYFVBTDkDep7okpLxeWxtElDXALidJEaJOAdOB0pjJNTWu1A3IchuMVF1ccbHJV1wD6faqQ61xnbUX0Cb3YZ0JXUmvnfyjWseE9gshDpzWGzidRJ2+q+yG/28Rrh7Vg8ZAgBvJjQuXbV9iza+koscLjFjRxzPjdPySIVnkb+MtjcEt1/SSgQr7rvc3XYo6HW/+6QNMmNCjqLzK8N122gXd69SYG5PZmsoMKI+RcJPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofaxl54vB3/BhWtrNaSdctzkbcMoXSCRWe1yDmN8/N0=;
 b=ciI7b63hPTGDifvm7MxrWkwZz6ADG4k4n9CcZ2NK3SOF0yye1B390A0v0FyK3hFTV1aOUmBHHcBDW+5AeSiMZM2RDItp2rtiXzQogiGgTx4uOXAYqQFkFcy1TN54KtmmMkVGPq3raGvAsFyIpTf0ZQMFguK0O2IXr7a2Xv8i+W2mnvxJTexXtIWXMBgIPInQ+AEjWDtSYjH5qno76KkeiDXWqQwLuYRotvHzB8gBp/FsNEz0yEJ5Wmgd7EChemt4aiAiZ1g5h8+juFCBknvqtnZK7Xugb3tLgw3aGAS3lfZWE+bQndE80uhMYEW8gcPdaNaiptV7mytArizpJBbPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofaxl54vB3/BhWtrNaSdctzkbcMoXSCRWe1yDmN8/N0=;
 b=CFtGevBLFc4SZH+vdF1lx0dV9SWR0BxGhG8HDCfJeBr8/Du7z6oV9bdYPwZt/avX+ui/qcCsf5zGoua5CSFNmK8HtDZ9NyTFu3XtB5VSVG4Uni0OeN61Qzrpip7JSc6t3U5+DvPVPjf7s9PkHLmkSDZf1u9xr2tyn8howSZksqs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BYAPR21MB1141.namprd21.prod.outlook.com (20.179.57.138) by
 BYAPR21MB1189.namprd21.prod.outlook.com (20.179.57.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.1; Mon, 25 Nov 2019 05:34:09 +0000
Received: from BYAPR21MB1141.namprd21.prod.outlook.com
 ([fe80::5d0f:2e49:3464:7c89]) by BYAPR21MB1141.namprd21.prod.outlook.com
 ([fe80::5d0f:2e49:3464:7c89%3]) with mapi id 15.20.2495.014; Mon, 25 Nov 2019
 05:34:09 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 3/4] PCI: hv: Change pci_protocol_version to per-hbus
Date:   Sun, 24 Nov 2019 21:33:53 -0800
Message-Id: <1574660034-98780-4-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574660034-98780-1-git-send-email-decui@microsoft.com>
References: <1574660034-98780-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:300:13d::21) To BYAPR21MB1141.namprd21.prod.outlook.com
 (2603:10b6:a03:108::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR20CA0011.namprd20.prod.outlook.com (2603:10b6:300:13d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 25 Nov 2019 05:34:09 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed358042-5a07-4a38-dddc-08d7716918b1
X-MS-TrafficTypeDiagnostic: BYAPR21MB1189:|BYAPR21MB1189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR21MB1189C941721F1EE61490FD38BF4A0@BYAPR21MB1189.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(366004)(136003)(346002)(189003)(199004)(6116002)(3846002)(4326008)(107886003)(6486002)(6436002)(10090500001)(3450700001)(2906002)(14444005)(50466002)(48376002)(25786009)(6512007)(76176011)(26005)(6506007)(386003)(51416003)(52116002)(66946007)(66556008)(66476007)(6636002)(4720700003)(86362001)(7736002)(186003)(2616005)(956004)(16526019)(36756003)(11346002)(446003)(66066001)(8936002)(8676002)(5660300002)(81156014)(47776003)(81166006)(1511001)(50226002)(10290500003)(478600001)(316002)(305945005)(6666004)(16586007)(43066004)(22452003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1189;H:BYAPR21MB1141.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HI2Z+xHsGezDNApzV9RgWplaJQprpIIQ5KSn3cmf3bcFDre7RI0MrSbZy+LsavP2mW4oafVBiriJdoHqLeyfvEWWe2ql5iucFze/CctRceyNJF9Iq/ECtA5dM/PPHP3IzaTMnouFlDaheEwmuC4dSeQnONarl5A75SntkG6hx5PZtxI6SuUUb+Y1UCaswcjDsDd8Gt/Q0xGlDMB8YoLd9PPusQBR52jKd+Y+6etwtth3Aapxedd5fK2zEI60oDmg5U4t551u4Z+Ml70b+WxeMZesCPjTbc+QaDMSdIokWRkK9zamD4vR2rscpNQCj/v5dNQAsaPIp7s2qwBoDU/stZYeRnIMe3IAPOcRM/XsOdkE8mkKxcJUh+apV0gQiOpMAfIrvuI6i2OxmCcMG+4fYZxMUxuxd19IrSq5sGQceS83QzMxwObLcnuxA7eNBZvR
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed358042-5a07-4a38-dddc-08d7716918b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 05:34:09.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHIfyWYOX3kYYRTvhk80m+44Z0joHNRmdfkZl+/w9/Uj0z6CJyvCW6vFujImdyki2UlgLNY88ZDw0z0AycamPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1189
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 3c4996b073ca..910fa016d095 100644
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
@@ -3200,7 +3198,7 @@ static int hv_pci_resume(struct hv_device *hdev)
 		return ret;
 
 	/* Only use the version that was in use before hibernation. */
-	version[0] = pci_protocol_version;
+	version[0] = hbus->protocol_version;
 	ret = hv_pci_protocol_negotiation(hdev, version, 1);
 	if (ret)
 		goto out;
-- 
2.19.1

