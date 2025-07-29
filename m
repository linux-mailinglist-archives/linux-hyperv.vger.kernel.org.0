Return-Path: <linux-hyperv+bounces-6427-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6650EB14664
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 04:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF2B5425AF
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 02:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C10214801;
	Tue, 29 Jul 2025 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT3A3M0t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666B82144C7
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Jul 2025 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756940; cv=none; b=jXYi2jSE5aybSUK0Fm6rZKw0miMrRZa2xPO06oivwKaGOqVmZSebXymQV0ea3zjXEkKJ7RfQbL3hc6sV8ZKBPF/j/GxbZIsfWzpWC86MTdCwKErMGw1W7lThXkSpTAHjqvGVA6EO2m9461+SmdsJa11PKQDgR7q9kiZu5+LXouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756940; c=relaxed/simple;
	bh=Ww2f2ZpyJcTFXUKhLHEBwckLTS8uuClVa/W/yWcnBdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JB/WTl4/q3UDZQ/an/b0NRXAdGcr35Mhmn5kJ0XaIhiTXiP4elmVwSNrkb6XCZVR/wxqOB5g6vXxKT5gIrkR4/DCIh72/CErAb1LsCRiMBpQ39t/VRSa/AyKCGsLIfRimsK+9fKphRm7sTKk82CgQzOrnimgOBHGcLbS+WIk6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AT3A3M0t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753756938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ww2f2ZpyJcTFXUKhLHEBwckLTS8uuClVa/W/yWcnBdQ=;
	b=AT3A3M0tNgzOgLC1SIqduDhekisS0X4PeU/9ioY4GxLlPNk5YbrQmv/MHLOXCGD89XtNuA
	2NJb+iGAPvq4euF8OeMKCk6+ErIz0Js0tDZz4g0Mluex1AW9o3ATAJleTSJkfSrEfvPRg7
	xYtNDghBVlR6Jlz6ETJ/XgPWrUwlgA8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-EuxtoXstP8u5ejwfsqbnWg-1; Mon, 28 Jul 2025 22:42:16 -0400
X-MC-Unique: EuxtoXstP8u5ejwfsqbnWg-1
X-Mimecast-MFC-AGG-ID: EuxtoXstP8u5ejwfsqbnWg_1753756936
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so4947848a91.0
        for <linux-hyperv@vger.kernel.org>; Mon, 28 Jul 2025 19:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756935; x=1754361735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ww2f2ZpyJcTFXUKhLHEBwckLTS8uuClVa/W/yWcnBdQ=;
        b=VR27MKveAUhhMRjDHAWT5kYUjHJl0dVHXbxxMGHg+0s9e693fjsCMCRfnQbGdZy5XU
         cekzvSZ/jpAqjiNqsPhkDkOVSOiRcI01mE2DldpHCw9h9oYEfKGvJxz5AMITfzI7Y6vs
         Sr4V6/uK6uO1FvWzboJ8hU4+0qv8fQyAgAkfXa7t/KsLwwlClBkpWPT//AAbPu2A6n5F
         f+jMFRZ+E/+0O/HWvxxdaCvoW5NjiEex/UYb6NwWz3HvYNvkAcIlJJNe6hrBJT8sxbXy
         ak/Nkrr6BdXaiBlLcCD77b2ryUamGbnPoHcIV6HjcCdOjHe8Pk1+Kr0LY5iABLc7PQzb
         od8g==
X-Forwarded-Encrypted: i=1; AJvYcCWmdZ3iejXgGb5QhRsXIheqOL3s7yGO4JumbfIXnjltuLgu9ONtSFie0qSNoKxJ6pufDjIq5AwTbOyXJ8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs/9Tr+BrFblSLC9auJqt2wi2saoy5iLrnGTGJdXwI6jfXJRj3
	OhCaShBHGX5yUIC149odXT7yikqyaknzla2sT3Cn00JI4LjqB1PX5P+LWC5ANpiSwobj2bJeWyl
	xXEIsH8Zqvb3mm80s+vNz3WrzjyNeiF2jGczIu7aqYwxzpzORxcl2x+Ld7bh9H/3H2hQGWg3VTf
	jpAIouHdLXhn1+0jWqrPrwlMBBigvfUewvMCtSYC96
X-Gm-Gg: ASbGncuqPZ9ochgf5ymOMorJkEJfuUg3nj9X9vqDjd4zEH5ZbsVnESSixAEDtDb99D6
	0Xi0sXKZVl37W8c0NL7T0qneq0Ibk8WjMkd8uuqtf7/B1WitFsuzXx4+hp8kD8HLUPv21NUkEz/
	9IuO/3WjIzVMMkSHfzcws=
X-Received: by 2002:a17:90b:280d:b0:311:c5d9:2c70 with SMTP id 98e67ed59e1d1-31e7789934emr19500208a91.15.1753756935531;
        Mon, 28 Jul 2025 19:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiTrGIt7eoxqCmwJKJyFiSjpEt/y/C2GLW4uxNz1WclVI1OSQpVtk4/Uh3bkfM8enIwqKkmmo/XskQneWdc8g=
X-Received: by 2002:a17:90b:280d:b0:311:c5d9:2c70 with SMTP id
 98e67ed59e1d1-31e7789934emr19500181a91.15.1753756935041; Mon, 28 Jul 2025
 19:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718061812.238412-1-lulu@redhat.com> <20250721162834.484d352a@kernel.org>
 <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
 <20250721181807.752af6a4@kernel.org> <CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
 <20250723080532.53ecc4f1@kernel.org> <SJ2PR21MB40138F71138A809C3A2D903BCA5FA@SJ2PR21MB4013.namprd21.prod.outlook.com>
 <20250723151622.0606cc99@kernel.org> <20250727200126.2682aa39@hermes.local> <20250728081907.3de03b67@kernel.org>
In-Reply-To: <20250728081907.3de03b67@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Jul 2025 10:42:02 +0800
X-Gm-Features: Ac12FXzBxdqLecuJGApu98LjzbNbf9v9AdNqmCM9700YIpdOZpTnf4cOXXGt-No
Message-ID: <CACGkMEvwAqY2dRYLnUnVvprjoH8uoyeHN9CB9=-xRUE80m6JSg@mail.gmail.com>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Cindy Lu <lulu@redhat.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michael Kelley <mhklinux@outlook.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Kees Cook <kees@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Guillaume Nault <gnault@redhat.com>, 
	Joe Damato <jdamato@fastly.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sun, 27 Jul 2025 20:01:26 -0700 Stephen Hemminger wrote:
> > On Wed, 23 Jul 2025 15:16:22 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > > Actually, we had used the common bonding driver 9 years ago. But it=
's
> > > > replaced by this kernel/netvsc based "transparent" bonding mode. Se=
e
> > > > the patches listed below.
> > > >
> > > > The user mode bonding scripts were unstable, and difficult to deliv=
er
> > > > & update for various distros. So Stephen developed the new "transpa=
rent"
> > > > bonding mode, which greatly improves the situation.
> > >
> > > I specifically highlighted systemd-networkd as the change in the user
> > > space landscape.
> >
> > Haiyang tried valiantly but getting every distro to do the right thing
> > with VF's bonding and hot plug was impossible to support.
>
> I understand, but I also don't want it to be an upstream Linux problem.
>
> Again, no other cloud provider seems to have this issue, AFAIU.
>

There's a failover module which is used by virtio-net now. Maybe
that's a good way for netvsc as well?

Thanks


