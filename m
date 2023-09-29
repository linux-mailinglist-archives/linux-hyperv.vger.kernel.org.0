Return-Path: <linux-hyperv+bounces-351-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44B7B39F3
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 20:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CAC401C208B5
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 18:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C70766696;
	Fri, 29 Sep 2023 18:20:40 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA5E66698
	for <linux-hyperv@vger.kernel.org>; Fri, 29 Sep 2023 18:20:39 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020024.outbound.protection.outlook.com [52.101.61.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88F0CCB;
	Fri, 29 Sep 2023 11:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dktBECflJjI0n1It5HpQTRIxR8cRKevUr0b1GQNjVBUx7dVihE24Vhn1nO3fE14ZWLYesYs+tUmydkQgl4ZPdyzqPxIOh3h4Xjv52r6eYtbqi4R74K5dBj32Y72EwhujWzZpLw4jus40hWdZwWCav1VEX8eIW7tZC202XBE0iWKRkZXkWor1zM44AFfspBUJYHagREXYhmZyiU7HhI/MiLcTT4NVhcLeS21ZfMh5CHZAfkrVtjDoCbf9D+mfv2rXIONV33/XWHWpnuUViJZVclSyyXLHv3XTrik7Qgtv7wcpBsMIOjgfxY8M/Ljwx9Ko4hrw/2occD8Zo+rTzug/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJjRfPFE1u59tUllCuAU5kVEjftyeGOfDutmuE8RjRg=;
 b=DcjK9mCr1mXtMcmUiz/wDj8xDdLB9WF7SU9nHJ0ydphq+0EPsg5ElmliiEwj5TBoOkcj5Wzb4qxcvi+WLNlaGuHn3hkVKBbzMqnKhdRj+u8EuontcBZi35P/Ml8WIFbsPGPdsXb6hsIPJJ+k6j+23lTAdsjuGUHBUQiZQSfGQhEM+xObw0fYtS2lJquFpKe1YdJZh/JsYjoovYJ2iRKO3NytxHWAX6gMi6AVLC1NbSfeJYl3YBzeoOMKEACne8dBmPCfBe2X5PKiqvUwTHlicuZRoDqryWU20Fx3/iu+Ny1vWZXeyzT7h+5WbaAwqpr6+cGEGMuhlWMUFJagmNxGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJjRfPFE1u59tUllCuAU5kVEjftyeGOfDutmuE8RjRg=;
 b=h9DV1JHl33wwz6I/5XBsMU/sTFM3AvQrYHjJsX2nFPB9HKnCcBiNG7ThOErsNFRmqoSlfXYRuqAL4Y0JeUJAwfqKA85vybUePTv8IftFFXNMcA5bfQVS1qZCacgVt15lAcOL5X25XE1ShxRYuKpgn+quvSDH1Xwwi3MWEzWqH2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by BL1PR21MB3377.namprd21.prod.outlook.com (2603:10b6:208:39d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.14; Fri, 29 Sep
 2023 18:20:30 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::eff:aea7:be24:8e44]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::eff:aea7:be24:8e44%4]) with mapi id 15.20.6863.013; Fri, 29 Sep 2023
 18:20:28 +0000
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
Subject: [PATCH 5/5] x86/mm: Add comments about errors in set_memory_decrypted()/encrypted()
Date: Fri, 29 Sep 2023 11:19:09 -0700
Message-Id: <1696011549-28036-6-git-send-email-mikelley@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5adb1059-6f53-4d32-53a3-08dbc118c226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ouGYYtscQdmWdHNkVkNIdZFc7CsuapPc+oOvplRgkTiM47ucJ4BG1lCNWQeEALEDGP339wnlcaapIhcfdJOc0QUZ+17S2kqkx5ArlVikCEbqCgMx1goKg9EVp9yZYQ9+keTbemtx0h02euq2M8VWHF9cu/i12GgufKk2zDKTPjR0OK38HipvQUEhIK5mt/9Vkj5ht9Hf0ufUj9RdDmaERHllp/t9e+OylUm70vNQGLZ+eF1Vm+SlmeyERupaYsXEARB7O5QbMB+1W/MUPAv7zojPPbIiZscycEZDY21+TduDD56gHF74mxYLdFhT1OU4oyWNa65Mu4iFXNVVYMwMPMs+MBSjsAuoNzCTO1LK4ZbeR4FdYTyFEpPiEERBy8/NgqTZg9qTVFUtsmowhA5uoBjQBF+KOBzFFmJQw2DAhxneWjBkSbHp51YBKcZcWSahP2fOK7Dr3J9QjTMqcwKjO95Su6ZJAE/s2anGdFSFn2SjRbzQyw8OG9XGYPjP0cEVO90Dtwhfza6P+DbJAZ+qjBFnf51KDWPQsUSXmlMm/9fnGruFcjhN7D2wK9La5tRmuC0Ug5rLsNjZNU/qtAgqyTtQAL3g4wyjE/Q3mpVoEC9vmK4a1+UmSy6aHifde/0asvbGP+BDQnoQblXgJrBS7Gn9Zu5Csp52Cb7PlxQGkjyW5NGrVb6frYo4EjWeOhSE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(41300700001)(6506007)(6512007)(6486002)(52116002)(478600001)(6666004)(2616005)(2906002)(316002)(66946007)(66556008)(66476007)(5660300002)(107886003)(10290500003)(8676002)(8936002)(4326008)(26005)(7416002)(921005)(82950400001)(82960400001)(36756003)(86362001)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KXQiH35tJcQE9Qa2lan00MA3iwOfYBoa2t1AYKjbJuJueU+5CHblXJcqCwGq?=
 =?us-ascii?Q?wrOA5U7rHdZ2Tk+JHggjcBYJkgPBJE0RjoxzBZLWL+5J0R9hUb/EjoxoDJTQ?=
 =?us-ascii?Q?H5qkQEDzhOIDx6EcbPcvB3w32TUxbLx5vEaF7cr9S7NObXmWtq4wscu2azQn?=
 =?us-ascii?Q?/SFN8zunU58YG1z1Mu7TUWOBI2/6tlqKKf6oRSvhGCE0HbwvhAlRLhei4PMO?=
 =?us-ascii?Q?dDEsSEOQM15ITY6XD42d/Ksc8YRsCrD0PzeTLyiO0cCBa145LFf6csNvGcMO?=
 =?us-ascii?Q?G37p3CBPNvvPfRearTnaI8oOoldokgeFLokqVbgbB6sB4MxE5hS128zGLMwI?=
 =?us-ascii?Q?khSIoA9o5+P9sxKRdnTQ6Dm6wrrHSMsZprPd6hYtLiOm+M60nV+uqaUNKQkx?=
 =?us-ascii?Q?IF+pXWvN/NWqiZxcMaRRgR6EHduKVFsaxGEL1CrNgWn68FIudwcN+LyoiaS5?=
 =?us-ascii?Q?EzBuVS6HwhXiLGBgyAyLUtlUTcWagpL5QLN0pc3oBBIJExm16fVP0ZbnjcyQ?=
 =?us-ascii?Q?fB72eJMIA20/v2Ryjuiq1gW5HMCOYgxaU1wJIoO0PC70QhhMmW5btA1VeOHn?=
 =?us-ascii?Q?bBtu35vwVnCYonmCjdI0Hx3FFLycfgHtJysm6ajFebQb45bct2ouQw8IwQI3?=
 =?us-ascii?Q?+9syJuLp9hbTJif8TebQzj+KX8lnqofH2qq0NMMEWjbrRdz9fqeG0p/jzjw1?=
 =?us-ascii?Q?ikMoHdvMjofnKr6e244SVC04/EwgjMuLRgz01nbZzaOJyxoPn1WIBrvT50kl?=
 =?us-ascii?Q?OzKIh7rutc643fpGdcqfWntjIgsCGnmyjpU475lOPovIe+unCg4rpLFuuEG6?=
 =?us-ascii?Q?1uAhrGJTIasiDOSj7dRbS6nSuoXl6S5C8AN/AFjFqX+i1hs9a16U+WwvA0A4?=
 =?us-ascii?Q?qMr5TDIJL1tNrwqTNAc2gFdFsblqdQyBNs2+3J/JmCGDz/r0xIOKq3/yH9lM?=
 =?us-ascii?Q?h3c3VMeJa/e/tSMW2h4qbFiXtbMZyyjQ3bdDx2QDeAgZfFiHvwh/Ek6pFDdA?=
 =?us-ascii?Q?U6kjA8EtRGzGWQXULkionWGWoNBLvfNHzVQN80yBcYzJ4pxXgd4NtfaxXiGh?=
 =?us-ascii?Q?bSWyK+Wva908x9p0pPzYJFQT7sNsA5H0IMzvdz3pQJ28L3h/FjOsgZ+TFdIG?=
 =?us-ascii?Q?BtpZpwiXh5PcbbXrd/vZoUFXYcuUqTEemIgQ0WR9gPXiZ3YG+/37CVdn7Okb?=
 =?us-ascii?Q?QZ56upt2OvtY5TbiLbdDXvtsB8kWoROxrUXrfi/QL8Cz6pWSPDNvrgT3Ranp?=
 =?us-ascii?Q?B58mC/qc3Jl4GmJZh9URs21NPcvsbK8Kw4eyjs9Z3hRoZ2h7Cm47X21qwWzm?=
 =?us-ascii?Q?p+YP+Lu8crkGI1dIzDLS+pJW46KS6gM5V8Xl8/J8zI1mxOD12njkwfY5WZ74?=
 =?us-ascii?Q?HAv/Heq3qM5hOAE+dPc8nNoAU5izgQVcPdTkaFtu/Rx/IwM3R7Yy/QykEuIK?=
 =?us-ascii?Q?yE/ycKKjNLfC6vGNrQDNfmIYdXemWiXQSS5paKm6dsDHcIcoeMsvJIeoQ5tW?=
 =?us-ascii?Q?UNcKc2OaeIIEjLGgveoqy7CbUJBTdxjFeuUZ4qA0LXKUmGRvdisGsFKjQ9bF?=
 =?us-ascii?Q?bWdih3/KrsULXZ4qScasbKB044U/IHSpnKPlG3Yrw6ByO7M54i/nTFkSogcu?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adb1059-6f53-4d32-53a3-08dbc118c226
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:20:28.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuC0/ng7YRMFlSH624x5Zh4tbrDZw54JUc36WXS5nWvZrTSeIOYq68BecXjwtf3CMKRPcpMqy4Ju4b7WlGhsgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3377
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The functions set_memory_decrypted()/encrypted() may leave the input
memory range in an inconsistent state if an error occurs.  Add comments
describing the situation and what callers must be aware of.  Also add
comments in __set_memory_enc_dec() with more details on the issues and
why further investment in error handling is not likely to be useful.

No functional change.

Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/mm/pat/set_memory.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 1578077..9d07d4e 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2133,6 +2133,24 @@ int set_memory_global(unsigned long addr, int numpages)
 /*
  * __set_memory_enc_dec() is used for the hypervisors that get
  * informed about "encryption" status via page tables.
+ *
+ * If an error occurs in making the transition between encrypted and
+ * decrypted, the transitioned memory is left in an indeterminate state.
+ * The encryption status in the guest page tables may not match the
+ * hypervisor's view of the encryption status, making the memory unusable.
+ * If the memory consists of multiple pages, different pages may be in
+ * different indeterminate states.
+ *
+ * It is difficult to recover from errors such that we can ensure
+ * consistency between the page tables and hypervisor view of the encryption
+ * state. It may not be possible to back out of changes, particularly if the
+ * failure occurs in communicating with the hypervisor. Given this limitation,
+ * further work on the error handling is not likely to meaningfully improve
+ * the reliablity or usability of the system.
+ *
+ * Any errors are likely to soon render the VM inoperable, but we return
+ * an error rather than panic'ing so that the caller can decide how best
+ * to shutdown cleanly.
  */
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
@@ -2203,6 +2221,14 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	return set_memory_p(&addr, numpages);
 }
 
+/*
+ * If set_memory_encrypted()/decrypted() returns an error, the input memory
+ * range is left in an indeterminate state.  The encryption status of pages
+ * may be inconsistent, so the memory is unusable.  The caller should not try
+ * to do further operations on the memory, or return it to the free list.
+ * The memory must be leaked, and the caller should take steps to shutdown
+ * the system as cleanly as possible as something is seriously wrong.
+ */
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
 	return __set_memory_enc_dec(addr, numpages, true);
-- 
1.8.3.1


