Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A1C10885A
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2019 06:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfKYFeN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Nov 2019 00:34:13 -0500
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:7331
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfKYFeN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Nov 2019 00:34:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I70rVeg89pQcqAmiHaDzjj3wprQUU3xUEnp79KIT7mBQuONcu+toK4JhHR1c1KjGD2KVokf+d9i7hVdkhgKv/X9owJgQ1LUoY/WTAF37X8U598Y/zxI61TIWM/l6MZ2p6vtqpDchKTT1C8c72GOihnMQos03GAyj+UETsRLssqq08vjpxQmhBzcxruNQQMPmbL3v2D1ZRlriWaqfJiwx3hR/7VXQi1IGCvPm0mJxYrru/MVM+rQ6w5+a0ggAhXRA0CKATnqPX9B/lGjn3llC2IWA0TqhmbKfc2tobi/3y19IaLxUPNCIzwhxgnnUWS7N/LIhV0pCC7PqrMylkNTtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC3B1muqgKYR4DdYCaiibwt3fQMT9P/hLKxSqPtMBOY=;
 b=DT3xJYaLk6gExpA4lpnGf5o5iQTjkURhtDg2M8BAaGaTCTlqKGseIsSqlVZvDGG/NDbo+snWO3RRb+JEHlHxTK5SJPhhBxBhzLM0jmrgzJkEC1XePH2NgGU4WLKDACDWPF6YAdsbeTCv6bQnLj7sPgRe6tdC7lzFrHivDYR/C6szbyv1lKRpcpIn6kxJJQR1iHMRjw+FIvTWS+iB4Woa9ZQ0kap6rgZNTG7LEqYpeZER5aMA+epU6vqzqHyaVRl8ZSZrra496AJyQTstCHGIKMUTjbg+vWwgo8f1RAhUcb4UKl3s/pJMJ7hvnY0Sj/M2WVab5LD76w7ZlVo9zwwtyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC3B1muqgKYR4DdYCaiibwt3fQMT9P/hLKxSqPtMBOY=;
 b=Mmc2axwnGTNxC8vOfdmVEIHhwFX567QSV627EqP7/46nzjuat8pyg5p5UwcOOLP3Aa8E+IktAMRVc2XiGLperfCaSs6zYexr9zRT+PCSPBWGh39jMMOuL2LhO1iaPBDCV1XD1DNZlIzPrmyIxTTmzql7yP4virRt2DwatHH2G/Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BYAPR21MB1141.namprd21.prod.outlook.com (20.179.57.138) by
 BYAPR21MB1189.namprd21.prod.outlook.com (20.179.57.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.1; Mon, 25 Nov 2019 05:34:08 +0000
Received: from BYAPR21MB1141.namprd21.prod.outlook.com
 ([fe80::5d0f:2e49:3464:7c89]) by BYAPR21MB1141.namprd21.prod.outlook.com
 ([fe80::5d0f:2e49:3464:7c89%3]) with mapi id 15.20.2495.014; Mon, 25 Nov 2019
 05:34:08 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 1/4] PCI: hv: Reorganize the code in preparation of hibernation
Date:   Sun, 24 Nov 2019 21:33:51 -0800
Message-Id: <1574660034-98780-2-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574660034-98780-1-git-send-email-decui@microsoft.com>
References: <1574660034-98780-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:300:13d::21) To BYAPR21MB1141.namprd21.prod.outlook.com
 (2603:10b6:a03:108::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR20CA0011.namprd20.prod.outlook.com (2603:10b6:300:13d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 25 Nov 2019 05:34:07 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fba6987c-47e8-444e-b7c5-08d7716917e5
X-MS-TrafficTypeDiagnostic: BYAPR21MB1189:|BYAPR21MB1189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR21MB1189F357A7D176805ECFDD44BF4A0@BYAPR21MB1189.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(366004)(136003)(346002)(189003)(199004)(6116002)(3846002)(4326008)(107886003)(6486002)(6436002)(10090500001)(3450700001)(2906002)(14444005)(50466002)(48376002)(25786009)(6512007)(76176011)(26005)(6506007)(386003)(51416003)(52116002)(66946007)(66556008)(66476007)(6636002)(4720700003)(86362001)(7736002)(186003)(2616005)(956004)(16526019)(36756003)(11346002)(446003)(66066001)(8936002)(8676002)(5660300002)(81156014)(47776003)(81166006)(1511001)(50226002)(10290500003)(478600001)(316002)(305945005)(6666004)(16586007)(43066004)(22452003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1189;H:BYAPR21MB1141.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JaPC36N20U/JK1VMxBR0yMOSA4wSsIt2O627aawD+297a753FniAZgQZtcMf97iqcIQ0j0qqP34ienMVu9jWFhXroNJ9hspV87DAdW0w3Pn2TXzoj3b47pgx2jyg7dgq4cLA20OByzmoUpI88YuYB96omwOf+pCWl+eH7VQXy514NsIBevBMq1hUXCXiy6fWYb0SlHyw0L1uxGXkMnj7iwt0LEVd8Uos2mngGsQ7bEF6/m8PVU3g9m3g9bWkCdIC1ft4JblISRld9ng82e/coNf261eSGq+2jmJFZufNFzD340UFHcH4xoYCQOAoGs4FyaAc0gAQYQBMR+9lv9+Mj0VNnZrv9dChc5qREV6Vw520THSs4weifJ0Fl13rOfYH7k6AKuhTav7x/eW9doXHCmRwc1mGiN/FGIhbdmgnJSIu24MJV92OQ6y9xWu3Lah0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba6987c-47e8-444e-b7c5-08d7716917e5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 05:34:08.5361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zY31RFQzbXbpTsHOEuRE3921jG7oALHJpviMdnh4f0pYZcg1SEwUz79mipGodj6ZrVhhgHAso4VtkYDOdQ+Nnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1189
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is no functional change. This is just preparatory to a later
patch which adds the hibernation support for the pci-hyperv driver.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 43 +++++++++++++++++++----------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index f1f300218fab..65f18f840ce9 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2379,7 +2379,9 @@ static void hv_pci_onchannelcallback(void *context)
  * failing if the host doesn't support the necessary protocol
  * level.
  */
-static int hv_pci_protocol_negotiation(struct hv_device *hdev)
+static int hv_pci_protocol_negotiation(struct hv_device *hdev,
+				       enum pci_protocol_version_t version[],
+				       int num_version)
 {
 	struct pci_version_request *version_req;
 	struct hv_pci_compl comp_pkt;
@@ -2403,8 +2405,8 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
 	version_req = (struct pci_version_request *)&pkt->message;
 	version_req->message_type.type = PCI_QUERY_PROTOCOL_VERSION;
 
-	for (i = 0; i < ARRAY_SIZE(pci_protocol_versions); i++) {
-		version_req->protocol_version = pci_protocol_versions[i];
+	for (i = 0; i < num_version; i++) {
+		version_req->protocol_version = version[i];
 		ret = vmbus_sendpacket(hdev->channel, version_req,
 				sizeof(struct pci_version_request),
 				(unsigned long)pkt, VM_PKT_DATA_INBAND,
@@ -2420,7 +2422,7 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
 		}
 
 		if (comp_pkt.completion_status >= 0) {
-			pci_protocol_version = pci_protocol_versions[i];
+			pci_protocol_version = version[i];
 			dev_info(&hdev->device,
 				"PCI VMBus probing: Using version %#x\n",
 				pci_protocol_version);
@@ -2930,7 +2932,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 
 	hv_set_drvdata(hdev, hbus);
 
-	ret = hv_pci_protocol_negotiation(hdev);
+	ret = hv_pci_protocol_negotiation(hdev, pci_protocol_versions,
+					  ARRAY_SIZE(pci_protocol_versions));
 	if (ret)
 		goto close;
 
@@ -3011,7 +3014,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	return ret;
 }
 
-static void hv_pci_bus_exit(struct hv_device *hdev)
+static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
 {
 	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
 	struct {
@@ -3027,16 +3030,20 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
 	 * access the per-channel ringbuffer any longer.
 	 */
 	if (hdev->channel->rescind)
-		return;
+		return 0;
 
-	/* Delete any children which might still exist. */
-	memset(&relations, 0, sizeof(relations));
-	hv_pci_devices_present(hbus, &relations);
+	if (!hibernating) {
+		/* Delete any children which might still exist. */
+		memset(&relations, 0, sizeof(relations));
+		hv_pci_devices_present(hbus, &relations);
+	}
 
 	ret = hv_send_resources_released(hdev);
-	if (ret)
+	if (ret) {
 		dev_err(&hdev->device,
 			"Couldn't send resources released packet(s)\n");
+		return ret;
+	}
 
 	memset(&pkt.teardown_packet, 0, sizeof(pkt.teardown_packet));
 	init_completion(&comp_pkt.host_event);
@@ -3049,8 +3056,13 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
 			       (unsigned long)&pkt.teardown_packet,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
-	if (!ret)
-		wait_for_completion_timeout(&comp_pkt.host_event, 10 * HZ);
+	if (ret)
+		return ret;
+
+	if (wait_for_completion_timeout(&comp_pkt.host_event, 10 * HZ) == 0)
+		return -ETIMEDOUT;
+
+	return 0;
 }
 
 /**
@@ -3062,6 +3074,7 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
 static int hv_pci_remove(struct hv_device *hdev)
 {
 	struct hv_pcibus_device *hbus;
+	int ret;
 
 	hbus = hv_get_drvdata(hdev);
 	if (hbus->state == hv_pcibus_installed) {
@@ -3074,7 +3087,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 		hbus->state = hv_pcibus_removed;
 	}
 
-	hv_pci_bus_exit(hdev);
+	ret = hv_pci_bus_exit(hdev, false);
 
 	vmbus_close(hdev->channel);
 
@@ -3091,7 +3104,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 	hv_put_dom_num(hbus->sysdata.domain);
 
 	free_page((unsigned long)hbus);
-	return 0;
+	return ret;
 }
 
 static const struct hv_vmbus_device_id hv_pci_id_table[] = {
-- 
2.19.1

