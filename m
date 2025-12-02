Return-Path: <linux-hyperv+bounces-7916-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6350EC9CDA8
	for <lists+linux-hyperv@lfdr.de>; Tue, 02 Dec 2025 21:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A965346E74
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Dec 2025 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2A52F25E4;
	Tue,  2 Dec 2025 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmT9H0ga"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6C2F12A1
	for <linux-hyperv@vger.kernel.org>; Tue,  2 Dec 2025 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764705639; cv=none; b=Vn6DAlYZ4xcfZHnloVTWpbbecjrvJOKj/3Wn6se6foJOEnanehEJmFmJq9rKUaJlYJKQK84CqMGIAjo5a6p37jSz3n8YbMyVpA3/h6d2DPnsdiyw7Le+JvjgVsRsPY9FZd6guUh0RrB7OLZyrrz/UgkfjwKBuuimmbycymXrQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764705639; c=relaxed/simple;
	bh=te4N56NzYz6/dMTrZam+d7syXgjYPyZteJDV4l74esI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnojgBCFF/XgW1IyZgXzehhhZJXBUx9lNvziUVlUL00/WZq7sRB+c6ZoEWdoudfmsrEUuDiRaRSzfQ7yDdIFX6E33aIzeicWaoPej25tFIUu8QxSs3mdw7gTZ+LZfEJVTBu36wBDqVcfIJSoTvmnGSqwEPNdlWQ9jj75wHVChgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmT9H0ga; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-789524e6719so3570127b3.1
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Dec 2025 12:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764705635; x=1765310435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOvq7zGQWlXv7Qg5p/lBCK450NxRsWzSuFDUvE6KnLY=;
        b=MmT9H0gaq8kLBlZN/aw6Y1DlkgBy0mjjl0jZbbLaI9n7BdNLQ8IVlwQg1AtkCOJ/9F
         a05VpwiGBaanzwEWOoEQ1RVZG2w2oIzo9Fm8fpY8kAbXgGvJEFFKFan9lMQnGBWt1VyY
         /NerLbaKXj9smz+1DNxNcksCl4RSCu8znN+PSUBtojYbybTT1otIMWz/tyum0kR42PNH
         5eStF56e+nBzkfyPGNDGDnspvxa0tIMr5D6iQzvZViTRVDZKXaL+YurftOOX3Prl5S/x
         1heeFZ6+BTUm5PqlwIdWVxa4kU12wOKaF+JPebmgHgcdgdhKYE2+Q90mgYCKRwIj7bAo
         Epjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764705635; x=1765310435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOvq7zGQWlXv7Qg5p/lBCK450NxRsWzSuFDUvE6KnLY=;
        b=Os3+QPDkY0qyRSTy9Y8ZODVg1OsnqeIX24eTQwYlW3zDXJIkxu21M3L7Ugdxzq3UuT
         OBJv5MSfYzGwX7TMFOzmeLUNcrw1rQM9Nf4TwlvAEhdR2aMjzbjwbAaD2QsPl4EgoNuI
         3PnwQNgw/hczqpUMTW3T9tFhEDK6CTBOWaBdv2MLs9SpFnQeeBFMT326O7+Dy+BlZC6x
         hfzF3tbcSE5RUXzwCrj7iyRDHKuxl9aucuPW3rd7NlZtZ1MRxSy42iPrhcZUSXy1U+Ci
         5f+OU5u8vDvlAN/NVl8za/lyZdRTmcFKh9d/EVfcjqbcCAEUxBUqjAHzyY74taLFO33F
         bjBg==
X-Forwarded-Encrypted: i=1; AJvYcCUV8xxDjqf8p0c6IDEeG+6w3x8Nf8ex3Sq1OGFgSd2vEXioim8iB0UfV1BxXsLMUT0JXVOrN9KXUSZKOsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2UNO0jcZijiAQJu4+J2jg/phcLCL+devO/q/VYnVgebF/3I2e
	X5mqXS9kxXNB9JZAvpTXYSjT5Md6q6lNQ+IseCAMKocV8azD082QQEOl
X-Gm-Gg: ASbGncsOdaDZms61caqSbyiI3BREge6UGLI48nwwUcx8ln4xMorH+DRv6J1SCPDiqGP
	poXLnpV4jVxZTBPKJQvnUXfpAj4D5/Yi8DACYtlcgXxMH0kKtikUumBZKq3+/5S4XC2gJyhGLQ+
	L1K3ELABpDYEfrImE+otu0ILbSY2e83vnpMd0QombDSIQygdEUWXHCmSuO82rPhovHGrZJWSHej
	f4eiECCcObdwhAT6cvtKSNUq/3Mi7KB0xNtCYF8cVt/+M8ODYqEkANcPt3gxpuCu2g534Smee/o
	6FteA4zmhs/dmHvBy5efo+OJzYRhkE5lukv5PsHvq4Y0XRaX2+YwCxgJbOr4pfgg8A6XTq/Dtni
	dP0aa1oiWyw7UKe53aNedhp+U4SDg19X+RqIkWSTpmRTgtd9f5gPLqNjZ25yHJj35tMIaY/hwuN
	1Id5zGJDqGwV0Iq4BSPOf465g56xY/+hxB6g0EcXVrkcAgBg==
X-Google-Smtp-Source: AGHT+IE4Lw0nvXL8yqBtDuOK7QrlnTetNDoVmfVcyfoTP8VgYdTEu+GudPd/2RaoWo8nWv4q3HA7Cw==
X-Received: by 2002:a53:b10b:0:b0:63f:a6e9:4048 with SMTP id 956f58d0204a3-6442f16a1a9mr2475593d50.26.1764705635271;
        Tue, 02 Dec 2025 12:00:35 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d5f4c5sm65824697b3.13.2025.12.02.12.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 12:00:34 -0800 (PST)
Date: Tue, 2 Dec 2025 12:00:33 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, g@nha0.facebook.com
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
Message-ID: <aS9FYWd3SDYu6U1v@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>

On Tue, Dec 02, 2025 at 09:56:02AM -0800, Bobby Eshleman wrote:
> On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
> > On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> > > @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> > >  		goto out;
> > >  	}
> > >  
> > > +	net = current->nsproxy->net_ns;
> > > +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> > > +
> > > +	/* Store the mode of the namespace at the time of creation. If this
> > > +	 * namespace later changes from "global" to "local", we want this vsock
> > > +	 * to continue operating normally and not suddenly break. For that
> > > +	 * reason, we save the mode here and later use it when performing
> > > +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> > > +	 */
> > > +	vsock->net_mode = vsock_net_mode(net);
> > 
> > I'm sorry for the very late feedback. I think that at very least the
> > user-space needs a way to query if the given transport is in local or
> > global mode, as AFAICS there is no way to tell that when socket creation
> > races with mode change.
> 
> Are you thinking something along the lines of sockopt?
> 

To clarify... do we want the user to be able to query the socket for
which namespace mode it is in (so the results of the race can be
queried), or are you looking for a way for the user to query if the
transport supports local mode (maybe via /dev/vsock ioctl).

I'm not sure we can attach a namespace to a transport per-se, as
different namespaces in different modes can use the same transport.

Best,
Bobby

> > 
> > Also I'm a bit uneasy with the model implemented here, as 'local' socket
> > may cross netns boundaris and connect to 'local' socket in other netns
> > (if I read correctly patch 2/12). That in turns AFAICS break the netns
> > isolation.
> 
> Local mode sockets are unable to communicate with local mode (and global
> mode too) sockets that are in other namespaces. The key piece of code
> for that is vsock_net_check_mode(), where if either modes is local the
> namespaces must be the same.
> 
> > 
> > Have you considered instead a slightly different model, where the
> > local/global model is set in stone at netns creation time - alike what
> > /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
> > inter-netns connectivity is explicitly granted by the admin (I guess
> > you will need new transport operations for that)?
> > 
> > /P
> > 
> > [1] tcp allows using per-netns established socket lookup tables - as
> > opposed to the default global lookup table (even if match always takes
> > in account the netns obviously). The mentioned sysctl specify such
> > configuration for the children namespaces, if any.
> > 
> 
> I'll save this discussion if the above doesn't resolve your concerns.
> 
> Best,
> Bobby

