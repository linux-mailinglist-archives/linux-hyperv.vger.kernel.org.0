Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B7D555419
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jun 2022 21:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377763AbiFVTPd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jun 2022 15:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377785AbiFVTPa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jun 2022 15:15:30 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021023.outbound.protection.outlook.com [52.101.62.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF58239B96;
        Wed, 22 Jun 2022 12:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epQvadr3sZHgdxj3tBMvxCS4QQDVbrOkCn7gIIIIrcbNLMdcfH1Q6bWj36sYg3vFXW2OIyhNFRgzVOYW82UzfZ52BDHUg43Jcjpg3TrF9rJtx2F9O1dKBVAL3pnhk7weQsPYljldR1CJamX1/uABDryO2SMg2hHonxO7xJxnmOjKW0O4gpz9v+0D38YBVc8EnnRgUKpGA7kBx0RrvE6r7XBtYyb97L73OSgAz6uU43jZqw/fkypZYMLWMNLHeSeefchVw1SS2nSkIQGxeOOreCgWrc6PxXQ7S69JWoQ/CF+bilTYJ1TgNi3tFibvNHahPUtQi35l2Kj2uBDYvDHcDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xCS8tKm+WbF1IY7eak1JzaFGb6aovru7CwHJaA4FCo=;
 b=MYpyJC/PILweGn03ro26jI/pyXc5KZJ9sHyOmp5uHmkuE8BqzHTE5fT+H3WJIXUUD+u+qg8dwZOsGEIKC88lWbU5I5mZJdBhWAW3EOQXgVf25Jg/JgkEKQQaVTwcbTn/Xz7J8FX2nDmwgeFkk4U7JGF7nWOjAY0Utb3nAF2lm+MPg+36Q4Hm7euI/OBpBDq5/mfxasJ2Rjux6eZAVPBC8CRS2JtlmvhHiJg2DC3pcHSONlgLoRbaa/2DlERFbEOcUp3KKr9oiuvLNEv13si4FDD+6gKZV0bD9NJ3Q4szM8l56CVFilMems0wzyNjzIxTBWSbx1Ju1+Hk232g9Cf/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xCS8tKm+WbF1IY7eak1JzaFGb6aovru7CwHJaA4FCo=;
 b=Lt3tFh6AZf082dQNXI48H5RtQmejHI7vuJbIFaUntkoe5AcKYy8Lme3Y96eO3AOc5imdpEhlblwsf+BfZEFIWbZL/Ou1QoFY6Qs9+Oqc8MY8ykW0ulKnX+nl8E0ZhEgClx6k/QaOEc0ICNpno+o2HEwUJhpr8IF6jNTP3bCDgbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from CY4SPR01MB05.namprd21.prod.outlook.com (2603:10b6:910:8b::17)
 by BL1PR21MB3115.namprd21.prod.outlook.com (2603:10b6:208:393::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.3; Wed, 22 Jun
 2022 19:15:23 +0000
Received: from CY4SPR01MB05.namprd21.prod.outlook.com
 ([fe80::6541:b4a2:1fd8:14c7]) by CY4SPR01MB05.namprd21.prod.outlook.com
 ([fe80::6541:b4a2:1fd8:14c7%7]) with mapi id 15.20.5395.003; Wed, 22 Jun 2022
 19:15:21 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        Andrea.Parri@microsoft.com, Tianyu.Lan@microsoft.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] dma-direct: use the correct size for dma_set_encrypted()
Date:   Wed, 22 Jun 2022 12:14:24 -0700
Message-Id: <20220622191424.15777-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:303:8e::12) To CY4SPR01MB05.namprd21.prod.outlook.com
 (2603:10b6:910:8b::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfcc9cc6-cbea-40af-2834-08da54838d3d
X-MS-TrafficTypeDiagnostic: BL1PR21MB3115:EE_
X-Microsoft-Antispam-PRVS: <BL1PR21MB311514A12B716AD020F5F063BFB29@BL1PR21MB3115.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gg7Z1g618joQ5J4cLIQ9WGiItEae2VmJdZ3NEGWxifhFWKQBYbOg1IFALV6lYVQWDZ9oOpO8akLr9rw4gLFlqGM8Gffo54dmtBhbcV95YdafUjiJabaApekqzn3MTRRJpiT38aM0PcHq5+qOieUF3uqimb6++38hsu8XWEoMP6zOoMpJGM/U0GIEAvdxxjccA7/07TzK0w8qGaOfDE+7Toj/V28Fj6jKIkxTVCuOLgizUxYyNImVMnwKOrQl1a17FsC//ChA7tLcmOBYzGZyY9VhJQ1cWiGb+Cvw+TI1e9fv+1rTWzVqYsIS/ldGw0MCEvWNVvj9TUWtoX5C29BcnZSXRWW+ueDPvaJQQvA0rdEi4Z+Na2O5xbZ5zrZBJHCoHedCtTwwzHTw0pOofbqUTCWkj/ieH7Zei/mOyyulXdwHbSmcLZnb9FuVc2ZKtSt5GkEeMul72WxkGAFu6VgAGMeUPpJdMm+65I0aiKrK3hHa7/r05uX2kFoxS16zGsxkxQ92AbGxbjCu7/iK3cpN2dGKd30NWugWKwghxZJ6dOBZURR8BkohdmiHpKtHpoamyIJeS6d+vB3HJScxG0R1OWbIXNIc8od7kdDoZS6uxt1WQ0F8WX1/jOULlCPOFye2Uz1b/fnFlgbqFQe7lsiFtShWNl9I1lWsYzlHibDY9xpQtujZLSuGBhtCnQUHA/VMrdRYU6J8B5ZeEvk8knAI6gM202TOC4YwrZVDCzGcBwKi3NQHqCy3vm3SJCrXl3bR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4SPR01MB05.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199009)(2616005)(66556008)(6512007)(8936002)(186003)(38100700002)(316002)(4326008)(66946007)(66476007)(82950400001)(1076003)(6486002)(82960400001)(107886003)(83380400001)(5660300002)(8676002)(10290500003)(36756003)(86362001)(2906002)(6506007)(478600001)(52116002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K9PhVtYQqgNdImgyIxlx47HIBlzXn4wdzOuK3degpvCExVa8r7hiqWWe9C1k?=
 =?us-ascii?Q?27tHno1896/ofiZDWp90ds5VPoCtVa5r0QaURswtoAiVPxz+Wie2YShuVsRK?=
 =?us-ascii?Q?74Y4e2jXTxIZxlPqfUprToq1G83koNl5vhbjAzLQpfOGqdLQrG6mGAvff0eW?=
 =?us-ascii?Q?PsPYVLvD8D+WrcEHt/T0ZwEz2LzS9anMSAHnuz8knJaidoX7HH8GG/KoVOWd?=
 =?us-ascii?Q?Zo+OPRpqn5LXcglqR/5fyL2G7dpBHkhx8CrRr7GVZU12aSrzgQ9IZs85ut9E?=
 =?us-ascii?Q?dAiriGP6YULUfWFKiOD/eQXDCtVVBTCP91XpNQ52IU3g7XBvKBToW5ShrGD/?=
 =?us-ascii?Q?dRrs1q+nh7DtoW96kfzvBo6XC7oDqiJQI4bOs5cy6K5F0WRVGWExuJl4pUwT?=
 =?us-ascii?Q?CPDWq/3zPaKGmqsjcpeJuyBj+d0a/hWNTT9SqlJ1p4kpbUXsx2bvQfX6QWqQ?=
 =?us-ascii?Q?0dRx6Q4dEqFFWB8BMLK0jOCh+qCP3cYG7sF9vHjCAjxP3TKn0FywxJZlXE//?=
 =?us-ascii?Q?FAQ3u09EhPHlGLeVJLBcLevsMh1QuNsh8CAJErz54OtR/xC0jRwcvaED2o2X?=
 =?us-ascii?Q?5Prex/n5osYSBgr7sEb0gws6Fg1v6GVu1aW7/f2bMjuWr8YWDZPA4ApQFZGB?=
 =?us-ascii?Q?zsdinBrQcSlVF38ph+qtN11Yjkr9cAKbAtzeeM1hhxsDuYdh8G5bdu++xVxu?=
 =?us-ascii?Q?+9JQ9qMSdP1874YtGD8pg4TlfkCMgjf3+EBOJ/5Kuzp/kj7yeYldlq56g31l?=
 =?us-ascii?Q?76eneJz7952yIXgTH6wBo1q9MgPmRu+RaqXfJhOWA+U9TfEp7GiuNYadjsMH?=
 =?us-ascii?Q?k+CH8/6SL72k2+U5PRkSTY53SUgbrha3Nf9U8Z4bRzmN45PjWRJDng4TsqkA?=
 =?us-ascii?Q?ylpk9ndho32E9D3YZBjI0Hm8zzHz8dxZ1gREbU8VkCcej7tAlLE99jv6IePf?=
 =?us-ascii?Q?Rij7mRBls1RDTF5brUUfob74fCdr6IHo5bhJKBxcE/d/Hw+7Hw56jeOJT4WU?=
 =?us-ascii?Q?4BIvTYe1AWbJDR4gs5tai0GlGI8EcObrqyu8qnMwBMvGGBVS9HvMt6oSO7xL?=
 =?us-ascii?Q?M0jx4nKw3UpFLNAxLd5wpE1CnIuRcCF48GY/RgGp0/5/+dECEwhgC6KiAy+g?=
 =?us-ascii?Q?oHwIrCbab1LrD59+Uu2G4Wd27MD747M6GA7fECEo9k9I2kyr2HbLhbSB5eP/?=
 =?us-ascii?Q?2tD91DmxUDtsgYC1+aXVVfl0b5PFQn+1/AxADJ+SdAj/eFWiLzh1KPeuMn3c?=
 =?us-ascii?Q?xpOmuLs4+CIX5C2r8zuiF153T3PmO2oLNHXvbkypkxFtqvu4fuNg/1R7nsT5?=
 =?us-ascii?Q?UoVKT3MpiaJQkJ08E86saVpuxC9eVBHGMtYRZMs+fgNn6ArFiCj56fM65TcD?=
 =?us-ascii?Q?piDV1DbmmXC0nmTaH0ZnlAo5qER99/BN7oSNCutq8XtUYJFcpkbejWy+kSux?=
 =?us-ascii?Q?yqO37OhvD8Yl3WeHDnBEIeLZt1Fc+FMTcncQ4ZL542DZ6bLHAZh3PJ0PlE6v?=
 =?us-ascii?Q?cjMeGfcXYYQmFAXlEzF2/ykl7gDsfC4FZKqjdU01B2U66NLEbxqgYEQrkIgD?=
 =?us-ascii?Q?pzSk2HPqhSGy/6tqfudOzxGDtwyqMiOfJyEVrz+9KYqxwe133KIE+DHoZPPj?=
 =?us-ascii?Q?89voI5Lgzp8+KIQC9QogUIOz7qOIq4k1aeUh/koImxqQ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcc9cc6-cbea-40af-2834-08da54838d3d
X-MS-Exchange-CrossTenant-AuthSource: CY4SPR01MB05.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 19:15:21.6359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2jVOwmCNibkvvEI33Wya22JIhoKGJ0Yh9PvbfQs1eTSgMHJU9WZ3N9CGzayeXm95QIFbXPuCW9aPKJ5lKZIiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3115
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The third parameter of dma_set_encrypted() is a size in bytes rather than
the number of pages.

Fixes: 4d0564785bb0 ("dma-direct: factor out dma_set_{de,en}crypted helpers")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 kernel/dma/direct.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index e978f36e6be8..8d0b68a17042 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -357,7 +357,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
-		if (dma_set_encrypted(dev, cpu_addr, 1 << page_order))
+		if (dma_set_encrypted(dev, cpu_addr, size))
 			return;
 	}
 
@@ -392,7 +392,6 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 		struct page *page, dma_addr_t dma_addr,
 		enum dma_data_direction dir)
 {
-	unsigned int page_order = get_order(size);
 	void *vaddr = page_address(page);
 
 	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
@@ -400,7 +399,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	    dma_free_from_pool(dev, vaddr, size))
 		return;
 
-	if (dma_set_encrypted(dev, vaddr, 1 << page_order))
+	if (dma_set_encrypted(dev, vaddr, size))
 		return;
 	__dma_direct_free_pages(dev, page, size);
 }
-- 
2.25.1

