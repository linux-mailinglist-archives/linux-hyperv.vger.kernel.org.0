Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABC0223156
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jul 2020 04:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgGQC4C (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Jul 2020 22:56:02 -0400
Received: from mail-dm6nam11on2091.outbound.protection.outlook.com ([40.107.223.91]:11406
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbgGQC4B (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Jul 2020 22:56:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw7pfi3TE/qQYWWKmOZEjPwwtdTb55JjtXw/Z7mbLM1O/6TFjfXMqwo3T8L+keRApTjXx+02cigAOYvwDFsZF9+myF12fC1oNjqPixTIuFWAOnLAWQ9KgByDzHpZmgW9ePRU98c1efxfweH3Yy9ngMxDUmmB92BfRVaWpvhFW7ky5VjlUo6jNIq1RtjH/XwJuxcOCKAxJt8E5VGY91e0cUYkqf9M8qr2uXBWePYvVlIfj7lFcOacQTXbW8LqNto3l5oHpPl9Gr/34yEr6rmmb3HzJG8Mfu75QnRzC8aZ8uuM5r65RlC44sCoQLYsI3V0vNiEYlmXCVvl4x/j0GSV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nmpg+JY3kXvwbKSDdltvUbENdrOiuXRFGXUY44RC4SY=;
 b=maYIiN7fm8Z7/d92JO5Bmhr/nJaprdxsAfNicLQO5H9mCmKvlJGl2jom7Uh1J1nJF/lIYd9KjR96Fv7tcVlWhSYdfGcXH3E+cnPtSoSbJ8FAIk1JPtpUrKfZ1O8XZZDDLReyPK1AgwXYVuPVNS1Gz539MZBknHcERM/fXLXy7QUDFcZYNgbQK4FDkJPeISbZtBQIa8Dqj91FSPUmW65umz6JT6jSbzLUxw6FKh1hFRA5B2iHp69lIRkML6oVhqSekSHOEF+FzQSDYNKn+gcmj32JWTWJs8azTRxUj98umCG9lMfZbrQRziUHdOpyTE/jH/mfZtANWS/y1ORnHFmuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nmpg+JY3kXvwbKSDdltvUbENdrOiuXRFGXUY44RC4SY=;
 b=eq8VzSgRS9/TbEZj57RvQ9OXnZTNJHZEE366Tl30Eoucjrp8QeKdW7+o2l0W6EvRRPK0bqx39S+cbHmlP8SzrdOZfAbXsvOHbOFYzwybHoniLaxQtI14o8E1rrn6avBZ5UoKll9JpEbEs4aYt/X+jYVunDLqGKBq23vLYD8qF0o=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM5PR21MB0794.namprd21.prod.outlook.com (2603:10b6:3:128::10)
 by DM6PR21MB1226.namprd21.prod.outlook.com (2603:10b6:5:168::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.5; Fri, 17 Jul
 2020 02:55:58 +0000
Received: from DM5PR21MB0794.namprd21.prod.outlook.com
 ([fe80::117f:a11e:9ab3:fa68]) by DM5PR21MB0794.namprd21.prod.outlook.com
 ([fe80::117f:a11e:9ab3:fa68%14]) with mapi id 15.20.3195.017; Fri, 17 Jul
 2020 02:55:58 +0000
From:   Wei Hu <weh@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>
Subject: [PATCH v2] PCI: hv: Fix a timing issue which causes kdump to fail occasionally
Date:   Fri, 17 Jul 2020 10:55:28 +0800
Message-Id: <20200717025528.3093-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::16)
 To DM5PR21MB0794.namprd21.prod.outlook.com (2603:10b6:3:128::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (2404:f801:9000:1a:3aaa:a033:18c:56f5) by SGBP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 02:55:54 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [2404:f801:9000:1a:3aaa:a033:18c:56f5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 53019e61-698e-4d1d-1e7e-08d829fcee81
X-MS-TrafficTypeDiagnostic: DM6PR21MB1226:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB1226CEAA9B6B780ABC909E9CBB7C0@DM6PR21MB1226.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbJCJPmYTwaQ0Ly+0uMoH2grZgO3AHXcpi0WRY6W/THaZbLPNVeaiJqCgYOs9qXXdYg9xZoB5J31qMB1PvEV/OGXXunDHT5Ndxy76Xd7uEgHyB7YIQBliJkol3oDeWQd9QYY2dnADp7xNlIckK6tIYLhVbEmyn5m69gWXb0Xemzkz/2WzKtFv1LKJbO/pTt5fN6J0Nl5KkAQw5+Mll6xzDBhUzUPnFvzOuSuSnaOWDpC/RnmuMiBNGgMFwcZwW+o65bb5b8Im/LG4PWivJ5YX5BryWCcnsJBQDneFLxuTdZXJVa0tztl/FC2Tb14JTM3aMRawDJFpf3KGo+YkwV4/J3ukY4HAh2aLFCGF7OihslgeuA6IBUtUayncRCUU17k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR21MB0794.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(16526019)(8676002)(478600001)(2616005)(1076003)(5660300002)(66476007)(66946007)(6666004)(4326008)(66556008)(8936002)(52116002)(6636002)(7696005)(6486002)(186003)(316002)(107886003)(36756003)(10290500003)(2906002)(82960400001)(86362001)(82950400001)(83380400001)(3450700001)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: oPtui8H9h5usQJHgwB4PNeta4SKxIV6NWQPRcZSO9u1l545ZTOlQqQNKbgUkYSPdvQM8HgNSv2K7AIMlvvK5/z+/91ZT4ktSQrqeDeFOR+3qz8OFS3ZEr4gnzWpm4XAVvRTo+42kxers/VaZFbstVpr5FAnHT5lZkyQ68YRrtFb/9vuLgGUj+Z7X3xqNgEXdtNo0YW5vZBkDv0fkBpv82TVNTpICLA/fEOUwOk01+5WUXOjK2KGPBIopMGqGvWCUhMmZz109HYBX2Sxb3j7LaWlEB8UkvmBSJ2nE3QUMmIUBZJpRC4RsjSNV1zcH1ZIaVxGfoX/Bad7xM2dcgJgv/zi7tmoZ11mYwk9YxaYpBn8RM1giSuNYCZuxO0wF3A9brktIYzGWMMWbvwS1YCYq1+jVZK3MY5PBW0d47tcU90TRNXVtQit2w5gaWgT8BV8zOlMX6SLyaw9F4FgYtMZhZIZcHMmoy2kvP+HcHx22SA2oo8ZU30a0c6VAphx1QmzpQHmQQjXrxr45vARoeCoam3OZh94eTLiZeEmHwOyuSis=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53019e61-698e-4d1d-1e7e-08d829fcee81
X-MS-Exchange-CrossTenant-AuthSource: DM5PR21MB0794.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 02:55:58.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEfU2VEsAbtncQvRl96+jKzUh+9xp6BvzCxK+wH9CiUbiSLaXHkpaJ45MEoPQYWraZ2u9DUYTWC2/hCVV/UAsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1226
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

v2: Adding Fixes tag according to Michael Kelley's review comment.

Fixes: c81992e7f4aa ("PCI: hv: Retry PCI bus D0 entry on invalid device state")
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

