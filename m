Return-Path: <linux-hyperv+bounces-5197-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421ECA9F748
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 19:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3ED3AE7E4
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7780328F92A;
	Mon, 28 Apr 2025 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KA1aSlDG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FAD28F92E;
	Mon, 28 Apr 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745861193; cv=none; b=LeOSzcguJlMnyHC5GSynguMpL7ROiDxbcp0EXmHXA1qNev3tU1pOHRsNtv5dgrxJvfo4j/cASgHd6AVufNj1JPKya3uSorR1AB5PZtt0NrDKQ/FOyrLg+sr3mnSKwnWDjw6zvB7XFLyPvXBy9utJa7JPojbgX7HBC6+qA2UiZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745861193; c=relaxed/simple;
	bh=SmMhoffXqK5lFgsuCUxRFgviJ4w3YYRhp4ncDtar3kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/enlIuYzMbHyYtBacjhCKIv0EbbaIsPBdyF4gmy16bFs2GnoTiKq1e/T71PPoczKaWpwFII+vpZh1y9gttmCK/uXUFHAqznnODdXRS2y+KtISvGZC8bXw8+qisHh/vREtt0NPQKwvTXH47oykXFlRF2/zFdPm/vAbuRSy3tMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KA1aSlDG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 53F9820BCAD1;
	Mon, 28 Apr 2025 10:26:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 53F9820BCAD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745861191;
	bh=incaWFa4r0jzEYqcW4jYJnnsM7UwCGhmzrmcbqC2GKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KA1aSlDGRWrYrjf0ftjz5Q8jkXXEy5bhP98G69tM1baZS6323NnCsTcPiJXGxkF8q
	 GUmZeiljJPG8x6bwTHVcnO5q2+tQCuS0EMAF6qL4nZE5mg6pHb4x6LazqTroQMvZH3
	 RR377wkP0uPIoLW9UofamfT/Q2SR63Oi624mfiHw=
Message-ID: <53760b43-fd0f-4996-87cd-9615cdbc4618@linux.microsoft.com>
Date: Mon, 28 Apr 2025 10:26:31 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH hyperv-next] x86/hyperv: Fix APIC ID and VP
 ID confusion in hv_snp_boot_ap()
To: Wei Liu <wei.liu@kernel.org>
Cc: Saurabh Singh Sengar <ssengar@microsoft.com>, "bp@alien8.de"
 <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Allen Pais <apais@microsoft.com>,
 Ben Hillis <Ben.Hillis@microsoft.com>,
 Brian Perkins <Brian.Perkins@microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
References: <20250424215746.467281-1-romank@linux.microsoft.com>
 <aAsonR1r7esKxjNR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <KUZP153MB1444118E6199CBED8C78E6D4BE842@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <8fa1045a-c3e9-48e0-86fe-ab554d7475c8@linux.microsoft.com>
 <KUZP153MB14448BEFA81251661433CE33BE842@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <c57c6ce9-6ff8-431c-ab77-fa2c727fee09@linux.microsoft.com>
 <aAv6slMtA7Kioy_3@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <aAv6slMtA7Kioy_3@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/2025 2:12 PM, Wei Liu wrote:
> On Fri, Apr 25, 2025 at 11:22:08AM -0700, Roman Kisel wrote:
[...]
>>
>> Yep, I see the issue. Will resend the patch.
> 
> I have removed this from hyperv-fixes.

Thank you, Wei! I'm working on resolving feedback for v2.

-- 
Thank you,
Roman


