Return-Path: <linux-hyperv+bounces-5347-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64459AA9A5E
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 19:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7363B0BC9
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B1C26A0CA;
	Mon,  5 May 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o3Xvpqkr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D5320E6;
	Mon,  5 May 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465769; cv=none; b=Da44xmx1EGkcpPIfSzfS2oIJb7/JRzFfRa8Nn3pdpHsmbG2H2AOvIqKtiVwlB49eL7T0GJByVNgFSfFP006xC/4bf3huo7F9Y6ay1X8wXUCYHDNxcj6A5PBq5WG86VvtvdAWn6xEWO2z40pWra8YBr60ZTOpUp/n74fvKaY3fXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465769; c=relaxed/simple;
	bh=/6hVLI8+DjKNaFwujUdJzocF4Keqd/XofxvlfwZ7GqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2CKGSZFJaZd9Es9HPa5agiWrIJGUHVI3lyOHhxcLYDTeJN/G9ee58IVA1TI8DkBD8hhIUhuKkC9fBZC1Rvya/MwEokeXj6d1zkjaY5eSB4OH7ysz979NzeMr4odotKGbGxl0zWqqaDZt6CBY4Xt66gEUzT5UOGRlQYmKjBXsz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o3Xvpqkr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 90CBF2115DB9;
	Mon,  5 May 2025 10:22:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90CBF2115DB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746465767;
	bh=8wbZLCwRqjanmT3onroeSyZn4dg6J4CGYyBd5+Co/M0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o3XvpqkrhbAZmS9cmuI/bvnLDWHF69TtYCYYPAcla5AYtVVQvW87J+tYnvSnY/dru
	 9Ea4ys3iToWPHzYtbCrhtVh6syxBmC5MAtb0z/2586tl+1auNZoJFPUwtoCj8Os2J2
	 OK/C/oBjRn4vkzAALtMFMd5WbE7KtUDGvIIy7T+s=
Message-ID: <41778d44-19dc-4212-a981-d5a82eaf9577@linux.microsoft.com>
Date: Mon, 5 May 2025 10:22:47 -0700
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
 <aBUByjvfjLsPU_5f@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <aBUByjvfjLsPU_5f@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/2/2025 10:32 AM, Wei Liu wrote:
> On Wed, Apr 30, 2025 at 01:47:20PM -0700, Roman Kisel wrote:

[...]

>>   arch/x86/coco/sev/core.c           | 13 ++-----------
>>   arch/x86/hyperv/hv_vtl.c           | 12 ++----------
>>   arch/x86/hyperv/ivm.c              |  2 +-
>>   arch/x86/include/asm/apic.h        |  8 ++++----
>>   arch/x86/include/asm/mshyperv.h    |  5 +++--
>>   arch/x86/kernel/acpi/madt_wakeup.c |  2 +-
>>   arch/x86/kernel/apic/apic_noop.c   |  8 +++++++-
>>   arch/x86/kernel/apic/x2apic_uv_x.c |  2 +-
>>   arch/x86/kernel/smpboot.c          | 10 +++++-----
> 
> Since this is tagged as a hyperv-next patch, I'm happy to pick this up.
> 

Thank you very much, Wei!

> Some changes should be acked by x86 maintainers.

Tom and Thomas reviewed the patch, and the `scripts/get_maintainer.pl`
prints them as x86 maintainers. If I understand correctly what you're
saying, someone who sends patches from the x86 tree to Linus should add
Acked-by to the patch. Likely I should just wait until such person gets
to this patch.

If I'm misunderstanding, I'd appreciate a quick note to help me navigate
this :)

> 
> Thanks,
> Wei.
> 
-- 
Thank you,
Roman


