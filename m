Return-Path: <linux-hyperv+bounces-3079-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417BA9876E9
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 17:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C061A2810F2
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4154815667E;
	Thu, 26 Sep 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qCMQJyI1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98C14D71D
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Sep 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365848; cv=none; b=rCBvj0Jdg4PeUO+UoaoSzrL5Gh63F45vgFyfw0VxGzJwPmzzmMByxTqWhJEEtttDTo1lnlh/Rgj9N8dFUKyj7E5ywhhMDSFsO2Jgsnn3Bx7tjAj96dintDDY4hHV6FNaDJVUTTG6E1P9PYy2bjoaTDW6mz6ggk7unWsXOLtGVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365848; c=relaxed/simple;
	bh=IX0EuvDMjTW+YNQmUoVlvdmyaeGBf+T2lnX/5x4GabA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcRIyhyjFk+Chqa8/YD1mHEX2fJu3Mb6eAjUQthH7h126uz60Ebi3gVlIurtd9yObIrCnH60ibTsKokzsX665ncl28xJnPA2F1UYIThshC2HeeKz4f5GkAxU5+/MSBxq33NFO7kz58mcQgb/bYg2uPO3XgjEK824AZOLHIcrGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qCMQJyI1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71970655611so1045331b3a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Sep 2024 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727365846; x=1727970646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4497cyjKPRI1PPIEvp39I++CetYP4FngtyziYodhtfk=;
        b=qCMQJyI1GDf0SH3eEx37kOU3qJBk233wTdGaXJkCCahOpjB5jTy7dH24xjtojwdACV
         rcYSw4DpcB8CLxk8u0Za/YQDHIWqjTq/lAmCGj7WFK/2orfC+z7nkEZGw2dAwtohOKop
         2E2sAQiK4VaUwtx+GYb/D69D2KiIovJdCKz6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365846; x=1727970646;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4497cyjKPRI1PPIEvp39I++CetYP4FngtyziYodhtfk=;
        b=ZDPqBtvSz68VfBq/XcrjDoUYcoWpBzEHju0RrtO8sMapRYVRC1pwKLQPc5soH2eWrG
         E13CimZK0n7Ud06szSRBIAusaoZfLaM3G2eetgaQBBYyHtPH/vi6gCSE7shfS8MU82MZ
         3t00mlHoOoK8u9i3A40ugOGqmBvLur3l4w+SiSu9ScUwnX9tge4oCbGQsqvuKoilhw0F
         wawtERlTYK1RPAP/BcLnf1TJXygpudSo1yT9Fk269yVPgJBWONZe3f87DgHCUz9KfXC0
         rdtmnwP+g7lMxcjVJ/MP/PL9fNiaIgjBKPqTGSpIND1VjiNvwcZXARjHXXVcOX/ErMUF
         4pDA==
X-Forwarded-Encrypted: i=1; AJvYcCXm1IsrJw6jnb+TZRPhvw3Wx8NBgCiB5tfhcqjqnPRRxqT7zxf+N7tfgzXE1R8kgKl4MyckXEYQRuXnkGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOoZDciVEC91hJNg1nybht6DyuvDgMpVrB9QXp6wCoZBOL/tHk
	rgHaGlEO4a5gIZa+1+KR6rSZEyd3pVicdksTvvIOhUVwKnxSDRRpyQGikftgTMw=
X-Google-Smtp-Source: AGHT+IEkQhkhz8M9XhbdcUG2MNIeKwnGlhXroclU7cIvREbDFN+d/Ne8bE0fjVwVOeH3tYuVP+gwkg==
X-Received: by 2002:a05:6a00:10d5:b0:717:8deb:c195 with SMTP id d2e1a72fcca58-71b2604937emr366312b3a.21.1727365845970;
        Thu, 26 Sep 2024 08:50:45 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2653717esm40742b3a.204.2024.09.26.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:50:45 -0700 (PDT)
Date: Thu, 26 Sep 2024 08:50:42 -0700
From: Joe Damato <jdamato@fastly.com>
To: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Message-ID: <ZvWC0mhTW-y--X3a@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240924234851.42348-1-jdamato@fastly.com>
 <20240924234851.42348-2-jdamato@fastly.com>
 <20240926151024.GE4029621@kernel.org>
 <ZvWA6BjwVfYXnDcA@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvWA6BjwVfYXnDcA@LQ3V64L9R2>

On Thu, Sep 26, 2024 at 08:42:32AM -0700, Joe Damato wrote:
> On Thu, Sep 26, 2024 at 04:10:24PM +0100, Simon Horman wrote:
> > On Tue, Sep 24, 2024 at 11:48:51PM +0000, Joe Damato wrote:
> > > Use netif_queue_set_napi to link queues to NAPI instances so that they
> > > can be queried with netlink.
> > > 
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  drivers/net/hyperv/netvsc.c       | 11 ++++++++++-
> > >  drivers/net/hyperv/rndis_filter.c |  9 +++++++--
> > >  2 files changed, 17 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > > index 2b6ec979a62f..ccaa4690dba0 100644
> > > --- a/drivers/net/hyperv/netvsc.c
> > > +++ b/drivers/net/hyperv/netvsc.c
> > > @@ -712,8 +712,11 @@ void netvsc_device_remove(struct hv_device *device)
> > >  	for (i = 0; i < net_device->num_chn; i++) {
> > >  		/* See also vmbus_reset_channel_cb(). */
> > >  		/* only disable enabled NAPI channel */
> > > -		if (i < ndev->real_num_rx_queues)
> > > +		if (i < ndev->real_num_rx_queues) {
> > > +			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_TX, NULL);
> > > +			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_RX, NULL);
> > 
> > Hi Joe,
> > 
> > When you post a non-RFC version of this patch, could you consider
> > line-wrapping the above to 80 columns, as is still preferred for
> > Networking code?
> > 
> > There is an option to checkpatch that will warn you about this.
> 
> Thanks for letting me know.
> 
> I run checkpatch.pl --strict and usually it seems to let me know if
> I am over 80, but maybe there's another option I need?

Ah, I see:

--max-line-length=n set the maximum line length, (default 100)

I didn't realize the checkpatch default was 100. Sorry about that,
will make sure to pass that flag in the future; thanks for letting
me know.

