Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924EB589648
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Aug 2022 04:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiHDCvu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Aug 2022 22:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiHDCvt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Aug 2022 22:51:49 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020025.outbound.protection.outlook.com [52.101.61.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9655A152;
        Wed,  3 Aug 2022 19:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d24HRGXcBIMXZWHYY2iMNXpMrXxXJDro51SpY45tcGPWSkgjZbnkrJxSLJBzRlWv2m4t1tpD5Jpry2CQ+5m+upySEr/mRGkWsJO2v0oHRR1DlA+mIAo+U2AqDcsI2NH0zsJtZx1t5O3dOousSa16uKuruJB7xWbiTqgDPzKJLY0k6z2qWP5Kzij0cLdBiNHWmMdZj3EZXIE/Quw6JeExSwbNH4IUEtyRqxeZULtJB8Fs7P3eDmVxD3TXUXuNEWvx7oPNFxdt6SLTNUR2fMSMHl6ue/WKivEgz1STc9XsQI5VDE+sEz5QYzS6Z4S2kycosyQ7sWVcXPvIh0OotcZPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJQCVZ/J+5d7AAF27L5HlwYSoRVZ8W2BQd5NomtEgU4=;
 b=FdXhGya3T/UJsyn66fZ29YDx+BKfZV67KKZedMvkfJ+TMWQdxyhHyuOz/KURVbi75/2/m9oIo1PxbRmPQdBuwHVTWZh2j3nmqFZMQcCfcedis6DxTkL4Qz0n8prafJ9irJ4FSDLRRWVEFsHy11pTr3a3SWWMtLSDFk7rlG4KJsFE0yVB6gGVgd8XxirLgdeKnxiEOVL2HlCLH5fRA7r6DOkHYSymTdcNVkxN+5zZXmSdq2sRd+BPll7Ckicmyia3JLeFnBqFgTlsOEM2k4B94Bdx6WzJw9UzYeTM8XoSYdEUiUdp7sxrrT6aJWK79scFQAjDGrQdKbve6p1xooFiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJQCVZ/J+5d7AAF27L5HlwYSoRVZ8W2BQd5NomtEgU4=;
 b=akxbpzEg4l81LUGVbEPLaTTEP7NfebgDikbhfdfCg9tN7H5qPXTXWZ27bTvbOEaqFl+/H9u9vBHZTZihpH1Wr7mVVOtSzCiT9MI03giSY3Y8AAeWhZgEdIn5WOUD0tt8lOnJiSj0Ri/mlqHF2pVJxHbxFgcGgl5nMtPBlJ9fP40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by CH2PR21MB1414.namprd21.prod.outlook.com
 (2603:10b6:610:87::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.13; Thu, 4 Aug
 2022 02:51:43 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::1d7f:eec5:68f7:aa1]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::1d7f:eec5:68f7:aa1%9]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 02:51:42 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     quic_jhugo@quicinc.com, wei.liu@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        robh@kernel.org, kw@linux.com, helgaas@kernel.org,
        alex.williamson@redhat.com, boqun.feng@gmail.com,
        Boqun.Feng@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>
Subject: [PATCH] PCI: hv: Only reuse existing IRTE allocation for Multi-MSI
Date:   Wed,  3 Aug 2022 19:51:04 -0700
Message-Id: <20220804025104.15673-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:907:1::31) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 664cd105-2ada-4237-b4ed-08da75c442eb
X-MS-TrafficTypeDiagnostic: CH2PR21MB1414:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KO9a3nIgkDxrPy7G4xbRlwlk/xm3YJmTj3cvxUZJNa7361IkNbxQpagSS6Fpu2zNPE6jq44mO7PURzjeZ1wbAsbN98EE5dq4dQ+xpLDeyMllIu7nr98D+y59Z+DgDsq3nYZRHy9716c+d0sknAQ9q3oAlV8VlWMciaOB8FzOvB64Th+l+GGs5DVmn36Xe+c8B66ucIFPrs0aaiGFVF7y/wf5PRSnn8mziTptg3sWO6HJOgQ+/kB9l+wGdww84UlWGKBdFhDVhdVFYHbPKxYN41Ily8pHb6/NR4oXeHFHJsv2CaBBJjsEezw56D8t29E8/6JN89SsQ/KOBrMOqgTjApZGs/jWAfQMJoUR7Udm8QK0xLNruS9ca1x/kLncP44iQ20p/5iOXeEmKA+stTQNsFPyvkBBFVtrPAdN3z1hp4uqSzPH4TgaabDGM044x37Lj9v3JSQgYgvxbXR1KG9RzqJ0OvLUD0GT2qXCxsj11wJ6bSDmxiUFYE5ZyRfyJrwybXZqmtdot3471slBFsbv/R5blTdlM8zPZxGUPSkI2pb+zC6vXf0NJ2nQ1bx9Qq/lRyUwUnP6vX2GCgS2JwLW+9MfUMGgD+lkTdABCvENvZ1W1dEUItYrW1W07DpCupGrnxqXB47aRGDj+Xukvd/j6KJMm2shDAoa9ZHeuSH0uZ1nKlYdQR0g//1tJ5xV5deFU3Rmdjvy0T7/nu95j6yd45sWg83+uRSfT8YQ3NTjbSMMj9tXNn0Akfl2kRFvKZ2CoccvhNa2+zTYy2PuHRxzvfS6rzg5OgLC6Y5HdHZvDxOH98K2T402ZyKiNxXNIOdCB7ri98zSrOPgsnNwg/yxtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199009)(6512007)(2616005)(6666004)(66476007)(2906002)(41300700001)(3450700001)(52116002)(83380400001)(1076003)(6506007)(38100700002)(36756003)(5660300002)(8936002)(66946007)(82960400001)(82950400001)(54906003)(478600001)(8676002)(316002)(6486002)(6636002)(921005)(7416002)(66556008)(186003)(4326008)(86362001)(10290500003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MqzdvrfXbpINaDA6Xa8Lw8KJxy2d9p05tFX7Yjx7KxYOjGszDeRZ6fm/EzFT?=
 =?us-ascii?Q?Qc/F3yo6fFU5UnrvIRW5ckg5MsviEjM+xhl1Oabjdhx9C0eRH47E27LZG5J9?=
 =?us-ascii?Q?wTI8v/k3G9z7BDgdxLtzkMipjVf6uEEm7Hx7kwHFHWx+/oo7UL9gT6+BrABv?=
 =?us-ascii?Q?uPbBRyCbQkd4+SHrWjnWWs6Yi8fGb7Tkt0l4fv2g9Fn5Hry81UJcYquqOyCp?=
 =?us-ascii?Q?ofMvV2AiIpNnOhhMACWZyDZf75BisfK9ckR9edx5XcSem6m38kzd9b1boNU+?=
 =?us-ascii?Q?w3I2w1NIixklEYvl2oo112w7jUWDC0WHuI+Lm0ZKOSqgGaepsnQsEve16zBz?=
 =?us-ascii?Q?kzDFN4IwlADJL443SrWecX6NBz/KSp3NdEpB2oZuS4NxEGz0Rzfz5fEIuRw2?=
 =?us-ascii?Q?w/bkpvRIT1HSTDq4mZN9qMX3LcDmrutYvUOU/FCvE5ah9nJB/Nok+qeI4ddw?=
 =?us-ascii?Q?n9pKbXlMmsEGcrFlUcg7OUBHsuKt7MsnP0ATLADysDYc0CjiHw1mhuQseNSj?=
 =?us-ascii?Q?a/0nt+KF6Ox5bFq0FtH9T/ceBgCFjMdWE7y3j+dMhmI59agU2d8vxI3yCsv9?=
 =?us-ascii?Q?C8/6RIk5dyb9a6Dp07LDiD8soBZ057K91KfQhgt/WevDDIc6xvAhiyceCJk0?=
 =?us-ascii?Q?vlbn+Hs0Twzn5eLxiS9Oo8EpoPTO8djUpBXmihYax8t41H2xOGdHT4BU1OQH?=
 =?us-ascii?Q?mQUt2cvm+0/gNc7JKnCxBUaCaSMeEX6S3xVH97UF3BJVC8XTo4mi/RULZFdS?=
 =?us-ascii?Q?IU3IbQC2W8hMNUi5tA3thYrjDu8DtPoySmHXm0cE/nw+DHbU1J3LgRtwytzq?=
 =?us-ascii?Q?W9c4GzfRI+eV+x37GkGq/HdFxBQzNoY1NnWdQZ3rKFmTxmIA6XePRL/7LK7X?=
 =?us-ascii?Q?24KYJC1aFMkqOFnVUqLSxUADcQbHms5J2sqwt+z/Qlak0A2GWvJcKdxRQoeU?=
 =?us-ascii?Q?Xp4MAYcNAdQWn6GiKPICx/BDnyYuKvulNJnLBvUvrU52nq37H5ElFFqr125N?=
 =?us-ascii?Q?l9AQcpIp/mRkSYTab9oZ2BfauQIJ4GoKGsY9MwkdslbbZzht6AbcIuq+h223?=
 =?us-ascii?Q?y/++6HKXRKntOL1IAExpkLj6rK8nRNwPRAR0aOcmyBxH7A3Lu2MotRMx+02x?=
 =?us-ascii?Q?3/VI+vc5e9VUSvRwCJJQ8WD3LlfTIq4eWSfdyHONWRKULqP3HcwNondPvign?=
 =?us-ascii?Q?OqwPV2aVX9yzh5e8o8JWMM/3HA42oeTSoSVi5gtCOLoNQ5DVg1L9c4kZQz8q?=
 =?us-ascii?Q?tQKsWIUQhDpaFz5U6JVezohOICSHVm1/h8+IcUSXb5354P5MBhi5KxAxthfc?=
 =?us-ascii?Q?J53BnU5DUx0XxPZZa069P1xF2QDEivp+eas6pLIAXfM/CqSKH6RMAVnm9yXt?=
 =?us-ascii?Q?THLvt9qWPYMJrF9TDRXW1/p8E0Sb8KT2Rm9AI2Z5wve3Y1BXX5ofoMdJdNN8?=
 =?us-ascii?Q?UEapUPh+BE5Lqax1Sr3KZhlUlei7ThtSaA0Oh6/32DbjYAZCPdeWa236OtvD?=
 =?us-ascii?Q?Hux1dxf6K031vFagfVBOB7EWUrjSP9eOz71BKc1IQxU/87uXpIIixfzY1vI4?=
 =?us-ascii?Q?RO0DZSQtZMQHJJ4okrxVYa58rmlOFXHy2/zZHcV0dEt2XrbaYnQxG86+YFkP?=
 =?us-ascii?Q?/yqguN4zORIgnQJqtPKCk3mHmEUgBDTHj0tj93Oz9cfR?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1414
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jeffrey's 4 recent patches added Multi-MSI support to the pci-hyperv driver.
Unluckily, one of the patches, i.e., b4b77778ecc5, causes a regression to a
fio test for the Azure VM SKU Standard L64s v2 (64 AMD vCPUs, 8 NVMe drives):

when fio runs against all the 8 NVMe drives, it runs fine with a low io-depth
(e.g., 2 or 4); when fio runs with a high io-depth (e.g., 256), somehow
queue-29 of each NVMe drive suddenly no longer receives any interrupts, and
the NVMe core code has to abort the queue after a timeout of 30 seconds, and
then queue-29 starts to receive interrupts again for several seconds, and
later queue-29 no longer receives interrupts again, and this pattern repeats:

[  223.891249] nvme nvme2: I/O 320 QID 29 timeout, aborting
[  223.896231] nvme nvme0: I/O 320 QID 29 timeout, aborting
[  223.898340] nvme nvme4: I/O 832 QID 29 timeout, aborting
[  259.471309] nvme nvme2: I/O 320 QID 29 timeout, aborting
[  259.476493] nvme nvme0: I/O 321 QID 29 timeout, aborting
[  259.482967] nvme nvme0: I/O 322 QID 29 timeout, aborting

Some other symptoms are: the throughput of the NVMe drives drops due to
commit b4b77778ecc5. When the fio test is running, the kernel prints some
soft lock-up messages from time to time.

Commit b4b77778ecc5 itself looks good, and at the moment it's unclear where
the issue is. While the issue is being investigated, restore the old behavior
in hv_compose_msi_msg(), i.e., don't reuse the existing IRTE allocation for
single-MSI and MSI-X. This is a stopgap for the above NVMe issue.

Fixes: b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Carl Vanderlip <quic_carlv@quicinc.com>
---
 drivers/pci/controller/pci-hyperv.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index db814f7b93ba..65d0dab25deb 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1701,6 +1701,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	struct compose_comp_ctxt comp;
 	struct tran_int_desc *int_desc;
 	struct msi_desc *msi_desc;
+	bool multi_msi;
 	u8 vector, vector_count;
 	struct {
 		struct pci_packet pci_pkt;
@@ -1714,8 +1715,16 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	u32 size;
 	int ret;
 
-	/* Reuse the previous allocation */
-	if (data->chip_data) {
+	msi_desc = irq_data_get_msi_desc(data);
+	multi_msi = !msi_desc->pci.msi_attrib.is_msix &&
+		    msi_desc->nvec_used > 1;
+	/*
+	 * Reuse the previous allocation for Multi-MSI. This is required for
+	 * Multi-MSI and is optional for single-MSI and MSI-X. Note: for now,
+	 * don't reuse the previous allocation for MSI-X because this causes
+	 * unreliable interrupt delivery for some NVMe devices.
+	 */
+	if (data->chip_data && multi_msi) {
 		int_desc = data->chip_data;
 		msg->address_hi = int_desc->address >> 32;
 		msg->address_lo = int_desc->address & 0xffffffff;
@@ -1723,7 +1732,6 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		return;
 	}
 
-	msi_desc  = irq_data_get_msi_desc(data);
 	pdev = msi_desc_to_pci_dev(msi_desc);
 	dest = irq_data_get_effective_affinity_mask(data);
 	pbus = pdev->bus;
@@ -1733,11 +1741,18 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	if (!hpdev)
 		goto return_null_message;
 
+	/* Free any previous message that might have already been composed. */
+	if (data->chip_data && !multi_msi) {
+		int_desc = data->chip_data;
+		data->chip_data = NULL;
+		hv_int_desc_free(hpdev, int_desc);
+	}
+
 	int_desc = kzalloc(sizeof(*int_desc), GFP_ATOMIC);
 	if (!int_desc)
 		goto drop_reference;
 
-	if (!msi_desc->pci.msi_attrib.is_msix && msi_desc->nvec_used > 1) {
+	if (multi_msi) {
 		/*
 		 * If this is not the first MSI of Multi MSI, we already have
 		 * a mapping.  Can exit early.
-- 
2.25.1

