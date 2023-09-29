Return-Path: <linux-hyperv+bounces-350-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CBC7B39F2
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 20:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CBC002825C0
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF9C6666A;
	Fri, 29 Sep 2023 18:20:39 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE066696
	for <linux-hyperv@vger.kernel.org>; Fri, 29 Sep 2023 18:20:37 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020024.outbound.protection.outlook.com [52.101.61.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E5ACC3;
	Fri, 29 Sep 2023 11:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAGjqT3Ozmmt6vSY7yDcVwTha/Lzk2AhilX3LBzyXhSNcvvQHKLL9iNkK0ooQK4MQ7JpubCbuhxG2HX+cV2qE+H4JRwxIzov6+LpHn0TP2IpI6Iggn4jnzLyE9XC0PxpTJKW2NVK47hiWtFm4IrmBqkA0iG21TisyexNBOwfMLxBHCR+NVipzr7daBF1Nzlzb4vDSNZLt/lVVoJvwnvkIQogB09L1Q+u0JMIAjCxkFbtz3iA/XWhs+9OU8oOiGxIdsLyGn7nf5uUJHyxpJPeEdHZQmj/LlSYmfxNUV6/f3n4Po9172DMaOMMe2EtdRK7rrJQS63UD9hri8nWYyoftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeFN+QNlagWKMaSa+qE3Sg3dic416Re6XcWZ6LzPDZk=;
 b=IzJs1UF6ah7EiIz1ygpyLgqaA7f6HKV3hcX+L7ru2FUULXgMngcTRzjEI9SjIMyDEugWWlaK8uRE/5RGfK1sm+xQpT2/qaPkXnk8iHXo7eKzldJtkuRcUoBarZhskI4Akg5g2KZaJnVYn6STpHBK730lIVgDfIlf3oF2obkvNwVGnyKD9zTVEF8W7cod0AbfAmWR8YO8UdEUBkwNZDaoUy9FdtOyugfGi856LyLkwUqxGWHMFsQwFX6hEE7vgxIC2F2RnsaS+mJHsypX7fjq5+liHI2uEtM/XagY5rgsIl9/vbzOgQ+f5GcjVfH4A5KKoF3YS2ArbZnQcawzIOYmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeFN+QNlagWKMaSa+qE3Sg3dic416Re6XcWZ6LzPDZk=;
 b=OFc6iOCU9F+p4Is4J8DAir91LYmiw0rdj7eQ5+wMo6X9UPvjGQ9nhwgEP/KMHZAnQPe7V06YxmpisKsmZ3NxY5Dx84nsUAtktW53LFpwiT/4XN6FJfHCY8VUi0tuONb0uvCx+qvVCDzVjWPesXpuPLjwqkigB07IZrAP9O5Drik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by BL1PR21MB3377.namprd21.prod.outlook.com (2603:10b6:208:39d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.14; Fri, 29 Sep
 2023 18:20:27 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::eff:aea7:be24:8e44]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::eff:aea7:be24:8e44%4]) with mapi id 15.20.6863.013; Fri, 29 Sep 2023
 18:20:27 +0000
From: Michael Kelley <mikelley@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	thomas.lendacky@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	kirill.shutemov@linux.intel.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	x86@kernel.org
Cc: mikelley@microsoft.com
Subject: [PATCH 4/5] x86/mm: Remove unnecessary call layer for __set_memory_enc_pgtable()
Date: Fri, 29 Sep 2023 11:19:08 -0700
Message-Id: <1696011549-28036-5-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1696011549-28036-1-git-send-email-mikelley@microsoft.com>
References: <1696011549-28036-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR22CA0048.namprd22.prod.outlook.com
 (2603:10b6:930:1d::29) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|BL1PR21MB3377:EE_
X-MS-Office365-Filtering-Correlation-Id: b16e7fb7-e488-44ff-aa01-08dbc118c17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lpVnEyVCiijcXgQH3eheIwB+KSwNNfKoI9toOQNPu219GQVQ1hCvU5LHfHd0g2Y8c3ECRnnD6A917PvbeqH2OS802wsbyLffqs//FRq2hRpR0rI5A+7mi1jIZzOkUxmjRuG74VRr/UUTv3xlE0T7JvIeBVfS4U1EpOJmJDARE4wtA/WmDAa5ssU+82zw8tgBVP8CIPCyGD98NFyR7dBwoyEsRGXcrYUKpc06laXTkbi9DEubMifznH9uJNG/r8VfIxcDZR5C6i+ckRkdtFsjlfxuQHYBwsSYghSnMp1OX2Gn5nhB0E0P4F5ONDdQBZbpJuLzPOUcV0L4nMTACrx3NR3IzrEjwL1JuW4iG8ujNbwjWQMxmVBjzZE3qA750nAM6FyTUcW5hnnbcsZQrgibHPrF7hRLwytPf4shmcv6bz6RYttzWE+Uz3tgkMTj8BMOIKUZflUC6ff8HvcvrYe3LJITYK3k/bsW+fBw1RbZXJ4Ok2nCzmCC7/43bp08Wfr7OcrvGN88MvWvcLZmuzzKuMS/fnx2UtmSLm5yq30fd7t6x3NBH7T4VUeobr2uBl0krgA2UK9zngzwJGkZi0yBqlmc1+oiwkOBHbPzQY9m+SIQAtAqOhikkLxlKIA1+9NHxf13mSAHvEJysEBZsgwn/ca8cruaNuChbWD2HR17sxWcfYFDWZ49UHiRCRYwu4lu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(41300700001)(6506007)(6512007)(6486002)(52116002)(478600001)(6666004)(2616005)(2906002)(316002)(66946007)(66556008)(66476007)(5660300002)(107886003)(10290500003)(8676002)(8936002)(4326008)(26005)(7416002)(921005)(82950400001)(82960400001)(36756003)(86362001)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pLh2uEltUgp1h2RXnn3mh54TFzf1WLcCJbs2hq7q5NJ5IvTOD16pq6rskisv?=
 =?us-ascii?Q?fFMs0W96joL2ZMVKV4dIwx+aFG1nmEjh1yOahTWij7gBLSntlfJbqPJIVxDJ?=
 =?us-ascii?Q?1uT9qUnkw7J7/onVykIK2K0cjy36lbAbqn//FwS9DGETgHDL2pAb8eYXBooK?=
 =?us-ascii?Q?CoI4HE65iuFbMGJXdq6l/YBbzt3CKqUvvcWzIETmrotIwrhqUo9AXq1cLTZE?=
 =?us-ascii?Q?wwEyXQa6KLBIqEKPVx0xTtOFrokCG2jO+4iJ5jFPqXqlEVBCca5aOw3JYgCI?=
 =?us-ascii?Q?isjotxXAgpfgENO/MPbnIio5qqtJj0HARTgW2gMWKTFP2MPXymcfe9PZFPye?=
 =?us-ascii?Q?l4Bx6sFDQgoZ8MK5T60/eKrbZXcMpgqCAYJK/bHECjEoecSdZ/gmlmp4wPzY?=
 =?us-ascii?Q?IdYLViIjya/4veFbPhCZ7WBMHxaSqzwHWa3RKbpYZJkI8a4L07Auhe/Kkb1I?=
 =?us-ascii?Q?Q2Jv6dNTKS3DgxH/1MSaEgtwwRJN+1LPbAFI0bImA5RPgmDnE2ZxN8PDBeto?=
 =?us-ascii?Q?MnmwCroLAN3rT080kt01kaXEqBTEnbp/2qF+QyLBEQlBp0Kyfus7zFPHvya0?=
 =?us-ascii?Q?5bqgaHA3YNTBYUvd5YSe3fzm+mTFrYSD3ymmgzKhX2rxZM6qhiXNG925Oi2B?=
 =?us-ascii?Q?788vAEIPeiJLnSKPLokbbc4/qxxo6/xC1D3/ApOfkoTgpx73Fl7CZvlUkpte?=
 =?us-ascii?Q?SGHAdcQasuSIHotdXP+V0/N6069N9TJH8sEabH82EUTdIKGmwrAP3bdy5CY6?=
 =?us-ascii?Q?JL8o5b8QgUPurEpCTRlpkaE/8cG6RdrH1JqTLThkyc9Ii+XArm0HFdOnoWzS?=
 =?us-ascii?Q?t0jSmxf2PhXW9YK4VnUSE2GlEKwfxghqhi0RxdDBiXqD+/9FhR+eso6YluqP?=
 =?us-ascii?Q?dneLbc1HPB3sf+9aFbiWKalYX5FcDgAMC7G49LRAp5LtR7Bu4wDhPWMe2YcG?=
 =?us-ascii?Q?opV9nI0N5/OSj0SgxNIrqyvQecxLA3Uv0qdRFk5DdzktWloOARQqMZXGCor8?=
 =?us-ascii?Q?5K79N1hS9914J0AHkIKPsZQimABqPXfyGTTgSh4prqGsRyothxYnRF7HGIqk?=
 =?us-ascii?Q?kiYaJM6LuJStoH2RDUXsETTSMF/fLQkRWviTiZLh5eSSHlPkP5mTMozNsNcK?=
 =?us-ascii?Q?bsSHwgmKXgGCZ/cxQRwF5OkjPtGt9IieK47KJ+4GVEj+CRwxCLK9Wh4O9lZI?=
 =?us-ascii?Q?TuyqKUfqhaaWwp5FxDyRw2I5PHBtLTLzxWYQqcAfjGe4Y8wtt6IKx6hW7f8/?=
 =?us-ascii?Q?oDPoej6L+LLxsGJ+c4G81LAXHq+ILmoCPPX85slisQYi1gKaNoBsQJu8teoK?=
 =?us-ascii?Q?Ns1GjDjekadW40StdzkkgLF2uzoXDju9lV+diHtlqpmpKhYYjBwJFO2kMoX7?=
 =?us-ascii?Q?avC2KZrHnhN+k7M72qvFJp+36W+j15hiA+pR/qjr3Bs2PzIASGCKokHQwxUY?=
 =?us-ascii?Q?1pjc+7xY4b9Vk42E6eog567tttUoxHUNsK5ngzBwlzlvOWpUIm9/JVi3Ofua?=
 =?us-ascii?Q?D1xhKSXq+gcCgMjeAbdlLIvrhRyEnUgqDtAF5FJ5HL/amNkl7tvG30K845D3?=
 =?us-ascii?Q?LyoSvTBk0Mf7UlVU0jxQzZATZst+nytXxwWfYD7L2WiuaWsJVCD19lkyaX8g?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16e7fb7-e488-44ff-aa01-08dbc118c17a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:20:27.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcqvv4zoHftCUIJI9DfOX041xgoRkWQdQqVY/4lAJbLg0GXkLm153GCFiF9IX+beama4px2r3udwgMZj8m9/gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3377
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

__set_memory_enc_pgtable() is only called from __set_memory_enc_dec()
after doing a simple validation check. Prior to commit 812b0597fb40,
__set_memory_enc_dec() did more complex checking, but now the code
can be simplified by collapsing the two functions.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/mm/pat/set_memory.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d062e01..1578077 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2131,15 +2131,18 @@ int set_memory_global(unsigned long addr, int numpages)
 }
 
 /*
- * __set_memory_enc_pgtable() is used for the hypervisors that get
+ * __set_memory_enc_dec() is used for the hypervisors that get
  * informed about "encryption" status via page tables.
  */
-static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
+static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
 	pgprot_t empty = __pgprot(0);
 	struct cpa_data cpa;
 	int ret;
 
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		return 0;
+
 	/* Should not be working on unaligned addresses */
 	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
 		addr &= PAGE_MASK;
@@ -2200,14 +2203,6 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	return set_memory_p(&addr, numpages);
 }
 
-static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
-{
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		return __set_memory_enc_pgtable(addr, numpages, enc);
-
-	return 0;
-}
-
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
 	return __set_memory_enc_dec(addr, numpages, true);
-- 
1.8.3.1


