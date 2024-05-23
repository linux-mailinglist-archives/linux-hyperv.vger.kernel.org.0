Return-Path: <linux-hyperv+bounces-2207-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6528CCAB3
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 May 2024 04:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D9C1F21FAD
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 May 2024 02:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CB8538A;
	Thu, 23 May 2024 02:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ylp27/vA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2110.outbound.protection.outlook.com [40.107.237.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD45469D;
	Thu, 23 May 2024 02:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716431137; cv=fail; b=JyXJGSEpFTBWY168s92wGUwN4HG+dCaDBYRpaViYOGQAKZoQLh7B/ApI+eeinOwzuzXYgaxlPwjbF0gO9hODH7b5KRV4oc1msca5RZ5drxM+6+oAG52QeIN9OB8A1nfA6B+Tq0kVFpO/ZoOKvMTsPT8Mr4iiOj3YjzBjVXhIKzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716431137; c=relaxed/simple;
	bh=6ARmv/FXCY8+P+JUSBqoimZRqp1e6S95gW4pZ/Umh8w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eEe2seBE16CxYgSCi8Pk7uok4OxF7LAJx7hSzgzWoBPiYOr2xzldRIkndRQTvArkilE+k/UnwLekqHJPpbzFWYEE1+JF+mHFrJ7phzD0DwlJ2knJvLDuahDR01UE0zgTLaA26dqNuKIv9ha98itwZFPvyLfvWo5XxO8HDYX2XNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Ylp27/vA; arc=fail smtp.client-ip=40.107.237.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUX2f0LNHkF5Jy7L9R+Io6gSSls6gFBwBDN/Tygz3n0OtEPcWd51Mtzl5aV5mSLwxP+igLoQDg0LmhB+yj2iWdgp8TamQG4d09zKTDXuz4ZbgjNbgzpxZNAnGmO7yOGDMspBKY7H/BY71yUhqh7XVKvXYa5NVqN+ozlWBHMkNTSj6itXmLnoM1HHhfwsdYgBYINci0azmvwAgbhmuMBwdISiiWdWHHOGIyaPt2K+VwAINof+/cMJEEvhVMM8aVqDQMFsE10xg+uPLe3TEwbJDUjR9q2xu8yHUd/JGQygDZV2EwNFd4fWbnOpoqOr1YV82l5tqjbGHGNt66S08JrbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6oPBpx3pGiu/oDDjzR0bWUpSYXr7nvkPU5XF5JCwUc=;
 b=liLxRgxT0u+T6h/kfe/dkiNIRy+CpA+Ol/KJ+Bo3xgQEGlMBsNKrHq+8B6aJwTTE+agCPyLVIANvbJ2kA3EKWFr4ODTm6AnAmiB+ZJ4/O0PEXoYx3K4MhnOmrLbCBBMSb1wK1LoQ1Di+s4JN9mAAwcCUhBTv0jiiTwKAZ16t4dpvyBV0hwEmtFhYlW67LZsb3QZ+KKT4Nok43vmmV2uTrFIRTt8GBpAzLpgdHUbH36kpKNKEyR7u8llPIZqZ+W+9lBCkwufaWvA04XAewndZSwJPQvVhuJgw2+XziNZ4W/hw56ZJV1IeFah64lxIY+KUMktOUWG8UygxMcn9c+jOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6oPBpx3pGiu/oDDjzR0bWUpSYXr7nvkPU5XF5JCwUc=;
 b=Ylp27/vAsMZtBP6yYQoIjCjJV6LOGrQNdhaTvuEhiTwvDFFwXBfGW11JfWKEJHL+lnhVlh8qRAwBHLXOnUJSc6zlFtIDpS2S+Iw2UH96Zs1T/6JvoGg2YVfzoa0k4+bWpdN/is9oyUyYmqzQfIN5KWc0kHD0O0iDVHOzAOqfnPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SA3PR21MB3915.namprd21.prod.outlook.com (2603:10b6:806:300::22)
 by PH7PR21MB3358.namprd21.prod.outlook.com (2603:10b6:510:1de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.5; Thu, 23 May
 2024 02:25:31 +0000
Received: from SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::47c8:8c49:be38:ed21]) by SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::47c8:8c49:be38:ed21%3]) with mapi id 15.20.7544.029; Thu, 23 May 2024
 02:25:31 +0000
From: Dexuan Cui <decui@microsoft.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	bp@alien8.de,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kirill.shutemov@linux.intel.com,
	kys@microsoft.com,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	Jason@zx2c4.com,
	mhklinux@outlook.com,
	thomas.lendacky@amd.com,
	tytso@mit.edu,
	ardb@kernel.org
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tianyu.Lan@microsoft.com,
	Dexuan Cui <decui@microsoft.com>
Subject: [RFC PATCH] clocksource: hyper-v: Enable the tsc_page for a TDX VM in TD mode
Date: Wed, 22 May 2024 19:24:41 -0700
Message-Id: <20240523022441.20879-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:303:2a::14) To SA3PR21MB3915.namprd21.prod.outlook.com
 (2603:10b6:806:300::22)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR21MB3915:EE_|PH7PR21MB3358:EE_
X-MS-Office365-Filtering-Correlation-Id: 4614db13-d653-44b8-b2d0-08dc7acf9e55
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|366007|7416005|1800799015|52116005|376005|921011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?8qovLEZqDhgPZA+EGn50QQCO220Xz5oqzhDEL2LQBntEHjyrDR2HI3jnkDVX?=
 =?us-ascii?Q?SMRUkY0rI2m8VrM4DcvV7YbumeoXzi4gETuIcBYpdhGpemIzrSDmOhvJLo2u?=
 =?us-ascii?Q?BML+MIWhkj+6gRxBuDUhLIYliV3/FuAMMif3ZWi5vJbZF99sEc4HYjd/qLCm?=
 =?us-ascii?Q?SQ9Q2u142DOCUW/ApMYtN5SQTxOgubzIVDk/DsYKeQZCUvsDnmVeU1huK0EF?=
 =?us-ascii?Q?XTecv2bLzb3SzQT2oxsEIj/5YoWoLwN5g5HI9h1QZJKzb6chZB2TM/xrc9w/?=
 =?us-ascii?Q?UIWj2W9ydHAQR1b3+UPZRxnn0Nu2dFwhEamvdL+NtR8OYEYgq1pbatMUMj7d?=
 =?us-ascii?Q?qGy3YHDwG4C2HFMnxCwgj8QmvtbTq0bppXO26ryP/o1avDK9xBgvY7WztwmM?=
 =?us-ascii?Q?Ou52H6LHTbnWLNi7SgN7t3Yx3yNELKqMTHg9RB2Lvg3WUyl5FSCVg8AyR3vc?=
 =?us-ascii?Q?JwMUlWe0WVjKB/El612Ty0nQmhrze++rhVuv+kl7ubgk5a/GwC6UlSQ7zlc6?=
 =?us-ascii?Q?lBflmppu+mA+EOFMmQqihq4vmvCaAoUU/SrVb3SktXt5eG1G5hVXSmpNptD6?=
 =?us-ascii?Q?cdMZEgjgi/Iwu7pNideqVa3kP6z8FFoAfBfzcSD0eWuENg8//Qf+CCEXpf+C?=
 =?us-ascii?Q?iKriq2JOUgirjebiwazFvWvXpjzLgeqcjJjFwteaYSKu6DrHy8bWfSXTrbwc?=
 =?us-ascii?Q?lxsuFw2NPV9k/Y8SFUGH0BGLAaiee39HQWe9XzW+WKI05wlBVBIETsrjt22n?=
 =?us-ascii?Q?B+TDoXgL+o+vhgFBEA9I9/4uDTbKdTllVyvFcekfuxP+uzt31AACV26rpJU8?=
 =?us-ascii?Q?HOpjO2wLIiKqSVMx+Ih5bMA5if9rzit0pZfsL2xptn39R2yJrFZv0s497xqa?=
 =?us-ascii?Q?Q1hmx34buaIaAprA7kMymU/el9ksCreAHBPH8pmzaWYR5WxgFAyqxrio6ox1?=
 =?us-ascii?Q?d/oZrt5U0snog1zOnby6H8N7wPuJTStlTmapsbeFFUwcogYmChJCg9ZM/Om5?=
 =?us-ascii?Q?ZqwfOgYsVy9EgaC8rXHDqeYTiltLHqNEpTRtSrtCcr4s44vv3uUxmcT3z479?=
 =?us-ascii?Q?ylfoHLsGNxmGv9UEKLciAqBxQP7C0C78dRYjlKCD0vVyz7xdp/6Th+/fj96K?=
 =?us-ascii?Q?E02y59KKoPGDIcigdYS3Fnn3M1P6h+LICZQH1UYzkH2EGRWxMXAeCTRlkrMi?=
 =?us-ascii?Q?a6SaoUvBe3kg37fy8QRggE/XzgHG0TKWyNhGsuJvziz+tL1fsuXPFRitTN5s?=
 =?us-ascii?Q?yxabcrxPvkPKkI5MHXt6REC74RGCiROEQghejXo6UTbRIsZIr1N3qiC+omql?=
 =?us-ascii?Q?siDO26O3Ha2918SxwOGWU9Ks?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3915.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?lp3u88qE3YxPToaF62x3o48QZNdiTisVP2bvfFlPfG8weMEvsK7G5w66nz4h?=
 =?us-ascii?Q?wD0/HZo99Idy3+IuzCRWtSB460XoJjjAsWSxu/D3vDC1coSFzgUZFxHmFNH3?=
 =?us-ascii?Q?wDhqj5oFJtIlwQFaQyuZKvVmMIGoY0AJiJsCoX564TddrWE4ppn+I+FLZXM+?=
 =?us-ascii?Q?x5DhamavIiXQJKUC3DAgFW8UJQa43qrBV/EZnhp5pCEpmTlvCYe7oLiWctON?=
 =?us-ascii?Q?m8I/XhayxJ67rRwMuV3BDnrs3tDHjCUwTw3ez0t3A/I1in551A4qwrfFwdyv?=
 =?us-ascii?Q?y6NP4QcUkIenVBUdwEcFAHvpagaEfbCsy76UN0u/LAKPUqX4IrQl22N4JpqK?=
 =?us-ascii?Q?3uBRL0tVikXnS2e3vpCCKQBEduY/wewq1fMRsowq59yDCVdad1nzouKC7Isg?=
 =?us-ascii?Q?Iw5l09NYi/FyIIh15Z2WZtqiMR9ytraIHxlWMnhBgq/hk181vnOO2k+IfrPD?=
 =?us-ascii?Q?8AV9DbxzE9rC7uszesFGOzuwByxYrafPitcJLqFhKgOOyeS+CfGO/zDTGHYy?=
 =?us-ascii?Q?nhIHdKu0C4I26fRyw5pLv+pfnSA7/RiVq8AOCTh0EVq7ajBRy38//GmIRZJA?=
 =?us-ascii?Q?iI0zJPAybEJQCfQ5KUlSgnT+04XsigbFjgPsqsNxPzKnA94BOJhLs61GG5rg?=
 =?us-ascii?Q?yHRLfEVoN3nuEKI8a2b5nx2AVenYNOSSaIN90o1Y25AriBhYOkWstMUJOQoQ?=
 =?us-ascii?Q?u+6hNMKg/5cAYlTWvt2lJA5dADZfP2ZsHeRivWMXZtNfqPhZxtpNJcyxLzFv?=
 =?us-ascii?Q?969VisTW3qLj5xvc67P8511U61TZSfZOUHV4ObteZpkGulxDtBUT8BN6Rfoq?=
 =?us-ascii?Q?XQxQyMn2H8oeGJF6GN5d0VC5i6zdHFjnrk8vp9X5teHihribQalzIe97bQO5?=
 =?us-ascii?Q?MQmJFxLwU4BHNE3Y1qcb/WBknPDWX7+9cqTohqXt8KoiWrtZ1UofjmvgcnAW?=
 =?us-ascii?Q?1zrx1mrDznDqtqpo5dNjEagYisaalSGG9Im6wbbs3axIVzTg/xjuEqwK2TFh?=
 =?us-ascii?Q?xbJee6kAJQHuucd5vxarOaITWBIxq9e7t6wjrBYrj33/WNS86WOveqFQsVpR?=
 =?us-ascii?Q?RtByQlgVT0P47cLr1LRUcg1U3dWmYF/PSmkOuNsaGYays9NjK708/KGe0HZl?=
 =?us-ascii?Q?o10PnlwNv10ZTYLeiiYJNtpeBylBdZ7RgXZP2WM9OWz5Up/gpSaFtJE2uLxh?=
 =?us-ascii?Q?my9buOrglOwh0W8sXbOCf27uEIckdoXdifnWrXafcRtKaCEedHNH3DeDs/Ky?=
 =?us-ascii?Q?eK6O9ib4ILnZPz148kJgjBzdkqyCfyEKRPtinvrsWdHdPROaGYuBraIHEt+w?=
 =?us-ascii?Q?dlw8XAkN/2wDpRBRXuZWG8bmtOlAMXKd78vyvrz68OuBdh/bEckceYBgJRHL?=
 =?us-ascii?Q?HMeZLXLz/YF68gddJAbGbdEik1Em8YkYvospTpedLWEJIMU7wxPqRI+ytqmz?=
 =?us-ascii?Q?/NbBRqE1LfGyININqnESIneNvVjZbZaaQ6mIcDGU7U6Osn3O0ovO3o0xRwFh?=
 =?us-ascii?Q?rxY1ufSjwQ3HKCxTxmotRbpg5Apzq+ubUq6RDTeqzJZFRBy6pmnR13yCaFcu?=
 =?us-ascii?Q?0zX+ZedwulM8pgZiCER8Sc6FLvrq8VQKVZu0eBa/pfDyzGmpov2ESf79PvLr?=
 =?us-ascii?Q?pBMCOqymNnf5azw7CnQDhxN3o4UxfVk95nVQLIE8bLqO?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4614db13-d653-44b8-b2d0-08dc7acf9e55
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3915.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 02:25:31.7745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bj61kqTQ+4kKwJE+T+y1tWcICIgeWKDuCOML07OZMeJS88hykk3rw0yDfRTCdKqnGv31LI+LtD+JB/0pisfaqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3358

A TDX VM on Hyper-V may run in TD mode or Partitioned TD mode (L2). For
the former, the VM has not enabled the Hyper-V TSC page (which is defined
in drivers/clocksource/hyperv_timer.c: "... tsc_pg __bss_decrypted ...")
because, for such a VM, the hypervisor requires that the page should be
shared, but currently the __bss_decrypted is not working for such a VM
yet.

Hyper-V TSC page can work as a clocksource device similar to KVM pv
clock, and it's also used by the Hyper-V timer code to get the current
time: see hv_init_tsc_clocksource(), which sets the global function
pointer hv_read_reference_counter to read_hv_clock_tsc(); when
Hyper-V TSC page is not enabled, hv_read_reference_counter defaults to
be drivers/hv/hv_common.c: __hv_read_ref_counter(), which is suboptimal
as it uses the slow MSR interface to get the time info.

The attribute __bss_decrypted was added for a native SNP VM by the
commit 45f46b1ac95e ("clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp enlightened guest")

The attribute works for SNP because of the commit below
commit b3f0907c71e0 ("x86/mm: Add .bss..decrypted section to hold shared variables")

The attribute is not working for TDX because __startup_64() ->
sme_postprocess_startup() is not for TDX; we can't just call
set_memory_decrypted() in sme_postprocess_startup() because
sme_postprocess_startup() runs too early and set_memory_decrypted() is not
working there yet.

This RFC patch calls set_memory_decrypted() in a later place, i.e., in
start_kernel() -> setup_arch() -> init_hypervisor_platform() ->
ms_hyperv_init_platform(), so set_memory_decrypted() works there;
accordingly, mem_encrypt_free_decrypted_mem() -> set_memory_encrypted()
must be called for TDX now.

When a TDX VM runs in Partitioned TD mode (L2), the Hyper-V TSC page should
be a private page, so set_memory_decrypted() should not be called for the
page in such a VM. Introduce a global variable "tdx_partitioned_td_l2" to
handle this type of VM differently.

BTW, the 4KB Hyper-V TSC page is enabled very early in
hv_init_tsc_clocksource(), where set_memory_decrypted() is not working yet,
so we can't simply call set_memory_decrypted() in hv_init_tsc_clocksource()
for a TDX VM in TD mode, and we need to get the attribute __bss_decrypted
to work for such a VM.

The changes to arch/x86/kernel/cpu/mshyperv.c and
arch/x86/mm/mem_encrypt_amd.c are not satisfying to me. I wish there
could be a better way to support __bss_decrypted for a native TDX VM
so that a TDX VM on KVM could also benefit from __bss_decrypted, if
some one wants to use it in future. BTW, kvm_init_platform() has
similar code for SNP.

This is just a RFC patch. I apprecite your insight. Thanks!

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/coco/core.c           | 15 +++++++++++++++
 arch/x86/coco/tdx/tdx.c        |  2 ++
 arch/x86/hyperv/ivm.c          |  3 ++-
 arch/x86/include/asm/tdx.h     |  1 +
 arch/x86/kernel/cpu/mshyperv.c |  8 ++++++--
 arch/x86/mm/mem_encrypt_amd.c  |  3 ++-
 6 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index b31ef2424d194..61cec405f1084 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -15,6 +15,7 @@
 
 #include <asm/archrandom.h>
 #include <asm/coco.h>
+#include <asm/tdx.h>
 #include <asm/processor.h>
 
 enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
@@ -25,8 +26,22 @@ static struct cc_attr_flags {
 	      __resv		: 63;
 } cc_flags;
 
+static bool noinstr intel_cc_platform_td_l2(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
+	case CC_ATTR_MEM_ENCRYPT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool noinstr intel_cc_platform_has(enum cc_attr attr)
 {
+	if (tdx_partitioned_td_l2)
+		return intel_cc_platform_td_l2(attr);
+
 	switch (attr) {
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
 	case CC_ATTR_HOTPLUG_DISABLED:
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index abf3cd591afd3..8e6ab42add7c0 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -39,6 +39,8 @@
 
 #define TDREPORT_SUBTYPE_0	0
 
+bool tdx_partitioned_td_l2 __ro_after_init;
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 noinstr void __noreturn __tdx_hypercall_failed(void)
 {
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 768d73de0d098..52cd44e507846 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -626,7 +626,7 @@ static bool hv_is_private_mmio(u64 addr)
 	return false;
 }
 
-void __init hv_vtom_init(void)
+void __init hv_vtom_init(void) /* TODO: rename the function for TDX */
 {
 	enum hv_isolation_type type = hv_get_isolation_type();
 
@@ -650,6 +650,7 @@ void __init hv_vtom_init(void)
 
 	case HV_ISOLATION_TYPE_TDX:
 		cc_vendor = CC_VENDOR_INTEL;
+		tdx_partitioned_td_l2 = true;
 		break;
 
 	default:
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index eba178996d845..ddcc9ef82dc99 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -66,6 +66,7 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 
 u64 tdx_hcall_get_quote(u8 *buf, size_t size);
 
+extern bool tdx_partitioned_td_l2;
 #else
 
 static inline void tdx_early_init(void) { };
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a8ba840..7c336bc020c9f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -18,6 +18,7 @@
 #include <linux/kexec.h>
 #include <linux/i8253.h>
 #include <linux/random.h>
+#include <linux/set_memory.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
@@ -449,8 +450,11 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
 
 			if (!ms_hyperv.paravisor_present) {
-				/* To be supported: more work is required.  */
-				ms_hyperv.features &= ~HV_MSR_REFERENCE_TSC_AVAILABLE;
+				unsigned long vaddr = (unsigned long)__start_bss_decrypted;
+				unsigned long vaddr_end = (unsigned long)__end_bss_decrypted;
+
+				for (; vaddr < vaddr_end; vaddr += PMD_SIZE)
+					set_memory_decrypted(vaddr, PMD_SIZE >> PAGE_SHIFT);
 
 				/* HV_MSR_CRASH_CTL is unsupported. */
 				ms_hyperv.misc_features &= ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 422602f6039b8..0ddb9e5d222c3 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -25,6 +25,7 @@
 #include <asm/fixmap.h>
 #include <asm/setup.h>
 #include <asm/mem_encrypt.h>
+#include <asm/tdx.h>
 #include <asm/bootparam.h>
 #include <asm/set_memory.h>
 #include <asm/cacheflush.h>
@@ -529,7 +530,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
 	 * CC_ATTR_MEM_ENCRYPT, aren't necessarily equivalent in a Hyper-V VM
 	 * using vTOM, where sme_me_mask is always zero.
 	 */
-	if (sme_me_mask) {
+	if (sme_me_mask || (cc_vendor == CC_VENDOR_INTEL && !tdx_partitioned_td_l2)) {
 		r = set_memory_encrypted(vaddr, npages);
 		if (r) {
 			pr_warn("failed to free unused decrypted pages\n");
-- 
2.25.1


