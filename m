Return-Path: <linux-hyperv+bounces-8083-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE3BCDC4E1
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Dec 2025 14:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1048A3080B76
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Dec 2025 13:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8054226F2AD;
	Wed, 24 Dec 2025 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAGu+9Ld";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uNMtlKXN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA61830B519
	for <linux-hyperv@vger.kernel.org>; Wed, 24 Dec 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581284; cv=none; b=R51J0oYqYCFwe63juddz0YAXPfu+D5E8KECfACDRQC2NtkwoHkfigwTNQqgkYn5FCzGmQywMo1kYuCX33+vcPdO2QL7uOmrL/QUeZzWUjrXmjj4hTF/uXIYg/Nv9TNvoryE52h3K1Dqd4meXexZrni375V/lre9VnACa8Vqp/KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581284; c=relaxed/simple;
	bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYlzmtjkbJq/lZ0gpfbtO/uriTt5mP+xwEU31pq9V057u+TVey5/jw1QA6ZxPu+Xd3bjN0Lq66jEitxrf2piqkQMBk6ADjMHuhqb71PNLQUZfVftPpZ4cw6DmYOMA5JOgbD+D8eOBSXIhN4tjHAce+5Wh0CFSImpts0wkDkybh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAGu+9Ld; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uNMtlKXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766581281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
	b=BAGu+9LdkgXJve6guLUEb/NUDKR2WiUSbkG0BwECraH/zP1zfNijwcQnTQ8aJl+dXopbvz
	0pn3fVxQTiYjpbRQcI6MmTFKKrU4tmkwtfDV4HYHpOn3uBlKTmitFYVbqfeItwNdIfYS1w
	3ob99kfYk7CVJB5aUlEsIWCyltQvSr4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-XLnvev-fOBGIBBA9jXzd8w-1; Wed, 24 Dec 2025 08:01:20 -0500
X-MC-Unique: XLnvev-fOBGIBBA9jXzd8w-1
X-Mimecast-MFC-AGG-ID: XLnvev-fOBGIBBA9jXzd8w_1766581278
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso57717975e9.1
        for <linux-hyperv@vger.kernel.org>; Wed, 24 Dec 2025 05:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766581278; x=1767186078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
        b=uNMtlKXNNG/lVwjdQjqTUwZPFSWRlFQpHTOF0uphMYaQKf/d/C7lSmZDkUCJOFAson
         9ac5Ekf5eRJRCTZmwMZ6F3EMvIxTZLrhD05Rn918KZP4A2xl4mIe4K/7PeBMYBoquE6Z
         QjspJV/d5vPuMqkA0jDsr3nR4+GJfDpflJ7IX3NWbDE/11IPowFo4UMVsW0q8jGvxLH4
         E9II5bWbrrh19qy5G5+7dC0vzeaCZ7y9SGjUrMN8fTaJ/z931MxXo1pL1NaF9Y+l1D3n
         LcSvPDkcSLvsZpkoDowQn1FNfDGmsq1hazpyMLfgyA9qEJ1w15RUlPmP7RQXRD93fT9O
         lD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581278; x=1767186078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
        b=chW/+tmsOJtZ+EfQoWUNreXpaL43H4O45UOPPZP7ja9JB+TaLcVUvvWEhh5tWOfGZM
         Z/NqST2TwVv5cR/6NJjDzBPu8GG2DcUzIspOoNulXiFRKUaUbZzfQdoJZfL2+WLpkjmb
         sKsWQmViUU9ZeriscjDPQPl1VjQtNYZ/uvqlJvC/sshyEP1pQUyaUQctxz4ulbOilQ44
         fh/Vl6mfoL7Nqd6WLcQYsInOAywZmduRaheNnKxrXsQY/MrhsRFTeVSis3G1fEHjWtsZ
         WFE5RvolVldeGS29ZSplUdupU530CUK4/vvxw9CfIAr2ZCrGIBq1305PW3LsRXN+SxId
         ZI2w==
X-Forwarded-Encrypted: i=1; AJvYcCWy9kKzGgb7eJFlPfIpTaxXvgub1d3JWcjE0+4tq22wfs2yKf1JZMZFCPU/nZfDfglbP4WTEuZ7ixVI8Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpgI1meuwz3w06TVryyHRHZTgf2wFP+k/Dgp7BKSm4qnHYVOJS
	fW+QesY3w/o9rytmmpBZB4VO8Ww9jTgt53PD3D1+pZ4XL+nTu0LYbBn3cYVr2fkO04dXWZaSioo
	l/7+Eqf1JJNwwhH0L6+QptawOx8Ypwr5SgW99I/XjdVuQUjv8PemGuEbyY5XG6THZbw==
X-Gm-Gg: AY/fxX4/CfRREZcShM3SplvvvF8gVStnOU06rjqqBXtlEn1b2OeZQM2h1ajjuLzuGlk
	Z7/8ZN0hm/5ng1HUnPYY85xf8jOS6ljx2W95dpfaY8T4B/xxvluAHOYNJRg1Q3CummfytCwjjeD
	T89K+BqsGGun/6JCuLYHhQJl/wK+MKyqCVgg0bfxsePdc04bE1v6zzbYYpxflBjELb5XsoMfcoz
	vlMwQgWHbP3LBXzc/KYOXDAOVjn6oyzvE/hX7/gqIkzDLwpUWgZ7nVfeLdZwtnljWiWsXYdpl+M
	k+RCv2Ciy+C8m8skalBMN4QjQa6XpuAGJV4gYImuzuB15H36d6xMOezyz0JcT2UkXBR1C5em89F
	JTB0r2rbB9GsCXunY
X-Received: by 2002:a05:600c:3508:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-47d18bd57bemr161759415e9.9.1766581278032;
        Wed, 24 Dec 2025 05:01:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHybeuqcZcHlfztr3bbKh1cFE8NLb3cLhTczAcvHp67h5Q0r41aRhsvZBwseTxwsTVGzvf/GQ==
X-Received: by 2002:a05:600c:3508:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-47d18bd57bemr161759125e9.9.1766581277580;
        Wed, 24 Dec 2025 05:01:17 -0800 (PST)
Received: from sgarzare-redhat ([193.207.128.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272e46fsm339791035e9.4.2025.12.24.05.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:01:16 -0800 (PST)
Date: Wed, 24 Dec 2025 14:01:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
Message-ID: <aUvjj1HyEG6_hoLR@sgarzare-redhat>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
 <aTw0F6lufR/nT7OY@devvm11784.nha0.facebook.com>
 <uidarlot7opjsuozylevyrlgdpjd32tsi7mwll2lsvce226v24@75sq4jdo5tgv>
 <aUC0Op2trtt3z405@devvm11784.nha0.facebook.com>
 <aUs0no+ni8/R8/1N@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aUs0no+ni8/R8/1N@devvm11784.nha0.facebook.com>

On Tue, Dec 23, 2025 at 04:32:30PM -0800, Bobby Eshleman wrote:
>On Mon, Dec 15, 2025 at 05:22:02PM -0800, Bobby Eshleman wrote:
>> On Mon, Dec 15, 2025 at 03:11:22PM +0100, Stefano Garzarella wrote:

[...]

>> >
>> > FYI I'll be off from Dec 25 to Jan 6, so if we want to do an RFC in the
>> > middle, I'll do my best to take a look before my time off.
>> >
>> > Thanks,
>> > Stefano
>
>Just sent this out, though I acknowledge its pretty last minute WRT
>your time off.

Thanks for that, but yeah I didn't have time to take a closer look :-(
I'll do as soon I'm back!

>
>If I don't hear from you before then, have a good holiday!

Thanks, you too if you will have the opportunity!

Thanks,
Stefano


