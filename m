Return-Path: <linux-hyperv+bounces-657-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9917DF25B
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Nov 2023 13:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C44281B11
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Nov 2023 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7148618E06;
	Thu,  2 Nov 2023 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="BPZck9bN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9318E27
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Nov 2023 12:27:48 +0000 (UTC)
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F628DE;
	Thu,  2 Nov 2023 05:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1698928063;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Qt98FOOlwQXNEe7TmHLKYpigU0UohpmukrdSKsAE3SY=;
  b=BPZck9bN89YigFykclQ+LGZnqSwJ7qUGJUlCiWrOO+zrdnBdmEmuQ3Re
   LW+tl499fUA83FmxVGHHhQZ+gGVlXJre/E7dYd87m4vcTgQSVIQNZiG4y
   Uzf1x0wTXujV75Za1RvabWjRh6OA8McGWl18vIebMnPEcQ6yny6MRJm13
   A=;
X-CSE-ConnectionGUID: pNIzOpSTTbaXx/hvRfdv1w==
X-CSE-MsgGUID: TcvbfrE4S9OsAZL3//oPsQ==
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 126596384
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.159.70
X-Policy: $RELAYED
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:9S6LjKqzPLvuwfp7fBSi8xMKZDheBmJ/YxIvgKrLsJaIsI4StFCzt
 garIBnVbK3YNmTzL412b4+/9U8F6pPTy99gTgZp/CthF3tG85uZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbOCYmYpA1Y8FE/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKq04GhwUmAWP6gR5waHzyNNUPrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXACgrTwKkn9mK/LiyevkrhtoZIsX1ZZxK7xmMzRmBZRonaZXKQqGM7t5ExjYgwMtJGJ4yZ
 eJAN2ApNk6ZJUQSaxFIUPrSn8/x7pX7WxRepEiYuuwc5G/LwRYq+LPsLMDUapqBQsA9ckOw/
 ziYojWnWUFGXDCZ4QaO7HiinMKTpnLcQ6sgMOb/sflSm2TGkwT/DzVJDADm8JFVkHWWWM13L
 00S5zpopq83nGSxSdP9dx61uniJulgbQdU4O+ki6QyXw67V+AexBWUeSDNFLts8u6ceRTUrx
 1aPkMHBAD1kqrqOTnyBsLyTqFuaOjkOBWoDbjUDVgwL/5/op4Rbph7CRctiOKu0hcfyAjb+3
 3aBqy1Wr64PgNAGkbqy/VTvgyqh4JPOS2Yd5RTTUySg4xJ0fqalf4Hu4l/ehd5MLYOYUkOA+
 mMFhcGY7esOJZGVmWqGR+BlNKu0/O3DOTvQjER0GJ8J9yygvXWkeOh44ixlOEZvdMsefyT1S
 E/LtEVa45o7FGv6M4d0bpi3BsBsyrLvffz9UvnIYN1UZ919bg6Z8TsrdR7O937inVJqkqwlP
 5qfN8G2Ah4yDaVh0SrzX+wc+aEkyzp4xm7JQ53/iRO93tK2YH+TVKdAMEqWY/onxL2LrR+T8
 NtFMcaOjRJFX4XWaDH/+IoSIFZaa3Q2bbj6otJaMO6KJBFrHkklCvnM0fUgfZBom+JekeKg1
 nGlU2dK2Ub4nzvMLgDiQnVibrzodYxyoXIyIWonOlPA83IjbIKg5a4EX5QwerYj+apoyvscZ
 +UKf9WoBvVJVyjd/DIcfd/xoeRKeAqrjBiSFyujbiI2c5NpS0rO4NCMVgLp+DgmDyy5r8Iyr
 rSskATBTvIrQwVkEdaTa/+1yV61lWYSlfg0XEbSJNRXPkL2/+BCNCHwyPs2PukPJA/Fyz/c0
 ByZaSr0vsGU/dVzqoOQw/nZ/sH2S4OSA3a2AUHDy5ekEjHhwlapyL9QF+aWRz7RSjrrrfDKi
 fpu8x3sDBEWtA8U4tosQug3kP5WC8jH/eEAklo+dJnfRxH7Uuk+fyPuMdxn7/UVntdkVR2Kt
 lVjEzWwEZ6OIsrhWGUJPgsjYf/rORo8wWKKsq1dzKkX/kZKEFu7vaZ6ZULkZNR1ducdDW/c6
 b5JVDQqwwK+kAE2Fd2NkzpZ8W+BRlRZDfR35s9BXtG12lN7or2nXXA7InaoiKxjlv0VbxJ0S
 tNqrPGqa0tgKrrqLCNoSCmlMRt1jpUSohFapGI/y6CysoOd3JcfhUQBmQnbuywJln2rJcovY
 Dk0X6C0TI3SlwpVaD9rBjD1QVkYWk3DpCQcCTIhzQXkcqVhbUSVREVVBApH1BlxH750FtSDw
 Iyl9Q==
IronPort-HdrOrdr: A9a23:aWN29a+FdqhaJVFNY0Nuk+B1I+orL9Y04lQ7vn2ZhyY1TiX+rb
 HJoB17726StN91YhsdcL+7VZVoLUmxyXcx2/hzAV9NNDOWxFdAb7sSkLcL+lXbalLDH5dmpN
 ldmspFaOEYfGIK6foSuzPIaurIqePvmMuVbKXlvhVQpGdRBJ2IhD0JbzpzfHcZeOBuP+tJKL
 OsouRGuhu9cjAtYsygAH5tZZm4m/T70LznfD8bDFod5AOPlDOl76OSKWni4j4uFx1O3JY/+i
 z/nwb4/6WutOz+4hLQzGPI9f1t6ajc4+oGKsyQq9Qfbg/hjQulf+1aKsW/lT04uvyu7142kN
 /KuX4bTrRO108=
X-Talos-CUID: 9a23:uxNYUmNbRDlVHe5DQA9G5mkMIfwZeHTt3DDQPXW2BXgwV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3Aa9s5vg7jLNLcXFC0q5hRT2xLxoxU6LqkBlogza5?=
 =?us-ascii?q?XnNKtBwgrfHCatC+OF9o=3D?=
X-IronPort-AV: E=Sophos;i="6.03,271,1694750400"; 
   d="scan'208";a="126596384"
From: Andrew Cooper <andrew.cooper3@citrix.com>
Date: Thu, 2 Nov 2023 12:26:21 +0000
Subject: [PATCH 3/3] x86/apic: Drop struct local_apic
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231102-x86-apic-v1-3-bf049a2a0ed6@citrix.com>
References: <20231102-x86-apic-v1-0-bf049a2a0ed6@citrix.com>
In-Reply-To: <20231102-x86-apic-v1-0-bf049a2a0ed6@citrix.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Steve Wahl
	<steve.wahl@hpe.com>, Justin Ernst <justin.ernst@hpe.com>, Kyle Meyer
	<kyle.meyer@hpe.com>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, "Russ
 Anderson" <russ.anderson@hpe.com>, Darren Hart <dvhart@infradead.org>, "Andy
 Shevchenko" <andy@infradead.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "Dexuan
 Cui" <decui@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>
X-Mailer: b4 0.12.4

This type predates recorded history in tglx/history.git, making it older
than Feb 5th 2002.

This structure is literally old enough to drink in most juristictions in
the world, and has not been used once in that time.

Lay it to rest in /dev/null.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
There is perhaps something to be said for the longevity of the comment.
"Not terribly well tested" certainly hasn't bitrotted in all this time.
---
 arch/x86/include/asm/apicdef.h | 260 -----------------------------------------
 1 file changed, 260 deletions(-)

diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index ddcbf00db19d..094106b6a538 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -172,270 +172,10 @@
 #define APIC_CPUID(apicid)	((apicid) & XAPIC_DEST_CPUS_MASK)
 #define NUM_APIC_CLUSTERS	((BAD_APICID + 1) >> XAPIC_DEST_CPUS_SHIFT)
 
-#ifndef __ASSEMBLY__
-/*
- * the local APIC register structure, memory mapped. Not terribly well
- * tested, but we might eventually use this one in the future - the
- * problem why we cannot use it right now is the P5 APIC, it has an
- * errata which cannot take 8-bit reads and writes, only 32-bit ones ...
- */
-#define u32 unsigned int
-
-struct local_apic {
-
-/*000*/	struct { u32 __reserved[4]; } __reserved_01;
-
-/*010*/	struct { u32 __reserved[4]; } __reserved_02;
-
-/*020*/	struct { /* APIC ID Register */
-		u32   __reserved_1	: 24,
-			phys_apic_id	:  4,
-			__reserved_2	:  4;
-		u32 __reserved[3];
-	} id;
-
-/*030*/	const
-	struct { /* APIC Version Register */
-		u32   version		:  8,
-			__reserved_1	:  8,
-			max_lvt		:  8,
-			__reserved_2	:  8;
-		u32 __reserved[3];
-	} version;
-
-/*040*/	struct { u32 __reserved[4]; } __reserved_03;
-
-/*050*/	struct { u32 __reserved[4]; } __reserved_04;
-
-/*060*/	struct { u32 __reserved[4]; } __reserved_05;
-
-/*070*/	struct { u32 __reserved[4]; } __reserved_06;
-
-/*080*/	struct { /* Task Priority Register */
-		u32   priority	:  8,
-			__reserved_1	: 24;
-		u32 __reserved_2[3];
-	} tpr;
-
-/*090*/	const
-	struct { /* Arbitration Priority Register */
-		u32   priority	:  8,
-			__reserved_1	: 24;
-		u32 __reserved_2[3];
-	} apr;
-
-/*0A0*/	const
-	struct { /* Processor Priority Register */
-		u32   priority	:  8,
-			__reserved_1	: 24;
-		u32 __reserved_2[3];
-	} ppr;
-
-/*0B0*/	struct { /* End Of Interrupt Register */
-		u32   eoi;
-		u32 __reserved[3];
-	} eoi;
-
-/*0C0*/	struct { u32 __reserved[4]; } __reserved_07;
-
-/*0D0*/	struct { /* Logical Destination Register */
-		u32   __reserved_1	: 24,
-			logical_dest	:  8;
-		u32 __reserved_2[3];
-	} ldr;
-
-/*0E0*/	struct { /* Destination Format Register */
-		u32   __reserved_1	: 28,
-			model		:  4;
-		u32 __reserved_2[3];
-	} dfr;
-
-/*0F0*/	struct { /* Spurious Interrupt Vector Register */
-		u32	spurious_vector	:  8,
-			apic_enabled	:  1,
-			focus_cpu	:  1,
-			__reserved_2	: 22;
-		u32 __reserved_3[3];
-	} svr;
-
-/*100*/	struct { /* In Service Register */
-/*170*/		u32 bitfield;
-		u32 __reserved[3];
-	} isr [8];
-
-/*180*/	struct { /* Trigger Mode Register */
-/*1F0*/		u32 bitfield;
-		u32 __reserved[3];
-	} tmr [8];
-
-/*200*/	struct { /* Interrupt Request Register */
-/*270*/		u32 bitfield;
-		u32 __reserved[3];
-	} irr [8];
-
-/*280*/	union { /* Error Status Register */
-		struct {
-			u32   send_cs_error			:  1,
-				receive_cs_error		:  1,
-				send_accept_error		:  1,
-				receive_accept_error		:  1,
-				__reserved_1			:  1,
-				send_illegal_vector		:  1,
-				receive_illegal_vector		:  1,
-				illegal_register_address	:  1,
-				__reserved_2			: 24;
-			u32 __reserved_3[3];
-		} error_bits;
-		struct {
-			u32 errors;
-			u32 __reserved_3[3];
-		} all_errors;
-	} esr;
-
-/*290*/	struct { u32 __reserved[4]; } __reserved_08;
-
-/*2A0*/	struct { u32 __reserved[4]; } __reserved_09;
-
-/*2B0*/	struct { u32 __reserved[4]; } __reserved_10;
-
-/*2C0*/	struct { u32 __reserved[4]; } __reserved_11;
-
-/*2D0*/	struct { u32 __reserved[4]; } __reserved_12;
-
-/*2E0*/	struct { u32 __reserved[4]; } __reserved_13;
-
-/*2F0*/	struct { u32 __reserved[4]; } __reserved_14;
-
-/*300*/	struct { /* Interrupt Command Register 1 */
-		u32   vector			:  8,
-			delivery_mode		:  3,
-			destination_mode	:  1,
-			delivery_status		:  1,
-			__reserved_1		:  1,
-			level			:  1,
-			trigger			:  1,
-			__reserved_2		:  2,
-			shorthand		:  2,
-			__reserved_3		:  12;
-		u32 __reserved_4[3];
-	} icr1;
-
-/*310*/	struct { /* Interrupt Command Register 2 */
-		union {
-			u32   __reserved_1	: 24,
-				phys_dest	:  4,
-				__reserved_2	:  4;
-			u32   __reserved_3	: 24,
-				logical_dest	:  8;
-		} dest;
-		u32 __reserved_4[3];
-	} icr2;
-
-/*320*/	struct { /* LVT - Timer */
-		u32   vector		:  8,
-			__reserved_1	:  4,
-			delivery_status	:  1,
-			__reserved_2	:  3,
-			mask		:  1,
-			timer_mode	:  1,
-			__reserved_3	: 14;
-		u32 __reserved_4[3];
-	} lvt_timer;
-
-/*330*/	struct { /* LVT - Thermal Sensor */
-		u32  vector		:  8,
-			delivery_mode	:  3,
-			__reserved_1	:  1,
-			delivery_status	:  1,
-			__reserved_2	:  3,
-			mask		:  1,
-			__reserved_3	: 15;
-		u32 __reserved_4[3];
-	} lvt_thermal;
-
-/*340*/	struct { /* LVT - Performance Counter */
-		u32   vector		:  8,
-			delivery_mode	:  3,
-			__reserved_1	:  1,
-			delivery_status	:  1,
-			__reserved_2	:  3,
-			mask		:  1,
-			__reserved_3	: 15;
-		u32 __reserved_4[3];
-	} lvt_pc;
-
-/*350*/	struct { /* LVT - LINT0 */
-		u32   vector		:  8,
-			delivery_mode	:  3,
-			__reserved_1	:  1,
-			delivery_status	:  1,
-			polarity	:  1,
-			remote_irr	:  1,
-			trigger		:  1,
-			mask		:  1,
-			__reserved_2	: 15;
-		u32 __reserved_3[3];
-	} lvt_lint0;
-
-/*360*/	struct { /* LVT - LINT1 */
-		u32   vector		:  8,
-			delivery_mode	:  3,
-			__reserved_1	:  1,
-			delivery_status	:  1,
-			polarity	:  1,
-			remote_irr	:  1,
-			trigger		:  1,
-			mask		:  1,
-			__reserved_2	: 15;
-		u32 __reserved_3[3];
-	} lvt_lint1;
-
-/*370*/	struct { /* LVT - Error */
-		u32   vector		:  8,
-			__reserved_1	:  4,
-			delivery_status	:  1,
-			__reserved_2	:  3,
-			mask		:  1,
-			__reserved_3	: 15;
-		u32 __reserved_4[3];
-	} lvt_error;
-
-/*380*/	struct { /* Timer Initial Count Register */
-		u32   initial_count;
-		u32 __reserved_2[3];
-	} timer_icr;
-
-/*390*/	const
-	struct { /* Timer Current Count Register */
-		u32   curr_count;
-		u32 __reserved_2[3];
-	} timer_ccr;
-
-/*3A0*/	struct { u32 __reserved[4]; } __reserved_16;
-
-/*3B0*/	struct { u32 __reserved[4]; } __reserved_17;
-
-/*3C0*/	struct { u32 __reserved[4]; } __reserved_18;
-
-/*3D0*/	struct { u32 __reserved[4]; } __reserved_19;
-
-/*3E0*/	struct { /* Timer Divide Configuration Register */
-		u32   divisor		:  4,
-			__reserved_1	: 28;
-		u32 __reserved_2[3];
-	} timer_dcr;
-
-/*3F0*/	struct { u32 __reserved[4]; } __reserved_20;
-
-} __attribute__ ((packed));
-
-#undef u32
-
 #ifdef CONFIG_X86_32
  #define BAD_APICID 0xFFu
 #else
  #define BAD_APICID 0xFFFFu
 #endif
 
-#endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_APICDEF_H */

-- 
2.30.2


