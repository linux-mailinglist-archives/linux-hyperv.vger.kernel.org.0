Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5476C4E59D9
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Mar 2022 21:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344645AbiCWUdL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Mar 2022 16:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiCWUdL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Mar 2022 16:33:11 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020020.outbound.protection.outlook.com [52.101.56.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F108BF33;
        Wed, 23 Mar 2022 13:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TD4611Do860P0WEyhr4iQk9ev3VKCZi7Dcu+jS14vf7JPk14J3uos5D0VePvigHs2zvWoNlPkUCKsrTQf2ilx6G8n3ng42qBX4ip6XbvwBXvUI2TPOrpUIFINZ0t3wNDZEKUOvaDr/upJ4nr4YG+pf1VhP1fqIg16TVPQTQQDHTZRIdxwWWoIROoSDK5X+fp1/cTCHcM8fAbETZcHO9/mJiO97GGB7s2TEaLBbLGFyqqsUItcfVezbIP9hQf2mFr/nA7HHnlL5/eDBMk1CcYL09BGpdM7fmB3VzHFQ0WM1a4ratkMiweBuzJaUSRSoKTgcpg9MAGlSDE+t/IO68s/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xy8OZinl7z11NmrBLDmzzm9ZbxBjHOPfF+9VYwefMio=;
 b=C+4G6lzHGwaO0Bpp4Lo/tCkup5EdbpZoSiR1++E8IR77NPaayb/QYkZ9vNMWHQJJk2rysy6QfiotylRjwdA2OonvbtPRWaRKxgTfFReR3wqr3JRTgKlQToX6G+2aVB1yUGbs3nBBhhxCcAeE1DiV6fQb+qEKAAD3X4CGx6U+ReecKzizPWmc4cer1QPblKiNHtFnHv29u2dz4yE1NrbzYnwqsRO5G+rOwcg3ATu46bK8PUGis5bf7w6DvPNgyyxmxhD/Qwz0XtNXeQHhEgBImP606CioYZ1W2LhsEl2Ul6bd81JkXSlrEN6W1DR+qU+8f6XxeOBrwpgfwzG3h2sCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy8OZinl7z11NmrBLDmzzm9ZbxBjHOPfF+9VYwefMio=;
 b=akN59Imquyb5HQnHgFMIJN7y197vjfIRmaWaujHdTZvRttoOPuwnydu87S5eaLCLy4+gpffpJtsLrB10NcYx44XA36g+fOliuhAHbslJK9Ky6UahkPT6CdiG88LcBzrpOIjwtA5iQFKvgS1jq8q3WtDxgBgh1rKBBVYwlRw34kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by SN6PR2101MB0942.namprd21.prod.outlook.com (2603:10b6:805:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.8; Wed, 23 Mar
 2022 20:31:38 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b%4]) with mapi id 15.20.5123.008; Wed, 23 Mar 2022
 20:31:38 +0000
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
Subject: [PATCH v2 0/2] Fix coherence for VMbus and PCI pass-thru devices in Hyper-V VM
Date:   Wed, 23 Mar 2022 13:31:10 -0700
Message-Id: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:303:2b::24) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75e49e35-c2b2-41cd-14d8-08da0d0c2190
X-MS-TrafficTypeDiagnostic: SN6PR2101MB0942:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <SN6PR2101MB094243028C5B85ACA1E16FB7D7189@SN6PR2101MB0942.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TaNcIdyKCxcvsPgZIyI+qZK3wOebWpPzZEsmQT9Jn9ric6UhLAlLHHpmUhtyoAaRQwwmDIpp8b+t9zTm4jj4LPoibP4TVS+FwUoRJA6f54lRokgTuecQSWJJmnv1w0Rnt4LQreetKYgMOUDLQgufxu4n+l9X1QFg4bfHcPL1NyW+bt6UuqHY61gaTkgQZU8hAqDlpGLPlUzVxPPGCajtUMVzks3qWICwZHPvwcaL3KFCTsJ21CofHMLs1gg58llG4+fAvwTeScgo90MFrsyRueTMBH6dS1fCSB4J/AICwoFwQMQN0nFg9vHJzdlDVlYGuDAsOYvMqtHIKp3IHov9ohj8W9JxXHYA8ZKCNNK2XjgV2dodcUa+3jDbBpZOXPwxwYlcJjwLKDJx3PHVSUF22moZheUIEpJ5q4pv5e06qYho1oTV7/sLuVrjRAi2PEidJqItrQ0O17oY8IcTkI6joAxWsznn8w4JFZc8JhsC38qYvBflMoYnYyH5dpYRA45mQPFa/rN2hY0ji2h4/smWSeR+eU4QkjmPFSFL5b/5eH4lkGDR2UjHh1oziqUlS61kAXfVl7OGN/Ud5t9r5N+OdQ1a5TXaI9gZ58S4gDzX6vK71xjPn/Kv7ugdhHEmlxjDJw7vL1Y9dCk/+O2the4q8FgDKlsTQE8lDRJvPp2+jJofDuLhBDAgH7FhaUyjPlk8FIdthYAs7BJxOGziVqLKuKXWG97nX/y19/aUe8qOS+EhpKJV19iTLkZHv66iiWUZXdxzw/S7Ar58yKd0ZvT3OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(921005)(5660300002)(107886003)(316002)(7416002)(36756003)(38100700002)(82950400001)(82960400001)(38350700002)(2906002)(86362001)(66946007)(4326008)(8676002)(66476007)(66556008)(6486002)(10290500003)(8936002)(26005)(186003)(2616005)(6506007)(6512007)(508600001)(6666004)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?krpYi6JbrhbTNEHm19ZjDVtyxArTMH3reIz2t8w/Lr+SEnrUDDuESyvd2ltW?=
 =?us-ascii?Q?CwHExkcuem83CVZP3cPYb87zGY2bJzo+IV5N0SJQB4dPrbYnFTJT3gxJ81lV?=
 =?us-ascii?Q?Mv0xo/ELdxiidK0Y3nlbqRGblpwcP9OTbW7gZi6a18o2mCH9MXCVwry1LIu0?=
 =?us-ascii?Q?pBXvjxPJkQnCHKoLRIHivhkSbUFD8JZShhShf5FDSjz4G33CrU1HuCyd+Okw?=
 =?us-ascii?Q?vXlFae581QJQdqfDDUALsSWcvow+5wkwsFHSX7YAXiGZQ5e//Etbgt21PvRS?=
 =?us-ascii?Q?jeMiyUw8/hpFevefXqeCAtMmX0kFNQdvHGdJpV+ExfPcuvb1bNeLXO7X6Fv1?=
 =?us-ascii?Q?GryqJtt3VTkW8TxdH1t1kCcJe3eJmQBTlJfkAxCzEKFYDNOicED4AAoF38fR?=
 =?us-ascii?Q?uNyxSUCyuUzQgMdvFQ8TrnG+cv9JbP+3SLPOTZLSS68etWvi6NcFOLjd5txy?=
 =?us-ascii?Q?gyWrrXuXIRapCE2yB9UuIsyJcin7TSQE0XfMPSqkS8TQGgJTxwFOCjSBQbQE?=
 =?us-ascii?Q?ps0KgHlUT3hlIn/8Fy1+mnF+td7SihDioD9qKB1+QA6ila4sew2ULRnVk7va?=
 =?us-ascii?Q?TXSdX9jlCDOrxEuuXhB6ufYnBBscVpla5I38ACFFGtC63K8V5MLM0AXc8neD?=
 =?us-ascii?Q?YNC7B4kihCgJvcILzAIu0ZFbFncs3kBNX9oPNkWXxLSq1l/0Jxiog+sn73d3?=
 =?us-ascii?Q?cS4x0Ii7ChXSNVUxJiDNjrlkstBsOPMyrMVW2l6vPL/wFzRfoSo2wt4YAOAW?=
 =?us-ascii?Q?mdgXe6sQQ57Q8dTvkpnrfGNxLbkR5K47Y6wzsrBzFtGp71odSynZYGOTsgJa?=
 =?us-ascii?Q?IBVBhpecr8Qm2KYdhFhhIaL9VzCozFTX+DxLhmj2x5T1sX1ncZMYtO7BXt6o?=
 =?us-ascii?Q?lBaZ28v05c1D7OZZ7cjrOJagSjCU22Qqf21J34G59ybf/HzMzhAyOVih+914?=
 =?us-ascii?Q?RTCkqUP2p9eUNkhB9GD3UNRHN73/wgRM9O8S9OZMsshgQPANzXCkan3F89fu?=
 =?us-ascii?Q?OHJmirt2ur8xSE3Lk9wukY3N8EAqEF9lebLy99ZMoWeAzPMA7NRlo8xbiiV1?=
 =?us-ascii?Q?vYkcBJ6vJJY5ZpsyHi7RldLkFhVwQ+509UniOdEcs1lVSvIaBmrJE8F4hYGt?=
 =?us-ascii?Q?ghQgoO3BK7OuxhddFal4dmbQFv3VWXXyhgpD8k+wGKmM+4Ki2+lfJBqqDtV8?=
 =?us-ascii?Q?FhL13WLtoE8LzLuCMJgTKprkR6UQNefv1Ji6EWNYDC+agXVaH5QVOgs/mryB?=
 =?us-ascii?Q?r+VcTj481/Xq1EjopQvMURWunSKgwqX5uIoOh1Ixm4BpZWXQ8cSU84crAg4w?=
 =?us-ascii?Q?2aNd2/JZCEXyuRUiYLgEpBp8Sqa3GPB9A/Gub1leexJeo7hyUsiw46zLGxLd?=
 =?us-ascii?Q?QFc+Vp9nsvGoWyqxaiDLDGNR5E/vsozfV/N+//JfWLv9pONA+4frPsTvOmst?=
 =?us-ascii?Q?G2cV/R81a+H9M/6BHntT/oAvE4pTf92v6ZE/OenrCQLy5249RY+ff8Ihtyn+?=
 =?us-ascii?Q?5WatsYEqy91oo5AzmqmQCcUrp+qp+bv1JmjoNLZnGG/9BoAfAK4p0FWLusER?=
 =?us-ascii?Q?ZwYFJfGZeymjdVYK7snIP7USm3xV+E5mp1Wt1cEJGy8Y7Budxhip9FwMrAx6?=
 =?us-ascii?Q?rXiIt/9vMxNEhN8ktyNTICegFs4Qhai5aRtkwgRdAl37lnLhPGJw/w4HxYyi?=
 =?us-ascii?Q?YylGtHi+DmBJoyzFU3ACwhrQXf4hCQJFjaNpcUfKhCQBUrw0C3SPjFmfaZWM?=
 =?us-ascii?Q?iuWOtDW/mQ=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e49e35-c2b2-41cd-14d8-08da0d0c2190
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 20:31:38.1255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coamfU/WhEitvZBazjy2szzYwBcJRa49TTthDf6I5OJFJ2QcFwnleIdGudbScTAFua6nrL1hx7ewgMh82v76KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0942
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Robin Murphy -- I'm not ignoring your feedback about pci_dma_configure(), but
I wanted to try this alternate approach where pci_dma_configure() works as is.
If reviewers prefer modifying pci_dma_configure() to handle the Hyper-V
specifics, I can go back to that.

Changes since v1:
* Use device_get_dma_attr() instead of acpi_get_dma_attr(), eliminating the
  need to export acpi_get_dma_attr() [Robin Murphy]
* Use arch_setup_dma_ops() to set device coherence [Robin Murphy]
* Move handling of missing _CCA to vmbus_acpi_add() so it is only done once
* Rework handling of PCI devices so existing code in pci_dma_configure()
  just works

Michael Kelley (2):
  Drivers: hv: vmbus: Propagate VMbus coherence to each VMbus device
  PCI: hv: Propagate coherence from VMbus device to PCI device

 drivers/hv/hv_common.c              | 11 +++++++++++
 drivers/hv/vmbus_drv.c              | 23 +++++++++++++++++++++++
 drivers/pci/controller/pci-hyperv.c |  9 +++++++++
 include/asm-generic/mshyperv.h      |  1 +
 4 files changed, 44 insertions(+)

-- 
1.8.3.1

