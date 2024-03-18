Return-Path: <linux-hyperv+bounces-1775-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C14687EE95
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 18:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F085B1F23D6D
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10CD5579C;
	Mon, 18 Mar 2024 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h1pfMRex"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C88855790;
	Mon, 18 Mar 2024 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782222; cv=none; b=P3S7Bww4V/Vg11L8YelIsvC/RR4EmG9D9x2/sNDFQMAZAYuQxjebcC+xg05eiVx68512l18usjIv6Z414B8yiLW/TleQuBiPPMfDUbppucyMzMmZSC/JYzipl/AyqoNRQcc6cpB7Ff+LJhem/43uwTVM6ykcP/3ARFRacJh8nqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782222; c=relaxed/simple;
	bh=vDTqZKYF8IvJ3DljVKzXoNPrU7o1alGyUizdeOTNDuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGoHgM7r4F5pUjP3R/IOsGp1OLe+M2h2CGqglQaNkutNRFIpCWwQmHe6t/0xm+w63mOEKm+P/+Xd1VVFTAvCTHxI0WivTfWvqSpv699QZ/bEnrlBuKVAKQ6JRC7J/XZYJcmcs8jY6AQPYia3DXtvJCW7ZOcpl21ZQHxjvLtTawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h1pfMRex; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.232.101] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id BB2E920B74C0;
	Mon, 18 Mar 2024 10:17:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB2E920B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710782221;
	bh=oBaGphn3sgS15rqtIpRpiQQCVintTQGUoEgffbht8jc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h1pfMRex9JeFAIpEfLqo3Ru1rw8Fd+cuLioiO2U87gharO5NtItLjy89I4sXiZUl0
	 R58UuKXNooldgmFppgYSRNO+Dm3a803YuBiW8zm/gd0MuNSYE2rvM6tNnlOIaZfSVG
	 r3rMFReXC7MIVCvXlg54AqeGpJKrMac3Q4Efu17c=
Message-ID: <066c4b0c-c8a5-4abd-9456-20b0352ee1ab@linux.microsoft.com>
Date: Mon, 18 Mar 2024 10:16:59 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
Content-Language: en-CA
To: Ani Sinha <anisinha@redhat.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Olaf Hering <olaf@aepfle.de>, Shradha Gupta <shradhagupta@microsoft.com>
References: <1710729951-2695-1-git-send-email-shradhagupta@linux.microsoft.com>
 <9d24633d-b2bf-4cbe-86f7-6df56ba14657@linux.microsoft.com>
 <C740F1C4-CA2A-425B-8E60-0EF5C2C15270@redhat.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <C740F1C4-CA2A-425B-8E60-0EF5C2C15270@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/18/2024 10:12 AM, Ani Sinha wrote:
> 
> 
<snip>

>>> + }
>>> +
>>> + if (strlen(output_str)) {
>>> + output_str[strlen(output_str) - 1] = '\0';
>>
>> You don't need this since you're using strncat which adds its own '\0'.
> 
> If I understand this correctly, this code simply eliminates the extra “,” character in the end. Therefore it is needed.
> Since it is not obvious, in the previous review and before, I asked the author to add a comment to explain this clearly.
> 
>> I wasn't quite able to follow along 
>> on the discussion between Ani and you, so putting this in here in case it wasn't already mentioned.
>>

Ah, great, that makes sense. I did see that it was destroying data but didn't spend enough time to think through
what data it was destroying, and if that was a feature or a bug. Thanks for calling it out!

- Easwar




