Return-Path: <linux-hyperv+bounces-6351-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7939CB0EA47
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 08:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B192564345
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 06:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAB2475C7;
	Wed, 23 Jul 2025 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFRycZ5d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892F678F51
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Jul 2025 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753250466; cv=none; b=SsbIIX73kdBk9Ahvs/mc5q/nkrrJs3DaM5qijdCEzxvzOKOirH/YjfmxFDrpRQikCg1noILZK10dO/r7Db8azhE/Fz7vJbaZP4KhGSCxBnFU0Pn7IqD9Ohn4IPN3q+vW5QnNHuyqFLyNQq3rJyZZb7NGgaXRLSjnYL4p3JxhgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753250466; c=relaxed/simple;
	bh=W3OEZPSUScGaKIkoKNcKNemh+3UB9G5qvWLv5ZR7u3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOvZ/+dESflfLwAvvQ2cYtO7Pna2o8SO6heY9Yr8ID6DIKBVKrCsvLouJ2CtZf+eVtiGUuPrcgoDv/ubnsoawAeljUF7PZShoxAHqsknROcQKiMArFiSNRvSshW1n+OELob/GKNW6k+zSLnNL9ZbBw+K6P4arO7IgAKM8gbbGvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFRycZ5d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753250463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3OEZPSUScGaKIkoKNcKNemh+3UB9G5qvWLv5ZR7u3g=;
	b=UFRycZ5dPUl15/jXn+x9z6oG5qt7/5Ulx8CghiLwrL10ewCUDK2GsSSt2Jzow090LfKBPr
	FRL51UA3WCZLP4w2A+dWInHSmiUYyTe4FoSQnoS8MfdBfS2tUZQkl5MiL8FZOQgqm8OgLy
	JoQbZ28VtD1J/ULM8iJpB+j6Fi1vUb4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-xRhA4fQPOOCV-K0lgAhb1w-1; Wed, 23 Jul 2025 02:01:00 -0400
X-MC-Unique: xRhA4fQPOOCV-K0lgAhb1w-1
X-Mimecast-MFC-AGG-ID: xRhA4fQPOOCV-K0lgAhb1w_1753250459
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31cb5c75e00so576311a91.0
        for <linux-hyperv@vger.kernel.org>; Tue, 22 Jul 2025 23:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753250459; x=1753855259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3OEZPSUScGaKIkoKNcKNemh+3UB9G5qvWLv5ZR7u3g=;
        b=R8+qY40Yp5j8ge3PDsI+1eT9R2IZhniL9YVmewOLRSbpuovnWpSFP9gJw9CtAUjEnL
         DQ6/KwMbwlXVtmzX04jCiS+1TnnebzyjISXPjf7EeJ5iX0KPTanZjRlt7qsfBk/Oy/bR
         rZk3Mpk+W7R4LPtSKc4GKJvGzgAvwx2fWMTU5r8dak4WX60GbZLVRj9lp2xXFAyss9aH
         MRwosiKcWYAR/HGX4wwyV/7zpbHUZyOllecPAI7UtQMyZQxtTflAErlG6aOvnpkDjxS6
         qGy3vz3ja2PJ+MJfqGJcNU4qi32UiqemC3KHPVsaSZG1CF/DzuDriQD3r03QJjZVX6+W
         7soQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL7H8k9qgr7SksFtUoyUV1axkOSb+/52NjlHb2sfyut5iXOkIAKMOMOhIOYusOJQwaPfUciOWb7EnWu54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbhbeRkQoiYG35EHBkHKogJF/Kob8oGrTc3l7C7shOAthH3SfO
	ASsCsS0wGUxAXBugekqNyT6HQ2+5e3fFPfdcVSs27BhJScW51n8ZbCiKUH7FQsOA9lxuRMggwjO
	MIr8eUeON1OVUYFc91JoNV4KUyJMpfNZnEfuPhet7IjSJCYx9TBxzIQMmI8kmm4TSH6I6FWr1J+
	AS3rfnhq2vfMDW4sh5JKdLkXLmcGOi+oBYT9MiVMqi
X-Gm-Gg: ASbGncut+4VTMKGSAf/N3w4zt5NLkXyOIUcDQgQzVB3zxcAraTuwq6SsLiUH6kxhekW
	LVM3ApXWKIWZK2w56rRMW2Gcunq32VPHR1r/UoZ2A0LpcBQw3DgyiwYSEsX9Y29DoBuv7J0i09h
	dIjCnfUEo17ruPxJZXN8o=
X-Received: by 2002:a17:90b:1c8d:b0:31a:8dc4:b5bf with SMTP id 98e67ed59e1d1-31e3e218aaemr8741145a91.17.1753250458793;
        Tue, 22 Jul 2025 23:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfliq5NGtPU/ziGbtu8YM4b/iq3mmjjPMpvlbkNtkuESyW0l9icnltubphyWJS/Lk+K+taORz5U6WVf0EI7c4=
X-Received: by 2002:a17:90b:1c8d:b0:31a:8dc4:b5bf with SMTP id
 98e67ed59e1d1-31e3e218aaemr8741094a91.17.1753250458228; Tue, 22 Jul 2025
 23:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718061812.238412-1-lulu@redhat.com> <20250721162834.484d352a@kernel.org>
 <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com> <20250721181807.752af6a4@kernel.org>
In-Reply-To: <20250721181807.752af6a4@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Jul 2025 14:00:47 +0800
X-Gm-Features: Ac12FXwsu5AMgm40YID7nIeVAKGIxY3SiYvCb26wbwKJM0nbVKa8OQafZHUHruE
Message-ID: <CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cindy Lu <lulu@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
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

On Tue, Jul 22, 2025 at 9:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 22 Jul 2025 09:04:20 +0800 Jason Wang wrote:
> > On Tue, Jul 22, 2025 at 7:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Fri, 18 Jul 2025 14:17:55 +0800 Cindy Lu wrote:
> > > > Subject: [PATCH RESEND] netvsc: transfer lower device max tso size
> > >
> > > You say RESEND but I don't see a link to previous posting anywhere.
>
> Someone should respond to this part, please.
>
> > > I'd rather we didn't extend the magic behavior of hyperv/netvsc any
> > > further.
> >
> > Are you referring to the netdev coupling model of the VF acceleration?
>
> Yes, it tries to apply whole bunch of policy automatically in
> the kernel.
>
> > > We have enough problems with it.
> >
> > But this fixes a real problem, otherwise nested VM performance will be
> > broken due to the GSO software segmentation.
>
> Perhaps, possibly, a migration plan can be devised, away from the
> netvsc model, so we don't have to deal with nuggets of joy like:
> https://lore.kernel.org/all/1752870014-28909-1-git-send-email-haiyangz@li=
nux.microsoft.com/

Btw, if I understand this correctly. This is for future development so
it's not a blocker for this patch?

Thanks

>


