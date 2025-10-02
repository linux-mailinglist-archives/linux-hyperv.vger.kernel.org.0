Return-Path: <linux-hyperv+bounces-7066-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F12BB5952
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Oct 2025 01:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3D83C6A85
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 23:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87ED1B0F1E;
	Thu,  2 Oct 2025 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bHPSYCMi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A393207;
	Thu,  2 Oct 2025 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759446415; cv=none; b=lVdF97qJQmTRM/LwEhXJbAwiwrQr1/r8VbBEM+gQKTekD9IZ7bKhOOLJ9gZ2YlG6A5kuv4pp6qV5ynoa7pQJkdRvvmb64vufsoMAjtvMJ3bsT0bTzH7wbiGJSM5bZn8WyYg8RWMRtBV3eQudyCEr4zKxNuyaYvSLwN7kQXouAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759446415; c=relaxed/simple;
	bh=StOXWqQIDIc3EfxAJO76K/F/sK2oVwNJB7HYiYqpcWU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QeeIdcuw5Ao9CW++7/116MqY6KQ7KQVeJi5bB5EbuLVDdKrrQzLHir0tTp75rimPuDs8S8dJ1LoIOtQwICoJ0QL1OzRLK+1BRybg2ckhriYml4RvhMhbqdBvjN2PMWASsR1G7g4VC9rrg2wewT9ksK7cdlJFUxkC42ylPEBTGJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bHPSYCMi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.160.245] (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3C4B6211B7D2;
	Thu,  2 Oct 2025 16:06:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C4B6211B7D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759446413;
	bh=G9ZIN578Xhmj29vW8aNiP5byoPPk/Bbt9VMvdrQm3p8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bHPSYCMisY0yknp9sPOulSUBz7mR6TN1Vktk8VqkfJysVjBtIzd5plJ2E/emJJkh2
	 c1iNv+dkSAAf3VPIE3G/mK2egjxlhQwkKivQ1HaqDflEI8mmi3tOj7CyCVbV7YaUR5
	 2DbjgH2CfMyxPWwARr9OWlYTrJT/h174TPswCgK0=
Message-ID: <37f0002a-a107-458b-933d-55f2cf96f5f1@linux.microsoft.com>
Date: Thu, 2 Oct 2025 16:06:51 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: easwar.hariharan@linux.microsoft.com, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: Use -ETIMEDOUT for HV_STATUS_TIME_OUT
 instead of -EIO
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
References: <20251002221347.402320-1-easwar.hariharan@linux.microsoft.com>
 <aN7-ryUqFNpgsIzI@skinsburskii.localdomain>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <aN7-ryUqFNpgsIzI@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2025 3:37 PM, Stanislav Kinsburskii wrote:
> On Thu, Oct 02, 2025 at 10:13:46PM +0000, Easwar Hariharan wrote:
>> Use the -ETIMEDOUT errno value as the correct 1:1 match for the
>> hypervisor timeout status
>>
> 
> The commit message should answer the question why this change is being
> made.
> Is there a practical reason for this or is it only for consistensy?
> 
<snip>

It's for consistency and because it's a better match. See my sibling response
for other error codes that I can also fix in a v2.

Thanks,
Easwar (he/him)

