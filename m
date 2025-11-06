Return-Path: <linux-hyperv+bounces-7425-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259E7C3B2D1
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 14:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D011882E50
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED8532D0ED;
	Thu,  6 Nov 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgV11jk8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D200830EF6C
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Nov 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435051; cv=none; b=s6t9DQYhOr4ZTz6bhHNei4owXBlPqWbi4SltiArxOmb93l16OLpXLdIknePDSAZQyZXf4WPt+arpX9Z5QaKLQ8ZWSUY7IAAYaRmbCP8xclFryxmPjPW3/jPcP5ao9HRP/Ym+/Zp5uRIaJifPUCnH5G0gotGhy4+/hnDbgZ9bOcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435051; c=relaxed/simple;
	bh=8xyayUNeX27WinogYM/STcDgXHhgPSZqFVuRAY979CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPqCAm/u66SXANK2Z8zHJ3+x57FiFPYu0HObFc9YRGJc8q0vqW2dhL/xYFnTN0DTFvfb7uqn4VeNvtQC/GyiS+07x6kWeH/fM9ksaIEnJuESIiJxk9d0tvRhs0IsxLR11+T2faUWYGfXkcQrVZvWnSi+jLnzoiT+aiyI6vtltxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgV11jk8; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ecfc3f4a13so4177621cf.1
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Nov 2025 05:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762435049; x=1763039849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yKqqA00jwTc/irIUDNF5NewMs+/9jewFrwR1l5Pykk=;
        b=bgV11jk8QoNsIbL82roahyKlhtYwGQ3Qcrzog2usjpeA6WcdA6jXVATLPLyqHdWXng
         MYymRswIReG/mABBRLgtxA9mJUzY3au35c3b5N8gc/a+/JvXHK6Or0L8Cdlo8TB2+HRI
         2GzOQP4qirU80Vwvo9hVkdkL2YcRsqanDkikuv9z7XRBCsurV54xzIDmcfSbT3FMW2F4
         i3qP/WHPFQNrEmESWGMos6UVDEEpOkZLyp++MeHWM1EIRg+YhO2ZJd0kbWLRLJXt7wkU
         GXbFUymwBz1bFNySGLzXI64qktUf+r6fNr6dbRHSJXZWuYWNWeY6IkpEvt/Rw2nN1l5j
         VTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435049; x=1763039849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yKqqA00jwTc/irIUDNF5NewMs+/9jewFrwR1l5Pykk=;
        b=hNTfIU0eklToY/DwdOZLRPBmj3OJUXNrqiqOiCt4qSxM5cmPgRv0jd8eOGLFzm8RY0
         SUVRraGiXvR6QTwZ7xM8DdkWaLMSI7+2GQ1UOQ62UC/bUyfnhWyaRg8PRyKue3FyQEEV
         Vc/HWW5pqhVQw3oll4P3lPAALY5dlWYerzJZ+Tmez53kK+QPNd2NEQXLgb16ag0zCrQC
         PQUTUb7KDiT14JGdEfDqEStND6kGHDgwtdW38hyaomvIU3JsIXdVHlHJg8eqkkGaz7op
         ty1x29Vsd1sUw50Dh/x5ZXsvvLizquEHABX/eOJjVR7JeqYIbPW0pxGaDXtXw/WGhSsc
         0+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGZcrFP6xWWAa4KCs9uvBazRIQLQeErvgWFFESMnz13bQ7yQJTb4s+/2JZUmeSGExwL6Ky3OpfK1okDXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/NPvBSvZGPLsnOuBMkYTP7LXJ1OjrSE+ex6wkXKCFd9d4/YWv
	on+JhZOl2CDHlzan4zW2Y7i5Oy2eXxsT+M9scsv8589rMIJSHcqy6daJXypK27jeuh+1x7X1I7Q
	7mCgKkOiuY9Y16AUVi5X5dnNbpsaqwMQyepdns5X9
X-Gm-Gg: ASbGncs9IcacBMy6T7V1k57dFsJtyC6Hn2AjY5RR2duj1OzIY2jvW79/DXiOLG478ek
	cr+eUtP2fgAIOKDDDoAPL7Rq4iY/KMAd04XfN3DSWQs0dtdD3lj3b0sweoKXdQh9nYSV+TunY+6
	RForppsVngS6gaxDUPNKcz/pgp9rikoiGk8dRFKano52SSIIN1Nao8qTu9p/p8H6MYrnCYgnupU
	QEjM+0lDeATQHT2gs+VXDeH30BZeW1rJo4uLHcjepLoq4MDnnFjToQ2i42xjKvbCf4l4XE0jNhK
	+5rIpw==
X-Google-Smtp-Source: AGHT+IHoVZY32WaUUPLhhY4TIgToxdwsHfeGByBPVatw4n/WThQoOgUxSF+0rV1ygA7KDRf83XJehc/SzmchYE2halI=
X-Received: by 2002:a05:622a:4a09:b0:4ed:5ed:2527 with SMTP id
 d75a77b69052e-4ed72330515mr88050901cf.3.1762435048365; Thu, 06 Nov 2025
 05:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029131235.GA3903@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20251031162611.2a981fdf@kernel.org> <82bcd959-571e-42ce-b341-cbfa19f9f86d@linux.microsoft.com>
 <20251105161754.4b9a1363@kernel.org> <bb692420-25f9-4d6e-a68b-dd83c8f4be10@linux.microsoft.com>
In-Reply-To: <bb692420-25f9-4d6e-a68b-dd83c8f4be10@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Nov 2025 05:17:17 -0800
X-Gm-Features: AWmQ_bkBBaZsd-rIT26BTjS7cW1vwvaDIkKAjz7m89rgLrJMPIY3CSG-aBEvnJU
Message-ID: <CANn89iJ8QKbwFfLUExJvB1SJCu7rVCw_drD3f=rOU84FNvaPZg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com, 
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	gargaditya@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:01=E2=80=AFAM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> On 06-11-2025 05:47, Jakub Kicinski wrote:
> > On Wed, 5 Nov 2025 22:10:23 +0530 Aditya Garg wrote:
> >>>>            if (err) {
> >>>>                    (void)skb_dequeue_tail(&txq->pending_skbs);
> >>>> +          mana_unmap_skb(skb, apc);
> >>>>                    netdev_warn(ndev, "Failed to post TX OOB: %d\n", =
err);
> >>>
> >>> You have a print right here and in the callee. This condition must
> >>> (almost) never happen in practice. It's likely fine to just drop
> >>> the packet.
> >>
> >> The logs placed in callee doesn't covers all the failure scenarios,
> >> hence I feel to have this log here with proper status. Maybe I can
> >> remove the log in the callee?
> >
> > I think my point was that since there are logs (per packet!) when the
> > condition is hit -- if it did in fact hit with any noticeable frequency
> > your users would have complained. So handling the condition gracefully
> > and returning BUSY is likely just unnecessary complexity in practice.
> >
>
> In this, we are returning tx_busy when the error reason is -ENOSPC, for
> all other errors, skb is dropped.
> Is it okay requeue only for -ENOSPC cases or should we drop the skb?

I would avoid NETDEV_TX_BUSY like the plague.
Most drivers get it wrong (including mana)
Documentation/networking/driver.rst

Please drop the packet.

>
> > The logs themselves I don't care all that much about. Sure, having two
> > lines for one error is a bit unclean.
> >
> >>> Either way -- this should be a separate patch.
> >>>
> >> Are you suggesting a separate patch altogether or two patch in the sam=
e
> >> series?
> >
> > The changes feel related enough to make them a series, but either way
> > is fine.
>
> Regards,
> Aditya
>

