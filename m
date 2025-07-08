Return-Path: <linux-hyperv+bounces-6136-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1509AFC1EF
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 07:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315984A5023
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 05:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A701C5D77;
	Tue,  8 Jul 2025 05:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="fQ1NQV0g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867821401B;
	Tue,  8 Jul 2025 05:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951866; cv=none; b=cHoPnBmQv4ev3KqYCTzHDT0va59aBxoqurdMIQ9WtYPL9xpjjYbKvoZ+ZkAzsKej7VCLfL6os5Vm3H/jZX6EAoNQO0QuCF7LRwVqbfqkVF6ikt12NtEx2eX4jA9veAPWBaEf2HGbiyC4wSKMz+wak3ESeRxvEjcjKR40PthqG84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951866; c=relaxed/simple;
	bh=59y7qEw4GpHqR9V5yVAvN9k1VJ4Mks0dolgkvU2v08Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCRm/Rkgg5wrFE9ZxItkp2FJmz0nL2940YocabN84cBJ7P8a3CuByNyPShm2gTZFYRwcoaPtX76E4UUvPjHHKbRBS8GLVdGZ4vG7f6YpE682VhzI8MaSLfur+P6MYy8nDuN36toTKbSiPXO0ZZKgkO1gIJX6OJFBD8LiqwQExvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=fQ1NQV0g; arc=none smtp.client-ip=115.124.28.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1751951858; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ll42IxvjGlWNCvhre5iXoxCnMkwXG5zTYn4NRTnJbTc=;
	b=fQ1NQV0gOfvv4zK1Fip/DQ6VhcY4HG/Ffc7BrIqkhhSwsKjLJYY6fZcYqlreNmaHfXJkDFcgX9ObKGKTvUEavXPWhAwCmG584LtKL3TKw1RjNujiKSfha9uCLN3xzxnqthJ3cFIa2mPhTMdJ/IOuzTpAoKzy3ROm/ukwZKgEzbw=
Received: from 30.172.244.77(mailfrom:niuxuewei.nxw@antgroup.com fp:SMTPD_---.dhG9apK_1751951856 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 13:17:37 +0800
Message-ID: <aaac1fda-7365-4643-b8df-df6412a42891@antgroup.com>
Date: Tue, 8 Jul 2025 13:17:36 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
To: Stefano Garzarella <sgarzare@redhat.com>,
 Xuewei Niu <niuxuewei97@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com
References: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
 <20250706-siocinq-v5-1-8d0b96a87465@antgroup.com>
 <xphwpqqi42w5b3jug3vfooybrlft3z5ewravl7jvzci7ogs3nh@5i7yi66dg7fa>
Content-Language: en-US
From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
In-Reply-To: <xphwpqqi42w5b3jug3vfooybrlft3z5ewravl7jvzci7ogs3nh@5i7yi66dg7fa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/7/7 21:42, Stefano Garzarella wrote:
> On Sun, Jul 06, 2025 at 12:36:29PM +0800, Xuewei Niu wrote:
>> When hv_sock was originally added, __vsock_stream_recvmsg() and
>> vsock_stream_has_data() actually only needed to know whether there
>> is any readable data or not, so hvs_stream_has_data() was written to
>> return 1 or 0 for simplicity.
>>
>> However, now hvs_stream_has_data() should return the readable bytes
>> because vsock_data_ready() -> vsock_stream_has_data() needs to know the
>> actual bytes rather than a boolean value of 1 or 0.
>>
>> The SIOCINQ ioctl support also needs hvs_stream_has_data() to return
>> the readable bytes.
>>
>> Let hvs_stream_has_data() return the readable bytes of the payload in
>> the next host-to-guest VMBus hv_sock packet.
>>
>> Note: there may be multpile incoming hv_sock packets pending in the
> 
> s/multpile/multiple

Will do.

Thanks,
Xuewei

>> VMBus channel's ringbuffer, but so far there is not a VMBus API that
>> allows us to know all the readable bytes in total without reading and
>> caching the payload of the multiple packets, so let's just return the
>> readable bytes of the next single packet. In the future, we'll either
>> add a VMBus API that allows us to know the total readable bytes without
>> touching the data in the ringbuffer, or the hv_sock driver needs to
>> understand the VMBus packet format and parse the packets directly.
>>
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>> ---
>> net/vmw_vsock/hyperv_transport.c | 17 ++++++++++++++---
>> 1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>> index 31342ab502b4fc35feb812d2c94e0e35ded73771..432fcbbd14d4f44bd2550be8376e42ce65122758 100644
>> --- a/net/vmw_vsock/hyperv_transport.c
>> +++ b/net/vmw_vsock/hyperv_transport.c
>> @@ -694,15 +694,26 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
>> static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>> {
>>     struct hvsock *hvs = vsk->trans;
>> +    bool need_refill;
>>     s64 ret;
>>
>>     if (hvs->recv_data_len > 0)
>> -        return 1;
>> +        return hvs->recv_data_len;
>>
>>     switch (hvs_channel_readable_payload(hvs->chan)) {
>>     case 1:
>> -        ret = 1;
>> -        break;
>> +        need_refill = !hvs->recv_desc;
>> +        if (!need_refill)
>> +            return -EIO;
>> +
>> +        hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
>> +        if (!hvs->recv_desc)
>> +            return -ENOBUFS;
>> +
>> +        ret = hvs_update_recv_data(hvs);
>> +        if (ret)
>> +            return ret;
>> +        return hvs->recv_data_len;
>>     case 0:
>>         vsk->peer_shutdown |= SEND_SHUTDOWN;
>>         ret = 0;
>>
>> -- 
>> 2.34.1
>>


