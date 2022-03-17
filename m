Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67834DCB60
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 17:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiCQQ1L (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbiCQQ1I (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 12:27:08 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67C1E6174;
        Thu, 17 Mar 2022 09:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jso8lGDRloSWDlJ9ed9eAN6Lu1mI6F2skw+wU6uioHTK0AYsg8FOc+DLR6Qit71Hj9MGUB8yMSuigJgTexkDWvkG+GlbXg5LSZWCguHeMPdXDEMHEqdkkHBni9Y/n65dxxMCiIDj0pUxsMryLpDEYfl4qnBua/23adB7Nr2x9y8qj0ibK+4YKGqMnO8bbGKqqFBMS6Pi6h6/TgV0ZhwW8f16Lh/VMTkcV7zI3I0ZBiqB5CCdKoTksx/u3pB+6kkgwYB4HTn9QFFh6V6wIygYi4XdJf436/a93VNytvMPRf20IoQvPkAmzW5Fi6M4kvK343ZgE9tLiYa6murvlvQhcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMBkvB8XqJXPIW9KcFtQrPV7sFII7sr9r1YK92fPbUg=;
 b=d+BvDfcDIhmBuHaZNbzSRDxH7F4kjAN685yNS284908+AH0j8718JeaexYEjhfKJg4/IT8OU84rSctkPIm7M1U6tnzEhh4h9+pK7IH8jJYMjLvgsTpbYLQydgpBaO/0L0TjKpEiLmSV6R8yLqwJOIPOJGHWB+s8CK4Krz9YwSBLUbghFJbwwrXuku/fQCRbL9akaSOkvwOxN907o4m+tMMdR/B4iJxFwELbjdhLrzQSUkP1cn6Ba53o5kvBOnW/9AbJl+38UPZar6EVOQgl4fFLofhjZoI+yBaFsBWItXiyA15DqeIpJ0wUZNKUaAAsBKTHXdzz+0kvzf9JZzTWUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMBkvB8XqJXPIW9KcFtQrPV7sFII7sr9r1YK92fPbUg=;
 b=g/T2hVXJton/8y0wyTwv8nl2Mb45A0mPQkEj7j4zKmcpxAYjNbLxHMxxlGgEA0yOTZoefNfTrg0acSvE3FF1sUjPKhJI1NexYJGJwk0GkjgSZs0qd68BBB2PUEyOqVOyaJywYGoSd1epWFZwcHGNiB29PNZMH/Bbg3Dn5/TigUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BL0PR2101MB1796.namprd21.prod.outlook.com (2603:10b6:207:19::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Thu, 17 Mar
 2022 16:25:46 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357%4]) with mapi id 15.20.5102.007; Thu, 17 Mar 2022
 16:25:45 +0000
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
Subject: [PATCH 4/4 RESEND] PCI: hv: Propagate coherence from VMbus device to PCI device
Date:   Thu, 17 Mar 2022 09:25:11 -0700
Message-Id: <1647534311-2349-5-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::6) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eb045ae-5cb7-4bea-3391-08da0832c9e7
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1796:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BL0PR2101MB17968020C19544492D164B16D7129@BL0PR2101MB1796.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nmNVD7+VrwOL1LWsCZ5yDAm6zK6hd01a13m7Ds1JvPeSQwm7+Pr5aptTDpmmKIvVFUmvdjesTWxChcUU6+8WZtykwJO+4o5X/lgpmFBxvhnIAdqsYIAH00ZEOwWK0RF3O2yZCeAsUMCnurN8aX+R1MLxeflPdX5jztN498INWwWP7VUxEiRxJ+TLUGDZhmAWggxU29Mx2BKIlt7FBFCtnm+mnEowNXqAWUkbZYtTvLVHQ8/4+3uYxLgiixyq8xkCl9YWeGxrQRj+lcuAv7SYafWr5FU3+zGVE4CKtJ2mEGcuELFHbtF40+5N+eTw550xDekrNOw2uCGY3Te6r+WePilbBVzVHRRg9wS78skHEqRSD1z+Dv8H5NPm/q4pY1b46wJyfOL4Kr387Le9sGTNvITZ9I+H9k6oSD8T8HTu+SJC9M85oWBp25fpqG8WO/rZVOEZ6BxmXR219lKDA/NAsJ+XMWm/SySiu8U7CSOscqEn8v8CL4TobWM5zezEIU1HNh++3JIK0fawXogIIugJ6sn3NutNj6K4ARnlCrAeG9GKtZOdsTy/GNaMdosChCqCdyUD0quaV7pjK3NTXCrxkHvSlfNSWUM+qyA6MxJwI4TMoajXwN5R7VMaNWZd7mPC5pB3HY0iLl6LwcRtgxgVobsP3/keE9krt4p0qumeduBJjm+i9NacG4mL7DoYUI1FZD6Sp+xc/cCBJU+PHwOe8IzE/nWd6gz1dvNWH/cufqKXYR1EsOVt6FQPi1wGxj+I7Mt6F9WBIWTJ2xE5PEvfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(6666004)(4326008)(8676002)(7416002)(66476007)(66556008)(66946007)(6506007)(921005)(508600001)(82950400001)(10290500003)(82960400001)(52116002)(38350700002)(6486002)(38100700002)(8936002)(2906002)(83380400001)(107886003)(5660300002)(6512007)(86362001)(26005)(186003)(36756003)(316002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HFUBH3kH254ypgDiOcIzPk4/7ervIBIjyVW02Sb9jCkJvtPt7xF4ilfprTIN?=
 =?us-ascii?Q?CQWrzE8bA/t1HvTJ8gDdLjMkwwdDZi2w8VzQn3QGHVSzFSFL6aH/SuJcq/Qm?=
 =?us-ascii?Q?PJhCfjCCm/LY5Hq/2KtKhsiyGPvGhAyh8Ooz4D0aWIr8BszlT1tY7JyyHaJT?=
 =?us-ascii?Q?lW0Kz1qJ8hIBjqyHU8EjbgcqkTtnyJ39TEJNQbCWh470pEeGUhSdcw2myMvd?=
 =?us-ascii?Q?HuTscoSbLutYefnVRf85s0was1A7kvsXiMFu5E83WQqOPR/xc/86aKbfs0Wz?=
 =?us-ascii?Q?ttz27mAnUQ3EFe5OqZoHCQFyFZp1BRzooYmTVtBFIqLDALGPU6B6RNklEgOr?=
 =?us-ascii?Q?a6b/ooz+QtM2QaHbyJzVYTYkWwE2ctTdTrYES0uW3JZl+C39Ts32zQsdR3wQ?=
 =?us-ascii?Q?JY5PHzpivAvoYTXT0QNG7xATnyJAc6QJhLDSp9BPWtXa5fx3vPx5YrTdTep3?=
 =?us-ascii?Q?dReMCZmQia9uC33Wn8awqk/NeHtvWMyElzLa3TJZA6CoSSREkrx5E9y/P2E+?=
 =?us-ascii?Q?X2vx3lQM4Bd+e3vDSqyIaqv3Mo7G8vEsC7rqKhg1fdBN1l6oLCIzJLwvJYTX?=
 =?us-ascii?Q?woeVFJeIma2LwUxFc/Lyk6UPUSMB+tDLmySNSYn5/PR+4A6SxLu08fZX24C2?=
 =?us-ascii?Q?Uj2TR601MIbvdNYYSEBMFWO9uETAlB2CcgTMKt2MpFB5SnRVVv4rZfRbgv2l?=
 =?us-ascii?Q?HEoPLJUqY4kGlcfkEzh/BpHEKp3jAD6tY4SHVcYbXu/iPYH4kkY7sj0lHf0V?=
 =?us-ascii?Q?e9v+nfvLvAG/ACy/jxOvarEnoIn0v+bMvfz1DEu9yOxtqJ0+ejoQIqtQrPvj?=
 =?us-ascii?Q?QP5RjybJ3zaga4JTgcUIoq2p1hUvncjarF0SAjqk18c6os20LmCpxnmL50k9?=
 =?us-ascii?Q?YrirZ/nzeEY7bpJL2XIxbHcqJmTsqeErnIOamcuUDH7CHgITisn5eEOWLBXX?=
 =?us-ascii?Q?rIffQnB+xCKXVIv/Pb5qEf3Xb1ZN/ubCdXBgQzBxbTtPBf2SwQs1V0Y0jMUx?=
 =?us-ascii?Q?m9O0SRNAbga1gr2bry/MwCLseiItx2Vt0L+160BYKwlExFNtRZiRqoQgJhNx?=
 =?us-ascii?Q?YMCt5DiyLbruD7cLsZ37DehGEBT6+H5rFPYXiizbQf7GLR/BToLTVbx8XAgH?=
 =?us-ascii?Q?i2MLsbgV2EgLpVQApUF/z9tGvyWnInkJbBPjZ5LmryiHVVcn/V6knSxv/Rau?=
 =?us-ascii?Q?n/Gxc9uiOj29pzFxstTSxHYFmP9bX8tvBG4H/LA4Kil+uVnkEeJzN+2jla5W?=
 =?us-ascii?Q?t6q3oyl8gmPqOmod+bNm4cxsqJoOEG8Sm/HiBjRDSQgZTGnBHxHmrW19T6rm?=
 =?us-ascii?Q?XMyMhUU/8CmPrd7Pg9os+64J32bJYRC12+TijTRg1BMLBEdfOOrOWNfS10F4?=
 =?us-ascii?Q?KoA1bX+RP1JTAoLvxv2Qpp3mivH8lrd5qtrFDNuRB8HADmpy3dMt11iuiU9x?=
 =?us-ascii?Q?aZQ61EumhJk8AGLYkYoEjNnuoCzImscAHmEVArZIdtLeD6khIi28ig=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb045ae-5cb7-4bea-3391-08da0832c9e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 16:25:45.8216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkT0jZx7Ru7C6rkvMwD+JnVn2oeWLXOkfGR44Zn5QUH5Lv7k+sI95cLck/lq0g+rCxkjare7PYTEofc7/+1lYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1796
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Fix this by propagating the coherence of the VMbus device to the
PCI device.  There's no effect on x86/x64 where devices are
always hardware coherent.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ae0bc2f..14276f5 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -49,6 +49,7 @@
 #include <linux/refcount.h>
 #include <linux/irqdomain.h>
 #include <linux/acpi.h>
+#include <linux/dma-map-ops.h>
 #include <asm/mshyperv.h>
 
 /*
@@ -2142,9 +2143,9 @@ static void hv_pci_remove_slots(struct hv_pcibus_device *hbus)
 }
 
 /*
- * Set NUMA node for the devices on the bus
+ * Set NUMA node and DMA coherence for the devices on the bus
  */
-static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
+static void hv_pci_assign_properties(struct hv_pcibus_device *hbus)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus = hbus->bridge->bus;
@@ -2167,6 +2168,14 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
 				     numa_map_to_online_node(
 					     hv_dev->desc.virtual_numa_node));
 
+		/*
+		 * On ARM64, propagate the DMA coherence from the VMbus device
+		 * to the corresponding PCI device. On x86/x64, these calls
+		 * have no effect because DMA is always hardware coherent.
+		 */
+		dev_set_dma_coherent(&dev->dev,
+			dev_is_dma_coherent(&hbus->hdev->device));
+
 		put_pcichild(hv_dev);
 	}
 }
@@ -2191,7 +2200,7 @@ static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
 		return error;
 
 	pci_lock_rescan_remove();
-	hv_pci_assign_numa_node(hbus);
+	hv_pci_assign_properties(hbus);
 	pci_bus_assign_resources(bridge->bus);
 	hv_pci_assign_slots(hbus);
 	pci_bus_add_devices(bridge->bus);
@@ -2458,7 +2467,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		 */
 		pci_lock_rescan_remove();
 		pci_scan_child_bus(hbus->bridge->bus);
-		hv_pci_assign_numa_node(hbus);
+		hv_pci_assign_properties(hbus);
 		hv_pci_assign_slots(hbus);
 		pci_unlock_rescan_remove();
 		break;
-- 
1.8.3.1

