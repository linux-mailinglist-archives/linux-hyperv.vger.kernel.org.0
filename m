Return-Path: <linux-hyperv+bounces-7454-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D972C3E4D0
	for <lists+linux-hyperv@lfdr.de>; Fri, 07 Nov 2025 04:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856DA3AD739
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Nov 2025 03:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEC52EF660;
	Fri,  7 Nov 2025 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a06yzr2B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60E227563
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Nov 2025 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484830; cv=none; b=ZjJIawO8xYa5EIQ2FXbBeAf7rg52A0VlnOvID4cXuHBr9BaEq+PNGoqHP2m82EJvCgaHSBgp4AW22OqXO99vbfu36ITvjuiDil1Y4QLJ3syNvEtpd2yhwDEMcJ6BkMQqTRuWFXQ8GnHmaYHJs/vAWjP5BfadPCfFBkGWyrqO5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484830; c=relaxed/simple;
	bh=808AlwEZ1o2mA4OcdatRSl+Gb85ZdMLrOwB3CyxK1Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOctxRfc2oeYR1mg1Lp4WnTa2LwfbUCy/aI1+5cDBKG1UbB7ly7Dzb6PBdZ3BWNNvOtK3KGMJ226KFvVncIfMftKnqkWwvW/vmzcrI+5Z5Id0uZgNiPBYA8aU9igS4qfx+anafkPr8edsISiCTQm6Bw2yeJUhTBmgXCcfep//jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a06yzr2B; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-787ab220b1cso4062967b3.0
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Nov 2025 19:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762484826; x=1763089626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hR77XGy8gKTpCV+3sSlL3axBPG4R/F86P0C6FJqRU38=;
        b=a06yzr2BZTwGYHArjHp9LGVTPlbRMRUAT0X+aLCvbKOYdB/uHjGpJNkdYmuLtITb8N
         FN/4qcMRd8g3E0Cs814vxGEKkfOFXXVLZhvXoFyNeUxGPUbz2GZHTy2xkaT/9CD5D4e7
         8/MWLBX+fZwSGrhWWSvT1J23CHiyEZYReXa+0mIjDVW4WYM5KDiIlGPJNoN02W36v3G9
         dN853tmWvBjgeJG4CvSoIUs44A2era9m5KjEk6IP5J+6HXoXDcRMgJBEuuEjgB4M9W+H
         RKmFPZBewnny9dfsbO+hGTOeCYZsUIzcCGgK1MdVuJOviDttthrRQ3IXzv2qg679brxf
         rUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762484826; x=1763089626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hR77XGy8gKTpCV+3sSlL3axBPG4R/F86P0C6FJqRU38=;
        b=P6q0My0DLSOkj6vGKBtdhpYpP5hb7OTW4DnMVCZPJ0ZqCAYIV9W93bL30aa+4+c9K4
         piEN831rk4P+BlLvA5F9wzflPZZVm+5qxwaGmylNUupcMSvE4lqogvPskA/z9FbdPVDE
         ubhP1fJaDHxQdlWQCPvbEVQWoO5InKhaYN7483RObg2LkBipCN25O3T/z28LizI97RY3
         5wT+Cbp+1r9630J7l6Ow6b5aZV1QFviu8wCqjuEakz5Geydrxw1f7rc8nKAYlxa5Ix+w
         RY9SHgLiw+AILbt6S8UZU7lGo9PgBoCHAbPaUoPEaCVEj9eakSToGN/lVqZgmSR+74RB
         8IbA==
X-Forwarded-Encrypted: i=1; AJvYcCUTjMZmFLMar3lhsteVMJS17QrFD0Xz27HpM64opPAIFyAGUhLUGS/rsm2YjRj93JE+7mNUG9RfxzPm8SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxCN2xAykqtl6RiFDGkeUXxl7EYrkvlxJIcrT//ERZZL6rCHA5
	Ku4P/yuR1yGp2X+8rMu9h6REiqNwbPTibl+qNYaDCsgTmwkRJtYv2VIT
X-Gm-Gg: ASbGncutFFVs6WBXKnf33u20rBKtVgwLKOz6NQCI+2FMuLdf8+LQuIU/z76I7pjWJ8g
	SoXeTVY5HzajlkRgBR1+5To45lOafYfNe9+cCpWwcuwBlw9Eu22KvDhMk46QVQUksDRewXeVuOZ
	AMid1OoItWs5hGTzqw7llwHBZPpGFD2Cac6zQcwTzSEGZLen3xxrQ+is8vCs8SegqBzI/KO7TLF
	TFjvXmfxVBigbVVl53RUKI+/ogEDAIHw7rpzHlmvTh/q0r2w1J/Lkmhy/WzoW/JgftB7vnvUGaP
	MVXN0ZxzKa4L950HJ6RyyKeUTCddVcxPtgd46ZT8Zy1DQt+jAjtg5QYs58jRTvlv1KCR9Bq56Cw
	piQn2o5oDkZjkuRDwD+IWKpstJsHENqNGjI8BLRsae+owLhFe0rHENHZKq4kUNRL9hTJvaD/nNk
	g4lU/fQwgWdQvqKbF0qxazvy8EHJ81OHAcjh5T
X-Google-Smtp-Source: AGHT+IFB590VLlupKmRJu3Xg8gkOtJWd0diOwJuCAD9JFt31fECUBp8uUIrK8y6sj/IrmT+p0bOb1A==
X-Received: by 2002:a05:690c:d84:b0:783:7768:55e6 with SMTP id 00721157ae682-787caaeead8mr1823477b3.13.1762484826556;
        Thu, 06 Nov 2025 19:07:06 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787c68c4025sm2798627b3.26.2025.11.06.19.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 19:07:06 -0800 (PST)
Date: Thu, 6 Nov 2025 19:07:04 -0800
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
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 07/14] vhost/vsock: add netns support
Message-ID: <aQ1iWCvSdrat1Y5v@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-7-dea984d02bb0@meta.com>
 <juxkmz3vskdopukejobv745j6qqx45hhcdjtjw7gcpgz6fj5ws@ckz7dvyup6mq>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <juxkmz3vskdopukejobv745j6qqx45hhcdjtjw7gcpgz6fj5ws@ckz7dvyup6mq>

On Thu, Nov 06, 2025 at 05:21:35PM +0100, Stefano Garzarella wrote:
> On Thu, Oct 23, 2025 at 11:27:46AM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add the ability to isolate vhost-vsock flows using namespaces.
> > 
> > The VM, via the vhost_vsock struct, inherits its namespace from the
> > process that opens the vhost-vsock device. vhost_vsock lookup functions
> > are modified to take into account the mode (e.g., if CIDs are matching
> > but modes don't align, then return NULL).
> > 
> > vhost_vsock now acquires a reference to the namespace.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v7:
> > - remove the check_global flag of vhost_vsock_get(), that logic was both
> >  wrong and not necessary, reuse vsock_net_check_mode() instead
> > - remove 'delete me' comment
> > Changes in v5:
> > - respect pid namespaces when assigning namespace to vhost_vsock
> > ---
> > drivers/vhost/vsock.c | 44 ++++++++++++++++++++++++++++++++++----------
> > 1 file changed, 34 insertions(+), 10 deletions(-)

[...]

> > static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> > {
> > +
> > 	struct vhost_virtqueue **vqs;
> > 	struct vhost_vsock *vsock;
> > +	struct net *net;
> > 	int ret;
> > 
> > 	/* This struct is large and allocation could fail, fall back to vmalloc
> > @@ -669,6 +684,14 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> > 		goto out;
> > 	}
> > 
> > +	net = current->nsproxy->net_ns;
> > +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> > +
> > +	/* Cache the mode of the namespace so that if that netns mode changes,
> > +	 * the vhost_vsock will continue to function as expected.
> > +	 */
> 
> I think we should document this in the commit description and in both we
> should add also the reason. (IIRC, it was to simplify everything and prevent
> a VM from changing modes when running and then tracking all its packets)
> 

Sounds good!

> > +	vsock->net_mode = vsock_net_mode(net);
> > +
> > 	vsock->guest_cid = 0; /* no CID assigned yet */
> > 	vsock->seqpacket_allow = false;
> > 
> > @@ -708,7 +731,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
> > 	 */
> > 
> > 	/* If the peer is still valid, no need to reset connection */
> > -	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
> > +	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk), vsk->net_mode))
> > 		return;
> > 
> > 	/* If the close timeout is pending, let it expire.  This avoids races
> > @@ -753,6 +776,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
> > 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
> > 
> > 	vhost_dev_cleanup(&vsock->dev);
> > +	put_net_track(vsock->net, &vsock->ns_tracker);
> 
> Doing this after virtio_vsock_skb_queue_purge() should ensure that all skbs
> have been drained, so there should be no one flying with this netns. Perhaps
> this clarifies my doubts about the skb net, but should we do something
> similar for loopback as well?

100% - for loopback the skb purge is done in the net exit hook, which is
called just before netns destruction. Maybe it is worth commenting that
context there too.

> And maybe we should document that also in the virtio_vsock_skb_cb.
> 

sgtm!

Best,
Bobby

