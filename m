Return-Path: <linux-hyperv+bounces-7482-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0573DC45D94
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 11:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72E4D4E9DDC
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859812F6937;
	Mon, 10 Nov 2025 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gV1/bSjj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C54A33
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Nov 2025 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769429; cv=none; b=k8lp3i4kXYB6gTuWKQdyaD9jLass2gR9wWM9ExCQzslSgYcG0HdoovCKgFwuLFGeZ7EoPYaI8TRT0VIiN0SvXesP/XxPiPB8Uf3K2CCVcvaec5uQF8OkawH+Pk3/uKPOOGbwR81KXNzXshuaGsEMvpwgDh+Dgu3HMmmrygbBYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769429; c=relaxed/simple;
	bh=TVNJZZr3jfoE3UaQeU9vIu/zRILJt+76GfhotihG2as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNrWqzkLqiNFOI54Oy7ZxDaLkoII6xgdJOwu394W8dkWUk+rD4wPLqEnHNKvswEB8vIazOsFcEuiyV2QbqD71/4PiMFKLz0UP7sCFhWQ4GNPQum+UcE5/TnoiHZ4U6Kqj3yb2yn7bWwZax57yBBvFzE99QDtYXrCcrvrlJA7DPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gV1/bSjj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b72bf7e703fso505187566b.2
        for <linux-hyperv@vger.kernel.org>; Mon, 10 Nov 2025 02:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762769426; x=1763374226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVNJZZr3jfoE3UaQeU9vIu/zRILJt+76GfhotihG2as=;
        b=gV1/bSjjQDmhqfKzDZna1AmdciSFeMUB2Dmu8RC/BLFZXhgu4mFYvYqAS54oVVdoF7
         9svHwWS2ysGZzDrlB9FrHQVWSKjZfFaYxyCCwim402EJjIbYERmkKg2fwgGNL3qIZUEE
         UlnZ5Nn0sJSJnavi0vfeYE/6cGNbMtuwxiyr1XDB1R13PIYTCVJbxb7xE5Szwl0yWUuW
         StadOyWt/B5kyE+eP1H5pQW/wY2BE3cm6vkAbaL6Va0xx+q6ktGfkI6K6y/RkN9DVnY8
         lER67QAduNzdc78KHTDSfijSjedl9GPeNJ/n1vnh4zo/zfc3Hf5Iv1hOU7tWqh1JyZ6u
         bXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769426; x=1763374226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TVNJZZr3jfoE3UaQeU9vIu/zRILJt+76GfhotihG2as=;
        b=oRTcviFhheRGHLzlGgI2roZfKafak4oKjbMrstnzek2vg5D/bezhtx5tPtg6i57fPK
         wV4CfBrmonLwKTaFqaH2bxos5OnjjLVClCjTaqIXtfEmks1/ocB97ffnx3Cc+JeIybHx
         R+Kq3wAj8TnOVbvDX/Jc21Y80Y5JzUVtiNsgYNtSpGrnfY2NgtEhfg865HDgChNlXiHO
         MKzD03UcFmvzKkiIGGfZjUPUOnElmZ/hxF3Rg+j8IuvV+YwO9fkyS61QFXXGzgRLdppn
         lp9upM0La1jd6bJjRAZYgyUutqiWZk9+RpXvxzXNkoySkySr7R3vk04utZq0P491PjXU
         pyIw==
X-Forwarded-Encrypted: i=1; AJvYcCUmjKMtph8zWsV2l+sZycZ/ZNiWuJLv0qbxm0lE/5kigo10YnnRfTA6tDCREpZ+Pjj/Ey8wC20MHZcDTk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKI7GpL3vTxPWa3qnA5UayaKv2xy/jVULoQNfkhCmxfw6TEs7c
	yFE+2n8dKI8ByBtR9J/SycZ6slHXMM0Ypx8kOvqoyERGgUBUsou8jonhEUleYud481mhVsnQUIq
	fu2ynq3YbacyVzWoLplYHwVrhUVnCbHSnlh8lDBCbCQ==
X-Gm-Gg: ASbGncu9ik+Xax8dxTDpX+WrqHEQk0/LclO4vqC2EqeExnRk7WDIugZQ7BHbLHjBybD
	g7zqgM1FMHj488pFLdJ2eNor5H0LpfQgilDQY6mZlpXjxML/unJZS7/W02b6hfjGBp2Bw7CpyGj
	BTFAMi7D7D/WKEEjwECvfIHcKq66ocj4SMx8Zr1DmsjNJEJwgi9n7nAZJss01ZzGBt8De+gAqGz
	TOr/s2BulA7mZBpt4B6S0VgV9id6DpQICrbeNF2ein9RdJBQvkR/h8EKzGND1YtJfmnvSjStEL6
	7hKI/44UoXYbnUvtPQ==
X-Google-Smtp-Source: AGHT+IGLwnDKdWKGCP0miJmikH8pE3adQ+9Q79EIKvxvM7XnoZfAmJ9m9kW2+rixfd9R6Gmcxrv/ZQn64iRasSw5Kj8=
X-Received: by 2002:a17:907:80b:b0:b72:b495:828c with SMTP id
 a640c23a62f3a-b72e04e34e4mr902549866b.30.1762769425768; Mon, 10 Nov 2025
 02:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107132712.182499-1-marco.crivellari@suse.com> <20251107181156.GA4041739@liuwe-devbox-debian-v2.local>
In-Reply-To: <20251107181156.GA4041739@liuwe-devbox-debian-v2.local>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 10 Nov 2025 11:10:14 +0100
X-Gm-Features: AWmQ_bm2G6CFuK2AUoQ3TkVXCY83KDhDqqtXzP_vMgpx2r6nNOQHc5dY63iflb4
Message-ID: <CAAofZF508p_6Jy4idPkbFu0r6bvf3x2SUQrH=nro+a125fBmkg@mail.gmail.com>
Subject: Re: [PATCH] mshv_eventfd: add WQ_PERCPU to alloc_workqueue users
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:11=E2=80=AFPM Wei Liu <wei.liu@kernel.org> wrote:
> [...]
>
> Applied to hyperv-next. Thanks.
>
> I modified the subject prefix to "mshv" and added a new line in the
> commit message body to separate the first two paragraphs while at it.

Many thanks, Wei!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

