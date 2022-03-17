Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74F84DCB57
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 17:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbiCQQ1I (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiCQQ1B (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 12:27:01 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021024.outbound.protection.outlook.com [52.101.62.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD43DAFC5;
        Thu, 17 Mar 2022 09:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0NhkDClOkLvQt/RRQb+jzedPz2jjhzXkr48E84UBIPZqzVHCCVKjpreHFEIYRa2aJh/hpekJtstZlZLriPb1pyZYxIW0W5/C4tbOkt5qAc0rRQV8y5k+9I88uRZfhlN2CczgZ2btm+QUWfheqcTg/mAms9g1xHyX7mitP+aQrPinrfj9go84olK//WJ/Q4DNc/r+JHid001vS2i8+XzmcO2tgOD7c9q9ibi/UuDrGquwCUEgR9cvw8lxucINj+So6dqljxRv43NtBUM6wbNNziulFpJCfemgBqIrxirwLNrFfjvlbUMBjt442OELZO3Hw+e8x0zJ3zvWn6gkxAP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxZuje2ccNfL+dilqXvqiAwKeYbCnnj+H5tv91jgZzc=;
 b=B1/g7SHhil4StypBijAPjYmj3YWTd8WBYPrWp8DnKdp1pHiu/awyiOvvdYu5N+NvXZzYeQulLdWXWBgJFqcWMSXijw0HLnIvkUU/5PAwlm8vzVozV9YSXF8DQoQ5PA/aNWj0YjWs312OsSac8FaQsIr1uCR3tt4VdmX5sHFPUbdsTPWqUEaay1egwwTRIylfmt2gimnm6oZr512GlhC+Ng+12ecmp6YUouzBmjGYYk7hm8P1GmiA1rMNRNnnVgguS3rgjM1peBioL6blZ1FaL3wD84cIJzJQO450hWy58oiPZN67Uvehx1U7QiRyMdAUUdMNXrVBW/c6LlL0Tw1PLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxZuje2ccNfL+dilqXvqiAwKeYbCnnj+H5tv91jgZzc=;
 b=Zgo7Fev8foZOmdvTUYUwxDLxYI6/ACexVvwgR71amsLRBHaueyo8qhfWajiS1Gu73XQ8wboXoefUtEWzmCJ4U+xcQNdW8ckWmzaq3rA96b8A1ILRiDTt6tzawMdqYwVVZOltoSgyRmqP3uDDt9yc/xUqNBpPs8oYaXb8XDfr/D8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BL0PR2101MB1796.namprd21.prod.outlook.com (2603:10b6:207:19::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Thu, 17 Mar
 2022 16:25:43 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357%4]) with mapi id 15.20.5102.007; Thu, 17 Mar 2022
 16:25:43 +0000
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
Subject: [PATCH 2/4 RESEND] dma-mapping: Add wrapper function to set dma_coherent
Date:   Thu, 17 Mar 2022 09:25:09 -0700
Message-Id: <1647534311-2349-3-git-send-email-mikelley@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0939e0c-e960-4f57-0e22-08da0832c882
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1796:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1796727DD7E54A7C3BB965CDD7129@BL0PR2101MB1796.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2PJvTQmy+qBdJMrhcQvH5odCF+txcZ7z7z0DEmBOhS5PN3DdVvpjJ6Qs6yA0cyWTPBSq1kpvFHDgrGrxnBw68CM6vvMt3cy0ZCrtzjJF5yCp5B+LbS9C7UQbEhhljg0QXqTBcYYLdjeeztifaA6sIaD5Nmywp1E9slwjqNL7xqv/IolJAXUo9/LS61m82vZs5UQWPJcBjzS8KR8+ber4NA7beK8dVT4/ZjqVARGYIaJeOIdYaYuhl9i7pD/P6xU3J97Cx75WaB80JKM3qqy1tl63oflbUB5jpwXyQHrzqs/O9foUrEDeY6D6aLI9CO9E9lmGeGGx4rbDcbuKVSxmOacfgucViFAi8snWDrHc0D9KmdCR4Svc2K5qO9ehDCb7cn5WjOYHs/CaCjKPBx7cO6BsXYxY3YIU/Y8Sde+ln7kLxIfw26daeFdf/bUuafBT06NUFHZQMuNQgeqJnDmFP0ISwQUDVHhnNzCM8Sug0a0DRhNIpTF9jUzL9a0RjdU9cV4GhuNmkyexTbSQpVIdt4R9yIDJi4h2lgqlWaUi5Z+N6AHHSrLofAhoo7/hocC8CIqBRCgD2ajEnsB6v2RY+8FMruzqBiusXRo2UMcxG0CQgWDtDgU5qWUSJl4bgXtilhHfPqsz87jJMATxmSVo64rG1cAfWGWXC9Km9hqqG40HiTynhI8Y5NK1Cl2i2Pl+2DCcNUJ/Yki75J6hvOlRd6DjcZm6b4En1X1zZD5/Vme54v1QmFE4WGTlu18wDk/WNFbv4HaUNfQzynOOS0lgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(6666004)(4326008)(8676002)(7416002)(66476007)(66556008)(66946007)(6506007)(921005)(508600001)(82950400001)(10290500003)(82960400001)(52116002)(38350700002)(6486002)(38100700002)(8936002)(2906002)(107886003)(5660300002)(6512007)(86362001)(4744005)(26005)(186003)(36756003)(316002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0av/8x5/s5DDYsN4H1M8Oo0+Cr42RfQO9oxfqFYM2cuxq79z+1qabJm5uvsb?=
 =?us-ascii?Q?7x6BapWsDLIKaiGr4MSPow02pV+KhLeMLo0hsJbg2cnZGLFC2ltA08hhPkiw?=
 =?us-ascii?Q?ax0Y01H+c6pm3FVw47ejuGYgl5JpHQuCHw2K0ZYHn47QMQj7PXczB1o2hw5j?=
 =?us-ascii?Q?Yz26jyFvkoYI2sdtjv+qEHP4Q06vnzYjPHJ8InQStQHdOPyVIGOIChq5XBvg?=
 =?us-ascii?Q?KB6oGx4lWbqGcTuyHAYK19UKdIR03Aya2SW0cXuofDsDOS3498xq7025UjEA?=
 =?us-ascii?Q?1Ga+8Jw8eBf1M/Jc1etlgvcjVbuFV5olF0eIcuhm3IKCVgE03wqOpgKgSqWF?=
 =?us-ascii?Q?wVKKc1Mh34em9qGY1ZCFwDmSXge5al8b/tAUuhtWqF2lnA5ZeK5r2vVJalv7?=
 =?us-ascii?Q?ufhWB3c3JbimjSnQZ2Un65ezCu3J4r42SsKh7nyQZ3GGWIzzxynIZ4UFAhfh?=
 =?us-ascii?Q?AxLqvF89MaM7nzeZZAaeE2Ofq/NmxvoBj8DmL1jXnboXL2nngtmGVL8Z268D?=
 =?us-ascii?Q?K9twsgNi2tDBHe80JqLAgX28xHy5eKlqRo6EOEXn5YZdKkYmf4TZVK2rhoxK?=
 =?us-ascii?Q?I1mGcyY7c/NkJIORBhGLc0ZMmF2KqbT4dZb14RFbiudY+jmRn41TkIasmKGF?=
 =?us-ascii?Q?1/J+OU8T3KERu/tBBVlUIj1/reucSocTpqgWKQjoLnN/aBkXuz5UveoJwW1F?=
 =?us-ascii?Q?HhTWGAAZQwIVw5moG9X/17GaK8gwi9gXIMTd+C35+TbXa/94XAogucl9+YNj?=
 =?us-ascii?Q?Bnw0RzuowuoWw8Sg0CaA8sM2CkE8NW+BUZONnJVkCEAsaBsGAIiLs/I5oIRj?=
 =?us-ascii?Q?7EMvO5RsjW91IXl59BLrVf9pSmAMDPlFW/9iU9IpFj4k/QD5yte1QOV73jMO?=
 =?us-ascii?Q?EazUUygzSOqcBc29EycuBW2NM2GO6K6NBLXkLMk5ZcwsfWq4FRyOu8+Vm9CM?=
 =?us-ascii?Q?CWorNkbpsRwBs+mJFX45ns9OGPa3JmbFoVBqT3SLriMGvwzRcIFaRanmX2+W?=
 =?us-ascii?Q?v2J2MB07Y8U4VFDoWrC5PCoKd/urAiNLcd2UDp7hGCiVPFtRRx+HILZse5gC?=
 =?us-ascii?Q?CjWBGL7wbIQHFt+h/c59/AWnM0BF3rsLLiK2J8xpOfYHgHUzG0UWf3SmRs7l?=
 =?us-ascii?Q?Bv6JCaPUv0N7w27D1xs0wRMldO5oS5g5Kt8rcmjMYuP+PEGJoF+lYSarqmXN?=
 =?us-ascii?Q?AdJ05M4gPbZJdTwYiJVZbARvncV7TGPJxahPQvsYgsreFO6EhSOjw1FnXRUU?=
 =?us-ascii?Q?mStx4I8Qpa0fCAJPMWuiu29sKEFar+Nh6cMBSlmwWbL48JWiHgI6fFxoOVdv?=
 =?us-ascii?Q?dLIb6Mrx1PRa89jiRboZ5osKwZI60W07OpV3kOvSGvvijl1UHzS1B0pdBBj5?=
 =?us-ascii?Q?5ML2pFGqsblJlETrdrdGGBQqKK/FsU4gvNhZPJjIV4mEglvpxX2EaInm2anh?=
 =?us-ascii?Q?rIs5MVFf9tTf4xIzWUtmSuMadQZk5F+L0ca/MJPPtTpxoPXAxaj6mw=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0939e0c-e960-4f57-0e22-08da0832c882
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 16:25:43.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thINH8NTaWtd2dm7lqe57swda2R2EZ03Z0TV3Yf9IMYieOtm6GKvzTCYE6wlofCTlhcm1IWPUL38W25Mu64EXg==
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

Add a wrapper function to set dma_coherent, avoiding the need for
complex #ifdef's when setting it in architecture independent code.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 include/linux/dma-map-ops.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 0d5b06b..3350e7a 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -254,11 +254,20 @@ static inline bool dev_is_dma_coherent(struct device *dev)
 {
 	return dev->dma_coherent;
 }
+static inline void dev_set_dma_coherent(struct device *dev,
+		bool coherent)
+{
+	dev->dma_coherent = coherent;
+}
 #else
 static inline bool dev_is_dma_coherent(struct device *dev)
 {
 	return true;
 }
+static inline void dev_set_dma_coherent(struct device *dev,
+		bool coherent)
+{
+}
 #endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
 
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-- 
1.8.3.1

