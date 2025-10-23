Return-Path: <linux-hyperv+bounces-7313-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CACC021D3
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 17:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C4C3AC1D6
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ECC3385AF;
	Thu, 23 Oct 2025 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="El791BPw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF6A3385B3;
	Thu, 23 Oct 2025 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232906; cv=none; b=RItlGbAiLWi69RSKGQZsrIJMd8fjlQSbVELvGqQ411QbV8xlTFdTIYMZ0JC5aTQr5owIBHK3lW129HIuOjLuckChwoPFEzPaeuaSkzhQKF1Gh+kS2ULnqL8qVwt7pNzGpF0nq3dzSWLfDW0FXrUv2G8t05T8xIoALytCTHElQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232906; c=relaxed/simple;
	bh=Py1H9BtYJNnlOXcTky/cHvzK7ZOHkwlwPFQcY7GBHUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dhe9YMNaky+R4a+vDqoxqduhTIqifiydbOGLIN5D/l/137m6MhPJPIqEaaZsAXYHBKVufnm8Eg/+vIY5xNpJ40hQe9KNjs6oyXjsN+j/H1pqSV3RGtPbadRcu0mxVdtBDSjwQI7Fe32q6jCuoqW92ncEul2CSXDEmfdHn/dhkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=El791BPw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.64.46] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id C97E7201725B;
	Thu, 23 Oct 2025 08:21:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C97E7201725B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761232903;
	bh=7yByHz4nEOFScL3ZiG5hNxqEWRfpfTW2wTv+vbIobVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=El791BPwoua1G3ocRSGRiLZ2zQGhsfmDjWNUfx/4wD9B7M0ZprVUfJVsnR/Hn9z4b
	 XyYJE4izAF+hQwVYCADiYn3uvxifNhFtqUzIClQFAlku0Q5Amn9nDB+Wya7hni26NU
	 tumIWVea5pX3raKC5VXAdqdI/AJsuJOoER7oaHHM=
Message-ID: <0f9f9d71-d12a-4b52-8477-46a66a534eda@linux.microsoft.com>
Date: Thu, 23 Oct 2025 20:51:35 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] Drivers: hv: Introduce new driver - mshv_vtl
To: Michael Kelley <mhklinux@outlook.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 Mukesh Rathor <mrathor@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Christoph Hellwig <hch@infradead.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>
References: <20251017074507.142704-1-namjain@linux.microsoft.com>
 <SN6PR02MB4157AE454F412993BC1D4BFDD4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157AE454F412993BC1D4BFDD4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/18/2025 12:02 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Friday, October 17, 2025 12:45 AM
>>
>> Introduce a new mshv_vtl driver to provide an interface for Virtual
>> Machine Monitor like OpenVMM and its use as OpenHCL paravisor to
>> control VTL0 (Virtual trust Level).
>> Expose devices and support IOCTLs for features like VTL creation,
>> VTL0 memory management, context switch, making hypercalls,
>> mapping VTL0 address space to VTL2 userspace, getting new VMBus
>> messages and channel events in VTL2 etc.
>>
>> OpenVMM : https://openvmm.dev/guide/
>>
>> Changes since v8:
>> https://lore.kernel.org/all/20251013060353.67326-1-namjain@linux.microsoft.com/
>> Addressed Sean's comments:
>> * Removed forcing SIGPENDING, and other minor changes, in
>>    mshv_vtl_ioctl_return_to_lower_vtl after referring
>>    to Sean's earlier changes for xfer_to_guest_mode_handle_work.
>>
>> * Rebased and resolved merge conflicts, compilation errors on latest
>>    linux-next kernel tip, after Roman's Confidential VM changes,
>>    which merged recently. No functional changes.
> 
> Did your testing against the latest linux-next included testing with
> CONFIG_X86_KERNEL_IBT=y?  This is Indirect Branch Tracking, which would
> have generated a fault with your v7 series and earlier because of the indirect
> call instruction when doing VTL Return through the hypercall page (which
> doesn't have the needed ENDBR64 instruction). But now that VTL Return is
> doing a static call, that should be direct, which won't trigger an IBT fault.
> 
> To confirm that you really are running with IBT enabled, you should see
> 
> [    0.047008] CET detected: Indirect Branch Tracking enabled
> 
> in the VTL2 dmesg output.  And "ibt" should appear in the
> "flags" output line of 'cat /proc/cpuinfo' (or the 'lscpu' command).
> 
> Michael


Hi Michael,
I have now tested with and without IBT, and in case of IBT enabled, I do 
see the log you pasted for IBT in VTL2 logs and there are no failures.

However, this additional testing uncovered another issue here where 
there is a crash in VTL0, some time after boot, due to rbp clobbering in 
mshv_vtl_return_hypercall() wrapper function.

Thanks a lot Michael for helping me offline on this, to understand and 
identify the issue.



Hi Peter, Paolo, Sean,
Here is the summary of the problem and the fix:

Assembly code make a call to mshv_vtl_return_hypercall() after handling 
rbp properly. However, current wrapper function in C updates rbp to rsp 
before making the static call. This creates problems.

<-snippet->

arch/x86/hyperv/mshv_vtl_asm.S:
	/* make a hypercall to switch VTL */
	call mshv_vtl_return_hypercall

arch/x86/hyperv/hv_vtl.c:
noinstr void mshv_vtl_return_hypercall(void)
{
	asm volatile ("call " STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall) :
		      ASM_CALL_CONSTRAINT);
}

(gdb) disassemble mshv_vtl_return_hypercall
Dump of assembler code for function mshv_vtl_return_hypercall:
    0xffffffff886981a0 <+0>:     push   %rbp
    0xffffffff886981a1 <+1>:     mov    %rsp,%rbp
    0xffffffff886981a4 <+4>:     call   0xffffffff886a77a8 
<__SCT____mshv_vtl_return_hypercall>
    0xffffffff886981a9 <+9>:     pop    %rbp
    0xffffffff886981aa <+10>:    jmp    0xffffffff886a7670 
<__x86_return_thunk>

<-end->


This is fixed after removing ASM_CALL_CONSTRAINT from above function 
which makes sure it does not add save/restore rbp logic before the 
assembly call instructions.


<-snippet->

(gdb) disassemble mshv_vtl_return_hypercall
Dump of assembler code for function mshv_vtl_return_hypercall:
    0xffffffff886981a0 <+0>:     call   0xffffffff886a77a8 
<__SCT____mshv_vtl_return_hypercall>
    0xffffffff886981a5 <+5>:     jmp    0xffffffff886a7670 
<__x86_return_thunk>
End of assembler dump.

<-end->

But then we see a warning reported by objtool for frame pointer, but 
since this is expected, I will need to add STACK_FRAME_NON_STANDARD_FP 
to suppress it.

vmlinux.o: warning: objtool: mshv_vtl_return_hypercall+0x4: call without 
frame pointer save/setup


During code review, I found CR2 handling was missing after making 
mshv_vtl_return_hypercall call in assembly, which I will *additionally* 
fix in next version.

Pasting the diff at the end, on top of this patch, which should fix 
these issues.

Please let me know if I should be doing it differently or if you foresee 
any issues with this approach.

Regards,
Naman

------------------------
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 636e9253b81e..c61d2dce4d68 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -258,9 +258,9 @@ DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, 
void (*)(void));

  noinstr void mshv_vtl_return_hypercall(void)
  {
-       asm volatile ("call " 
STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall) :
-                     ASM_CALL_CONSTRAINT);
+       asm volatile ("call " 
STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall));
  }
+STACK_FRAME_NON_STANDARD_FP(mshv_vtl_return_hypercall);

  extern void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);

diff --git a/arch/x86/hyperv/mshv_vtl_asm.S b/arch/x86/hyperv/mshv_vtl_asm.S
index 4085073a5876..5f4b511749f8 100644
--- a/arch/x86/hyperv/mshv_vtl_asm.S
+++ b/arch/x86/hyperv/mshv_vtl_asm.S
@@ -65,6 +65,9 @@ SYM_FUNC_START(__mshv_vtl_return_call)
         mov 16(%rsp), %rcx
         mov 24(%rsp), %rax

+       mov %rdx, MSHV_VTL_CPU_CONTEXT_rdx(%rax)
+       mov %cr2, %rdx
+       mov %rdx, MSHV_VTL_CPU_CONTEXT_cr2(%rax)
         pop MSHV_VTL_CPU_CONTEXT_rcx(%rax)
         pop MSHV_VTL_CPU_CONTEXT_rax(%rax)
         add $16, %rsp

