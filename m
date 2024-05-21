Return-Path: <linux-hyperv+bounces-2205-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE8D8CA611
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 May 2024 04:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C97C1F21C39
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 May 2024 02:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0083C15B;
	Tue, 21 May 2024 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EYbiWrqf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3336D51D;
	Tue, 21 May 2024 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716257602; cv=fail; b=AP2MvNsYGwXfyLnQCAPeh7kuYPlEoo8gGoszMrwqXKNEWyffXXVQgOcRpuUNd9yvavmT52w2UigNwLZxpsTp6hgJSrvdYqX+7N70niARTXCopbfTql0+FZ87X9WKWLrPDp9zAj/RH671VnZh4dndznrGV4ssEm9BuMr/nmqjonw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716257602; c=relaxed/simple;
	bh=uSlQBDrHTlw3N42DFNwtTZmTye9XNXE2fd7Vv53V8qk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rUi9fHYiD7FJPfwM4lrjAqlzFhLWIbKOZwKI0zjQrDN2HWMafMXmt69pvpm6bLERBbr7c6E4T8q78ueXAa1aF9TkAmBYeVXutFXdgX255kq5Z1r3rx/LmirHvYZLxoj2i9DlCeelyqC8o3q3/8Mu0oQsln9YvJifih5A6oSxjV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=EYbiWrqf; arc=fail smtp.client-ip=52.101.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBRHf4q+rzWF9X4v8o35js1IJxfR2LIjCrYZGAYa0TfXcq1cjnid4qZ2lVUV8FZeklXruuXQmdQRgdRAHTSHb7GLiWpb+YSZoRXDlhw/dZYBaQ3U9rGm2Pe+BtDBsPkSHUHqu28B22N2/ZBM2XFEzJFa61xsyaRdM1u/dLWSC/3KJj+Mqm75j/SIudQkNqNn/7MLopJI+f0uEMANlS36iUND1uWMrMf9qcMQG6qe0yZlwM+ZnTPYB/AAWN+Ti3U8EW5ALKRjrmgInluOuk3mfGt8ABfAdpD/fLe9FPlM+pDZUQOjWievR9ng6sUJYnXyY6/GK+tmjiygo+jRgLBxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBUTd9CdcHN6fDYgNQw4R53ZbNCowUioiGsfsLqaeKI=;
 b=bMGUrbSnfPgx/dNa8roZ+WcqOr9JRVHz8SCXmIa++BsaU8Yd5kziKVs26KzZNuAwGQSCvdQqqAZSxUC1DTG1zn1TFLK3qb4NMATtlBd3tIAxZ8PTeuGOs0kEVb0+MdwlVf21GAT5ZUtuDCoVuSa+K9uzV5dVFbTULqrXNC1hi/F3/StNdke2XtpYYKTHc32qAgmqClC2Pf5jFF4NGPhZam1cxPeo4LssbXuid/X3EUCwEohtyC5bf+0AA8FjoIMIPBpXZg6JkgMKzhTioZFYef9zXE7e/SFJuuF8nFmhq1RJFRz64lNAZNfFILuJ9k0qYfE5457TMBf7+ayMAz63Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBUTd9CdcHN6fDYgNQw4R53ZbNCowUioiGsfsLqaeKI=;
 b=EYbiWrqfqeTV4w+LwJRXdqNdmVlyjM/xuPgRXdeIFeiKsVitr4nIHukabRlSmT471o1ew8/bfPlPHdUYF01rOnvKtltkFNuzkLysvNAMzITLHC4UC17Mzt0sa3hoi36/tYNEMZ21720ZIbWFfJxs6unTvT4vdG8aRhdUpKSiquA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SA3PR21MB3915.namprd21.prod.outlook.com (2603:10b6:806:300::22)
 by MWHPR21MB4429.namprd21.prod.outlook.com (2603:10b6:303:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.2; Tue, 21 May
 2024 02:13:16 +0000
Received: from SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::47c8:8c49:be38:ed21]) by SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::47c8:8c49:be38:ed21%3]) with mapi id 15.20.7544.029; Tue, 21 May 2024
 02:13:16 +0000
From: Dexuan Cui <decui@microsoft.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	ak@linux.intel.com,
	arnd@arndb.de,
	bp@alien8.de,
	brijesh.singh@amd.com,
	dan.j.williams@intel.com,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	jane.chu@oracle.com,
	kirill.shutemov@linux.intel.com,
	kys@microsoft.com,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	seanjc@google.com,
	tglx@linutronix.de,
	tony.luck@intel.com,
	wei.liu@kernel.org,
	Jason@zx2c4.com,
	nik.borisov@suse.com,
	mhklinux@outlook.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tianyu.Lan@microsoft.com,
	rick.p.edgecombe@intel.com,
	andavis@redhat.com,
	mheslin@redhat.com,
	vkuznets@redhat.com,
	xiaoyao.li@intel.com,
	Dexuan Cui <decui@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Date: Mon, 20 May 2024 19:12:38 -0700
Message-Id: <20240521021238.1803-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CYZPR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:930:8f::20) To SA3PR21MB3915.namprd21.prod.outlook.com
 (2603:10b6:806:300::22)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR21MB3915:EE_|MWHPR21MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ffacd0-1034-4052-85fe-08dc793b92a8
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|7416005|366007|52116005|1800799015|376005|921011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?iMl6jadRFBDbmdxnaDDVxVwgNXwB3gVKZWKspCpE6C6d3Xdh0N9DYnr39akJ?=
 =?us-ascii?Q?W7qW5swzkaX8+xLhHNvD16TbTAVylwSgivsTeG/OztlVIuH1IIURv+Frs0RD?=
 =?us-ascii?Q?16ocJMYO7WD0o5cbaEq6j+2djDYxr6M/C5XWijUpKhX0h3IjxE93xHdOb5Dk?=
 =?us-ascii?Q?rKapcT5u7K0ECSTWbParN4KKIEUu6UTwc/AVBao+sgtUczVvQfJ/lb2owzWC?=
 =?us-ascii?Q?i9ZflVG+/bb7MGR+j0tMMsdo2UkAjMtZjP1klrUkHiVuHAkvTzlKiXH/uYXh?=
 =?us-ascii?Q?6P4XsdJ8G3ilY0lA+IuCiD3YkQybTmegxoKOGFNx0Of3gYu9kfau0/NwWdoz?=
 =?us-ascii?Q?ZQbYqLNayiwXuwsYt+yW9V0EWx5aAXg8tVWH0qSS/lRKD60YccjBzS9KHATe?=
 =?us-ascii?Q?XSwFgKJ3p8bE39d8ZPJTm7A8b8TcFCw/HSQS05+qDrRrkHZqdoTyBBEGzzGa?=
 =?us-ascii?Q?kZXTKBHfVrWt1j8nNk6HDXvl57/7Ym2oERsYd7a4ypeRgqMTdLeVUX8sb5lp?=
 =?us-ascii?Q?4NCitrmZnh+LS99IiICBtOW26E5qdG3K2pctACgvkliuqJB/yscF4hTJ7jUt?=
 =?us-ascii?Q?Iiw1pjf/ACS1t8tlrH+Fh3+cw2yU3EGvGZJ2QkkYfLQ490XHnb0rXoG4ih7G?=
 =?us-ascii?Q?UstelY8PgjUCuwGQVZrV0ZKtC/VEDdMO4nRuuqaxQDIpskh7Ew5oG8VbGskH?=
 =?us-ascii?Q?1MmReSMzU24b+vbIECF16dr633UEGmk0T3/zGEjTrK3bL4XveLBC9ez4sQn4?=
 =?us-ascii?Q?S1uJ+4Wjj3oillpZJ2IGeSLmmO+HFTlRq5a7Y+iuvabGpBGHUayXu5JkuoIl?=
 =?us-ascii?Q?rNmDnfvTuTdwj9QPC5wwAgOXtp0UWffqtlQxlw7yOJin0Iy3f9um/3y//1VH?=
 =?us-ascii?Q?8LEHWNFH8f8MVg6LJqCs37H/BXWd17pg4S/JvbT8BafmHecL52/+x/OZStFs?=
 =?us-ascii?Q?w3OLKrKpQ4Itx9tZuG3LgRcsokFBVWnZnZEFBCRL431LYKF8g7MIbDNI1ZOl?=
 =?us-ascii?Q?V6TK5fqTBoc/ohtIVuJ4r68F55VPkEGBHFeVFcpG5AFOZDJBlU+32qGClqlZ?=
 =?us-ascii?Q?3TwxD2beu8ZZ9Gc9mJ18H3rV0pa0tF7SsF0/AoOj3/mOwr7bxKFJL8nTKMvH?=
 =?us-ascii?Q?MAeCk4/eaHExxrFoTkzp2CdIhBGdz5nvH40UskLI41NKAb4bqZRX3l0EIqWQ?=
 =?us-ascii?Q?vJT3DITvhRtmlJnP6usK4uk9EqCfP6FIAxg4L9bl/Di0iMdSPGcINIdeUw/1?=
 =?us-ascii?Q?lGcHwJiigVH0SNF5O5HCwylPgQwOnf6yOXxyVIp1hQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3915.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(52116005)(1800799015)(376005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?X5BV8fpf1XVkGPMjK+9pLk6VMG4EF2+mpjEmhQV7nQgPMwL4VHMi69a+UKM1?=
 =?us-ascii?Q?Ci9O7oO6p2Qf6+Bjlyj39NyD0PnBqeCM4WDvt6w3ZUidi55vBUA7T6xY+yxU?=
 =?us-ascii?Q?Lz+68zZMPXTHqbMzlAsPma07jp9Ru23a4+4npGnRfKpWn7N1VH2k9S/M6VFm?=
 =?us-ascii?Q?U9p5fg3+9YzMP9bjm65s55FjkN143CnQQCrdRhPzXw6eDM3FCNgA6wMIf38X?=
 =?us-ascii?Q?0c61iUJfI3oRGBiO2pK3Xdxm3kuATBLFhHT96wNHsUd7A1J5OVnxxkbHUkcw?=
 =?us-ascii?Q?2ZmDEIHjp08w9yystD3aFguERiwSCO2E2Zmue3/ypvAq/HEG80Vz1NPyzHHn?=
 =?us-ascii?Q?QokheDzoAUEdWmWioONpKHa786qOlFqXyja7vz5WIq0ypxvmz6Xy1ewn+273?=
 =?us-ascii?Q?jSZVI7qTECDvpacLRjXlHzq+bD6y6tmdGQ7Hj1R+TfaaOy18pTD+i+6LpoCa?=
 =?us-ascii?Q?HR3Y4Yu0sjXmCDWJaRMQH5VlZ/7ZLtzmRZysfshh3TN4EFHChcSNMw1Z/zBD?=
 =?us-ascii?Q?ydrbXD/kTb9yvCDtZglL8iv8w4S2h98qoExQz+5HhlMJkefVpvPnQB5WL6MY?=
 =?us-ascii?Q?vMNw2QlHo//qNBLjsk9QxYh9Aip0/w7IryOv1je4HgdUVEBnuxNqrrA4Px25?=
 =?us-ascii?Q?lCcoCH1Sv0aJSkQmo4xjJ2b+zbcfvCht6DLNO0H3eHvSjflityR6UiNV/BzY?=
 =?us-ascii?Q?jojph2SayQtiwe39q4Tqc55Lo6grOJLdekecxcBMpsNYo0YZ2FTKz82zbXAf?=
 =?us-ascii?Q?AqRcnIBVnTPgb8jW/ACf3MHju1kU9D9qtVoJ3yOdeKgnfWap1JVMPOIGfNhB?=
 =?us-ascii?Q?7SJtxGX7Wt4K89PY3yZ2hHzi3NBmKEbtNc1Bzj7Yfj5nvaUpILBWAID87bqO?=
 =?us-ascii?Q?OkxK3Q5OQTxjt1UHDm/GmA+nzMZtqTZolE9NTzHWjXTLK2io92GQDi69p0vW?=
 =?us-ascii?Q?NBq5G4YhraYLeSl6Q+SDsDijOXH7m+4wDY33HhPRO8Uci3ksKstVcxAsaUvq?=
 =?us-ascii?Q?3t8kGNj1WkRp6pGbShRKgstgi/BnHfqmyGU/eqwWH+1P+y7ZknZ0LQ/wX6HS?=
 =?us-ascii?Q?rb215HVoHsiHSHRFVG5C0dY1iSYxF6cYBOhFWZ3BgPH7D4QSFR6ulYN4pdQ7?=
 =?us-ascii?Q?AEiPHUpjGy4O6hQCyTzwZXvdKJjxolVDHUDfVR9o2iDpDqsNFILArWHUCNVn?=
 =?us-ascii?Q?skmpXjg1DQyUYrJmmsqKp7xjmKjfHaZY+OxNhWqnw/GaV0y2oyaI42gQQ/fL?=
 =?us-ascii?Q?6mabnZAWgub2AI4CKqqTk5W53JkFIAgjAFhSVlV2S1661Eq2kpxmQPSKRWJL?=
 =?us-ascii?Q?sr5o69qEZweb90QaIG1+RaWbRml/OTQKp3yLlo/qIXqA+dEzhT00CirUXL0V?=
 =?us-ascii?Q?jEt8JA0LtRBNIHb6tEL6JuZmGgZh7hgEgK2sGC8BmD0ZU6pjFvPrqp9yJj1j?=
 =?us-ascii?Q?MsWZExhZHYDisjiBxu2fiFh0ZD+U1AKC2Vw2cAbkCFs0jnBEOrK1DMQQW+AW?=
 =?us-ascii?Q?bW7s3JfH80nwp9xmNPIZXlb+gvmoRcwzDoukBcgVdDA7nqH1W2xUz8LIJL27?=
 =?us-ascii?Q?D8GmTXtJFk56X1/r/JRE9WmQsujuvkVQXqH2O5/J+VI4swneQKjC1BWBZkH1?=
 =?us-ascii?Q?MiT1ztw3QmNbXidrb1ekDJf/Qxbmw9dBcsUydfJUct7m?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ffacd0-1034-4052-85fe-08dc793b92a8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3915.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 02:13:15.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+KOyFaO/MBahOG+jjJ0gMe1Mp8QXfd0zniXiyiqnKDIHsAQ5pOslMIf71O+mzXh1euXd9A6PVj4fMSL4udpTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB4429

When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
allocates buffers using vzalloc(), and needs to share the buffers with the
host OS by calling set_memory_decrypted(), which is not working for
vmalloc() yet. Add the support by handling the pages one by one.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This is basically a repost of the second patch of the 2023 patchset:
https://lwn.net/ml/linux-kernel/20230811214826.9609-3-decui@microsoft.com/

The first patch of the patchset got merged into mainline, but unluckily the
second patch didn't, and I kind of lost track of it. Sorry.

Changes since the previous patchset (please refer to the link above):
  Added Rick's and Dave's Reviewed-by.
  Added Kai's Acked-by.
  Removeda the test "if (offset_in_page(start) != 0)" since we know the
  'start' is page-aligned: see __set_memory_enc_pgtable().

Please review. Thanks!
Dexuan

 arch/x86/coco/tdx/tdx.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c1cb90369915b..abf3cd591afd3 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/mm.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -778,6 +779,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 	return false;
 }
 
+static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end,
+					bool enc)
+{
+	if (!tdx_map_gpa(start, end, enc))
+		return false;
+
+	/* shared->private conversion requires memory to be accepted before use */
+	if (enc)
+		return tdx_accept_memory(start, end);
+
+	return true;
+}
+
 /*
  * Inform the VMM of the guest's intent for this physical page: shared with
  * the VMM or private to the guest.  The VMM is expected to change its mapping
@@ -785,15 +799,22 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
  */
 static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	unsigned long start = vaddr;
+	unsigned long end = start + numpages * PAGE_SIZE;
+	unsigned long step = end - start;
+	unsigned long addr;
 
-	if (!tdx_map_gpa(start, end, enc))
-		return false;
+	/* Step through page-by-page for vmalloc() mappings */
+	if (is_vmalloc_addr((void *)vaddr))
+		step = PAGE_SIZE;
 
-	/* shared->private conversion requires memory to be accepted before use */
-	if (enc)
-		return tdx_accept_memory(start, end);
+	for (addr = start; addr < end; addr += step) {
+		phys_addr_t start_pa = slow_virt_to_phys((void *)addr);
+		phys_addr_t end_pa   = start_pa + step;
+
+		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
+			return false;
+	}
 
 	return true;
 }
-- 
2.25.1


