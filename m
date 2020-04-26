Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9E1B9098
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Apr 2020 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgDZNZa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Apr 2020 09:25:30 -0400
Received: from mail-eopbgr680111.outbound.protection.outlook.com ([40.107.68.111]:6369
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbgDZNZa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Apr 2020 09:25:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bw48v9j53O5yU0H9xEWQK1Ni1Kab5UZTadTOdx/7nzVa9X1Awz7CeQSIBDvETqCEhyKCdZMzjgTs/97JDNCstunblTKtoEJX0zCxCkt1O/WHP2CH7zjuh+wCnMYvZKt65eqrlizuL08icBtz6ZxmXRbiFWvV1JIWgwIFpZu+B8E0ZBSjTEsGA8knvQLZCsOg71Ot0KLSscs7ptAVJkNpCQzcTwnqAF5g3eUZ+WdRXNyVyzeiH3vSAuHQJ3yqh1/4UICMEROlcbWZfpChopkT5A9Tvp6x/h1szvAqX2PzvwVVaT32Q2gscgjaUiO4rHaRASDP9Wh869q2eFvbsrLq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzKdqpDtC3WhYGrH/yeHCe4XyUQu6d6dGlB6xrEz+1E=;
 b=W2cKYd73NC47BU9FpdAYp+LOgQTUlMAvNWNA6eioTT3TC223AUPNEXe9ok9fKXAcLkE/6uAonDoYw9Wt8hy7dG2E6J37RWTlqu6sfU4p+iaxeNR0hIACTOyciN3S4YbYvHRn/B93UHM9+CUEmvqMlB0xFZqW8Wcdzofa31vA5+DxlgpFR2oGcduRZ5mhR6jWT+rtMHdLsLmZpy3VOljIRjta59P4LT8c0m5tzeNCykt0h8xYhTF+bZLXc+wUESB0FV+BAEC85j3+z48wndC6nd8MnGu7q8bl/EOgZV61/nZRa9R5QUP2W7idGJwju9/CDMUBYIPJQskp2QzWlgovOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzKdqpDtC3WhYGrH/yeHCe4XyUQu6d6dGlB6xrEz+1E=;
 b=P1s4kzxOmXrwW6b2Qt1ReCyNeawGsp7FCYgJ5sUUAHbjAsyPOny4EyspjsX9aJ1M13Wx43+WVJBOHY/bx5XDGZCasPVuQbYKmnonFPDg6LG4p3Ai3Rgf5OhaWAX63zbRVb4IeWxXL6mi/AoCo8TaFrmQU6kbqQaGXfrVhqm4ai8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com (2603:10b6:805:8::12)
 by SN6PR2101MB1053.namprd21.prod.outlook.com (2603:10b6:805:6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.3; Sun, 26 Apr
 2020 13:25:26 +0000
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55]) by SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55%5]) with mapi id 15.20.2958.014; Sun, 26 Apr 2020
 13:25:26 +0000
From:   Wei Hu <weh@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>
Subject: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first attempt failed with invalid device state 0xC0000184.
Date:   Sun, 26 Apr 2020 21:24:30 +0800
Message-Id: <20200426132430.1756-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0188.apcprd06.prod.outlook.com (2603:1096:4:1::20)
 To SN6PR2101MB1021.namprd21.prod.outlook.com (2603:10b6:805:8::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (167.220.255.49) by SG2PR06CA0188.apcprd06.prod.outlook.com (2603:1096:4:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 13:25:22 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [167.220.255.49]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d41bf8e-018b-49ff-20e7-08d7e9e5480d
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1053:|SN6PR2101MB1053:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR2101MB1053E71B2FA20FF8785A342ABBAE0@SN6PR2101MB1053.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1021.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(1076003)(3450700001)(81156014)(10290500003)(6486002)(186003)(8676002)(8936002)(956004)(16526019)(478600001)(66556008)(66476007)(66946007)(4326008)(26005)(86362001)(36756003)(82950400001)(6666004)(2906002)(316002)(5660300002)(6636002)(7696005)(2616005)(52116002)(82960400001)(107886003)(921003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkS8Dk9q2hqVyRrvIbFEiwCRC1X1t0P7VdN0zNE1v82a87oRiGcGT+PoLEmc4OCoMskL4MW7TquouR4GklfT2DD4HP1BILSO3L/MhpWOm1gZLnoQSfOlIkSA2fjmF4AwpUD/jSVl5KoybSyYkD3bE8prAgapTVKxLh4uBKuaoqkXhLiLQV9pte5FxVuzetGxzsim60JUoH2lChF1OLaY3BimMW+WjVtoQcpm9GvZDeLfuNAQcxcGNlF4r0JM7gx2//ftN0uXdTTgXlYwJxHWiMwIW7tdQA3HpND6PZX5P8XX4BfB7DWoyIbdekoZPN2ymek5XH/o+DPE+SPkbw0kpTEna75nj+LaCemDoCe9X+F6be9alo4b/E3Cs2r/XuSpJ06DGV2C44B5/gNYucXH6hI05uGoWKN5tEqTgp3AIQKizlj1/IwnjkEQCo41NZ9PV53L+crJpdYk2o0JTz+NjEFn/2q4M9YNQRMXVvk1t90=
X-MS-Exchange-AntiSpam-MessageData: mUDzl7V+qyq0VUt6W8GxRCSjhU+0dY2UFmgHWDjQhrOHdmJ3uS0SApa987EwPjgXAivnN33AiGwjOynKB7AdRlc5k2ZpBFdHc8hKRS0lWKLDUuIxBVsyCJiGQ2JmV1QeEmy5yQ/g8OayNQL17WoT9Ltj0PkVbN/GQrD1Ae2li0+0mu5v+LlN4AbiUiC47agNC+0vjsiy3Do/hXPCvKzXtIatXO1pdoOY7up5+8YQbOroqfd52z/qfLGbQ0ykc5v6PaY6zmJvgW4w2cF4rrVgU8ojkVuCVN+aRdkmlcFI+YJsjaA/mIfs6+0JB0PxMHHhd8AG10xGDFrIzJ6igCqHuAy7CnX7E9EDK/39NoKbKT8lidSe5t+KgA+pJdASKzRfCUVpU6ohyymt12fdMlpcz/w3wHgKdpYf2usZjd51gmq/oBb2YAUECpyVBpcvP0noDYjwP74xJVCfUCq9LwbeRQLJ6zmAW4VK6BL23gJjwBuXNb0hgpGyifiWUnhFPUmyBxtAzrFm24AFu58NHwxlQ9exutxjWFrB8EQTMnZCBxoxA7lh1MJrAuWeM4DSNASoli7BEjKRnAaKN/Aq747gM6Usd26Lt2XgAVdnIOyijkpQf03JMzPDIfLxPE05O8Pm3u2XT7/YSn+qbDj3AGF6Zw6MBPPg1CT/JZVcrvwXSRP4U2dJ9f0bDmyDDaeOqYyKMbBUD4BbMtMiSXRVjRk9Tx0UjXGNsK4xh10tOauWBkQAFi0W9vKeuqTEchGJRrnU4DXzoDPr/7Yec3YNjpBIWZsZE1xHH4Crpc6hF2RdgGY=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d41bf8e-018b-49ff-20e7-08d7e9e5480d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 13:25:26.5345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Au/gD37T6jZ400/RH8Nn/Fsfs8xTaKUaaWmomOxe5wlyozE/L8WLC01KgLjnCJHtrLr78AzPPVqfwffkvmHLUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1053
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In the case of kdump, the PCI device was not cleanly shut down
before the kdump kernel starts. This causes the initial
attempt of entering D0 state in the kdump kernel to fail with
invalid device state 0xC0000184 returned from Hyper-V host.
When this happens, explicitly call PCI bus exit and retry to
enter the D0 state.

Also fix the PCI probe failure path to release the PCI device
resource properly.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 34 ++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e15022ff63e3..eb4781fa058d 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2736,6 +2736,10 @@ static void hv_free_config_window(struct hv_pcibus_device *hbus)
 	vmbus_free_mmio(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
 }
 
+#define STATUS_INVALID_DEVICE_STATE		0xC0000184
+
+static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating);
+
 /**
  * hv_pci_enter_d0() - Bring the "bus" into the D0 power state
  * @hdev:	VMBus's tracking struct for this root PCI bus
@@ -2748,8 +2752,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	struct pci_bus_d0_entry *d0_entry;
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
+	bool retry = true;
 	int ret;
 
+enter_d0_retry:
 	/*
 	 * Tell the host that the bus is ready to use, and moved into the
 	 * powered-on state.  This includes telling the host which region
@@ -2780,6 +2786,30 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 		dev_err(&hdev->device,
 			"PCI Pass-through VSP failed D0 Entry with status %x\n",
 			comp_pkt.completion_status);
+
+		/*
+		 * In certain case (Kdump) the pci device of interest was
+		 * not cleanly shut down and resource is still held on host
+		 * side, the host could return STATUS_INVALID_DEVICE_STATE.
+		 * We need to explicitly request host to release the resource
+		 * and try to enter D0 again.
+		 */
+		if (comp_pkt.completion_status == STATUS_INVALID_DEVICE_STATE &&
+		    retry) {
+			ret = hv_pci_bus_exit(hdev, true);
+
+			retry = false;
+
+			if (ret == 0) {
+				kfree(pkt);
+				goto enter_d0_retry;
+			} else {
+				dev_err(&hdev->device,
+					"PCI bus D0 exit failed with ret %d\n",
+					ret);
+			}
+		}
+
 		ret = -EPROTO;
 		goto exit;
 	}
@@ -3136,7 +3166,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 
 	ret = hv_pci_allocate_bridge_windows(hbus);
 	if (ret)
-		goto free_irq_domain;
+		goto exit_d0;
 
 	ret = hv_send_resources_allocated(hdev);
 	if (ret)
@@ -3154,6 +3184,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 
 free_windows:
 	hv_pci_free_bridge_windows(hbus);
+exit_d0:
+	(void) hv_pci_bus_exit(hdev, true);
 free_irq_domain:
 	irq_domain_remove(hbus->irq_domain);
 free_fwnode:
-- 
2.20.1

