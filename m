Return-Path: <linux-hyperv+bounces-6320-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE40B0D217
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 08:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3286C1C21F12
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 06:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4410128A1FE;
	Tue, 22 Jul 2025 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enbUI7IS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808A289829
	for <linux-hyperv@vger.kernel.org>; Tue, 22 Jul 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167126; cv=none; b=t7nRFWlR/SZgdvi7zMo2sPdns7ywDWQ900/zE+YOFTvVP3uU+pYv9n7igTM2yga8GWsMrd+lYvYoQu/uiJWG77eL4g/vPSTGuSHhk0seHzDCVdkFeRhTb5ZGhezpl+V1O0lcKuNqGkmgIAuwFK1bqZECkmw3siU/anKIY25BLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167126; c=relaxed/simple;
	bh=PeWIbC1zji8Rcv82/MombFa1BJRmw7d2fz/ARauiscU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fD1ZxJnQtqMZHIBe+Fj3vXH3H3acJiahLL1M9JAmRVZgjEqoSAujN7NAM6OIsMvZzkt/n92phOc85w48gvSYqduXdYcOHiu6+QMh7VaFtQI4Kk6GkR3z3Stg1xaK1SAmeyug9ykcGK68aOB6kBOAL6tlUOBdoOrZjCkH8BzGJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=enbUI7IS; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab9ba884c6so65478821cf.0
        for <linux-hyperv@vger.kernel.org>; Mon, 21 Jul 2025 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753167123; x=1753771923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeWIbC1zji8Rcv82/MombFa1BJRmw7d2fz/ARauiscU=;
        b=enbUI7IS3Pdgii2vPn5xqVAV9iHcIBaXnKm8rDsTZxZmYkOsObKA9Wbx9YgYU5u+uB
         QHbXRHYM4ZDkl74xsJ/ItRDA8z5Esf8vZvQYgl0hImphZxc8HGnv4dhmXOlgryRfMU8e
         Vo5xjCKhokd948J5DnZ79YsdH2hueS8+ngC4yjBoMiUQArUWCgFYmQkvHUisJFmdo9UG
         eb1MdWwcLwblChsl0TTZcC8t4vF0ONHHexnNy/zfLp0+Y5YfroN7AwqJjg2vfs7F7Swb
         ZJbpfkdk+UBXvW4qT+MIUqt7pY+sqc8tPONwm3fz8+bFrXOXSrCiLxW0BiYu6bMYOtVh
         ExUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167123; x=1753771923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeWIbC1zji8Rcv82/MombFa1BJRmw7d2fz/ARauiscU=;
        b=r461vZxypB832/+RXsNeOG11jci/ncacVtPDKsA5JAxkcZaHodnoXzONPfLKULRug2
         60fNDgj/0xsLZ38bY/zbdcN3dqDAhqnX6L8q2eSFXjAzeBEz+sQhEeW8VlQjc+FBnJHw
         Six2t9jdtSwXPMs4YcVJfoEmpG0kpDgTKcwqnGo4fEK4jza5vYznQTeJpnzBR6Pui70u
         FqZ7f9obUyBCrhr0EHRlu+K0UivgxIsj7zTsBsSDK33lI+Dx6XVaNGPr6Bc6+BHrzctS
         6JhKxDzGUjP+crgrYeB9O+rLFtFojC7rJ+hunEDkybICUunjw+xalpj66MjzPraHhLN7
         UHgw==
X-Gm-Message-State: AOJu0Yy5BMJH8foGntVP14zKVeP49KItwNYTHZ47zBZsqy/nwLmt1x5P
	0oYGZOANQOtr9ctNj42X0fHH7tf20yE74PHMPP2XnjmbgeoaOUl7pKuhGqwMc7vOrsy7sgtOnvr
	Ge2HJa+MwN4Tma5JSmLfKc3gD6VpxBr/s1cMSrfLT
X-Gm-Gg: ASbGncthbm7l4hzw852vBM+hazQd7xya91tcZXtokq5XocNesde0oMC4tvGB3M3Mon7
	mGggUNCRgN6uY8fcaJBm/gha0ljAsacmb8UYUn3gUxQJloo5jvBIYokQsLn8f4DiUm6fk3idIxC
	U920iikHD9ZuQJbqCPrDb4074MIZXyDUSzIgd/XDfV/tm7LItjtsHVZjV/NjP9/Aerylp87BAmy
	O+XUA==
X-Google-Smtp-Source: AGHT+IHQtTROmOPjtYKNp3LrKieED28s9Ihtni6NoFl6cfc5Sc0h1mgzJXsDX15qgWH4HGDMdRBDDSThTKbNVJHA4jg=
X-Received: by 2002:a05:622a:114f:b0:49a:4fc0:56ff with SMTP id
 d75a77b69052e-4ae5b7e22bdmr37705791cf.12.1753167123226; Mon, 21 Jul 2025
 23:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com>
In-Reply-To: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 23:51:51 -0700
X-Gm-Features: Ac12FXz4iUeeGipOp3D_tB6KFKYfqAFLlbaMGXZvPSx57DSINr_rpmIyL81k98Y
Message-ID: <CANn89iJLnprFvLpRpJ7_br5EiyCF0xqcMM7seUVQNAfroc4Taw@mail.gmail.com>
Subject: Re: [PATCH net] net: core: Fix the loop in default_device_exit_net()
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, davem@davemloft.net, 
	sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, #@linux.microsoft.com, 5.4+@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 1:21=E2=80=AFPM Haiyang Zhang
<haiyangz@linux.microsoft.com> wrote:
>
> From: Haiyang Zhang <haiyangz@microsoft.com>
>
> The loop in default_device_exit_net() won't be able to properly detect th=
e
> head then stop, and will hit NULL pointer, when a driver, like hv_netvsc,
> automatically moves the slave device together with the master device.
>
> To fix this, add a helper function to return the first migratable netdev
> correctly, no matter one or two devices were removed from this net's list
> in the last iteration.
>
> Cc: stable@vger.kernel.org # 5.4+

We (network maintainers) prefer a Fixes: tag, so that we can look at
the blamed patch, rather than trusting your '5.4' hint.

Without a Fixes tag, you are forcing each reviewer to do the
archeology work, and possibly completely miss your point.

