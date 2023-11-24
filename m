Return-Path: <linux-hyperv+bounces-1044-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C867F717F
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Nov 2023 11:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C43281CEC
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Nov 2023 10:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78050199A1;
	Fri, 24 Nov 2023 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qNTjTTAk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A6201BD;
	Fri, 24 Nov 2023 02:31:50 -0800 (PST)
Received: from [192.168.1.150] (181-28-144-85.ftth.glasoperator.nl [85.144.28.181])
	by linux.microsoft.com (Postfix) with ESMTPSA id E259D20B74C0;
	Fri, 24 Nov 2023 02:31:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E259D20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700821909;
	bh=QLms25rgq8qSrzk159jr51gU0QpzCDKfknjLMjUaAxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qNTjTTAkNJr4duxdUknZaGEH905MX99vycftZ8lZ4SLR/E4P5cmh1WKWIrwTDIxaV
	 q1UZguzEpWq0o9ZANF1yATZK5eQCwXcHeS77JrCLlMxah+2dwQZincDgF3aigs9jQO
	 cwuTi/EyXVfJsp5mB/SZeCe1O++3k0GO7HqO1P7I=
Message-ID: <9f550947-9d13-479c-90c4-2e3f7674afee@linux.microsoft.com>
Date: Fri, 24 Nov 2023 11:31:44 +0100
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
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Kelley <mhkelley58@gmail.com>,
 Nikolay Borisov <nik.borisov@suse.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
 stefan.bader@canonical.com, tim.gardner@canonical.com,
 roxana.nicolescu@canonical.com, cascardo@canonical.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, sashal@kernel.org,
 stable@vger.kernel.org
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2023 14:58, Kirill A. Shutemov wrote:
> On Wed, Nov 22, 2023 at 06:01:04PM +0100, Jeremi Piotrowski wrote:
>> Check for additional CPUID bits to identify TDX guests running with Trust
>> Domain (TD) partitioning enabled. TD partitioning is like nested virtualization
>> inside the Trust Domain so there is a L1 TD VM(M) and there can be L2 TD VM(s).
>>
>> In this arrangement we are not guaranteed that the TDX_CPUID_LEAF_ID is visible
>> to Linux running as an L2 TD VM. This is because a majority of TDX facilities
>> are controlled by the L1 VMM and the L2 TDX guest needs to use TD partitioning
>> aware mechanisms for what's left. So currently such guests do not have
>> X86_FEATURE_TDX_GUEST set.
>>
>> We want the kernel to have X86_FEATURE_TDX_GUEST set for all TDX guests so we
>> need to check these additional CPUID bits, but we skip further initialization
>> in the function as we aren't guaranteed access to TDX module calls.
> 
> I don't follow. The idea of partitioning is that L2 OS can be
> unenlightened and have no idea if it runs indide of TD. But this patch
> tries to enumerate TDX anyway.
> 
> Why?
> 

That's not the only idea of partitioning. Partitioning provides different privilege
levels within the TD, and unenlightened L2 OS can be made to work but are inefficient.
In our case Linux always runs enlightened (both with and without TD partitioning), and
uses TDX functionality where applicable (TDX vmcalls, PTE encryption bit).

There have been long discussions on LKML about how CoCo features should be supported,
I've followed most of them and I believe we've converged on: the kernel is fully
aware what kind of guest it is (SNP/TDX) and uses CC_ATTR_XXX to check for specific
SNP/TDX features.

Right now the guest with TD partitioning is missing out on X86_FEATURE_TDX_GUEST.
That's why this patch tries to enumerate TDX.

I have posted an alternate version of this patch for discussion here:
https://lore.kernel.org/lkml/0799b692-4b26-4e00-9cec-fdc4c929ea58@linux.microsoft.com/

