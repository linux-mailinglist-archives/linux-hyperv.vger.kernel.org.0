Return-Path: <linux-hyperv+bounces-2343-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCCD900C5C
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jun 2024 21:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8DB1F23771
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jun 2024 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EA01411F1;
	Fri,  7 Jun 2024 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0+irMuM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC707345D;
	Fri,  7 Jun 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787864; cv=none; b=p5NvO4ozFV9nufUuRHSnwwLVaJu1sPnDxliatfawyjMaXx/by1QLGt7sQstaicjiojeLMn44hGxaOnKWVOn81NpjU6ZTWzVgvn1/w3xZL0gZnX40l/PL+aNkuny2KIGg+w05gFQ1hwKK6Sg8FJnYBkgW/9DJY1m3tzJFZd+nnUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787864; c=relaxed/simple;
	bh=d7pNxXN7ZZ7n1TjEK8X8kD9o37/7SEp9NufTqHRsRe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvuhDWqwYLYpZcCSaJahWBI9nqR60jXBCgjP9M9g5/9axl9ni5x1Dx/nHY+ELpPhuvY4IiuQy91At8ziA92levp6bGRf5TdgWzIZUuxcZmapMIYRyr6Sze06UI3yv1GXGEcMaB7Ak5WY/Muf9Urk6dGrKzmosLzoMJb+mN2RvZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0+irMuM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7025c5e6b94so2066729b3a.0;
        Fri, 07 Jun 2024 12:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717787862; x=1718392662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMwKu+pMCkNLk3fA7XHYBTAbLNx7GuEVog7Bj2JBALk=;
        b=L0+irMuM/spDerwIer58QP0RIQnvjANafe+rGwWBs/rdicxBkfhhcAJ6OFG5isNTRe
         q6l1hSe1odfzEuZOEYYz4wz14LIIq1cGjC9+dSpoJJsaQLRNY9OYKe9WD/ZpDNNCMS6n
         tXwIKnhrWmBBWt9b3EqAA7mOYlPw3zc/ACs24p7RAkts5rchWsv0kYd9pqs8AD92uK1x
         iMaKWz2CWwOpgdgniuKBPQ3PMho9l5iEy1CEqrDwhXXYkuHpbAuJoYk5YH2/dkYI2q6q
         Rp4DCg0xttd7sH9mmanoU0YC+revsDvt7EtbUO+AU+okQdjXse2BR5WmfI7VkvHFK/7A
         RolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717787862; x=1718392662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMwKu+pMCkNLk3fA7XHYBTAbLNx7GuEVog7Bj2JBALk=;
        b=gMNYQxP5Ovt+BsrlEzNt850YLxzhf5mWFHT4Ju0yY5Q8kpVBTBXOUhABiqdLynB/po
         /cLjE0nJLei4MUpbNzlCcYOOcYNHQ9hefNEW7mhp54X+ADvVgJnXSj+OXydnDq5O/9Qx
         cLMOasxgIBAu0cmFAOz4eE9tRuDbOJ0P3U5iJodeZzTv5GnOqH17ypjUaRjztnaCBV/5
         7MHn0qu0aa07Ua2Fpa5Bbqi6MxcPBYoLp8iqGRwS2x5bOgaF2r9XuQQDnJIOMLjkgTBI
         ZkXoRbY5Z935o59AbGy2qvvblw9eRmlgm8TFnTORIOrm6OP3kakPmdVLQdITHHyuADcU
         KghQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXq5RZG2iRMRBJQECrvPurrCRw82XjJjlBD8C8BG8v+zArh+i+B0iinOPiKvNmcVXOskug6qBmrTxZ2Bm+MsJMK4bM6uj0RBPnFUgHhpfS/t4diU4ISLAv3i6hwuat8RIZWLar9fxkvg1F7diiUQtKgxLJ2pzd6vJj9xM2hxUtaeApU7A0dqxVRg+PtZN9NxPSSZTRmy7EBwCfCOpEYSkEEwxbHX6+csnhUj/QgB5Y1acow7o+TgacQlm4ewaslYiaeyHp/8I=
X-Gm-Message-State: AOJu0YwLG6n81JuMMrZTcz15Q/B0Vy+3GYaqgr2o254Kgk5o5JPoa/ZB
	0hVsA+Slj5T3hN0nBQbwbIi221xhfqgzS8ssDCDAGn1c2E2HpIdU
X-Google-Smtp-Source: AGHT+IHYSV0KCIG3qxQOTEBKKcc1mjWK4+6fwEeVHg+i4ItkqLKlvKzlGZXukzqLa21WlkEglyJVUg==
X-Received: by 2002:a05:6a20:918f:b0:1af:cf63:3742 with SMTP id adf61e73a8af0-1b2f9cb14e6mr3810470637.42.1717787861751;
        Fri, 07 Jun 2024 12:17:41 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b8e9:3447:a54a:310b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de200848bfsm2600379a12.1.2024.06.07.12.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 12:17:41 -0700 (PDT)
Date: Fri, 7 Jun 2024 12:17:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Stephen Chandler Paul <thatslyude@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Ruan Jinjie <ruanjinjie@huawei.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Input: serio - use sizeof(*pointer) instead of
 sizeof(type)
Message-ID: <ZmNc0cwc6yzl3_7H@google.com>
References: <AS8PR02MB7237D3D898CCC9C50C18DE078BFB2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237D3D898CCC9C50C18DE078BFB2@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Fri, Jun 07, 2024 at 07:04:23PM +0200, Erick Archer wrote:
> It is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not
> change the former (unlike the latter). This patch has no effect
> on runtime behavior.
> 
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Applied, thank you.

-- 
Dmitry

