Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD094E59E4
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Mar 2022 21:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344672AbiCWUdS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Mar 2022 16:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344660AbiCWUdN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Mar 2022 16:33:13 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020016.outbound.protection.outlook.com [52.101.56.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8228B8C7E5;
        Wed, 23 Mar 2022 13:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0+o2t+mCra/5lmQuhzGa3OYOvUI3eCInhI5zv2CFWPcInK35MUeJ7/z0VZin+C1NvhzabEZF52KZn26+10urIs/LLUxdMqPCBC8n+/qhFGFFBS8IEMrg1xP9UA6DZTxK5tbImm2HRZoWB8iev1BDsasNI3b8fQETpuFJ1h1b99XM21MmwAZeXrnA0/CVzVJ12Ao/LbITtgJ1vyJKpPjEOf/KQuxRwJdeCwyQ2DyP5v11KINIZmg+1+ZtfpMarsK38dRSL8RS1lbXVxsWUX8Ggzy1VoH6TAJzF8PBF8AHeMnJnd+84FxsV/Je2t8MtfxSj91WtOC1cWDqqLOfrPcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyO99w7s7VMNWuDh5lI4ielArWozmZ63exfDFTApM+0=;
 b=eih6srCKE1Qdz3H0JnECWtpfxwz/AzOFvivpevQSoz7ZOEdo4jaAYDhJNfRwRfFTTNAMDGP1erTfgCFTVNakMkN8CXxf/Q5cY7Y7cSP+diyVzgFriaqnSLjwSbZzE7BNHyvH3tGZQwuUmZnJ50XL9f9AwTAr3DINPkIhv5jo4hd75Few8y9pZ+PL9kyRK2YGViNNTdoZ3AP7+0QIO2abuAewNGbx/Wt5o36PuUGtqPEh1N4Tj7TZwLKwy02AcHbG2JB8nuOekwZMtgTnwZ0Jnk23lODhqtdzaPdLQap7IvD6ORh0z7sj6CAgwX51olag1bw3sElhmbpKWPXjKzM+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyO99w7s7VMNWuDh5lI4ielArWozmZ63exfDFTApM+0=;
 b=Zd69c+i00gTjAH0Ab/5L2muIiEZqgmvjdZkmpafV1mZsNb6z1teMyRH5R1OfwUo7uNAVw6bNAXe4DLjhFaQ5xxBWaPGnz6q1anaqpxJADxvPTQ2Cz6zBOylEEh6l12V34fQIm14+hV5l8hTQI+mrQysE4eJ1/CWR2JYhR5IFgEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by SN6PR2101MB0942.namprd21.prod.outlook.com (2603:10b6:805:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.8; Wed, 23 Mar
 2022 20:31:41 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b%4]) with mapi id 15.20.5123.008; Wed, 23 Mar 2022
 20:31:41 +0000
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
Subject: [PATCH v2 2/2] PCI: hv: Propagate coherence from VMbus device to PCI device
Date:   Wed, 23 Mar 2022 13:31:12 -0700
Message-Id: <1648067472-13000-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
References: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:303:2b::24) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09428e1d-bba0-48bb-6b21-08da0d0c235b
X-MS-TrafficTypeDiagnostic: SN6PR2101MB0942:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <SN6PR2101MB094283C49A56680D3699C4FDD7189@SN6PR2101MB0942.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3ySo2lXKl6zIiZBW3nWjpUeHZVqaehBmfFITXC1425SoIpNTQDA6+2xJ7xJjaeWBzuMnsRsbFrTJi+UYhkVfGQUyEwwMIkqWY2s/5byy6hvYpVl4dHx0d/4clNF65JVQEcZuFTbRzrQi9T5/P6e19vOS04GN3zXcT5fs0Arp/rIuvG3V2y7eHEkkC80cd6kZ2m0F2nnNlgHZFSd4lEPJhCBa1VgwShKV5Lm9XBBxUQe4yfB8+FLAdiz/uYLqHeADkixhUNgKGr3uuPu+JZiE605EHPN6oOLl9IqLD5LaJN/E3YcKIT13NaGOTn+0gvLAEL1rk0hGyneuxihj+zoZdLfhhaAANI+TTEsV83evMYJglLjsApls5D5ikvYaumhNDbZvr8Lp+hbI9aTgQZ4cm7NCUJ3VuScIwIMXTpgTvcEMp+jT+SDPIOh2OJ2vgwoisT+XKIRVijEdZiOy1f32nbn9utpBwZhlgEP9InJmz2qdp8aPed5oe4qVWyScXuAt0x5qCARSwwdRSBXnHu9lP8rYEKItDkjSyfb1j+2rbxWBCa+8vyrUzIhXmyJozLYYjsf0XjPjdza8YRe4VxnIBCuVXX4+10x55TY+kxgrB/cZnfbNRBen8Igirhe+ijNKObCCIcV20DOijPO0JNcX0Qf6PkQan+M79hXjfbBsSFKeOWXcWQIwKWzKeyqN8kJGpxWJ2JxoEeLMe5tmJHumTi25/ay06sP8RddaGt3CJpM5Gh0KkpZUp6IKZv/I6ABoNUlHPPVIPu6mGVLK0DPpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(921005)(5660300002)(107886003)(316002)(7416002)(36756003)(38100700002)(82950400001)(82960400001)(38350700002)(2906002)(86362001)(66946007)(4326008)(8676002)(66476007)(66556008)(6486002)(10290500003)(8936002)(26005)(186003)(2616005)(6506007)(6512007)(508600001)(6666004)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FhRkgwpAeiWFcCBuhlJ98YHisBWoxzDuNIdCAEzn1DCh+slkcVDt3H0NyIrf?=
 =?us-ascii?Q?o6kP1Kj8xKKABHiXySoloJVuZhUEHdKvhh3Tk5kxUAV7njwTxMD9dJlk0EtQ?=
 =?us-ascii?Q?qvy2TQnw3v7FlWtY4DeOKR/eiBnnH/wVJagNxTvP4WIVWC57kbl9sjoB6dPE?=
 =?us-ascii?Q?oRUxYuCmwccmKLkTJTH4mbeqsv2F7pYFxNY9UA3/4uFCaoQq2V7pi0secaiZ?=
 =?us-ascii?Q?ZyimwlyD61hGLN5dfkrQkKRDEpDHdMLbiwuZt59oEGk1CxMI1hvkYZ5iL2pO?=
 =?us-ascii?Q?wtoNH0S/4IteRSs4A/o08gxRr3OCeSwRH85rTgBXLggZpk+7H583TMICR/6C?=
 =?us-ascii?Q?5rtADVgnWPCiRlK0Zu4GjVNRFZbUZkkM5nhfRe9wgf85EWbF0O2TW30Aw1yh?=
 =?us-ascii?Q?o3iVAuDkzwKigCNwVjuY+EPcgrNg+zCte5b3KGmWXGV7R44aXC+TdKsb8J74?=
 =?us-ascii?Q?yjZh8f9By7IWbnLnCplsVjFjSEMY75Kw8i6OMzgNJ7EmAxue7HFFKheFkKIe?=
 =?us-ascii?Q?UNE6UbhcC7i4V6mitmCLq+3LfFi8DYmYaaXzy+Ld3kXqYcATtr7CdBs9D9wQ?=
 =?us-ascii?Q?A9zzFqsMg+c9+H4BtFM8mBAmK1BHo8b45B8bETLZDIdNwZBPlXuFQXP2DJXq?=
 =?us-ascii?Q?K/kwWSqpaxa7w312/Iord2azBxc1CpmcWqWqhYgKQTflHFp5f2XsfUBj/G8C?=
 =?us-ascii?Q?vg/OOyqrPtECbA3m1HH+XsCYm/F1hjy2TqtVJFReBhg2EhTumtPEdXYIbrYd?=
 =?us-ascii?Q?pc//8qE5TuXlLhcZRMmFOYkwXVppYLxX4KFfl01lioaRgWjcgu57poJn6DWp?=
 =?us-ascii?Q?XHR/zBWQVhm3BK5V/Qtb3mWFo/fTf/IyOcOn3SXbaZqrI8YYp8yr+K/npejt?=
 =?us-ascii?Q?5f1jaTv19Aqlz35+vm9ml0OHkrGbPMH+Be5D1keT/E9ySige557JnrepQc8e?=
 =?us-ascii?Q?YlbVGKBPiwtgyl9uq3lRC3p9EfPat/t/P3iAIrM9A0s9gdo3AaWYNPNQV6TC?=
 =?us-ascii?Q?RukwGp6yoEBkISNgr4P2A5782kd0QEeWTvTConbn3Lh7Wx5/2xS4uPt8PRke?=
 =?us-ascii?Q?RqI9yMbUpxL7DnRnMBD3Gg7yvnG7gQcqobgWmV+wt4+w+0SjK5KnFtqvlmVj?=
 =?us-ascii?Q?mxbA/Fi/xVOSUP2pvnL7Sk8nhWPt786WjSPFW43ObvGPJXgbL1K0QeobZZ/6?=
 =?us-ascii?Q?060IKSgOw0hyrBbO6QPB4zCnlbfuo6pHVb108SGRJvNn+Rgx8ut24G4xbC3Z?=
 =?us-ascii?Q?62iJBheGYblDw8FlBLb4H41RKoAzmiJvlYr9Jk/3RMoEG6xz0RSobsdnCCCR?=
 =?us-ascii?Q?kteozWMaoSNpFaeI6pfH3H5qmZTBIteUt7Jb16f0igL0DlTXRSdzzvmWOMA3?=
 =?us-ascii?Q?Vx/L/IrreyP1Udawqu7iY/bG5fCa56Cr5WmP3ar4jn8ugGmfD9SOv/Kyjx85?=
 =?us-ascii?Q?z69jCKrk9iGFxnAYcxd5rE88Aysj0PFvvp36B/j4ubsM3oV8chNhKIqITLar?=
 =?us-ascii?Q?GYKdpfm4UfBJlRHeEqWqqzU6hh2VyjMKiIzLLop5QtGeR6Gu8Hy7NUpc3YDZ?=
 =?us-ascii?Q?0nlyxVVCA7vMohFuwCkKHQP13Ah0qmZvidSf5H+9FZt2d2grWvs53QaNPrIZ?=
 =?us-ascii?Q?G0rT234mRLzJKt6ls2iZbMZP2rOu9UPqQhQXsOQUMjinF96+4XA8FG2UPkJZ?=
 =?us-ascii?Q?diCz1Q/pUcb4NoZydWTbgIWZKTJeuSxIgzYk/rlEOw2rF9UmLrge/xT1EE/U?=
 =?us-ascii?Q?zw/Utz5DHQ=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09428e1d-bba0-48bb-6b21-08da0d0c235b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 20:31:41.1358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUQrvMNEm3AMc2z4Ef8geSz7jrsMZSOQhMhmOV8hj1vdshsTkOl+bG3q+eQQAbdhMUY3pSQgKq/BUOAvBOnMUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0942
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

