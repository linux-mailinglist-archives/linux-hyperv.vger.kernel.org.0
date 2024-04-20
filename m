Return-Path: <linux-hyperv+bounces-2016-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C38ABAC7
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Apr 2024 11:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274721F21245
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Apr 2024 09:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E15171B6;
	Sat, 20 Apr 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjYPqOfG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF3C14AB4
	for <linux-hyperv@vger.kernel.org>; Sat, 20 Apr 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713605385; cv=none; b=us3id+NKJs072YGwshFHy7kjDiWrOyBQHpF8LwWAiXo1m93GpF2auzJjESRegSxpKLS3ZBM7eOgc/Rhl5DUVfUmumpT4QadDSPy/tYoK1FlC+sFr705K9+da783O+ISTwdDJDfQpn642DAtU4NKyzEcRx7T5YcZSiY/56vziutM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713605385; c=relaxed/simple;
	bh=TmS81HAjOmqQQ/TRTduklSWIG7EHYBD3vgJmKyLSBi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sco1Xhfof8sQo4vURjNHkL8IoZx/0toysH5CBqQ6L/5XZoA58cbL5poV0/pmxK6hcP3NeFX1uvj+PAC9RlmlE8ZpLbZOEHN8t2we09Y5nsNshbwwOdNo3g7ZyCJuwAqGMHESshZMBcqD47aGGkmS25j8HBDtvnXdm2USb6tSzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjYPqOfG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51a7d4466bso294668266b.2
        for <linux-hyperv@vger.kernel.org>; Sat, 20 Apr 2024 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713605382; x=1714210182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tL9SzqjKZJjSqoxD/K6mR5BweiSCQYf0x9/vIAfRvyQ=;
        b=VjYPqOfGZr+icvCkO5PMwafIZpYNNjlBEukNuMRi2Syta+tYarI/h9Sm9RAdpi6U2D
         7R6nlxRI2SGrpCNes7zeU+sZGIzyKAMNv59jHj5Kwq/qzxoapGBX4HXdvtzptBYCEMSL
         zE8ItKxPVRgiMIXY+rXtNhpThFKqQ3bGOgxCodwuq6ey/IFPaTObkHO5aZTBt4xvTdRI
         kXZhX0SD0kuBp1FgrsUWecGE0tR3yQOwLuDhb5ubGhkxYbWCz41xxIBJLgnVWmceYGhx
         0G7eCstyt1rWZTWelKHQuIMzFdRG0XB7ToaHnuP2Wr6tFPcWN/LNeVu7kpibcBjbbMNW
         mGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713605382; x=1714210182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tL9SzqjKZJjSqoxD/K6mR5BweiSCQYf0x9/vIAfRvyQ=;
        b=n42Xlq6NmDN3ze2VPU6qNLc4Vgg5nTba2T+KI0ADzOsBJ7xtQAcUcqHgTRFD2S2sG9
         2HFPhsitFIawfXFcVuarKaVaR0EVqAxAvWlLXev2INaZVDhYf43L8fnKGzFyNEYxuI11
         qxoAPnlU6s9OhX3uWROf+XUtLKIjywG8QGmWj6XTkv13kYhwjLhTZ1qnR26xTv+UwBRW
         SIpi4zW1FtxC7msyPUDU15EPm8hnw2snjCrChGrgFQiCx7O4NhMBLysGlVhYPmkpVELX
         mOd9w7mfZ3gAJ5J1MGPcH2Q5+MbHUBPiTcjbfuYscixGpfcxnNWEjVOGFEbAoQ/CrYZy
         vgfg==
X-Gm-Message-State: AOJu0YzJ6xg88DrGRanQRZcx+W3JrdYqNIMUxidL3CRRLfApu6bcgqPX
	UhVFhfJjnqVkpwmM3O1qz7EgsL9r5rANW65i5DSFZ8hS+jpn7C4GZj877OV6pxSN2mcHMxr2KJz
	OuXLecGP7I/SUjgiUsIk7nI3DjDhIWnSnfbg=
X-Google-Smtp-Source: AGHT+IE5Mtob8iatsc068VQWMUB4mwOfOYbup1BPXTxQ0dC2+Qk9s/2+v5KMas4UOIboTDQXcY6k+iltlduFXt2kzs8=
X-Received: by 2002:a17:906:c290:b0:a52:1e53:febf with SMTP id
 r16-20020a170906c29000b00a521e53febfmr3074559ejz.69.1713605381944; Sat, 20
 Apr 2024 02:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMc2VtSNEb1yogTs1fy15xW94_UwqOUVoxaLS2eJ6mcpiaXOXA@mail.gmail.com>
 <DM6PR21MB148125DCBFA3AE71E35B8019CA0D2@DM6PR21MB1481.namprd21.prod.outlook.com>
In-Reply-To: <DM6PR21MB148125DCBFA3AE71E35B8019CA0D2@DM6PR21MB1481.namprd21.prod.outlook.com>
From: Francois <rigault.francois@gmail.com>
Date: Sat, 20 Apr 2024 11:29:30 +0200
Message-ID: <CAMc2VtQ0QRA_SEy92Fxmquys2q+CXzbHDv6euAL2GbawdkS4fw@mail.gmail.com>
Subject: Re: Nic flaps for 1 minute when reconnecting
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Apr 2024 at 20:15, Haiyang Zhang <haiyangz@microsoft.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Francois <rigault.francois@gmail.com>
> > Sent: Sunday, April 14, 2024 1:15 PM
> > To: linux-hyperv@vger.kernel.org
> > Subject: Nic flaps for 1 minute when reconnecting
> >

> > (Nic Connected) sent to Nic
> > 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> > 24/12/2023 09:39:33             220 Information      Status change
> > (Nic Connected) sent to Nic
> > 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49C4-...
> > 24/12/2023 09:39:33             220 Information      Status change
> > (Nic Disconnected) sent to Nic
> > 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> > 24/12/2023 09:39:33             220 Information      Status change
> > (Nic Disconnected) sent to Nic
> > 40DBAAF6-D408-452F-BC2E-B76AAF065732--B670C9DF-AB50-49...
> > Thanks!
> > Francois
>
> The 2 seconds delay is necessary for the upper layers, like link_watch
> infrastructure, and userspace to handle the status change properly.
>

Hi, thanks for your response!
I understand the need to split a "change" event into 2 separate events, I
don't really understand why there needs to be a 2 seconds delay between
each. Surely other network drivers do not artificially add that delay?

In my case a lot of events are received (instead of a single
disconnect/reconnect) and they are all tailed and processed sequentially,
in practice the VM is not usable for a minute or so. It happens "by
surprise", I have no idea what is causing this.

I don't think I have a way to dig into the way Windows or Hyper-V are sending
these events, so I am living with the patch to reduce the delay. What would
you think of first adding a log in this fashion

> --- a/drivers/net/hyperv/netvsc_drv.c   2024-04-20 08:48:09.105928816 +0200
> +++ b/drivers/net/hyperv/netvsc_drv.c   2024-04-20 08:57:28.254412513 +0200
> @@ -2080,6 +2080,10 @@
>         ndev_ctx->last_reconfig = jiffies;
>
>         spin_lock_irqsave(&ndev_ctx->lock, flags);
> +       size_t len = list_count_nodes(&ndev_ctx->reconfig_events);
> +       if (len > 5) {
> +               netdev_warn(net, "handle storm depth=%ld", len);
> +       }
>         if (!list_empty(&ndev_ctx->reconfig_events)) {
>                 event = list_first_entry(&ndev_ctx->reconfig_events,
>                                          struct netvsc_reconfig, list);

to inform the user that something is wrong and events are being stacked
unnecessarily? Hopefully someone will notice and more users would be able to
chime in and report.


>
> Thanks,
> - Haiyang
>

Thanks!
Francois

