Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2E22485A
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Jul 2020 05:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgGRDse (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Jul 2020 23:48:34 -0400
Received: from mail-dm6nam10on2116.outbound.protection.outlook.com ([40.107.93.116]:37569
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726923AbgGRDse (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Jul 2020 23:48:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4YfJSI65j8pfWFIN4aYSqDAfwEmYX1EKWZh838KHlBlE8/N9nlhlrI7gXAsllQKcBfzvbijIfh+fGOvdv//qDnxgo/AkH53Uw2siYbsq451WJuiZpZpBwZ/EdkJ6/3UEFx3aSVgQ/QDvBQ81CqV52NDC2LbZVSzMNnPqQrVK0n4/i3IN/KBqlyqH+DTvtQhmSd9sNDVXs+LxZzUQiiXlrXlrumEOXoLXC6VsNMXk5lGS2BUm/dAP1N5GV2v8nx+lv9GmCuCJPz+i7/h6SzZambyST6NarDFFJuxNwnGSCjyvoUSS4eyiAZvMoshekriJcqnZ6GTFX2PIZONKlZVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwVbh2Ja2kP62/gLggUlkJwF1U9iBhfd15JKGBOQKuA=;
 b=a8WcKXwnfV1N4j5w7o9ph5+PYLfXXkcKp8dYZCT2gvGigttzwWuzA+mzEpD8/C9nQvxl+39dOw4cbDKtRE/pKgRKvOFiKO+UKUYrKloYVxlPzjyd1vE1tGwbU/PhSxJ46Mw6TbiEH3AdFXpSND/ygPauBVk7LHZ6xjfO3L8Ik7ykfWMEdzR60noKtSKiZ5pp93jkUqRe9VVME+m6sqU6IuZmzeMohTcqaJ+qZ9m+nHOvLHhH9x/P1MKDZnJfRw7Ry1n9je/GHiFPrP5nnvQ9FMBdkx6lCHBnXNh4PYJ+SFJjz92YKLYsAsmIDdT4PWrUTPmoswqfMFuu9BD/5/nneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwVbh2Ja2kP62/gLggUlkJwF1U9iBhfd15JKGBOQKuA=;
 b=UxF+UEwQ+ies0Hulou14WJGkf2e4n1eVnK+PbhTwYQDW0UxOAIiTeas2tbAKzqA/grfeD9YCI6CNqREsH99E3cAo6DdNL/Ju7MXWnIlbE9yvFewlm52NCY+wOZ3nUh0sH5aFU1rI1EU0JuxoS+faFzcdg4EV2hhvq2iz/jo4xRA=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM5PR21MB0794.namprd21.prod.outlook.com (2603:10b6:3:128::10)
 by DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.13; Sat, 18 Jul
 2020 03:48:31 +0000
Received: from DM5PR21MB0794.namprd21.prod.outlook.com
 ([fe80::117f:a11e:9ab3:fa68]) by DM5PR21MB0794.namprd21.prod.outlook.com
 ([fe80::117f:a11e:9ab3:fa68%14]) with mapi id 15.20.3195.017; Sat, 18 Jul
 2020 03:48:31 +0000
From:   Wei Hu <weh@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>
Subject: [PATCH v3] PCI: hv: Fix a timing issue which causes kdump to fail occasionally
Date:   Sat, 18 Jul 2020 11:47:52 +0800
Message-Id: <20200718034752.4843-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To DM5PR21MB0794.namprd21.prod.outlook.com
 (2603:10b6:3:128::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (2404:f801:9000:18:b45:b63d:6fdf:5ce) by SG2PR02CA0001.apcprd02.prod.outlook.com (2603:1096:3:17::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Sat, 18 Jul 2020 03:48:26 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [2404:f801:9000:18:b45:b63d:6fdf:5ce]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38682bc3-7b76-4f86-d30b-08d82acd6fe3
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB10471FF6AE1519A321C55822BB7D0@DM5PR2101MB1047.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNIdOf3fSu8PJvQ5nCAnk5Nf1ybJwcg+JHNtL1cTZRnkKivZcnKpI0Cw2+NPzBsOH17EGEi6ge3LrAZavoXrmicGFXBmuzYxdrHL8bwJ00uVhmTTxpPYI+Dbekz24NVb8dKPp/cE0YEzo5EZAXcuU2otVag6qMbWvnTIwxfPU/+q0Rm7a/DWX5SXDpvFazlFnV6Q78nytqa29V92k9O7zPDbAfm95DWmObJmLXgaOgbybU3727+yAkfu3xUNZqYGE2Vlrj+kSKJ+C/+q6ti5AoP3CNBqjaQHaauz69AA30HaKtIQ+eLFwzw8eN7Kd2DwTJbp2as9DPyFDB54kKMQYj8NrpBMZA76AVHhx+wrvaRPeDxgsQft6Yy5HVlI2pkx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR21MB0794.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(16526019)(5660300002)(2616005)(3450700001)(316002)(10290500003)(66946007)(86362001)(6666004)(36756003)(66476007)(107886003)(52116002)(6486002)(7696005)(66556008)(82960400001)(6636002)(186003)(4326008)(478600001)(1076003)(2906002)(8676002)(82950400001)(83380400001)(8936002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: sHmGzdjsubUlgYqyFV57P2gXKyzBbVP3nGyg0zNbrp/jqRbw+0dITT49MdZDfzzU7uK8NINwrDQmn5yQW5zSYsC97qJNeWfLBMOinvWypxntfwQhoULgIwS9qjm5hFMdK/YbH4BNoNvs0tAwHqVf0yehVW4ajIAic9xOOXHosQ4AuXJVWuN5J8+XyFWI80fR3KBUKlfERvXwFDqquaGwO25Qs+moNBcYnbqUPT71VtCylEHbCeUhs/plPiDg2OA9Jp1Pzfe94w4d6ePAJWqxATYYLT42syRQ4dlT7ThSMkeuld6b/u/cUUxHyYPv3Rzn4psg9kihFMsmJySywRzqnsDeDKlYozsd6kIx0GGLwJqtqP6jGe9xu+uTo139eGXsp3026YYaGGH7GB2hbLg2nS4vkBlk2yokC6eTKP5Xif54meColizEd7in7HhZrLUSEEr7ZdGmiM04vcc9Ckx/wpl1XPdcQn/ZkwmZCm2P2Y73z23xfso2PkDxbDJI2PMHFgbwq2++effza/jvl68Ctt5y32ZJsrGhOse2JBE2M48=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38682bc3-7b76-4f86-d30b-08d82acd6fe3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR21MB0794.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2020 03:48:31.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG4X4zkMlvKoa1oEVIF/hIu6YRyHUFX5jruioYglTrUU3Uq+o8y7Vcl5fEAu5X5CWmI3e00UrCY8n3+Cola8dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Kdump could fail sometime on Hyper-V guest over Accelerated Network
interface. This is because the retry in hv_pci_enter_d0() relies on
an asynchronous host event arriving before the guest calls
hv_send_resources_allocated(). Fix the problem by moving retry
to hv_pci_probe(), removing this dependency and making the calling
sequence synchronous.

Fixes: c81992e7f4aa ("PCI: hv: Retry PCI bus D0 entry on invalid device state")
Signed-off-by: Wei Hu <weh@microsoft.com>
---
    v2: Adding Fixes tag according to Michael Kelley's review comment.
    v3: Fix couple typos and reword commit message to make it clearer.
    Thanks the comments from Bjorn Helgaas.

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

