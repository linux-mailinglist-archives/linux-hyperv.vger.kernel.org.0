Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B122E660
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Jul 2020 09:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgG0HSH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Jul 2020 03:18:07 -0400
Received: from mail-eopbgr700113.outbound.protection.outlook.com ([40.107.70.113]:35897
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbgG0HSG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Jul 2020 03:18:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeeBpXItXSUkdM4Vs9srJdUTcmZxLMvGO8N9ljEwr+Vn241RD8OYMA1IAO3KJkxHoADvX/3cIYIHKolVn5X1++Zoo7w3ThkmzNtCvxA65LLaBzkH7a19K4vTk/9iO0+2iA4LjhjIHCBbXIdxodFfp8/ps/PpAepQuetalPO9cGvlLhR/StLDGjrBRaXACglnpKlJQbgy0T0XRU5OBFJXaX8YP5CX7JRm40l0tiQ4irVnQcQZZYETaBDHwN5CaKgxvnITVZf0NWNEsgQVI/sJ0HUenn/ckSrXiRzmURf0pP9PK4PUYK0drWqYtGnCMv2okZQVQs0c2pfqytOGKXjw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/GZD6JNTJJNWbW6z00dvnrhzDaPRcuCVcYeqB+fxLE=;
 b=UTOWtVch1pavKymK2tYugZPuNm9JoPIgC+0DU4jvmH9rdngUkst97AK6EVLzwDa1yub6HKJLwLVtcs5XOEobOVuDaDOGxmC26BkAUBzxwH+jcfRomj2i0ggZ74mCDHigLW9Rh5kpTldXMC/tta9P2xNtc9wshPqn3KYd8xq8veRsJsa7uXJwlWXaXfwKtcBJerQxPBRF7xaBQgnQmKTbtfOu1dpsm0IyMUGTsIm7mzbhtpTc2gJrOgaliC5jgbqLYG4rCxerwgiufjuYewMSLjXda29iZx0sezSiD2MfrOFW7ueK2pEMYKpTXSH5uYSsMVgmD8/+cvlt/FUtBbm+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/GZD6JNTJJNWbW6z00dvnrhzDaPRcuCVcYeqB+fxLE=;
 b=R7Mxj5gKwsm6jAtKYVqMO0n1/wHkF/poHogVHozfKqZG6ClpCnPaA9KreGUZTC7AJ87vJHTjuyf36Ysv8i3YTyD76tReDCZweYblgnQVhjZl/dl7BEuVA7dM3pwOhXdqiauL+I59LpjZUhw6UXWBgZ1yGmCxOW+GAd3mf/YaCRM=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from BN6PR21MB0850.namprd21.prod.outlook.com (2603:10b6:404:9e::16)
 by BN6PR21MB0147.namprd21.prod.outlook.com (2603:10b6:404:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.6; Mon, 27 Jul
 2020 07:18:03 +0000
Received: from BN6PR21MB0850.namprd21.prod.outlook.com
 ([fe80::9812:b8e4:d141:1901]) by BN6PR21MB0850.namprd21.prod.outlook.com
 ([fe80::9812:b8e4:d141:1901%2]) with mapi id 15.20.3239.001; Mon, 27 Jul 2020
 07:18:02 +0000
From:   Wei Hu <weh@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>
Subject: [PATCH v4] PCI: hv: Fix a timing issue which causes kdump to fail occasionally
Date:   Mon, 27 Jul 2020 15:17:31 +0800
Message-Id: <20200727071731.18516-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21)
 To BN6PR21MB0850.namprd21.prod.outlook.com (2603:10b6:404:9e::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (2404:f801:9000:18:99a0:6ae6:2be6:14f5) by SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 07:17:57 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [2404:f801:9000:18:99a0:6ae6:2be6:14f5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6df25a99-0d84-447f-04c1-08d831fd32bc
X-MS-TrafficTypeDiagnostic: BN6PR21MB0147:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR21MB01470D3D4E8C84CFDC79736BBB720@BN6PR21MB0147.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJHlRbvJrsIr5LWKHSlM+cUCeE865SMJkWFXX5QUtKQcHaJ9IJ4vP/N8iXVKAVpqEHw0YZR1FGFqo4GIeq7gZ4wAckx1gO8x9hOADOcXMGZVjjxmG2Oj7RSIGscJgci2FLXrrLrT5FzQEKfjF9lFmZdSd1ZVnYtK90D8DkfORNE44BELfm35rPe6i5dAmLJMxkaUuHzgGerIwKUzuSpqVJAhdhZWA4/FikcUieqB7ZMg+Pa68TkQH+OxaAmaOsLOpE6ofWdkagzvfAlsQv24ovf7OePUjqWIFGpS60O+5dSlw5sM2NHXxDFT3lN43o9n03NMQ23nDpffNSKcqOSBAqrIruBSIuhX4DNii1c6xwL1p/9Esbbc53Jm4piGZy8p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0850.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(6486002)(478600001)(6666004)(2906002)(186003)(6636002)(316002)(1076003)(10290500003)(16526019)(2616005)(3450700001)(107886003)(8676002)(8936002)(4326008)(86362001)(36756003)(66476007)(66556008)(82950400001)(82960400001)(83380400001)(7696005)(52116002)(5660300002)(66946007)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: yeroyiznf7lOEglPlFvdG9RbaRHXRLxqd1+KVLQe++wmOCZXUwN21O8RmrUIxDW1jpwFlgcbYfgwuPCeTiJBYvvKBtZHr6W8R5/ooKyMpYptssA6/wGMQRBsT+C7GCZ1YvewNuGcesv9zfmhaeNEvANHvOkZenmIHEwKYajwJKG6lGoyssAZxt2um5xf03KYnGviNm4m1HZ9OYxJLzQ/a9ZaDW+M84YHCcS/WpTVw4O0xhuN2Ebnhr+rDXq5S7EA7QbuOzSy//tgTcODc+tf1LQ6xfZAOota7+RXycP0c+UDGLja52UuBsubrgZwlHBUnta9BDAGFfKe7n0ksWK6AqNee1P89BXmu6arQJkO9R54TvBmp5xdZ2rNr6Q6mLWUHJfuIOd2+WqX+9VpOmeBGzk8TMkUfRSuW5UMwN4sAbR58kjS9zPXQacVWs8yFYRmPmUyX2NcLw1+gU3DxKcUG3E1ZE2x0YuMbfgXw0V1Px8nDMbWkpK4Db4TXWZJ9Q4XfpX/m5YJXIlq3MaQNy6BMUQdXci8qMqyY1wPYz/5/QlCeHbkwgX7uvU8KBHVVK1biGJ2fP9kCFHyyjY77sWzFh+keZA+VwJctSVS4iSShNXII0ch9FUTeA7JsqD4XZfEokTRoxMCmHQQfJhNQWK/1AeQ4CDpj7iy6PJNSbK4F2ifLRXJNCilo958YwjrMOYIIec7SSC2OQkwV4C4a9wixQ==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df25a99-0d84-447f-04c1-08d831fd32bc
X-MS-Exchange-CrossTenant-AuthSource: BN6PR21MB0850.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 07:18:02.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2c9aDEGLCX9jECvSiPd9VVjUIuiEBZEaka+dcf/NlVMiPHWa4WOkpFRP8LJklDUujUyCEuhOpx6aTyIeLApfDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0147
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Kdump could fail sometime on Hyper-V guest over Accelerated Network
interface. This is because the retry in hv_pci_enter_d0() releases
child device strurctures in hv_pci_bus_exit(). Although there is
a second asynchronous device relations message sending from the host,
if this message arrives guest after hv_send_resource_allocated() is
called, the retry would fail.

Fix the problem by moving retry to hv_pci_probe() and starting retry
from hv_pci_query_relations() call.  This will cause a device relations
message to arrive guest synchronously.  The guest would be able to
rebuild the child device structures before calling
hv_send_resource_allocated().

This problem only happens on Accelerated Network or SRIOV devices as
only such devices currently are attached under vmbus PCI bridge.

Fixes: c81992e7f4aa ("PCI: hv: Retry PCI bus D0 entry on invalid device state")
Signed-off-by: Wei Hu <weh@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
    v2: Adding Fixes tag according to Michael Kelley's review comment.
    v3: Fix couple typos and reword commit message to make it clearer.
    Thanks the comments from Bjorn Helgaas.
    v4: Adding more  problem descritpions in the commit message
    and code upon request from Lorenze Pieralisi.

 drivers/pci/controller/pci-hyperv.c | 71 +++++++++++++++--------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index bf40ff09c99d..d1758986fbc9 100644
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
@@ -3178,11 +3145,47 @@ static int hv_pci_probe(struct hv_device *hdev,
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
+	 * Since the hv_pci_bus_exit() call releases structures
+	 * of all its child devices, we need to start the retry from
+	 * hv_pci_query_relations() call, requesting host to send
+	 * the synchronous child device relations message before this
+	 * information is needed in hv_send_resources_allocated()
+	 * call later .
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

