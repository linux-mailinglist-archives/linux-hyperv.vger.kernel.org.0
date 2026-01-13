Return-Path: <linux-hyperv+bounces-8277-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 005C0D1B87E
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 23:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1475B300CAE3
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 22:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D72352C4F;
	Tue, 13 Jan 2026 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOKH27+b"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14255350D62
	for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341864; cv=none; b=RbAPNUZCQMXxJc783ENNa7PIO9o5wxmlw7g7SCgR9Vsr5qHoRhigGlxliAEz0ymrrze3kFFmnIpQ9weCi3uo0A9HBh1nQQb9/KzvCIlEGsyQPRIejPO+V0nS55Cfq5aJT0j/EfVbSE/u7fUvw2AtyLp+krvkKixb2gOKlzjgFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341864; c=relaxed/simple;
	bh=h+UznknjOhsgpxn2WvyaKZdy+E01z3xst2FqiSOZMS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoJI5GUumgHSPk/wR6vRqKTy552DFeZQvt2rkLf0LBwW2+fqdlVWMOU58IJ+QUpU8FtK1MsdAmKkhfFRjYUgdDw8+LDKsHVFnkv/Ek3OwwdXASoUwtABUp8lHboZGNCeNDRB/dwYZk5OcU+tipT2JEVyTHQczTxxqpQrMZ9fAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOKH27+b; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2d32b9777so1211683385a.2
        for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 14:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768341862; x=1768946662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QzIlW73SYpRCgsFT6C0OFykRPA/kKAr4bQkErotYYOY=;
        b=dOKH27+bYD+a9m3c/8V5ZfVjyJUMB77yTlc1CE/A3urRpZ5GLqTlArSsjlQTIGnVz2
         mAtrGWpNwjdT8OIh4h10EJWWEkpgbbHSRGsNzGDeW7GWsN3Mkx1CsguZvCw9xrhBYoYX
         MxSPa7IFfFDJNC0uvLYl/MmrtuKUonuJpQKhBBW22gB+Fcj3oVV21oDUNZinTcLYDKgR
         5HNhBEDqSM21JAIJ7frcz3GXC+uXin23qpdkICzQhh38ogCUGxKCLgwk76D8DTYo9LWt
         PLo2W1vTDmeD6ICJxFdzPC35uHUgGQ3k1ZSAzrMGL6wmQ1uWGa2qEV6odtzyovMpWLyJ
         mE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768341862; x=1768946662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzIlW73SYpRCgsFT6C0OFykRPA/kKAr4bQkErotYYOY=;
        b=NM8eKKtJsf774RoiR6W5f5JbHec4kgYlHjQxY8SzM7G3vRBlKJxB6wd0WAAisNWTNK
         8zC0dpqVqlGi/Z4FUlmVmdPBH/+/3vH5YTDkLs1gJqcA7eXOXbZRWHeywlAamad60wwo
         g2LfT5u/xBObyEBL+emQbEvhUG4TQY/eK1470MhuvUNpA2kvBvo3V5RbuhPt4OBSPvg5
         sxqIxeXXJSQsyteTr5facM4kMWQGUpUJ8DO+TlL/lSKWxcgDGet9oT48dvbzFgI81N7D
         krof50exGiq51T616J9KombPwoXNuC3Y72utgG8t+ZRWu+W/llwLT24n9n71ZLWz7F3J
         zAQw==
X-Forwarded-Encrypted: i=1; AJvYcCXbOdExRSqNJ8CI801fcIhXhuXfCJia4j33Ix+ODMDVCuNDph6SHRPaWvHN2Q3EkhpJO5GmJUl/7Asq7fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywom+4dSy6jtcA3+ucs1wxa5aVb39CoOZKH/njncNNttGnbbWky
	liXo3+SkhDhVwrTY/zbrerbDqwfVn+gK4ORQDr27voimCQMyJ8xs/7ZFQp3djw==
X-Gm-Gg: AY/fxX6j/vo4POIdCfNe1w4Puy0UvP5bPSNsyE7/ng5e93f9okswuV5PKwc0riD+Nwj
	UsmT7NmrGaY/iE5CZFfgvf5cvni2zdpv4e4EnHlqIwq8VCaO+upeNJpnTyQrEjE8haQc/QtWyU2
	7ETY2TTRSN9GkCXFmwr3SRZSdbzDFcHBwcD82jjK2oPqhLqx1MGFIPKFDJUKdADu03prFPIw4vR
	KYkfvXW+ck9zL2sedQyKn/osHwMlnT6tljxocaZ7NjnSP8IEGyr1bmFl5TeCIHvxaRT/SSuhOcF
	qbR5sODiJf1m8HDJd4kXI4+OmBaPU2BU9eSlPgq09FN/bwbKG0ZM9YNuzcXK39CAqPAWyPCj3ET
	PuZQ9LesQ+1V2e4YZg28OfSzlrFJqicalvdv/1AquyEOMBqtRmdrR4zpgqMmvCso9jUnQjL/0oi
	zeg5VhwGDOVEanD/Hlrmp1at75/BQnirw/s0Q=
X-Received: by 2002:a05:690c:c85:b0:78f:f3e2:35e0 with SMTP id 00721157ae682-793a1d4bad1mr1649307b3.42.1768336120080;
        Tue, 13 Jan 2026 12:28:40 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm77661627b3.47.2026.01.13.12.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:28:39 -0800 (PST)
Date: Tue, 13 Jan 2026 12:28:38 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 01/12] vsock: add netns to vsock core
Message-ID: <aWaq9vbBJGqg9+DU@devvm11784.nha0.facebook.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com>
 <20260113024503-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113024503-mutt-send-email-mst@kernel.org>

On Tue, Jan 13, 2026 at 02:45:32AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 12, 2026 at 07:11:10PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add netns logic to vsock core. Additionally, modify transport hook
> > prototypes to be used by later transport-specific patches (e.g.,
> > *_seqpacket_allow()).
> > 
> > Namespaces are supported primarily by changing socket lookup functions
> > (e.g., vsock_find_connected_socket()) to take into account the socket
> > namespace and the namespace mode before considering a candidate socket a
> > "match".
> > 
> > This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
> > report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
> > for new namespaces.
> > 
> > Add netns functionality (initialization, passing to transports, procfs,
> > etc...) to the af_vsock socket layer. Later patches that add netns
> > support to transports depend on this patch.
> > 
> > dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
> > modified to take a vsk in order to perform logic on namespace modes. In
> > future patches, the net will also be used for socket
> > lookups in these functions.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v14:
> > - include linux/sysctl.h in af_vsock.c
> > - squash patch 'vsock: add per-net vsock NS mode state' into this patch
> >   (prior version can be found here):
> >   https://lore.kernel.org/all/20251223-vsock-vmtest-v13-1-9d6db8e7c80b@meta.com/)
> 
> So, about the static port, are you going to address it in
> the next version then?

Yes, just wanted to get the rebase out to unblock review of the
child_ns_mode changes.

I should have mentioned the static port was a known issue and still
under discussion.

- Bobby

