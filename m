Return-Path: <linux-hyperv+bounces-7548-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4E4C59732
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 19:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 486E1353893
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 18:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A9235A125;
	Thu, 13 Nov 2025 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j29f4Eqx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0332F5A05
	for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058370; cv=none; b=R2VbMLoHA9EBH4eEs4YS6fJQ7OVwBjuTQwpzCa6LBCzqh75wYgI9JhfFKi0GhUYSViGZQe2B9ish5OAMiKEl/rhfi3ApUv75uftbSUQPV0LB9m6Tjqc5gUOM+YqCXNN4OOpQkMeuv3OxXpCgyfsYBOgqpSAY7KQLN2bxNtbenTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058370; c=relaxed/simple;
	bh=NJWfzzFj8vgG4jgYe+zOfuZHD36yc5H5fI4S6VnrPoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDx8FS3c8rbl5xAJ2hJCijMJsjrs2TfZGbwlijEqfgjLpODRCKkrelDRpcslvjaNTMI4rHC6Z7u8gO6NEAGWnXzeWIe7FI1qnLNF1shUDSm4B4p76LxWs5Tz3RKmMG5FLjQN70osZ379oATJEvhtQjx8rAm6BMp3OpSxV70a+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j29f4Eqx; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-787f28f89faso12846537b3.1
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 10:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763058367; x=1763663167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PWcA86QhcaogO/P79JJUHrKh+Hv3BICSCdLFq4V4bOY=;
        b=j29f4EqxVQsnNHPZTIc/ZsF6yW5nheZieAY0YTvbTNA7NcaGk9d5XL1LRU4cd4c5Vq
         TXhEfhVKNmJPSSq08CSZkOmOWW90xpA3KY3x1LBF7Yu6Cji8Ywn+Ndz/0e/bsDzmckDZ
         T07KoHeq0VKTMSx4mUKVNhP+g0zz8s+p7MPMZmicCEl8zo3DLgfiuk5m/fORYvKXAfre
         NsVzyZzDw3Aq24ke268hv0ft+8bvBc9HLoulFWNv3COzLNCQkY94bXCc7WWdN1Pw0YR+
         LM23D727zBohmrEq7Qi6Zz7m68KYloCKeELI+TXJpKF6ZgGYwWYroHAc4nG68CLQPkJ9
         RbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763058367; x=1763663167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWcA86QhcaogO/P79JJUHrKh+Hv3BICSCdLFq4V4bOY=;
        b=Epmn3P4cYZ7wglC1MhW+q8fxswfXDgG+V8fOt0qjgAjI6Sx3unFcBAH0ba5isoyxBW
         11LNVzSId2JeNwHeAzsiXDbgaEmaKJ1e9Y4nQeZWkKNxsIUgEtJj7rfR6nwFkwvAV07y
         chLmpDalM1s37edG1U2Cr1cfOgnhcH++IsRgB2klxTqnfEtCFHHErd+3XgMjBPUvrhSn
         FzuTV/INoGOT9W/u1Z8ro0daIVG76PrU5sk7pH4maaY1MqmsqWoVWsmLWeMaVvc2nf0i
         Cnh989nS2lE1gH6ACWCOIQpXsp0d2qF+WmuboeK+5L41rWVDd4IeDay2om7+GhF8yvEA
         ZxMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXfNnZqKw8mvms9mK7hryphCmQOULgr3SQWyXd+Ci1NDSxerAXof7G8/eZIpbaeYsOGJC8vz9G7DKnHl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFC9P6Kok6atNnbTLMprowZcKy26XAblE/ISeUVwVxsOCxAx1R
	NxUfBoB2rzea1bfFGmqi46tZpZ6logcgqNuoOpfOWduHaLHIDg/9/20H
X-Gm-Gg: ASbGncukvQ2eqARsz7CnnHYonU8bbUJHeb5P1PhvhLXcTek2M0kR9Kt80hWrowq9+wT
	jCl0B2Sx8LLpwYyBxhsRSTBIjb6HlQecYVmnUo7ffyIt6+/yzWBT9BMIcVJSqgP6iNRrea1yfUM
	iOn3WW/mKfOYA7Gs/FoQbzMPdD7NPdNRqUMkpDGcV/UWt0LAq/H+Y2fwfxeiDEyLbrVF1/12fFl
	HWMa7EM5DHU1bneoc8JkBj6mFv0w8ixeccV9Gsc3AesPJyIg+f5Autkb5xhXkrRC8eaawgC3/Lo
	EOqJJYIvQ1TBv/hHoWdua0tSNMuB65PEkpqg9lz5e7I4f9jyMRogMtSG1THy1S9YUZHAJBMsTGI
	iYRI93iXwWsi3c4csSAC6Crbvu3Q+lx+9r3m7TNf+muTzAinf87MbjndLTX0W43/H627qlREABl
	X8aSgfcB3xb+aiNL+x7FZGS1vgJR74iCsbHd4=
X-Google-Smtp-Source: AGHT+IGv1NUbsmH0mBFSpcmwoDDPPls56gYuUVpN5OeRP+WyZcaWbsNJTzNc/oyC8pxSybEkxYaXCQ==
X-Received: by 2002:a05:690c:7008:b0:786:5f03:2b65 with SMTP id 00721157ae682-78929f09730mr3233697b3.33.1763058366513;
        Thu, 13 Nov 2025 10:26:06 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78821e76af5sm8637957b3.27.2025.11.13.10.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 10:26:06 -0800 (PST)
Date: Thu, 13 Nov 2025 10:26:04 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 06/14] vsock/loopback: add netns support
Message-ID: <aRYivEKsa44u5Mh+@devvm11784.nha0.facebook.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-6-852787a37bed@meta.com>
 <g6bxp6hketbjrddzni2ln37gsezqvxbu2orheorzh7fs66roll@hhcrgsos3ui3>
 <aRTRhk/ok06YKTEu@devvm11784.nha0.facebook.com>
 <g5dcyor4aryvtcnqxm5aekldbettetlmog3c7sj7sjx3yp2pgy@hcpxyubied2n>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g5dcyor4aryvtcnqxm5aekldbettetlmog3c7sj7sjx3yp2pgy@hcpxyubied2n>

On Thu, Nov 13, 2025 at 04:24:44PM +0100, Stefano Garzarella wrote:
> On Wed, Nov 12, 2025 at 10:27:18AM -0800, Bobby Eshleman wrote:
> > On Wed, Nov 12, 2025 at 03:19:47PM +0100, Stefano Garzarella wrote:
> > > On Tue, Nov 11, 2025 at 10:54:48PM -0800, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > >
> > > > Add NS support to vsock loopback. Sockets in a global mode netns
> > > > communicate with each other, regardless of namespace. Sockets in a local
> > > > mode netns may only communicate with other sockets within the same
> > > > namespace.
> > > >
> > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

[...]

> > > > @@ -131,7 +136,41 @@ static void vsock_loopback_work(struct work_struct *work)
> > > > 		 */
> > > > 		virtio_transport_consume_skb_sent(skb, false);
> > > > 		virtio_transport_deliver_tap_pkt(skb);
> > > > -		virtio_transport_recv_pkt(&loopback_transport, skb, NULL, 0);
> > > > +
> > > > +		/* In the case of virtio_transport_reset_no_sock(), the skb
> > > > +		 * does not hold a reference on the socket, and so does not
> > > > +		 * transitively hold a reference on the net.
> > > > +		 *
> > > > +		 * There is an ABA race condition in this sequence:
> > > > +		 * 1. the sender sends a packet
> > > > +		 * 2. worker calls virtio_transport_recv_pkt(), using the
> > > > +		 *    sender's net
> > > > +		 * 3. virtio_transport_recv_pkt() uses t->send_pkt() passing the
> > > > +		 *    sender's net
> > > > +		 * 4. virtio_transport_recv_pkt() free's the skb, dropping the
> > > > +		 *    reference to the socket
> > > > +		 * 5. the socket closes, frees its reference to the net
> > > > +		 * 6. Finally, the worker for the second t->send_pkt() call
> > > > +		 *    processes the skb, and uses the now stale net pointer for
> > > > +		 *    socket lookups.
> > > > +		 *
> > > > +		 * To prevent this, we acquire a net reference in vsock_loopback_send_pkt()
> > > > +		 * and hold it until virtio_transport_recv_pkt() completes.
> > > > +		 *
> > > > +		 * Additionally, we must grab a reference on the skb before
> > > > +		 * calling virtio_transport_recv_pkt() to prevent it from
> > > > +		 * freeing the skb before we have a chance to release the net.
> > > > +		 */
> > > > +		net_mode = virtio_vsock_skb_net_mode(skb);
> > > > +		net = virtio_vsock_skb_net(skb);
> > > 
> > > Wait, we are adding those just for loopback (in theory used only for
> > > testing/debugging)? And only to support virtio_transport_reset_no_sock() use
> > > case?
> > 
> > Yes, exactly, only loopback + reset_no_sock(). The issue doesn't exist
> > for vhost-vsock because vhost_vsock holds a net reference, and it
> > doesn't exist for non-reset_no_sock calls because after looking up the
> > socket we transfer skb ownership to it, which holds down the skb -> sk ->
> > net reference chain.
> > 
> > > 
> > > Honestly I don't like this, do we have any alternative?
> > > 
> > > I'll also try to think something else.
> > > 
> > > Stefano
> > 
> > 
> > I've been thinking about this all morning... maybe
> > we can do something like this:
> > 
> > ```
> > 
> > virtio_transport_recv_pkt(...,  struct sock *reply_sk) {... }
> > 
> > virtio_transport_reset_no_sock(..., reply_sk)
> > {
> > 	if (reply_sk)
> > 		skb_set_owner_sk_safe(reply, reply_sk)
> 
> Interesting, but what about if we call skb_set_owner_sk_safe() in
> vsock_loopback.c just before calling virtio_transport_recv_pkt() for every
> skb?

I think the issue with this is that at the time vsock_loopback calls
virtio_transport_recv_pkt() the reply skb hasn't yet been allocated by
virtio_transport_reset_no_sock() and we can't wait for it to return
because the original skb may be freed by then.

We might be able to keep it all in vsock_loopback if we removed the need
to use the original skb or sk by just using the net. But to do that we
would need to add a netns_tracker per net somewhere. I guess that would
end up in a list or hashmap in struct vsock_loopback.

Another option that does simplify a little, but unfortunately still doesn't keep
everything in loopback:

@@ -1205,7 +1205,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 	if (!reply)
 		return -ENOMEM;
 
-	return t->send_pkt(reply, net, net_mode);
+	return t->send_pkt(reply, net, net_mode, skb->sk);
 }

@@ -27,11 +27,16 @@ static u32 vsock_loopback_get_local_cid(void)
 }

 static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net,
-				   enum vsock_net_mode net_mode)
+				   enum vsock_net_mode net_mode,
+				   struct sock *rst_owner)
 {
 	struct vsock_loopback *vsock = &the_vsock_loopback;
 	int len = skb->len;
 
+	if (!skb->sk && rst_owner)
+		WARN_ONCE(!skb_set_owner_sk_safe(skb, rst_owner),
+			  "loopback socket has sk_refcnt == 0\n");
+
 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
 	queue_work(vsock->workqueue, &vsock->pkt_work);

> 
> Maybe we should refactor a bit virtio_transport_recv_pkt() e.g. moving
> `skb_set_owner_sk_safe()` to be sure it's called only when we are sure it's
> the right socket (e.g. after checking SOCK_DONE).
> 
> WDYT?

I agree, it is called a little prematurely.

Thanks,
Bobby

