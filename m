Return-Path: <linux-hyperv+bounces-6664-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5DFB3B2B5
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 07:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216761C80101
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 05:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58A212567;
	Fri, 29 Aug 2025 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iyJOyVe7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171737404E;
	Fri, 29 Aug 2025 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756446779; cv=none; b=hryhmANg68WgUsGzgFxw5+UyEkty7zwrb+JUb9oo4GA3L/X5JXsOOSClwii6gaXXHaMHq15nQBE7KKVjRA8vXao9tkPlvL+9B9MvT070J+8l3lzG0K8aUizvQ+Hr7dEsf7Qa1J4Ai5fSRqgpICKJ0YEdTZEiSUsoMQSPTfdKCLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756446779; c=relaxed/simple;
	bh=LG8tzpGW4xmEbi+NqiDEg4/hoFt/I5LMddcB/akqt6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkv9+4DIEqocduKgXAZet1GlyDlFlNRZQQjP5/sf7t8wQUAc1YYlh6rjoZiEa8uMJxeuCgUsUyvbxhnKGgMXVIRpIIQAiNvb3ATOua0AM+2rNBIWKqjD2cyM6BKTJWJXvGww+Iygf8x4n+HxtKD74hkM3vsHdir8fT6T+vWCFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iyJOyVe7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.129.125] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 08EB1211080D;
	Thu, 28 Aug 2025 22:52:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08EB1211080D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756446771;
	bh=pgQVYTbJ2GLvLrSRzex4vEnPKoTWOLwxiHE6X1U+Qtk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iyJOyVe72o7jHGrUHNM+/cOH6ln7WpCgeCXdLjLz3xbcQbfRzu66dTaK3Nisze0zh
	 S1yWsE6JZGWoRdj6U6vQdDaWa5wgXpGBaEPw3LwP8mddxCuPidJKMFOQ/L9NzzPZTo
	 txCai/QP+h8QrPirBr5yQOEmbqlSJxni2L8RylFg=
Message-ID: <1bb599ee-fe28-409d-b430-2fc086268936@linux.microsoft.com>
Date: Fri, 29 Aug 2025 11:22:45 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] uio_hv_generic: Let userspace take care of interrupt
 mask
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>,
 Long Li <longli@microsoft.com>, stable@vger.kernel.org
References: <20250828044200.492030-1-namjain@linux.microsoft.com>
 <20250828080207.6d9d3426@hermes.local>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250828080207.6d9d3426@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/28/2025 8:32 PM, Stephen Hemminger wrote:
> On Thu, 28 Aug 2025 10:12:00 +0530
> Naman Jain <namjain@linux.microsoft.com> wrote:
> 
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
>> Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus")
>> Suggested-by: John Starks <jostarks@microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> Cc: <stable@vger.kernel.org>
> 
> Makes sense. I think the logic got carried over from uio.
> Does it need to make sure interrupt is masked by default to avoid
> races at startup?

No, initially I also figured that this would be required, and that's why
this was added in the first place. But my experiments with userspace
told me otherwise and I don't think this is required.

Thanks.

Regards,
Naman

