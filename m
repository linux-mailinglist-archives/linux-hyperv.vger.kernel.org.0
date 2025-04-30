Return-Path: <linux-hyperv+bounces-5264-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A82AA5550
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 22:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50AB1C257D6
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 20:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA7429C354;
	Wed, 30 Apr 2025 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ydLFA15L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yVYQFiLz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE26296FCF;
	Wed, 30 Apr 2025 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043425; cv=none; b=bExdP6EeKS0Wgss2iBRCf7hlyIipRgKY89gMUEVtIe1M6HPNDOIIW4PUlWjm4Ghn+20crnQuvXuyC7py0PqCqXvQyVDOhOB+Yz3P5qGphZRsVkpX8nW9nDmu2gF+Jo6PI6XyhEzkeh/GoQAVsqBAwmfgKEj+UKsjJrSDks0KEZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043425; c=relaxed/simple;
	bh=deJj9yxghJsTZ5cGCburcB6ndZph1fm7MtG9MEQ78oE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gATqns2jQmY5gquI84tLqHKSnbA45u+UwgJlFULmLxzgZ08R6B3eDADDgA5VzWHvBiQsmrM27JDmzhEArO926cVFpKlHSEpMVqBxPABX8M5PdLWQcI+JKsY1Ddl1VCGWEI9yjPcTxPKmQzVfpzzU6Drk5jLb1DCqZESNC0A1Jw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ydLFA15L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yVYQFiLz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746043421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vkjyiEt/VrH94utziasQNj1s46pVyPhG0946cAV1LtM=;
	b=ydLFA15LCvA4L1rkDqnw5N0hZjlH3xlOGZiWt3OIBZcj4YkDM1IZ1AkiZV5EWkYBDJXJsL
	XltT/5ZIH8vokbS453JuLNLGYEMdh9BWnmoHFlt7PKCn+vNQ4ZUEeJzJ55pbVn36Bo1mJD
	qK3JhWCHwSXTbM+zNohHvFcPtOULqYZICoD293vErVx8gtPl43qpcZ5nQHkFFP6JWJaEOl
	ol0p76u0Dw0KFlOBjkU6TN+B+E2aMCUfD9/Ug1loee801YLpsTuNrWgV9lHW3rDewB6RU4
	j32eidgOxdJJCJljVd/IGUgw74QzlP7wx0LbargxgLV5SsIxdorIlYPHmyPpYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746043421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vkjyiEt/VrH94utziasQNj1s46pVyPhG0946cAV1LtM=;
	b=yVYQFiLzHU6Ny3btoCcgcDJQbV7g+dtWPxprfEuJQWoPReT9E+6bKcCvb4TYpzfk288NOQ
	VSLDMbZEn+tVREBw==
To: Tom Lendacky <thomas.lendacky@amd.com>, Roman Kisel
 <romank@linux.microsoft.com>, ardb@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com,
 dimitri.sivanich@hpe.com, haiyangz@microsoft.com, hpa@zytor.com,
 imran.f.khan@oracle.com, jacob.jun.pan@linux.intel.com, jgross@suse.com,
 justin.ernst@hpe.com, kprateek.nayak@amd.com, kyle.meyer@hpe.com,
 kys@microsoft.com, lenb@kernel.org, mingo@redhat.com, nikunj@amd.com,
 papaluri@amd.com, perry.yuan@amd.com, peterz@infradead.org,
 rafael@kernel.org, russ.anderson@hpe.com, steve.wahl@hpe.com,
 tim.c.chen@linux.intel.com, tony.luck@intel.com, wei.liu@kernel.org,
 xin@zytor.com, yuehaibing@huawei.com, linux-acpi@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v2] arch/x86: Provide the CPU number in the
 wakeup AP callback
In-Reply-To: <15be9f01-717f-51a1-6a5b-3bc4335d2506@amd.com>
References: <20250430161413.276759-1-romank@linux.microsoft.com>
 <87cyctphqo.ffs@tglx> <15be9f01-717f-51a1-6a5b-3bc4335d2506@amd.com>
Date: Wed, 30 Apr 2025 22:03:41 +0200
Message-ID: <877c31pgbm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 30 2025 at 14:44, Tom Lendacky wrote:
> On 4/30/25 14:33, Thomas Gleixner wrote:
>> bool __weak arch_match_cpu_phys_id(int cpu, u64 phys_id)
>> {
>> 	return (u32)phys_id == cpu;
>> }
>
> There is an x86 version of this function in arch/x86/kernel/cpu/topology.c
> that overrides the __weak definition and does:
>
> bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
> {
> 	return phys_id == (u64)cpuid_to_apicid[cpu];
> }

Oops. I missed that somehow. So yes, aside of the signed/unsigned thing
this looks fine.

Thanks,

        tglx



