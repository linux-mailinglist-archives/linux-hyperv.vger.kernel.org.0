Return-Path: <linux-hyperv+bounces-7701-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CB3C6F4DE
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 15:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 722C54FA1B5
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE6D2727EE;
	Wed, 19 Nov 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPeo0Jqp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0BD274B27
	for <linux-hyperv@vger.kernel.org>; Wed, 19 Nov 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562226; cv=none; b=aOX3onBNbz/rf/0KHoJfk7q5sUZaw2H0CIQqHlgkxdJ9NOHegF9JYKsYH49K0zunZSONfp5oaBFySEuLUqw74wKUTfNqgTfwkJz12dqtMtj5yyOM/AJTJh6NlbPoFFblfz7qBgozaV72e6GahTUwCIDfD6rQwqe6zFlAr1wb13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562226; c=relaxed/simple;
	bh=feLpsTcRooeBUDh1NuZrtx4BR5eXJUHXIjFRyYBOBVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpgWPM3j2G9fC+Ll7dya2rLv7MCrB5wuMwqalG+0NSGqvHAugMWu7Yrmob2h/ZdcL1r2U4LmJfBjPIxnOoAv6kZrvQonkdMetvhK9ANDIXeV6u6sp+fZ81wDjupiJAGn9lO+gSGqewxWGS6R9E9uYvrhC7tbDvu1b5GjoFLKYTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPeo0Jqp; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-640d43060d2so6314009d50.2
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Nov 2025 06:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763562222; x=1764167022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=feLpsTcRooeBUDh1NuZrtx4BR5eXJUHXIjFRyYBOBVE=;
        b=GPeo0JqptvMsc0yhUlPFO6CYVQsM3mp6jIDIpUEoIY39y4LECUJ6RHGSSAoS9piBGj
         RMPRCr2NZa7rMp6EyK3iEuWuJMKezjDOblElgaEwzabMj3U+LvU0Tnj0tcP7JCNPQth9
         8LLqlB7PySSlN2x3tcvrIZiSZnfOV9yr4VJ4e2WeaVNbVOdnSw50HUxhEA9986I8qNoi
         DPKKvILCu28f8B/zKwjuU2uJNfZCJDbE7Bx4Zgul2hN78d5aeu6hREjRWyvAoSiSYT63
         bZAUpMywFo0WMqzj6Yf5KcawW8sMiERXPT3HxSDqsy3lXPtCt4wsNAXrjllZ2JAF6OgX
         oyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562222; x=1764167022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feLpsTcRooeBUDh1NuZrtx4BR5eXJUHXIjFRyYBOBVE=;
        b=bh8VvH3kf+EkbBxhSPTNc0nUQukgsjExvlO7cOvnsva5JzGxK2WN95OvuSX8/Ml754
         AY/KnpR4l46SI4AGyXjxUynHFI9K5zsT9adIFcB8UGXhACekgxuoHGa++Luh3YgU+V8z
         S5/sdSAplIVwqq+I2zxWqTURN+MTts57aDePkoJINmDW2RgiwvtT1yXsnfBZseKYcF4g
         CZ1773HeKHOAwpCW2dWocaco1JGwgDLM/hH5MOxn9puet6mLEmiKebKXPoZTtfZ+F5lt
         0kf9hQXjEfhJHOlw9KYevNvwXFTs++k6Rj9eAaeY+8DKGTUkHyWwj3L8WWzuuh0ddIUQ
         iCdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWFIJO0e0gBotenljZc3A1ng/z8QIL2iuH91N5CuCPUW8A8GKtg14jFLAwxh1h+h/gz/nZpnEH3TH1QUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJdA+tm+EMJ5nTJxLRkk/uiVAwu4bYYd88SsQHQuHEWar+NvY
	bIeYWbJCLfLsDgUGXtxQI5bMh0kisv0NSJpT8wcurMzhYTVawMS+4/Ut43OVibZGDXwCbZD0ugL
	CUiRfeaig3MXaIsUyMMPoClTRlzyhnnA=
X-Gm-Gg: ASbGnctMxP4TkxmuUXVen5m7oBYbQvpr9Ye2PEKnQwYUdmsXG8IJL1+vdrCAfnvytUT
	ZL3hwj+7AFTKoJL7XUq5CLSDjrIqYZMmwS+SZn2QEJcwrxwD5Os+m9kuLzoYO90Os4mG8DZvVjG
	KSpSsO4CSi9p0fxABp+F1W2+RXVcjSVRmzJ9edv+z5fNPN68FBaiZSIew++YVmK7Bm1ok7w86Rg
	z7dHT/KKoKEubkiEJP9VJ/ri/ANamMKZyycKfJ6m3NARJJfETR+A/xYKtUv76sQZNYdePrDFTYQ
	6dpoPmxfNKpunUP/+wVXLhxznyz7qTFg5HJdS4bHIfQFQMJJ6K2zRvR8sTLF
X-Google-Smtp-Source: AGHT+IF5NwixCJp2T74Yk+VGJOFT70YL4ipTdPK29oJUWRmhQ16csu9lLdxNgu9JhRR5iqSvFNtCD4jkp5Voqb6nMwk=
X-Received: by 2002:a05:690e:4086:b0:63f:b366:98e3 with SMTP id
 956f58d0204a3-642ed11f6efmr2195929d50.23.1763562222141; Wed, 19 Nov 2025
 06:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115085730.2197-1-namjain@linux.microsoft.com> <dca120db-4751-4de8-961e-05ba701ca100@linux.microsoft.com>
In-Reply-To: <dca120db-4751-4de8-961e-05ba701ca100@linux.microsoft.com>
From: Peter Morrow <pdmorrow@gmail.com>
Date: Wed, 19 Nov 2025 14:23:31 +0000
X-Gm-Features: AWmQ_bkiYDQ6u5hyLwq5pIsZUbEmRyAM2-OA75PYb-RUfW-RBak2JgjGmjqppv8
Message-ID: <CAFcZKTxFB_iztzAK_Ljy5sU48qCTUs+FPD1aXUyz3qt7ug8DhA@mail.gmail.com>
Subject: Re: [PATCH 6.12] uio_hv_generic: Set event for all channels on the device
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, 
	Long Li <longli@microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Tianyu Lan <tiala@microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Salvatore Bonaccorso <carnil@debian.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Nov 2025 at 09:02, Naman Jain <namjain@linux.microsoft.com> wrote:
>
>
>
> On 11/15/2025 2:27 PM, Naman Jain wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > Hyper-V may offer a non latency sensitive device with subchannels without
> > monitor bit enabled. The decision is entirely on the Hyper-V host not
> > configurable within guest.
> >
> > When a device has subchannels, also signal events for the subchannel
> > if its monitor bit is disabled.
> >
> > This patch also removes the memory barrier when monitor bit is enabled
> > as it is not necessary. The memory barrier is only needed between
> > setting up interrupt mask and calling vmbus_set_event() when monitor
> > bit is disabled.
> >
> > This is a backport of the upstream commit
> > d062463edf17 ("uio_hv_generic: Set event for all channels on the device")
> > with minor modifications to resolve merge conflicts.
> > Original change was not a fix, but it needs to be backported to fix a
> > NULL pointer crash resulting from missing interrupt mask setting.
> >
> > Commit 37bd91f22794 ("uio_hv_generic: Let userspace take care of interrupt mask")
> > removed the default setting of interrupt_mask for channels (including
> > subchannels) in the uio_hv_generic driver, as it relies on the user space
> > to take care of managing it. This approach works fine when user space
> > can control this setting using the irqcontrol interface provided for uio
> > devices. Support for setting the interrupt mask through this interface for
> > subchannels came only after commit d062463edf17 ("uio_hv_generic: Set event
> > for all channels on the device"). On older kernels, this change is not
> > present. With uio_hv_generic no longer setting the interrupt_mask, and
> > userspace not having the capability to set it, it remains unset,
> > and interrupts can come for the subchannels, which can result in a crash
> > in hv_uio_channel_cb. Backport the change to older kernels, where this
> > change was not present, to allow userspace to set the interrupt mask
> > properly for subchannels. Additionally, this patch also adds certain
> > checks for primary vs subchannels in the hv_uio_channel_cb, which can
> > gracefully handle these two cases and prevent the NULL pointer crashes.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Fixes: 37bd91f22794 ("uio_hv_generic: Let userspace take care of interrupt mask")
>
> Sorry for missing this, please add Closes tag, if possible before merging.
>
> Closes: https://bugs.debian.org/1120602
>
> I have kept it in the other patch for 6.6 and prior kernels.
>
> Regards,
> Naman
>
> > Cc: <stable@vger.kernel.org> # 6.12.x
> > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > ---
>
> Regards,
> Naman

Tested-by: Peter Morrow <pdmorrow@gmail.com>

