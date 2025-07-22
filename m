Return-Path: <linux-hyperv+bounces-6319-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1F0B0CFD9
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 04:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A523B0558
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 02:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CE2270ED4;
	Tue, 22 Jul 2025 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzrbK+0m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6B1270ECF
	for <linux-hyperv@vger.kernel.org>; Tue, 22 Jul 2025 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152434; cv=none; b=mN3JbfIgggQcf7Hlz6WgDzK8QpX7CWEhYN2Y60Smd34Waow+sWw80kLNHXLo+P9AKzmY4URBaMaO6cNB22EeOzT7sTG0mTCBEiURYLDTzykKJIiPir6I6v3s1kT9BM/GNldlT/z9BSueNMsrTkLTSNZeASeri4vMKV4nlorx4r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152434; c=relaxed/simple;
	bh=kCKyEvyaME9w7wWZPjOrMFKwm0hXVrCcUoazmS1Oke8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOIU1ubaotizd5iubw82dT0ybfXoKEk7duCCTo63u13ZnJdHt8JwsxH1b+C8tB7vb+BZvgNuQVrCKJ6oZRDY2wlSq2JtJPSADfJy6sITwVNNiauPoNVmD9d8vtnhz5stIAH0N0U7QD/Mu3A/P9Em3jD0Js2l2GwF6fSIp+y94No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DzrbK+0m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753152431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCKyEvyaME9w7wWZPjOrMFKwm0hXVrCcUoazmS1Oke8=;
	b=DzrbK+0mG6uTmuCIKTnGR1N0Vwlm7pMFBZDkpEExkTEZywSBnCK3VvyIcdwA0MOApRr2s6
	tuk7fNmPqfsQJ7w2RK9e5yCsKpIXA/cIXqcXhpDXfqs0UXEzz1swIlDJrC2ZijAtygwW1S
	/kfEtYXt57y1H/P8yGfy8rw+sKGwL3g=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-lDV3KoobM4S_T-tckJasCA-1; Mon, 21 Jul 2025 22:47:09 -0400
X-MC-Unique: lDV3KoobM4S_T-tckJasCA-1
X-Mimecast-MFC-AGG-ID: lDV3KoobM4S_T-tckJasCA_1753152428
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-53473ab4992so1025681e0c.2
        for <linux-hyperv@vger.kernel.org>; Mon, 21 Jul 2025 19:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753152428; x=1753757228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCKyEvyaME9w7wWZPjOrMFKwm0hXVrCcUoazmS1Oke8=;
        b=XTtwsUsP6FP5r6XXC2pAeCLUUwRvML1IiQgndZgcLOhFFGUzYp9o4YE0N7cZICgvwd
         1GlUafylU6M/rck4gNG4mhDh2Nbi9OS8sO++IDA/7TPsoSWJf9QO7jfe55gQrve87dNp
         TJxn35dkwNt4FWqwfxxKpiDsQCpQcYhm5sB5WEOZvY6r4LstQC5ob8+t0U6ieM6YipxH
         yJLG9w7EVgYbyQghFkS2Oz6Uku4JCqzeLjtT3BlPUEO/UbNpoo2MSGbMHauCWTztfH10
         2/Ulf+HUee84shaLS1vzDGNulC0AkYdZGbyf177pzXC87hKJszMaUKIqmMtKb0B7V5Nv
         N+dA==
X-Forwarded-Encrypted: i=1; AJvYcCVEwC9Bz3xIqILN6E0gtRNnzp6LNBYlraBD9q+VnSoU/hh+ph/jb/2SimsVGaLliNw8WXea3LPz9ojBLUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuhxw6yTLuaN263aH1XKQ48ZAg0zgomu6pBDm8jGjNsCy0zRMd
	Vrg90ElkaxYD7M5Cnxo2L13ByrnNcz7/Kc8jka/Umzakt5JzNQgQzu9szxsZ+y/8oEGV5sBE4+K
	6J4ShdDX23fDlt1aE3gYDaIuDyqeIUjoYNFqUNv+5/zxAEFsN4/bJlDsoN5DxtgBPVa4FNaYE+/
	Dnp+ytIXsTld+hf6HiwXB/YTUbzrA9a9fXsjDJh4BB
X-Gm-Gg: ASbGnctNW8OAc5TpJ0inPu1Pzn95CbyX2p32f7Xaw5s4DdwrVU1hIOCBduxzqKz6Mij
	9Sh4ATZq/iWGU9KJ3b0yUta2KsaIUnnCkK8wCNGQ+L3pY77ixYU7jsmtD4IO1PSda8DQHdfXwN4
	ZOjvUBJ4yEh/rPJ3dGQG9mxQ==
X-Received: by 2002:a05:6122:3d10:b0:537:3e5b:9f66 with SMTP id 71dfb90a1353d-5376482147bmr5706733e0c.12.1753152428496;
        Mon, 21 Jul 2025 19:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV65GEf/DyozjXmm0Me0cAGFvEFM6aRW6c2q/EOZGLutJWdB5Vun7O3DOic039V936BGNXEekLH8idxFs57TU=
X-Received: by 2002:a05:6122:3d10:b0:537:3e5b:9f66 with SMTP id
 71dfb90a1353d-5376482147bmr5706727e0c.12.1753152428170; Mon, 21 Jul 2025
 19:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718061812.238412-1-lulu@redhat.com> <20250721162834.484d352a@kernel.org>
 <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
 <20250721181807.752af6a4@kernel.org> <CACLfguXG7Mpsp=z4zCE7H4CMA_s9qV86SkeL7Q=WxChXcFpNfA@mail.gmail.com>
In-Reply-To: <CACLfguXG7Mpsp=z4zCE7H4CMA_s9qV86SkeL7Q=WxChXcFpNfA@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 22 Jul 2025 10:46:29 +0800
X-Gm-Features: Ac12FXz8Hsd99YwjuM8V3mxzon1LCiQIo6XR6UICD1OlRmKkbYUpCVM_dl99qBs
Message-ID: <CACLfguVi=+ZtikBwu-5ThEa095gDuCW8bVPo0QGdt6ja3xZjhg@mail.gmail.com>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
To: Jakub Kicinski <kuba@kernel.org>, Long Li <longli@microsoft.com>, stephen@networkplumber.org
Cc: Jason Wang <jasowang@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
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

On Tue, Jul 22, 2025 at 10:04=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, Jul 22, 2025 at 9:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 22 Jul 2025 09:04:20 +0800 Jason Wang wrote:
> > > On Tue, Jul 22, 2025 at 7:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > > On Fri, 18 Jul 2025 14:17:55 +0800 Cindy Lu wrote:
> > > > > Subject: [PATCH RESEND] netvsc: transfer lower device max tso siz=
e
> > > >
> > > > You say RESEND but I don't see a link to previous posting anywhere.
> >
> > Someone should respond to this part, please.
> >
> Hi Jakub,
> sorry for the confusion. I previously sent this mail
> (https://lore.kernel.org/all/20250718060615.237986-1-lulu@redhat.com/)
> to the wrong mailing list, so I'm resended it here.
> I've also submitted a v2 of this patch:
> https://lore.kernel.org/all/20250718082909.243488-1-lulu@redhat.com/
> Sorry again for the mix-up.
> thanks
>
> cindy
>
> > > > I'd rather we didn't extend the magic behavior of hyperv/netvsc any
> > > > further.
> > >
> > > Are you referring to the netdev coupling model of the VF acceleration=
?
> >
> > Yes, it tries to apply whole bunch of policy automatically in
> > the kernel.
> >
> > > > We have enough problems with it.
> > >
> > > But this fixes a real problem, otherwise nested VM performance will b=
e
> > > broken due to the GSO software segmentation.
> >
> > Perhaps, possibly, a migration plan can be devised, away from the
> > netvsc model, so we don't have to deal with nuggets of joy like:
> > https://lore.kernel.org/all/1752870014-28909-1-git-send-email-haiyangz@=
linux.microsoft.com/

I'm also including Stephen Hemminger and Long Li in this thread and
would greatly appreciate any suggestions.

Thanks
cindy

> >


