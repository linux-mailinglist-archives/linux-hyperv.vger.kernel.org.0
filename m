Return-Path: <linux-hyperv+bounces-6139-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E60FFAFC26C
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 08:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A774A4471
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 06:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB5121D5B6;
	Tue,  8 Jul 2025 06:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="M6lAkofx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617FC35962;
	Tue,  8 Jul 2025 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751954814; cv=none; b=ijiPlY31IXbzcJ1Imgk/6ZLjKc3X86O4tKAYRv+rabqlNACbLmNb8fZOp01X+86kBTmfI9QyRDwEWsuNNz+rZ78rSFL1gqLHlfMq2alpnqZFAmBYF9i+QZapDwbxgCIAOQcY6+UBWe/wMiGwMKXH757A92Wqgi+0R6CRYY1n/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751954814; c=relaxed/simple;
	bh=mIOs9ZQv+Dge62egFi7/FYpUbNceMjDUj5FMhCzPzvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rr+C8zL4WcXLk7Qws22RlWoXt5OEYDNz252AZx4M5mEkWPY0xbUho9dG1gw8kb6M8I9lg3VLew0z4yaTnqsxbf1YdCKuyrIqr3FWEzYSnTh3Erir0iZ8az5PjmvmUypuBVqceada2d8laOd7/icr+dkpMJ6yC77J8NzSqV9oBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=M6lAkofx; arc=none smtp.client-ip=115.124.28.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1751954799; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5JEqIO5uBY95Voa4tTrXdXEV+OOCe7hAnim8ZON5228=;
	b=M6lAkofxCxoUdow3haGpU5j92GzWIdnZOogE2sEe7d24vi3UFMnJkN60DHVhPprGYUdTDEZE6yllLquZBsduar4YCuqqkb0n+gU6sYAKitfsEjQhZjEPv9G2V9ZYr4kcNsOFA+lwOMOsAuJ0h7z2bA8pTjKvNMYvPxIfODwWdOo=
Received: from 30.172.244.77(mailfrom:niuxuewei.nxw@antgroup.com fp:SMTPD_---.dhEfNgk_1751951111 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 13:05:12 +0800
Message-ID: <0a969517-ba41-4aa9-8f1b-471422cc2593@antgroup.com>
Date: Tue, 8 Jul 2025 13:05:10 +0800
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
 <xhzslzuxrhdoixffmzwprn254ctolimj7giuxj4nfrfg23eesy@ycpe6kma5vih>
Content-Language: en-US
From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
In-Reply-To: <xhzslzuxrhdoixffmzwprn254ctolimj7giuxj4nfrfg23eesy@ycpe6kma5vih>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/7/7 21:40, Stefano Garzarella wrote:
> On Sun, Jul 06, 2025 at 12:36:29PM +0800, Xuewei Niu wrote:
> 
> Again, this patch should have `From: Dexuan Cui <decui@microsoft.com>` on first line, and this is done automatically by `git format-patch` (or others tools) if the author is the right one in your branch.
> I'm not sure what is going on on your side, but you should avoid to reset the original author.
> Applying this patch we will have:
> 
>     commit ed36075e04ecbb1dd02a3d8eba5bfac6469d73e4
>     Author: Xuewei Niu <niuxuewei97@gmail.com>
>     Date:   Sun Jul 6 12:36:29 2025 +0800
> 
>         hv_sock: Return the readable bytes in hvs_stream_has_data()
> 
> This is not what we want, right?
> 
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
>> VMBus channel's ringbuffer, but so far there is not a VMBus API that
>> allows us to know all the readable bytes in total without reading and
>> caching the payload of the multiple packets, so let's just return the
>> readable bytes of the next single packet. In the future, we'll either
>> add a VMBus API that allows us to know the total readable bytes without
>> touching the data in the ringbuffer, or the hv_sock driver needs to
>> understand the VMBus packet format and parse the packets directly.
>>
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> 
> Your S-o-b was fine here, I was talking about the author.

I misunderstood the meaning of author. Sorry about that.

Will update this in v6.

Thanks,
Xuewei 
> Thanks,
> Stefano
> 
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





