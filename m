Return-Path: <linux-hyperv+bounces-1170-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718EF800E92
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Dec 2023 16:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14135B213DC
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Dec 2023 15:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4752F4AF6E;
	Fri,  1 Dec 2023 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iQzBBw2f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED92C1721;
	Fri,  1 Dec 2023 07:27:32 -0800 (PST)
Received: from [192.168.1.150] (181-28-144-85.ftth.glasoperator.nl [85.144.28.181])
	by linux.microsoft.com (Postfix) with ESMTPSA id E3CDF20B74C0;
	Fri,  1 Dec 2023 07:27:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3CDF20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701444452;
	bh=ugsgDNc54VmuVqxUqJuTKbnR7XplRz9Jd0SR1rz/60Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iQzBBw2fclqekxjOIWDiHYRhxqMwTQRhRB2Xi1gI82zYAaoAWs6JIut5AlB9MF0B5
	 /y1FjDFn8p2H9JbXAXQ0tZNWF0H/MKrD8DDyUO/zrsiJl4PPcO0gtjnzkKmwuDuscs
	 8qHPBESj9ynA0Y6Al4D3UryrNrD+JzS+w+3wJz3E=
Message-ID: <e471f965-0ae1-451c-b985-951ed7f65971@linux.microsoft.com>
Date: Fri, 1 Dec 2023 16:27:27 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] x86/coco: Disable TDX module calls when TD
 partitioning is active
To: "Huang, Kai" <kai.huang@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Cc: "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
 "cascardo@canonical.com" <cascardo@canonical.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "stefan.bader@canonical.com" <stefan.bader@canonical.com>,
 "Cui, Dexuan" <decui@microsoft.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "mhkelley58@gmail.com" <mhkelley58@gmail.com>, "hpa@zytor.com"
 <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "sashal@kernel.org" <sashal@kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>, "x86@kernel.org" <x86@kernel.org>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231122170106.270266-2-jpiotrowski@linux.microsoft.com>
 <20231123141318.rmskhl3scc2a6muw@box.shutemov.name>
 <837fb5e9-4a35-4e49-8ec6-1fcfd5a0da30@linux.microsoft.com>
 <ab1a3575ac66cf2f7cc05a21e5a20fbe415e834b.camel@intel.com>
Content-Language: en-US
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <ab1a3575ac66cf2f7cc05a21e5a20fbe415e834b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/11/2023 11:37, Huang, Kai wrote:
> On Fri, 2023-11-24 at 11:38 +0100, Jeremi Piotrowski wrote:
>> On 23/11/2023 15:13, Kirill A. Shutemov wrote:
>>> On Wed, Nov 22, 2023 at 06:01:05PM +0100, Jeremi Piotrowski wrote:
>>>> Introduce CC_ATTR_TDX_MODULE_CALLS to allow code to check whether TDX module
>>>> calls are available. When TD partitioning is enabled, a L1 TD VMM handles most
>>>> TDX facilities and the kernel running as an L2 TD VM does not have access to
>>>> TDX module calls. The kernel still has access to TDVMCALL(0) which is forwarded
>>>> to the VMM for processing, which is the L1 TD VM in this case.
>>>
>>
>> Correction: it turns out TDVMCALL(0) is handled by L0 VMM.
>>>> 
> Some thoughts after checking the spec more to make sure we don't have
> misunderstanding on each other:
> 
> The TDX module will unconditionally exit to L1 for any TDCALL (except the
> TDVMCALL) from the L2.  This is expected behaviour.  Because the L2 isn't a true
> TDX guest, L1 is expected to inject a #UD or #GP or whatever error to L2 based
> on the hardware spec to make sure L2 gets an correct architectural behaviour for
> the TDCALL instruction.
> 
> I believe this is also the reason you mentioned "L2 TD VM does not have access
> to TDX module calls".

Right. Injecting #UD/#GP/returning an error (?) might be desirable but the L2 guest
would still not be guaranteed to be able to rely on the functionality provided by
these TDCALLS. Here the TDCALLs lead to guest termination, but the kernel would panic
if some of them would return an error.

> 
> However TDX module actually allows the L1 to control whether the L2 is allowed
> to execute TDVMCALL by controlling whether the TDVMCALL from L2 will exit to L0
> or L1.
> 
> I believe you mentioned "TDVMCALL(0) is handled by L0 VMM" is because the L1
> hypervisor -- specifically, hyperv -- chooses to let the TDVMCALL from L2 exit
> to L0?

That is correct. The L1 hypervisor here (it's not hyperv, so maybe lets keep
referring to it as paravisor?) enables ENABLE_TDVMCALL so that TDVMCALLs exit
straight to L0. The TDVMCALLs are used for the I/O path which is not emulated
or intercepted by the L1 hypervisor at all.

> 
> But IMHO this is purely the hyperv's implementation, i.e., KVM can choose not to
> do so, and simply handle TDVMCALL in the same way as it handles normal TDCALL --
> inject the architecture defined error to L2.
> 
> Also AFAICT there's no architectural thing that controlled by L2 to allow the L1
> know whether L2 is expecting to use TDVMCALL or not.  In other words, whether to
> support TDVMCALL is purely L1 hypervisor implementation specific.
> 

Right, the only way to know whether TDVMCALL/TDCALL is allowed is to identify the
L1 hypervisor and use that knowledge.

> So to me this whole series is hyperv specific enlightenment for the L2 running
> on TDX guest hyperv L1.  And because of that, perhaps a better way to do is:
> 
> 1) The default L2 should just be a normal VM that any TDX guest L1 hypervisor
> should be able to handle (guaranteed by the TDX partitioning architecture).
>
 
When you say "normal VM" you mean "legacy VM"? 'Any TDX guest L1 hypervisor' is
a bit of a reach: the only TDX guest L1 hypervisor implementation that I know
exists does not support guests that are entirely unaware of TDX.

Maybe it's best if we avoid the name "TDX guest L1 hypervisor" altogether and
refer to is like AMD calls it: "Secure VM Service Module" because that more
accurately reflects the intention: providing certain targeted services needed in
the context of a confidential VM. No one is interested in running a full blown
hypervisor implementation in there.

> 2) Different L2/L1 hypervisor can have it's own enlightenments.  We can even
> have common enlightenments across different implementation of L1 hypervisors,
> but that requires cross-hypervisor cooperation.
> 
> But IMHO it's not a good idea to say:
> 
> 	L2 is running on a TDX partitioning enabled environment, let us mark it
> 	as a TDX guest but mark it as "TDX partitioning" to disable couple of 
> 	TDX functionalities.
> 
> Instead, perhaps it's better to let L2 explicitly opt-in TDX facilities that the
> underneath hypervisor supports.> 
> TDVMCALL can be the first facility to begin with.
> 
> At last, even TDVMCALL has bunch of leafs, and hypervisor can choose to support
> them or not.  Use a single "tdx_partitioning_active" to select what TDX
> facilities are supported doesn't seem a good idea.
> 
> That's my 2cents w/o knowing details of hyperv enlightenments.
> 

I think on the whole we are on the same page. Let me rephrase what I hear you saying:
'tdx_partitioning_active' as a "catch all" is bad, but CC_ATTR_TDX_MODULE_CALLS is in
the spirit of what we would like to have.

So something like:


    case CC_ATTR_TDX_MODULE_CALLS:
        return tdx_status & TDCALL;

and 

    if (no_td_partitioning)
        tdx_status |= TDCALL;
    if (l1_td_vmm_supports_tdcalls)
        tdx_status |= TDCALL;

would be ok? I can directly tell you that the next facility would control tdx_safe_halt()
because that doesn't operate as intended (hlt traps to L1, tdx_safe_halt is a TDVMCALL and
goes to L0).

The other important goal of the patchset is ensuring that X86_FEATURE_TDX_GUEST is set.


