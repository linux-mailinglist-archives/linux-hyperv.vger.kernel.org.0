Return-Path: <linux-hyperv+bounces-8294-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED29FD20FC6
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 20:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B360A3025F90
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 19:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE35340282;
	Wed, 14 Jan 2026 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVIgoa+I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42712FFF9D
	for <linux-hyperv@vger.kernel.org>; Wed, 14 Jan 2026 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418039; cv=none; b=eAZXEozua2d7yo3WSrEbUTvcMnT5l9yoJGdyTxB3l7HTa6ip4gREPtBOL/9srxNejk9irhjPBUIlFN3toraEMwic5pfapumxzzwFRev2Hz49yc3nLRG1ZAM2k0tT9oLKKJP5p0BGLLAGl5kvfpNun8L3NimJXcCzf0QKaFCm8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418039; c=relaxed/simple;
	bh=QKRezXrA3bG4ArDBbT58+S8c1CtyAn6iBKaQozySKZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKZiO9HOdCx/aNg/+KAFyyE5lfZ9rEieUhcEzbusRV0DUbe+5dZFvOGWuP6OfLYm246vBRsrzocMkTILv40S6XgrZzA/OLUtTndLtwz41xyxOEXTNUdH8QR3X6HMwyZmM19/rbp48esB/cngHzyeABRqOYcqwT8TbiMy2UxS/9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVIgoa+I; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-941063da73eso118184241.3
        for <linux-hyperv@vger.kernel.org>; Wed, 14 Jan 2026 11:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768418037; x=1769022837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jUpDNPxjIqi9ICJXtc+mfMuxEexyo061EqFw5Nyb8q0=;
        b=NVIgoa+IMFoHSuKYsyQjrVU6Wdvlfk+ZxMqcRAvbsmOBiRoQ/Pus7M3A82D1XpdZ/y
         U0yA8MdYN3tctP/CFEz/Mep82MglO3960NE1+SlD+ApVSsZULZ8wbTbmFtSZH5WDyB6a
         P5kc3kz9k7WF4G09nEkrOVo237qDGLFckAAv1B1tz0/I7hwDYrtLjSoGeuTncwH3EiA2
         c29ewviTsyW1qfaP7mvOnoEyjY9loFrjvkVE8p4DHZdltSo6kMPmwMletL4dBUtV7G52
         WKOZZnKLqX8wISDKFxlssYqYOK4qwUa5R3bRC9Eo6B5eE/r5J4QrIsBypSWNnmon0CcH
         mTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768418037; x=1769022837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUpDNPxjIqi9ICJXtc+mfMuxEexyo061EqFw5Nyb8q0=;
        b=ryfcvHJcKNvVlCXKY2eBRc9d/I7hR5fQ+GEkQ0DmHysdqhOdZmc6OpckufFdxme4QL
         Rt6avK+tpNAi7clIsfDankDXcFOUs/FsbTiMPB9fAWTgdZNPzVymh/wNAceU6EJLVugS
         5cVF50FFWNjte2n/DDNVkrUaxUgrgW4lpAcUgc2+fbmHu0XnJ4CyqEpLiDHEBHuhmoPq
         w8xsr5TIl37CqH98ZbmG1H293avZ9qtZNHxLxxEXEmtO6HEshWv3vZnldCPmj76qoHY9
         3jXPxdunvDK1rQxQ51E4rnFEEBCKoEC/sFTS0TZ/bZIaVdgf5fPjusStJk1WSPPFu81T
         9tlw==
X-Forwarded-Encrypted: i=1; AJvYcCXAKixDCtAfeZaQEmoX1uJ5/1l10RXFWxwspjdF5j/WTHkfPTxjJRqXyrxk0SfhtwCY2JMgPUmdpXxzDcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH6CTLwrUE+LrH+qIjvGp+w6T8bX0CwKUBq7t26Iw/ee9qj5jU
	icCy4xS7fYhNbfuLDR9AmbnT9qCyJhppAtM9U4GlIFBXBTTn55FEFGQaBfl6iA==
X-Gm-Gg: AY/fxX5N3YYgIA+rCMKp2SvGhrn2wF2sfEhspfXCZ0qWT83cnGzM+pXtik5eT3/0JG5
	+4tuzPuqdSuRWPfB27wTquhGXnlMcOP/96Hm+7yWB3I7ABJ5ZSkVQor3xTsQPpbxOdDd9e87DPV
	fdN2O/2u8Q5AZ9yoFdalKO8tnZ7UgXj+Tygz1FB63J8jTB71BeHwyGNZ88S7cx6x2Xf2KF8Y8P8
	jVjb3hRwZfBpU62UT0QG0jDuGfaJ4xeZ97d09pN7YIPVJ4QmNkYpdhR5aogHNc2SQ9jwym98mIK
	eL/x2yqM81Dl/BB+6HSnb7SDXJIzvcO6DwP7q+E4gTMpxqQufADNtx2ct0vZif2MarB4GWjvikE
	Z938rnDZSkXhufSRnd22zPyuWQMtAmUe5XbLO73eJx3INKry9Yo0tRvOjepxv/JoLEQKz9gFdXA
	Q6B19/AKTWMaF5aiaxHdC9NNAbr0I8+/Vn3Q==
X-Received: by 2002:a05:690e:1c06:b0:646:eb06:f2e2 with SMTP id 956f58d0204a3-64903b513d2mr1973243d50.73.1768411311135;
        Wed, 14 Jan 2026 09:21:51 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6e12ffsm92418037b3.53.2026.01.14.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:21:50 -0800 (PST)
Date: Wed, 14 Jan 2026 09:21:49 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kernel test robot <lkp@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
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
	Shuah Khan <skhan@linuxfoundation.org>,
	Long Li <longli@microsoft.com>, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>
Subject: Re: [PATCH net-next v14 01/12] vsock: add netns to vsock core
Message-ID: <aWfQrS1oNcXwcXu3@devvm11784.nha0.facebook.com>
References: <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com>
 <202601140749.5TXm5gpl-lkp@intel.com>
 <CAGxU2F45q7CWy3O_QhYj0Y2Bt84vA=eaTeBTu+TvEmFm0_E7Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F45q7CWy3O_QhYj0Y2Bt84vA=eaTeBTu+TvEmFm0_E7Jw@mail.gmail.com>

On Wed, Jan 14, 2026 at 04:54:15PM +0100, Stefano Garzarella wrote:
> On Wed, 14 Jan 2026 at 00:13, kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Bobby,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on net-next/main]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/virtio-set-skb-owner-of-virtio_transport_reset_no_sock-reply/20260113-125559
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20260112-vsock-vmtest-v14-1-a5c332db3e2b%40meta.com
> > patch subject: [PATCH net-next v14 01/12] vsock: add netns to vsock core
> > config: x86_64-buildonly-randconfig-004-20260113 (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/config)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202601140749.5TXm5gpl-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >
> > >> WARNING: modpost: net/vmw_vsock/vsock: section mismatch in reference: vsock_exit+0x25 (section: .exit.text) -> vsock_sysctl_ops (section: .init.data)
> 
> Bobby can you check this report?
> 
> Could be related to `__net_initdata` annotation of `vsock_sysctl_ops` ?
> Why we need that?
> 
> Thanks,
> Stefano
> 

Yep, no problem.

Best,
Bobby

