Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE51310350F
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Nov 2019 08:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfKTHRV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Nov 2019 02:17:21 -0500
Received: from mail-eopbgr720133.outbound.protection.outlook.com ([40.107.72.133]:51631
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727175AbfKTHRU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 02:17:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FljHz+jx7IYOjrcJzrsyXUHsK53gOwq4iIRU8yi8iqhpI0+R0jTPVsPUFAhGZLhWjEIQM6ds4yr0nyJFndNPSd+LjASe+UupzIgX8wVuX2A22KERka4gYtk8NzPTtpcN1IoWDQjsoTmYwo4YZSpkDZd4/RbyqoPrfXk/wimMhce42oJ6g+K88ar0FF/CM6wCNHsOHdw6kQZggTChynn84zj+C5tenWr/Fqh4wyNA0cob1QuoTrQCRNdiyDNECvQ+NC0s2uomWcfOBFla61E4liD0MlGwPj0idIthoq82vsVPpxtceZv3Gr9IcDC2LYKoKG7kYjNMp/UzHI4dDOzp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9IMnM1ZPlUAuAQe0sfSNqTZkAVsThpCLoezmc5eCMI=;
 b=LqfQ4XF4JFaKGg2zP73MT3xrKsxMVTXikqnNqdgMiUZ2atL4NjhTDm2aHCXuD2niB2m66iA9zM8JgvFutUMzLouQNecPhtfCKydujHjf0XolfCk0oE8xI0gWaw9GQ+2HWgDXqQgfL+se/J/WKd/BtfG2/EhtpJI/3PmZr6+PAJ4HFBGiTz/zGT9LXb5BtWa5Ljf/Ac4HXW4sqzbsDERH2o4LiMOfBIb/x2jSLM0jAz9dc3DS8kE8Ho+kjMchUFMQenozV9Yrwrgu4oYxdH7rm0Gt+sYYkmRC3QMISRFMLqF2nY4oRUUJi41GxEdQxifxjkLpRqVyp0qNBEs28nHOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9IMnM1ZPlUAuAQe0sfSNqTZkAVsThpCLoezmc5eCMI=;
 b=fixvOOjYu1CrA2HShnGzkiW4YyziIlY+5oITlxRRIa512cYZjMNO9D9utsVzxlisDQw6+kPVzc6Iw5PBfywrlO0MVDh4RX3GCs7WiyK4hUy1mD1GyeiXlxTjx65jCrNiYforwPT+WySyQ1l6YsdnX+k7htBqln6LrRQeDcpC660=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) by
 BN8PR21MB1251.namprd21.prod.outlook.com (20.179.74.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Wed, 20 Nov 2019 07:17:17 +0000
Received: from BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d]) by BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d%2]) with mapi id 15.20.2495.006; Wed, 20 Nov 2019
 07:17:17 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 1/4] PCI: hv: Reorganize the code in preparation of hibernation
Date:   Tue, 19 Nov 2019 23:16:55 -0800
Message-Id: <1574234218-49195-2-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574234218-49195-1-git-send-email-decui@microsoft.com>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR2001CA0022.namprd20.prod.outlook.com
 (2603:10b6:301:15::32) To BN8PR21MB1137.namprd21.prod.outlook.com
 (2603:10b6:408:71::32)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR2001CA0022.namprd20.prod.outlook.com (2603:10b6:301:15::32) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 20 Nov 2019 07:17:15 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9edbb00b-4c5c-4c30-f389-08d76d89ac8e
X-MS-TrafficTypeDiagnostic: BN8PR21MB1251:|BN8PR21MB1251:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB12515F44FED253B9CF1643BEBF4F0@BN8PR21MB1251.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(10090500001)(36756003)(8936002)(50226002)(81166006)(81156014)(8676002)(14444005)(6436002)(6486002)(1511001)(86362001)(7736002)(2906002)(5660300002)(478600001)(10290500003)(4720700003)(6636002)(3846002)(6116002)(25786009)(3450700001)(66946007)(66556008)(66476007)(305945005)(316002)(386003)(6666004)(4326008)(6506007)(22452003)(26005)(16586007)(186003)(16526019)(107886003)(76176011)(51416003)(52116002)(66066001)(48376002)(47776003)(50466002)(446003)(11346002)(43066004)(956004)(2616005)(476003)(486006)(6512007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1251;H:BN8PR21MB1137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+TOfimj/W705YRii+naDzdZDKyx9GbCSrI407O4rwirYaGLwU8nFxd327/zXLBkEWNqxaj8tSUxyjKsjeCiltnBqyt2eKoAMoD6NhBIxZUKtzHNM5/Cp4wM18jm+09MtZzPYAaDi8eqPXzjEl3hbk0q7PhFXrC9RcOsYxLBtHvunbftALo8oVI64v5hsib5jnKYhgU4NAHInajzF+5IoicU0rk5MCeVZkRrJA8ZR1lmDF7WYNzLEInDOBhzOIElmZLKKYhykbOW3vpgnE2NRQLSK7G4FDzkdum7yOvg1UZh3LYNe6aQaGoJbQYtlWZuAcGF6+3yoykXfMSsBpadcZeXNSA3JTQxrcs0apAg561+XcaVl6dzT9UZ4M5AkEcBgY1sQATmv3KKfc/Tkg8bDcLab7I4jN3gdq9H8SBYxRXamMd66TXo53ArcUIsiCCn
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edbb00b-4c5c-4c30-f389-08d76d89ac8e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 07:17:17.2333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpiukM9nJ+CtOvLojAxotg0zPjHBYdgFxO5v6FEdh9uo18W/xOkxOJjwJj0MULY7lFZKcUniZZXNWCDYs6tScw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1251
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is no functional change. This is just preparatory to a later
patch which adds the hibernation support for the pci-hyperv driver.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

No change in v2.

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

