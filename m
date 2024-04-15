Return-Path: <linux-hyperv+bounces-1969-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA28A5C1D
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Apr 2024 22:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0541C20FC9
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Apr 2024 20:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E5F156655;
	Mon, 15 Apr 2024 20:15:32 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A826811E7;
	Mon, 15 Apr 2024 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212132; cv=none; b=oXvukSCESvP+zE3XmCCRo4WeT1kaPs1iU8DlBGYp0xec7zAbrUGwGAQAG6IV1NGQmCuPVQLRHuG66EP+hWN8cnmZ2B2xHKMEJV6Ia3if36ScD8uHR9kuva3ahZVhBIQ+jFpIu5PiFFiSq8VqG6P7krxxUVKKo3Kn7lmz9iCGWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212132; c=relaxed/simple;
	bh=x009S4Q4i/2wOS31bqm4Mw3McE4pheaTIN5NwCFvr5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVxlFaLQd2PbtXOQMeetf3A/puunuui35D8yOpgdlhsFeJoyOf1Y/y54y/EeW2Gq6c6PhLdJ4tnSkEq/CbQtvFTKmCL1a2zlktYdu9P+TGeGyg+3C1+yfixVkTJbp87kPTKHrIqLjOh/wiSPYHY09RNgjgvj0ltcH8FU1JNOnHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e782e955adso3662711b3a.3;
        Mon, 15 Apr 2024 13:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713212130; x=1713816930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqK2eKIP/xF81JVkMZqp7Qx6AZ/CY+WMk90Q12OqdUU=;
        b=H43XNw0cgtV4fMsa1dUd5lLFunhsbxNckg3NHKP09Ld0EOHxWBW6vFsOkbZ5jV0vYP
         zyYuETRLMb4ajU1wpkvbH/yvw1Q5lLY2ZXsvDU/5sVNoqoh6epwckq9E6xUvefZh2cqp
         EC6+Cwc3RI51vGVQFHfjvsnn41Tz7eb3G2sPpauB2eBwd/wpCca44ll6pLpjDDqXjlNz
         yKpe1LeChYoy1+rUg6Y0HfMsUDClwzBdavtFS982j5J2nOovgHtArf0jUlgSxuaehYJA
         65MjlOumAwNL+g96FK0XPpWfBiMQPEOt+Pfagw+I8oxptLve3EYkRg7jjlVxJFCsNAZ5
         n4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVns6KXULQ6gNXgrAsXKTxwWePv3EEi9LR6vjz+2TqE67aLujEKV/hipbnFoRc1sPMQ/gcLA/ZE7FWAgTrxCmsMBxAatPqUYhT2zKM8FbHvM/fLzj1LUfU7wyI6/XTR/7QjkL5okw8rO6s/
X-Gm-Message-State: AOJu0Yx2rkNa2dtQR+M6P1rEE0HknhU+p1abgGj6bgXBzp+GzCjCdZ1t
	UPcE8zoSQ5AQ3afrAe2+YTVF8QmIiuOp8DTpL3/GUhcIqYqWVI2ZrwAkcA==
X-Google-Smtp-Source: AGHT+IGs0Q5Xg54In8UDqMKlLRdGQvsq6QS49ZTJ3r7y93Y9vztBHzgcR9YrY6hmb8ZYM6zf1lQpeA==
X-Received: by 2002:a05:6a21:2d87:b0:1a9:c28e:bc17 with SMTP id ty7-20020a056a212d8700b001a9c28ebc17mr12026418pzb.45.1713212130276;
        Mon, 15 Apr 2024 13:15:30 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id bz25-20020a056a02061900b005f3d2a9a91bsm6463293pgb.89.2024.04.15.13.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 13:15:29 -0700 (PDT)
Date: Mon, 15 Apr 2024 20:15:27 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Schierl <schierlm@gmx.de>
Cc: Jean Delvare <jdelvare@suse.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Message-ID: <Zh2K3-HLXOesT_vZ@liuwe-devbox-debian-v2>
References: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>

On Sat, Apr 13, 2024 at 03:06:05PM +0200, Michael Schierl wrote:
> [please cc: me as I am not subscribed to either mailing list]
> 
[...]
> [Slightly off-topic: As 64-bit kernels work fine, if there are ways to
> run a 32-bit userland containerized or chrooted in a 64-bit kernel so
> that the userland (espeically uname and autoconf) cannot distinguish
> from a 32-bit kernel, that might be another option for my use case.
> Nested virtualization would of course also work, but the performance
> loss due to nested virtualization negates the effect of being able to
> pass more than one of the (2 physical, 4 hyperthreaded) cores of my
> laptop to the VM].
> 

Have you tried `linux32`?

See https://linux.die.net/man/8/linux32

Thanks,
Wei.

> 
> 
> Thanks for help and best regards,
> 
> 
> Michael

