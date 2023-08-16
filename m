Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1A977E812
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Aug 2023 20:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbjHPSBB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Aug 2023 14:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345343AbjHPSAf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Aug 2023 14:00:35 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27A12D45;
        Wed, 16 Aug 2023 11:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIF7xnJ/6ZQw/Ur4twiwQ1BjzM3bghCuCdaBxKhmP3fZY5qCGdZ5zW4yhUmWrBBlVYBbDJd9sAlIBckrJEvrFwlNGqPt9k3Hwwq4zgbKn5XZWuzJoNmjvYXY0rlFImrUQg8NeXhsxCEfkxHSuoMBAWa19fUaPFrbz5QLPs7iKmm8eY7r83F1c/5iSjrfGBgGsO2uf5gD9rbkyAi8tQPkimCZzlYBy0YYJUUtChT5tnE7B9H25KPO3PoPrA9Lr+8lEivmpQICIsm6k27u2mjulY+asoHPoXHwXs1cDquedwPBW1WPU3SNjixIpMuoNy7ua0z/yfkUraS6N1oM7m1OwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koh5ZnYpXDiyEv0pywSlKhUHQ9hn7pXloCfSnctC4QA=;
 b=eIOPVZwccZlcdBOisfO3JjCtWnf5C34hopZrow+HtF1afOlcX/G/FOMteoYIYdN0aOH5BNdNd515pOuAC4DF1v2mWgbv/pvHNKdqZunn6uaGaPS4pAnilZWWA7LijobNha7kzRqHyBP8CjPh5FIDL7ny8AjxG4QgPtyANMVYeiDx16FRYl4wzrdKMNnWPAlsFc97t+pMN8F2SENeAkq5iIUQzeg3lbd90Sg75YmITN+nvVMqtYvNpXyIODUWkFqSTIrPgi1TJKAkuae8HMDco95oYXTRHvokDHxRZAuIHJaKRfUrkD5drPKtmxKsnmiAAI9S4viSm63FfWAVSP9T0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koh5ZnYpXDiyEv0pywSlKhUHQ9hn7pXloCfSnctC4QA=;
 b=dVV3Xxsne1lnFNlQu6TJXSKP0kxI03IivcQCx80SibVrkeFy23eo3Dxas4W31mQxlSIU502di/8Z6HEh7QitEoYKu6pgU1z9h7qKoIO42AHceFz5ynTtbm6DFyx/9WWkRxyauski9yHSODLA9obP03U7JXjytSAhczL9gnBt7I4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MN2PR21MB1503.namprd21.prod.outlook.com
 (2603:10b6:208:1f7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.4; Wed, 16 Aug
 2023 18:00:16 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 18:00:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     tglx@linutronix.de, jgg@ziepe.ca, bhelgaas@google.com,
        haiyangz@microsoft.com, kw@linux.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, mikelley@microsoft.com, robh@kernel.org,
        wei.liu@kernel.org, helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during hibernation
Date:   Wed, 16 Aug 2023 10:59:39 -0700
Message-Id: <20230816175939.21566-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0165.namprd15.prod.outlook.com
 (2603:10b6:930:81::7) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MN2PR21MB1503:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5f4774-4e64-4290-2eb5-08db9e82a52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzPyaK94eyN+lgllalHs/QuEmqXIZ3Iii0jTK+xfjnuq4mz3BfoMlfwvIrxik54IyLPO4p+irW2Uke3rLLNBri69t/17/INeNgdYbKTJw27M3WU7WrPwh+M3jNJeqSG0w7jAsJop8nRYhkKK0+z9DMC0Q4JdwQldOFP9be5Sn2qAZJUl+LPVGuybjEtyJrzynLVtACCFnHpJz90X5E/uYw+2s3VXd83/v+uPnuuhyP0PM1ij+ve8scaDkI+zwrAwpjk/xFNrTz0icHEKl5KrVYAIYZ8fr7RZ/07Z7onFLMvHu9Ivdo4I/R0p40uuquLFeMgggSeiVzjCW69DoR13kNuW8HqI8tagHwYcuZ6RQjTSYMbNBAUQQ0kGUcNMQrwC3tFZKUhIDlUAhEXyGOrNFyq1eiV2m/5it+zysgzEQ2hiXGNEWWGJsEoyr2ulOHafdrg6qd1/LqV+k1ezWeN0pWIbVWqDYMEBHLxVwKqDf6bKNK9Xm3GYLxvCpjm6U3Sw/hukVinuQiRRHxWhv//fWj+lSf7dZNOCS1tvRcjdfslgz8HYtiChNVmdr31SFmGMpe+7TaNKBF5IPuPO3wrtG/3uRJvY6sx6Aq4RDstbzWisgRKP8uFRu+i+oPUdDPy0RsDtjB3KNuOD4kcmAM2lhboXf1N56Oz9QLPmi42mKcSv/flwQaYA3Q63hhNKwPuW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(1800799009)(186009)(451199024)(12101799020)(107886003)(6506007)(52116002)(316002)(4326008)(86362001)(1076003)(66476007)(2616005)(10290500003)(41300700001)(66946007)(6666004)(66556008)(6512007)(6486002)(38100700002)(921005)(5660300002)(478600001)(82960400001)(2906002)(83380400001)(82950400001)(7416002)(36756003)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0/cam3NrogI2tZOwA8Bth514oF7ArA4BJJvyxYToQWaz1XUYpefBYgGy6L4?=
 =?us-ascii?Q?NJ3Xu8Fup2cZfJVFI0PVAEnCLOL0JPn+FMJLUT6SFZhOCRAwF1eCgCxlfasE?=
 =?us-ascii?Q?mL1RsUckGaVvPbKn3hKuhLfwlcFWV/Z29x/j9blJEpJTTLanYwwBSOqUGa8/?=
 =?us-ascii?Q?KXQOWnS+SWihZzfCTAQ/lfhnUzClZ7csC6Gix42VwIn+rhiSiClUfSdxhJJO?=
 =?us-ascii?Q?WrszXbzFKECWdPSfGxrRWN+P+Bvu3YWefuLD3NOtq9IdoM/FufPvDhoKpmR1?=
 =?us-ascii?Q?VYtIU7LWXVrCI3H04tZol/tTkznNZaomU9rtue5S2mQTg99L4BhNd8f3fu4v?=
 =?us-ascii?Q?XNWNE+qOTQoRXHq6DXAOJrUWk4qMaZ8HR5bNppaJA12qZEQAekKi3kwik40X?=
 =?us-ascii?Q?2xHDbq9elOVPpvf/ZuJOtooyAdNi2YW1YFovKDWD6JfVNel1tIvC2wWiRCWs?=
 =?us-ascii?Q?dpLc3wcFM9vFtcmcKljy517seecaPCkiuJiHz1pFkYXgYo6SOxLDZHnikumT?=
 =?us-ascii?Q?39+xj/wksiNBe61c+RwhnIfH7NZokkAMQ1Vb6BtOwnVAJplJDvUYOnFlu+LU?=
 =?us-ascii?Q?yvAOnEh6rvnX7epMB4BmSpJoRZizUKwz8YTBm2pSX9r5snlAFhjnOtAnRUKQ?=
 =?us-ascii?Q?4Q3Lk9nR8YHsteisEBHbQDzbmfkMD1xBV3i2ChMP7d/spsc7sXIwH+Db35OI?=
 =?us-ascii?Q?p1pNDDQbtx3t1vCvwzf5OFj8plO7RhOul1A1PhrvwP9bZcdnEq3Z5fCB1HtQ?=
 =?us-ascii?Q?AKp6adDrk+hTASItE9HyZY7KBOI3yKR5wGUEfgba35Tgfswazfjy11JVFioX?=
 =?us-ascii?Q?/kcHwPWtEcnLZ2pRw3/yQo5YhhpNaaEWTQwjZkd4k9VFMv2YEoBV0Dk5EgxF?=
 =?us-ascii?Q?IUX5PoJaRDsegpL2wePJgxuc5AasXRwkD4xuzqMXrUTfgLepIhI9OhDL8N19?=
 =?us-ascii?Q?9EWGlNMQJ0w9LliGoGpOwrs2PwUoBxdCWcIWkI5XTtLflWNFwk2ZbxlsJm2K?=
 =?us-ascii?Q?V3pAlLgAyUvUVuensFhJa7wgwcXavpC1NPt2xBGLuXUBnSos0uHcn29MSvfF?=
 =?us-ascii?Q?MOyp/n40yWp84ZB/kC3VXh0vDaYKv/iHGG3Qnn/mvsqhbEeNgmKLVu0cVoY6?=
 =?us-ascii?Q?ARDvZcvb74d6N0BrO02A556SRYJchxDbFp84vSkz/6Osuh2hwfF6VyFFOKEe?=
 =?us-ascii?Q?zbHy3UyUJZN4TdcFChLXb6jE5/VcdFxgIqsV/qBg1O3Cdy0pIe9zEVeW3+T9?=
 =?us-ascii?Q?ylC4OZY/OVHlcemYjzLknSjEuW6np3jZFbPF41TszxsAehC1hMu2KLsPGQcy?=
 =?us-ascii?Q?AhbyUtqVpYpkP8zbqdULZHu4f5Q8BsreIiIOS9yxt3oXfWy7Dc3WKV2CxVIq?=
 =?us-ascii?Q?ZV3WN/kNaJEO8t7xvbNZBrK3LIVKRpE9Z8iacbpnpmvS0uI0QDq+T8gWIFjG?=
 =?us-ascii?Q?mA9OVnxhT8Em59kKpXy1+jduEu+f2Gv0p+H20v6US/wSEZm3apL4jetNvqgH?=
 =?us-ascii?Q?Zcp2JbKsMj26PrZjQcMNys5lcjsJpI6ukHjxPfIPCE5hiiRx0VFaWU/xdpZC?=
 =?us-ascii?Q?ObhlCWiSirA2w6Yl6IoMULSiPYifyrHe/L9gxpuFkl1Q2iUoScpaB4vcGlIs?=
 =?us-ascii?Q?JUOLVydXxoPz9LcTP9Py8s5CKRx5hB1oJedWrwup/Bw/?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5f4774-4e64-4290-2eb5-08db9e82a52e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 18:00:16.1320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QD6bFM6Y/3rR69YKXA3N8gke09CK5XXppzXxvQBaHUPClaBDP5JqB8vYkNDLuykHjIOpZuTUVOfwsHcFdDsYnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1503
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When a Linux VM with an assigned PCI device runs on Hyper-V, if the PCI
device driver is not loaded yet (i.e. MSI-X/MSI is not enabled on the
device yet), doing a VM hibernation triggers a panic in
hv_pci_restore_msi_msg() -> msi_lock_descs(&pdev->dev), because
pdev->dev.msi.data is still NULL.

Avoid the panic by checking if MSI-X/MSI is enabled.

Fixes: dc2b453290c4 ("PCI: hv: Rework MSI handling")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
    Replaced the test "if (!pdev->dev.msi.data)" with
		      "if (!pdev->msi_enabled && !pdev->msix_enabled)".
      Thanks Michael!
    Updated the changelog accordingly.

 drivers/pci/controller/pci-hyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 2d93d0c4f10d..bed3cefdaf19 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3983,6 +3983,9 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
 	struct msi_desc *entry;
 	int ret = 0;
 
+	if (!pdev->msi_enabled && !pdev->msix_enabled)
+		return 0;
+
 	msi_lock_descs(&pdev->dev);
 	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_data = irq_get_irq_data(entry->irq);
-- 
2.25.1

