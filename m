Return-Path: <linux-hyperv+bounces-5992-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E88AE4B8E
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Jun 2025 19:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DDC5189C978
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Jun 2025 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9411B4242;
	Mon, 23 Jun 2025 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aF3DSI6H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C5288527
	for <linux-hyperv@vger.kernel.org>; Mon, 23 Jun 2025 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750698145; cv=none; b=tTgDYFnuusdJ8G4ya0Eq9LAMYjOYSxnXEMDf0wxJRwwAxBlX/HlGncfasNvElb6sKfYWnsF6I6X0WIAJ10iKNzAYL+4nsOTCOkFlZHhk3I3d2RLeJmK3eBc0Sb9/pmK1jzvuwPiDQG30boF4JeRUN8caAzH+r1+dfhgLLaQ3S0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750698145; c=relaxed/simple;
	bh=taqM6M2yCTAkigZXwCzc8+OLPoroFfNThxW7WCtpr+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqhvjRr/eD0mjlWd45QnO8epuZ+UKl+4Usu/2NOVwxkGfSLhUbpOBzVJV7RVzpF0BdNItpTyE1XuSCElQQAhkG1XsoW+z0bZTHjsy6BSvMH/qcyjKvRydDJg/xrbZLHRJQJfQc4VYu3RGaOYeje8JaOhpysMBhbXwVnl7IWptJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aF3DSI6H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750698134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jq5JtTNSTi3UbB2t2zf1v906mYuPWMRbjCVCINzsyvo=;
	b=aF3DSI6HviKXvbf7GNBunf5xAOoMf2TfEoEgwRdslYzDLaNpeUtKp7qyUKPr0aKaTzrtvH
	bZvY34L6eQM7tpgzOYbTK+IyQfhnY8/yZRE0TNrsGWZzHYmw1S9nh8O0M3c8fycPuga7lT
	LAMEvqUdWx9w+7l9ZAuq8AIY4L+EDJg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-nwJpS23tOqe_aiAjUxdgNA-1; Mon, 23 Jun 2025 13:02:01 -0400
X-MC-Unique: nwJpS23tOqe_aiAjUxdgNA-1
X-Mimecast-MFC-AGG-ID: nwJpS23tOqe_aiAjUxdgNA_1750698115
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a6df0c67a6so1103757f8f.3
        for <linux-hyperv@vger.kernel.org>; Mon, 23 Jun 2025 10:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750698115; x=1751302915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq5JtTNSTi3UbB2t2zf1v906mYuPWMRbjCVCINzsyvo=;
        b=xEAkMNZljgEAnLYksTHFJ30Ji6ERCpv6r6kMIgfJhXUNxM5lTyw19z3wx8T3r+m15m
         omnLUREOGUe2TnsrA2AOv+bMr9z00UKsYP5oG0f3ywVROXdPLdZzoquvFu6HfluQHUWE
         AgMCRQUR9XLCfQanmpf8YHewrETz658nRYG1DAPiwpDsl5xjHGAxv/7Ac7TGTXlpbsT/
         9DPkvG9wtvE1UxObCGUS8vqFTH57bZMbzhDc43ttI7n1mDmuxvmQWIyoW5iRy2fUo/Ac
         80ILGRNMz/pZnPaF2uZnnvNEmoVQC+s+yxZBt/n1RnieiVLtmBb2FQBNmC9Sc1p8GZh4
         3TJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIr3WqThks7WVfPTQCyfitMGkbfCDqWhHEoed/epR1rSwKQ51ZO7guTy6A348IWFoncXDHRGT0bgMORHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMmmcgFzq8EN10QRnrVFX3PRiOn8z5ImgQpl0FEvGfHl4YIfQb
	5VK/Ak3hqgL8W4toSOjrfbUM36QisVwZTLoNR4980epSZZW9C3GVGEftcZSxxnR5DOMuESqlrcd
	vbxFnfqjTKCyVYF5w89epDK82XsLFuhJczoSMCieHHbGVwOyWldY/vyc/GHCPNKmXbw==
X-Gm-Gg: ASbGncupJwzWYljTnmF4HcIUSkYk8p19yXDHWcW8IrlyiAVaIzMs6tsKcmd/+UD8CdZ
	Rf809pty+FJqgL4IHAP4H7iTu+teUdUC8WlN4XTLnqwxOj3kRpBuDJ/YNGQRxSctnbRkZzpGRif
	J9YWgem0msBxv/MNsWaIri65lzj+1/TgMGGI2Yu+8gFYN312tfXtZ6h0SV2hJcARmUMHtBHYrg/
	Ny/syuiw18nsz8ly5eK+qh1B4j9DOVH10CZzTNKK1JIAqbZVesDyPRcqF4ZjoZCYZlm4g80DF+s
	klOh13GWbt78Zu33zHVT+VueH3g=
X-Received: by 2002:a05:6000:288d:b0:3a5:8905:2dd9 with SMTP id ffacd0b85a97d-3a6d1331316mr11150045f8f.51.1750698114867;
        Mon, 23 Jun 2025 10:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgLc1G5fHA+5OCdohy+RX20t3SZJ3zi/U76KcD2RoeCTL1jtFDfjcLkndhINDFJCXPqEyFPQ==
X-Received: by 2002:a05:6000:288d:b0:3a5:8905:2dd9 with SMTP id ffacd0b85a97d-3a6d1331316mr11149981f8f.51.1750698114073;
        Mon, 23 Jun 2025 10:01:54 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f10411sm9667235f8f.1.2025.06.23.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 10:01:53 -0700 (PDT)
Date: Mon, 23 Jun 2025 19:01:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: davem@davemloft.net, decui@microsoft.com, fupan.lfp@antgroup.com, 
	haiyangz@microsoft.com, jasowang@redhat.com, kvm@vger.kernel.org, kys@microsoft.com, 
	leonardi@redhat.com, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, niuxuewei.nxw@antgroup.com, 
	pabeni@redhat.com, stefanha@redhat.com, virtualization@lists.linux.dev, 
	wei.liu@kernel.org, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v3 1/3] vsock: Add support for SIOCINQ ioctl
Message-ID: <opt6smgzc7evwrme7mulwyqute6enx2hq2vjfjksroz2gzzeir@sy6be73mwnsu>
References: <y465uw5phymt3gbgdxsxlopeyhcbbherjri6b6etl64qhsc4ud@vc2c45mo5zxw>
 <20250622135910.1555285-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250622135910.1555285-1-niuxuewei.nxw@antgroup.com>

On Sun, Jun 22, 2025 at 09:59:10PM +0800, Xuewei Niu wrote:
>> ACCin hyper-v maintainers and list since I have a question about hyperv
>> transport.
>>
>> On Tue, Jun 17, 2025 at 12:53:44PM +0800, Xuewei Niu wrote:
>> >Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
>> >socket. The value is obtained from `vsock_stream_has_data()`.
>> >
>> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>> >---
>> > net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
>> > 1 file changed, 22 insertions(+)
>> >
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index 2e7a3034e965..bae6b89bb5fb 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
>> > 	vsk = vsock_sk(sk);
>> >
>> > 	switch (cmd) {
>> >+	case SIOCINQ: {
>> >+		ssize_t n_bytes;
>> >+
>> >+		if (!vsk->transport) {
>> >+			ret = -EOPNOTSUPP;
>> >+			break;
>> >+		}
>> >+
>> >+		if (sock_type_connectible(sk->sk_type) &&
>> >+		    sk->sk_state == TCP_LISTEN) {
>> >+			ret = -EINVAL;
>> >+			break;
>> >+		}
>> >+
>> >+		n_bytes = vsock_stream_has_data(vsk);
>>
>> Now looks better to me, I just checked transports: vmci and virtio/vhost
>> returns what we want, but for hyperv we have:
>>
>> 	static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>> 	{
>> 		struct hvsock *hvs = vsk->trans;
>> 		s64 ret;
>>
>> 		if (hvs->recv_data_len > 0)
>> 			return 1;
>>
>> @Hyper-v maintainers: do you know why we don't return `recv_data_len`?
>> Do you think we can do that to support this new feature?
>
>Hi Hyper-v maintainers, could you please take a look at this?
>
>Hi Stefano, if no response, can I fix this issue in the next version?

Yep, but let's wait a little bit more.

In that case, please do it in a separate patch (same series is fine) 
that we can easily revert/fix if they will find issues later.

Thanks,
Stefano

>
>Thanks,
>Xuewei
>
>> Thanks,
>> Stefano
>>
>> >+		if (n_bytes < 0) {
>> >+			ret = n_bytes;
>> >+			break;
>> >+		}
>> >+		ret = put_user(n_bytes, arg);
>> >+		break;
>> >+	}
>> > 	case SIOCOUTQ: {
>> > 		ssize_t n_bytes;
>> >
>> >--
>> >2.34.1
>> >
>


