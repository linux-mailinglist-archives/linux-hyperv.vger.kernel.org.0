Return-Path: <linux-hyperv+bounces-3621-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57352A0671D
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 22:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D71188A7A3
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 21:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3DD2040B5;
	Wed,  8 Jan 2025 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hg3kOA1E"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865EA202C4D;
	Wed,  8 Jan 2025 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736371334; cv=none; b=ClkV6PmsxHYxu0aBIVMggoHoIKLpnVv0KXZzfWjCkbwG1S++8xdcHJhRWtcJxSs5eenf52orn4P9aeTUzB60oWnqHirO8eDZrlxG/Ke+o9lOH/vyRPkxXcI87Ufd9C6C7FoG6jarFBq7nCsYLfjjRrfrADP34L2qk6G1955Mllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736371334; c=relaxed/simple;
	bh=3sZmD3MUtSWHjOHTIi/7DgrWrdpZat9hqC371zbjSko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNuttD8iSMtR7jw5rcJt4IMf//B+q/uRaYOG9FqQJZyTJDID3dSDpaAg/0gllvbqxK0i5IQbextE5fkPkDtyIc0HWZ7pSk2odF9DfssVlF0J0k2hY9zMNiRk7MoUV7nY1j2AuFCK9oJxfwC4tL5Jnrnm6J45dtsEqDVvHCBD1bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hg3kOA1E; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id E18ED203E3A8;
	Wed,  8 Jan 2025 13:22:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E18ED203E3A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736371333;
	bh=qq1qKbd1CKaYhLGdSDtFE/jo0eaFj/cY+inJsoOkpxA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hg3kOA1EDOb1NzB5LabzMKFG2nY42FnTCsRciZ8q4IbkCPdFY68pZ9lh7VvVt0Nfa
	 3J6/1YY4LmqbroWHdjGGXIqERqrDl14BC/TJ77YaMuh+fhbLG3jKSc1uqkl1MFYHNl
	 PF4oCmpSCOp6gVFZVZ1bQAf5GckznBjEZWmtJJYo=
Message-ID: <729f82d5-804c-417c-a050-29682fd5eed8@linux.microsoft.com>
Date: Wed, 8 Jan 2025 13:22:13 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
 decui@microsoft.com, eahariha@linux.microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <b4a27944-7622-429c-9e59-602f727363b2@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <b4a27944-7622-429c-9e59-602f727363b2@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/8/2025 1:08 PM, Nuno Das Neves wrote:
> On 12/30/2024 10:09 AM, Roman Kisel wrote:

[...]

> Replying in a new thread since I don't have all the context about the different
> VTL code paths that may need to converge. To my perspective, the approach in this
> patch seems perfectly reasonable to fix the current issue.
> 
> One small improvement might be to put this check into a helper function. That would
> make it easier to amend later when/if a clearly better solution is proposed.
> 
> Something like:
> 
> static inline bool hv_output_page_exists()
> {
> 	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
> }

Will apply, thank you for the suggestion, Nuno!

> 
> Thanks
> Nuno

-- 
Thank you,
Roman


