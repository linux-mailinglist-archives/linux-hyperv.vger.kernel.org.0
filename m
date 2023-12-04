Return-Path: <linux-hyperv+bounces-1192-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD79803AA6
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 17:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AC71C20A21
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 16:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2319250F4;
	Mon,  4 Dec 2023 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KFlFC6V3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 301939B;
	Mon,  4 Dec 2023 08:45:08 -0800 (PST)
Received: from [172.20.10.13] (unknown [83.232.59.81])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0511820B74C0;
	Mon,  4 Dec 2023 08:44:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0511820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701708307;
	bh=WmfHCN3jVeLCujfeKdxoJP9+xwCwqUAHJemHoreeygQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KFlFC6V35RPeaHC9w0beCchXcugku32yKVEsntKZ3fKxjfVgUqS68wvMhqXHdbBbE
	 frmWEegr00kCD9RMUNe6mjL52CJ2jwKyND8zZ9wRe7sMGxSgqsnpQUDI2HGBVnZi7k
	 M82u7dWOIncYGS28B/PcXwmhxyVDQCkk1nOwdxog=
Message-ID: <450a50ba-4c87-4137-9feb-de8f17e3dfa6@linux.microsoft.com>
Date: Mon, 4 Dec 2023 17:44:48 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>,
 "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "stefan.bader@canonical.com" <stefan.bader@canonical.com>,
 "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
 "roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
 "cascardo@canonical.com" <cascardo@canonical.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sashal@kernel.org" <sashal@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Michael Kelley <mhkelley58@gmail.com>, Nikolay Borisov
 <nik.borisov@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky
 <thomas.lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>,
 "Cui, Dexuan" <decui@microsoft.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <0799b692-4b26-4e00-9cec-fdc4c929ea58@linux.microsoft.com>
 <20231129164049.GVZWdpkVlc8nUvl/jx@fat_crate.local>
 <DM8PR11MB575085570AF48AF4690986EDE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20231130075559.GAZWhAD5ScHoxbbTxL@fat_crate.local>
 <DM8PR11MB575049E0C9F36001F0F374CEE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20231130092119.GBZWhUD6LscxYOpxNl@fat_crate.local>
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231130092119.GBZWhUD6LscxYOpxNl@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/11/2023 10:21, Borislav Petkov wrote:
> On Thu, Nov 30, 2023 at 08:31:03AM +0000, Reshetova, Elena wrote:
>> No threats whatsoever,
> 
> I don't mean you - others. :-)
> 
>> I just truly don’t know details of SEV architecture on this and how it
>> envisioned to operate under this nesting scenario.  I raised this
>> point to see if we can build the common understanding on this. My
>> personal understanding (please correct me) was that SEV would also
>> allow different types of L2 guests, so I think we should be aligning
>> on this.
> 
> Yes, makes sense. The only L2 thing I've heard of is some Azure setup.

"L2" is the Intel terminology in TD-partitioning (see figure 11.2 in [1]),
but Azure uses it for the exact same thing as VMPLs in SEV-SNP. On the AMD
side the community is working on Coconut SVSM[2] and there was an AMD SVSM[3]
project before that, both of them have the same idea as the Azure paravisor.
SUSE, Red Hat, IBM and others are active in SVSM development, we've also started
contributing. I think this kind of usage will also appear on TDX soon.

[1]: https://cdrdv2.intel.com/v1/dl/getContent/773039
[2]: https://github.com/coconut-svsm/svsm
[3]: https://github.com/AMDESE/linux-svsm

> 
>> Yes, agree, so what are our options and overall strategy on this?  We
>> can try to push as much as possible complexity into L1 VMM in this
>> scenario to keep the guest kernel almost free from these sprinkling
>> differences.
> 
> I like that angle. :)
> 
>> Afterall the L1 VMM can emulate whatever it wants for the guest.
>> We can also see if there is a true need to add another virtualization
>> abstraction here, i.e. "nested encrypted guest".
> 
> Yes, that too. I'm sceptical but there are use cases with that paravisor
> thing and being able to run an unmodified guest, i.e., something like
> a very old OS which no one develops anymore but customers simply can't
> part ways with it for raisins

I don't think we'll be seeing Windows XP TDX/SNP guests :)

The primary use case for the paravisor (/SVSM) is pretty common across the
the industry and projects that I shared: TPM emulation. Then comes the
other stuff: live migration, "trustlets", further device emulation. All this
inside the confidential boundary.

> 
>> Any other options we should be considering as overall strategy?
> 
> The less the kernel knows about guests, the better, I'd say.
> 

The challenge lies in navigating the Venn diagram of: standard guest,
TDX guest and SNP guest. Is a "guest" more "TDX" or more "Hyper-V" (or KVM/Vmware)?
Should the TDX (and SNP) code be extended with more knowledge of hypervisor
interfaces or should the hypervisor interfaces know more about TDX/SNP.

I'd love it if we all had some agreement on this. I posted these patches
based on suggestions that TDX guest-ness takes precedence.

> The other thing I'm missing most of the time is, people come with those
> patches enabling this and that but nowhere does it say: "we would love
> to have this because of this great idea we had" or "brings so much more
> performance" or "amazing code quality imrpovement" or, or other great
> reason.
> 
> Rather, it is "yeah, we do this and you should support it". Well, nope.
> 
I hear you, that's we've been making an effort to be more open about use cases
and capabilities along with patches. We also care about simplifying the code
to make it easier to follow the flows. I think the whole kernel has come
a long way since the first confidential guest patches were posted.

Jeremi

> Thx.
> 


