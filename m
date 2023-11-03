Return-Path: <linux-hyperv+bounces-687-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AD27E0A09
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 21:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F232C281F62
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 20:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223E023753;
	Fri,  3 Nov 2023 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="mEea6OpQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203792110F
	for <linux-hyperv@vger.kernel.org>; Fri,  3 Nov 2023 20:17:16 +0000 (UTC)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B38D53;
	Fri,  3 Nov 2023 13:17:14 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3InJ4f001508;
	Fri, 3 Nov 2023 20:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=D51GjDb7/ozAJNlUYKNTwI4ApLuMChHWlUEbM3CJ6no=;
 b=mEea6OpQ4GyhnF36+uGnR03Vx1ICKSCu6OxzE4yX+cbJ6lZDumNQVs6DbbTD0A9eauyy
 g6s7jyvesL+yGSqFNIBsyeUJbdgqwdLPEY8MwMl8hF7MOl9/csH654p4dyiL76pXjgB8
 vC+8zIVu1RbFbKK/ZBcfPojc9qgCiE/GS9pPEMGxRezsZQy60BECCIGxJ1gJu0bgdYK9
 PbqRsZNXlnd+ZBL8vX6IhuGbHX8Lx5+2U9T+v9uxqxyBZrvHl9Cjr6P297DOTnBfeqxS
 mJWs0TSX/DU4HShDVVjcAhARK9Uz3ucTScaxKKlyDeCErEBC8hqCaKVSoDmw2eNLmLIi Sw== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3u4twf02jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Nov 2023 20:16:51 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 7C11E13197;
	Fri,  3 Nov 2023 20:16:43 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id CD82A80045D;
	Fri,  3 Nov 2023 20:16:39 +0000 (UTC)
Date: Fri, 3 Nov 2023 15:16:38 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/apic: Drop struct local_apic
Message-ID: <ZUVVJkpGg4hoF/Hs@swahl-home.5wahls.com>
References: <20231102-x86-apic-v1-0-bf049a2a0ed6@citrix.com>
 <20231102-x86-apic-v1-3-bf049a2a0ed6@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102-x86-apic-v1-3-bf049a2a0ed6@citrix.com>
X-Proofpoint-ORIG-GUID: kxI0VjgnmO0WDNPr5wrLa66Msn4A28Gw
X-Proofpoint-GUID: kxI0VjgnmO0WDNPr5wrLa66Msn4A28Gw
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_19,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030170

On Thu, Nov 02, 2023 at 12:26:21PM +0000, Andrew Cooper wrote:
> This type predates recorded history in tglx/history.git, making it older
> than Feb 5th 2002.
> 
> This structure is literally old enough to drink in most juristictions in
> the world, and has not been used once in that time.
> 
> Lay it to rest in /dev/null.
> 
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> ---
> There is perhaps something to be said for the longevity of the comment.
> "Not terribly well tested" certainly hasn't bitrotted in all this time.

   :-)  !!!

Reveiewed-by: Steve Wahl <steve.wahl@hpe.com>


> ---
>  arch/x86/include/asm/apicdef.h | 260 -----------------------------------------
>  1 file changed, 260 deletions(-)
> 
> diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
> index ddcbf00db19d..094106b6a538 100644
> --- a/arch/x86/include/asm/apicdef.h
> +++ b/arch/x86/include/asm/apicdef.h
> @@ -172,270 +172,10 @@
>  #define APIC_CPUID(apicid)	((apicid) & XAPIC_DEST_CPUS_MASK)
>  #define NUM_APIC_CLUSTERS	((BAD_APICID + 1) >> XAPIC_DEST_CPUS_SHIFT)
>  
> -#ifndef __ASSEMBLY__
> -/*
> - * the local APIC register structure, memory mapped. Not terribly well
> - * tested, but we might eventually use this one in the future - the
> - * problem why we cannot use it right now is the P5 APIC, it has an
> - * errata which cannot take 8-bit reads and writes, only 32-bit ones ...
> - */
> -#define u32 unsigned int
> -
> -struct local_apic {
> -
> -/*000*/	struct { u32 __reserved[4]; } __reserved_01;
> -
> -/*010*/	struct { u32 __reserved[4]; } __reserved_02;
> -
> -/*020*/	struct { /* APIC ID Register */
> -		u32   __reserved_1	: 24,
> -			phys_apic_id	:  4,
> -			__reserved_2	:  4;
> -		u32 __reserved[3];
> -	} id;
> -
> -/*030*/	const
> -	struct { /* APIC Version Register */
> -		u32   version		:  8,
> -			__reserved_1	:  8,
> -			max_lvt		:  8,
> -			__reserved_2	:  8;
> -		u32 __reserved[3];
> -	} version;
> -
> -/*040*/	struct { u32 __reserved[4]; } __reserved_03;
> -
> -/*050*/	struct { u32 __reserved[4]; } __reserved_04;
> -
> -/*060*/	struct { u32 __reserved[4]; } __reserved_05;
> -
> -/*070*/	struct { u32 __reserved[4]; } __reserved_06;
> -
> -/*080*/	struct { /* Task Priority Register */
> -		u32   priority	:  8,
> -			__reserved_1	: 24;
> -		u32 __reserved_2[3];
> -	} tpr;
> -
> -/*090*/	const
> -	struct { /* Arbitration Priority Register */
> -		u32   priority	:  8,
> -			__reserved_1	: 24;
> -		u32 __reserved_2[3];
> -	} apr;
> -
> -/*0A0*/	const
> -	struct { /* Processor Priority Register */
> -		u32   priority	:  8,
> -			__reserved_1	: 24;
> -		u32 __reserved_2[3];
> -	} ppr;
> -
> -/*0B0*/	struct { /* End Of Interrupt Register */
> -		u32   eoi;
> -		u32 __reserved[3];
> -	} eoi;
> -
> -/*0C0*/	struct { u32 __reserved[4]; } __reserved_07;
> -
> -/*0D0*/	struct { /* Logical Destination Register */
> -		u32   __reserved_1	: 24,
> -			logical_dest	:  8;
> -		u32 __reserved_2[3];
> -	} ldr;
> -
> -/*0E0*/	struct { /* Destination Format Register */
> -		u32   __reserved_1	: 28,
> -			model		:  4;
> -		u32 __reserved_2[3];
> -	} dfr;
> -
> -/*0F0*/	struct { /* Spurious Interrupt Vector Register */
> -		u32	spurious_vector	:  8,
> -			apic_enabled	:  1,
> -			focus_cpu	:  1,
> -			__reserved_2	: 22;
> -		u32 __reserved_3[3];
> -	} svr;
> -
> -/*100*/	struct { /* In Service Register */
> -/*170*/		u32 bitfield;
> -		u32 __reserved[3];
> -	} isr [8];
> -
> -/*180*/	struct { /* Trigger Mode Register */
> -/*1F0*/		u32 bitfield;
> -		u32 __reserved[3];
> -	} tmr [8];
> -
> -/*200*/	struct { /* Interrupt Request Register */
> -/*270*/		u32 bitfield;
> -		u32 __reserved[3];
> -	} irr [8];
> -
> -/*280*/	union { /* Error Status Register */
> -		struct {
> -			u32   send_cs_error			:  1,
> -				receive_cs_error		:  1,
> -				send_accept_error		:  1,
> -				receive_accept_error		:  1,
> -				__reserved_1			:  1,
> -				send_illegal_vector		:  1,
> -				receive_illegal_vector		:  1,
> -				illegal_register_address	:  1,
> -				__reserved_2			: 24;
> -			u32 __reserved_3[3];
> -		} error_bits;
> -		struct {
> -			u32 errors;
> -			u32 __reserved_3[3];
> -		} all_errors;
> -	} esr;
> -
> -/*290*/	struct { u32 __reserved[4]; } __reserved_08;
> -
> -/*2A0*/	struct { u32 __reserved[4]; } __reserved_09;
> -
> -/*2B0*/	struct { u32 __reserved[4]; } __reserved_10;
> -
> -/*2C0*/	struct { u32 __reserved[4]; } __reserved_11;
> -
> -/*2D0*/	struct { u32 __reserved[4]; } __reserved_12;
> -
> -/*2E0*/	struct { u32 __reserved[4]; } __reserved_13;
> -
> -/*2F0*/	struct { u32 __reserved[4]; } __reserved_14;
> -
> -/*300*/	struct { /* Interrupt Command Register 1 */
> -		u32   vector			:  8,
> -			delivery_mode		:  3,
> -			destination_mode	:  1,
> -			delivery_status		:  1,
> -			__reserved_1		:  1,
> -			level			:  1,
> -			trigger			:  1,
> -			__reserved_2		:  2,
> -			shorthand		:  2,
> -			__reserved_3		:  12;
> -		u32 __reserved_4[3];
> -	} icr1;
> -
> -/*310*/	struct { /* Interrupt Command Register 2 */
> -		union {
> -			u32   __reserved_1	: 24,
> -				phys_dest	:  4,
> -				__reserved_2	:  4;
> -			u32   __reserved_3	: 24,
> -				logical_dest	:  8;
> -		} dest;
> -		u32 __reserved_4[3];
> -	} icr2;
> -
> -/*320*/	struct { /* LVT - Timer */
> -		u32   vector		:  8,
> -			__reserved_1	:  4,
> -			delivery_status	:  1,
> -			__reserved_2	:  3,
> -			mask		:  1,
> -			timer_mode	:  1,
> -			__reserved_3	: 14;
> -		u32 __reserved_4[3];
> -	} lvt_timer;
> -
> -/*330*/	struct { /* LVT - Thermal Sensor */
> -		u32  vector		:  8,
> -			delivery_mode	:  3,
> -			__reserved_1	:  1,
> -			delivery_status	:  1,
> -			__reserved_2	:  3,
> -			mask		:  1,
> -			__reserved_3	: 15;
> -		u32 __reserved_4[3];
> -	} lvt_thermal;
> -
> -/*340*/	struct { /* LVT - Performance Counter */
> -		u32   vector		:  8,
> -			delivery_mode	:  3,
> -			__reserved_1	:  1,
> -			delivery_status	:  1,
> -			__reserved_2	:  3,
> -			mask		:  1,
> -			__reserved_3	: 15;
> -		u32 __reserved_4[3];
> -	} lvt_pc;
> -
> -/*350*/	struct { /* LVT - LINT0 */
> -		u32   vector		:  8,
> -			delivery_mode	:  3,
> -			__reserved_1	:  1,
> -			delivery_status	:  1,
> -			polarity	:  1,
> -			remote_irr	:  1,
> -			trigger		:  1,
> -			mask		:  1,
> -			__reserved_2	: 15;
> -		u32 __reserved_3[3];
> -	} lvt_lint0;
> -
> -/*360*/	struct { /* LVT - LINT1 */
> -		u32   vector		:  8,
> -			delivery_mode	:  3,
> -			__reserved_1	:  1,
> -			delivery_status	:  1,
> -			polarity	:  1,
> -			remote_irr	:  1,
> -			trigger		:  1,
> -			mask		:  1,
> -			__reserved_2	: 15;
> -		u32 __reserved_3[3];
> -	} lvt_lint1;
> -
> -/*370*/	struct { /* LVT - Error */
> -		u32   vector		:  8,
> -			__reserved_1	:  4,
> -			delivery_status	:  1,
> -			__reserved_2	:  3,
> -			mask		:  1,
> -			__reserved_3	: 15;
> -		u32 __reserved_4[3];
> -	} lvt_error;
> -
> -/*380*/	struct { /* Timer Initial Count Register */
> -		u32   initial_count;
> -		u32 __reserved_2[3];
> -	} timer_icr;
> -
> -/*390*/	const
> -	struct { /* Timer Current Count Register */
> -		u32   curr_count;
> -		u32 __reserved_2[3];
> -	} timer_ccr;
> -
> -/*3A0*/	struct { u32 __reserved[4]; } __reserved_16;
> -
> -/*3B0*/	struct { u32 __reserved[4]; } __reserved_17;
> -
> -/*3C0*/	struct { u32 __reserved[4]; } __reserved_18;
> -
> -/*3D0*/	struct { u32 __reserved[4]; } __reserved_19;
> -
> -/*3E0*/	struct { /* Timer Divide Configuration Register */
> -		u32   divisor		:  4,
> -			__reserved_1	: 28;
> -		u32 __reserved_2[3];
> -	} timer_dcr;
> -
> -/*3F0*/	struct { u32 __reserved[4]; } __reserved_20;
> -
> -} __attribute__ ((packed));
> -
> -#undef u32
> -
>  #ifdef CONFIG_X86_32
>   #define BAD_APICID 0xFFu
>  #else
>   #define BAD_APICID 0xFFFFu
>  #endif
>  
> -#endif /* !__ASSEMBLY__ */
>  #endif /* _ASM_X86_APICDEF_H */
> 
> -- 
> 2.30.2
> 

-- 
Steve Wahl, Hewlett Packard Enterprise

