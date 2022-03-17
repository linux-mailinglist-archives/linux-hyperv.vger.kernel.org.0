Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26704DCAF5
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 17:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiCQQOk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 12:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiCQQOj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 12:14:39 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B1813F17;
        Thu, 17 Mar 2022 09:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLzN/OhbanPe3vVYMW+8WhCIZxsWgXd97JJvu7Qmu3bNRtUcTEiBkTVlmYtx85rIuKoqYla7glWF9Z3XDor13mpUIMA/guXE52iiOKI+LjgpRDy98Zg8DEQ8YbXFD39vImneY8mFs7bEIrucb4qv44JTuKKUuJSGRpN8qcJLxyl0esgm0hlW6q/MhoAlZwWSd9bSwuKIKznRe5zoid1fswuDINJdhkvaXig1uE98Lz2sK+9pBxwy96GtxNKKNAB4Rt1fy0zRgr9OFe1H5DwgJV53+s+vYm5NMGJZ0qRmCP/hWxiBZkZH9tUp0TCLo7ghXXegVWGceRnYLltKRS4hWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO1YdWsiEnaF9VQyrEJVPHKwnv+MhPiQSoaZvJ3DwgI=;
 b=KagHVo8lhKlVmhfHauJRHMqTKYY5/2u++phJHsNYhEUsrcWcZd2JriIzhdOV5OmWSp2wfeAXPax1YghSCa2H5yj+vWNPDNgg3sYI1yEVeeU9uEpD3BspoiG64w/pRGwP/XysEp+sbcZketzkNiumbkfL9zmAUtZTqT12xW+D9PhmFm8wyeyNY9Nt/Da1riKE0IanRrueO4gfu0OZq9E8FVUcda7Obm1sOHfcgv/zW/yX2yW6UVGP0drqVghwE8Pvp6Y9BJZp+Vj3dRiVJwDzrT3QCffqgXXHEwHOi6Y/5Zw4XJ7p5iQ1zSXYIIgylCV6qBvDqfuKkJklABZnsQUOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO1YdWsiEnaF9VQyrEJVPHKwnv+MhPiQSoaZvJ3DwgI=;
 b=ZqhDBm4l1xIbRE9Wv2qAgM7me4xuB7l9tsTx5Tay6cAFyrOypFOFrzbTE6XqQHXavLDYZHXJKj83wQSW8XfXKLE4lhijXSNoimX+yD9Zwb3ztxg+lyk2jnIkoyedWzDjy69dexdweItitovYEKHhwNJYrcSexP6mMeLv+SjT9cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BL0PR2101MB0995.namprd21.prod.outlook.com (2603:10b6:207:36::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 16:13:19 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357%4]) with mapi id 15.20.5102.007; Thu, 17 Mar 2022
 16:13:19 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org,
        lenb@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgass@google.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 0/4] Fix coherence for VMbus and PCI pass-thru devices in Hyper-V VM
Date:   Thu, 17 Mar 2022 09:12:39 -0700
Message-Id: <1647533563-2170-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73609d37-2d96-4d66-c85c-08da08310cf1
X-MS-TrafficTypeDiagnostic: BL0PR2101MB0995:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BL0PR2101MB0995005F7E4BE8BA03737FC4D7129@BL0PR2101MB0995.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPxtzWIhT4uj8csDWBf/oPbwaFLBrNKhhyNPkMd6y149rVFqSWTR/OdlVchReScvPk7zh+Vgtw8hg/SO90sViHaF/+XnfJY8pwLp+9QQVs7VyHvR2nIeiwP/Qhjtq3nwB6kA7K1nmsFwIUoEB6xDW4Mn6qImBIX0KGN2wpHszdw3BZEalNvnlAe2D5TKM3wXhc5b7v6AT8Iqvaw6yKCmEGVO86qUisBJaLd5zwgvHioJL/SWW3jCaFAFaFvYPjBdmzYNJRelyKnS+PNa531IjglhkdCZUxyMlatHnLCWg8Zq5dZVG17IKo1AilkG0dqy9dtNutcjBO4rR+/yowjlJkpvPYYz1aF1crDB2OnQl+uZJwdghQfWnrvJqmqM3Y0pNiLqnt/T+SnzgguTZvfhEy3mMu8Qm+WX/wfyzJ2QeyWLJHu15/DToTX6OCwFTCJ1TB0SVfpW5AsflaGTgCClKE5WCjs0aw/aL3Eql7iB+m0gDFg8jlCMvDdNymEr1l/4zmQ5CDogDo9lgisYku20PPp0bqLnJdQFyVcVongUQYq1bazRcC6GaaK8b3hVWs4FovuGFUmXYHlsScTIn0Ly65x74JGxmHh0U902qo0bmlUxvNzmnz7JtSFvBo9hRceV4qlUJQTlnb7iE4RpA9qW949g2ljYC/mKa66GHZhAk4m0XMwY40jkDEOHyaAdSegF3kXV4zy5L7k8pDZXp5mxLfBBHG0tDW7k3E7JKcZB5gRastENzsuaHGptIHuu2mEeByunqRDUffwmv30wBMGGbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(83380400001)(186003)(26005)(4326008)(8676002)(2616005)(8936002)(66946007)(66476007)(66556008)(107886003)(38100700002)(38350700002)(316002)(36756003)(10290500003)(6486002)(86362001)(5660300002)(921005)(6512007)(82960400001)(7416002)(82950400001)(6506007)(2906002)(508600001)(6666004)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tZ6Lpu8LrHgb1aJq3omqdCAXMAps5ZKWhCPLtY1Ko2t1fsPWniSEVg73m5Fa?=
 =?us-ascii?Q?dt7j1x5OE4aHYns8PagRQR17htU9KBns8L0gZn/jHp66dy43fl25UYYwIOss?=
 =?us-ascii?Q?uUOQqwY/oWVyh2sIQvDr9rAWpw8YNGjk5Euk7a7/K+/G5A0qCf0Xmh255OMa?=
 =?us-ascii?Q?lV3bachgGKJkicYdcQZPMe9/E7eHQXvcpmYS5L3Cczq3Ix/UQ8JqTLN/ZmM4?=
 =?us-ascii?Q?Wr6x6HkoU8Z43xbDZfhf/3EQIVbG+7+qzs0CxD7kZtEl7UvfU4uQ5NFm89s6?=
 =?us-ascii?Q?5SVPO3I5McJMCBct6wlsXUdHmGixNF6DW33GPY+eVMWcaHgaH7YPPDFoEcWr?=
 =?us-ascii?Q?NZhCBhyJsBNnRZzX6dFuc0+s+ZANcbZ2trsa/y+fp99YgAZYmA4+7yaQgvMP?=
 =?us-ascii?Q?TDVr5ViherFy2ZO6+2b+NN2SyyP3WEsll2o43M0iswZSokZPpObUSdp25Vtm?=
 =?us-ascii?Q?yR1nPfOG8JprGN7HDkB6pef/2bx9sQbSjWznZNNXH5auLYXy/kiJW8CRnA4Z?=
 =?us-ascii?Q?gOXdWYc1pK6NDmkzMx9VnxhOcRHFB8AX15Z2vFjpIlIisGSK8zrEY0vHUTZc?=
 =?us-ascii?Q?gXJKTKoq1tmaDhEWBMPkQbVxRNIZP1M7XfNChTK26cErHFP76D49wXCL6yv2?=
 =?us-ascii?Q?LrvOhMsPabyADcRhJCB5YKF0A26OwzEEtLDycNkfKVQKNpQF6Z22G2HkBtLO?=
 =?us-ascii?Q?KA7QajJl/ocP+tBRXDrDHLYrr051TXYGfVQo2GyVMFQVHcMJqnWU/GUdwfmr?=
 =?us-ascii?Q?DfsNHloP5HD50sEMno8Wo/lV/A7yL37m86ODDcd2aXj91LP/ajVQtM0p5VLp?=
 =?us-ascii?Q?HZOT/hM4ybtTIfc9rRALNY/KqzxskO6xuKrK81Ah0u+GAEuhMvsIyjXZbgN9?=
 =?us-ascii?Q?QKepvWqhApC1P4/cBvNxrhQ5Rimi6WEaSyZGO9L1j+pqc5b0hyQ1b8DajJ1j?=
 =?us-ascii?Q?FaJ0DFPLjLRqPEUWfmtUKK6E1Pe9R4bUtkwgIr8Ynt1otmPfbnIcEnVgdQtJ?=
 =?us-ascii?Q?cKmIzdkHiOx6GE5zm2OgX9g7GEos/GX1srd7ri8UOakUj2UGtaFdNnPNggKT?=
 =?us-ascii?Q?uIjGo5MlL1HXWyZBmh+owCGvZ4HvmKfycAwIS3d3OGfNBGH5rEkQyqHSlutg?=
 =?us-ascii?Q?d7nLaAjaVg0kU/YFbaaKnD52arT1eJTXtcdhh0BO53Ko/C9f1Rf4nAdx6I46?=
 =?us-ascii?Q?rFAFgqqhGcxx50U9YARYtZK9kt7u7CezRJw0cUFG11o5bUaD8rwHFKres+9H?=
 =?us-ascii?Q?c6/M1+hBDudaKB06WkCGMpz1xlH/hZbjCjhQjDnfR2OTmkZ7+zPGdIr2veKF?=
 =?us-ascii?Q?Air6iwr6kjWHpAO8JwuXO4+IXv4PG0mMBMZWkjFKLe/nV7WC3RfrYvTbFty3?=
 =?us-ascii?Q?GTHVj2b7FlChfzSTSHGdrzsNpyCiVdp88lDiJXAGkcJfTrarTPe83NwdVM8m?=
 =?us-ascii?Q?3vyFH10M5S9pl1COoz5HDDbHLnfhuW5MRUdMvFy0TdqHxT5sE7kYCg=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73609d37-2d96-4d66-c85c-08da08310cf1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 16:13:19.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snRMojjKXjofr4oHeNQb1QzwyF8HWDkMxFGF6POyVlxjLxaV+A215yEYWNz/A/rDfbgDwAytrDrqIrjyO5dEiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

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

