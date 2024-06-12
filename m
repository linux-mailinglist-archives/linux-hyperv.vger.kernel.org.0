Return-Path: <linux-hyperv+bounces-2408-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A59905F2E
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jun 2024 01:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 713E2B20F29
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 23:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B76312C816;
	Wed, 12 Jun 2024 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KF9jPSBE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BFE84A36;
	Wed, 12 Jun 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234794; cv=none; b=VDDH/CSzUhLqCUlGimQxxUGIT5IzUdxx5cf1qu3hwXWw0skSv4Dyesa/rDJ9hkipJRNj1azq/C7foGba9z/r9xhjvYipwtnYfvmyp3sOuE5CeBU5ggbBlhxe9PoekZhGA/7iXI/cn71ySX1bCEXqERns2fQgkUe9Ap7k+ol7E3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234794; c=relaxed/simple;
	bh=aLnUBqPtUeBv32NbeLVNmgLi8ew95brTEfYYJlJWmEM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ISiAlt9ABRICoh5LdBwS5KuBRABhU4CLcwm/+o0dkkmiNGUwmr0Ts5z9+aNuD7qm4lavwhbyihZ1GwfJgxpwqCQKiJbg30oS88+3YtMlsc4Uis3iwJcrIccbuQfjnUVV0hmP0/Pdv69JDOhyq18LF1t4A+w/jFOo5/0BAdo07AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=KF9jPSBE; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45CNPftp3933198
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 12 Jun 2024 16:25:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45CNPftp3933198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718234743;
	bh=SaATviG6Z81UgEioCPxN9VS+E0yDGnphYvOlmf9J1es=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KF9jPSBE0HgW6q2T+PnT8ZrKRIq/1w1yA2lERYUpTk0mvJnKTRoZ/s6e2WTNmsBvu
	 bane9gvKiCqNfsQZu6Zou2esQBN+Se+uKDSjd+lVt4YqhJA97uEMT0Xz1JMwHrRc78
	 BYsmaRDenE593mlF1op7w5q31M3WCf/+F9N1ls4tDCI25tuNiqNNCi2wTn8F8ltiMI
	 Do+1jRWckpsiW09/FKMgRroup8rCGQZ8m5s6WJrQ2LWwRFWbUBN9k2XKbwbIs0DwyR
	 v4X8SRVrEL48m/RSHe7ElSxkO31u/qnXEYCL2t9OL1WU/nPKYGs+PAc/3EkMw2ZV4U
	 HFEVTl5DhqKsg==
Date: Wed, 12 Jun 2024 16:25:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Borislav Petkov <bp@alien8.de>, Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
        Baoquan He <bhe@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv11_05/19=5D_x86/relocate=5Fkern?=
 =?US-ASCII?Q?el=3A_Use_named_labels_for_less_confusion?=
User-Agent: K-9 Mail for Android
In-Reply-To: <addbd29a-66dc-4180-ae45-ef038c2249d1@citrix.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com> <20240528095522.509667-6-kirill.shutemov@linux.intel.com> <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com> <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5> <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com> <20240604091503.GQZl7bF14qTSAjqUhN@fat_crate.local> <ehttxqgg7zhbgty5m5uxkduj3xf7soonrzfu4rfw7hccqgdydl@afki66pnree5> <5c8b3ee9-64c2-4ff3-9cca-ba2672b9635e@zytor.com> <nxllu5wfhvfvorxbbt6ll3lc2mr47lw7sduszfawhtryqgtyrd@3qgtci7ocah6> <addbd29a-66dc-4180-ae45-ef038c2249d1@citrix.com>
Message-ID: <587E6BF3-4200-442D-95F2-156A96F6FDD8@zytor.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 12, 2024 4:06:07 PM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=2Ec=
om> wrote:
>On 12/06/2024 10:22 am, Kirill A=2E Shutemov wrote:
>> On Tue, Jun 11, 2024 at 11:26:17AM -0700, H=2E Peter Anvin wrote:
>>> On 6/4/24 08:21, Kirill A=2E Shutemov wrote:
>>>>  From b45fe48092abad2612c2bafbb199e4de80c99545 Mon Sep 17 00:00:00 20=
01
>>>> From: "Kirill A=2E Shutemov" <kirill=2Eshutemov@linux=2Eintel=2Ecom>
>>>> Date: Fri, 10 Feb 2023 12:53:11 +0300
>>>> Subject: [PATCHv11=2E1 06/19] x86/kexec: Keep CR4=2EMCE set during ke=
xec for TDX guest
>>>>
>>>> TDX guests run with MCA enabled (CR4=2EMCE=3D1b) from the very start=
=2E If
>>>> that bit is cleared during CR4 register reprogramming during boot or
>>>> kexec flows, a #VE exception will be raised which the guest kernel
>>>> cannot handle it=2E
>>>>
>>>> Therefore, make sure the CR4=2EMCE setting is preserved over kexec to=
o and
>>>> avoid raising any #VEs=2E
>>>>
>>>> The change doesn't affect non-TDX-guest environments=2E
>>>>
>>>> Signed-off-by: Kirill A=2E Shutemov <kirill=2Eshutemov@linux=2Eintel=
=2Ecom>
>>>> ---
>>>>   arch/x86/kernel/relocate_kernel_64=2ES | 17 ++++++++++-------
>>>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/relocate_kernel_64=2ES b/arch/x86/kernel=
/relocate_kernel_64=2ES
>>>> index 085eef5c3904=2E=2E9c2cf70c5f54 100644
>>>> --- a/arch/x86/kernel/relocate_kernel_64=2ES
>>>> +++ b/arch/x86/kernel/relocate_kernel_64=2ES
>>>> @@ -5,6 +5,8 @@
>>>>    */
>>>>   #include <linux/linkage=2Eh>
>>>> +#include <linux/stringify=2Eh>
>>>> +#include <asm/alternative=2Eh>
>>>>   #include <asm/page_types=2Eh>
>>>>   #include <asm/kexec=2Eh>
>>>>   #include <asm/processor-flags=2Eh>
>>>> @@ -145,14 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>>>>   	 * Set cr4 to a known state:
>>>>   	 *  - physical address extension enabled
>>>>   	 *  - 5-level paging, if it was enabled before
>>>> +	 *  - Machine check exception on TDX guest, if it was enabled befor=
e=2E
>>>> +	 *    Clearing MCE might not be allowed in TDX guests, depending on=
 setup=2E
>>>> +	 *
>>>> +	 * Use R13 that contains the original CR4 value, read in relocate_k=
ernel()=2E
>>>> +	 * PAE is always set in the original CR4=2E
>>>>   	 */
>>>> -	movl	$X86_CR4_PAE, %eax
>>>> -	testq	$X86_CR4_LA57, %r13
>>>> -	jz	=2ELno_la57
>>>> -	orl	$X86_CR4_LA57, %eax
>>>> -=2ELno_la57:
>>>> -
>>>> -	movq	%rax, %cr4
>>>> +	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
>>>> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_T=
DX_GUEST
>>>> +	movq	%r13, %cr4
>>> If this is the case, I don't really see a reason to clear MCE per se a=
s I'm
>>> guessing a machine check here will be fatal anyway? It just changes th=
e
>>> method of death=2E
>> Andrew had a strong opinion on method of death here=2E
>>
>> https://lore=2Ekernel=2Eorg/all/1144340e-dd95-ee3b-dabb-579f9a65b3c7@ci=
trix=2Ecom
>
>Not sure if I intended it to come across that strongly, but given a
>choice, the !CR4=2EMCE death is cleaner because at least you're not
>interpreting garbage and trying to use it as a valid IDT=2E
>
>~Andrew

Zorch the IDT if it isn't valid?

