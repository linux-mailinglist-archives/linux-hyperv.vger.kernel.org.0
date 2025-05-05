Return-Path: <linux-hyperv+bounces-5349-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E36E1AA9B43
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 20:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF851893341
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 May 2025 18:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8FC26F44F;
	Mon,  5 May 2025 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjHbG1M6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0826E173;
	Mon,  5 May 2025 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746468739; cv=none; b=Gbkep3Q9LYL/TGYnK9HDA94jNYYcFfLCjbNC+Z1zeG2JHl10TeVfG6nX9FsNoHRdqvDbAmTlLLybfy/FONFuiHq2fH1Nwip4qTOKnhtCwUjYg8QC8KVk0IYGHe+Tcq6pqm6lJwo4spJZCbbMEPb8WRh50EvNntViydJGV//85NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746468739; c=relaxed/simple;
	bh=2EVHAdj4aDrTK4oOmI4zIjyY5SKv243A69kdLRzW7og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZhYPKS26MwGRxM6ceRQyRQX5ul3Jwqi7bR4rIKwlBHGpVHFZbUuQ2b8zooH7ESRWZlAX11uqMY2K0wGRCMUC2u5EnyIOBe1ljKWoPocoHvUGN8w4T8Weg6XIWmwkQ8QFxXXK5QsRc9zTX0E17OQZ0dSTEQMXbO7MIvyKwClgCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjHbG1M6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746468737; x=1778004737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2EVHAdj4aDrTK4oOmI4zIjyY5SKv243A69kdLRzW7og=;
  b=fjHbG1M63+w81azaIY0Fq92LlIyZoicrk9CH9DWDMhIwIb9j0hroBupE
   ZTJMXRseVeAfsXPBbD9KrdMdccNShVJyEkpZ9FM9ajste4r/dY5nUlO8t
   Sf+bZRG2vP9Wlovqj/XyxLfEGfTrbmWObprl8JBLc44gxb2Pj240M30BE
   sBKkQzuLqtNZw35r/Xiatj7ul2bQDcFlbKJo5l3FuUoVvj8uuNhZlLhuR
   Cuv2ASaymG66zl+0LVg4IkM+LBNkY/NstX12Xuu4oWTmUcRu9PYHMGIG9
   D5OtwyoKfv+46bAICkvqhZGD0lVmd8iaUL1BZY6wTV0KMvwrB7MN7AUzX
   Q==;
X-CSE-ConnectionGUID: VQclF3wHQT2wx6/HkHSfsg==
X-CSE-MsgGUID: sRkBY5gHStKXOv64L3QprQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="73484315"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="73484315"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:12:16 -0700
X-CSE-ConnectionGUID: /sFao4d8TUSilqbQ13QeTQ==
X-CSE-MsgGUID: S92fiF3DTbiSGYPAo8fliQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="172545899"
Received: from uaeoff-desk2.amr.corp.intel.com (HELO [10.124.221.35]) ([10.124.221.35])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:12:13 -0700
Message-ID: <8bb6418f-0131-4a75-aabe-c753841d116a@intel.com>
Date: Mon, 5 May 2025 11:12:10 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v3] arch/x86: Provide the CPU number in the
 wakeup AP callback
To: Wei Liu <wei.liu@kernel.org>, Roman Kisel <romank@linux.microsoft.com>
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
 <41778d44-19dc-4212-a981-d5a82eaf9577@linux.microsoft.com>
 <aBj895aOnhgsIiwO@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <aBj895aOnhgsIiwO@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/25 11:01, Wei Liu wrote:
> You don't need to do that for this patch. Please point me to Thomas'
> reply to the previous version and I can add the missing tag to patch
> while I queue it.

It's right here:

	https://lore.kernel.org/all/8734dnouq6.ffs@tglx/

It's pretty darn trivial to find if you do any of the following:

1. Read this thread in your mail reader that understands threads, or
2. Look at this thread on lore, or
3. Run "b4 am" on the thread

Sure, it can be kinda hard to do #1/#2 on gigantic threads if there are
a ton of replies from the maintainer. But there were 5 messages in this
thread and only one from Thomas.

I'd highly suggest adding one or more of those tools to your maintainer
toolbox! b4, especially, does all the work for you.

