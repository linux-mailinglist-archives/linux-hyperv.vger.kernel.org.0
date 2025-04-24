Return-Path: <linux-hyperv+bounces-5094-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5BEA9B396
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 18:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0E21BA4636
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37E5F510;
	Thu, 24 Apr 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e2mu47aY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC6127FD48;
	Thu, 24 Apr 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511198; cv=none; b=Hg12UQqwMjgWrlkN/JbhmfFec8MaHw5Vthbn+idewcaeIVV/i25lSdAtspwwTVw7oP8FPEpUTF3/QUOVrqn8tBatgj6XmYsJOX1T9QM2IEyncVxw6ACBO6oERZN8tjDMJPdUJF95Ib+XawSQ0i9/CDEm8kKzymJspq+cFRdqZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511198; c=relaxed/simple;
	bh=3noiHdyd2JCAd/6QIFXAoWSAAz5mb20nUGdiGcPno/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2gDilQRxVgmfMJpsbw38hnvD0LFtUZunaXFyFlo8RTWyK+ftM89oNwa3DHXmzVSN0JS7S7TVgFaEEFREbSpXl8L/+dKOLpflfvhnDyXjG1E3NC52u1tult4dX3kRh2m6N9WfpRb4eUvqb0WDwFcS1tpTug72oEmBG0g6cKMKng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e2mu47aY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.64.200] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1635C211309F;
	Thu, 24 Apr 2025 09:13:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1635C211309F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745511195;
	bh=HlrTCuefG8icNM178F2xHTwz+FhhL/89lhLddGCpFVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e2mu47aYdXmSDl+GBPuoYunnHqcFyTVlbYFM4gIescaq6UtZkh/uzZ68DOJm4cFcY
	 b54QZecIgYniCe3OChcPYYJnHn9LFE3BK7iZwbx2DLuXjtprS0ozp4t2ODNXgj/Gb7
	 OjyCKGIjRrcbnof+RYeWIcc8DdYkaFBy2YIu4SzM=
Message-ID: <5ac09e74-8a30-47f7-b0e3-9e759ee98f00@linux.microsoft.com>
Date: Thu, 24 Apr 2025 21:43:09 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] uio_hv_generic: Fix ring buffer sysfs creation
 path
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@kernel.org" <stable@kernel.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>
References: <20250424053524.1631-1-namjain@linux.microsoft.com>
 <SN6PR02MB415788B8A1C18603497A9653D4852@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415788B8A1C18603497A9653D4852@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/2025 7:18 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, April 23, 2025 10:35 PM
>>
>> Hi,
>> This patch series aims to address the sysfs creation issue for the ring
>> buffer by reorganizing the code. Additionally, it updates the ring sysfs
>> size to accurately reflect the actual ring buffer size, rather than a
>> fixed static value.
>>
>> PFB change logs:
>>
>> Changes since v5:
>> https://lore.kernel.org/all/20250415164452.170239-1-namjain@linux.microsoft.com/
>> * Added Reviewed-By tags from Dexuan. Also, addressed minor comments in
>>    commit msg of both patches.
>> * Missed to remove check for "primary_channel->device_obj->channels_kset" in
>>    hv_create_ring_sysfs in earlier patch, as suggested by Michael. Did it
>>    now.
> 
> Ah, OK :-) I thought you had decided to leave the test in, and I wasn't going to
> argue further, as it didn't hurt anything. But the test is superfluous, so the
> code is better without it. It won't mislead a future someone into thinking
> that it solves a synchronization problem.
> 
> Michael

I agree :D

Regards,
Naman

> 
>> * Changed type for declaring bin_attrs due to changes introduced by
>>    commit 9bec944506fa ("sysfs: constify attribute_group::bin_attrs") which
>>    merged recently. Did not use bin_attrs_new since another change is in
>>    the queue to change usage of bin_attrs_new to bin_attrs
>>    (sysfs: finalize the constification of 'struct bin_attribute').
>>


