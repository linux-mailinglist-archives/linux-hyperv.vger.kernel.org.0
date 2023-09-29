Return-Path: <linux-hyperv+bounces-347-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94897B39EF
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 20:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9A1FF283179
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660C866693;
	Fri, 29 Sep 2023 18:20:33 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC136666A
	for <linux-hyperv@vger.kernel.org>; Fri, 29 Sep 2023 18:20:31 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020024.outbound.protection.outlook.com [52.101.61.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1999C1A5;
	Fri, 29 Sep 2023 11:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QC7yPmH/JrFcy7YcWD7eUI/UWr30yvQYnmAyhMdjxQs1MarcFCgv1b+XXB1kFSwpNIMJZ/I52Z4rkwwaDP/kex+M1AjECa5j+52k32MenCjYWIKhO8eJZlLoQywYdoKHKoT6HL0EOym/u1aETB3GKTJwRAlFugMq5WMSe1cztmXUtgZ1/+Mlz6tas9nobUB6OZxotqA5/iJb3GETZ/mE+tSUKmdTGSI++Ry1GM5JdES4p1EpN5BEQ1ZjO2GcT1WH/2hYOreTBzGurV7/f6hzoa41IVIh0z7GwMT5OHFSEv4Hhaiy1MBlLqVaNitkhW/SytoHyn3NwMj9khdOgXuZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSOLdTfIZ4+T830+nJ7RRdvPJg2csnPAprl1jzEEDuY=;
 b=evCDBtRbZsS8cHxLzM9hACL0gQUfAbd+QrsRtMm38RxRH3DMaOG00FZ3w926ZBFQzwRywoh+gLmNugM05jZOw6bH+3jWolFFwxsz5kQbkcT3PnRQ+q8yaO6yzx+PQwQkYK/kHT0h4gxHdUJJScetuXmWb4PbZcYE/jcCF8XrJ7+fz/V1S3OnhsvbqkV01sHf21oZNKjoo3SbmkqbHMSIPmoobsBrCw1tXZlG32W6kWwpPXaXjxDxgRQQ7u+LlNZNU/EdzVgX5OCrR/v6foyexkRo8FR14RIZ2RBiOky6WnqTaAtOzvvof/+Ws+x9OIT38IOrSgx81xD3S2InJJEYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSOLdTfIZ4+T830+nJ7RRdvPJg2csnPAprl1jzEEDuY=;
 b=CPp9yv1CruSIsC4twRpUAS+reuxxfHbHQeUTGF7SOjVDQexmcRCu6twmLxQ2I5dc5T+lrgRsgYImGqtjmJajaKVb900Z4/YaSwGbfnrbSi0dhcqh+4YI5+TywnNjE0USHGDnkmcentiGKMxiuF617+c/5hsjAZjSkLECk1PDr3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by BL1PR21MB3377.namprd21.prod.outlook.com (2603:10b6:208:39d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.14; Fri, 29 Sep
 2023 18:20:24 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::eff:aea7:be24:8e44]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::eff:aea7:be24:8e44%4]) with mapi id 15.20.6863.013; Fri, 29 Sep 2023
 18:20:24 +0000
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
Subject: [PATCH 1/5] x86/coco: Use slow_virt_to_phys() in page transition hypervisor callbacks
Date: Fri, 29 Sep 2023 11:19:05 -0700
Message-Id: <1696011549-28036-2-git-send-email-mikelley@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: fb218858-7da1-4d54-234e-08dbc118bf6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mUPHgUoH83MYBMMK8yvbfGOxIuuTET1OnWf1aZ1Of89d1oiR4Cmn468l2LRh3ABqS2JIrvwvzeTz8pElA6pd+AJ27531aA/6wqO6/7AqeN+Amy9Ewig1YB6ZmR9XWmjftofSwwEirEkxFWfm6fWgmrJIdhKUzz6JzC7Yd6HBzebHEKSqi7LZVZ66CF7LkTXTbY9Ms+9UwNb69YC4zksq5AjHwn4YjhLEqDOMroHAMkIC8//Mq6HXYC7z7OYH5njwklkB/DRokbyFzLN2tgbuj9OLckpeRgo35RCH56ZCnYGjwdws2jJ07Lb68zxvRnyYZ8YtVDHGqJZHdHoIZXJ8OBg/49Dyxcgww5+G8lVh0WpFiW02E+HjiSSJYtYwKOfCFqy0jw8QVLCl84TMjKorc5zRGDtXyUL+vX2LlljuV6e5AMRYEUXMga6m5xiEPpBSFEQTvR0F7VNG82yr7TN914rGBfgQl4fxqjVQDQi1WJz68qmMAuS5Tq3duFt0UYk2/kPVwEkSk9xSYBsxHhKyFq3SKF9fLOP+r/vRXqp2OV4qWoej0CUiLFgpic1Ocmosq5sXKBurI6jF6hu1wvN93bN8P5g+d47pKEkJUWhCZmDsk10RX0OFxPppAPZMdCJOMCyd6/HXgYFVBYwxsYYlhVO7I0p9nL8a0ogaxK/dm+20BbW3QOpUZ8QN83ns5IBt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(41300700001)(6506007)(6512007)(6486002)(52116002)(478600001)(6666004)(2616005)(2906002)(316002)(66946007)(66556008)(66476007)(5660300002)(107886003)(10290500003)(8676002)(8936002)(4326008)(26005)(7416002)(921005)(82950400001)(82960400001)(36756003)(86362001)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JgbRmJ8EAInjrnLV8/uwCDX97hmH7czFClEH3Z0rvZ4siS3I7S24wn5HrRYB?=
 =?us-ascii?Q?9/hIUxFUoLE52RdvIOuIGsFWRR9HsFy31ks5zMBVbFHc5vtziH2WqCoBXVoB?=
 =?us-ascii?Q?zmviF5wz2clvVRfJHjPiVLcEKtPH21uci8wnvTy8eDSHljEHtNdfH87OUdWD?=
 =?us-ascii?Q?ApmtoCid6IJFa7jmbNCqjfWfpqRDn+5/xYebUxwr4Mdk1PiKR9UnsQDVErLe?=
 =?us-ascii?Q?6zg80V/jTn4A+CcvsE6bjor/hw4ZGgnlCYiaagAodzBFkNhoOqG7KfL7Fe6Z?=
 =?us-ascii?Q?b6xA9yzec5208Tc6eaeZ3g100F2l08I3k1OfYhkANQnt0DybMEETIajzw8U5?=
 =?us-ascii?Q?9CfE5l2K9J/6BtaeUYatHf8kNRSSRvV7/KX4uavMACdkZUF4Gm8kuLNtU/vG?=
 =?us-ascii?Q?v2WkUtCUQRLddEjl2ZIFNyAU/mpCx2fvAK0e+zJbJEUfAhmQZn5Cw+Vhp/Mi?=
 =?us-ascii?Q?MqMrlGTaJ+12OdaR3CQK9k2+A7BFxp4mgX/SAlgdifLTG8WwtwCNBCMoRuIO?=
 =?us-ascii?Q?KeD04bNYXWcLcp+9J76gCzlhp58EGfj/UvIl1V3wMJ6Afufly+lwT/WHSZpc?=
 =?us-ascii?Q?3jCyTNSMjX1Zx4aRKENzC+ckubJefSKj0IEYAW4QiLq64LzkPQ3my8rp1IRg?=
 =?us-ascii?Q?PQ5JpALGaqVDUqaz7hSlvk3UsnnhV/lLF6DU81Ir/8oAwt2enqNrdUfBsVEn?=
 =?us-ascii?Q?InnqIkj8T9Rqamhx37V8fZUdB6IqVlTxAqikuUheoys86Gfw4t1Y4CQEpJCt?=
 =?us-ascii?Q?9vtRNobxBwC2Le1wHIvG8XL4eWdpARhyzbn7QjKEFL00k8d4llNtke0NFqjc?=
 =?us-ascii?Q?TYIIr/lSJXccFO7ayKtch8GQ6TSWcKqZxFtOYLkyCODg1tUsqje6pGrFK7qZ?=
 =?us-ascii?Q?tnJ8FJuENUbo2FMQnNZX/qULDVrBTNxQAFx/it0bu94M5O3mU3Ws8DZWhMyN?=
 =?us-ascii?Q?9qy+IlVoayyjMFjYIKgHj3QRk/Wdd/AORvSRgn1QFFGOqRHIkNQh4JQ82unk?=
 =?us-ascii?Q?tRWH2+7V7jWbW0whVA7el36Fgtl8DYfiDr+KsgXWuJ4UwNoFawpFo6q7L337?=
 =?us-ascii?Q?Ebl0KjFQJMpfAzJzFiMuLqlYVcR5lhJMqYEpMQ2uxTCy4iozKFFOUv3cxFPL?=
 =?us-ascii?Q?uYYpCbq9OCKacaTFXMbtrXD4YA51bksNSytAYCHr/cBp1i7WqJdtxDbJMuA3?=
 =?us-ascii?Q?F/tg5f1xZNi+Y+hCVevw91HlVj0Y3H5b73AjYKBh8yKXj0JvkjXgWbhiZnkm?=
 =?us-ascii?Q?A7NgHRgll01cx2sbb5aZdVIDQBLTP4hBdE2WC3Ueot/Yl3E4DoD7jvoYk9x7?=
 =?us-ascii?Q?mUSe5JSepfX3UJgK58ZdKIdsFYYSyZQE4GS+bIBBnU923MT+2cj/TN87Agvb?=
 =?us-ascii?Q?QEp6rYfh2jwQMx89HZHvrZz8w6hcn+nvK3Si0jSEuTDn2Md0y9JPdb+bQt5Q?=
 =?us-ascii?Q?VWvjOCYM8G/S5o3mZsxIusluzPOXCY4kBQWnB1MqE/RPOm2mKkOtG2v+I+1n?=
 =?us-ascii?Q?l8VddH8r//ggUQ3kbsyzVuUCiIwmCVJvhCfm7UHg9dgcecYjszAJGLJYLTK7?=
 =?us-ascii?Q?lrsyi9eTjT/1IEativARqdwG99IOoZl2Wh3wSsB7qwdAY1xNLSrXnJqp3PO5?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb218858-7da1-4d54-234e-08dbc118bf6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:20:23.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HkN7j8Cfuex2mmxod46j1H/sjSzSY7izgmBv4voykqZoAzRC5UwUGOIjdJf8PoilC4FcatAMAYDDcx3uHD7Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3377
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In preparation for temporarily marking pages not present during a
transition between encrypted and decrypted, use slow_virt_to_phys()
in the hypervisor callbacks. As long as the PFN is correct,
slow_virt_to_phys() works even if the leaf PTE is not present.
The existing functions that depends on vmalloc_to_page() all
require that the leaf PTE be marked present, so they don't work.

Update the comments for slow_virt_to_phys() to note this broader usage
and the requirement to work even if the PTE is not marked present.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/ivm.c        |  9 ++++++++-
 arch/x86/kernel/sev.c        |  8 +++++++-
 arch/x86/mm/pat/set_memory.c | 13 +++++++++----
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index c1088d3..084fab6 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -524,7 +524,14 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 		return false;
 
 	for (i = 0, pfn = 0; i < pagecount; i++) {
-		pfn_array[pfn] = virt_to_hvpfn((void *)kbuffer + i * HV_HYP_PAGE_SIZE);
+		/*
+		 * Use slow_virt_to_phys() because the PRESENT bit has been
+		 * temporarily cleared in the PTEs.  slow_virt_to_phys() works
+		 * without the PRESENT bit while virt_to_hvpfn() or similar
+		 * does not.
+		 */
+		pfn_array[pfn] = slow_virt_to_phys((void *)kbuffer +
+					i * HV_HYP_PAGE_SIZE) >> HV_HYP_PAGE_SHIFT;
 		pfn++;
 
 		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 2787826..f5d6cec 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -784,7 +784,13 @@ static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long
 		hdr->end_entry = i;
 
 		if (is_vmalloc_addr((void *)vaddr)) {
-			pfn = vmalloc_to_pfn((void *)vaddr);
+			/*
+			 * Use slow_virt_to_phys() because the PRESENT bit has been
+			 * temporarily cleared in the PTEs.  slow_virt_to_phys() works
+			 * without the PRESENT bit while vmalloc_to_pfn() or similar
+			 * does not.
+			 */
+			pfn = slow_virt_to_phys((void *)vaddr) >> PAGE_SHIFT;
 			use_large_entry = false;
 		} else {
 			pfn = __pa(vaddr) >> PAGE_SHIFT;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bda9f12..8e19796 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -755,10 +755,15 @@ pmd_t *lookup_pmd_address(unsigned long address)
  * areas on 32-bit NUMA systems.  The percpu areas can
  * end up in this kind of memory, for instance.
  *
- * This could be optimized, but it is only intended to be
- * used at initialization time, and keeping it
- * unoptimized should increase the testing coverage for
- * the more obscure platforms.
+ * It is also used in callbacks for CoCo VM page transitions between private
+ * and shared because it works when the PRESENT bit is not set in the leaf
+ * PTE. In such cases, the state of the PTEs, including the PFN, is otherwise
+ * known to be valid, so the returned physical address is correct. The similar
+ * function vmalloc_to_pfn() can't be used because it requires the PRESENT bit.
+ *
+ * This could be optimized, but it is only used in paths that are not perf
+ * sensitive, and keeping it unoptimized should increase the testing coverage
+ * for the more obscure platforms.
  */
 phys_addr_t slow_virt_to_phys(void *__virt_addr)
 {
-- 
1.8.3.1


