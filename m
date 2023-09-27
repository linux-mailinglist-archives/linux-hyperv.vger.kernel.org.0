Return-Path: <linux-hyperv+bounces-291-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17257B0756
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Sep 2023 16:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5213F28132D
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Sep 2023 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A2F31A98;
	Wed, 27 Sep 2023 14:52:56 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8561846
	for <linux-hyperv@vger.kernel.org>; Wed, 27 Sep 2023 14:52:54 +0000 (UTC)
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F7BF5;
	Wed, 27 Sep 2023 07:52:52 -0700 (PDT)
Received: from [127.0.0.1] ([98.35.210.218])
	(authenticated bits=0)
	by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 38REpsBI2813248
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 27 Sep 2023 07:51:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 38REpsBI2813248
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023091101; t=1695826316;
	bh=MhJAHO9v2jzk2PvwqyNGETAyG1UpCoLntbh2yXQZUBo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=aMHkj4DOv6DVKNQ2jE/JqTDv2qBKCKxAShqmzZ7y7C+Zw/OitN+OuLKpupSaDjwJz
	 vTeT5e4dp5j+0WoGrSNvIE+EYfKhq/Gbny4pLZzhEX0Z9E48d2Uo8zrv3W/biN0xWK
	 3nyBImm5pKOvKWPV+Qe000I/N5m43n7LNsOG2JUPA3iYHFO+sLliz82f5g/4SakiEz
	 OQR2CAx3IaHTxan5Pu6I1KGdyw27lHWo8cyikgm37DNdsPcruVzwRsapJKcnsJk9JW
	 I+g+vN1DXdpNzgIPOIV7Eu/zalBGDTREa5xWlPpQbACtoARZonM7Lecng3qmQMWZzr
	 eWmUR/REs6aOg==
Date: Wed, 27 Sep 2023 07:51:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Xin Li <xin3.li@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
        pbonzini@redhat.com, seanjc@google.com, peterz@infradead.org,
        jgross@suse.com, ravi.v.shankar@intel.com, mhiramat@kernel.org,
        andrew.cooper3@citrix.com, jiangshanlai@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v11_05/37=5D_x86/trapnr=3A_Ad?= =?US-ASCII?Q?d_event_type_macros_to_=3Casm/trapnr=2Eh=3E?=
User-Agent: K-9 Mail for Android
In-Reply-To: <7acd7bb3-0406-4fd9-8396-835bfd951d87@suse.com>
References: <20230923094212.26520-1-xin3.li@intel.com> <20230923094212.26520-6-xin3.li@intel.com> <7acd7bb3-0406-4fd9-8396-835bfd951d87@suse.com>
Message-ID: <22A5EA90-8B57-4376-BAE2-0FE982DF4E90@zytor.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On September 26, 2023 1:10:51 AM PDT, Nikolay Borisov <nik=2Eborisov@suse=
=2Ecom> wrote:
>
>
>On 23=2E09=2E23 =D0=B3=2E 12:41 =D1=87=2E, Xin Li wrote:
>> Intel VT-x classifies events into eight different types, which is
>> inherited by FRED for event identification=2E As such, event type
>> becomes a common x86 concept, and should be defined in a common x86
>> header=2E
>>=20
>> Add event type macros to <asm/trapnr=2Eh>, and use it in <asm/vmx=2Eh>=
=2E
>>=20
>> Suggested-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>> Tested-by: Shan Kang <shan=2Ekang@intel=2Ecom>
>> Signed-off-by: Xin Li <xin3=2Eli@intel=2Ecom>
>> ---
>>=20
>> Changes since v10:
>> * A few comment fixes and improvements (Andrew Cooper)=2E
>> ---
>>   arch/x86/include/asm/trapnr=2Eh | 12 ++++++++++++
>>   arch/x86/include/asm/vmx=2Eh    | 17 +++++++++--------
>>   2 files changed, 21 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/arch/x86/include/asm/trapnr=2Eh b/arch/x86/include/asm/tra=
pnr=2Eh
>> index f5d2325aa0b7=2E=2E8d1154cdf787 100644
>> --- a/arch/x86/include/asm/trapnr=2Eh
>> +++ b/arch/x86/include/asm/trapnr=2Eh
>> @@ -2,6 +2,18 @@
>>   #ifndef _ASM_X86_TRAPNR_H
>>   #define _ASM_X86_TRAPNR_H
>>   +/*
>> + * Event type codes used by FRED, Intel VT-x and AMD SVM
>> + */
>> +#define EVENT_TYPE_EXTINT	0	// External interrupt
>> +#define EVENT_TYPE_RESERVED	1
>> +#define EVENT_TYPE_NMI		2	// NMI
>> +#define EVENT_TYPE_HWEXC	3	// Hardware originated traps, exceptions
>> +#define EVENT_TYPE_SWINT	4	// INT n
>> +#define EVENT_TYPE_PRIV_SWEXC	5	// INT1
>> +#define EVENT_TYPE_SWEXC	6	// INTO, INT3
>
>nit: This turned into INTO (Oh) rather than INT0( zero) in v11
>
><nit>

INTO (letter) is correct=2E

