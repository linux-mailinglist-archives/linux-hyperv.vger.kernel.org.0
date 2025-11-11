Return-Path: <linux-hyperv+bounces-7496-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F1FC4D4FC
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 12:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE0D18840D6
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 11:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD6034D4CE;
	Tue, 11 Nov 2025 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XJSnNMiZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3CC1E7C23;
	Tue, 11 Nov 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858718; cv=none; b=PKbzHVwU8G409psA1C6GJs/06wdDiyDtcLEytTcHGVCGBvnV7N/IKGiBqpeuk9prso6E7PELKkuqUKWFwyCw0W3dpj9aF2mPWIaENgYMbw1W/LWMvdC8j4EwlI3SPJz7SX4gGcMEnxiTsZYOY+nw+dtMP5XtNGGDLoFG42aaTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858718; c=relaxed/simple;
	bh=uUnRDveYYUG8h2W7Ve9OXGR6zDjNcTnt5B3GUcmiOJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXL8ryr8X/FLT3qRRkm0fvG897ir1ejbMYv5gP1syF5HkaMl20GCuCmiZVub3qQuiJLX334+JEMkhVuHDQFSm9WLgst6Q5F+Q829BDGjUy12Vd/YMuKPcg8ozr0BBErnmVQ6gJtiy5Zy2pn9QEXxhB6c60r9mWLfy+E09x6X0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XJSnNMiZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.76.239] (unknown [167.220.238.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 788ED212AE4A;
	Tue, 11 Nov 2025 02:58:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 788ED212AE4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762858716;
	bh=lxMOwW9SB8M+Lbun3eP5l2Z0meMTWQqIetqoa4G9uOs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XJSnNMiZNyStUOYaPsWDVDJ/3GJclEU3t482knUUsLgn16qDMojI1471W0DQRX+R/
	 c2o1ZgS2IZeFb2ruHiNuWYtJWmJJAmpuB4+A56wDWsUwMeb4Bw2XWgwahoJgexa5Yy
	 CYTP19E+FW8vc6mmwDAtspKKkaUor5gP8LA284hY=
Message-ID: <5788c77f-fbb7-43e9-bfcb-7c0b103ca301@linux.microsoft.com>
Date: Tue, 11 Nov 2025 16:28:27 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Michael Kelley <mhklinux@outlook.com>,
 Mukesh Rathor <mrathor@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Christoph Hellwig <hch@infradead.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>
References: <20251110050835.1603847-1-namjain@linux.microsoft.com>
 <20251110050835.1603847-3-namjain@linux.microsoft.com>
 <20251110143834.GA3245006@noisy.programming.kicks-ass.net>
 <f32292e6-b152-4d6d-b678-fc46b8e3d1ac@linux.microsoft.com>
 <20251111081352.GD278048@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20251111081352.GD278048@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/11/2025 1:43 PM, Peter Zijlstra wrote:
> On Tue, Nov 11, 2025 at 12:25:54PM +0530, Naman Jain wrote:
> 
>> This would have been the cleanest approach. We discussed this before and
>> unfortunately it didn't work. Please find the link to this discussion:
>>
>> https://lore.kernel.org/all/9f8007a3-f810-4b60-8942-e721cd6a32c4@linux.microsoft.com/
>>
>> To summarize above discussion, I see below compilation error with this from
>> objtool. You may have CONFIG_X86_KERNEL_IBT enabled in your workspace, which
>> would have masked this.
> 
> IBT isn't the problem, the thing is running objtool on vmlinux.o vs the
> individual translation units. vmlinux.o will have that symbol, while
> your .S file doesn't.
> 
>>    AS      arch/x86/hyperv/mshv_vtl_asm.o
>> arch/x86/hyperv/mshv_vtl_asm.o: error: objtool: static_call: can't find
>> static_call_key symbol: __SCK____mshv_vtl_return_hypercall
> 
> Right, and I said you had to do that ADDRESSABLE thing. So I added a
> DECLARE_STATIC_CALL() and a static_call() in hv.c, compiled it so .s and
> stole the bits.
> 
> And then you get something like the below. See symbol 5, that's the
> entry we need.
> 
> # readelf -sW defconfig-build/arch/x86/hyperv/mshv_vtl_asm.o
> 
> Symbol table '.symtab' contains 8 entries:
>     Num:    Value          Size Type    Bind   Vis      Ndx Name
>       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
>       1: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    6 __UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0
>       2: 0000000000000000     0 SECTION LOCAL  DEFAULT    4 .noinstr.text
>       3: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __SCT____mshv_vtl_return_hypercall
>       4: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __x86_return_thunk
>       5: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __SCK____mshv_vtl_return_hypercall
>       6: 0000000000000010   179 FUNC    GLOBAL DEFAULT    4 __mshv_vtl_return_call
>       7: 0000000000000000    16 FUNC    GLOBAL DEFAULT    4 __pfx___mshv_vtl_return_call
> 
> 
> ---


Thanks a lot for sharing the changes. I tested this and it works fine. I 
can create a separate patch for the include/linux/* changes and add it 
as the first patch in the next version of my patch series.

Please let me know if this is fine and if I can add your Signed-off-by 
in that patch.

Regards,
Naman


