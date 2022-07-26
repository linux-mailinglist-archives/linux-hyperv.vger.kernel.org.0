Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB4F5808D4
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jul 2022 02:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiGZAx4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Jul 2022 20:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGZAxz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jul 2022 20:53:55 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020015.outbound.protection.outlook.com [52.101.61.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9356527165;
        Mon, 25 Jul 2022 17:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4S2ZtXqefYr60kt50U5o0g16LyDitLXoO5pdzaipqOT0do8CaJ5/J9GquFLVUujiSEc9ImGzeh6NlItAlXNL/ZRFRgnmy+K48IBGzwKHCP3rvgk9yCUQpNYRz3YmD5Nnlw4ecxBN7UM2lfl18XSy+6McEZFaW0T88hoaxpeb84VJLYAgx4LgKA6Hn3UviLg59/KgLEWClJWtlMK8GvbqgxF4QdRyukpqr5lp5KxDb510ZAqKHzpeCSjcCxYdU8gl7RJ7UxHDTHxWoze8rMpS6tAIkt+tcoLQ2OzFv09IGNtadBSTSpR9W+IX//Gc2MhJdhLq97mHp9KPAQDkJcdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhrnOe1aU/VZgfb3owNjE8RU8xShsRt0TaHpEnM7AF0=;
 b=jFnKsd7NUu/Ky7iccy6KHM7lyL1qMvWaXIFmnrwNPGNs0rZZelA3QVK2ZY4Ej7eMebgEa2AExqxAu8vawu6LTo2ywu8D7M/c9gNO7Hu5IS1MqhzavCMlrFjrMKEldCkGQ20zrmqCS4rIzR+GsGe7MuNzECW+vcoQAmolPnbNvtLSKDMTiNyFMRng/rydSSLZmrqlTclfbIvX32Ka1VKQJs5LHVJIRmZIyRTvmJXKcruKUkItFiO0mVr4akrpDFt67hqdgfOEBmJjtPXLZHk9vtTvNeot4aGBOjIiTG08pQoFciB6Gkp0J/9bcxxR5toqm4vC+nLP1lWcD2PQsTBO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhrnOe1aU/VZgfb3owNjE8RU8xShsRt0TaHpEnM7AF0=;
 b=jOy5M5HU++KaJ6x/dNfR0y2/MxJY/mM/BdDrX+WrskDiY4oW3NzyvqIXsRPOFE0eF65mx0d3zp8mIF3yxayv6sDxT+EX6TISrORduLuX/D0JFG0BDTVly4irW+r+3EY3Zv6N29FhTrmGO617rojfI/zp6xijmzwGpKSP2Wb3wm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by SA0PR21MB1881.namprd21.prod.outlook.com (2603:10b6:806:e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.1; Tue, 26 Jul
 2022 00:53:52 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6%5]) with mapi id 15.20.5504.001; Tue, 26 Jul 2022
 00:53:52 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        iommu@lists.linux.dev
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] iommu/hyper-v: Use helper instead of directly accessing affinity
Date:   Mon, 25 Jul 2022 17:53:40 -0700
Message-Id: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:303:8c::13) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33c4d571-afba-45c4-0b54-08da6ea14ecb
X-MS-TrafficTypeDiagnostic: SA0PR21MB1881:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctmpSN4cM+EbvMdqurYev6u7w92BONEvVrFOMqsj4h+lSgs9Itz8WwFmRKIZIRdVpato7HxQt+zA7WBJNpKo+Dz3E1IkPoBKVgdDdFvuAsP6plzl2W4Y8mlvhWk2JYeHfEwtf8UbQyfY8oIFrZ0yMLoq4Chk8v5f3wN6XJ5nmDlxW9utefq+eTre426AKxCKrnFTS2jlkhX1gd5mGlaiGEFF58LOv3RE/tfWIxI25Dqcf2KrDDQq4UY0KiTLjbteV9P2llHHL0JZzc1UgWbhMJf2Ot6x7mEiOCQ4mdts/se2vUdU6TtDzqFPxAyPAXmp8hZnvkZ8QDZkzEyRAsl6aanXpTpHGzFemcQRaGlogs2xX9naJ4vvGHj66NoeQgeZCd+mnQXB2BUeuo1ZBah5nzyiejQBWIWsXXNoTsXWIrhH1m1YBEWRvsKZuDoS04aEWAdpfQXOYCZKzZcBjlKStfOf1XlQfMEKMVOHBdbA78VWI1YEtwaI675A7zMMKyaLqGxX4c96P0eEamRc/23Z90X9AULUccQSrNUtTaoeTZcUi0rIk7CrbGu6jxOnV0uS8P/+3oAqeQvn+9+XJdEPJizHTGdafHNcShlNA9C4r1RvjCCVPiB38Hxznu3lQFBeACdBq+NqQVPCc5W7yDsibZ0QdR28CDjYJO5k8vTw1mZW2HKzrsDkV7gqm3nvinvlSpAYxsILDbuq+w7k4uJvelJ6xeZBwa0KJUbthemKBePmIXQLBl7HTZARktYttmKCg0CGUQYmRyKMnUPK+qnNyvPwevn8agdC9ZRLrf9kIPkWNW7BuXORAjwdk/b3mVaJiYngKusmhjIAGr9r39DJz7NKPge1BIelJjUXbaZj3Ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199009)(52116002)(6506007)(186003)(6512007)(478600001)(6666004)(2906002)(26005)(316002)(36756003)(8936002)(107886003)(41300700001)(6486002)(66476007)(83380400001)(86362001)(66556008)(921005)(82960400001)(38100700002)(5660300002)(82950400001)(10290500003)(66946007)(2616005)(38350700002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WKb9iN3LCqTqJqldI37P/6QbnRfKC6o31R0bNe0CUE0JpuzJDWjAO+J6DzSs?=
 =?us-ascii?Q?7S/9l3bxoTHNOmty5kEGuVKxKBTYw1qqklorWjfw1UK0VYuLpjgOsC15nmnf?=
 =?us-ascii?Q?ITeJJEI+3/J52nF5LAMjLCyJt8cnBp6/h773E3bC/vde0oO3ael8MbO0oyDh?=
 =?us-ascii?Q?HT9x8Hl6KJvykH6Xu//kZWj5ce5QtfceTkotaU4QUK3MvrSyPv5Ee9lUa/6m?=
 =?us-ascii?Q?c03zSUu5c2twSEgf3cHASqzPV6u4mZWyomPN6Fn7IeTcvIiJ5freTPIp9SX8?=
 =?us-ascii?Q?D8SJL39+9eEZ4J7H9ZFSk57t/voFbmqmrEGBiB0yz0srWmVdNsMT+SoWc2X0?=
 =?us-ascii?Q?oX/nlw5w39lLsDLvzSwp2B1O6BVVmjeuBDSSx6TxttLSKrcx1kL4wNZzpNkH?=
 =?us-ascii?Q?IHu8l0cgD41K36GMtqkdozcQcRt4jBPI+iejaOdMZ9B9g52q9RotauyCGr4i?=
 =?us-ascii?Q?jPbj78hVqZutfly3I6PphtTvW0U43awKK7yCanAIVzp+llqM00VzLME77lTV?=
 =?us-ascii?Q?SP2So1K338bebMjoNRiDlvbyD6Vjh4c06ON8jbMHjPB+Hhtsba4E68i44R0U?=
 =?us-ascii?Q?uMs370GXxTD4yWyOUe5jSy9X+ReA9gBfV6CzIQGPUuviPscy/WBPWEFEym5l?=
 =?us-ascii?Q?DAKyQlIVvK+CB5z/YrxmN4kQcHP+GjvMtjbjj1EWL+iDRyVoN96Ru/kbb0Yc?=
 =?us-ascii?Q?LmtEh6id1P53TvnG52qGuWB9Kna435QJulS55yGORYSJgABvklj5b7g2mPYr?=
 =?us-ascii?Q?RStzlAp9Md1BJX4WJG9qQjBZtqQmk1vO1VHkWUHaO9uye8+6CHHlNIiR4dn9?=
 =?us-ascii?Q?F46ZAOLBXFH8lovz1LwLPSvG2Yr/a24pZyPoMxJHYiVQDhUJCweJPm9r6O19?=
 =?us-ascii?Q?7i973yqIh3wl5c1LOwehlzxFKX7uO76k69wbF0ZeSRN13V7xKVPdssQARNxf?=
 =?us-ascii?Q?4yWhp41cgulCLvGLtq5irK4DuRJ5dDmdoipmEebzdbCIr+a4BelC0ITM5VFJ?=
 =?us-ascii?Q?QH80MHIizqMWngFZrtrShh7/qfrg7zWHaIMDGRP6U611aDLrI9PnpRZjLxA3?=
 =?us-ascii?Q?dZcyecOsn/7Kbzv7TA7cekE6fhJW67RYjNxy7N+004bLW60/U5TuDcU1MWcs?=
 =?us-ascii?Q?MaOkoFE5MsTcUNa4jJ1XYGbeqYh14MPlqqvkGOZs52bYst9E9EuXf5SXV/0B?=
 =?us-ascii?Q?M1zM/c6PsQavtD3pJ+t+Oo+21joU3St6BJKuQM99x8zDOkHULMEq9hn0J1nF?=
 =?us-ascii?Q?Tk/tDA1MSaWC/cOit/kK719qDlRP3539FsXkK+qRYl6PQGqB/L0pLWfP91Wg?=
 =?us-ascii?Q?Ggq2+jy02uncPw0Pp4kdBnqgfrUccYDIH7Skx+z6/cTsiXi+MAg07mvelljR?=
 =?us-ascii?Q?rUgDnSDpKiOqYR5vYPcOX1hcaSisQB96JsbTvbSFu3diheQBMqkRPtHsjwma?=
 =?us-ascii?Q?KJ5QE/O8sWlXp4RvM7+dj0zjw8681a9YKxxPkuDMllemBGVGFJDg+RotgsWd?=
 =?us-ascii?Q?kEelp4B0T6s9DYn9YF7wVjC8CgC1wdbz9PyKBDO7CR2NPN/JPBpfk5rfF57L?=
 =?us-ascii?Q?4HaTmTTDXqgt1ORV3JYgTu+WL6+Mqiy0TgRNr233?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c4d571-afba-45c4-0b54-08da6ea14ecb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 00:53:51.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZ0e6mcbkhCQ3HKqYNp9T71W63AccmsJrRRaNiW7oZE4rV+QSOUpfDfE3CtBip3vyOHpZBQAn1zLKXi9PSG1mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1881
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Recent changes to solve inconsistencies in handling IRQ masks #ifdef
out the affinity field in irq_common_data for non-SMP configurations.
The current code in hyperv_irq_remapping_alloc() gets a compiler error
in that case.

Fix this by using the new irq_data_update_affinity() helper, which
handles the non-SMP case correctly.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/iommu/hyperv-iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 51bd66a..e190bb8 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -68,7 +68,6 @@ static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
 {
 	struct irq_alloc_info *info = arg;
 	struct irq_data *irq_data;
-	struct irq_desc *desc;
 	int ret = 0;
 
 	if (!info || info->type != X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
@@ -90,8 +89,7 @@ static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
 	 * Hypver-V IO APIC irq affinity should be in the scope of
 	 * ioapic_max_cpumask because no irq remapping support.
 	 */
-	desc = irq_data_to_desc(irq_data);
-	cpumask_copy(desc->irq_common_data.affinity, &ioapic_max_cpumask);
+	irq_data_update_affinity(irq_data, &ioapic_max_cpumask);
 
 	return 0;
 }
-- 
1.8.3.1

