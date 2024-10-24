Return-Path: <linux-hyperv+bounces-3187-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07E99AE2A0
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Oct 2024 12:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8DC2827FA
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Oct 2024 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C0A1C3029;
	Thu, 24 Oct 2024 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="joZBOyKu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65181BDAB9;
	Thu, 24 Oct 2024 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765928; cv=none; b=LUh8dxGGDlqahX/8pYwbtQ/tajvCNixqxf4UO1nqHKyLJx5vJUOgkztihC3MfaA4/CWdbhJloO9oAdKzWTqF5SP60yyBEZo53d5iBms682kogmZb4AuYPUmolN/EXUheDCWGa9/nGmcTCVj5mFKEkCUmuGdaDlBEuTG9KVh9asI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765928; c=relaxed/simple;
	bh=aDamS9doPBRLR6Ggl/up63h8nIFk5aVVZEMKj6e8j2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5VYvzRG3E9qQVKaT5aOCM3kcroxXx62VPxclnNKOMaPEltLSjFfm03JJ071qEg2CaWkCQIaeQIFMzKAQOrzNh1rBI4Qi39ISoDQzzQYxWEclN+WOutyZO30UyDh8ajSHsstkXrZYS8R7U9Q11T8slK2vRxGvzIHN9YuFqk9I8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=joZBOyKu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.162.181] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id B1851211130F;
	Thu, 24 Oct 2024 03:32:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1851211130F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729765926;
	bh=RbdDh/ajcppDH/amjYBDTQqNsnUzcLwMYAfwe2yKypw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=joZBOyKujxI1Q7s03l4y2gRml1ZuVsb45ll3Vq4mCK8avcAjBXdAJARsvGD1umfvx
	 wZHJVB1pVLklFIWtXpVx5RcoAI5G3W7y5A4f61kqMf6msF/EI6URrmqIkUrXsTUlDL
	 CvQoQkE3O5Fo/jeeC/99RWjVucB4FeT65bZ2QiNc=
Message-ID: <9c47c207-f77b-47b1-af4b-e6821e975391@linux.microsoft.com>
Date: Thu, 24 Oct 2024 16:02:02 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Wait for offers during boot
To: Michael Kelley <mhklinux@outlook.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 John Starks <jostarks@microsoft.com>,
 "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>
References: <20241018115811.5530-1-namjain@linux.microsoft.com>
 <20241018115811.5530-2-namjain@linux.microsoft.com>
 <20241021045724.GB25279@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <91756da8-f2c3-482a-95ee-6208e1205502@linux.microsoft.com>
 <SN6PR02MB41576455C9F38EAA1B5D7807D44C2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41576455C9F38EAA1B5D7807D44C2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/22/2024 11:08 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, October 22, 2024 2:55 AM
>>
>> On 10/21/2024 10:27 AM, Saurabh Singh Sengar wrote:
>>> On Fri, Oct 18, 2024 at 04:58:10AM -0700, Naman Jain wrote:
> 
> [snip]
> 
>>>>
>>>> +	/* Wait for the host to send all offers. */
>>>> +	while (wait_for_completion_timeout(
>>>> +		&vmbus_connection.all_offers_delivered_event, msecs_to_jiffies(10 * 1000)) == 0) {
>>>
>>> Nit: Can simply put 10000 instead of 10*1000
>>
>> Noted.
>>
> 
> If Easwar's patch can get "secs_to_jiffies()" added, that would be even better. :-)
> 
> Michael

Yes, that's true :)

Regards,
Naman

