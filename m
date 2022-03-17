Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1569A4DCB4C
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 17:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbiCQQ1B (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 12:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiCQQ1A (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 12:27:00 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021024.outbound.protection.outlook.com [52.101.62.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F4DDAFC5;
        Thu, 17 Mar 2022 09:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvwjxdPSyI8K2Vk8GdIaw1xMlKQELS28qczrI96v8O+4WfJqoFbK0bpsVUasC4BzxZgF0pF+PaVfK3PmHzbK5TGG7J674KWzLrlqR9LyALhGAdAc3i+Bon2ljgsL8Wx7lp8LnvrLN2DLTfs5neqqiGMM5UsZVrwuDRNiOH0+WzkbxEFL2hg+c6BEZZeOkG+N77Ty4Xkdmc7IJ1QYfwkoNg+WGZljWPlg0AAQtgt/XG4rpQsmhwJTRvOdtRv/Eet0qpfIxLEHB8tx9Csw8SKWtl3yUoLlBGsTrxfsZsWdhd9Aj8dNpzFR0nSNjDx/sxWUtkxooJKlLAUFRp5LTbAMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBRksVOYCYGxK+oWseMqGlkZjqhO/t2MgDq47iOK61k=;
 b=F7MDu9Fcsv0rAwWBJETqYlTrEaDRbA2Z94OKh/TIlnaqNCZ9hz/8FZX3nGhZv+K0cDus9jS9heAMRoQndKM9brXk+Qbh+7qZEghS/WFE8bkyJcp/C10XbjvlVaU7IGQOATlPzmIrm/AnOjWJz4C/anMKy5Wd7T265B2QqMpD2looBlZ36AnyBTGuJJxTETbPVTwtGpwlsrpXpkIu3l8MAQRf3mE2cjfPLqvK5KLh6xtxUZ5rp4kNlVhqae/22ifAWuPECVPrdFdfWKlT47R97cPfRR5i5bFjtC1kHNSauZmodRKbkUIgD/L2N+vwK8wqa+EkyTuA6uWe0ZPAYbxKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBRksVOYCYGxK+oWseMqGlkZjqhO/t2MgDq47iOK61k=;
 b=GrQI81VkvuxPjKE4VfPTMC513A/mgoIQfiB3Q+LbDeiVtGC+LCGn+osoxsZ4gWWNokWTRQuE5kbFAQfO1sDjGrOKfteD/KWiDxI5T0IGxSV3fTUPA2Cs6TG/dXwRLOr1M3SHVnGTz9wKZ/LbZIeQwlbIMnrHY8RMuJsg0z+opOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BL0PR2101MB1796.namprd21.prod.outlook.com (2603:10b6:207:19::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Thu, 17 Mar
 2022 16:25:41 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357%4]) with mapi id 15.20.5102.007; Thu, 17 Mar 2022
 16:25:41 +0000
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
Subject: [PATCH 0/4 RESEND] Fix coherence for VMbus and PCI pass-thru devices in Hyper-V VM
Date:   Thu, 17 Mar 2022 09:25:07 -0700
Message-Id: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::6) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee828dbb-1cb5-4818-f67c-08da0832c719
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1796:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1796868C777EA0E0CC2F46EED7129@BL0PR2101MB1796.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AlZrtcwbRB4/B+gF7YOq9hlYAIfKrDrpSDo2YkAQB8WXfTwltkNjYxkhCFFGl9osDCkqjTF8SI9z8M1WVN04/CqZ6wd59DiWRLEoIklAnSLE9tO6kvxv6I3L0LJrL5CiWR+FFJsiswQSRiSIssb2FoIIuhvICFI7fV03k3u6eLT7ZNrlPCZh663UPbQZ2lv7O/Ax0JqotzWk5lRKkERQCA2UvmuCHlxm4iipNgfBmLjYzXZev85LZSFX4D8vaQOzfqsk9HI7MmmGN1wA3bQiGHc9/ewUmAiup16MvEAF3JUzWLJ+vM8UpJ2RCoNXmVhJq5nF5vxK3WQuBobWPlSm7AIWwb4O6RAUlpRSVW7T4IUuVtJl637KVAmutVOn8SOehcsAEWIoLEDysC2azlRJA7D7IXuBDV3sKLawKgy8Zvgxh4QfAHiMa957x8TvA2grO/vkFVLd0AqzAWq48u9/5GxHx+kD+iNZDK9nVkwvlD5lvKgFZpRoV5ppuOnK0P/mOhwwQB0QVmRkx5I2kQlHnICwqHDUChO2KTERp5tJeQGq6uwl6Dm1wJK6BJVTVbAerZdC86VNXV5UZGS+SVAWLjtqiDGBVdsNb3TiBFQuf8kv0CeCEtV2cmuIOcBNPe905FJa0TOwoZXASgySYVjXJyTxlR5YLRISloYpyhQ1+cmn80U0UM4T5AQIZycwKTDPtqJ8/GsDC/qbfXLlgb9jPkmUoide8RFNXisdZUfjI4MKi6p6h/tz+Kl+IlthDrlByvav6AQQGJcKGdWYp6Kzfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(6666004)(4326008)(8676002)(7416002)(66476007)(66556008)(66946007)(6506007)(921005)(508600001)(82950400001)(10290500003)(82960400001)(52116002)(38350700002)(6486002)(38100700002)(8936002)(2906002)(83380400001)(107886003)(5660300002)(6512007)(86362001)(26005)(186003)(36756003)(316002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W6I+YXr+9U7/IlnaoVpefZYXo3WBSZ8ql3FnIf1E+xJHDKmy3pfThppAJVE2?=
 =?us-ascii?Q?/N7tKqMvz9Oeky1AyuJ4lT7tGgki9vdknOpfRIh29TMxETXxvx2BJqw325is?=
 =?us-ascii?Q?6xgoSgtxvg17aTwwM1FWRGZBT3egjB1wLAS1H2fR0Ifef0N7wKNCZrPDiArr?=
 =?us-ascii?Q?zPdweiWlE6koGAmrdsGwRsbR6DQJi5p/Pyw1pWc1KPQUz+2ilUwwml72qtRc?=
 =?us-ascii?Q?q8dpHMSkd60xyazYn/RBU89ndtH4RLLQsL4BIfXRN+Hy47a635rdwEBVruWo?=
 =?us-ascii?Q?ougWTJMVSUtjfFiw6X1UPCxoOMCNDBlZ1IdFzWySvCAw1LN8nE/rglc8zLWG?=
 =?us-ascii?Q?QioIYHQk+dlKS4naN1Uk6CupqveSHnlTGxSzgEu6Gx8PYgikrcudKQMJRAfb?=
 =?us-ascii?Q?EGN60yUhLcPFsd0eTd3NGfF7otB1L2MLHV4nvq1dSNcKvYRYQv1BWOYTzXD5?=
 =?us-ascii?Q?O86ligJq7FRss7lcuPW7KxwADLE3bStdKxlxXPt8FGYMoW4cYS+z9bVgRhHQ?=
 =?us-ascii?Q?XPR3h0nNUAmNu27Ztobx+kaI7qnbV0Dy6urrx1MxvxyjBrBNcGRQSYJUxIf6?=
 =?us-ascii?Q?qcfiMwKSnzP8epV55UQgMhlxZClEbv5yQcrU9TjIn6Mgt0HQmfHEDmWAFkBy?=
 =?us-ascii?Q?3kyVwasrmciWdbwPUPVk1LTzXA/UmTTsRes6bA5Kdt7qtkS2ffZ9P2DyIcIN?=
 =?us-ascii?Q?xiggS7vfc6c0opHFY3FflLAuuPWHzf7sBjzrq6sTIrOflcIQHxsMkVe6oQtk?=
 =?us-ascii?Q?krDIbqWtxrkMjMuIueEYOzfQk6lWktVXX6Rwjj2DPGUIYcpbsQIznR4edkeR?=
 =?us-ascii?Q?Sfy4M4cwy9NB0zny344b5V7gTpwmD9W5ghBpXgwPS1DuFD+0YAjkhJaT+chW?=
 =?us-ascii?Q?AkUDdZ5+gY70MeSTnifqN0ev0qRQpa6onwCIBmTdq6QF7sFqYErmlr9B49o5?=
 =?us-ascii?Q?U7QH/HxZyQM1CcQG/U/5cdoeA91jSP5tMscU/Jq2/p/SdiRg+BScmXz961x9?=
 =?us-ascii?Q?n2u4+hrlfvUI4cUXrMnV7YAbYc+Bbr9XCPrJy+Vrdnc5B+PUS/dygrDcq5qb?=
 =?us-ascii?Q?Em0qOQzBe+nnEoAOwVA6REp5sNaztpwOICoUr8fEhIGFb6mT9kspBeeClxgt?=
 =?us-ascii?Q?CD7EX/KhgYcfJkJ1bUcuJXAoWar1NYVc5NkZ92KFLsOz82gkG3TD6aAf6/h6?=
 =?us-ascii?Q?tK0+DAIbtJQ65UjzpTTOSh06yQkgxHuBeqCLjmwnK8DD8Jou5rGxg2sBQ/Sm?=
 =?us-ascii?Q?cLA2MeMlWnvHKkQG6PajzLEEEMxDvyenKBR5HucoPVWcRxUzSNYvHlUfoLXk?=
 =?us-ascii?Q?K+jAATcfbjpiuKXfYknJ/BJDMZ6v0N4KdN0sUvez226wPbI7rWanVCTVtOv9?=
 =?us-ascii?Q?P6qphPSw8jooaccxBfQHl/uyE+uDtST2u/l0flZhGef+QpFB7Tji4zCxQqSc?=
 =?us-ascii?Q?2MZeE8Kk1nEGzvaWdwu0H/4i0iLezGUTz/IkvLaVmPjZPuBN0y3H0A=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee828dbb-1cb5-4818-f67c-08da0832c719
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 16:25:40.9450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X85/sLRftqiQ5GsCLE4Il6KxF/XduqsxUs6X6aK1qxEEvkV0HZ4oGGzvyFz5xd24jka4rnAscKiCufuVTDcotg==
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

[Resend to fix an email address typo for Bjorn Helgaas]

Hyper-V VMs have VMbus synthetic devices and PCI pass-thru devices that are added
dynamically via the VMbus protocol and are not represented in the ACPI DSDT. Only
the top level VMbus node exists in the DSDT. As such, on ARM64 these devices don't
pick up coherence information and default to not hardware coherent.  This results
in extra software coherence management overhead since the synthetic devices are
always hardware coherent. PCI pass-thru devices are also hardware coherent in all
current usage scenarios.

Fix this by propagating coherence information from the top level VMbus node in
the DSDT to all VMbus synthetic devices and PCI pass-thru devices. While smaller
granularity of control would be better, basing on the VMbus node in the DSDT
gives as escape path if a future scenario arises with devices that are not
hardware coherent.

The first two patches are prep to allow manipulating device coherence from a
module (since the VMbus driver can be built as a module) and from architecture
independent code without having a bunch of #ifdef's.

The third patch propagates the VMbus node coherence to VMbus synthetic devices.

The fourth patch propagates the coherence to PCI pass-thru devices.

Michael Kelley (4):
  ACPI: scan: Export acpi_get_dma_attr()
  dma-mapping: Add wrapper function to set dma_coherent
  Drivers: hv: vmbus: Propagate VMbus coherence to each VMbus device
  PCI: hv: Propagate coherence from VMbus device to PCI device

 drivers/acpi/scan.c                 |  1 +
 drivers/hv/vmbus_drv.c              | 15 +++++++++++++++
 drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++----
 include/linux/dma-map-ops.h         |  9 +++++++++
 4 files changed, 38 insertions(+), 4 deletions(-)

-- 
1.8.3.1

