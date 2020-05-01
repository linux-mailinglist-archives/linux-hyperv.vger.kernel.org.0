Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AC61C0DC7
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2020 07:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgEAFgw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 May 2020 01:36:52 -0400
Received: from mail-eopbgr750111.outbound.protection.outlook.com ([40.107.75.111]:56710
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbgEAFgw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 May 2020 01:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG/hT7PmczdRwcLtgvRXXqen5Bz94T/OTROtxVvAn6ltu1OE5mYxRllJVnvDTm+csmjEwvsuy9BLcorqUfyBvslAhfeNFdv3hf+RVsQXrBIlVhbGmwGrhu/vlt5u5YzwaxKhbtlPv0s+cr2phoiPbfeIMmrnxzxCYIdFNagw7qnicESd0OXqXWG4Hmu8MuhCmcFLEfemJNMWvq31/YzKYAwZMnt3iNIliL735KzP/J/tb/E6FCXrQB3ZuEV0C8f0nTgyupNwt3heaqPAs765+fGuaB3XQUN+ff5acQ26ZpfNrvZlHSfYoOBzKeF3Jdj/CUKosnb+ZoARdj5hWGKWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mjmo77Z+Nw7B2iJ/oIHJZTVqv9wgBYPRFZzIsVAa7o=;
 b=PqYNyk+hYK08Pf1fz3Oo8CyVO4WRord6ZTSYvc7DHBXX1cNi4lBwofQbsdsGHaB1W9Sz1W9XXFcjwxS/MHTDgtfMciCohHPUM/4UcJR08hYS5Z1CDpQSFDvJ5WG0w7Y0yBrpA+87QF31vOI7PttAmc5n4A99qGo+2JMDf06LyeebtSGhEk7qTw7zbjcEfiS3yTvxjhQBucwGKYCMymTlMPOjEypLkVPPo7IR7fAq13D22qMwGeZm7UbrMCC1hc7PhKa+B6DG1lCuX8oEAPDZHc/fsaIjfRC4Xf9MQPyx2/YgZacBzN0AhFALgwsGrEubg3wOSAgGV5CVvIutf6dJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mjmo77Z+Nw7B2iJ/oIHJZTVqv9wgBYPRFZzIsVAa7o=;
 b=FGGULrFKUAZtE/x3edz3aAFmauEFjZJfcpah2Ekv09g14UD6c3U3cwBo+ETBzRxssoFajv/mo/XUoYPdoe2crItyMfO1lWWcY3htUhcqA4IIPaTYTYyDfEYoZx6H0dRn2oD0I5KlV4GMP8GVoCHTH9Gr8U5Mhn3XOsQA0ZDhJbU=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com (2603:10b6:805:8::12)
 by SN6PR2101MB0992.namprd21.prod.outlook.com (2603:10b6:805:4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.4; Fri, 1 May
 2020 05:36:48 +0000
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55]) by SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55%5]) with mapi id 15.20.2979.009; Fri, 1 May 2020
 05:36:48 +0000
From:   Wei Hu <weh@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 1/2] PCI: hv: Fix the PCI HyperV probe failure path to release resource properly
Date:   Fri,  1 May 2020 13:36:17 +0800
Message-Id: <20200501053617.24689-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:3:2::11) To SN6PR2101MB1021.namprd21.prod.outlook.com
 (2603:10b6:805:8::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (167.220.255.49) by SG2PR0302CA0001.apcprd03.prod.outlook.com (2603:1096:3:2::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.14 via Frontend Transport; Fri, 1 May 2020 05:36:44 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [167.220.255.49]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41303e84-1a0c-40ac-f901-08d7ed91a488
X-MS-TrafficTypeDiagnostic: SN6PR2101MB0992:|SN6PR2101MB0992:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR2101MB0992396AC613825E4B87CFF6BBAB0@SN6PR2101MB0992.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0390DB4BDA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MstNsRaM2QvQosXcqNE6L96RGsXVjr0Msn6PLt6+VdcQqKdvma23J9HSls7Ul0A8GwqcMX0phga9NBRGI3770LXEKFZnGWmQHukpeEsUAk5/We5f4idZBzpejZ/oyCPB+CVjn0AZm8EDUBW6lcN1GXtOlsh48VZWtEvr9Exqm/pptWJnUeIlX9x0IrUu4idUnnVbfRflExGoOEhoj/nXN6a2GfHwyyMEkMXxsSGKDGAl+W1ZIyt6PPgr0pK8IvHUt/RfuOkmtGPKMqEjdPHQ/SgF+xB7VHR7z5d9SzGBAl7+2R436NENQy07KNH7GjOLdpir/upajWbR7jseB7wSCvGdKbRjdWWfwQ+3YgnQhnT+FC1AbC0bx+5+CMMqWHOYdMw8aQ7FHDzU3Kt0212uxxvLDxcQF9xy6ey73clzRLXkNarBO+dqsu7qA0bu8Se305ErQYehef0odlkT1D7VZVbH6PlC/qQxuiC1Wvbb02o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1021.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(16526019)(186003)(3450700001)(8676002)(8936002)(5660300002)(26005)(6486002)(7696005)(52116002)(107886003)(1076003)(82950400001)(86362001)(6666004)(316002)(36756003)(82960400001)(2906002)(10290500003)(2616005)(956004)(4326008)(66946007)(66476007)(66556008)(6636002)(478600001)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: i8XMj6YXSLd3uLC114Le0gEAZQWCWBBn3biEYLDfJEtX/xRy1H9FXt9eWzqGK9/0bWlfC0gi53Wu8IKEy1XhB52VGpz7PC5is83vo1BZBzmtNtFrSLJsFnuV8h1vBc+32dgwdXE2VS+Emnia5+Z5L4I8OdNnEieqp8YOb/hwCRv2u2Bvpq29+sT9voPaNZ3txYx0p69VF1+y0rx/sZgtzUOMyg+XPW7wOp2eDtGYBECKK2MQ/eBdTHOid7uaeZcqZDJdw8XsDwbXXkc+ZhiqmUQwjs3BwYySuAQWWO9uxqcgBOcxv4EdpkgY4rcHGBHVAwQyFYSPuabAijWOR4tDoQLdLfIuN5xB5Ps3AvVoL5xUoHsavvr6YfZ6DvBKAZUgPe5sFy11pTe8ltihx+ZRtaJlNLH3VBeF45bkd0AOCgw9YpkWmE6f9Fu9v9ybh1PVShuXYNpqjUBM1Z92txi2PvB0oGfgCZbZ9qvoo6mGKwwBp51YlnI4B8DZvfh8wKIhUiHHY2X8Wq8ZVPi8sM2/SfahAPgYj7Plm4veqoVx5SqtI8s3rwjutZw3Ged5nN1w4Doiz2TZl7Ejt2fZq3Jp2p9Dz2wv3Ngj+xymcMXawCpgW9RRmdFIocwb9tFNlYZ0EAD7pjQ+0sc/YFZ4clvtQfOJ3QeNAugewNqhWL1VGIlaOWa3BVuIMwr3hF4zT9L7dsYqiSmBZpWMfWeRC47iFDy8gkJMiY2aIGaX5kFwaFmVylzaH+CH+7QKsDR8RJ7RSh7B143H78dUmE/IOtr/VQFx6rpevZ5pDMET35BsytE=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41303e84-1a0c-40ac-f901-08d7ed91a488
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 05:36:48.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/VndH6MyHZLpJMjVgUtIP4/Sxli9sNL3pJq1WZrSp1mCIVCtiqmBVAYC19vrPzkOFDVOJs/yyoYdaS/+j2baQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0992
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Some error cases in hv_pci_probe() were not handled. Fix these error
paths to release the resourses and clean up the state properly.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e15022ff63e3..e6fac0187722 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -480,6 +480,9 @@ struct hv_pcibus_device {
 
 	struct workqueue_struct *wq;
 
+	/* Highest slot of child device with resources allocated */
+	int wslot_res_allocated;
+
 	/* hypercall arg, must not cross page boundary */
 	struct hv_retarget_device_interrupt retarget_msi_interrupt_params;
 
@@ -2847,7 +2850,7 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 	struct hv_pci_dev *hpdev;
 	struct pci_packet *pkt;
 	size_t size_res;
-	u32 wslot;
+	int wslot;
 	int ret;
 
 	size_res = (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2)
@@ -2900,6 +2903,8 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 				comp_pkt.completion_status);
 			break;
 		}
+
+		hbus->wslot_res_allocated = wslot;
 	}
 
 	kfree(pkt);
@@ -2918,10 +2923,10 @@ static int hv_send_resources_released(struct hv_device *hdev)
 	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
 	struct pci_child_message pkt;
 	struct hv_pci_dev *hpdev;
-	u32 wslot;
+	int wslot;
 	int ret;
 
-	for (wslot = 0; wslot < 256; wslot++) {
+	for (wslot = hbus->wslot_res_allocated; wslot >= 0; wslot--) {
 		hpdev = get_pcichild_wslot(hbus, wslot);
 		if (!hpdev)
 			continue;
@@ -2936,8 +2941,12 @@ static int hv_send_resources_released(struct hv_device *hdev)
 				       VM_PKT_DATA_INBAND, 0);
 		if (ret)
 			return ret;
+
+		hbus->wslot_res_allocated = wslot - 1;
 	}
 
+	hbus->wslot_res_allocated = -1;
+
 	return 0;
 }
 
@@ -3037,6 +3046,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	if (!hbus)
 		return -ENOMEM;
 	hbus->state = hv_pcibus_init;
+	hbus->wslot_res_allocated = -1;
 
 	/*
 	 * The PCI bus "domain" is what is called "segment" in ACPI and other
@@ -3136,7 +3146,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 
 	ret = hv_pci_allocate_bridge_windows(hbus);
 	if (ret)
-		goto free_irq_domain;
+		goto exit_d0;
 
 	ret = hv_send_resources_allocated(hdev);
 	if (ret)
@@ -3154,6 +3164,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 
 free_windows:
 	hv_pci_free_bridge_windows(hbus);
+exit_d0:
+	(void) hv_pci_bus_exit(hdev, true);
 free_irq_domain:
 	irq_domain_remove(hbus->irq_domain);
 free_fwnode:
-- 
2.20.1

