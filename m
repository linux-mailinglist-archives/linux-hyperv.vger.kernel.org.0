Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5434DCAF0
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 17:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiCQQOl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 12:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiCQQOk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 12:14:40 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F41D167F4;
        Thu, 17 Mar 2022 09:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjkmuHUA8rhKyqCndwbvCHE7bhFcDpxoTe4XApiK+CHxBAfn5SNoUjQnCn1gcP6oMEvPdn88OLdNG55UB1McOWP9k1kLL3M8K47Y+/DK861KesaoN3mvDythmgu3cp8LsSdos1otUoYKnFB7ZdX8lfPcplNS7yjhaZk7KJnI00f+gXksk6uFJc7fGkauUjjcGY/m8dNZPGTsiyhMYyQXd0gYY4x1SvtP5rk6IbR3UUJSgSaUNnFOq+SgVzHFAUBVgHpCHEnj3mSYeJz+0s8o8BK64CqJbBZ+Qy+SSlvNZvSiOAvp8tTXfv0wVXibb3bX9i/auUm3gmpGiUhHK6NO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fANw3N96wb/SEz2HYRPFH4oNYkebZSLj6chgN0ZIU84=;
 b=JEKxydoVBhbsk07j+z1HjdK+hv3H25po61mKDmWefjvRPODqOxwd0e1UoXKrgrPpSBbxxZMVF5PTgyXASJW9zBfxhJvNtBFwK1J+id6Eay1kln0+pQYG7YjhCCko99tw0kzhX77bM2UxLhTSWfELRm3kaxfzxZVGxZJ27zzBWOmHKtnA9yl2EX3SKew8/uR3kEncJ09WxxJjotuFADWHYYvEcdjLDqNj22yeFTBGGvo34KddVvYKDd9PuqcCc7yxCKonQuZo+MfKkX8LXW/EBjx3WXskDR+uzQLnuoyJLa9U5bM/Dms7AeaDzK94XB6WXF2TsFlxndD2WC7CczzIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fANw3N96wb/SEz2HYRPFH4oNYkebZSLj6chgN0ZIU84=;
 b=Cj4NzznzV4wQ9PdTJDlDkNKJ8NzeGPWaYbN2kL7ia3ZLbqdX/ZRyIqyugM73xMtM/NkyW9/9NClcI6rjVZIVbUjwNrEAIHGrBOH8k2sQExqUTD8zbKqUpUJos1ab+UPEJdbBwIsqm8mSXbb36/BYSCyY2ia7qQjgnlUiLqxiMYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BL0PR2101MB0995.namprd21.prod.outlook.com (2603:10b6:207:36::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 16:13:20 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357%4]) with mapi id 15.20.5102.007; Thu, 17 Mar 2022
 16:13:20 +0000
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
Subject: [PATCH 1/4] ACPI: scan: Export acpi_get_dma_attr()
Date:   Thu, 17 Mar 2022 09:12:40 -0700
Message-Id: <1647533563-2170-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647533563-2170-1-git-send-email-mikelley@microsoft.com>
References: <1647533563-2170-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c4a72cf-95d6-45fe-0749-08da08310da9
X-MS-TrafficTypeDiagnostic: BL0PR2101MB0995:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BL0PR2101MB09959DB73944BEC866C7E90CD7129@BL0PR2101MB0995.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YiP+Rr8tt0Rf1WyyjlpF5bj0HsFxvDzokvhvuX8g43Iz6SPSgqSigWvb3zWgS3sBJDK2haWZMETorFL5k4wLPrn7PKvrJlpin7CEXzw7c2F/neT/oOk/PAlB/DIzQXYD4c2x56ICiIFA4ld/fymwYcLInjryoWzpAJwnbZEs13KdpGSyknEGbkvPQJGALp8w1ICrsxdIpCGLiyOvfilQJDxQ+BDeHm3C8A8S8nzVdA30jsufl3MTGxlVp73/DMqofVQWJBxl/9s8MvN/LM7Z+Zp5dD0GKNLwmD82C8MInKllsqxFvz3x6IAwyvFL8EMGsYu8sjfn8wUN4dNmvtwWICOu90KJG6nIl2D24JBfxdDySEHkO87z8bKOaObMOWb7UlGjB8TXHU7Nu+RLJBA/s78OKPscXCVUJjhvScq/xeGrH1YhrwmbFkMlK8QxW+oPSXTRamHewdeh8YqK5Q9Mk77/Nw6bsd5dHO6srKQeTF26yzSk/RwuPe/D6+8BRLUC5Rjh51zElNV9M3MfUnFcH9yibKq+1x+R2QapMhymEAfmYPHAM2k5IZOnMT7zqg0OpPwDeQD6ATxPvI7QoyOUw4UdQ2z9NzJqWZSSbNL7bt3VJaM4+F+vurkQY0I/0+9pOm8WaOndl2Xv43lJCwBR4jTcgHu+ybaKmtQK6Pzo1x+tDSG8CnR3hu/Wqtl8QkprtI8EeNUGaD9ilKjhOJCgWhfOV8zknFfPAkVRRaQWmSgKG+IceQCQgteewlZqQtqDHmfAVd3W+13FxXF2ppEvCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(186003)(26005)(4326008)(8676002)(2616005)(8936002)(66946007)(66476007)(66556008)(107886003)(38100700002)(38350700002)(316002)(36756003)(10290500003)(4744005)(6486002)(86362001)(5660300002)(921005)(6512007)(82960400001)(7416002)(82950400001)(6506007)(2906002)(508600001)(6666004)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g/Nf1JDFHyzLc4yhaPYLvZUnuYhjAClA/WFwf8cqgaWqk2FaTh8EEYByjuIa?=
 =?us-ascii?Q?4NJVO+Xnkr2e3GJAly6Oy43FtSchnjVIag8lkbA5FkII5uobmPM0Mt3cE5pR?=
 =?us-ascii?Q?EyY/9YuWDW22q7iCAlMcGlRcWC1NGcET5WB623a1Q3Z23C6APlhQ8Q4V/ojK?=
 =?us-ascii?Q?9KdXosdbux9M2UP8q9wIwn0Jo8fygE93ruixYopO8VvMb7HK2DBJYGgE1tWQ?=
 =?us-ascii?Q?BZJcY/BAw+JuTc5o/eXt6TMJnJzv2HdkQdJcBHU/5oCHjto6se2txJzRDalE?=
 =?us-ascii?Q?HabxsVDHS3KCJzdRRhVk3npF9z1jxsjikNmu8EvnH8UyWfYnfzFruLaHS4v2?=
 =?us-ascii?Q?kRqP8jO3+dgEq/XnITlTWnYckSM1ZGTlhrb6BG7WuXk4M8baeQeEQ8OpfD9G?=
 =?us-ascii?Q?xhVzLFISzawiKx8CdGz2o7nIGci3fz7qzQ4Jvv79dU4D7zBlbQ0ftonPWWPY?=
 =?us-ascii?Q?LxdxxM9ND0xYGXXDVNfYHi1b6Gh318RDvrakDDTR1mgME69A4PZJbzOiE2Sb?=
 =?us-ascii?Q?gcS0lL+/JQxmzlOcD+TZW8TxM1O+/Sk8c4h+03RnbHqr7/LFUxSUP1V5gqMt?=
 =?us-ascii?Q?5zuRiiV2HSD7GQHqf+2HoiuoryhNTBqVOhUaYPMmspmEhMbsf7KaHEyb7H7Z?=
 =?us-ascii?Q?Lh4P7kB4JW8Eg2pb81//pwz0Eg/V8mzXH+NNwagxmrAa8FrkT90fzQHXoCa2?=
 =?us-ascii?Q?X7t+fAXUqNXzOKtJyhFwtAXCmdWhLTq3qDuMX/J42c9GqkB/+yB2a8NGo3PQ?=
 =?us-ascii?Q?6i6htzdaYbpaE4TvJ95WZnYSg6yeeBBt2hdkAhCsG/nByAM1YIHFIejpysql?=
 =?us-ascii?Q?Hley9Q0r+XLO4UTK8IQPP/SUgRPXEfvM0XcfIrlGpgD0pS6UXaK00+iUVH8M?=
 =?us-ascii?Q?6a9wumbBrSaWlgElgD/KmX9W/pdmjT8X/7T82qyBMEZ9oB90Tqjb3YJKQFDP?=
 =?us-ascii?Q?evbVu/Z8LoStCLyUpkhDg3EsNa9MSZFcRy6pHOtoZlSDAxIDKysRcy5iohKR?=
 =?us-ascii?Q?4bU6KFE8tQufJfhKOLoOhXn9qWKMFsO0roNBOctoZ/XRWdk75Dqk+bAWXdX1?=
 =?us-ascii?Q?+gR66ys/TrYLxERhtS0R3N4bsUH4+lf5h5wAMHXlJoWbQ25OqCPPxvOlUHXl?=
 =?us-ascii?Q?XWLjddetuS3c3fRLtTo8BI+sdtED8pbm7veAnkizO5LwXZk3LLT06eCeDq6T?=
 =?us-ascii?Q?HsYEpotO0LsR+wcSvtAnQBBxieKHZqdGDNWNTCOuP7hsyJR8eLGEtL+y4gFo?=
 =?us-ascii?Q?4ZcGr6KyaIv6hK1Ma6mfjiK5HDHZ2g2/LWmIWCBXBX9A+lFP3iK6f1ZGEYRi?=
 =?us-ascii?Q?FzlG57B6Xx3Oy4EOqOPmRuniC6D0+6Nmwgf1ZUcnTElne7ZoU/fWjkLa5XbP?=
 =?us-ascii?Q?DJ05gz+FFDNvzC1FKxNaTRMPrbeYSWVYvRKxHYjqJPYXxIDz+V+GD15jOKcx?=
 =?us-ascii?Q?RH3PNjhxf6Ziuo4d18sxwUdMMrsYbyzllShfqV3K6Ve4Fk71WVczmg=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4a72cf-95d6-45fe-0749-08da08310da9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 16:13:20.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSOWCiZtIB2q0qPNK00ZSp+LgtlZeAKmba7e5kMzxwZfyLMKMophg2weFRZzJ+rmyskbepiHW3dA7F/bM0EW/A==
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

