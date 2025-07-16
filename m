Return-Path: <linux-hyperv+bounces-6276-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED1BB08010
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 23:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33DB1C24DD9
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 21:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D412EE263;
	Wed, 16 Jul 2025 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAUAZ6/f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38D2C3756;
	Wed, 16 Jul 2025 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703141; cv=none; b=WSCA+N58uY9kKBcuBna4Tj1pzZe2h71Xqkys7Qjevqy4kVPLYt3ydxUeiuJoybbjBx8fhrkg/yiIoGMZZolC6d32+c+cn8Q33QiLE8/bL1yaMIoyIwXh8L/L9IH/tD8olkUpOcKsHcXAgBBU0MIugR2aRpII1GaCrE+ek7VquMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703141; c=relaxed/simple;
	bh=UkBJ9cHYRd6RJlLltFrluzjDP16UJwlZC6ZXRxpXOZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWQLfvH/owZewZcWLaiFZtdM7PtkJiYW4kOWOOLPM1wBTJBqBRHeIjO3y649/C7mxzxlEo3HR5Tn5SFnUn4iOn/uFnA3af5q1BqoKkbhn37scc3O3CNWLYJyaTqIDguSEnd923pmxQZKUf8bO/sFntCvxJN2VRI42lsFvM5Iop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAUAZ6/f; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3df210930f7so1777365ab.1;
        Wed, 16 Jul 2025 14:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752703137; x=1753307937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRyPRnH4RA0lEl0YXiJRnsaPybpKGPwgWOjr0WxsL+4=;
        b=XAUAZ6/fblSDGgk4m1yFwyn2zD9aLmUSEUBQKIjpQpIElyJmSCBHs7nmQxKa+MlZMM
         HSz66lgHh5rCurGJWFjaaCuZ0toYhk0eeaKR9E5rDbYViyJQ5CxHoGHzU5juKsxnQlrv
         2IaSi5Km/1u2qTFwKn/4gHDOKiPqn7yq62mvqQ7tfWNQ5l6XxxT937cSdUicrrvRHT8A
         udx49iEgg1klP5O+fHpbziDIAESIopt1p5e4ITZf5rkfXkzYiBEyvVeRhMYnUfLrIw8p
         0uvPqA/8yuXH3k36uiJ1oCDJIsrmEcq9qWh6+qv74snK2lQzVm2IjtTfn43rB12YKQtz
         AppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703137; x=1753307937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRyPRnH4RA0lEl0YXiJRnsaPybpKGPwgWOjr0WxsL+4=;
        b=HslZ+bvNdSzU+IUVa8qBFxCyazM/NZqZV3l1gbR7Tz3OMQcKjkeW7GvkgtHZUkZGMz
         J/6fgQcoqOlM2fZxCeEVRBiSpPDMYxTGqx739KJhDm4xV2Ou9iOoPN4EBlbzizM9m53m
         YA68MkcIaBIsLXhK9W6sbQkvApHaZ3eBs2DjWvnofDB0aq0onk4okm2kqCIEBIL5dD2G
         W1KD5DqSfwL2ssCVN9wQ3ac9A2VOb8MeYrP2Ztw0p3CLSezZAkEsfr1lopz7de39whnd
         NRgbsqO0KIP2s3X5vNmN95Z38p7UQ3ItTxe8qjmHiXnMGKwVVTdD9BTD+oryG8SlzJQV
         YRkg==
X-Forwarded-Encrypted: i=1; AJvYcCUbVWQaqxzrlSb8Ad2Wt8cb6dBwzFfAVbucTmPLKz1HjjCJQmgnWPBQsJf1Z9A3CKK/aIL6BygIdBZP+fk=@vger.kernel.org, AJvYcCX3sgqyAz7yoY6XuqXWgO8xkkuegQ0BLthifGKepxhPow/AH6ZVK6qZJNJGOO5y1TE9qK4O6mob@vger.kernel.org, AJvYcCXSMkNDQbEXDkPoTit6GyFC35oY4n/L0ij7h3xU7hJXLR75WeSPWe4QeGtaJSVlXeyrEQAOmjvPIIx25J8I@vger.kernel.org
X-Gm-Message-State: AOJu0YztBTdJEaHQxPl/y/vmCIS9N+45050yovZN8Q4oMHEhxjxBZaqE
	NvtDUmPIn6s6/NFS4VZtwqlkysRJJlrir20V1HRTGwIg0zB5PijSyVXp1PCTIHp2mi7grCeHmob
	wTRfwf/sBlawISfuVTGFR6cPHQCXbFbDGIJxY
X-Gm-Gg: ASbGnct7jh0N524gOhXmmMYW5DK0IzqwtVFEJRDA7qQrPlSRkMXjbWb8BLrmYMJLDmK
	8cAtikEVA++ELk0N7pOYEbWs9FPlZPHRkjWQiPOtmnqbhPfNSMbIOhZhxOkvudK0LRts7K+cD2Y
	81jUOKUyxzEyrb/BELY2QKrD9CepNE1aicYd6zDDRa1Xb5pXwXT45ZIHPM8lp9foMiwHOav6xWV
	VikD6iD+YisVVwTvBd29M5DicLKLgkWbmziFzFXyQ==
X-Google-Smtp-Source: AGHT+IE3a6WhwJDruIuFMeBsTOmTR/N3kTnhGSIPlruRWVnOf+Fd9QQFjbSI3bmdZbPZcMnwYlm9nS7oMyOIHKd4+3o=
X-Received: by 2002:a92:c649:0:b0:3e1:3491:e873 with SMTP id
 e9e14a558f8ab-3e28ba05923mr13473965ab.10.1752703136658; Wed, 16 Jul 2025
 14:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716002607.4927-1-litian@redhat.com> <20250716092927.GO721198@horms.kernel.org>
 <CADvbK_cdOTO_UVg6ovx-Si7-ja=ErYw-MnSnR-CL4HwmtKJ8YQ@mail.gmail.com> <SN6PR2101MB0943EAAB55E0BF97E0841419CA56A@SN6PR2101MB0943.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB0943EAAB55E0BF97E0841419CA56A@SN6PR2101MB0943.namprd21.prod.outlook.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 16 Jul 2025 17:58:45 -0400
X-Gm-Features: Ac12FXyPbx72VLC09xD0LTQCjT62SZmePXXnJFipm7Xmc3IgwrmJvHi6smqgTY0
Message-ID: <CADvbK_cgPq8x5OR2RomZqL9+_ce8-e=-EG2pZw6TK4mE1ova3Q@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v3] hv_netvsc: Set VF priv_flags to
 IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Simon Horman <horms@kernel.org>, Li Tian <litian@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Long Li <longli@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 12:15=E2=80=AFPM Haiyang Zhang <haiyangz@microsoft.=
com> wrote:
>
>
>
> > -----Original Message-----
> > From: Xin Long <lucien.xin@gmail.com>
> > Sent: Wednesday, July 16, 2025 11:14 AM
> > To: Simon Horman <horms@kernel.org>
> > Cc: Li Tian <litian@redhat.com>; netdev@vger.kernel.org; linux-
> > hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; Haiyang Zhang
> > <haiyangz@microsoft.com>; Dexuan Cui <decui@microsoft.com>; Stephen
> > Hemminger <stephen@networkplumber.org>; Long Li <longli@microsoft.com>
> > Subject: [EXTERNAL] Re: [PATCH v3] hv_netvsc: Set VF priv_flags to
> > IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
> >
> > On Wed, Jul 16, 2025 at 5:29=E2=80=AFAM Simon Horman <horms@kernel.org>=
 wrote:
> > >
> > > + Xin Long
> > >
> > Thanks for Ccing me.
> >
> > > On Wed, Jul 16, 2025 at 08:26:05AM +0800, Li Tian wrote:
> > > > Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.
> > > >
> > > > Commit under Fixes added a new flag change that was not made
> > > > to hv_netvsc resulting in the VF being assinged an IPv6.
> > > >
> > > > Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bondin=
g
> > to prevent ipv6 addrconf")
> > > > Suggested-by: Cathy Avery <cavery@redhat.com>
> > > > Signed-off-by: Li Tian <litian@redhat.com>
> > > > ---
> > > > v3:
> > > >   - only fixes commit message.
> > > > v2:
> > https://lore.ker/
> > nel.org%2Fnetdev%2F20250710024603.10162-1-
> > litian%40redhat.com%2F&data=3D05%7C02%7Chaiyangz%40microsoft.com%7C8048=
5948c
> > b344b12f2dd08ddc47b7c6e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63=
888
> > 2756868249313%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwL=
jAu
> > MDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&s=
dat
> > a=3D1ljWIFtnhAiGjdIEgNNlQZGK%2F%2FZHdgHVkvyCWY9%2BKxI%3D&reserved=3D0
> > > >   - instead of replacing flag, add it.
> > > > v1:
> > https://lore.ker/
> > nel.org%2Fnetdev%2F20250710024603.10162-1-
> > litian%40redhat.com%2F&data=3D05%7C02%7Chaiyangz%40microsoft.com%7C8048=
5948c
> > b344b12f2dd08ddc47b7c6e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63=
888
> > 2756868272381%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwL=
jAu
> > MDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&s=
dat
> > a=3Do%2B2BM9YEi3O2zcqQu9KfPae6PZerBWO%2FhL5KCIeJ9xI%3D&reserved=3D0
> > > > ---
> > > >  drivers/net/hyperv/netvsc_drv.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > Hi Li Tian,
> > >
> > > Thanks for addressing earlier feedback.
> > >
> > > I don't think you need to repost because of this, but for future
> > reference:
> > >
> > > 1. Because this is a fix for a commit that is present in net
> > >    it should be targeted at that tree.
> > >
> > >    Subject: [PATCH net vX] ...
> > >
> > > 2. Please use get_maintainers.pl this.patch to generate the CC list. =
In
> > >    this case Xin Long (now CCed) should be included as he is the auth=
or
> > of the
> > >    patch cited in the Fixes tag.
> > >
> > >    b4 can help you with this and other aspects of patch management.
> > >
> > > >
> > > > diff --git a/drivers/net/hyperv/netvsc_drv.c
> > b/drivers/net/hyperv/netvsc_drv.c
> > > > index c41a025c66f0..8be9bce66a4e 100644
> > > > --- a/drivers/net/hyperv/netvsc_drv.c
> > > > +++ b/drivers/net/hyperv/netvsc_drv.c
> > > > @@ -2317,8 +2317,11 @@ static int netvsc_prepare_bonding(struct
> > net_device *vf_netdev)
> > > >       if (!ndev)
> > > >               return NOTIFY_DONE;
> > > >
> > > > -     /* set slave flag before open to prevent IPv6 addrconf */
> > > > +     /* Set slave flag and no addrconf flag before open
> > > > +      * to prevent IPv6 addrconf.
> > > > +      */
> > > >       vf_netdev->flags |=3D IFF_SLAVE;
> > > > +     vf_netdev->priv_flags |=3D IFF_NO_ADDRCONF;
> > If it is only to prevent IPv6 addrconf, I think you can replace IFF_SLA=
VE
> > with IFF_NO_ADDRCONF.
> >
> > IFF_SLAVE normally comes with IFF_MASTER, like bonding and eql.
> > I don't see IFF_MASTER used in netvsc_drv.c, so IFF_SLAVE probably
> > should be dropped, including the one in __netvsc_vf_setup()?
>
> The IFF_SLAVE is not just for ipv6, the comment should be updated.
> IFF_SLAVE is also used by udev and our other user mode daemons, so it nee=
ds
> to stay.
>
Got it, then the patch looks good to me.

Reviewed-by: Xin Long <lucien.xin@gmail.com>

