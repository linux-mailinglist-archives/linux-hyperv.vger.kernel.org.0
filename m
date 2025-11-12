Return-Path: <linux-hyperv+bounces-7541-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A33A2C54393
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 20:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D57D84FE52B
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D51248F7C;
	Wed, 12 Nov 2025 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDniVANR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E8526AC3
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Nov 2025 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975977; cv=none; b=fVCOaEtvnpJ/9a71HzEx+k8QgeSeNP/TnX+WVt1x8EgmPyXR5X2Xu8jIJ6t6IU9VQBbORb6SvvoHJ2/sVm+EGNqp69DQo0cBfVhPgR+QI8bAin0grq0sWlWybN0N2Ynqim2QqnbRF3EbbNqU83p7o05Wcco3vBngsU+xyurF1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975977; c=relaxed/simple;
	bh=SUUhDfoBmuPhmMw0GL7Ir4bt1svau2Ajo0eTYsuBFqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5+ogWgNxYrLriIhcXbXl8bHZ4lRX3id5dh1G+WKp8BCLp0JHQ9JawaOefUNonYvcNs9bnjVA7A6F13wyrepnqxUUFVm4SFm7ys0m1gBPN36JJ8dobkGb2FLa+D8yVT3WdA4c5uf4WmmD2DrFZmOD4PSgiTjoaZOLKfEUgiovNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDniVANR; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f95dc176fso1186389d50.1
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Nov 2025 11:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762975974; x=1763580774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lxubWASL3+7oeSYOF8cRfS3IaF1lf07GjfI/BFusVlo=;
        b=GDniVANRw7/JIpN8NxtyzRFIGwATa9A2zCRzT3AyV9bYUYVYwu524FQVWDldPls9Sy
         BpN03Dl612FtbGpNolRLv7VQcy21mEAgyRgKaz8iRgqv93oEknieZ6Y0/RngcZrd9SSC
         GZNx04VANDM2Cuu0mcyR6voyECGLmNbytUFhlpwNU2hwygi9A3MsbOmnK+GLqGblJC70
         Y3ZU/AOVaaXFGaQcTxJx45VWlQd1jjjEUDnf2OPYE2bbqLo78IVe58YmFOwQytbkPRWF
         pfwpadEZKWx9TK1NMR2djxLbPfw4cn5kdJg3xSMPquTNqj/Yxa3mK++zs3NWcntr0n2w
         ageA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975974; x=1763580774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxubWASL3+7oeSYOF8cRfS3IaF1lf07GjfI/BFusVlo=;
        b=ozE15yE5v855IkGPNo7wu0u9GAdzXGzmdxoXb5UIrZCYgwocn3yFLjKJk4tu9GWISO
         e9hxJ0+8IQdTwbx2dBsNcFAVygdAYRJFrbuKrsGUKkFLPPR6MAVMAE19Wq/P3CvSMcB2
         orc+68PvjHqC3qVUhwDbU+/eNmhCRDOAFM2HpqHaYxJwJaLilPK8rPlN5nBSwKnoN6vN
         cn/Xp4S1gVYWa4cKTQzuQTaYHksdHoULsNCfZGJJhXVzm4Dfpm2FThn3di2y2shuQY/0
         MOBYtrWmBoR10hsMa+982MFFb5zY899xd5RUTKnW32RdbyHRbj9hE+dJO8Yl3DYQ9Ttr
         8GCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd9tpzpDgnuwuspdxm6Edx65/towV2WSxxd1xXOlRp5QOkQXwToXAWAiUNyuIIt7hk3FPYPv/emtQ7p2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLQmEzH8uhUS/3PQV7VNVfpXwqkCMg2nuZym+ImKLEVfnQsn1
	xt6PPqPX6bKaALeqzSETCbjeywJTjKo2TvSZ/hl4rCHOKMpeYYaTVfde
X-Gm-Gg: ASbGnctijqU/qCrfiCMvtp5vPJYASILqyNb3OLfHqEB3cGfHUfUjGNi0DGDKgLo0WyV
	GZJ/gkQ1C1XmB/CFvuH0elwUk6OqsV1cLGIZYr4N5EEIkbh6r0LT6XtGUlldHsEYf5AGnmSPy6M
	U3fLzRyJ+1aSoGYvGtgmGeHJpxMEtJjarJMJowQgvCm/Ct6gFh2ZjkUa3J+saIOcLsTkXDTJun4
	ifuBfdL6hZq7Ejlp0I6TulXb4gjnfVh8Kv+GGu/egfn7VOGqrd+qzqGQ0dTsI+OOAG8v3vGVnh3
	0tBg+eeT3Di3sMGvsB8B0dr4pP0iix+pfmZbD5GEwsy2POBHY+sboh60OvV0pBsfMtkzGUrCNOU
	AEpfZ6u3YnyGHqoba4totr4qJ/rQke+waSgsTbcL9hITXdEY67mxzmaky0DF71NlpOkD6xm7OpC
	tEn1MdaJXmGRt0Tqa2/xTcBL5GBMEcUO3YBFq+
X-Google-Smtp-Source: AGHT+IG4MyRZebV1Szufgtc9uf8er54fQt94boVEX+HeLHRTnsDHzaHu6bkb0vk12BKBHmbmHT/a7Q==
X-Received: by 2002:a53:b10f:0:b0:63f:a818:6d34 with SMTP id 956f58d0204a3-64101b29733mr3157363d50.32.1762975973985;
        Wed, 12 Nov 2025 11:32:53 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-641015aece9sm1236185d50.3.2025.11.12.11.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:32:53 -0800 (PST)
Date: Wed, 12 Nov 2025 11:32:51 -0800
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
Subject: Re: [PATCH net-next v9 03/14] vsock/virtio: add netns support to
 virtio transport and virtio common
Message-ID: <aRTg4/HyOOhYYMzp@devvm11784.nha0.facebook.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-3-852787a37bed@meta.com>
 <cah4sqsqbdp52byutxngl3ko44kduesbhan6luhk3ukzml7bs6@hlv4ckunx7jj>
 <aRSyPqNo1LhqGLBq@devvm11784.nha0.facebook.com>
 <bhc6s7anskmnnrnpp2r3xzjbesadsex24kmyi5tvsgup7c2rfi@arj4iw5ndnr3>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bhc6s7anskmnnrnpp2r3xzjbesadsex24kmyi5tvsgup7c2rfi@arj4iw5ndnr3>

On Wed, Nov 12, 2025 at 06:39:22PM +0100, Stefano Garzarella wrote:
> On Wed, Nov 12, 2025 at 08:13:50AM -0800, Bobby Eshleman wrote:
> > On Wed, Nov 12, 2025 at 03:18:42PM +0100, Stefano Garzarella wrote:
> > > On Tue, Nov 11, 2025 at 10:54:45PM -0800, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>

[...]

> > > If it simplifies, I think we can eventually merge all changes to transports
> > > that depends on virtio_transport_common in a single commit.
> > > IMO is better to have working commits than better split.
> > 
> > That would be so much easier. Much of this patch is just me trying to
> > find a way to keep total patch size reasonably small for review... if
> > having them all in one commit is preferred then that makes life easier.
> > 
> > The answer to all of the above is that I was just trying to make the
> > virtio_common changes in one place, but not break bisect/build by
> > failing to update the transport-level call sites. So the placeholder
> > values are primarily there to compile.
> 
> In theory, they should compile, but they should also properly behave.
> 
> BTW I strongly believe that having separate commits is a great thing, but we
> shouldn't take things to extremes and complicate our lives when things are
> too closely related, as in this case.
> 
> There is a clear dependency between these patches, so IMO, if the patch
> doesn't become huge, it's better to have everything together. (I mean
> between dependencies with virtio_transport_common).
 
Sounds good, let's give the combined commit a go, I think the
transport-specific pieces are small enough for it to not balloon? 

> What we could perhaps do is have an initial commit where you make the
> changes, but the behavior remains unchanged (continue to use global
> everywhere, as for virtio_transport.c in this patch), and then specific
> commits to just enable support for local/global.
> 
> Not sure if it's doable, but I'd like to remove the placeholders if
> possibile. Let's discuss more about it if there are issues.

Sounds good, I'll come back to this thread if the combined commit
approach above balloons. For the combined commit, should the change log
start at "Changes in v10" with any new changes, mention combining +
links to the v9 patches that were combined?

Best,
Bobby

