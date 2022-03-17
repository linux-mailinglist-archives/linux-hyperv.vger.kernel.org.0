Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610884DCB4D
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 17:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbiCQQ1B (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 12:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiCQQ1A (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 12:27:00 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021024.outbound.protection.outlook.com [52.101.62.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DEEDCE12;
        Thu, 17 Mar 2022 09:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPQlamQyMttrK6h6t0nYqoFtP6ovKnVBJrLUBrMnVc53bwdKX1RAkKCPlL+QNsUfZLTZ9wrGq8mlYfzURthtLumzSuUfOcy46oOa9OhQnNfAT+oD/Dk1vXYh2ISBKrP7+yMZarLsshiZCziQ7sQp0S/0BPTHN++WxAXZiJffzi5Bl8xo4KkOA1qKWAlPZ/NV+DZsYlV4fHN0Azt5yOc3VdFOcm2GzrqkfZWg+oe7+E0g7R5ulGTF6QfVXRGThazdI0AXi34B8UwpO2jOQFWDQzxCEnJ3lHUHdVNH3X0PbG9YQhDHu1w79p1dUWf5QWCXg+l+kU3GY+v9Rt5zjnLKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fANw3N96wb/SEz2HYRPFH4oNYkebZSLj6chgN0ZIU84=;
 b=FbV9rfoUZ796KEiD1Kw8v0oYLENvKcTh3cuAOLMdDDoJMLAd+fxSaWsHDkG2FifO/xSzmTAERV8h34EiB6+0Ig6NE0u9E5v5zMHDj8ZmIphYv4uNMUd/oGd/4PTwtauXNZlL9NnhzFOP1o/kMNWA7x0FU2rD1LnK4apghsO/Is5bkgtX9t4tXjbkL/uzQpulelOTe9j84ofnklYrXdgfxtCHgFA6M2lyKlpH/1EqIXhh61Djfte9nPKJqym6yvFiHb57NaK78JtM8rx3vBnYXx/tEYGlzFyGqvAxdA255HElMLXjQ1uCAHjN4iSddGqFBbg6WCdG4rG4Wa/rGBqUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fANw3N96wb/SEz2HYRPFH4oNYkebZSLj6chgN0ZIU84=;
 b=B1BTghpvhd/jlwFYvBqKmmBQkaqNeIWP8l8Gxg802E+Wlu2OfvI5WTG4LXNO4+5kUxedAe96XBkp8cxoRM/PPWwtoPypGZgsmMm1sWDSz+U1ZdjmSHA7KugtUUBm2Iq7fxV0yFJHciLzDl/+Z1kpe9h0dPsfvxmGhcPxnMSzaZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BL0PR2101MB1796.namprd21.prod.outlook.com (2603:10b6:207:19::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Thu, 17 Mar
 2022 16:25:42 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357%4]) with mapi id 15.20.5102.007; Thu, 17 Mar 2022
 16:25:42 +0000
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
Subject: [PATCH 1/4 RESEND] ACPI: scan: Export acpi_get_dma_attr()
Date:   Thu, 17 Mar 2022 09:25:08 -0700
Message-Id: <1647534311-2349-2-git-send-email-mikelley@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: a0c88254-8563-4cbd-ea44-08da0832c7ce
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1796:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BL0PR2101MB17968748262BFC61C7F12047D7129@BL0PR2101MB1796.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Erzoh7rUUTtIXeOUen8PzzUEDQ034Hic6w+/wbcTZezivSugEPjDY9u+JxHSUbo/Hfdg7YAruP2Mwxa3g2sbw6iUtI8u/RMzqOT8nfaLW6eqisIWPjGXZYaWmEDywDGUOsKz2Gqsn9ApdTos5plnRar2oVbtm6vCUpSIR6SjHYSFQw7WtvAM56AGHsIH4fHAclZc5mxnW9X660lqCfbZ/0ttCAunTorCWJwE9A+5xvHsclE1quOj/3tJ3RTYPMlMIVFmqsxIShJ0r7ctFr+oKH+Bbyj02sWZQvwYOYDHL90bk+MLqH6Sqmgj8CPXLorVgtWFutiMMhcqvDnFwC5lGri59IFg7ypZCOKogSPjs3zrGiQsoel4YoioCdWqGjHD5ID3Z0Qd9UAXaJyK0egMY03jwEUVX0Uv3rpqzLDL06XbfUkC3LAAh9EqWU8HXAbU36XjtJVA7VWZZ69zSjmVqN1JBhPiQVMIsZmjM77swe+F21p8JvxtOaoME9WpT7vRTOSCqit8t+bcKeqbIfPUDEf15cz7S4UoMiq1Zji+H4jrAG3XC4dmCgrtmqv6RYnKQtPxltVZMdd5oQvW1t8yz7RvhRM6UYyl34tR9zahn58fBWM4Rt9AC9WhMNeV99WKCFrVfpwWqTtYErgt2OcjnQTqiDSE/igxfW4xAWwFbVo9NQ3kuyEpuo2xY59GXJ+YBSYPqOXzwIuJGxtey4FV9xlbjIQXfgH3cMvvW/LpILRX7d3uQrKOqTsB3jlk6uwcBdeK4PMdRtfGHXnOy31EUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(6666004)(4326008)(8676002)(7416002)(66476007)(66556008)(66946007)(6506007)(921005)(508600001)(82950400001)(10290500003)(82960400001)(52116002)(38350700002)(6486002)(38100700002)(8936002)(2906002)(107886003)(5660300002)(6512007)(86362001)(4744005)(26005)(186003)(36756003)(316002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a056XUFSE9rAhiPxMYPpd+lAiKlS6YB2qxUBDkX3dliwWPgR7jl8FjmvKmSG?=
 =?us-ascii?Q?WA8V8QLeD1MF9hvU4gebubwv/MM16eP85tdUSTixrX/N87cxCrZBzRUhKetQ?=
 =?us-ascii?Q?z1bld/8sCWGZMGVM+DSEWBP1u3s6hVkGWq9e9sdegUDg2rZhOzXp462siZ3G?=
 =?us-ascii?Q?N8kndKyfvc/rly5oPGfXns55pOeNWC7CYS7lN165Jrxo5QEv4rblNShtL+yM?=
 =?us-ascii?Q?b4yp+mVaCDaYnxZHgD3LI1/E3Gdys0gkdPv1hsp2TDOEni6jQhZsGwTm+dRY?=
 =?us-ascii?Q?uAQzLm2jUxvHoDDM7doHdOCWpI2jXDSH8rbYZaYFcW+ZgI4/m3rWqSQ6Ptlc?=
 =?us-ascii?Q?MppGmY6nnLud7F4aUT/wMoqRnqaq7suFue+Rm3smRo9In3AAC4wSMeEyc8FK?=
 =?us-ascii?Q?fcUWUIwjzpWoh6iqQ6voj3n/GT7mTq5ymR2KfnA3Bz5DdYpNs/LNW9dc6GrO?=
 =?us-ascii?Q?ORosaOIbO2le4NBzWw1haTe9Gp49epLKRl6lqgJTYc29s97/QmGcDbv07rsE?=
 =?us-ascii?Q?72iC45Avqn4Ewt6OXQIh5XXJoRlMMbY+9m2PNv4LvbLukhaR0qP74iGKXIa9?=
 =?us-ascii?Q?wqPGZ03y+cpmHacQQnRTCze8lWkU9mwIew3mBVQDMFhRqZLQQkoX+YJlA4BU?=
 =?us-ascii?Q?/vReBDpJkOgpZ/RNnUW0MG2SkGZQmc6kamtK1uZji4nPLHur4qS+hQHYZdse?=
 =?us-ascii?Q?eMTlFYceY/Ck6WcXvQT7SGEyjVsb5seDEs1jJHnBguoCgK7abXg2vkppOLvT?=
 =?us-ascii?Q?3FOtpJ2VImOx1qF3R0xLLhgGCFiQdNAoLlppWdAKhZB968MvLpiL/PmhuuQh?=
 =?us-ascii?Q?E2jRwJDWLancKj1ECUkBoHlMqPMKqUdoJaaKVGXRBJjLKtpxr36Q8gZwcdpL?=
 =?us-ascii?Q?XzBpfD9nsDj5Ih/UssGcrcjUHWYDHm5K8/nS9q2pGru1zBkkBbHk6MIEEfnX?=
 =?us-ascii?Q?QuQdiRIvERRu2GhCfRjV3gXzT3BublKpWtKCcS8HDtuvIFJXKEyZBKKJaZob?=
 =?us-ascii?Q?rNgHbuGlr5YNTg7cnjcrw4hRSHSNiUV7vrd8sDxxZdE/2wyrYAkEAQEIMqZm?=
 =?us-ascii?Q?ATHoN82qiSLj7BLPdD2VvqczPlEF90jXHT1RdxyvV2ItNzVLHaTbm3yyVhAf?=
 =?us-ascii?Q?qtiF91advTXND1FUoVGrzi4g4SL60+QZpM+5C5/4lXJELDxnJm5paoQdcVNx?=
 =?us-ascii?Q?s+VtO28F+kCZfd7f+dkz18M6+N8zDXZHHk4pQp0czTio2jgjZucH75FelsnI?=
 =?us-ascii?Q?InLFNBe+aAuJ0tEK5So8PgAXn80RPWgXcnOdxxgilvksjhPe+br14p+hkcVL?=
 =?us-ascii?Q?TmAWhk/lpTOU1ROIzpeGFn5Ctba0LvMk9A5Pa9ogP5kH7m3gh4ms5KLLHQm3?=
 =?us-ascii?Q?FBIQVDpngCw7PNJo/LG5calZ95QY33MqeheiNfppYs+531vAqenZSAoOssQO?=
 =?us-ascii?Q?G8eLPqVs/sSRHKEdhIy9JUung5/bUGLhP2nxCwUU0Dz03t80zK6d2w=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c88254-8563-4cbd-ea44-08da0832c7ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 16:25:42.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+i68gO6DoG59CtUFAk6SPRjZB3HDrD7KYiU4wNZhB8NhaFSX5TWA6fxllkyVEiiz/Aeud/0PoKlfdiaeyMPPw==
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

Export acpi_get_dma_attr() so that it can be used by the Hyper-V
VMbus driver, which may be built as a module. The related function
acpi_dma_configure_id() is already exported.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1331756..9f3c88f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1489,6 +1489,7 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
 	else
 		return DEV_DMA_NON_COHERENT;
 }
+EXPORT_SYMBOL_GPL(acpi_get_dma_attr);
 
 /**
  * acpi_dma_get_range() - Get device DMA parameters.
-- 
1.8.3.1

