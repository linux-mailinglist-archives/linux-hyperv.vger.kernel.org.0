Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2481BB523
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2020 06:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgD1EVz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Apr 2020 00:21:55 -0400
Received: from mail-dm6nam12on2134.outbound.protection.outlook.com ([40.107.243.134]:46657
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726413AbgD1EVy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Apr 2020 00:21:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOvYcPspbFntjk5lWA7bTuBNLj2NYYsL1wwaz6dA4IgeQchN8uYMfI/FryWYBG0dhvo/y6bMWOcBKFdqENXjzygTHRyKN0PiCrVK803+mm3wNso9nRc+VTYZKqkAoZl7E2C3hazwLt3a+AMBIq4SEWkr+mcNBpMdhkSAKiXUVgr1skJiMSggp7qUhl3BazfCx/DwBjwLkSQGlGqmT505MAKfXx8vwlfBLhnpAkdaBUylxYGNwq3r3VXCkwEIUnjkuZCf/YROA0qONOHSTtGyGA2g8WxxDU23FVXWrDITNJvg7QBht7vEbx1115Xoyh3KulnD4z9hjXjMIgc4lAnfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OAz9ywgePeSeHnPMmOG6iunEWu0dI2obD8p8sqxqY8=;
 b=nWNNEMoBUYok+pM+7ErsA4PUpVoM9ssVbijAUqsEUj1hh6QmaF95PUl+HFEIKxZ9Mip/AwcDKzKFO0zlFTzzfBWua+6IYCBgXvqmvArDGn2y7GGSlRgc/67ViFnzrbMCKBMiExE4Ea+mIi2bjVZ9bEtlWw/RFpD49LHcHn22Kd1Tar7grE3KRAWBdTBtZyQb6isU4P5IgNlAaV6Pb6jTQw48xKDwQE4hbYRp2BsAQCioPlC/k7t6LO2sygd30n9vCHp3mYZeWcX+yc7v79Xw+5GM+sUNJ4K+Wz7xaLZTpi3r9YgjTcu+WPdGhWzweMMeVjQSDFx/MeOvHlp/U9Rs2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OAz9ywgePeSeHnPMmOG6iunEWu0dI2obD8p8sqxqY8=;
 b=EuhXQ4M71aqjzMXsPAiG56tpbloRpMl065lIxvwru6Rut4h1dWuc9YDhjNhyaqDFp9Vq3QYp1rgKvCD2K3zWNbgaDwWJolMDbM6fNsN4eDqQ7dfusjyhJzAhw9itJKr08itmbe3AlRWStmDL4Wo5GBiuCm4fM74qxmn4SwEtCHU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com (2603:10b6:805:8::12)
 by SN6PR2101MB1088.namprd21.prod.outlook.com (2603:10b6:805:6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.3; Tue, 28 Apr
 2020 04:21:45 +0000
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55]) by SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55%5]) with mapi id 15.20.2958.014; Tue, 28 Apr 2020
 04:21:41 +0000
From:   Wei Hu <weh@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>
Subject: [PATCH v2] PCI: hv: Retry PCI bus D0 entry when the first attempt failed with invalid device state
Date:   Tue, 28 Apr 2020 12:21:12 +0800
Message-Id: <20200428042112.1479-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To SN6PR2101MB1021.namprd21.prod.outlook.com
 (2603:10b6:805:8::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (167.220.255.49) by SG2PR01CA0115.apcprd01.prod.exchangelabs.com (2603:1096:4:40::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 04:21:37 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [167.220.255.49]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07ef6588-9888-4a3d-0b00-08d7eb2ba6a7
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1088:|SN6PR2101MB1088:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR2101MB1088C24C7CC0D4CD49C98859BBAC0@SN6PR2101MB1088.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0387D64A71
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuC5Yk+34PUswC9GOLUSSBuyLk32elI9RU2ZmMnsFy7+A5N4CKU8DrZGSZA6uDZo9F4Jq30b/7vxZOflW5QpAeuObDVyLPQnvYYr+jzgM8BE7DHs/zRPnjWWVWd7Wd0kA9+ZQt7sZg1dXOcb/YS+bY6uubkh9keQTi0pX7DIKrbNQcpiMFk4Ymqnx1mWZHxb1aGvURHg0eIB7Ux5pzquyX6tkqcRd57FgZwjsdfEz4b8YZtQogLCMozBwpXV2eBwJmQEzwhjVu7scHNjIibpRcWZRfB4hee9J0Nawat6a2MAVxAxj19ZLqlsBc7xlisONs6OaD7ZeYuXoHaVhYRX9bRNKZrfhA/j7v+1yguqr7OIlaTqDwjzkbCTugHaeWaa2gerv82KFmiHlIh+YQQxMddLI1VYeDRyeqoTywY1D50scV1vqih/gCENgJkJjYpi/3oR2fgzjc+cvL50PP4zCanHn3Ns26GFVByn/sry9cA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1021.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(186003)(66476007)(66556008)(3450700001)(82960400001)(82950400001)(478600001)(316002)(6486002)(8676002)(86362001)(66946007)(2906002)(36756003)(7696005)(52116002)(26005)(8936002)(6666004)(5660300002)(6636002)(10290500003)(2616005)(1076003)(107886003)(4326008)(956004)(16526019)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ue+e2QvAcTEtm6DUFBoBtUwo0DAlILeQ+ub3ebSDUvo1ABgkCqrl3IgjndEm5k/xQ98K5Az8yG8mBYK35ZlZWL6X1kbq47f4Mu1JtopPB03ussqiXb8CBW8t3tVUF8qheg+hgODG62J4UWEBjlAaacZejbFlhQ9onxy/ZOXD30Bf0Kyc9OSbp8wKHV4D81JD1+PA8wVrPFXVHqiJxCclKYDsyQE6jma5JxP1l2xLmz4I99RVFfyBjSETuGeZbi1Q+p4QUQNXHmCB6Wwlq9L3hSgJFEhFMuBhZ/FfYoYbIeDf76gYKgQOftB5L47q+H7lpMWJWJfIXkCiseRxhLXmjoW5XC8CzyUsUiRn0yuhEr/PgIlUQM01s3nBklUNXgs1gWrMeKEAAWOa/K1P7Y2YTYNPJQ+LsE3C2tWPpuq05olUiXAqwUzyv7U06qkMft/OIk3kWBkx32rax2yiRu9nshu7nxn8MeMb1W+EEchpg5Rm5skmhHCgridDhOMNJ3qEStrts9ZiY4G7RqF5FVy43hJcw8bppS4TEWzIlYMkljf0swyjGULpSJnVDmslD5kDl43HgeyEY+66Lwv6lVAF1lRthBTv8s+OktBOlmRfDt9UeECmlT67g/BQRtaURdjNOLljUxafH5c7fx/+EfUvsQPJkt0flbyhfBWorP5n8Va9sy8raMKbmESUky17Mdp7noaByF8O9xWW3fYGIkdx1LVz0qOw4vfGwj5Af5PUCadBDDTQYLT2xbQqjzM8bUATnVf+pYwZmzpJPPfSi2B/yljfyKA2cEcWC9AYEyx3bPU=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ef6588-9888-4a3d-0b00-08d7eb2ba6a7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 04:21:41.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0m6y1QiSj6NvrdTykSjeJIltfzv7g1L8aLyOVntvQEcekBTnV2A7a21jF5/WGnFabgWQ4Gr91LDcaime6ilPdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1088
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

 drivers/pci/controller/pci-hyperv.c | 30 +++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e15022ff63e3..0a42c228b231 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2736,6 +2736,8 @@ static void hv_free_config_window(struct hv_pcibus_device *hbus)
 	vmbus_free_mmio(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
 }
 
+static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs);
+
 /**
  * hv_pci_enter_d0() - Bring the "bus" into the D0 power state
  * @hdev:	VMBus's tracking struct for this root PCI bus
@@ -2748,8 +2750,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	struct pci_bus_d0_entry *d0_entry;
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
+	bool retry = true;
 	int ret;
 
+enter_d0_retry:
 	/*
 	 * Tell the host that the bus is ready to use, and moved into the
 	 * powered-on state.  This includes telling the host which region
@@ -2776,6 +2780,28 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
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
@@ -3173,7 +3199,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	return ret;
 }
 
-static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
+static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 {
 	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
 	struct {
@@ -3191,7 +3217,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
 	if (hdev->channel->rescind)
 		return 0;
 
-	if (!hibernating) {
+	if (!keep_devs) {
 		/* Delete any children which might still exist. */
 		dr = kzalloc(sizeof(*dr), GFP_KERNEL);
 		if (dr && hv_pci_start_relations_work(hbus, dr))
-- 
2.20.1

