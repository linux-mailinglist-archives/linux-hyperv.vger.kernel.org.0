Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09A44DCB0C
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 17:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbiCQQOw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiCQQOm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 12:14:42 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F6C193E5;
        Thu, 17 Mar 2022 09:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxLySp1aViLrsMGfgp4KDMz3Ky65CvKFti+AQr9av7kkYLndnrtA6A4ULstkA4REASVj0c7IoYe2vqhL+10e36wG9Xwzn2wmOFz8J6MF6WNCkzevJfe7g4Igttl3TbaRF4oqgJnilXMsiB8AM17DsPoBH9ZXo+oYr6nfdVZUUSaz7fYpUA3FSaX6R6qFEWKfQYQK8b7u/iIPILyz972a2LZXvyhOvflH3vtpa5DDGFHDdFRJz782XFZhPVLmSFmWi5rgRzkv9ykzxaUdRzLVfqt/RDPbofEo24zVk2jAdb7dfQuHfoHtD6wA8h421XNnTHMW3nEPGTD99HO7Ia1e9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxZuje2ccNfL+dilqXvqiAwKeYbCnnj+H5tv91jgZzc=;
 b=fkOsSjR0dQz/aISbvdabql0JJP/v7jR2vRb2ZVDtBJ2bTP9OeuPjWQeuguDSDIb7d1zh+dplBq0OclJxtsR3Dr33EDANWD/dDYy8NQ4MzEU9LcJH+GpGqwm4Tk6bbGPhLQDAZDNAykuBNnbm2qL3SJC8Q5/np98Ew8yvb6vHFwwe+c9Nbzio6NSD7Yuj1BVeX7Fq8gC5BIOaH/lVcQJOiDqDYbGyK9cL4Z0TkkY42ok8qlh4o4Cw13xw5zExIAj2ZOG4myhp9Kkkv4GcKR3Rb5eXKQjs3vDsGGzTzF82inRQWAnjZMIdZmsgZMZRTg1M41zpcLDMgPgEsSep4AryUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxZuje2ccNfL+dilqXvqiAwKeYbCnnj+H5tv91jgZzc=;
 b=G+0JgNKUfO2ORDCNmIV4pmb36NBOMuO3rqAa4BBGcm0DxMYBTmQkivB/Ekh4Ew1sIzkHfiuFMlMpd+8rMKiltK2IlDVdlqIVT4yeCXPmEHTEQtrojD1pFaeA9dzzpw2jJH5jUvluYPy9IqfB3AZX9a4+2QDQnMYAM3Yrt7KvZEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BL0PR2101MB0995.namprd21.prod.outlook.com (2603:10b6:207:36::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 16:13:21 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357%4]) with mapi id 15.20.5102.007; Thu, 17 Mar 2022
 16:13:21 +0000
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
Subject: [PATCH 2/4] dma-mapping: Add wrapper function to set dma_coherent
Date:   Thu, 17 Mar 2022 09:12:41 -0700
Message-Id: <1647533563-2170-3-git-send-email-mikelley@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 15bc5f65-2eed-4211-710f-08da08310e5c
X-MS-TrafficTypeDiagnostic: BL0PR2101MB0995:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BL0PR2101MB099573B5FFAC3B820C0CB6C9D7129@BL0PR2101MB0995.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xX5vEMFad5s8jt/A9mdIS149oMA2VMFi6K5eFjPUixMelEhUF8kKUNC+rh6nDllOedNrRmLxSh7AVVcE3GEruhbOi4tVbZVP+xgoLWkDg+dRRpUjGyVSMNd95HoEXvoOUR0joMATGmF1iiUUfrf1bjQZLA0OQlldGHXuosGPx0GeVgkfDlNrD+GCKlayNe0wSpVM/b3Dk9BJx/AjcjIacIotINvux5tONLeQib4SRaEo18oZaFtHbsRepmVFiOy6h0O0Vh8z8EbULxXmtA3RVV/Pr36tngm4ingunARNqp3XQF1LFksb8Or8gWUMFnZ6/j6zR1bNnk7Mc+Z6qRdhJOXNVbr+tIh3g/Yh/Px/Z3DdfzhZslghrzYAIuIrFvtsq/yEtKGK+9B1QLoOvDXfy2A9F1ub/gYCyPWfHk4KDHqpVanAevt3dVvCsevDAJIY4a5AOPk47tcCi61z2pJlzi3xUnijIVnHee54J1YBJeI5x/5M6EL+LamtSIpQrZvqoumvvCyIXSu5kRWBHjFGv+r57lYZJ2rpFrIADBIVfZdD2U8FS4BNUT/cB1v42vVNJU3fri3lNEiJsvxIip3DY6nabIMsAFb1s8aeC64kzjaGd100tCh7jfPRfKc/fUmq1bItSCnuyWbKIoGWkQolgjWL6psTS3RwLtsjkZtymo7lZH+mc5Dx/jaVIEDhhAypI/ad8gQ3KiX/JQ4lgP9InkueQJ074DUfeZuHwyKKtg5dXqNQA3QTmUQivO1Inr6a7XOjQGq25lkz246Fa/4OAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(186003)(26005)(4326008)(8676002)(2616005)(8936002)(66946007)(66476007)(66556008)(107886003)(38100700002)(38350700002)(316002)(36756003)(10290500003)(4744005)(6486002)(86362001)(5660300002)(921005)(6512007)(82960400001)(7416002)(82950400001)(6506007)(2906002)(508600001)(6666004)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7gxaX8ohOJjOuUGyD3S9A1g1jaFz4jtXJ74XO7DoC0aR9xG/gs6MUo8KmuGh?=
 =?us-ascii?Q?LtqDhJtKRyfpMm716LYDI0fU7J3T5gSK1oAznL9plSyLl8vAgEIGvNKNpRYU?=
 =?us-ascii?Q?iD//LgpTvq3ZdsKcuL6Pn23jMd6lbYjkSUyonw+Fbn9ASWlm1VCc0el/ilcu?=
 =?us-ascii?Q?wjn6T/hJquke4FofSoQjQ+u/sYgsIK1C5yjwaREDOtXqSwSvnHIdSV5CADpx?=
 =?us-ascii?Q?l7NmlwwDcX9u1qikGKyLzA6T8sfOWY0SAND1UDeyYxbgvb8YuGpPZhKcEDM+?=
 =?us-ascii?Q?IAACQynspSW45jSIcZk1qjnKtzck+z+PpNCYxFuSapZwveazmv36KHON5Qau?=
 =?us-ascii?Q?ZGgIe3zxNtiIDco3mIU5Ggzq4/++h+3vFrkYKNdsOI/5q9QLPx6SaC10O0G0?=
 =?us-ascii?Q?yTFjchMPh5LRkmBnBqdM6v1nJZuEUrQZG7mhKT6tsT3Kj5Zg4hESnZjpwc6t?=
 =?us-ascii?Q?xUMecxp5/D1h2hSsyWSnuD2YcygXQJqXNqwpZSTIHxNwxr/33kpXYs9DEnUv?=
 =?us-ascii?Q?qjgLjJ0buTJ7ROXtV2gksxouOLdDLmnGccvmNz3MSlEcG23MRw3tJrsdgYB2?=
 =?us-ascii?Q?Lx1MT8sB69ezG1gQ7nJ6oKl+nn44TFrSU3atDJm9Z43Yyr53DNNeZbHSfmNy?=
 =?us-ascii?Q?LBMpuUq5KexYHWkV3FgloHEs2GmhLuPPVEtSnKr6OIEDsTEjKQ8L7kbDGnpz?=
 =?us-ascii?Q?PXrCEM31erq7I8kWX3WXXFQu9SZtcqp/GFjIvrWELdrn+JO11J3p8b/sTeKW?=
 =?us-ascii?Q?COIzGHYLELVHbPfHzaxXpzJxH+SwXQq73hJ8PLx1XNLPM00fl8dTPfH5uLEx?=
 =?us-ascii?Q?OzeAaXH3gQRCEr2ZvhJ/e0g7/BVETFSsvW55cYNAAGyRzShbzrcWJJ25HB0s?=
 =?us-ascii?Q?bpHkvzd8uJ015hk+8Q0H4ISTwMqgZdpFdqfoGBsVNddXsgsDY+LToNeR+JM0?=
 =?us-ascii?Q?l/FfnzIJmFgaEWuZsVXLQDBM8GTRkV/AvKXlm5Jb5BogiQWr6GvZNitFcPs2?=
 =?us-ascii?Q?GVD5uL/hCzGQjwT9RIcB1nNugwhWZ7Y+HhCAcEbmJB0sySEyqsoJvas6rhcJ?=
 =?us-ascii?Q?zbaDjH0vMdgF83QNpLb5tOm2hplZvbJj4lur+8DyOX+ufqjEyQwk4ee2jwxx?=
 =?us-ascii?Q?4B6R9LtWWSDAAXsSpiOPpEGXerhZR2xnt1EriB5UDzYzsUfFn+Ud1XazLioA?=
 =?us-ascii?Q?nCWjGmJ7AdAI5YsNyg/2x2DSKI61BlkJLlyD9I+1nFQc5qUbpJ/iK64kE90w?=
 =?us-ascii?Q?Bci2CS91GEw2sZaUS04WrpRw+JM9ojdfWF3P9NfflqrOckbvqAGT4CIC7+nN?=
 =?us-ascii?Q?ZagzMkrqO0qifhaLSn8DIye7FtVp6kY7Ee2K6xlx/ylYjIdB2w9HqMvlXLSg?=
 =?us-ascii?Q?1z6fIXC1oJ1kjI0/15oDirS9VYDzQXYSfA1F0pWp/YpKSxaLgd9kTf0QaNoC?=
 =?us-ascii?Q?6FsnmIGphGOtnTaGXVgsCYyYvh2b+U4V6txZ+p94l67pzptEAAZ/Fg=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bc5f65-2eed-4211-710f-08da08310e5c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 16:13:21.5005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1AZ2zgZ+HoEYzwxZXYDQSGnM1l8I8jE5TurKy8qUDX69ccm6WmYgY0dYM/xDSSrf/UGCFqC0rVqUaef+f1PtQ==
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

