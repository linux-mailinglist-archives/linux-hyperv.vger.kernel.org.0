Return-Path: <linux-hyperv+bounces-10313-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPN7CHGZ6GnVNAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10313-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 11:48:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD3D444380
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 11:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C297300A138
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 09:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9242D7BF;
	Wed, 22 Apr 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3k0dS/X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDtauj7Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3980D35A399
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Apr 2026 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850814; cv=none; b=UnCMD4kE2vlME78dgwBsp2rBT+6ueNid8nLQQM93fXJQeS/fIfe7NnL4vtBHs4Nb7hVHcosxZQX3LqSkZ1W0RCqYSo55fcfhyl5VkENPW4KBudBwj/uCZZ3ykGzKHGcctoYzI+7v8bVED7iotty/8j66H3+CRdB2dxfNrEFGa80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850814; c=relaxed/simple;
	bh=zAkck15aRQTZ1Q05U2YBuMYW04iQrWlQkMLWra0PA3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K86lU6pHEXbntsDS3LeBWR1FuNai2w7N007mv2AvuG9cKJr/cce2MrVZhdISm0xynzjnViT7UOggaRAA9ziJC2+AVWDMBOalMBbp+8N3E9SPBIbxNV3RKWN4Esmj8sI7WnntJyOHWdmgX48i7iCyqzSNyFTLLoZnFc+Y7QdL4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3k0dS/X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDtauj7Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776850812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8cr/tWxIjPFzBjhqZCt4BN4Fwf/3ahvnB9QHJ9ZKhqw=;
	b=N3k0dS/X0YuqP/AeNdbBuVQ8iC74LTlPLUl042kqQ/ZUmecg/f3Dpx3qN1Ozti8hb+NMdY
	bTCvXC17LdPpcZySl3OtTU4BQcEG025vY9olEYkXT0Nwn6aA+m3KYqf3tLpYoD0Kk4hRvu
	/FI9EIvfnqyGplUwQjq60szKkMDyIT8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-eI0a5ZgePaWGPhvLdto1yQ-1; Wed, 22 Apr 2026 05:40:11 -0400
X-MC-Unique: eI0a5ZgePaWGPhvLdto1yQ-1
X-Mimecast-MFC-AGG-ID: eI0a5ZgePaWGPhvLdto1yQ_1776850810
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a55ecc249so11622465e9.1
        for <linux-hyperv@vger.kernel.org>; Wed, 22 Apr 2026 02:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776850810; x=1777455610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cr/tWxIjPFzBjhqZCt4BN4Fwf/3ahvnB9QHJ9ZKhqw=;
        b=MDtauj7Yi8djQfouSEoFrmucKQOWy2Ex3r4LineA/9nuq4jaefYztLFddh95hq4A8Y
         z3wO0kAejCwOTlyy9Ri2yNplyqW0OIiT6ZAsuF4NoDMUHB2edCdlpSswBDrv6VzZgcTW
         HkbpdnkcqMSORUPpZ9ZhXD9AdK9vkWcXJCf8nM2IeG0RzpFkJ4YQkptCHlafgbMSTpbp
         sjmvJ2BsJLfvVVH3ehxYRdBJ4TBtt2ZWgKlzi+YMRhJz5diOwPnlA6XzWuZeu7RMT2HX
         /KKlQ3sqy8oZkkbNHROokiVA/hWNjMPl/AYuuE4dOjbhsXxNThjaSb1YNbLw2JOSgS+n
         CrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776850810; x=1777455610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cr/tWxIjPFzBjhqZCt4BN4Fwf/3ahvnB9QHJ9ZKhqw=;
        b=Yq/ktmcSLhbIIvHBr83CGboOdkeqsdnQig5mFhqPDSdaKCWoJ6dyEUTCGYdfmz+ObP
         z+DpVxafftaVqe87s0qyHVdy3l7QIWA+nZ7d8j4KSRrwnqeRRxdB07y+oIjZLxZz7HBc
         xpCv2VMyp+r/TZ91H/oWABAV+QHC9GpFlk5pUUt5GtzJ+B6fBADx5VZUCWlC2nr6VJxD
         is8MB1NisndoNm+5kQ3ZOohUd+Nb1AW9+CmAF2Pm8/FA+emLnuLmXFhMvkCtNsaNebB7
         RG7ErBc8j66cG11NUPo5edatO5adkSuZdK17N0IoZbjA02JL8EzhTBSJkDMKwgEt22XQ
         WmWw==
X-Forwarded-Encrypted: i=1; AFNElJ+JXGcc3DtJGQisyZzu8Jr/tuqyLJOnJPVVFT5xnhj1+qTghRRvZ0OgHruZKF39nCozH3Pauq4by2ZgNWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbUtQA1f1M5vFvWWWLvIsy8R9owrv08+Lmp3qIcuIvGqMrQTM7
	MaSA4WVS6uL9qjT3uTfkQzRmTwmqe4Uh8JZ9F2QQ/jEtNRRLkMS80rcIxl54mnoeMn7h+N0yUXT
	qZJYBNLk8Ez5LSMWSP57kjazYR9lPokZS0p46nm/Au2mB6M9nSC88soQrs0b9ulB0hA==
X-Gm-Gg: AeBDievxTMlPBi0pItdvd1tf9DeGF5tFhyl7kYo7mt6yB6GxTZ2T65tNqNBeWttKk5D
	cR77I8Rg15LbdiOgZbL7oUWAKlP6x69cXf0g7yNZEfzuBGDz6sl61BfUG9rpYalxaeowtltHulA
	7ecAW5NuhFynWGOa2Hb0CqRNNixrMfUyDMjRQwixQf1btXAwUvEs4fMQjGjAt6z1vJjl+cjxXk1
	kCynGYmkWGBQ5gMqvc8gyCxGSV/rLRM+UNUospXtxE0wDSGnGaJJeHz+Mlie+aPXAz1OWd458OG
	0LxxrTBXscWrH8NGKaDDqEzJOfrnebrp38dLLWV0Y8bo99M5eCs/cfrODfmxk8vIMsPIk5/Zvt3
	k2Q6yErMIgmdPNPgoN6Xj5+iN5SW789LEWDRrrAxkTnI4cIM+b0HwfIBuCB4G3knpd7TqKPlKX+
	09pKJZSA==
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48a563cd0eemr82211675e9.7.1776850809629;
        Wed, 22 Apr 2026 02:40:09 -0700 (PDT)
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48a563cd0eemr82211215e9.7.1776850809081;
        Wed, 22 Apr 2026 02:40:09 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm396567715e9.8.2026.04.22.02.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:40:08 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:40:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	longli@microsoft.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, niuxuewei.nxw@antgroup.com, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] hv_sock: Return -EIO for malformed/short packets
Message-ID: <aeiEsYqcKumplu5P@sgarzare-redhat>
References: <20260421174931.1152238-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260421174931.1152238-1-decui@microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10313-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FD3D444380
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 10:49:31AM -0700, Dexuan Cui wrote:
>Commit f63152958994 fixes a regression, however it fails to report an
>error for malformed/short packets -- normally we should never see such
>packets, but let's report an error for them just in case.
>
>Fixes: f63152958994 ("hv_sock: Report EOF instead of -EIO for FIN")
>Cc: stable@vger.kernel.org
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
>
>Commit f63152958994 is currently only in net.git's master branch.
>
> net/vmw_vsock/hyperv_transport.c | 29 +++++++++++++++++++----------
> 1 file changed, 19 insertions(+), 10 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 76e78c83fdbc..8faaa14bccda 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -704,18 +704,27 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> 		if (hvs->recv_desc) {
> 			/* Here hvs->recv_data_len is 0, so hvs->recv_desc must
> 			 * be NULL unless it points to the 0-byte-payload FIN
>-			 * packet: see hvs_update_recv_data().
>+			 * packet or a malformed/short packet: see
>+			 * hvs_update_recv_data().
> 			 *
>-			 * Here all the payload has been dequeued, but
>-			 * hvs_channel_readable_payload() still returns 1,
>-			 * because the VMBus ringbuffer's read_index is not
>-			 * updated for the FIN packet: hvs_stream_dequeue() ->
>-			 * hv_pkt_iter_next() updates the cached priv_read_index
>-			 * but has no opportunity to update the read_index in
>-			 * hv_pkt_iter_close() as hvs_stream_has_data() returns
>-			 * 0 for the FIN packet, so it won't get dequeued.
>+			 * If hvs->recv_desc points to the FIN packet, here all
>+			 * the payload has been dequeued and the peer_shutdown
>+			 * flag is set, but hvs_channel_readable_payload() still
>+			 * returns 1, because the VMBus ringbuffer's read_index
>+			 * is not updated for the FIN packet:
>+			 * hvs_stream_dequeue() -> hv_pkt_iter_next() updates
>+			 * the cached priv_read_index but has no opportunity to
>+			 * update the read_index in hv_pkt_iter_close() as
>+			 * hvs_stream_has_data() returns 0 for the FIN packet,
>+			 * so it won't get dequeued.
>+			 *
>+			 * In case hvs->recv_desc points to a malformed/short
>+			 * packet, return -EIO.
> 			 */
>-			return 0;
>+			if (hvs->vsk->peer_shutdown & SEND_SHUTDOWN)

We can access `vsk` directly, I mean `vsk->peer_shutdown`.

>+				return 0;
>+			else

nit: we usually avoid the `else` if the other branch returns early, and 
maybe have the error returned first, so it's more clear when reading the 
comment on top.  I mean something like this:

			if (!(vsk->peer_shutdown & SEND_SHUTDOWN))
				return -EIO;

			return 0;

BTW, not a strong opinion on that.

The rest, LGTM!

Thanks,
Stefano


