Return-Path: <linux-hyperv+bounces-9892-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HqzMVzqzWkLjAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9892-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 06:02:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B12E38357D
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 06:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A3033058DF9
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 04:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C0930E84B;
	Thu,  2 Apr 2026 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eAnUARNl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EDC279334;
	Thu,  2 Apr 2026 04:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102498; cv=none; b=I9AYs/rNRUjm8G7SQGdfGyyYD8mKpCeJ/oX3Yo3Q3374smYPTYYksq12CbIPAN/19DMSabZw5ZcxcaBLZtQkqq/tdAkig5Y9t+07ZjLsJJ4HkvLmlUsutSphA7Knp2mbxYEMOeTFNa9b3uUq9+MsSCRLxEJMZlIyugy/uxB8Uzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102498; c=relaxed/simple;
	bh=tY3WvR4R/zrWI1MsWDPbn78x2fJshokN5D05V5yxYaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kyq6IC5Meo7T4wB5s1PJidd54ECq/UK/hKgZzw0YdmV70xR6svfAlZrsRJUMbkrR4oIiXzn0DLFBSpcWOxp+icB3D68keIV5Xf9YDk7exngxGWG3Jm6cYn/dre5Ca+2rvgxNwVDRAsSMwtLtsbOE2/53iPbcqgHl2ZP3QKa5FEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eAnUARNl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.66.83] (unknown [167.220.238.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id A6ED220B710C;
	Wed,  1 Apr 2026 21:01:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6ED220B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775102490;
	bh=T6sBwsFb445Pp7249L79ufDRpJqZshHczUisxFI3JEo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eAnUARNlHoU7VXFylRE5DLFJrHd/bTFZfsva8Frd/0OaQNP+H5HBfDGUsKXcWK4j9
	 DCORtz3WkyAFjVZSBnLcBSqP1locZaGVeOkTYl3BxmW0xAd4W4kkTI8UTh5/aLonrY
	 7Rk51EmzcAbubl0WKZf4Ni57dSE1fX82drzW4uFo=
Message-ID: <b093e70f-1ee2-4ba1-a934-581326a7abe8@linux.microsoft.com>
Date: Thu, 2 Apr 2026 09:31:21 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Drivers: hv: Add ARM64 support in mshv_vtl
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 mrigendrachaubey <mrigendra.chaubey@gmail.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <SN6PR02MB4157DFC7B7CE94500C89664BD441A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <a8f856a0-49a8-4041-9036-4e9ade79532b@linux.microsoft.com>
 <SN6PR02MB4157E4E088F39106979BE4EDD450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157E4E088F39106979BE4EDD450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9892-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 6B12E38357D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/2026 10:24 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, March 17, 2026 9:23 PM
>>
>> On 3/18/2026 3:33 AM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026 5:13 AM
>>>>
>>>> The series intends to add support for ARM64 to mshv_vtl driver.
> 
> No need to be tentative. :-)  Just write as:
> 
> "The series adds support for ARM64 to the mshv_vtl driver."
> 
>>>> For this, common Hyper-V code is refactored, necessary support is added,
>>>> mshv_vtl_main.c is refactored and then finally support is added in
>>>> Kconfig.
>>>>
>>>> Based on commit 1f318b96cc84 ("Linux 7.0-rc3")
>>>
>>> There's now an online LLM-based tool that is automatically reviewing
>>> kernel patches. For this patch set, the results are here:
>>>
>>> https://sashiko.dev/#/patchset/20260316121241.910764-1-namjain%40linux.microsoft.com
>>>
>>> It has flagged several things that are worth checking, but I haven't
>>> reviewed them to see if they are actually valid.
>>>
>>> FWIW, the announcement about sashiko.dev is here:
>>>
>>> https://lore.kernel.org/lkml/7ia4o6kmpj5s.fsf@castle.c.googlers.com/
>>>
>>> Michael
>>
>>
>> Thanks for sharing Michael,
>> I'll check it out and do the needful.
>>
> 
> I've done a full review of this patch set and provided comments in the
> individual patches. Some of my comments reference the Sashiko AI
> comments, but there are still some Sashiko AI comments to consider
> that I haven't referenced.
> 
> FWIW, the Sashiko AI comments are quite good -- it found some things
> here that I missed on my own, and in my earlier reviews of the original VTL
> code. :-(
> 
> Michael


Thank you so much Michael for reviewing these. I was also trying to 
address review comments from Sashiko, and noticed some of them were 
false positives in the sense that these were existing issues and not 
introduced by arm64 changes. I thought of keeping them separate from the 
scope of this series for future.

I'll review your comments and address them.

Regards,
Naman

