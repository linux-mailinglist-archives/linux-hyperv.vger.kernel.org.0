Return-Path: <linux-hyperv+bounces-1392-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7520827882
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 20:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E8B284F55
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 19:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4B754FAE;
	Mon,  8 Jan 2024 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0jNbgz5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C754FA3;
	Mon,  8 Jan 2024 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704741851; x=1736277851;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=cJOrLgxgkebHcXJBcayOfWJpxDUa4IaN64xEo8IWidU=;
  b=C0jNbgz5nPfecAtIEgmxemMUHSRpwHncwoGouqmXL3BHx+U2RoXo51gS
   fsXIyBH9VYx8AjuXhgLKx2nK3pYz3HSKSyfn5iQ8JkpoYya8Id9M/bSg+
   gXAEkA3aERzMVtdvDSPsoylofa6pKYWkx/Tu/wi95A5I0i7HEuDdtZRqW
   8ZEC+NGf1IycsmkzybPRs8twIlRMhPMuOB+wpM0bpJCLNFMeVFDMAM/Ew
   iBPN28vyXkPpYap/ik3jy9WPiupQpISuXwTkBzK2CJEHiPckkM9J1CIGt
   BB0YphIim1PtgtOie2LSjP2Bzq3eer8mkpC/1oMgGRIkQf+7ezMrcJabA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="401777923"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="401777923"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 11:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="23282048"
Received: from nsingiri-mobl2.amr.corp.intel.com (HELO [10.212.166.188]) ([10.212.166.188])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 11:24:10 -0800
Message-ID: <9f0c0b3d-6021-466d-8ee0-375f66c5006a@linux.intel.com>
Date: Mon, 8 Jan 2024 11:24:06 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] x86/hyperv: Make encrypted/decrypted changes safe
 for load_unaligned_zeropad()
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "urezki@gmail.com" <urezki@gmail.com>, "hch@infradead.org"
 <hch@infradead.org>, "lstoakes@gmail.com" <lstoakes@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "ardb@kernel.org" <ardb@kernel.org>, "jroedel@suse.de" <jroedel@suse.de>,
 "seanjc@google.com" <seanjc@google.com>,
 "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20240105183025.225972-1-mhklinux@outlook.com>
 <20240105183025.225972-4-mhklinux@outlook.com>
 <a559406d-acd5-40eb-906e-2b8b11739e9e@linux.intel.com>
 <SN6PR02MB415797321652A47E166A295FD46B2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <SN6PR02MB415797321652A47E166A295FD46B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/8/2024 11:13 AM, Michael Kelley wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Sent: Monday, January 8, 2024 10:37 AM
>>
>> On 1/5/2024 10:30 AM, mhkelley58@gmail.com wrote:
>>> From: Michael Kelley <mhklinux@outlook.com>
>>>
>>> In a CoCo VM, when transitioning memory from encrypted to decrypted, or
>>> vice versa, the caller of set_memory_encrypted() or set_memory_decrypted()
>>> is responsible for ensuring the memory isn't in use and isn't referenced
>>> while the transition is in progress.  The transition has multiple steps,
>>> and the memory is in an inconsistent state until all steps are complete.
>>> A reference while the state is inconsistent could result in an exception
>>> that can't be cleanly fixed up.
>>>
>>> However, the kernel load_unaligned_zeropad() mechanism could cause a stray
>>> reference that can't be prevented by the caller of set_memory_encrypted()
>>> or set_memory_decrypted(), so there's specific code to handle this case.
>>> But a CoCo VM running on Hyper-V may be configured to run with a paravisor,
>>> with the #VC or #VE exception routed to the paravisor. There's no
>>> architectural way to forward the exceptions back to the guest kernel, and
>>> in such a case, the load_unaligned_zeropad() specific code doesn't work.
>>>
>>> To avoid this problem, mark pages as "not present" while a transition
>>> is in progress. If load_unaligned_zeropad() causes a stray reference, a
>>> normal page fault is generated instead of #VC or #VE, and the
>>> page-fault-based fixup handlers for load_unaligned_zeropad() resolve the
>>> reference. When the encrypted/decrypted transition is complete, mark the
>>> pages as "present" again.
>>
>> Change looks good to me. But I am wondering why are adding it part of
>> prepare and finish callbacks instead of directly in set_memory_encrypted() function.
>>
> 
> The prepare/finish callbacks are different for TDX, SEV-SNP, and
> Hyper-V CoCo guests running with a paravisor -- so there are three sets
> of callbacks.  As described in the cover letter, I've given up on using this
> scheme for the TDX and SEV-SNP cases, because of the difficulty with
> the SEV-SNP callbacks needing a valid virtual address (whereas TDX and
> Hyper-V paravisor need only a physical address).  So it seems like the
> callbacks specific to the Hyper-V paravisor are the natural place for the
> code.  That leaves the TDX and SEV-SNP code paths unchanged, which
> was my intent.
> 

Got it. Thanks for clarifying it.

> Or maybe I'm not understanding your comment?  If that's the case,
> please elaborate.
> 
> Michael
> 
>> Reviewed-by: Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

