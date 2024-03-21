Return-Path: <linux-hyperv+bounces-1811-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48488885F45
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 18:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0445F283C8F
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF36979C8;
	Thu, 21 Mar 2024 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JQ6H1ty2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86256B673
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Mar 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040836; cv=none; b=TUsjwoguRpQGABa/X8Ko19/roA+qruSRMcSstFiLyEuJ9KesbbzoNmwkqpNRkrXR4GmN1ulUrEagYoOYI3AD7oNSqeGzvDeSyn5/zvmpiWBXg05IS7PQtup81gVyLQxIdASCUgt7hrmkyc4eTKWnmMRjwtYYYsZSAia+7azXR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040836; c=relaxed/simple;
	bh=kJJk/+Zdsmcv1wL0Fg0q/2+f4j2RqoeS5rRQ6udYmmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cU/8BoM9Jnd8KhWdIN801DPeYSmtMMY1//yyoQALEH6FBCQjFKGgrVTDZPyKrRxeuITCENmC3s1eEgt8uKN5iFM5UGr2ZO2zpqKbS8ZG9R36w1NPmue1WW35Yd/MI5ZyNW6drIhOIVVv7+9dMoXlQK3Y5eiUqM5LMZR+75E2+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JQ6H1ty2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46d0a8399aso391305566b.1
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Mar 2024 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711040832; x=1711645632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MsVbd2140swEcLwTG+MF1x3NLhBkmZkIVQJKoZyOCjI=;
        b=JQ6H1ty28ullPGWs32TbOduX/siWev5wKYccWZjqFuHDUODPJZJiPVol7MCFjNfJCt
         gyc7CbGU7FpyiRPZlu8Ao8MSCz4Wur0PvNx9+D75CxNyR6W2oCG0nHkitfu3m7Qp2IMJ
         Z+H0joBlfCoh+joSQ/0hQ/6JSIPUSq08CX6v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711040832; x=1711645632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsVbd2140swEcLwTG+MF1x3NLhBkmZkIVQJKoZyOCjI=;
        b=IX9rcAu1QmvbY55tbOUavFjA0JijyoyPxshXhONs94TCJSxFMUz8swXMDsZ6XTd6ja
         RLkj0yqdu2wYN/XdMwwYivvqgP97aBKUhD+y6iIccnN492AKGfuaf7NMRKdVbVUCL60B
         rUS+TKfe0R0s3efaCtbh1X0GlbXVv/TGaOjSwGJDjcrDoldzAtjNe7E2QIQlQRPuI2S7
         DjJoOmS9U2SpiFMernL8ELKDFlzMyLlvu+QFmwfJySm9WlOTSd2i9ml7l8U3Ai7vqlCU
         +OhLi9bgPQ+jcpETDTw2pfBb5OXUqs9Szc2PZ6GEgXQGAqH/fmjvHFpqgO9nqtay8DI/
         gyfA==
X-Forwarded-Encrypted: i=1; AJvYcCU5MP6PQNjMCeJpXun+W4HMdvkBdsufqF3ga8TqtgyvNTTulrQzcqYMvecgWlb8J+gMMgHMa6/VfiHYIlfqHPCACQ4yqOV/Jh02kfOR
X-Gm-Message-State: AOJu0Yy2VO3xvsqGolxoALh7YtIY4CnH/tS/La1lgt/r+7/Yw85IEvS0
	mNiaBcYaP7WFFzseLClR/uN3QbT8B1h8yKSldAXtTaVYlE+XpuEDNJPyhYuWj9upn+jy+7cbbEa
	pdEF13Q==
X-Google-Smtp-Source: AGHT+IFdAvbohDybkGhng1LdAhNfvl/N7CCNNE0AkUBUYUIqq1sKhRQhHLlEArajICz8ooUjQQgTgw==
X-Received: by 2002:a17:906:74f:b0:a47:1b25:a7bb with SMTP id z15-20020a170906074f00b00a471b25a7bbmr1549702ejb.4.1711040832564;
        Thu, 21 Mar 2024 10:07:12 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id v6-20020a17090606c600b00a46025483c7sm116780ejb.72.2024.03.21.10.07.10
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:07:10 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4707502aafso219838666b.0
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Mar 2024 10:07:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeLg3EJUX5hH1DT0xCWUERnpMHGHDM1c3vkGlb5SNuNsQr+GF+uipiLWrnjArtSXyRBzvps+k9GPOg7Xa6tTwoEmjmGztoCTIpeT97
X-Received: by 2002:a17:906:360e:b0:a47:1c5a:6577 with SMTP id
 q14-20020a170906360e00b00a471c5a6577mr1106916ejb.35.1711040830359; Thu, 21
 Mar 2024 10:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfuy5ZyocT7SRNCa@liuwe-devbox-debian-v2>
In-Reply-To: <Zfuy5ZyocT7SRNCa@liuwe-devbox-debian-v2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Mar 2024 10:06:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCD994KKNL7LGTNpF4B6-E2_A13J2hjP-ufnYt0KJdCA@mail.gmail.com>
Message-ID: <CAHk-=wjCD994KKNL7LGTNpF4B6-E2_A13J2hjP-ufnYt0KJdCA@mail.gmail.com>
Subject: Re: [GIT PULL] Hyper-V commits for 6.9
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, 
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Mar 2024 at 21:09, Wei Liu <wei.liu@kernel.org> wrote:
>
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20240320

Pulled, but...

Your pgp key expired two weeks ago. Please extend the expiration date
(and not something small!) and make sure to refresh the kernel.org
repo and/or other keyservers.

                 Linus

