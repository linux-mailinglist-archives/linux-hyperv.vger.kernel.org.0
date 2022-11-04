Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D644261A419
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Nov 2022 23:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKDWa7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Nov 2022 18:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKDWa6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Nov 2022 18:30:58 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11020014.outbound.protection.outlook.com [52.101.51.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB2012772;
        Fri,  4 Nov 2022 15:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFrLBshBEalAzMKJUiVKp+YBkUB42nw5qY4sjGpaDnvzpkem8IS1tXT5HMy8g7IyPOThywLnVh18qtSqMGdzOrTOx1TIUUlrWg8IP9xHrOf2yFH4VUBAqlhf82sx9W3/oBE237cPpLr9V6DDPlzLmM0dQNYJ0LR2NpTjTREfGxFBBt6IgMkDMjnlLlhfuQrR/JRkkpH+S2x6dvZZHt2fSADEReLlu/e89g1Vol2VG38gnkxf0/zjyCgf8Y36OP+F+hHKJVqCksUt6RjB5kkmr3p3xVT4dxdHlEKjr8kYlHymSoclR+JEYeOZ+OfKX/74Mej/Jsggy+o8qdgpmZoVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIy97nKAhxl6T0cZPnzjuU3vHWT5tjhybn9x2Jdzc34=;
 b=lrmS2whf1YtCemORcQtxp3ismG0fGn4uv2KYDhpElcfAployDh8lduRZLvS9hXCFINd7l0AL9y/GSVXMXScHF79Ir3It9qGuPn/z80KbRFjPp7Yjvt1iZf7iUd2x8hkP55xTPToJ3IWu406J5P3nfRsdMAtVZgEFy1GbPgwuC3vWpOas5c+Ya5Dm3WbCEaeiyHQlXxfJyKb1rlu6RZdv3bQRUYbRAXgRr9v63y6tuHX9NbOuGURswB3IRspH10v/y/iGjTGcnyVz7jkfKiZ3U5EpYaV8h9So0ZHnW1CiEdqeAElCnPQFr+os7CltC+rNB2Qm0AaoNGcTwGssFIwZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIy97nKAhxl6T0cZPnzjuU3vHWT5tjhybn9x2Jdzc34=;
 b=gENZpFIPGTWQyMoQV8zc5DZo/wbxPizI9GODglL2coiuygredIey9I0/TOQaCW+lbhedzYS2kKHLSahN2O4aDZ+qRbUYE5ZS/h47zwM3PxGmSaG5SFp5Z/+4eLCAHhR9XSUYWcoFZ42U+EuOXcz2OI0X0uoFVlgAYdGhK/rQX18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DS7PR21MB3100.namprd21.prod.outlook.com
 (2603:10b6:8:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8; Fri, 4 Nov
 2022 22:30:53 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::a746:e3bf:9f88:152f]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::a746:e3bf:9f88:152f%7]) with mapi id 15.20.5813.008; Fri, 4 Nov 2022
 22:30:53 +0000
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
Subject: [PATCH v3] PCI: hv: Only reuse existing IRTE allocation for Multi-MSI
Date:   Fri,  4 Nov 2022 15:29:53 -0700
Message-Id: <20221104222953.11356-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:303:83::18) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|DS7PR21MB3100:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc27d1d-65ca-4696-b8ed-08dabeb43b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75xhUKcp7xCtFTLS/oWead2cJn9Fgqu0iLbytDYssLAs1JY3npJjKM1KSNFNCqr1o5Ycf3ovWBxcJTWwbfhV3dcxn/n/eZXIdLAzedCZGkiGOY50+mKEkO77SAZudRdta9YqPxPG44I5cOwLGCCYqq7zbodEWS3S33fV7ykfIK6ZFtbeo0YdVU9UbhsWcXcFq+fmAmqL/O9reC1RdBNbspSsKqHT+GayerStawPodZMLGWEWYDPLnVZoi5Pq15kks+TjKhXRHLtBQoffeU/RvT3IKUHOT2LSZnvhpRAjTA+PS968eaML7PVvnlV5z6L62A36DttIAQIDZsRAhgCtoU5q5+iJQ2ndeUN0l+AssZoK/HvTbV6AmoBOz0Yf3iVhHGrFipmIeAROwdSE8Evp2XKlCr28WI6QI8oJq0s9ss1YzUpx2sirp9OE+s7XBegDUJVtH6yi9Ci3ZfIDeQpxQhizlYyh9ZwwYKq61KQLUHMwOs79WKDqrjjxM/6WlKelP6a98Gv4MZ+2Tjs6iMq+0SSXAXyyzijEQllw7TuIPtH/k6nNpiL0KdiipaISFIQbiTVqIIjelIpSfAp688lxd2FiriTCb48XhvNoOZ7WsqZxwMXQZ8q+VL/BNCINB/2XMHaPMCmCvvYJdMT1mvOwWfEq4dqYgchCcjfs5Of50LqUSk+hg/pHoMCTcCgKSFFK3s/+5iSkbOjzB8Z1dFngFSUH7VkF+pKrXEjUvaJ8L2EFxZ/wLIckqsms9Eb9A2uS/KvV1ocICQQwXouUMHBY7FhskzIzVAGPOCU45QEdxCNFlYS8Il7IYwCZqXsDEF/tRcldqo869KmOUYw6kG2EQ65nL0gfKGZOjXGoyV1xacmWOSe6gILaAdjmf+lDeOAg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199015)(10290500003)(36756003)(966005)(107886003)(478600001)(5660300002)(6486002)(66476007)(2906002)(7416002)(66946007)(66556008)(30864003)(4326008)(8936002)(82960400001)(82950400001)(86362001)(3450700001)(41300700001)(316002)(6636002)(8676002)(921005)(38100700002)(83380400001)(186003)(2616005)(1076003)(6512007)(6506007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JpbsCBaByjok2gTUTqs1aryOein6DaJP/GvzcTPXAE9v6ENJm4qqIb6um283?=
 =?us-ascii?Q?KlcPs2fGd1+ddQ4Hz6frwrPhRvyKo6S1StAUOG66lY7lrE+3BjC9z0aBf7Bj?=
 =?us-ascii?Q?7YIx9Gikj+n1E2/fHi8hMDDSnSs8WIlPWVuWIN7VouskatiW9RzdLBz+1YWu?=
 =?us-ascii?Q?wMCQcl9KkasAsK4JSfKtD4B94YFK9cKjnpoIwt8qZXrc9Vl21gEKGj3GweoN?=
 =?us-ascii?Q?eXBzfQvXE9yOnzDoiR2tJNqDOYocQ+PqwqlX0yIrtWtpmy15K+XeCfaWdcJz?=
 =?us-ascii?Q?mMo1hmENQNLSkjopmgl0CoR0AGzVGjYIzdXetLI7t6HpqM8ZUwcuQmmw0ejt?=
 =?us-ascii?Q?MftTwmbwxX9wBnLRC629GpJZoe3yNznkJRDl1s1GB/00Ac/YIWIgmkTfZRQN?=
 =?us-ascii?Q?BUeSjCI7B2eCzON7UbIrv9O7W3OZkWvH5odmkXQGOXH1usnEF4vA6bHBqFF+?=
 =?us-ascii?Q?8+wrxAnHR2tmM0+wdiE1cj1IntuUHgtwSCXpxXwDj2qyNMdKGl1MABgLLb4+?=
 =?us-ascii?Q?r3YHhVGQIM+GNmKVmqoolAiwIpnvbh9+pW+SMbm4t3W1JsYgdTcXbsBfh8hD?=
 =?us-ascii?Q?Ui9NKofTKFSI02LdZLKfZxWqC0BQ7eOAve1+sv89OlxUCuRFNFMf9jrcc1Hi?=
 =?us-ascii?Q?QRbJuVmZPzeh7yXem6jxAwhMipyCaGqWXW10sr7Dlj+TuGB/MfxpjebiSP5Z?=
 =?us-ascii?Q?OLo4bPafgGDRKsAf/m6dPJQRGkPKhGh1uTiqsup9FHYJONYlpZVEP7VBdso9?=
 =?us-ascii?Q?zeLRjagtwT4AnS0M+6viPZ/hXXeb6hr2i9NrbCoxbZS8JPXV6UKLLFlN7i65?=
 =?us-ascii?Q?0feV5x372Y9LS/JRVvZtWPu0LyxLfnkBw9XBJ0xwipbMnTlcsmQYCfplznlZ?=
 =?us-ascii?Q?kjQdfmvXmkJjbUWyxDEL2ejmZHq569nOYXYSzYd5FyResnveITmGS90msFpO?=
 =?us-ascii?Q?/osQjbhFt6nSvw93eAmb/5ZjEJcyIz7Ze3d+cxz1muEJitpqPJT/oIEoYTcr?=
 =?us-ascii?Q?Alezjh3FOj1EvTK7ovUfw4CQ53UrTlQ/f2E8TYsf8ibcKupq5IG0cgVYqBrI?=
 =?us-ascii?Q?rZX+1Kemfk+eWcXCt1EVGyWn6fDVsBPdk/BnY6FbeOjorLF0OkoOB1srSsrw?=
 =?us-ascii?Q?Q1gDqF7gWh/e28AGA9XXwsczPcW3pXJJg8h7eZ2+f7Mx8h4M+/LKMxAaXii5?=
 =?us-ascii?Q?qm+JdgqadoxonmdOzYRm012c93cbeHrsgG7k5JXu0hZLgYVvETOdHBX720Os?=
 =?us-ascii?Q?uz0fREUkJOjZX30NiTck43CZNVVvL940UM878q8EBw1LeLVodEagtcPvm7Hk?=
 =?us-ascii?Q?Zc3IzCPEF3uzhHa8XoUAi8yq0EsV4wJ9hrbcptFidnHYQU2hUwaY7FLRLzTL?=
 =?us-ascii?Q?gLdB26IRTsBw/2UbEx3S1JnUrvXTeYU20FsgMQuqnmhk/dJvBnC/aZBf4twT?=
 =?us-ascii?Q?uY8XOQpUFfiS4xeeRvVExiZrhLgXFmEH18Nc/IxEkTnPS5KvIfaIsjUGMvA0?=
 =?us-ascii?Q?dTP3nkZHZo0rDNEkf2ZSK3iiR9/qpGPKOlMJXlZ4/Gn5Elubm2bAzMIhp83/?=
 =?us-ascii?Q?l9PBM2fSyQnyXj10SCenNRCeX1yAsNtcUujHx3/16vt6zmehWKi7mSbPM8N7?=
 =?us-ascii?Q?rnqiJEgVcWO6gtQ0emOFlhL+JNUJiWkZLxGDpwtc7bgo?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc27d1d-65ca-4696-b8ed-08dabeb43b64
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 22:30:53.3849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uaqMbKieWtqqHmNxedU9raP9o7gZ71ogzZz+wN8oZA760OYnWO2Q79HvLeBBoPDUtYojc7ySOz8yES30C0SIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jeffrey added Multi-MSI support to the pci-hyperv driver by the 4 patches:
08e61e861a0e ("PCI: hv: Fix multi-MSI to allow more than one MSI vector")
455880dfe292 ("PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI")
b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()")
a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")

It turns out that the third patch (b4b77778ecc5) causes a performance
regression because all the interrupts now happen on 1 physical CPU (or two
pCPUs, if one pCPU doesn't have enough vectors). When a guest has many PCI
devices, it may suffer from soft lockups if the workload is heavy, e.g.,
see https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsoft.com/

Commit b4b77778ecc5 itself is good. The real issue is that the hypercall in
hv_irq_unmask() -> hv_arch_irq_unmask() ->
hv_do_hypercall(HVCALL_RETARGET_INTERRUPT...) only changes the target
virtual CPU rather than physical CPU; with b4b77778ecc5, the pCPU is
determined only once in hv_compose_msi_msg() where only vCPU0 is specified;
consequently the hypervisor only uses 1 target pCPU for all the interrupts.

Note: before b4b77778ecc5, the pCPU is determined twice, and when the pCPU
is determinted the second time, the vCPU in the effective affinity mask is
used (i.e., it isn't always vCPU0), so the hypervisor chooses different
pCPU for each interrupt.

The hypercall will be fixed in future to update the pCPU as well, but
that will take quite a while, so let's restore the old behavior in
hv_compose_msi_msg(), i.e., don't reuse the existing IRTE allocation for
single-MSI and MSI-X; for multi-MSI, we choose the vCPU in a round-robin
manner for each PCI device, so the interrupts of different devices can
happen on different pCPUs, though the interrupts of each device happen on
some single pCPU.

The hypercall fix may not be backported to all old versions of Hyper-V, so
we want to have this guest side change for ever (or at least till we're sure
the old affected versions of Hyper-V are no longer supported).

Fixes: b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()")
Co-developed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Co-developed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Signed-off-by: Carl Vanderlip <quic_carlv@quicinc.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>

---

v1 is here:
  https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsoft.com/

Changes in v2:
  round-robin the vCPU for multi-MSI.
  The commit message is re-worked.
  Added Jeff and Carl's Co-developed-by and Signed-off-by.

Changes in v3:
  Michael Kelley kindly helped to make a great comment, and I added the
  comment before hv_compose_msi_req_get_cpu(). Thank you, Michael!

  Rebased to Hyper-V tree's "hyperv-fixes" branch:
      https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-fixes

  Bjorn, Lorenzo, it would be great to have your Ack. The patch needs to go
  through the Hyper-V tree because it's rebased to another hv_pci patch (which
  only exists in the Hyper-V tree for now):
      e70af8d040d2 ("PCI: hv: Fix the definition of vector in hv_compose_msi_msg()") 

  BTW, Michael has some other hv_pci patches, which would also need go through
      the Hyper-V tree:
      https://lwn.net/ml/linux-kernel/1666288635-72591-1-git-send-email-mikelley%40microsoft.com/


 drivers/pci/controller/pci-hyperv.c | 90 ++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ba64284eaf9f..fa5a1ba35a82 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1613,7 +1613,7 @@ static void hv_pci_compose_compl(void *context, struct pci_response *resp,
 }
 
 static u32 hv_compose_msi_req_v1(
-	struct pci_create_interrupt *int_pkt, const struct cpumask *affinity,
+	struct pci_create_interrupt *int_pkt,
 	u32 slot, u8 vector, u16 vector_count)
 {
 	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE;
@@ -1631,6 +1631,35 @@ static u32 hv_compose_msi_req_v1(
 	return sizeof(*int_pkt);
 }
 
+/*
+ * The vCPU selected by hv_compose_multi_msi_req_get_cpu() and
+ * hv_compose_msi_req_get_cpu() is a "dummy" vCPU because the final vCPU to be
+ * interrupted is specified later in hv_irq_unmask() and communicated to Hyper-V
+ * via the HVCALL_RETARGET_INTERRUPT hypercall. But the choice of dummy vCPU is
+ * not irrelevant because Hyper-V chooses the physical CPU to handle the
+ * interrupts based on the vCPU specified in message sent to the vPCI VSP in
+ * hv_compose_msi_msg(). Hyper-V's choice of pCPU is not visible to the guest,
+ * but assigning too many vPCI device interrupts to the same pCPU can cause a
+ * performance bottleneck. So we spread out the dummy vCPUs to influence Hyper-V
+ * to spread out the pCPUs that it selects.
+ *
+ * For the single-MSI and MSI-X cases, it's OK for hv_compose_msi_req_get_cpu()
+ * to always return the same dummy vCPU, because a second call to
+ * hv_compose_msi_msg() contains the "real" vCPU, causing Hyper-V to choose a
+ * new pCPU for the interrupt. But for the multi-MSI case, the second call to
+ * hv_compose_msi_msg() exits without sending a message to the vPCI VSP, so the
+ * original dummy vCPU is used. This dummy vCPU must be round-robin'ed so that
+ * the pCPUs are spread out. All interrupts for a multi-MSI device end up using
+ * the same pCPU, even though the vCPUs will be spread out by later calls
+ * to hv_irq_unmask(), but that is the best we can do now.
+ *
+ * With current Hyper-V, the HVCALL_RETARGET_INTERRUPT hypercall does *not*
+ * cause Hyper-V to reselect the pCPU based on the specified vCPU. Such an
+ * enhancement is planned for a future version. With that enhancement, the
+ * dummy vCPU selection won't matter, and interrupts for the same multi-MSI
+ * device will be spread across multiple pCPUs.
+ */
+
 /*
  * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
  * by subsequent retarget in hv_irq_unmask().
@@ -1640,18 +1669,39 @@ static int hv_compose_msi_req_get_cpu(const struct cpumask *affinity)
 	return cpumask_first_and(affinity, cpu_online_mask);
 }
 
-static u32 hv_compose_msi_req_v2(
-	struct pci_create_interrupt2 *int_pkt, const struct cpumask *affinity,
-	u32 slot, u8 vector, u16 vector_count)
+/*
+ * Make sure the dummy vCPU values for multi-MSI don't all point to vCPU0.
+ */
+static int hv_compose_multi_msi_req_get_cpu(void)
 {
+	static DEFINE_SPINLOCK(multi_msi_cpu_lock);
+
+	/* -1 means starting with CPU 0 */
+	static int cpu_next = -1;
+
+	unsigned long flags;
 	int cpu;
 
+	spin_lock_irqsave(&multi_msi_cpu_lock, flags);
+
+	cpu_next = cpumask_next_wrap(cpu_next, cpu_online_mask, nr_cpu_ids,
+				     false);
+	cpu = cpu_next;
+
+	spin_unlock_irqrestore(&multi_msi_cpu_lock, flags);
+
+	return cpu;
+}
+
+static u32 hv_compose_msi_req_v2(
+	struct pci_create_interrupt2 *int_pkt, int cpu,
+	u32 slot, u8 vector, u16 vector_count)
+{
 	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE2;
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.vector_count = vector_count;
 	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
-	cpu = hv_compose_msi_req_get_cpu(affinity);
 	int_pkt->int_desc.processor_array[0] =
 		hv_cpu_number_to_vp_number(cpu);
 	int_pkt->int_desc.processor_count = 1;
@@ -1660,18 +1710,15 @@ static u32 hv_compose_msi_req_v2(
 }
 
 static u32 hv_compose_msi_req_v3(
-	struct pci_create_interrupt3 *int_pkt, const struct cpumask *affinity,
+	struct pci_create_interrupt3 *int_pkt, int cpu,
 	u32 slot, u32 vector, u16 vector_count)
 {
-	int cpu;
-
 	int_pkt->message_type.type = PCI_CREATE_INTERRUPT_MESSAGE3;
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.reserved = 0;
 	int_pkt->int_desc.vector_count = vector_count;
 	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
-	cpu = hv_compose_msi_req_get_cpu(affinity);
 	int_pkt->int_desc.processor_array[0] =
 		hv_cpu_number_to_vp_number(cpu);
 	int_pkt->int_desc.processor_count = 1;
@@ -1715,12 +1762,18 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 			struct pci_create_interrupt3 v3;
 		} int_pkts;
 	} __packed ctxt;
+	bool multi_msi;
 	u64 trans_id;
 	u32 size;
 	int ret;
+	int cpu;
+
+	msi_desc  = irq_data_get_msi_desc(data);
+	multi_msi = !msi_desc->pci.msi_attrib.is_msix &&
+		    msi_desc->nvec_used > 1;
 
 	/* Reuse the previous allocation */
-	if (data->chip_data) {
+	if (data->chip_data && multi_msi) {
 		int_desc = data->chip_data;
 		msg->address_hi = int_desc->address >> 32;
 		msg->address_lo = int_desc->address & 0xffffffff;
@@ -1728,7 +1781,6 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		return;
 	}
 
-	msi_desc  = irq_data_get_msi_desc(data);
 	pdev = msi_desc_to_pci_dev(msi_desc);
 	dest = irq_data_get_effective_affinity_mask(data);
 	pbus = pdev->bus;
@@ -1738,11 +1790,18 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
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
@@ -1767,9 +1826,11 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		 */
 		vector = 32;
 		vector_count = msi_desc->nvec_used;
+		cpu = hv_compose_multi_msi_req_get_cpu();
 	} else {
 		vector = hv_msi_get_int_vector(data);
 		vector_count = 1;
+		cpu = hv_compose_msi_req_get_cpu(dest);
 	}
 
 	/*
@@ -1785,7 +1846,6 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	switch (hbus->protocol_version) {
 	case PCI_PROTOCOL_VERSION_1_1:
 		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
-					dest,
 					hpdev->desc.win_slot.slot,
 					(u8)vector,
 					vector_count);
@@ -1794,7 +1854,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	case PCI_PROTOCOL_VERSION_1_2:
 	case PCI_PROTOCOL_VERSION_1_3:
 		size = hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
-					dest,
+					cpu,
 					hpdev->desc.win_slot.slot,
 					(u8)vector,
 					vector_count);
@@ -1802,7 +1862,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 	case PCI_PROTOCOL_VERSION_1_4:
 		size = hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
-					dest,
+					cpu,
 					hpdev->desc.win_slot.slot,
 					vector,
 					vector_count);
-- 
2.25.1

