Return-Path: <linux-hyperv+bounces-5414-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC38AAE765
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 19:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A2A7AEADA
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492E828C006;
	Wed,  7 May 2025 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r+9GXfG8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA7289361;
	Wed,  7 May 2025 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637649; cv=none; b=P6xgpl1VUFR6f8TFBERSDAM909OW+s8LHCqTFtFl3N83VQCaBfzDTjT0IjbB5OizANBwJQ9Y/4T3MQLdO6U9y5KrIyIq1qmNiMYBoftFqFVf33MI6pZY46o/EGoJkyHzX07by11X4dAvGzEsXdMloUZYv4u2XrmPveeFKRFl0Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637649; c=relaxed/simple;
	bh=ZAeBIInxRDk0JjceYJ5nfLOCipMU/kiZnDbJqxCcXA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tk8XwpUGxCCvL9NOKCD0tenKW+TO1IDZ+/QJlIdiPX2/r03o/VeLWdskgQH7alJ90/WzyyIvifrMH0qgCfF4IlDai7bEBmV408O/4iU6LP2BPJFZvT5CHCV3+YeeKEUJmkmyDe51lbbmL7HFl07V5fiRk+GFdUHFnPyo8uQirks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r+9GXfG8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id F18A121199CC;
	Wed,  7 May 2025 10:07:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F18A121199CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746637647;
	bh=dJhcMfKRu4+UGyqD7ovmVZwM69P8Veulgfr2jLnleuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r+9GXfG8FhrdPPXfg1bReS5N0GwmGU0A9GInvcMi9GqLfOrTkQGkLZdutP/pe3JOb
	 HwKEGOcUureqf8NLxyWuQ/CcWQSzkzr6jYzkYn/gLFXYG8MJOxKNVVSFcCZa3T29Up
	 mdxh06iUb33SYSzx+WgNPaNFGCi34dm7fSL74lnw=
Message-ID: <3b0c3732-ccf6-4133-b55c-4177532ebecb@linux.microsoft.com>
Date: Wed, 7 May 2025 10:07:27 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v3] arch/x86: Provide the CPU number in the
 wakeup AP callback
To: Wei Liu <wei.liu@kernel.org>
Cc: ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
 decui@microsoft.com, dimitri.sivanich@hpe.com, haiyangz@microsoft.com,
 hpa@zytor.com, imran.f.khan@oracle.com, jacob.jun.pan@linux.intel.com,
 jgross@suse.com, justin.ernst@hpe.com, kprateek.nayak@amd.com,
 kyle.meyer@hpe.com, kys@microsoft.com, lenb@kernel.org, mingo@redhat.com,
 nikunj@amd.com, papaluri@amd.com, perry.yuan@amd.com, peterz@infradead.org,
 rafael@kernel.org, russ.anderson@hpe.com, steve.wahl@hpe.com,
 tglx@linutronix.de, thomas.lendacky@amd.com, tim.c.chen@linux.intel.com,
 tony.luck@intel.com, xin@zytor.com, yuehaibing@huawei.com,
 linux-acpi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
References: <20250430204720.108962-1-romank@linux.microsoft.com>
 <aBl62kTEAnR790KF@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <aBr8cNXD630JbIxP@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <aBr8cNXD630JbIxP@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/6/2025 11:23 PM, Wei Liu wrote:
> On Tue, May 06, 2025 at 02:58:34AM +0000, Wei Liu wrote:
>> On Wed, Apr 30, 2025 at 01:47:20PM -0700, Roman Kisel wrote:
>>> When starting APs, confidential guests and paravisor guests
>>> need to know the CPU number, and the pattern of using the linear
>>> search has emerged in several places. With N processors that leads
>>> to the O(N^2) time complexity.
>>>
>>> Provide the CPU number in the AP wake up callback so that one can
>>> get the CPU number in constant time.
>>>
>>> Suggested-by: Michael Kelley <mhklinux@outlook.com>
>>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>>
>> Queued to hyperv-next. Thanks.
> 
> This patch broke linux-next. I have dropped it. Please change
> numachip_wakeup_secondary.
> 

Thanks for your help! Working on that.

> Wei.

-- 
Thank you,
Roman


