Return-Path: <linux-hyperv+bounces-518-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9DD7C5D3E
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 20:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B45282D3F
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501DF3A29C;
	Wed, 11 Oct 2023 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Znfct9J5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003B3A294
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Oct 2023 18:57:35 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C824D93
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Oct 2023 11:57:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso2413a12.0
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Oct 2023 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697050652; x=1697655452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxkPm2B1OBi9iYXN9MuYvqMChLrgNkYVTRTGG0T2fWU=;
        b=Znfct9J5uEgMZVS1t6P08/oENe6hb2X2cUn4rUHygOG4K4hSUJyA46KYMfvuMVvnNC
         YBOg90xjmdMPkrghJIlAI1sFi3qYnzIvOAFlLJlt0SkPZIgITJf0aEdqZlk33s27PL0/
         rTu+SQsfw9ESzD7QWQ2+5kvmW63c2uUtP0j3a7r2Ght46DlR0kUS+pLaOLfxxr1DgVT7
         wPYLtGItYZiDYhtRIvID7Wq9EACmVar0wTdyCmGKI5VNywMahzf6bOBVV6tqXtj5vc5Q
         S8qW30qGBXXJn2rRFxe4jS9ZhMVHRHKerR93I0WeFeJRYsMx9fSk/rVjmwO8q2Be+3RY
         Zjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050652; x=1697655452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxkPm2B1OBi9iYXN9MuYvqMChLrgNkYVTRTGG0T2fWU=;
        b=rH419Q9gpdugFsFfQGdqZSi73ZyJUp8WJouBp7T1TqUjysKN5j/UJD+lFQyfSOoSU/
         a5NKZnfbm6cPTQ+pkO1ZlB5smF6YWXwKdGnzpxCuhQcPe3MGVQ061GdpV6FvtvUEFDE2
         r2sLcmcjNgAfu4cMIzyCwdYRuQz21p1f+xRVna2LMvInolpwxKtcgqxfRTtlizYfe92h
         Rw/oFnXRlO/kxZ1Fammq81vpRo9j2DywZGtS918yb5w7aQIuXNdz4/RbAPqpVIIikUNE
         gQQBlySuVUERcHGqsUlY6oSpHUYQmhbZOEJGdTyV3XCBNuac6JhLIqZJOTEHngsAq6M2
         d9jA==
X-Gm-Message-State: AOJu0YxbWnjadbZ5xwIfiTEcQpT1UBj+WoMC8ucLk6dnkHwLBI4MwKvy
	QkBuW/7PVhyhsbdwJgyNLTYXhchF8HHBZnmU6Ax6Tw==
X-Google-Smtp-Source: AGHT+IFc/89I7Y+6rUKwx8XNGrZ9m5vt94TlXkrFXEIM0Zdkve1IgyQhh4RAedFUg2xtXtVh8L8xDVXSIjlO7zGT0M0=
X-Received: by 2002:a50:c35c:0:b0:538:50e4:5446 with SMTP id
 q28-20020a50c35c000000b0053850e45446mr140284edb.5.1697050652003; Wed, 11 Oct
 2023 11:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com>
 <20231010151404.3f7faa87@hermes.local> <CAK6E8=c576Gt=G9Wdk0gQi=2EiL_=6g1SA=mJ3HhzPCsLRk9tw@mail.gmail.com>
 <PH7PR21MB3116FC142CAECCD5D981C530CACDA@PH7PR21MB3116.namprd21.prod.outlook.com>
 <20231010191542.3688fe24@hermes.local> <PH7PR21MB311616744CBE08375C52C2B8CACCA@PH7PR21MB3116.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB311616744CBE08375C52C2B8CACCA@PH7PR21MB3116.namprd21.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Oct 2023 20:57:18 +0200
Message-ID: <CANn89i+DWa-xbBToc2-Zr2YyZ_axbeo6poyLp9t-XqGr2EzOPA@mail.gmail.com>
Subject: Re: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Yuchung Cheng <ycheng@google.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"kuniyu@amazon.com" <kuniyu@amazon.com>, "morleyd@google.com" <morleyd@google.com>, 
	"mfreemon@cloudflare.com" <mfreemon@cloudflare.com>, "mubashirq@google.com" <mubashirq@google.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "weiwan@google.com" <weiwan@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 8:49=E2=80=AFPM Haiyang Zhang <haiyangz@microsoft.c=
om> wrote:
>
>
>
> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Tuesday, October 10, 2023 10:16 PM
> > To: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Yuchung Cheng <ycheng@google.com>; linux-hyperv@vger.kernel.org;
> > netdev@vger.kernel.org; KY Srinivasan <kys@microsoft.com>;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; corbet@lwn.net; dsahern@kernel.org;
> > ncardwell@google.com; kuniyu@amazon.com; morleyd@google.com;
> > mfreemon@cloudflare.com; mubashirq@google.com; linux-
> > doc@vger.kernel.org; weiwan@google.com; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
> >
> > On Tue, 10 Oct 2023 22:59:49 +0000
> > Haiyang Zhang <haiyangz@microsoft.com> wrote:
> >
> > > > > If this an application specific optimization, it should be in a s=
ocket option
> > > > > rather than system wide via sysctl.
> > > > Initially I had a similar comment but later decided a sysctl could
> > > > still be useful if
> > > > 1) the entire host (e.g. virtual machine) is dedicated to that appl=
ication
> > > > 2) that application is difficult to change
> > >
> > > Yes, the customer actually wants a global setting. But as suggested b=
y Neal,
> > > I changed it to be per-namespace to match other TCP tunables.
> >
> > Like congestion control choice, it could be both a sysctl and a socket =
option.
> > The reason is that delayed ack is already controlled by socket options.
>
> I see. I am updating the doc and variable location for this sysctl tunabl=
e patch
> as suggested by the reviewers, and will resubmit it.
>
> I will also work on a separate patch for the setsockopt option.
>
>

I am not sure about adding a socket option, and finding room in the
socket structure.

See our recent effort reshuffling fields in tcp socket for better
performance (stalled at this time).

I would rather experiment first with a sysctl.

