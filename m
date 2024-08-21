Return-Path: <linux-hyperv+bounces-2787-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1B959401
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Aug 2024 07:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ABDF1F22C41
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Aug 2024 05:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD94A168493;
	Wed, 21 Aug 2024 05:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fclwXrrC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9DE165F12
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Aug 2024 05:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217867; cv=none; b=tDWFoO1A7HdZs1lvoij7eEj1iBnRiHFSKUnRwc/K83431/li2/hA7k7pzdxvAWWglxw8jI93u0g2SF5Qx/gcI/FxPELYCLkwFs3MhzcXZyFf5fWQjbBcL2TlggGGnmJAUgR1JOORXACb57NYJXtD0gz2LJi+msKFDn0CmXqkQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217867; c=relaxed/simple;
	bh=+c9ry0gIKwo4UXh5zsTLVRtv/dS4wCh2ZSvVpVlgmGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmfpybvBEBQI29TZNupM3PhDl4iobJLC+6ayq6dAANZHSvb+li7StdrTfewQqgoEGv6sqZ29JReumrFGEejA53aPH4Dle1ITubDXQPdhLvO/FeRuRFQ1HNqJahfRgkKdZMGNiLc9XNyGGe9qzSpzRJxUb0DuMZEpyUot4vHuJp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fclwXrrC; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fee2bfd28so153411cf.1
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Aug 2024 22:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724217864; x=1724822664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+c9ry0gIKwo4UXh5zsTLVRtv/dS4wCh2ZSvVpVlgmGA=;
        b=fclwXrrCUbNostfgCMd1La3shPRVOZWX7NBGQo4UHZzjMXPcrSpNKULQ9MImg5XYFZ
         CUegKrg1Fyl7CyJRn/1/tvPw1wlrt+bGmLJHhcMcUUJsGIa8Zb0jsdfkPrzBVQU8OHQm
         8dIMv+2iaxJeeFcP+n2mDKiRM3dkeyalcHar9RC9H8LQ0bWAw/onpJFqpKriGZ01a/1t
         M9b5rA96B74LZiM2zdhf5YwWort6xA2xcpXOx0Bi82d5wU2qSbpIsuQN21WeeNkEXlH4
         LxpudhD6SeYCDorLcudcwf16ua7KSTQhRL/9f9SCln4QOAenhivCtyYt5MlCr6MqTKM3
         F+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724217864; x=1724822664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+c9ry0gIKwo4UXh5zsTLVRtv/dS4wCh2ZSvVpVlgmGA=;
        b=T+r4dksBV3oolnCaYD1PlqDSxOpUK3poJ7J6+EVT5em8o6+9u5l7trcyR/4lEsDgGM
         ooGVOteX5X1HoHjUAbScwXuvvfZotQ1Pz4hvMgbcda24L7YhbJbLFyyVEkRhp32myepR
         +6m1lS6AGuyjKevPuWtA8aaF3aaBwctOXZggg8R+SH9zbvfTqfqCRn/uXCSb6cAr9oWt
         M4fKfzKoiZbNNS1q8Dr0cj8TP3rYGd6TzgMzRxNlUF+kKj5/O+c910gncTSiQsQWdrdF
         RaAlsnV0dsQUfMPhN1Oh7Ui8zI31Zwn2C5nTWHIxp/K2NfJb591Ut2cyZMRf6ouSwj+z
         Lzeg==
X-Forwarded-Encrypted: i=1; AJvYcCWsZAkH6MbPBPjdPgiXaBttJYETKmuw2MSt5kNqagfh8gS7HNrlS89vtuKxsF65NPFeSzIAEZLQPHKSYxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNywMCCpcqR98/VLGR6OFcqS08mUHX8qN2M/i/7/+u1g0+VCnW
	iaF0fTCIkKxFHcZPu5exC8Q1fE95TfLjJv9Ko5ZPin4jk4wktQh+jRBjvkPpVngv5d8Ytkpsmzu
	+/HfuW91HV7ClTY/spUTpJS9jHZCGCvJyRm/7
X-Google-Smtp-Source: AGHT+IF73BCpn5UEcqFM/BhSSvMcfe9RO5QJr6iMJ/RDZUzv06kFzVkx6JeX8ZkAINLWgUfT5JTOhJyg6PRKU3OeCEQ=
X-Received: by 2002:a05:622a:452:b0:444:dc9a:8e95 with SMTP id
 d75a77b69052e-454e86dd4c8mr4839811cf.15.1724217863923; Tue, 20 Aug 2024
 22:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821045629.2856641-1-almasrymina@google.com>
In-Reply-To: <20240821045629.2856641-1-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 Aug 2024 01:24:12 -0400
Message-ID: <CAHS8izMyAxw8DyG11b6h17ghU6Xa-be-C7tDOvGCjkCJ1bZDKw@mail.gmail.com>
Subject: Re: [PATCH net-next v21] net: refactor ->ndo_bpf calls into dev_xdp_propagate
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 12:56=E2=80=AFAM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> When net devices propagate xdp configurations to slave devices, or when
> core propagates xdp configuration to a device, we will need to perform
> a memory provider check to ensure we're not binding xdp to a device
> using unreadable netmem.
>
> Currently ->ndo_bpf calls are all over the place. Adding checks to all
> these places would not be ideal.
>
> Refactor all the ->ndo_bpf calls into one place where we can add this
> check in the future.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Sorry the patch title should just be:

[PATCH net-next v1] net: refactor ->ndo_bpf calls into dev_xdp_propagate

v1, not v21.

