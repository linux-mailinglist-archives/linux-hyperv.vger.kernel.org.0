Return-Path: <linux-hyperv+bounces-6680-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A93B3D4A8
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Aug 2025 19:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A2417243E
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Aug 2025 17:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC4F270EDE;
	Sun, 31 Aug 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e13PmDaX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00D25C6FF;
	Sun, 31 Aug 2025 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756663015; cv=none; b=Xhb++OGS/6koeIXAA08aUI+tTbG1tTsusbwLDYPbWs0dS+YVi518HzxFXQaae7QDB1n/yQ4xCYFrSA46GAPf/nqGv7iNSryjzoLD0i/X/2hyzsRP3X1qp+E1PGCz5CWEubht/oY4pm3xuQUxFTkXknBcXDu3mbd7ZtfSCarRA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756663015; c=relaxed/simple;
	bh=PJSyMJv1xgc46w3wntfD9Ts3XvSSk2tDfUPm6dv19Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We54TWatc8F8VJRGhHMRPIyYqDhEfAjd9NKUpAa1SVB+QhErb9bOe02ZTYElBWGREjZDQuoiqJlIqj6/zLaMJfxDe06FLrVGkKjJJhiQchfcyiLWQrkCSBkSLonXkP8oP6xoE0zksHdLH2WPqT37T3HxHMyn0q6jUq4SWqKhDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e13PmDaX; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-771f90a45easo2962745b3a.1;
        Sun, 31 Aug 2025 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756663013; x=1757267813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJSyMJv1xgc46w3wntfD9Ts3XvSSk2tDfUPm6dv19Io=;
        b=e13PmDaXpN0/3j3ekpB4qqJJEUxE3HSZAWQ34wQIsr9L2cu/Zy2B96OuvYT/5CEsqk
         KZe36LEY6ZXQhojYJDcR7gNBDZN/E0Vqu/ugubInZH+JefNAyLvBLlTx/a41n+2lObx/
         FloopoO7YdvH0azMZAkIZqmosykefGuhcwpgkAXnVTvcnkyBxhm6U+KviYG89IGB63UG
         oHBr4uvrTgYUo+t1t+xiiKNpnW9a3QTBfUKTq9iNLdzKUJDZc0oCP2iPByKX7xc1Nyh8
         fmP6TrRh+bdAofmnXwWC84Dml3zpiAdU2cuQsZzs7P8IsR3NLiAchdhlXdxzez3xWtVM
         aMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756663013; x=1757267813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJSyMJv1xgc46w3wntfD9Ts3XvSSk2tDfUPm6dv19Io=;
        b=VVVjF5aksLm9ieEo+mxn9Xr9PE1syP3lgpkLtKFAxfzEytG0bswfgv/IoXZATro11E
         0yJkLiK7KwVxYoCTsnGQroc3Rof+fhn25vyMxlbZpOwaQZnnkH3fMir/tg68kvSBGUB7
         t3KBlfJrfHMueHhVmnP8Se2hQD7L0kJxp2B6aNc+enKLC6QUERr7aGTlnPjN+m+Fh9ST
         H/j/yaYVTY9WA9TcJVcggLMNyna3T3eW+M8gVm7bDP2dtnbIlG3494ksHJ8ykRlF7Oey
         V19ZL63H5tg0911uc9oE7kxK9eSIiIu6Vor5z5+CLvFRkHtu++TsXGwUtM3N84v3E79Q
         MGjg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Q3vZK2yinPB815pmqJr9GXZHn9dxH94aR3SOD9JZPlQfoEcCUbnnvrZ+RXtEJEM0Vdjp7vRlM/ijUJw=@vger.kernel.org, AJvYcCWqMcojKFND50eHG9SOpwxpWO29uxl38V8FXQ1K2nVxOzV7zM2mPmH8Oak/QEl3e0E7VWgOJfXjmTrWCPsr@vger.kernel.org
X-Gm-Message-State: AOJu0YxUqPYrO4Y4QN73pgJQ3IHtQVHZfuyR98r/YbVrm47A8kwunDfz
	ZA8QyEbRgHlMYdRyvtphriiUW2k8jMGX1XV8KcpI5f9bEw6XfxwGNYjBxZHvrFURdkgArW6pB6c
	4ODmA5rh/3HbWfTkOCC63dD2sS4u8rxe+yeK2kEM=
X-Gm-Gg: ASbGnctwNVWqfxa9PNc5WWyUeY0h7GI9slm6b8Wsn1LXL3LTEC5a0VJxd5GeWCzomS5
	XoO09tlGN2KrqUGjGrJZ+FvTMhDpO0bkFxL/VnCtbFPcP50FVQDj3ExK5+SpYveJi0bVTOgDlib
	7yPUR9fNNzeG7kUrFMD8Kq8R2egcNQ8WW3bkgeOFk+1y6hbJT0H+UufWymCG56fJbkMH90NPNbW
	YhTx3/qxLlZhMZfrq8=
X-Google-Smtp-Source: AGHT+IFTV/D85erxDkhWS7awOswBVR9VjIGdJejDA0NVeSq0CUugTNkHM+oTT5E67MM+d3QFHMf/2yvvmUs5oMtxemM=
X-Received: by 2002:a05:6a20:3d8a:b0:243:c336:7ba7 with SMTP id
 adf61e73a8af0-243d6e00a61mr7061756637.19.1756663013442; Sun, 31 Aug 2025
 10:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831160406.958974-1-mhklinux@outlook.com>
In-Reply-To: <20250831160406.958974-1-mhklinux@outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Mon, 1 Sep 2025 01:56:17 +0800
X-Gm-Features: Ac12FXys1M8deZa2AQskrWA37OiJRwtk_7dDMChQtX3mmzVtDs9jOAaXZzyaq4M
Message-ID: <CAMvTesBGma=mXDvY=3aqp0k3A3LQt1y7gnMLrD4CqJ1WW1dPSA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Drivers: hv: Simplify data structures for VMBus
 channel close message
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	kys@microsoft.com, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	gustavoars@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 12:06=E2=80=AFAM <mhkelley58@gmail.com> wrote:
>
> From: Michael Kelley <mhklinux@outlook.com>
>
> struct vmbus_close_msg is used for sending the VMBus channel close
> message. It contains a struct vmbus_channel_msginfo, which has a
> flex array member at the end. The latter's presence in the middle
> of struct vmbus_close_msg causes warnings when built with
> -Wflex-array-member-not-at-end.
>
> But the struct vmbus_channel_msginfo is unused because the Hyper-V host
> does not send a response to the channel close message. So remove the
> struct vmbus_channel_msginfo. Then, since the only remaining field is
> struct vmbus_channel_close_channel, also remove the containing struct
> vmbus_close_msg and directly use struct vmbus_channel_close_channel.
> Besides eliminating unnecessary complexity, these changes resolve the
> -Wflex-array-member-not-at-end warnings.
>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---

Reviewed-by: Tianyu Lan <tiala@microsoft.com>




--=20
Thanks
Tianyu Lan

