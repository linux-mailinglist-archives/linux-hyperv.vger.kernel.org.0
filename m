Return-Path: <linux-hyperv+bounces-6268-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A17AB07970
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 17:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97FD189F770
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBB626E16E;
	Wed, 16 Jul 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcN9ivjo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D161D5CFB;
	Wed, 16 Jul 2025 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678881; cv=none; b=hn6vNXNn5hC28krTNsN7nt+O5emykDKe2xQv0SSB5aWb/CicFZ+F/VU0kLtBzLdAGJUY/GLwoly9U3gsBlAYTsnRkRZyz+d5Ai/vW8OyrNHo1YYP4l6h61vkEnnotmbt3+9WCn+AwZbIipmd6jERqu93UFeibvqZGyYPKR47tEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678881; c=relaxed/simple;
	bh=JGfjaozL+xMWdV0XXsCKfSFov9DvkeQMxV6cXeLB/VI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZdUzi9Z/3drJO+YKPnEMoxPsFYbIxZeHZbMASTIjHwdCJET2F9boMPoe+zmsTFIQ1Yl4rW8E0roNywHZhSCBRZn0l778JBFN55mWdXOsVtG1XIPETuAdbphU4PruEDK7wEeJHs9Ybi9NcfOgQzutp6oQL3qVtOuK/Sc4Q0r9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcN9ivjo; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3de1875bf9dso50056515ab.2;
        Wed, 16 Jul 2025 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752678879; x=1753283679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tlzgsqxl7m0sFdq0NXyFVdMSE8vaPjAL8cIJQh6kUxs=;
        b=KcN9ivjo06XnFKxdnTlMlV7L/B/Hnf4f4JM2JPNKWn2XbOolL1DvmjPK0GEdYaYivp
         O/KXXUeULWj1sL9H5gg1kTI/8+CNonoxY7OPrOOhlipUR7nY+G8CavR0keEmWH2aGa1U
         EsP2dClqlcOYGo/W+U9HFDCwZsH8OkOaHBkx+zhiFkWSIZSYfOPIMCd+uCE+moBiskYK
         agc75xbS9b0OrmugpdNVXha+NGOte/smStoewKFWR/CZgPSTofiP87mQxERk3BW4WFLg
         AwMMf4+KK2SABgfe2Aoly4clLD2VBNnAx4M3qb9sBh1Wqjv3hCiUq39dwghVfMyxxQe/
         n23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678879; x=1753283679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tlzgsqxl7m0sFdq0NXyFVdMSE8vaPjAL8cIJQh6kUxs=;
        b=cgUWL/xUAXlnCguwpJSqbXCTSfL/M+miL8aEcW759Xj8IZmhDpalHgP9u66c24gWte
         UEzfpCF0HR2wIM3pld4s5K1DNxD6Ul5ja1ZPm8JMiVXVQWAyhwSGCjQc0lFGkHu51cav
         XKXbHjkmJbDqhGc7pKOiKbNlykKwys/720D6GKKaadqdpxJgkcKAyNezrPfeIZbTYozl
         0FlCvwReN5mneGQY50K0q/yctwxF+ygsrRX5JF+pVaYcaYRm3ayy3VzxCCU/9o4wbgdY
         0w+fUXA4bBNXd5JuxZrTBm0Hc7ZdYgvIYkNKNbH1guP7n6zm3wWltt5lGEIgh4egCXZy
         n6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB/y1z9P5j21b32jGw8AppR5h5LJ52PS2YaU20+HNDp2cvWx6uded2E5enC+k789CAjwYj6k3c@vger.kernel.org, AJvYcCVLECXRg5jQJiA8jJTX2Vgb/Ijr2gAs1vyvD/UCOfcErLGe0Yxxgmgqk43ovks4osxPQ5RGetk88+SyBKo=@vger.kernel.org, AJvYcCVsavhaKxi2hIx1QcJNFJhkuK8kGPiCpoS9UMfwgkCrr4LVR8W846ahIURkQTWYPas6Bs+WoEw2ClEzboj1@vger.kernel.org
X-Gm-Message-State: AOJu0YynYEa8F3RrZzSpu98TiBl7LRlyNNRuYGcMU3iZq+IymJMwyP1v
	DpSL+3cT9MuTixRiZ9qY3HHpWUG7vLQm21PI71ipxolZ4u6sdj3Ef2/PZR6TRsTr35H9YFYoCWG
	r9M6fPRfnj5oC14c9Y4UG9Rm38q6n55k=
X-Gm-Gg: ASbGncsB8FH0913suH1qGWCmPbFnFqHVzU/8tvRftoQN2daDzI/GdfX/WUC12Qj+iMX
	HrRpoeCnzKjQprDnl+xGv5EYeDREpIxGH1i1aspre2aFCtgDVXAoS7Qj2TASN7nKdb/ckd77v6C
	whVzr0XsAtL86St2Qc7pNlIc6pU2LVX6HXET0BwgI4ydEt9tg/pxQxLJnpZUtCyx0MRbuKqw8Bn
	vRFKfUnxOWhfe0iwVcfZWnVBT6O9eKbPp0LNcYJSbXZJ5LOeA==
X-Google-Smtp-Source: AGHT+IGp/w3OhbRlKaM7WBwVtAScqPY2hyXHH8Wk9zGmZCUUR4ZjE70sSQQPOYoyxVo6u3eMkVfJe9O/iwLboHF517E=
X-Received: by 2002:a05:6e02:1c07:b0:3df:29c5:2972 with SMTP id
 e9e14a558f8ab-3e282da9cd2mr33620365ab.9.1752678878693; Wed, 16 Jul 2025
 08:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716002607.4927-1-litian@redhat.com> <20250716092927.GO721198@horms.kernel.org>
In-Reply-To: <20250716092927.GO721198@horms.kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 16 Jul 2025 11:14:27 -0400
X-Gm-Features: Ac12FXzRov1GHK8odSuvmX5RhEKm0LzXVxiEG0Fsrz9TLbCQQXwLzdiuH9ZNDo4
Message-ID: <CADvbK_cdOTO_UVg6ovx-Si7-ja=ErYw-MnSnR-CL4HwmtKJ8YQ@mail.gmail.com>
Subject: Re: [PATCH v3] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before
 open to prevent IPv6 addrconf
To: Simon Horman <horms@kernel.org>
Cc: Li Tian <litian@redhat.com>, netdev@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, 
	Dexuan Cui <decui@microsoft.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Long Li <longli@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 5:29=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> + Xin Long
>
Thanks for Ccing me.

> On Wed, Jul 16, 2025 at 08:26:05AM +0800, Li Tian wrote:
> > Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.
> >
> > Commit under Fixes added a new flag change that was not made
> > to hv_netvsc resulting in the VF being assinged an IPv6.
> >
> > Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to=
 prevent ipv6 addrconf")
> > Suggested-by: Cathy Avery <cavery@redhat.com>
> > Signed-off-by: Li Tian <litian@redhat.com>
> > ---
> > v3:
> >   - only fixes commit message.
> > v2: https://lore.kernel.org/netdev/20250710024603.10162-1-litian@redhat=
.com/
> >   - instead of replacing flag, add it.
> > v1: https://lore.kernel.org/netdev/20250710024603.10162-1-litian@redhat=
.com/
> > ---
> >  drivers/net/hyperv/netvsc_drv.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
>
> Hi Li Tian,
>
> Thanks for addressing earlier feedback.
>
> I don't think you need to repost because of this, but for future referenc=
e:
>
> 1. Because this is a fix for a commit that is present in net
>    it should be targeted at that tree.
>
>    Subject: [PATCH net vX] ...
>
> 2. Please use get_maintainers.pl this.patch to generate the CC list. In
>    this case Xin Long (now CCed) should be included as he is the author o=
f the
>    patch cited in the Fixes tag.
>
>    b4 can help you with this and other aspects of patch management.
>
> >
> > diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvs=
c_drv.c
> > index c41a025c66f0..8be9bce66a4e 100644
> > --- a/drivers/net/hyperv/netvsc_drv.c
> > +++ b/drivers/net/hyperv/netvsc_drv.c
> > @@ -2317,8 +2317,11 @@ static int netvsc_prepare_bonding(struct net_dev=
ice *vf_netdev)
> >       if (!ndev)
> >               return NOTIFY_DONE;
> >
> > -     /* set slave flag before open to prevent IPv6 addrconf */
> > +     /* Set slave flag and no addrconf flag before open
> > +      * to prevent IPv6 addrconf.
> > +      */
> >       vf_netdev->flags |=3D IFF_SLAVE;
> > +     vf_netdev->priv_flags |=3D IFF_NO_ADDRCONF;
If it is only to prevent IPv6 addrconf, I think you can replace IFF_SLAVE
with IFF_NO_ADDRCONF.

IFF_SLAVE normally comes with IFF_MASTER, like bonding and eql.
I don't see IFF_MASTER used in netvsc_drv.c, so IFF_SLAVE probably
should be dropped, including the one in __netvsc_vf_setup()?

> >       return NOTIFY_DONE;
> >  }
> >
> > --
> > 2.50.0
> >
> >

