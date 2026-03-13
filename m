Return-Path: <linux-hyperv+bounces-9406-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GbcLflDtGk4kAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9406-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 18:06:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B419287CDA
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 18:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8043A30C3D99
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2313CA490;
	Fri, 13 Mar 2026 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PehQkiI4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C74363C72
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Mar 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773421171; cv=none; b=a8JUDxScvALZ+dMU8h6SfTm3C4343WKV3YOQ3kLbRGdR3039UAY73IHMSS0C1q1FtmtAi+TR/nUobMJD0T4xSkaJaINFmiVqCn48d74ZAApkwMn2QjchS52kV5ORQw939VMzcdHYIGXx1Jh99iEc1FHhe9epDQY3/luShQzJ4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773421171; c=relaxed/simple;
	bh=ZtCcl/BQGcxN/KUZGbuRltnqiIZdE1BNslevOQGWgSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRcgQQjRyQZ57bq6Z4BsBvZL+SG7kPzCd1gEdCQ3D3j1MxwCmHO8zn5K3TTCQfNi8uJr6IK2SoE37o+K/TxDrb8mYg5h6XijavN+iAYV0KryGLq4UISdu+MkCEe+SNNKWFAUFPdXtT+4zw/7tZwgoixp3SpA7GcpWyuvCM0R/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PehQkiI4; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89a1c6dd788so24970096d6.0
        for <linux-hyperv@vger.kernel.org>; Fri, 13 Mar 2026 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773421170; x=1774025970; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=23vNKRuSFnFOzf5hO6ZBoQlegCCAZzuo2j5iFmnbc5A=;
        b=PehQkiI4M6Jd47dJdNiK4ZLpmpbRRoOAWmvfoehAtix64kyfPIt9T7FFN0IRc+ycUs
         n4vQbLjq+2guHsmefuI5RlDxSwngphyDF95e4Mt7gI3j2s+1ZffqdHV1xk1EMwHfbyAA
         qznKFepOXmTz82YsZVkgQgTMP9ljWjFXH4W3pFYk8o8TSJfQ5SMALHY28jOJp9fM9rx7
         2ukcl66e05ePXuU+frU8gUxrJWbXkrZx7lMkCQgl0LwWMzFmHsHUivqZD26nwuOsO6wR
         1T1V72GHAty9EA54Il2rQE1OP/m/+Y4Q9PhepBm6eU7DI6NIF8HlbT7aeXRRiwYsFivm
         UH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773421170; x=1774025970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23vNKRuSFnFOzf5hO6ZBoQlegCCAZzuo2j5iFmnbc5A=;
        b=KJvxLT9tmtJYf2ilhFYaiTmyCTcQCcQCpOSEwCduoRCUHitvSehnRLM4KC7Fv79v60
         NYcTpTz3SSXIj+fW5wzqvjGavJUmkvXdAOOXQgcJeSP1SfyAzogq18rP/ab5z7JJ5SbN
         viURXSglCZj9iv2HAWdisa9bBWObl8M6V4QGo0Mmk77bwYUyCw/Xd1q74wVViFDC2xAS
         TKsgcUV8h1ecxK2u+uMXdsQThKYj5H0rrAybVEul1zECRTGtJSgRui7y+8nByk9kyvrv
         k9kR6GNhfPG58BePvKMknFaBDcHAV/fWDRMGTnG3RfTJ3EjfjDZbYQXWmZ6II5/8hIe5
         P5fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl+rNzqI+66P/TNs3nu3qafC+TnuvM5JNlWdBKJRw/dAd4c3d0zl1L0X/Z7sQhsuDFfBAG1UxfV89JBc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz60okEoYWn9BmCnotTuQuUeSgrHS/TbX8WefpGRPiqSQDiz2kl
	+DC7W7STae87VgBNjuz9pkmhk28yiH4Q/R4Y165Ffvm3CiZc6V4QAdQmTJ1YK8I36XY=
X-Gm-Gg: ATEYQzwuqu52lth5PfPeSvkAIqfbZliCCOFX2XtirU+QwtQSuXPqp8ShDZ37C/uzwTC
	29IWYgwO+f9PgGCzY75H9wCdqGDAEm1kZd59zoatcMqmvDtpr+thUqMcsxHkJUZY/ZxJvHiU9My
	36VFnsIccEIrALk9z1Y6fZrlcyrT8u//AkyMPkMUCYe2g73g+yEv+T+nN7IN3Xp2DRX0Y40ln0P
	VliDeWvkYBX5TnwBt+irpifj6JW4/lE5SPo3iEQHaYsHddQdNrg3nhzT5q1MGkdied5flVZOQg2
	8gLwDnw4uFGezkiNdBAXSYBfY3cnINUK4TTEHHiAkzQf0U8bfQ4k8alRQelA9ujrLhJEp3NTOCJ
	UEM86L9p6MNl3hXcYsfRvNldF92gYBhr/wQAgYEc6q51Hiqf393ugzgdgsAwEfGwtJFOorVtexY
	vPokaTdyHb9mBLYJWePnsc+CVzF4qcdifn2UHck7ERwKV1DTdz/s77TsWVieSduosT2j9DV0voF
	/adkhqu
X-Received: by 2002:a05:6214:c2d:b0:89a:622e:d334 with SMTP id 6a1803df08f44-89a81fe1ef3mr64802856d6.48.1773421169725;
        Fri, 13 Mar 2026 09:59:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beb4besm60515486d6.15.2026.03.13.09.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:59:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w15rE-00000007Jg3-2Wt2;
	Fri, 13 Mar 2026 13:59:28 -0300
Date: Fri, 13 Mar 2026 13:59:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 0/8] RDMA/mana_ib: Handle service reset for
 RDMA resources
Message-ID: <20260313165928.GH1704121@ziepe.ca>
References: <20260307014723.556523-1-longli@microsoft.com>
 <20260307173814.GN12611@unreal>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307173814.GN12611@unreal>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9406-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: 1B419287CDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 07, 2026 at 07:38:14PM +0200, Leon Romanovsky wrote:
> On Fri, Mar 06, 2026 at 05:47:14PM -0800, Long Li wrote:
> > When the MANA hardware undergoes a service reset, the ETH auxiliary device
> > (mana.eth) used by DPDK persists across the reset cycle — it is not removed
> > and re-added like RC/UD/GSI QPs. This means userspace RDMA consumers such
> > as DPDK have no way of knowing that firmware handles for their PD, CQ, WQ,
> > QP and MR resources have become stale.
> 
> NAK to any of this.
> 
> In case of hardware reset, mana_ib AUX device needs to be destroyed and
> recreated later.

Yeah, that is our general model for any serious RAS event where the
driver's view of resources becomes out of sync with the HW.

You have tear down the ib_device by removing the aux and then bring
back a new one.

There is an IB_EVENT_DEVICE_FATAL, but the purpose of that event is to
tell userspace to close and re-open their uverbs FD.

We don't have a model where a uverbs FD in userspace can continue to
work after the device has a catasrophic RAS event.

There may be room to have a model where the ib device doesn't fully
unplug/replug so it retains its name and things, but that is core code
not driver stuff.

Jason

