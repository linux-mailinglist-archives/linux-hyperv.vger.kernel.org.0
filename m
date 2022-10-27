Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0F46103A5
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Oct 2022 23:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiJ0VCA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Oct 2022 17:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiJ0VBp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Oct 2022 17:01:45 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021020.outbound.protection.outlook.com [52.101.52.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A830D8EC9;
        Thu, 27 Oct 2022 13:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPNewB/V5y+5llnm/I6Dw5a4051FIZfOCKfdTTeUjoPnvNmMwLwdIxLCo2lLkHf/oYnaFENHB8jCCVbCzrFnbPwPlgmgmm0NMZPwjdin8SNPZdDAnXpJIcquIZOH4aJIALkZ/0B+1n/BeS6NcNOXAuF6m+qp/b1aawkcpBJ6swJeVZYkcLtjvvc50UiGEc6QkEhZdUuXzbXXDEOr7/dwzit0WM5C3v5JE1oPMVZzy9pE587JCEqVT+4qWWRPltmgQIC8nq2dQ7aEJc8OOqnt5hf8xHHlpxrEZheIctjdtKJBPggOW9sUJQDKo9crchU/F3av9DSiQQCH0YnPdxXbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcOHf/hf7oXdNIZPHPwuKyINg0VLvdre8r4dKg4STvg=;
 b=K9EUFPKl4RIcENXrh/WDxpukQYiE4LTuBvRrlOdVYGmuYUXiMFDkYsSRUbp72LA0WNeiTVJqVx1F3MjGzcqSlFnHWRfGlKWExGuYrFe6msKJDUC+6+Ucyc4lC4SPD1D9zbIXc/61gWodfHVYeEExeqk22ZkeWa87bRpMmYN1JkTmOpcutX8ft0RRDCUgRqTTsg1XfODuc1+HGeI+SRinjh1jLKiAhkWMA7SCkIlEX8q77d2lfEVL36Go9K7WVpMiq2Lu+4v2iM5i68+mq0YijH4YEj7A8zGZOfHT4G92VCB1D+DNLyhJfZe8EmqhAFF9uynRPNUhs++0pXQ7bIQRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcOHf/hf7oXdNIZPHPwuKyINg0VLvdre8r4dKg4STvg=;
 b=TYix7zQfRSS32Eh5g4z2y5XF+WuhuR1VaHsKHxfHzvZhYDFhqo+J2babEa4ljEgXSe/Zecr7dSNKaREK2+FGIvvLElQ6Nl15+sVv1vZlmYZ1+k0QY5l1Rkj1IL0keIveIdDhQq4xzESPR8WshzXG/buGWBPP5jh0sP8MoheEwoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DM4PR21MB3705.namprd21.prod.outlook.com
 (2603:10b6:8:a0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.8; Thu, 27 Oct
 2022 20:53:21 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::a746:e3bf:9f88:152f]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::a746:e3bf:9f88:152f%8]) with mapi id 15.20.5791.009; Thu, 27 Oct 2022
 20:53:21 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     quic_jhugo@quicinc.com, quic_carlv@quicinc.com, wei.liu@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        robh@kernel.org, kw@linux.com, helgaas@kernel.org,
        alex.williamson@redhat.com, boqun.feng@gmail.com,
        Boqun.Feng@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] PCI: hv: Fix the definition of vector in hv_compose_msi_msg()
Date:   Thu, 27 Oct 2022 13:52:56 -0700
Message-Id: <20221027205256.17678-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:303:b5::21) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|DM4PR21MB3705:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a707c02-f9fc-47f9-0ef8-08dab85d4846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46Rb/BLXPlQ2JA15yi0rd4UCCO+D4O52JNfD8qrhCzaMnD624uwORs8FhADPjD7/eytBWJE5bEShwNT8Pk5H8RMG9qDidqL5BBTDStOcp9ZTuAz6XaXDa7S8CE1Vz+OSXt5Lf15xASHvIhqVOyyNfKgBXN3YuSUw2aylperf+KiCDUU8g0KNLmvdI5+yYNKewgWOKcCqlK6wsHD1GdHx5RnfcPdIopxvtR/VNwAKQmdvE3I2807DjQpctAQq8Wy+c3xCopl/oFvfS/Ncg7bQaSCrwH+RwbkWdtgchLBDNcStDKShy/u8Wdprgg+qBez8GrsLpuUXP836GXRjkRaVj91b94Q/OHxSaCPXAFbLDn7WtEdZbqJf9gKm6U9AzZZPhHLlVwaUQ2vOl9FqBYOqOUdAdR2arrVvGq/0vUgzGpFxT3QDUjZ6jpb3c7/yro+rGJsDzzBYBUwgBZlBTwVJSvOfzBFJaF+eaZghN1XqkX1Jtq6ZHABBKMr/s/0m/Xge9ZH2COF9zLVtxCFoJD3R3YPB4GMdYKepD4ZpFrE+pi5XEM+t1Njiv3fOTjSwAYZ/HmsmxcWcMt/bS0xcOPukmQko73ZwxsHK/InLhAqmdvjwTyveadbGNBK9zRscVWw3cwoffJ1kR96UqbHm68rlLgcSErGaiU6i9rRayfVDKrSGAzIBC2INWh36uxIQJwFvYhhwQtrD2hFhw5g0AMZYy2ByhV/VSJ7uYk6N6Ynykp/b/Xy+3gOKwZag6uToPRGX/mQ8+4P9kj/4sn4vQYYIP92UdUlstKL4hROUJqjJmWvISU2f+S4st7GMmcCOF5WP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199015)(6666004)(52116002)(4326008)(8676002)(66556008)(66946007)(6506007)(107886003)(36756003)(66476007)(6636002)(316002)(921005)(38100700002)(2906002)(186003)(3450700001)(83380400001)(1076003)(86362001)(6512007)(5660300002)(41300700001)(2616005)(8936002)(7416002)(6486002)(966005)(82950400001)(478600001)(82960400001)(10290500003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H0fIkb7xrTxGkIFE7FRimysRKk4U92YJTrmO+MSFfkZN2ES/gZZIhyUcqVpk?=
 =?us-ascii?Q?YDT/GdmxU6PBCm1ttYpVacgrTuWzjkJ5DjinUxEWTjHdRxOM2KolgQ2O0BCw?=
 =?us-ascii?Q?zMF5KCxG4Zuravk3fstLQ78wzHI3/tlETyV+OosBw6cxM85QBVTHuoqG7v3J?=
 =?us-ascii?Q?3xxdaiJx3EtoPvcUh+Ucy5oqPN6+Q4oFyoN4eQxeu4qHeuLUCco9+iotkFgG?=
 =?us-ascii?Q?8224jOUbKHaAEfE5U5sfwSxiaTfSTSnx13m6N9SelooO4fTx8HsNQvNoYuQZ?=
 =?us-ascii?Q?zDbWDiCSB/qtO8raa7ASFdb8sW2QvRecAVTV6gIRO/Y1uhxVmexOUyOaml2W?=
 =?us-ascii?Q?7r7EbyTxQpoFwmG4paQevoO/2r20n4o27mdwTqFRXJ/ZiqzLm4IIXomZi+/h?=
 =?us-ascii?Q?SValrN3CM/xz0No/hjApVhKjHHScgIL/soaKnAido8mwCRvKB4aLYGCWTtuD?=
 =?us-ascii?Q?DEeB8JekwFSwGRYecmMu66x1DCz9EEjYAjPMloUij1vZtPSbajHzGIb9tA9C?=
 =?us-ascii?Q?wZXuhKdyadr40+Ay9wUE3OQHaAVxD81jbJPpozrVeXRQnAd42Zdcm99LyKrM?=
 =?us-ascii?Q?OIDohQN6MZbQnGvpajrmRXVUEZteGIJSfKkPEtwXHPn2ssNQQQUAJE2qHYMG?=
 =?us-ascii?Q?vu2MZNZgp8l2U5pH6rbfUKR8V/0OtQt9uILGgAq3efkhPMkY0B40uGBNSilj?=
 =?us-ascii?Q?lbYQXRG9+01EEz6OVc3iESUi9fiBu1R+hGNFPNBdmSz927Jbfhjp6jFeI+N1?=
 =?us-ascii?Q?YaeApPqCxdD4oyceSe2I2Wh3jJ1VpWbylz6yoGh8RjinLpEYEaQYmNVonQe1?=
 =?us-ascii?Q?pWfTbJKThiJYJ0LFT2D8tqkjGNjRjPm3zUW8b+J8KZCJIwX0fCAsBK9STdFP?=
 =?us-ascii?Q?UA+A/PxKPZETTKI+tNuFyuw3zCpD1QDyWU8dhUjZl1/1Hi0wkuMjV6oHaW42?=
 =?us-ascii?Q?rdW8R0BfQCm/+mUHAi3xzeZhq/ul/6knL7jXzR79qJMFt3Ob1C+YN+O86gKq?=
 =?us-ascii?Q?CijTmUpFT0jGPBxIMZefi6Geh06GxfN1IXCAbg5piK8d8QOTWXelzW2vwpyS?=
 =?us-ascii?Q?8ocn51zgE0NAvfNC5ZtcBp28rmgVFb6N4+waR0PBO+tAcWMSsUAqEj+n59sW?=
 =?us-ascii?Q?yN4hHeu/n1dAFB/KSsKy5PWhuGklcyZwP8ya2m8rrfh2czGv9ajRgGmVBoVs?=
 =?us-ascii?Q?kb7Y5fgQqC6Ye0jR90ak+TaqqFqrV5jJKysTODz8prUU0t5j0bAMFdw2F0nV?=
 =?us-ascii?Q?6HG7ZtOBWjlBfFQM9f5FcsnhvkWtmJJcnfj8w7EPN+gy6Al+enKzzlIE/wBd?=
 =?us-ascii?Q?1CXoyBjG/fFp88pS+LOZYlF4upCuPA8Zu4FaTxSARAds3lqemcXFGW4+4yeq?=
 =?us-ascii?Q?3BIeaosLYFjaQQYRQ59cfb+MXUWxgbKn1TmFV/kX48X1OcziNIPuxK1HOMCt?=
 =?us-ascii?Q?cMeOWGfHEsBgmON9NyiypXRvHpi4iqfiVjummqunM32At9dvNIYzMJO+6kdO?=
 =?us-ascii?Q?wSbkgAtCMhsBZViGsIuTEJrVJ3Hyy33Kk0RqtlrMT3wLaYvJhX302ADTH6ux?=
 =?us-ascii?Q?HLLiZe+6P+XKV/54RTls2rzVP+3pUxbuVBN4AXLpbPMEQLR72KOEaPKrswXQ?=
 =?us-ascii?Q?CqMF1MTkiXGUh1v2/px3X1AUqpNqBRV9dS0luZEsaZkr?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a707c02-f9fc-47f9-0ef8-08dab85d4846
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 20:53:21.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Di7yBON/0no28BtQB3XJ5Xs0fNaufxI17yglb9zik9E8MWtTAXl9xZM7wj2dMRVVkbwTFXRr3aYmW58z+DtIGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3705
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The local variable 'vector' must be u32 rather than u8: see the
struct hv_msi_desc3.

'vector_count' should be u16 rather than u8: see struct hv_msi_desc,
hv_msi_desc2 and hv_msi_desc3.

Fixes: a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Carl Vanderlip <quic_carlv@quicinc.com>
---

v1 was posted here (sorry, I forgot to follow this up...):
https://lwn.net/ml/linux-kernel/20220815185505.7626-1-decui@microsoft.com/

Changes in v2:
  Added the explicit "(u8)" cast in hv_compose_msi_msg().
  Added and improved the comments.
  Fixed a typo in the subject in v1: s/definiton/definition

 drivers/pci/controller/pci-hyperv.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e7c6f6629e7c..ba64284eaf9f 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1614,7 +1614,7 @@ static void hv_pci_compose_compl(void *context, struct pci_response *resp,
 
 static u32 hv_compose_msi_req_v1(
 	struct pci_create_interrupt *int_pkt, const struct cpumask *affinity,
-	u32 slot, u8 vector, u8 vector_count)
+	u32 slot, u8 vector, u16 vector_count)
 {
 	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE;
 	int_pkt->wslot.slot = slot;
@@ -1642,7 +1642,7 @@ static int hv_compose_msi_req_get_cpu(const struct cpumask *affinity)
 
 static u32 hv_compose_msi_req_v2(
 	struct pci_create_interrupt2 *int_pkt, const struct cpumask *affinity,
-	u32 slot, u8 vector, u8 vector_count)
+	u32 slot, u8 vector, u16 vector_count)
 {
 	int cpu;
 
@@ -1661,7 +1661,7 @@ static u32 hv_compose_msi_req_v2(
 
 static u32 hv_compose_msi_req_v3(
 	struct pci_create_interrupt3 *int_pkt, const struct cpumask *affinity,
-	u32 slot, u32 vector, u8 vector_count)
+	u32 slot, u32 vector, u16 vector_count)
 {
 	int cpu;
 
@@ -1701,7 +1701,12 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	struct compose_comp_ctxt comp;
 	struct tran_int_desc *int_desc;
 	struct msi_desc *msi_desc;
-	u8 vector, vector_count;
+	/*
+	 * vector_count should be u16: see hv_msi_desc, hv_msi_desc2
+	 * and hv_msi_desc3. vector must be u32: see hv_msi_desc3.
+	 */
+	u16 vector_count;
+	u32 vector;
 	struct {
 		struct pci_packet pci_pkt;
 		union {
@@ -1767,6 +1772,11 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		vector_count = 1;
 	}
 
+	/*
+	 * hv_compose_msi_req_v1 and v2 are for x86 only, meaning 'vector'
+	 * can't exceed u8. Cast 'vector' down to u8 for v1/v2 explicitly
+	 * for better readability.
+	 */
 	memset(&ctxt, 0, sizeof(ctxt));
 	init_completion(&comp.comp_pkt.host_event);
 	ctxt.pci_pkt.completion_func = hv_pci_compose_compl;
@@ -1777,7 +1787,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
 					dest,
 					hpdev->desc.win_slot.slot,
-					vector,
+					(u8)vector,
 					vector_count);
 		break;
 
@@ -1786,7 +1796,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		size = hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
 					dest,
 					hpdev->desc.win_slot.slot,
-					vector,
+					(u8)vector,
 					vector_count);
 		break;
 
-- 
2.25.1

