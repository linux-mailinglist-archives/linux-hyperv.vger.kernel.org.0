Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE732227D7
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jul 2020 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgGPPwC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Jul 2020 11:52:02 -0400
Received: from mail-co1nam11on2123.outbound.protection.outlook.com ([40.107.220.123]:52417
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728126AbgGPPwB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Jul 2020 11:52:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQEr0SjtyrGPbn/xg0kVPNT/te1MJosS1CSsIvlhFJZMibQN3IKgYbhIIm04PPEd2I6dpEyZJLA5xhzKS6ucLmHYsD1seZi9J5j7oRYXMnCySjuPLHHT15DNhKmNM4X44qw5dsJsRqLor+H9M3vXr3men5AtJCAxnOe8YlVZgvO+PTgr1LGnyFEqSlehs+PQEamm0fNOpPX2EdX8q5skt0XY04/s17eors6lSDZXFi+2rWFqKLIkoSomamFYWpCY/DbMjM0XFMYaia7STzHcOYT0mDY2oO9naIUXkmSIBZnZvBmJl5W3KGPEbZo7qKwzI6O8n2NZ24fvUmbJWzWdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnLZBHRzckLDdsbLr7KdJq9VJR4GAwt131RcspXcyNM=;
 b=XvlyizN9JeHYJOBuhpCSg/QR2ElM35Wy8oIRVB0RG5jD0/pqWtjvy8fpe4VcPAgkpr1vZui6OSR4BfSDGT9HhsFXP8mURdRIqpBsXleTAP63BBMvOHQAhw/pi/4jvQDaLQ4cUyOJ62MLfHg4tK+anZFLD+BIiuxdJ5evf1oPy350kCeUwBiD9sbXp1qYQDX5ZSeHwIHLq9RPSE3GDz2K9pnJEep8GyrayclGN13lfuG5nKaxdHzhA/sUIV0Xslj9srr0+0yM4nhWVIBkTKxupZ1QakCgwnAmTy35dYETUc6DzIBso3+SAzOvJLPt3ufKSoEHt777cdyj5+Q/j3Gihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnLZBHRzckLDdsbLr7KdJq9VJR4GAwt131RcspXcyNM=;
 b=Bl0pz34/yenAoNOn/zN0w/R8OlKcwmQfu0t2jUW/UTDvozhdk9BdqP2XOsvVX1LFpFPsNV7SXMSISs3VwbCDv7rBfw0jpodaaWu75At3owtM9/9P7wwU1lNFlCJFvNbIhY6XXgU9k+DaLJ7UEWvWUJNdUmgxKgKiXUH3s18s6ss=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM5PR21MB0794.namprd21.prod.outlook.com (2603:10b6:3:128::10)
 by DM5PR21MB0778.namprd21.prod.outlook.com (2603:10b6:3:a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.4; Thu, 16 Jul
 2020 15:51:58 +0000
Received: from DM5PR21MB0794.namprd21.prod.outlook.com
 ([fe80::117f:a11e:9ab3:fa68]) by DM5PR21MB0794.namprd21.prod.outlook.com
 ([fe80::117f:a11e:9ab3:fa68%14]) with mapi id 15.20.3195.017; Thu, 16 Jul
 2020 15:51:58 +0000
From:   Wei Hu <weh@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>
Subject: [PATCH] PCI: hv: Fix a timing issue which causes kdump to fail occasionally
Date:   Thu, 16 Jul 2020 23:51:28 +0800
Message-Id: <20200716155128.2038-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To DM5PR21MB0794.namprd21.prod.outlook.com
 (2603:10b6:3:128::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (2404:f801:9000:1a:3aaa:a033:18c:56f5) by SG2PR03CA0116.apcprd03.prod.outlook.com (2603:1096:4:91::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend Transport; Thu, 16 Jul 2020 15:51:53 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [2404:f801:9000:1a:3aaa:a033:18c:56f5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 161ddd6c-82cf-4dfb-1dc4-08d829a02baa
X-MS-TrafficTypeDiagnostic: DM5PR21MB0778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR21MB07784EE82B7B42FCDE243A6FBB7F0@DM5PR21MB0778.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UA4NsmfDo73RiiTbDpzsmtdowiHUZaZRsJjbdK3raMvbMY8ZecnyV++1M6Y5IyfXDKoH260vJ+YdcTEwTizyq2IOaHuRVMd2g/wxJGIjSonvEeNTrmG87zDfNcX+TGcsYwqDwbJ+pG4gsXKQvhryxm3gamYTln7J7KCQAKq9/0/pzIPAYGylg6C34B4QwLFGanwv5PPjKIUIZS/rv3JSxhFTO15U+MG4GSVKIeg5ympFqd1lNEmm5Gdu7SkKJOtOKXlUoLBzCIW7ICLb9tzOdw17OHPS5MoZrtz0/atnM1OxhaHrKoUO3tUxkKxaaDkxFPyHbkvv3rRiFkfuXQq5Y2juuaQYX47ZGsp0K/6TQ66y1HNjeUNH9RUyD3gTgUve
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR21MB0794.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(107886003)(6486002)(2616005)(86362001)(478600001)(66556008)(66476007)(1076003)(66946007)(6636002)(5660300002)(3450700001)(8936002)(2906002)(8676002)(4326008)(10290500003)(316002)(16526019)(82960400001)(82950400001)(186003)(83380400001)(52116002)(7696005)(6666004)(36756003)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: d1DPj41hQSUdFDkP2frBLpmODWY5xShzLMwEvjd0nf7zNdSbgzv6NllW/2Jn9btF3TvolBAuFZMWaLEmW0pDP8MvuIqmWC3dCyL6NEF5+Jh0XfN/l2T6E6IB2tv1HdTVjlfPP0rhuRKLYE2PoIFcTqj+cS5A0WhtuWOYQObgsq2hp+KnL9XZhRBhdez5OBxp22up5WpO2BxCSCBuT1Sj3v2j9bwmRT7ypffSDQi2kkmD9qD3Lae7aGXQ6/XHCYgx3hGAfDvf8CdbEbm11ex0Y8M4W+xbzumdUKV4IRj+zX/wk1DJYEkO5DEEyaONvjGc5VpWm6BryeYE4XLDr4UOq1YX45y00cCL/XCpBeN05Yjm/yOiEECvAV7X2hpFGNyd85VyVrKbIrIOe89LSMpRU9hhtGyw/e9w4xpf/5n9sPdhsg3L/IJuR3dCYVphsdMBb84URtFq2qtkBn9VBW7Qk/ndykvLNQ+CWc8+xmO7sQ2kJZ5dyljng/3A0nmSq2/WMOptrna6cEASap2SM1HIXZL81+D6dVXy3vsgyb1n6eM=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161ddd6c-82cf-4dfb-1dc4-08d829a02baa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR21MB0794.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 15:51:58.6226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoKc1l4U00OFdpZtdX+cI7rXyauTilxEpcSQZHHt4n9W7o22fvUJ6NXYGoRvIp43aGxF2ZtHldz+gcJ+FHbCCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0778
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Kdump could fail sometime on HyperV guest over Accerlated Network
interface. This is because the retry in hv_pci_enter_d0() relies on
an asynchronous host event to arrive guest before calling
hv_send_resources_allocated(). This fixes the problem by moving retry
to hv_pci_probe(), removing this dependence and making the calling
sequence synchronous.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 66 ++++++++++++++---------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index bf40ff09c99d..738ee30f3334 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2759,10 +2759,8 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	struct pci_bus_d0_entry *d0_entry;
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
-	bool retry = true;
 	int ret;
 
-enter_d0_retry:
 	/*
 	 * Tell the host that the bus is ready to use, and moved into the
 	 * powered-on state.  This includes telling the host which region
@@ -2789,38 +2787,6 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	if (ret)
 		goto exit;
 
-	/*
-	 * In certain case (Kdump) the pci device of interest was
-	 * not cleanly shut down and resource is still held on host
-	 * side, the host could return invalid device status.
-	 * We need to explicitly request host to release the resource
-	 * and try to enter D0 again.
-	 */
-	if (comp_pkt.completion_status < 0 && retry) {
-		retry = false;
-
-		dev_err(&hdev->device, "Retrying D0 Entry\n");
-
-		/*
-		 * Hv_pci_bus_exit() calls hv_send_resource_released()
-		 * to free up resources of its child devices.
-		 * In the kdump kernel we need to set the
-		 * wslot_res_allocated to 255 so it scans all child
-		 * devices to release resources allocated in the
-		 * normal kernel before panic happened.
-		 */
-		hbus->wslot_res_allocated = 255;
-
-		ret = hv_pci_bus_exit(hdev, true);
-
-		if (ret == 0) {
-			kfree(pkt);
-			goto enter_d0_retry;
-		}
-		dev_err(&hdev->device,
-			"Retrying D0 failed with ret %d\n", ret);
-	}
-
 	if (comp_pkt.completion_status < 0) {
 		dev_err(&hdev->device,
 			"PCI Pass-through VSP failed D0 Entry with status %x\n",
@@ -3058,6 +3024,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	struct hv_pcibus_device *hbus;
 	u16 dom_req, dom;
 	char *name;
+	bool enter_d0_retry = true;
 	int ret;
 
 	/*
@@ -3178,11 +3145,42 @@ static int hv_pci_probe(struct hv_device *hdev,
 	if (ret)
 		goto free_fwnode;
 
+retry:
 	ret = hv_pci_query_relations(hdev);
 	if (ret)
 		goto free_irq_domain;
 
 	ret = hv_pci_enter_d0(hdev);
+	/*
+	 * In certain case (Kdump) the pci device of interest was
+	 * not cleanly shut down and resource is still held on host
+	 * side, the host could return invalid device status.
+	 * We need to explicitly request host to release the resource
+	 * and try to enter D0 again.
+	 * The retry should start from hv_pci_query_relations() call.
+	 */
+	if (ret == -EPROTO && enter_d0_retry) {
+		enter_d0_retry = false;
+
+		dev_err(&hdev->device, "Retrying D0 Entry\n");
+
+		/*
+		 * Hv_pci_bus_exit() calls hv_send_resources_released()
+		 * to free up resources of its child devices.
+		 * In the kdump kernel we need to set the
+		 * wslot_res_allocated to 255 so it scans all child
+		 * devices to release resources allocated in the
+		 * normal kernel before panic happened.
+		 */
+		hbus->wslot_res_allocated = 255;
+		ret = hv_pci_bus_exit(hdev, true);
+
+		if (ret == 0)
+			goto retry;
+
+		dev_err(&hdev->device,
+			"Retrying D0 failed with ret %d\n", ret);
+	}
 	if (ret)
 		goto free_irq_domain;
 
-- 
2.20.1

