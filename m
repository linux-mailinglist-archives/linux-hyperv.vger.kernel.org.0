Return-Path: <linux-hyperv+bounces-838-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B758D7E7C9F
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 14:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E043D1C2094C
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 13:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2816419BB9;
	Fri, 10 Nov 2023 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ErKgrXTG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B819BD7
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Nov 2023 13:42:39 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D668737AE2;
	Fri, 10 Nov 2023 05:42:37 -0800 (PST)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4373720B74C0;
	Fri, 10 Nov 2023 05:42:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4373720B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1699623757;
	bh=iQJfXDlwXXwcx9/wg4dueoqnKk6YMfmTC6RexGNDY4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ErKgrXTGftVur9/Ow+eAuaZY4sLViWM9WBtEAVYyJhjPhUsNeKpbwtw2XpeJCeSyi
	 j8w8W4QdYqDPgcJVbaMaZKxa0xWozSMlrF0LPePWlnoFWf/RscBUqP+5SGEu161UJJ
	 WbbGATDDK61hMzFIKfOetfNONl0yc0+P4Wh1vk88=
Message-ID: <5a80bfd8-7092-4a85-93a6-189a16725642@linux.microsoft.com>
Date: Fri, 10 Nov 2023 14:42:31 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Check cc_vendor when printing memory encryption
 info
Content-Language: en-US
To: kirill.shutemov@linux.intel.com
Cc: Dave Hansen <dave.hansen@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, stefan.bader@canonical.com,
 tim.gardner@canonical.com, roxana.nicolescu@canonical.com,
 cascardo@canonical.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, sashal@kernel.org
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
 <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
 <ee9de366-6027-495a-98d9-b8b0cd866bf2@intel.com>
 <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>
 <20231110120601.3mbemh6djdazyzgb@box.shutemov.name>
 <6feecf9e-10cb-441f-97a4-65c98e130f7a@linux.microsoft.com>
 <20231110124626.ifq3hqaiqvgpnign@box>
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231110124626.ifq3hqaiqvgpnign@box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2023 13:46, kirill.shutemov@linux.intel.com wrote:
> On Fri, Nov 10, 2023 at 01:27:08PM +0100, Jeremi Piotrowski wrote:
>>> Maybe just remove incorrect info and that's it?
>>>
>>
>> I disagree, other users and I find the print very useful to see which coco
>> platform the kernel is running on and which confidential computing features
>> the kernel detected. I'm willing to fix the code to report correct info.
> 
> For TDX, we already have "tdx: Guest detected" in dmesg. sme_early_init()
> can do something similar.
> 

That doesn't cover TDX guests with TD partitioning on Hyper-V.

