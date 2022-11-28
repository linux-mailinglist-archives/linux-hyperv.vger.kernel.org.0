Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A317D639EEA
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Nov 2022 02:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiK1B3W (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 27 Nov 2022 20:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiK1B3U (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 27 Nov 2022 20:29:20 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11021021.outbound.protection.outlook.com [40.93.199.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE14A45A;
        Sun, 27 Nov 2022 17:29:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPmNYy/ZuAHHCsfSIY49RyHKLTs1zr5I8wbmVTiAfc6SikWd7aWHdV2+M2Oll4U4V8nsoI4dBnRMvW/QxIrvSwTuzBwKYfJ5PyGkKRM4i9Ap1uHI8P94TUoadyUVJVT5+QW72QySSpZN/gI+zmL2MKutwR4yr0o9hSWXagmAmVbA3zOuHjTJXsIh8fx90sME1P0VHHb2Ahtctr4FazOXYJpCUjnrto1iL5ahdE558nfwcYj8+UNmV7007IwBE3w8kBKffp0X9vH8OBpXfPFU/2Rwnu3xNcALnkbqJtd8GlAv8jgC1jHHcPmrsWDrQ1r8NN1O9m+kYVxCwzmMRzsDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMqDaxVGURKlurcIfHpj64XL7RxGRS5P6xfgjYIvG1s=;
 b=GFCFiv70tHyvzdLT7VXe+SsENJn87kayS1aPowZFWMo6ofjN+Tf04hg4OHrHaE1WDnIB3n/wTly70kzfMpaYqJHsaC6gVHY+SSFs5DB/PZyClnMW6AiZUl0X7dm2oBpDfoBgmYqNnW48AXWyvu9LM/WDFqnIS2ZMI/jjp6Btqt/sPKx5frUArRu8e3F+8dYF1U1l5A6zFU/CG1KYlKnk8GEWVSwCmRr7p6oKzwMmQ5HN3amS75AgEq8u+2dU4U+wkO4mRc0dE8aPHALkddCp7kYCfNj48zRgJJ07+ih1pjsJv9Y949e4YSRLx1nnZp5WCUPvf0TC0PV1Iu4oc8DxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMqDaxVGURKlurcIfHpj64XL7RxGRS5P6xfgjYIvG1s=;
 b=dXbuMMunY3dh/eTUj7Ahdjac81G3yJb34xH0auCLJW3C4Wj2dKFmoynr1rRkFHwkzvsroOXejYE5FwGuvyS9PmricW28x2YDEHKW9My2ofvuPTioPoxiy9+nK+LZHIHc+tcgVtioBFbzrdnRbIhiuYW8PZ/jka2CK0gz+UUwiMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DM4PR21MB3153.namprd21.prod.outlook.com
 (2603:10b6:8:65::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 28 Nov
 2022 01:29:17 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 01:29:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, brijesh.singh@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] x86/sev: mem_encrypt_free_decrypted_mem(): encrypt the pages for AMD SME only
Date:   Sun, 27 Nov 2022 17:28:52 -0800
Message-Id: <20221128012852.8561-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:303:8d::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|DM4PR21MB3153:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a3e645-e7d6-4b37-0885-08dad0dff652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQ5MI5mn3/pFcTlYy1EWHp957DQdaQ9KLcpHzSL77XOt9v/CfpXQ0DKM1SMEcMja3AB+EdWPfUGVP1VeUfRGJbyuIcRebNlisWr4/qQ+GIKpc/0SVb+zvJZtnUzN7dxnTwXN+4wwAp+YFeDF/LZw4gCU+fw/7M/vyG5eTDQq5WqeRaknge3mI8JiOiQkOyE5eVklxZL0jwbipBWn6ov3W9tF1lS9QI+OYpCxIjEAGq+BYQ8PHVmWsCrieBvcWD2WmfXyCOtSCCFrtWV6mh/MSyNHdtdYFSIdWT8CcZIehnBfIES+Gs2prZA54KtTp6hDyjXgeScrX+k+au7C674Wl0fGv9zXlfwFRFlrCxYsp8NyLFGEvWMoq0oiUEEksvepAquRRqRbE9dNZe8OSCrQ3SKFe2Kx9wmliL0c3cTWHb2iBBZCo94EoerulzNOc3fXwuJ233UQJTdK+hoGgH+eHPlq6HlCkrFMnC8ZR2w7wv+csDHaNrjEegSbJ8JAJ/9dzyxW1yYYcyaAqkx2qCymMUUnEQtbXCtmmwsfmErxTCIUonQMAA/nKcRyb5gHwtSUJ+kkLv+85zTSBC4+aNZG1tVav6tlchHdoOa6NoY7PLok+c/oWLgWfwMGqDCvL6kgsjOc6lv8l0H2UuTTjHC4RQwIRK450c6sbdctWJecHJnr7DhsDK1p5Fw6LZETyJU8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199015)(5660300002)(7416002)(316002)(6512007)(66946007)(36756003)(1076003)(2616005)(66556008)(8936002)(41300700001)(66476007)(186003)(8676002)(4326008)(38100700002)(82950400001)(82960400001)(2906002)(83380400001)(86362001)(6506007)(6486002)(6666004)(107886003)(52116002)(10290500003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iqo6ZFVO5lq4H4quRGG2IZg69YXClHw/761HZ2YYWgl5Gk7ihrqkE4XBJ6/E?=
 =?us-ascii?Q?qfrzUZVWV1oKh3j/yeQ3j3wfy1F68XNGFAnjg9eWulobPnlhvnzNK+LU3Q2w?=
 =?us-ascii?Q?s4njIuLnHv0Kp/IWIBJ6jbBrYeFPvjyhjqirCFyyDvOtL7r4cqUs3+pqjCbb?=
 =?us-ascii?Q?ccgdEKoWHlXU5tldC73Lg71W4XOnK4u6yjhhoKb5CNZSKCEn0m+OGJjIN3WN?=
 =?us-ascii?Q?L4rE1Ee2cUpJg3haGNsTlpNOTIb666KkHNXlh50TUAKpIAfm9autyZ2A6wdY?=
 =?us-ascii?Q?By01cPqA0KxdYgHvEo7ageXUJ6E5ezPZ+dJYaNzCs4zrvpZ0tCOGTsiDMgSr?=
 =?us-ascii?Q?Tj9icowgvRNhPvX7gARd3iAAkmGx3Durk+QM96Ovl5fBWYCoaQiwGwDszpNK?=
 =?us-ascii?Q?D3NM86CUrabacIqiCbjsa5g6AakEJyNpiWoMlzlG/XtnKCTxSgS898OG4R21?=
 =?us-ascii?Q?tjbHS5PkHDOKSl5xoLXIunNTSgexn9o94GbeVlR2yC8ehgsMp3lsOV+72d3X?=
 =?us-ascii?Q?AiLOWFIMLDuG8RdFWoMhyddJldxRlONHM9UpxRCfJakMzZ4kenIr0w8WE+9B?=
 =?us-ascii?Q?K4RhhzYfr2Yp9q/YETejhyC74mJ2WdHUGhXbYAX907L1oMdYzQdufoK9y4k7?=
 =?us-ascii?Q?3T38Q2cp+Ug/Rqcue4vJwNJsFfcSjoE4QOfsIbahXVPCgWQSI/waAApV9sFk?=
 =?us-ascii?Q?t+zBrQvZOGmEi2ogwuHL7lqY+FpqhRrUipbQKTZ1V+RnOa5eoM2S//00QPYc?=
 =?us-ascii?Q?uMKjZ2Da+hBEOyuJYZqIiTKtu+EcKmkKbI7MhjPMxPKJEDBe06c9yioA9CUr?=
 =?us-ascii?Q?iLdnoq++vEMIsb2gnhoJlD56QpK5iTD5gcY829lqnM5AEm1TKaO1T+yOxwWY?=
 =?us-ascii?Q?zjm6EgXA5yYOzuxziZW8AIBcqgrKWbz0PXEudfEMtta6BLZafVcfapPMcAK0?=
 =?us-ascii?Q?JtcVcsQQIiUi79vzuy3qAZW4Sd7qE5CZvLPO4NWcnnpvqz/ekBrOvqDvA1di?=
 =?us-ascii?Q?BYpwkjzHe2pkX6HBHCkmfPcLWgops2zT5a9vYK6MBY+7a27dGvwQeke04KyW?=
 =?us-ascii?Q?q1uuuWv6lCr9ITcLdpq+NN6vNI/uoG6RZMrm0zRQtm5wgAjPld+FbRarbEJ5?=
 =?us-ascii?Q?FWhA8az3S797T3TjGAs1iPDgDbEtNXl5J/OdWcsmE2fu3EGRQqTh6Najgdiq?=
 =?us-ascii?Q?b38TvIN+/4WEmWwe2Uuj/QDH0/g5uZp3mQqsv75e57SrUWxt6Xgr2DSn+vSz?=
 =?us-ascii?Q?KWhLAlGlws2TSfxUmHVxFlNypYdGP+wZSedeH6AaX8aYnVCV3nJVMRC+viyc?=
 =?us-ascii?Q?SK3co/EFi81Un34umaKcZCSpvWj2DPTDYJwYXpjiujSEc3SxfjSycJR5P2nK?=
 =?us-ascii?Q?WJc619KKjiBFZKn5JBCfnvWIZEPKl4fVn7DBxpmhb4uFIiXn9bOvEjn4HYRf?=
 =?us-ascii?Q?0JZQIsAim8TXFDYhkK7zcmCpiif3E8klpezI3yrVztzynu0BhNsTVk9MwR4l?=
 =?us-ascii?Q?/fqtLpVKk6OV8OZqVU42C198v1gfIgqam7r+5jCqoCVV/bmsiIX696Aat9J2?=
 =?us-ascii?Q?2Be5lDPser6Lx14GjYQ45U1Q+mrkz9CAmRjG4L7sfkaV7sv57KM62ldw/yxO?=
 =?us-ascii?Q?rPev2UBYEnYLmop9+kB7cnf6Ue0SX+tL/maaaFpbNe/U?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a3e645-e7d6-4b37-0885-08dad0dff652
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 01:29:16.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlRyUQsqNrnUwjIpL3vo5CZRgN/IvadvItpZAFH+cfCZTDEGKmkj5SGkUQtapV/DN/BPfMo4FW09P6qZe/AU3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3153
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

sme_postprocess_startup() marks the __start_bss_decrypted pages shared
for AMD SME only, so here set_memory_encrypted() should be called for AMD
SME only, i.e. don't call the set_memory_encrypted() for TDX, otherwise the
error "failed to free unused decrypted pages" appears in 'dmesg'.

Fixes: b3f0907c71e0 ("x86/mm: Add .bss..decrypted section to hold shared variables")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/mm/mem_encrypt_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 9c4d8dbcb129..fd9b58402a22 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -516,7 +516,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
 	 * The unused memory range was mapped decrypted, change the encryption
 	 * attribute from decrypted to encrypted before freeing it.
 	 */
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+	if (sme_me_mask && cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
 		r = set_memory_encrypted(vaddr, npages);
 		if (r) {
 			pr_warn("failed to free unused decrypted pages\n");
-- 
2.25.1

