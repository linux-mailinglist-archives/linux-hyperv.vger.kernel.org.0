Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7CD1C8148
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2020 07:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgEGFDb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 May 2020 01:03:31 -0400
Received: from mail-eopbgr760092.outbound.protection.outlook.com ([40.107.76.92]:22353
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbgEGFDb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 May 2020 01:03:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go0GHRPJjjODy7rYDaELbrn596ysCoRRXlzKbKQdWq8aFvelc+d0a+LkDadAGn9+JA0+DX3WZXt7rI8dYK+Dl1WSNXuUXV4YEXDykIYW/ZikreKb6/ZTuHtemfMf2lXsSv7L76k9k9QB3DVv9dqw4uE14GgjhQhMg4lE4+uXBzkxliRWNcsPLM0c5oj2Om4SewTmLhMrIgKeUNID3DdilxrVCtsF5XUroCU7WBYy26fpRJsmwULst4Uh5I5psG0UExIf2JqNNkwEFH4Wtdm/mJtxggA0ucfsvrcmHzwqcpYlg8yQu6hZUomAr2V0C2uv0wCLiQkmhU/+XwAm4vZHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKFVlzUIW4xVhlfs4E5qk5bCEg1g3RRToHvxtByxeKU=;
 b=a+L70UaxBVsxSVo+WiZEY8l2uU1BDy4aaGF8RYBIj3iOil5SG98l17AeC1rnK1mBjvcGK6hsN7ayIyCVAsK5tfbTeOZsNQFfElH2hnA3M5kCL1TXjYWQJniGTZcs/98mLWo37vpD5Oz+LSa7aQcBnT+rl/Y/qE7kYzoeVt49CYjffXueiv+KdYBbZpVsrPm/3zBcpulEX6KCWBjRw8qfGoF3D4m3/v1HefPMRpeKTcdpYT+gmnrqsxy9Yrdv3yQBphIR5j98fXmEbwKPPRzSnubc7+aX6Nh0+OEyWcW37nnqN7K+GaltVJEkHY7DmRKpb6GuDh5Gd65xBHeAY0JxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKFVlzUIW4xVhlfs4E5qk5bCEg1g3RRToHvxtByxeKU=;
 b=iJA+AxpGiWTrPf8xdEGI1onAX9VIKwNWA+yC7zxbCed3OEktKmz3RnEV3xYfXB/ynt5ARTx63SUI87d4RboxAQW+74fLEfIrjKwlP1IVGTU+dX/GkloDMa1x2g/YcenFasd1dIpz9rAdnTcbSAzh0G6X9fw1HoUyC+GHqiIGJ5w=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com (2603:10b6:805:8::12)
 by SN4PR2101MB1584.namprd21.prod.outlook.com (2603:10b6:803:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.3; Thu, 7 May
 2020 05:03:28 +0000
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55]) by SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55%6]) with mapi id 15.20.3000.004; Thu, 7 May 2020
 05:03:28 +0000
From:   Wei Hu <weh@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 2/2] PCI: hv: Retry PCI bus D0 entry when the first attempt failed with invalid device state
Date:   Thu,  7 May 2020 13:03:00 +0800
Message-Id: <20200507050300.10974-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To SN6PR2101MB1021.namprd21.prod.outlook.com
 (2603:10b6:805:8::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (167.220.255.113) by SG2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:3:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 05:03:24 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [167.220.255.113]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41a8155d-8c26-43c0-7e78-08d7f243fac2
X-MS-TrafficTypeDiagnostic: SN4PR2101MB1584:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR2101MB1584F24C18FBCF112CD328B0BBA50@SN4PR2101MB1584.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTFzUuomV3TsTRGTJ9WUhbgKRKfwAG2sx6p/mrJmRUeAQtoFA5PZn4LRNAOh/yuDU1Av0brp/EjFSFv3oY+RH8lvxrrhfxeq8O2Mieis7Vj04osxUBxxzw/geQeb3GC619jNqBATQvuurBP0utgrQNTTM8cm/G3nmgLcdjGC7QTmf10uPu5zMAz0uxV6bR1aqqA4/e2JelEi8LyL/WlbiEf3g47gIQ1C87jMAQDMDKyVVaLBDs9vbFLZISV5viauBk6TP9I9sSLvTSQ1W5Tj6ySyBllq1bBLJwYHFZ5eRLEDOCcA7DiaCWdYt9XO+j3PBclnUGbJaOAi6rplgZ5++t8j5IclZNCyiBaWB5Tv8tHJyWwvDxLFCtST6fOVYifBXKWH/QUeuZO8w05pTaApeZbJTWkfL5GxXoDBFs7jd7BAy09rgJ/j/5IRSHA5HNycNSCiKukd372k98n95wjTscZSgvYSSCGq4aliJwS1fVZHT4Bn8kh0h8OfWEY5xqzMA+gTw6nFc1r9VcpgKWdUsaDV8RCfax8OcaP2NESTZaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1021.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(33430700001)(82950400001)(5660300002)(2616005)(956004)(478600001)(10290500003)(316002)(1076003)(83300400001)(83280400001)(83320400001)(83310400001)(83290400001)(66946007)(3450700001)(82960400001)(4326008)(6636002)(107886003)(26005)(7696005)(52116002)(36756003)(33440700001)(86362001)(6666004)(66476007)(8676002)(186003)(6486002)(66556008)(2906002)(16526019)(8936002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cBANEynu1zzzef11M3ERjNFrxelnlcXxkHOHex38IiKK4+sHsofeo631xowm9BCjVCARC+HrJd8MPZB94m3pUaoPg6Q+CaxlMcGktMd3X1L/2bzVsQdrEZf6WSs5WXwRZRN/u+75cX+CPRlGxFLf/aeWdUGwNRimB2Yk49LJaZINu6ehkgHFWZxBTZTrKo9ejTCwyHBaS4vAq+HY5RFJo7kXFXc9KaH8svzefDI4Rp4rYfbCh9YMsl7m0dsggL9eTEjr5NsiJmQ0Z8bWbdZFTgHq7+e3/zbtZHOesN4t0Dj92fSGe5gvvyUeugHBBzs6P5LLLmG+5onEQXiYgNsXQzYM9FmqxdJ3/mc9768WNpmo6rIHdwbMbOX5Y+IWerN8iGyjFr4NXnpjIEKHy9Et4ScjmrGQql8uIAvClhB7s77QS7dVF07ICXrkfcdXPTkXr50w7IiLpb6dduZPuHHj++M85fuGTc5ekJUPJydtvitcS+EcyjB/w0nZFiKt+gC9l9nF0Xa1M7G54CZV+WkkSBfH/cZVz6whjtBvNvHn7yeNHGkcfLQu0CLBayVJviKi1KS4GIUozRYUkC/FmLCFmKdgONhplt7lt1/9MR+z+qmusC7dU0+Oq6rXcwKFKWbzvloxL03pANMuCIUWRqkEyigFT+PD201+BYSwN38PRqwouVssj3QIPuYhD+TB5RERegRT120Eeb2JpcEU6QmT85wZlxa0HqdWq5iGl4ASeyo5vG5xUO0IFPk1bh6OPYTqCxmjjdo+72ApuZxykUqwzJC6zIwBeUPa4yvdkrVlpV6w50bHBwWj875M4wFos4wp
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a8155d-8c26-43c0-7e78-08d7f243fac2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 05:03:28.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKOTRcy6upIjrPsp8xmzhmAJtZIFY61HslCGcWSZLr45ChorV6FlW11xorYUq9RDyQnfOsxHYOsbQgdsuNRB7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB1584
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In the case of kdump, the PCI device was not cleanly shut down
before the kdump kernel starts. This causes the initial
attempt of entering D0 state in the kdump kernel to fail with
invalid device state returned from Hyper-V host.
When this happens, explicitly call PCI bus exit and retry to
enter the D0 state.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
    v2: Incorporate review comments from Michael Kelley, Dexuan Cui and
    Bjorn Helgaas

 drivers/pci/controller/pci-hyperv.c | 40 +++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e6fac0187722..92092a47d3af 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2739,6 +2739,8 @@ static void hv_free_config_window(struct hv_pcibus_device *hbus)
 	vmbus_free_mmio(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
 }
 
+static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs);
+
 /**
  * hv_pci_enter_d0() - Bring the "bus" into the D0 power state
  * @hdev:	VMBus's tracking struct for this root PCI bus
@@ -2751,8 +2753,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	struct pci_bus_d0_entry *d0_entry;
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
+	bool retry = true;
 	int ret;
 
+enter_d0_retry:
 	/*
 	 * Tell the host that the bus is ready to use, and moved into the
 	 * powered-on state.  This includes telling the host which region
@@ -2779,6 +2783,38 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	if (ret)
 		goto exit;
 
+	/*
+	 * In certain case (Kdump) the pci device of interest was
+	 * not cleanly shut down and resource is still held on host
+	 * side, the host could return invalid device status.
+	 * We need to explicitly request host to release the resource
+	 * and try to enter D0 again.
+	 */
+	if (comp_pkt.completion_status < 0 && retry) {
+		retry = false;
+
+		dev_err(&hdev->device, "Retrying D0 Entry\n");
+
+		/*
+		 * Hv_pci_bus_exit() calls hv_send_resource_released()
+		 * to free up resources of its child devices.
+		 * In the kdump kernel we need to set the
+		 * wslot_res_allocated to 255 so it scans all child
+		 * devices to release resources allocated in the
+		 * normal kernel before panic happened.
+		 */
+		hbus->wslot_res_allocated = 255;
+
+		ret = hv_pci_bus_exit(hdev, true);
+
+		if (ret == 0) {
+			kfree(pkt);
+			goto enter_d0_retry;
+		}
+		dev_err(&hdev->device,
+			"Retrying D0 failed with ret %d\n", ret);
+	}
+
 	if (comp_pkt.completion_status < 0) {
 		dev_err(&hdev->device,
 			"PCI Pass-through VSP failed D0 Entry with status %x\n",
@@ -3185,7 +3221,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	return ret;
 }
 
-static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
+static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 {
 	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
 	struct {
@@ -3203,7 +3239,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
 	if (hdev->channel->rescind)
 		return 0;
 
-	if (!hibernating) {
+	if (!keep_devs) {
 		/* Delete any children which might still exist. */
 		dr = kzalloc(sizeof(*dr), GFP_KERNEL);
 		if (dr && hv_pci_start_relations_work(hbus, dr))
-- 
2.20.1

