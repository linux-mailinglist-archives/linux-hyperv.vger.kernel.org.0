Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171504E66C9
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Mar 2022 17:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351615AbiCXQQr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Mar 2022 12:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351600AbiCXQQq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Mar 2022 12:16:46 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350F049FB7;
        Thu, 24 Mar 2022 09:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SA6TRA0+bwF6JundqA4AoeSWROD5COFICNGO65Jomd+ffpY47A4LwXsIkLHaGQ6sj02uvQ49dtYFOIjoSWOsLmh9pc7GYNIvSus1aOYPS0/LHurndk+H3ZuSjvbDrisJIVu7F7H8Xa6tbOU33YDPYhmr/KpadGox2S7fNQkiRnxYtBpnGmXaHeH5NK4NAeje1BpcwxwkglYn1tsAKoYgmhQUIOLCIWp/IK3uJyvnwZ03UC9Ld21HD09leezGbtE2ik+ZnoEkQN278/D1fzSJhQFqjsEZU+aNH0xwt9eUH0foPD7uW06B6l/c/nkY/QcT+c+c5K3+3+5GzzQ9P9+1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE74jggk/LMNOtLMIV90q30xNMRXi88xMxhkXHWxUYQ=;
 b=ZsAh2nqwQa7J3hvDY3eHx7dRpP5cBTKZbFtTlmljZqPVVU1x3DaWsr2Ab//sO8FX1xx0jCOvtdeSxG6KL1LabHDt8WNI/B8/75z36HWS8b88ZUHNW8blTSBdr5X/76OUGgfx9ICunFQweZSn9gTah/JYTRCXl96uPXhFm5vHiaGp/R9eA+dhsTVwcFzIeW5/prA8OVI+R37bnFZveN+zej5KmntA/n0ewbHRl3vVWv40UYdqdQm2B+y8GrODEoUrCTTF3QNUdT6O5vzzOtAoLitCyz6Rog5MASL5wyWvgwo59hDHdmJFHZOT/0yD/RiGgh0g6RiwUJbw5ybuTshMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE74jggk/LMNOtLMIV90q30xNMRXi88xMxhkXHWxUYQ=;
 b=V+cWx5qO5suFZFK50EN++8iQeiyjkLEtONRwvC4+2cCuc0VJwH7tcYtgROYUmgy8fVIIXrduIxSmj+NgoM33a1LoFVKLoRhEjH/uZKyf+A1mYv7gXHDzGun+FH/BXJkZS3Z0V/UbjnegUQlJ9DC0hVt/8/5rCmSEnUXoPjO/NzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BY5PR21MB1411.namprd21.prod.outlook.com (2603:10b6:a03:238::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.10; Thu, 24 Mar
 2022 16:15:11 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b%4]) with mapi id 15.20.5123.010; Thu, 24 Mar 2022
 16:15:11 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org,
        lenb@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v3 2/2] PCI: hv: Propagate coherence from VMbus device to PCI device
Date:   Thu, 24 Mar 2022 09:14:52 -0700
Message-Id: <1648138492-2191-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648138492-2191-1-git-send-email-mikelley@microsoft.com>
References: <1648138492-2191-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0253.namprd04.prod.outlook.com
 (2603:10b6:303:88::18) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb3c36de-932b-4d15-c6ac-08da0db17900
X-MS-TrafficTypeDiagnostic: BY5PR21MB1411:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BY5PR21MB14110C734C9A9396C31FC9B0D7199@BY5PR21MB1411.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5U/FY2T2iJarJzLTbno/tIe+WUDannNPb10hCTyRBG7RR7vUCaotv6LVcSDuDMlGEQxyn2MMuxrxT8cKsBhQ1lYeHKpPoLswBoGaIG5aEPB/2skxdbG9MG4/8OoJSR+uhQ9Yj+oroIMHq5DltWaZamYNNe35aWYTA/S5NM3pS7BMbY6Yc3F05BtyHsbfjZYYo7sA6hwvDXhZNeMNGoyEvte2IWEigDqe7L7ID35HMSHoIT58rDs9LBBws4oBCw0qSTseHn9q/I21bQcOAcgYfP1OZndjCw4yXOqnIxw/M+udt7leLkuMBeb6kwtfAJTubyQWvdhbGmdF7O0A6FpLZ3kRqHnE6KnK0wPZpadO3HSTgNwNDouYQyh1C4xj5zoJbWpCk1H96FktUy/RSpaLGZx0i06hPOLFs2JzTE5xxE9m7F14sOZ0ZHLJFhNlnNLYmnjS70c9A6u7qFC+CAO3+BDGfpSMR0lIrvorNT+o5h7kER3VJJNdqnMBYoGzOkEjd2CaipUpyM36Dw8kO4/Ey/Yke1LRcMenpY6XbSAWA9TWkzAfW4CwugHg1SlOvmIwBng3PYFrPgqhmgOs+cf+9PI3lZGrUMlXAgLrYrHYeOZTz/fdtF+NmI6Gzrk4VwYeuAZHfxMQdrnlL0tXV2em4HsS39H7d2ZPRuwbaRDzYuITVTMCLzNDyo0fCEyC/iZxDtuUEcWgkZHUVFcRpyAGBCvose+6dScgoR0cYC6sh6beAetIMzbMjer2BYkik8/SH25SCN3hIJ+8UdvPqqB+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(2906002)(6666004)(6506007)(52116002)(2616005)(6512007)(26005)(107886003)(186003)(8676002)(4326008)(10290500003)(6486002)(508600001)(66476007)(66556008)(86362001)(316002)(66946007)(36756003)(921005)(82950400001)(8936002)(7416002)(82960400001)(5660300002)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sYSPpkHkc2hBJ9xM1eTcE1luKHO0LMWb0tgRiV7cAk3psFLu2oPTz2pI5ikD?=
 =?us-ascii?Q?+BEICoj4LT5rh18iZQ6WCr7uDJVH9QH7dPTEITny0AmZTA80N+p1bPWx/zh3?=
 =?us-ascii?Q?KhQLrzUH6MjiC9yVD9OI4gatBFYegHPTXuwWjlr5TchFYCOlwX9BNCASk6x+?=
 =?us-ascii?Q?6AnUNVOc3QAnsLDOWG/NIykrEqAI0jsuMEEFDS576tdlke1fLVHw3u59R4ED?=
 =?us-ascii?Q?uM2hUGAc04toOV40RcVH8JYGZdy+IMD36HDq/F0y4qeXWCKVx+Fc9ZnuzgM1?=
 =?us-ascii?Q?6dFGpxSUCejzIY6p6LIBXB3cFiQPIQzrxbbvAmaP9tkr7dOJpgXxalmOM0UX?=
 =?us-ascii?Q?5oQToK2Bf8uZ8IACtHB2lseNxdS6U/mFDZjNj4TnwQZWoq0ALOehk3rNVxGF?=
 =?us-ascii?Q?S9saezXrD5+zWWGNwprqdaH/4MT2Mxhpp+m1sc9mkVd+0S1M9iuSbq6t8/D9?=
 =?us-ascii?Q?h3yTEWATOhvJocSPcuewOhVGq4bjCKPvS2GiZhbLR4egB+tbgsLNkYqrCNGq?=
 =?us-ascii?Q?eCOL41uJ/77tzgFdK5/0kvFfr0q6RFWtpEHjfl88DVsugpGNbGnsBRq/nIzY?=
 =?us-ascii?Q?ZQtklUhJ0HhMtY0fovNw9lL2kFDOQCAYqT4Mj8K2G/5GYRQubUX4qt7kIP5d?=
 =?us-ascii?Q?urWxHB2emQWuDppQP7EyfllLXqI0v3WvUCUALNLnzXON22/N3bwVCPDgNVfw?=
 =?us-ascii?Q?RFDX5jhX3Mz8F0dtcdUxevD+e5gNhQlbj7A2aSAnM0B4EC5R+W/5t/gE4c4H?=
 =?us-ascii?Q?W9cMBo4pkcqfoUAairBuYSeYQxPnlEoTYUyr+ekg65Pwvc/j66BIGFkMogqF?=
 =?us-ascii?Q?1Vex+fhVIn24zdRoj3Sny/LQE2W6KyAVSV6AsgkRDVY6saOg+BJZqSgTe9dP?=
 =?us-ascii?Q?HoNyz4AhGJYpMF2iokQArweMYppGobG2UEQ/RL8tA27Ryk2HAO6BqGg+qNri?=
 =?us-ascii?Q?M9MYbathwKZC9mpUqxomoMrZa7IlvLbDXHSRN80+4R0c8csJOJshwWvJaUW5?=
 =?us-ascii?Q?g0W4gB9bXis10QuqWMV1Sa26RXOqAIHvrM3hokRZfHOT3dppkuLyK7GDXIwf?=
 =?us-ascii?Q?pEQi9C9bep828nKO1oSkVjsefit05tjsOCCu/39BWfWWI/h12dLjfb5QNYae?=
 =?us-ascii?Q?rqXu6mcB3wITDGiJcOhN+cRFEpBuMyeww4mihfvrNBtdFaHi72CIrDrIUkMY?=
 =?us-ascii?Q?USYx2Y9Z3rD63RGK4YKFSA/RiZ8/tm/sQt3tof++OTKd7cM8M9GBo19hX/Vd?=
 =?us-ascii?Q?zYRxuvesB6qhHMEXDVqkbjxj9e+pQDMRKcLsxXYxaYTtibuSRa1bEG0kgiOQ?=
 =?us-ascii?Q?VHZbHtJlM/MTJ47t6IryLbasi+w5rS1ZhfiV0fkDxvNQFEmA3NtfTdHeceil?=
 =?us-ascii?Q?z5rhxI9oXPgSe12n0Us7crXtxKxdDb9uFDVFdj8w6h3tZx8smlFhdm90Hq3D?=
 =?us-ascii?Q?rS1lHWNiO2WLhdT5iREFpArW8mlaSKMFOWBUyBEio8SIxeIrfJzYFPzjhMFp?=
 =?us-ascii?Q?LWRv5mzGhvni6PGdCHFVxf+dN6Yy74ZEmmDJVZ3iE8/WO6cdD6keNyVzdhv4?=
 =?us-ascii?Q?5Qw1uLH7jKFYzs63d8cRXYjBYyosoylTjFQw5xIA1aJfc/9KP6NfbR1iA8UG?=
 =?us-ascii?Q?MvHlp+DAXIvPRMeG0Pixjd596xAeencziQCjJ7t9q0Njv/gn+Tig5gxKrhcZ?=
 =?us-ascii?Q?UVSd+d8tKK0IQkLzaPuzbMSJxGY7rsHbxc/8IqyV+Xcmc8hs8ABEFKaY4F6H?=
 =?us-ascii?Q?hVzACm5z4soPzEHhitT9Jj1StPu1u6Q=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3c36de-932b-4d15-c6ac-08da0db17900
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 16:15:11.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxVHIs606MZYdd07fL9rlXN+HFZ3VzhcM7pW3kurNfyN+HFPUImUuqiQYsGX54PH4ZsdyXpzqJmm+BX8U8umzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1411
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PCI pass-thru devices in a Hyper-V VM are represented as a VMBus
device and as a PCI device.  The coherence of the VMbus device is
set based on the VMbus node in ACPI, but the PCI device has no
ACPI node and defaults to not hardware coherent.  This results
in extra software coherence management overhead on ARM64 when
devices are hardware coherent.

Fix this by setting up the PCI host bus so that normal
PCI mechanisms will propagate the coherence of the VMbus
device to the PCI device. There's no effect on x86/x64 where
devices are always hardware coherent.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/pci/controller/pci-hyperv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ae0bc2f..88b3b56 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3404,6 +3404,15 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus->bridge->domain_nr = dom;
 #ifdef CONFIG_X86
 	hbus->sysdata.domain = dom;
+#elif defined(CONFIG_ARM64)
+	/*
+	 * Set the PCI bus parent to be the corresponding VMbus
+	 * device. Then the VMbus device will be assigned as the
+	 * ACPI companion in pcibios_root_bridge_prepare() and
+	 * pci_dma_configure() will propagate device coherence
+	 * information to devices created on the bus.
+	 */
+	hbus->sysdata.parent = hdev->device.parent;
 #endif
 
 	hbus->hdev = hdev;
-- 
1.8.3.1

