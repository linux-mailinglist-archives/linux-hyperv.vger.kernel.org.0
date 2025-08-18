Return-Path: <linux-hyperv+bounces-6550-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C65B29C1E
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Aug 2025 10:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C55E189A84A
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Aug 2025 08:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99366301472;
	Mon, 18 Aug 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EnbwmqsT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D163009EF;
	Mon, 18 Aug 2025 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505494; cv=none; b=fsB51JBsuOeRM84Q+FrPbj26its63EgoFVpuX6Evjq6CwNtAX8nl2Wlcnui2Pp1DJXSNRskdXfHzcKZSAZ+1VO2Sp3Kz152lhNKS8dePTMIDePGmGGAkdOOF4hsLalwX4dUBLI/ywSijJfhn6jEnX1vOzM7++eM03o/p+6DWHt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505494; c=relaxed/simple;
	bh=xlB/c3ii8ixrjcNOv1m4SuGfyXJU/37Awo78snWkWUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpLOhplTGbK9qjWB+MhGkuswbCKqWvqEUT8/oXm0LzCd+ypJ+lQyIKjB9RB1MPEbpm3Ri1DxbdgU3F1t0FCjf3o42tzb//87jVWsUlHl1hS1UaNzjsYEEmauf4XMAa4K7xakOZ27hk8DK/rewQGj5k87y3q3bl08Nne4qDeXCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EnbwmqsT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.64.75] (unknown [167.220.238.11])
	by linux.microsoft.com (Postfix) with ESMTPSA id 13C99207862F;
	Mon, 18 Aug 2025 01:24:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13C99207862F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755505492;
	bh=/jlfaWonm29ltGslm5MGY6BGwhM5xbqoIL1BJLz2SqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EnbwmqsTGw10RBWdBi1tFyLCwmqCUJrex6wfxpbmRAHPqCpKveRzmghpWyNgzVjgA
	 q0ONOz53CRREzUxynOsGoEM2N0JKIbnbOQDn7THmsC9P1hZYa0ihD9YqFTEQIxgBxg
	 MTu2tpkr4mnOZ+Tu7/mPxraSLhJJaUNVvMJou8Zs=
Message-ID: <8b997c95-8ecb-49e0-a6fd-7f855068570c@linux.microsoft.com>
Date: Mon, 18 Aug 2025 13:54:47 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uio_hv_generic: Let userspace take care of interrupt mask
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Starks <jostarks@microsoft.com>
References: <20250818064846.271294-1-namjain@linux.microsoft.com>
 <2025081810-faculty-ceramics-42eb@gregkh>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <2025081810-faculty-ceramics-42eb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/18/2025 12:55 PM, Greg Kroah-Hartman wrote:
> On Mon, Aug 18, 2025 at 12:18:46PM +0530, Naman Jain wrote:
>> Remove the logic to set interrupt mask by default in uio_hv_generic
>> driver as the interrupt mask value is supposed to be controlled
>> completely by the user space. If the mask bit gets changed
>> by the driver, concurrently with user mode operating on the ring,
>> the mask bit may be set when it is supposed to be clear, and the
>> user-mode driver will miss an interrupt which will cause a hang.
>>
>> For eg- when the driver sets inbound ring buffer interrupt mask to 1,
>> the host does not interrupt the guest on the UIO VMBus channel.
>> However, setting the mask does not prevent the host from putting a
>> message in the inbound ring buffer. So let’s assume that happens,
>> the host puts a message into the ring buffer but does not interrupt.
>>
>> Subsequently, the user space code in the guest sets the inbound ring
>> buffer interrupt mask to 0, saying “Hey, I’m ready for interrupts”.
>> User space code then calls pread() to wait for an interrupt.
>> Then one of two things happens:
>>
>> * The host never sends another message. So the pread() waits forever.
>> * The host does send another message. But because there’s already a
>>    message in the ring buffer, it doesn’t generate an interrupt.
>>    This is the correct behavior, because the host should only send an
>>    interrupt when the inbound ring buffer transitions from empty to
>>    not-empty. Adding an additional message to a ring buffer that is not
>>    empty is not supposed to generate an interrupt on the guest.
>>    Since the guest is waiting in pread() and not removing messages from
>>    the ring buffer, the pread() waits forever.
>>
>> This could be easily reproduced in hv_fcopy_uio_daemon if we delay
>> setting interrupt mask to 0.
>>
>> Similarly if hv_uio_channel_cb() sets the interrupt_mask to 1,
>> there’s a race condition. Once user space empties the inbound ring
>> buffer, but before user space sets interrupt_mask to 0, the host could
>> put another message in the ring buffer but it wouldn’t interrupt.
>> Then the next pread() would hang.
>>
>> Fix these by removing all instances where interrupt_mask is changed,
>> while keeping the one in set_event() unchanged to enable userspace
>> control the interrupt mask by writing 0/1 to /dev/uioX.
>>
>> Suggested-by: John Starks <jostarks@microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/uio/uio_hv_generic.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> What commit id does this fix?

This is supposed to fix the first commit that introduced this driver - 
95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus").

Will add the Fix tag in next version.

Thanks,
Naman

