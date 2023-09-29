Return-Path: <linux-hyperv+bounces-348-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACA57B39F0
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 20:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id C8905B209B6
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 18:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F5466693;
	Fri, 29 Sep 2023 18:20:35 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C826666A
	for <linux-hyperv@vger.kernel.org>; Fri, 29 Sep 2023 18:20:33 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020024.outbound.protection.outlook.com [52.101.61.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED5C199;
	Fri, 29 Sep 2023 11:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCWVqFO9jReYAMvA2CeP7x4dsq3gwOvrkTgFRYmwS+zzhcxJARNa9dYXKdbrsoVgkCm375cafyZfGxD8ecxtH6TebulY46SdOT/xUV4ifBtu5mSWurGu0zhgTYOtgMBOFmb5becmFRRHjjCtIy7l9Lsm3Y2Y+teAdShoP2yjwUL5eqA0j5hTrACYA+ge7izQvJWmpg5ew/TN2FRExfm2vRQo0m69/gt6Bi/ydlcLqcvvmEQVyUZxh57U6C5ZPm/nK/USsl8kUoQijqeTpDxp6DympEo7v/vidKLS07IXw2W3s15CMvYU7m7qN/LH9m9B4HFga62Y2XYNjTA4VK2Q6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Rjf3q/TwNEaI/C1ZPj7OLMe/dHReo1HA7m/Y30XYgE=;
 b=Q9bPhxTRqeTOCU/POO2tCj7Oq80HCwDU388vNvmAwPXqsviCvOE9Bh3yysKbWnaFlfikxw+KceGLPblGlYFmGx60Dn4olSBrw51XgHdLfXL9SrCBaUzVEJik1p/I3InTrg8MacpOoJdkl08HlOYHSH8Pmn3vcX1ndKhTyWWXTCDsC5Xg7FCjHjVdgAbXdZsetvRTk6LtnJ6XEdAvNdQqHGODuvELohNmWgLXYB0JPyuiBGMVOmlEcvoKTNJMCQEL2dtc40GlKjpnN+tWiDlvzH37MMtcpLy5B090lrP43OndZkAnWz3UMx8um3jN08sz55qthBZbyBgo2yjE/bz8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rjf3q/TwNEaI/C1ZPj7OLMe/dHReo1HA7m/Y30XYgE=;
 b=PjA6oR0DZsp1EB4eT6wT2Ui7u1erumzl5ZEpNnb5YQiufYczBPIi+khAMMZ9PihMONA0Fz95sYyJTHoboOqDIVI5KXSFvtDHouVVNMvUw2C//SfJpBnF7Kxv9NOaHuav/TMQMfCr22OLGzUwC0N3yEK/h6gu/5nIKT/rX9utrvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by BL1PR21MB3377.namprd21.prod.outlook.com (2603:10b6:208:39d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.14; Fri, 29 Sep
 2023 18:20:25 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::eff:aea7:be24:8e44]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::eff:aea7:be24:8e44%4]) with mapi id 15.20.6863.013; Fri, 29 Sep 2023
 18:20:25 +0000
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
Subject: [PATCH 2/5] x86/mm: Don't do a TLB flush if changing a PTE that isn't marked present
Date: Fri, 29 Sep 2023 11:19:06 -0700
Message-Id: <1696011549-28036-3-git-send-email-mikelley@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 876bc7ea-dd06-43cc-f419-08dbc118c020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	drKoxyNdfNHGgC2dAgfKk4mGYSq5cFVuJNnNMIDX207u2WoRdzsI7vITLfmdZTnBTkhZnUrrY7pmAFk4SzmhMafuWwPPTHOu5OzdhhDKTmjZ96BDP21re9J01cXxnjp1tE926ixm48OOf+LClSqUuJR36FzVqZu+CKPtAgM0mgKIMeI+F8M0Bkhw2h+qWdljNsBb/CRzCZDl6l8MoRaHMjWCx4+3xmL4gr/rqNXLSSYEC8u2popVg/C3sk+90BarA5AONI/xnwkBc7Fl8uGMnth8BuYOo000Qj7tx+UlQb3tDiEHQk05gfoa3fLUIckFQE2sfMo5cBS1jniwr3LvCtqoXeSpzi3HwjxEXWzcVr8itWKB6s/nEG04VkiZsVcSKVlVFtk/a6xcleuciScMQ/R90nJChc83Mmwk3AGXvEeRrjUX4wG57cZ0n6zAwviA9g25MYUZWLBLvVis23EW5uZiGNPhHYweWnLZGqgysCVkkzfAOQ+feLNolaLUpYnCq8yln3u/Ims4ZmF1Jtj2nCxT9n1jR7ffVz8XI1f4yT7UpB+ce15YpgzUoGF883K8U1wvgCVTm9F73vLrDWp9222IeJ5qkesTAtYSufT3UKB8mba/XwiUNBdMd72hhtqYaBWaZCri8HICtjrPEVJTCncZ9dtzgPj3gWoACcSpTAC544HTALBSiSDi0eoD3p7E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(41300700001)(6506007)(6512007)(6486002)(52116002)(478600001)(6666004)(2616005)(2906002)(316002)(66946007)(66556008)(66476007)(5660300002)(107886003)(10290500003)(8676002)(8936002)(4326008)(26005)(7416002)(921005)(82950400001)(82960400001)(36756003)(86362001)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RpoZgqrfEqTuymHl33dS+zp9mv/oxMaZ+DN6gGuh0ZwgRcWJGPmvj+4bpVT+?=
 =?us-ascii?Q?96dKh8bCZc2IMV4jBhYoBR3zO0uGTyKhmYFG33/E7QR7z1FXcVZKUtjIP7kl?=
 =?us-ascii?Q?0wo9xM1Q3eaHq8Pv93Ep2nZrFshl+ninCYOxj9bUjaWP7wOpdI0aWICNS5zC?=
 =?us-ascii?Q?6+ntSGP9irc+kIVOi+ShDxxAUKFBQJItK3ESo1l+FD/8kxkwJR6cfdcMumdf?=
 =?us-ascii?Q?QOAXdvO4ipkLLjJkZF6K9FsQTtSLtQbvCHNetx4K0HjCUG3pTdN71m1DcgpY?=
 =?us-ascii?Q?DNpLCowD7sN9mgeDLF9jn3ZJKxQLyCsLScbYFBAblibdC1ng9MrqKrextZBA?=
 =?us-ascii?Q?S8NxGXBOjpVAxPFpd/0/8XFZZqdyx3R17rcJF6pwCcdWrUzrQzuHhOw1OpjH?=
 =?us-ascii?Q?12xRHSNLbPgP8J/mYW4HFRdCFgBwcWaBONvT83vBIeSpN/J5xgIONIFhwPVe?=
 =?us-ascii?Q?cZX+HNoWSdur4DTSwtzf5w+3JFFJ9BWduHBHPsVBIHSLX/7fAZQwgKb8mq+6?=
 =?us-ascii?Q?FM6+PgQyWDDvUryNoCZ/KIU+IuYzSGn95FcyLtELmAhivw6/PFSyu7FUe45e?=
 =?us-ascii?Q?fDwNkMZ5H1mTy662IHiAoqUHLKs2fs3MNj3SsW4IzSzwngpC4AwxeNJLVIfC?=
 =?us-ascii?Q?fR0LIFlUGr2iB0IdfgdTZiWtkMsB9aTDpf7KOD36+RT901wAKeZ40PpUphx6?=
 =?us-ascii?Q?m1xTqt0H6tflPGrmCMZN8Z4Pjf07WolTB4IwZgnKzcEsqZJQHVB8q1ABms+0?=
 =?us-ascii?Q?ac0o4cu67W7jlN2XWfavlEWvqxcTipxF7DbsE+UXk851fPo2AF/qWkQl5795?=
 =?us-ascii?Q?yg53c863yubZmNyQrxmRoN3f3MLOiR2fXWrYO5I8htk+4MQwiV5IvDzczwO7?=
 =?us-ascii?Q?H9d5AvbH20Fkf9ROq21ENh51V1Fwh03tJfSnZoKm062UmQ0nNNf8NiNUwED0?=
 =?us-ascii?Q?QI3+i7LMduiLbjW2Z8qfvRzzpkK0M4WfgDXZshk3Xezj5w9cGbe1wPGkRSNH?=
 =?us-ascii?Q?9rOyQORQ3q2cjrIOHvNwUr/I19I/rpSwxkdQF2OY7fHbmQlddX6Q05uSOQEM?=
 =?us-ascii?Q?8Ry2mMLz3y2uZXS9AEjtkmPtyReT3jwpsDDj8k+uIBQpSzbXvLFSmg05KNTr?=
 =?us-ascii?Q?ho0k8ph4M780zgXp087JckdGP7qMNtj59SB6FvDHLAMIbrXKpRaumpYolck6?=
 =?us-ascii?Q?PsSVK9dxrXsZxQhWJGa9LyLgyZxBeaifrEMDNignJvyCRBxls53k8njOZGFw?=
 =?us-ascii?Q?0IX+xN5F9n2/1epPb+P0/J8BCctv49VwPv2FdcHmNvwtilqwuT+mUFPGtOrx?=
 =?us-ascii?Q?6yCp7Z7JaFEY1Xhr7NgQGqZCUX34+vFyoEwp1dqoRw/PIggD2W75+8yTRK9S?=
 =?us-ascii?Q?ntxHNZ351zT6VU9upMhdMUU8EKpIj7L/d0PY1yOjki3Mifhbtz6cYjFrhKKv?=
 =?us-ascii?Q?/HhR7SM1dBQV0PEx1tk8+INHsczjn3RlRqZETa8Qr7m6CJk4UoHIenWMj9G8?=
 =?us-ascii?Q?nfx+yp0GWfPxAyPMU39kcDpSstbZD9X5SXb4BJHo/LTMsGJKUdMU77yqAMi+?=
 =?us-ascii?Q?xrxt0N8Ihr7rMKGfdigMCIuqspMI9uOKOw13nbeF0Mt1ZX7CmVG93Vjh2LWG?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876bc7ea-dd06-43cc-f419-08dbc118c020
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:20:25.1192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03L3zsEtkDnp8U5ikYVePuc/qNx63RA5q6dnkItn5IfTL++430f/Z/SGDXNl3qkK3LAwq0dkLzuWvGn3RvLYkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3377
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The core function __change_page_attr() currently sets up a TLB flush if
a PTE is changed. But if the old value of the PTE doesn't include the
PRESENT flag, the PTE won't be in the TLB, so a flush isn't needed.

Avoid an unnecessary TLB flush by conditioning the flush on the old
PTE value including PRESENT.  This change improves the performance of
functions like set_memory_p() by avoiding the flush if the memory range
was previously all not present.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/mm/pat/set_memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8e19796..d7ef8d3 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1636,7 +1636,10 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 		 */
 		if (pte_val(old_pte) != pte_val(new_pte)) {
 			set_pte_atomic(kpte, new_pte);
-			cpa->flags |= CPA_FLUSHTLB;
+
+			/* If old_pte isn't present, it's not in the TLB */
+			if (pte_present(old_pte))
+				cpa->flags |= CPA_FLUSHTLB;
 		}
 		cpa->numpages = 1;
 		return 0;
-- 
1.8.3.1


