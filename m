Return-Path: <linux-hyperv+bounces-6448-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502DAB169DB
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Jul 2025 03:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD51F7B6147
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Jul 2025 01:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F70313AA3E;
	Thu, 31 Jul 2025 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gS166KaG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8FC136352
	for <linux-hyperv@vger.kernel.org>; Thu, 31 Jul 2025 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924065; cv=none; b=F1qk75771MjVgV+rJeIdektr8oKriUYps5YnXu4W/5gPVdG+9mb9M6xBq6EwsuT2RplWAh2vrKFGxoLqVmXsMlK1MUmReHflfqViRK6g45YLKV5+Q1I3iu5iSKiUr92iT/0sFua8hr6axU4gNAcVQVnWzwVUr3oqqNaEtuCRhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924065; c=relaxed/simple;
	bh=RwCqBhqd4SGtljt8ozavaYhxd2dZWBQTZl0x74OfiRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teykxFGofpaI48DcuXlVuLG7ZSaYxwuhMLU7VtIfFWwD0mLmE/0dhrAJmGAAflyKeFoI0e6GbxSNAYA1BDSn0Fac3wR5pP33O5fFw8WZX1M+e5WhvRkxsBbYtt8gB1uU7Zoz36xQ7F+aZszM1pwFu7/sd4hSvg68xJQvaQaaWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gS166KaG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753924062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwCqBhqd4SGtljt8ozavaYhxd2dZWBQTZl0x74OfiRg=;
	b=gS166KaGpyyu5CZBt6Ly4KJUGXrppjmkRCIL+50O5O06A1mz1lNpdv9B4fOg5CPfzHSHJm
	/OrCAyH2lmbh4K5Wa5wtNDRxiKGd6v1ICJRWuIPk07UnpEdMQsLpZQpwOGflzZK/evOTEa
	ppJkkLAFLj2pjb0/uGwNmyzDWU2p2dE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-g7C7zpOFN464AxkD25RHzw-1; Wed, 30 Jul 2025 21:07:40 -0400
X-MC-Unique: g7C7zpOFN464AxkD25RHzw-1
X-Mimecast-MFC-AGG-ID: g7C7zpOFN464AxkD25RHzw_1753924060
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so431340a91.2
        for <linux-hyperv@vger.kernel.org>; Wed, 30 Jul 2025 18:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753924060; x=1754528860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwCqBhqd4SGtljt8ozavaYhxd2dZWBQTZl0x74OfiRg=;
        b=KgG0Cb/Eo/Fj+eybA0WsWA5WeHPqVYW0bq77po+TTDLc8Nx+Wqixe4XIb3QI4Lr1AR
         qk2QIMdvM8yJDY1X4h+oW2LB8YGWa/ctQPjo6bTr3zCda3Ivg4MlEpCWWItEnigYwIkU
         mrSm/ob0tn3MRZ9+CWMjOOp9+4gh323KvBZpFjvm8vzkpVdRtaM1FlVMY5v4b7+2MWcO
         wslw/cDjX0DeOh+CnUr3MrV+gQ1q0DiiLV2NZSGA35ybk/7I1YI2rmXLJz832m4tNU9S
         PpItDfsQRDYTVi7uthVyWNNtKU4EbewnmE1GRlrgeQ0G9ybcpBKnRi0BHvscBDspGnsH
         W8pw==
X-Forwarded-Encrypted: i=1; AJvYcCWge4T3NS8DqGNHahzLNs+n5esszp1c/Lehnoh/ByvGNb4ap71wA7+H/V8MW96L7rhTT+5JphjviugDZT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNNW3uQRiqyOBJ+TGNJuDOPqZ45FVPqA/7jAI/U6qENso52lbi
	mkvCeoSzWwofpUSaFdyjnelMXvUSgzBlgpF5S7NsSBLdNBwqGA62w7Yj1M4ZFJ0EVWbjswinOxT
	EqCZiYbPuNcWUjgL/iJed+M0xBBd8Zy59KDm+9GHMyJe3DyVwi4vInq2h4yL9paxSFjCy5Hczkc
	zkJ39qDviB9JYXW9e1xqLk5911x51KEsS5abOGOSx7
X-Gm-Gg: ASbGncvLeZQxvv6Zv6UKj/5As7/vtz7av+sLMpPC3y4bYvau8MB+UndKhOCE+qEUg+T
	0gKdO8dQfF+QyLa6HG+wamjtlUgdfn37uDfa29q0Y6r0lylK3kjsrL3OJBV/MevTzb5W/B43rf9
	B4GhpopFmMbFvIR7WAc4E=
X-Received: by 2002:a17:90b:4b11:b0:313:5d2f:54f8 with SMTP id 98e67ed59e1d1-31f5ea6b571mr8104418a91.33.1753924059807;
        Wed, 30 Jul 2025 18:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBTkvTlCrxS4KqWqX9J2caauKKosURWKkzL9ddM8eH3KW10NDC7rPZNwPk748PPfO7GuO55un+fWqFpNss2fo=
X-Received: by 2002:a17:90b:4b11:b0:313:5d2f:54f8 with SMTP id
 98e67ed59e1d1-31f5ea6b571mr8104373a91.33.1753924059373; Wed, 30 Jul 2025
 18:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718061812.238412-1-lulu@redhat.com> <20250721162834.484d352a@kernel.org>
 <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
 <20250721181807.752af6a4@kernel.org> <CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
 <20250723080532.53ecc4f1@kernel.org>
In-Reply-To: <20250723080532.53ecc4f1@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 31 Jul 2025 09:07:27 +0800
X-Gm-Features: Ac12FXyltfKnkJ6WA6PQZrqMC6on4IVMKH4G4mZZ6ShVaStyC948R-LQlIsa18c
Message-ID: <CACGkMEuvBU+ke7Pu1yGyhkzpr_hjSEJTq+PcV1jbZWcBFm-k1w@mail.gmail.com>
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

Hi Jakub,

On Wed, Jul 23, 2025 at 11:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 23 Jul 2025 14:00:47 +0800 Jason Wang wrote:
> > > > But this fixes a real problem, otherwise nested VM performance will=
 be
> > > > broken due to the GSO software segmentation.
> > >
> > > Perhaps, possibly, a migration plan can be devised, away from the
> > > netvsc model, so we don't have to deal with nuggets of joy like:
> > > https://lore.kernel.org/all/1752870014-28909-1-git-send-email-haiyang=
z@linux.microsoft.com/
> >
> > Btw, if I understand this correctly. This is for future development so
> > it's not a blocker for this patch?
>
> Not a blocker, I'm just giving an example of the netvsc auto-weirdness
> being a source of tech debt and bugs. Commit d7501e076d859d is another
> recent one off the top of my head. IIUC systemd-networkd is broadly
> deployed now. It'd be great if there was some migration plan for moving
> this sort of VM auto-bonding to user space (with the use of the common
> bonding driver, not each hypervisor rolling its own).
>

Please let me know if you want to merge this patch or not. If not, how
to proceed.

Thanks


