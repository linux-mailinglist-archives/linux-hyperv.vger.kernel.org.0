Return-Path: <linux-hyperv+bounces-6316-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15699B0CEF9
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 03:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BB71AA44B7
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 01:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ED4189F5C;
	Tue, 22 Jul 2025 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M57LCq4M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7A13632B
	for <linux-hyperv@vger.kernel.org>; Tue, 22 Jul 2025 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753146279; cv=none; b=e6qF9bVfFXbZoQncxiIOOeABRKr/GUnLA7AeaqSDQ7jEcTUq51YmmJ14kOhd3hQ7j1UHGRYDXKnqllQlKgZ70qiZwONF1JDYCqm1nSk/hOyb3KECfLu0Sj7zJS0qal0DGJwYPcejhKvj+U9iVnYGYsX9Kkr/0kaNLTeZ9jAhq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753146279; c=relaxed/simple;
	bh=QSHfY6/I45E7VoqU71vjWN2GGh3FR7Hqm6Zx+uwE1oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3O5YpUYetEJP9ove1gNlcSZRUXKeLMzrlk8KFfPh5TLsl6+6qWvx/XutXn5Kcso7432fSGmqx2ScA287gR9E3W5kJYcwHQGTuFvdksobBwYq5byVoqiKPWKjBYe8N9jntoGdj9SvzwcvHmx9CiBVx69xyaFln5kXzt++mH1Nsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M57LCq4M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753146276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSHfY6/I45E7VoqU71vjWN2GGh3FR7Hqm6Zx+uwE1oU=;
	b=M57LCq4MwXc2EgJ8nK/SFl7B5zK8MASfeQRizlV+lgnk00qyAzt4FQMAW3YXADaiiQTVSx
	1n3g9K6QmQ6Eu/ZeT6SrMWfK2I4i4H6HDPDAkxSHDvRSFGIRUq3e9ACkD243hV6hNpps/Q
	oh5ySEtPc+YS2JNV2EEt5X5d1a502Ro=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-gNhzrLlPOtSWTfpvSvN7bQ-1; Mon, 21 Jul 2025 21:04:33 -0400
X-MC-Unique: gNhzrLlPOtSWTfpvSvN7bQ-1
X-Mimecast-MFC-AGG-ID: gNhzrLlPOtSWTfpvSvN7bQ_1753146272
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311d670ad35so4533990a91.3
        for <linux-hyperv@vger.kernel.org>; Mon, 21 Jul 2025 18:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753146272; x=1753751072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSHfY6/I45E7VoqU71vjWN2GGh3FR7Hqm6Zx+uwE1oU=;
        b=PeitR5V626bdo5pLrArwiEwGqMbIoTv5RBzY+bnUcEsa8QN6cW8uZQNzpAzOJoU2Fp
         3hd9J+C6qCTk5L4fHRHoYHcFiEI60Nyut5YO6ELvEyVu9mSU8A6HSHEeX014G5P84Z1B
         x/MdItJo+tuZjv1UGfL8Yj2tqjehdA4c43FyqtbG/3SizKyaLOySzy1OsLdRAq0HcyYG
         DNlMGICfuiywz3cyOueFUsKHnXs0ywAXY+obZMTgqMXgmMCrXrfcPlcI3/mKpe0GcKLG
         NaIvpz6Fw4zM+mkWXoS9MlimuD6V/q3bx62xKcTs+XXQWoHwSw0hibyBQNRy9loPlJcm
         YNzg==
X-Forwarded-Encrypted: i=1; AJvYcCWJQjAU07UfOTywgv/YuRoawdZ5b9ZSgsbes0wAgvSLTlp8vQqU+7Ep2Zww2ms/dsYqQuNEPPwroCp+dVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTO8kbmjCvDOvIq+KA0hfCRAl9XKOwZZihJVLKYmY9d+A437Sc
	2ySuuJJJi7hKkcY7iP4gnePO0P+3pgAgzbFFYI6IuquY349xerlh2vgNITyiWya4tkGZgoTRgBj
	1+JHdpt5yfMTXhQtpWKNq2vfl8Mx5VCQXkbwCF3YKemLwE0yzYBl0FbggfyOi3xSTyIpwsNSwS+
	mrSUiPhucgzXpVrHnMRRrgKepO70z3AB7uASeErXDK
X-Gm-Gg: ASbGncvYuUIuz0/jBmVAwUGo7GgiIbYWnMfc59qG/0F5L+8rqa7AlaWlT7c7O87/FJ8
	pzcXlZ99G/ZRaOz+GvA9pcSwh0ItXrTFYPqHb39kgi5yFxzxYFvsGgge6CciLUp5mE5yHBrZ1Cy
	pUZSwDjUe4GW1bTdIMg9po
X-Received: by 2002:a17:90b:3fc4:b0:311:c1ec:7cfb with SMTP id 98e67ed59e1d1-31c9f4c33d3mr30854050a91.21.1753146272140;
        Mon, 21 Jul 2025 18:04:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHbGV5ZoUz9R/WO/NmCH4wsvyzuXu8KWNfORxHSTj8M2vI5FKY2tXFlD0N7kPl5yOe5oFtODb2u9iLGbeS7Yc=
X-Received: by 2002:a17:90b:3fc4:b0:311:c1ec:7cfb with SMTP id
 98e67ed59e1d1-31c9f4c33d3mr30854021a91.21.1753146271717; Mon, 21 Jul 2025
 18:04:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718061812.238412-1-lulu@redhat.com> <20250721162834.484d352a@kernel.org>
In-Reply-To: <20250721162834.484d352a@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Jul 2025 09:04:20 +0800
X-Gm-Features: Ac12FXz7bcSA4tc5LblLvTxBTyr6TPXP7yPwK31t1GMBpJ5P5WuM1Cl6XkRbI94
Message-ID: <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
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

On Tue, Jul 22, 2025 at 7:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 18 Jul 2025 14:17:55 +0800 Cindy Lu wrote:
> > Subject: [PATCH RESEND] netvsc: transfer lower device max tso size
>
> You say RESEND but I don't see a link to previous posting anywhere.
>
> I'd rather we didn't extend the magic behavior of hyperv/netvsc any
> further.

Are you referring to the netdev coupling model of the VF acceleration?

> We have enough problems with it.
>

But this fixes a real problem, otherwise nested VM performance will be
broken due to the GSO software segmentation.

Thanks


