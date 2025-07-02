Return-Path: <linux-hyperv+bounces-6069-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4A1AF0C0F
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jul 2025 08:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5123AF233
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jul 2025 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1884F219A8D;
	Wed,  2 Jul 2025 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZYpCyKkt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58631FE46D
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Jul 2025 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751439397; cv=none; b=AVagoebAHJuEuJPFtoG872MTNM/FtjvtvSKHfflhvGoPIFu9Ikpchc/4Hq8tCNt4uN9WQ14npX7gj4wjvYW5RS4xrVgpxMq5WRp4XzsFJFS35eAoxTO88wUYHur+/zGr7VAZOK1OWNLMUlNHG/mFDqeD1/oxiBmHHnYQTyWihmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751439397; c=relaxed/simple;
	bh=6cPAVd7hczo2QIix51p1gZOYXf4Yy2FRr3/QJ1Ncsdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgOQvWazEtwl3ihSlmqhtThcDLri9KIpK37rWCGrn+WFFtFMksgDUpDVH02BEQ3nCyXjz5Dme+CnRdKvrktK8LbV3zBiQUzWC+ZxOaQppAMBBt1Vn/uHUgRzUmQxy58/7TvC34zUweuq8K1azqZust9acE3Tn5yTUv7DaMJK2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZYpCyKkt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.65.159] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 26BE3201657A;
	Tue,  1 Jul 2025 23:56:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26BE3201657A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751439395;
	bh=jYjoFygznun8IiEWEdmOJt7XY2ZRBhTnuRyPsUcS1mQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZYpCyKktQsmD+fNyyavhaeGGpNG0pa9rlNcRLHUUtraogbLj/C824g9NJ/PktwGRB
	 GQ/TDZeZ99afUDkz/dssRIPsR+RWLEEEE6Xim4CnCpm3wooUVsNgB4ldWwitkhDzCn
	 hu6MV4ylKabiuSWwHOjnKfdjpYGHyI7i92fP+lfc=
Message-ID: <3a6ca6ab-cbd9-4e0d-b047-fbea405033b3@linux.microsoft.com>
Date: Wed, 2 Jul 2025 12:26:31 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v2] tools/hv: fcopy: Fix irregularities
 with size of ring buffer
To: Long Li <longli@microsoft.com>, Olaf Hering <olaf@aepfle.de>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>
References: <20250701104837.3006-1-namjain@linux.microsoft.com>
 <20250701131532.125b960c.olaf@aepfle.de>
 <DS2PR21MB51813681D55C8833729D6954CE40A@DS2PR21MB5181.namprd21.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <DS2PR21MB51813681D55C8833729D6954CE40A@DS2PR21MB5181.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/2/2025 12:02 PM, Long Li wrote:
>> Subject: [EXTERNAL] Re: [PATCH v2] tools/hv: fcopy: Fix irregularities with size of
>> ring buffer
>>
>> Tue,  1 Jul 2025 16:18:37 +0530 Naman Jain <namjain@linux.microsoft.com>:
>>
>>> +		syslog(LOG_ERR, "Could not determine ring size, using
>> default: %u bytes",
>>> +		       HV_RING_SIZE_DEFAULT);
>>
>> I think this is not an actionable error.
>> Maybe use the default just silently?
>>
> 
> How about just fail fcopy?
> 
> This will have a consistent behavior.
> 
> Long

I am OK with that as well. I provided an explanation regarding best
effort fallback mechanism in my other reply in this thread.

 From silently ignoring it (1) to failing fcopy (2), or simply logging 
as info (3), I would personally prefer either (2) or (3) or keep it in
current form. I'll wait for this discussion to conclude though since we
have varied opinions on this.

Regards,
Naman

