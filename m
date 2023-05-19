Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221FE7099EA
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 May 2023 16:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjESOef (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 May 2023 10:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjESOed (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 May 2023 10:34:33 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020018.outbound.protection.outlook.com [52.101.56.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19469D;
        Fri, 19 May 2023 07:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6EnuYt1+2wh8cGH+ptqq1OuatRtWtLUXhqIRmP7X1x6O/l9PkcwyEkdv7ltDO/XufkrHY1v6L41J0LajtbkOyjS5mY6MDV3BynxWCmz2udpedLZAtvJK/pM+IkgZ7htKP9Zo1mlt80Q8Loc/5+znTbtQMTXSpN7lX8cflMhxE+0cBGbug5PN9mvqpapg8B5uWsOJ7wp3DcEBipgFNS5djjs2G2myBr1uo8lkiUGDLrkce+sPdGlHAXGwKpsIP+6rkXThTIo768zWZHRMmOiW1BZQgeAuz5av/HU56n1dXxGnXiReddaUkRqJF/ShRQXw2WfUu7xo+JQR61QKowacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVLCXaXFVSydw+sLVl3pn1lZjRPAvTpnNGR1Hbdmeqc=;
 b=OOhmprkkchT0W1wPHmK0zxri/IgEOWPFJoyKuqqJepN97iFbQbBbrwAireMKAmCvfTOPLQc0sE1pEnDinNuf4TGJVUxvwXZazMWAL29vTeizgtmr+nKD9VMHzLrDVwrGKu+fQC/n5ccO3QTIlBseX8i9HfAmqIW7/Ry2oesxJo5xIXckIxPE/JavQ9bb+hCSC+uKlYz+WwgPqHr2nTNQhcBCB7xCpStKK+tQYDAAJ9bxMA6XN6/DMQz+tgeX70eOV5P/93Y8PoR803FkrxCwO9kuxoYlMqmajGewW6p3BrIIiSpJO1a/cUIlRIDPjd9goI93GnE/50X+MLX9Ia3m/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVLCXaXFVSydw+sLVl3pn1lZjRPAvTpnNGR1Hbdmeqc=;
 b=AkvEOUB6CDoGIDMbbA3E8KgQfzytcL+fCcSVwDOFaLGuSUZTX5h6JVmYrpyGxFzlUZ6nPu5siLSqG24Jdjyupn7YOrFbOxNVN1eFuw9tXJVhrvcWbuCGEDOC50QQP2jayPaxPt3wW64DOt63ms8T8lkAXfYAZqQRNY9XsiGcsnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DS7PR21MB3391.namprd21.prod.outlook.com (2603:10b6:8:83::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.7; Fri, 19 May
 2023 14:34:28 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%6]) with mapi id 15.20.6433.007; Fri, 19 May 2023
 14:34:28 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 2/2] arm64/hyperv: Use CPUHP_AP_HYPERV_ONLINE state to fix CPU online sequencing
Date:   Fri, 19 May 2023 07:33:52 -0700
Message-Id: <1684506832-41392-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1684506832-41392-1-git-send-email-mikelley@microsoft.com>
References: <1684506832-41392-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0166.namprd15.prod.outlook.com
 (2603:10b6:930:81::14) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|DS7PR21MB3391:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb9cd1b-956e-40be-bcb1-08db58762700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2SIFUBw6nI7D8qH2XbfJ6ZH5lbXsllcYVZuVsfRvWoBrzHH3Neawkm8gu2/4IXN/kEFjkcRR9iFGTVPsc8hZV32vBcNRizaLWJTfxwU2+YHCjqN0t2vAr95UwOFGw7zNwVganMc7wDGgcfZBJpHTUqUPt8bz0GnLBRwVybtuPEhZtrzjmheKSM5OpV0FOIwVqCrM/D2nOHYws+DMv0nHEgz3HLNIFPCM4AL4/dHr1A57SLOqCyNVBcgr51lwtqdhfRlIR3GilErWBeyZU+JlUn8RdB4dCYpshtaWSXhCNFBGH1I1Ndz0TBdhQ6kgldA5maAhYS1MNBSZP4CHonQtaNRWh7tbcyk8/T7BtJh+O/fkZW+bL71b47wxvYj2RPy2d2c6trXaLQxLHJTnD7yy65+VzqX22LkpOO5FEhPQdbBk6ZIxjE3+9moP+nHDhYYQlk1JEnY2H2Pvv4ERRjNuAZhLLudebJHZC07qVWAVTp655L+2qAzrkd0z/l0eWcWKXscZTgFN/feiKVfV5pkqNOp7Et16x5tlkovuWszaKX4hCuc0hNzP6YDEF8eOyfI4pP4x6Iai45DnzJAiqPnF4Pe5VBd3sfeUi4JRLAlcdXMvWzF01LNidfsS8+HJXVb3TwC1p51ddCZ/HPQb3pwVhxUHX96ZoHMg1Fav3Ze8J6Ti1l+S6QHW3jdIHuxTdkf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(4744005)(2616005)(6506007)(2906002)(66476007)(6512007)(8936002)(7416002)(8676002)(83380400001)(107886003)(6666004)(26005)(186003)(41300700001)(5660300002)(66946007)(66556008)(316002)(786003)(4326008)(52116002)(6486002)(921005)(82960400001)(82950400001)(86362001)(38100700002)(478600001)(10290500003)(38350700002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IqvNu5PeLNbTFabk57k3lAS5nU05hYW2LZvwW2KIU7VB5U2r/xaDiAdCpUHE?=
 =?us-ascii?Q?PT5tDpuzUBeRocmt2l1rudlDMelaDT/DoURwcNBJ+fBC//pK/1zfpXHepyn4?=
 =?us-ascii?Q?/5JZuhoBU8G7nCqUmuBGMxB1Q9UwpHb5RVGdKOng/libfGJWlUmmYIAVUBv7?=
 =?us-ascii?Q?CKV5RT/6GLRdrQ+YYufDilLlYV3//pOOQVp+neB606Bsa15ry9UkSkuya3y9?=
 =?us-ascii?Q?x9cQWTpXWYILjCzIvL8dUiIbRRR0VKg3rVLcHLsb2WNAVLPRLf2zfZmJWJ1+?=
 =?us-ascii?Q?Rzo3mNhPTe15jXXXVmi7BxXvHpYxeFZLDYuffUxu4F+zNdu88ydt+Z2+r7+e?=
 =?us-ascii?Q?MCIokN0PnlE8Mnh1Ok91+AjESlqQmWFsZLFIul/1MOvTLPZMuXLpOrI1fRI2?=
 =?us-ascii?Q?OqVx0ZUpBt8LiJSVUsNU862cxfGyh+HRbXkYZbEsrxS3t+7ebHuny/uInt82?=
 =?us-ascii?Q?wnUDVHLoFMPRPZgunI62qYMNH5/h+uZw8NMa5bfhsZ7F5H7YiHibYiCZbfNX?=
 =?us-ascii?Q?YQ+bpTqfF4PZM94MuK4GNOlFTWYMCLBklws6vvvy61oE1u1Q7ja4mHv4kVIF?=
 =?us-ascii?Q?9VCdCxSZQQxo33nz9qBJTNlovMDyQYnwHOJqQH3Go2kY9MlokWBVCfIljqkc?=
 =?us-ascii?Q?aBCcg0Mu47K7EnK7ZqEuIKudbYrkdm1ZVmDff5SJwdQfxm5iuMbT+XxIQF2X?=
 =?us-ascii?Q?kx56ux4lgkU9lU33mP9LHd9N2oNd1xAtR9zMnf8izD1VkHzhywRn0uMuwHMS?=
 =?us-ascii?Q?e1KJrxkCGcZObFafRagq/MrSSHfAwQlXU2dVS34dJPDlaeHusV3O0QkoeDzn?=
 =?us-ascii?Q?NANPDmDH9e3a6Dc7DFweYDi9RrN2x3kvungsd6I7/sUTkJhHVE+hVIvLskii?=
 =?us-ascii?Q?B1KYBxIYAjmyjOKc173fmWnr6mWE1zFkqrHwdfsFF3/EBXvCIuaUQa6ELOtT?=
 =?us-ascii?Q?2rOLJlcf+zfu4NplxP2utIaU96n2y4Z4onPBe69DiB2mECog31L6+vNICIKm?=
 =?us-ascii?Q?F1frMTFTPXzoYmLNAvoN54qKD9Ks62zbiTtjDtHgONA38c5lhSD/hHkZofdB?=
 =?us-ascii?Q?r7AAWiaO7Kz1JMCCMCVCqrpttvfENjeqSCXexaE1sm6ihjCTqpxA08HFh4Np?=
 =?us-ascii?Q?m9GOHBTiK9+XZkYq1HHNXYN/qy5iYyW6/l51KOsBuUEeQq3F02j6xqnCLqDe?=
 =?us-ascii?Q?Krep+zLRwvGcvujWbJgyJqrLtwG/xZhYgZvXichYWE5Z9bCWkE1OKAN/s+PA?=
 =?us-ascii?Q?Icz7ZkP25VSiB7D+llai2ZbXOdH6arqvrftF22yNf7LiD4RPX9ADsLCXLjJs?=
 =?us-ascii?Q?5BIUR9nrBH5XCRriyHNacZ7BgcVSpUTjFrQaJU/bvz6PLKJ8H3HDdr6wEpDX?=
 =?us-ascii?Q?VNiHOGG5r3CB+UjuJH7I6XKcFMOhxx937MxcF8pTkpMRx2dxCXO1DCZ/SD1O?=
 =?us-ascii?Q?vZWLTXGbqx/iMcOdzeMZTwEC564hVUKU5joWfGBmpZMiN4U/p4Onek3wnqOI?=
 =?us-ascii?Q?03Cu6EsOG5xr1psPMCdZdGP3JMlNMWcW07XSIl+6O48rBg/WORImH5zGofJJ?=
 =?us-ascii?Q?wgM3ubcmo/eHmI1i+8XtoTRgjQyeaeFGdUhz5k5+?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb9cd1b-956e-40be-bcb1-08db58762700
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 14:34:28.8292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnWXTGuzQlc5THoeOnsUP3h2SMScKCuSEcZTXzZwis2QiJQ90MdqLM+/1SHty2SaMYeooNr9dM7zArOApG+9cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

State CPUHP_AP_HYPERV_ONLINE has been introduced to correctly sequence
the initialization of hyperv_pcpu_input_arg. Use this use new state
for Hyper-V initialization so that hyperv_pcpu_input_arg is allocated
early enough.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index a406454..f1b8a04 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -67,7 +67,7 @@ static int __init hyperv_init(void)
 	if (ret)
 		return ret;
 
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/hyperv_init:online",
+	ret = cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "arm64/hyperv_init:online",
 				hv_common_cpu_init, hv_common_cpu_die);
 	if (ret < 0) {
 		hv_common_free();
-- 
1.8.3.1

