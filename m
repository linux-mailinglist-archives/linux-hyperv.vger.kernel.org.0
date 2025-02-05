Return-Path: <linux-hyperv+bounces-3839-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DBCA283F4
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Feb 2025 06:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0179163AB6
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Feb 2025 05:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE74A221D8E;
	Wed,  5 Feb 2025 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="PvgD56ON"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF921E085
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Feb 2025 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735009; cv=none; b=Pvcs10vnfStQiiXyvIo1zKqmkO+f8IHBHTthMKTE7+w+sm8RgCL/vDBE8v9hvMr6GYdckxm6caVA36J9eVfTE4BwW7Uf5xBXxjlpg1gltjDRthmZbO8aza79MUbakELG9AZ8xHHqzqw9qo7tZrIIrt1byNxKEEYeB2v3WuQYkmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735009; c=relaxed/simple;
	bh=MrX4MfuXKWj5ytSNxwkhkKn37o5v+Re4uJYrYKu/+kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAiDoWkhhkjSy+KFf9wgks3xbp24ZedGiUAH0tTClEe01NcY2neHpx8ADWM5f5eUQ26m5ldVC+vub8Mq8fKYhP6ENzxTP1hx0wrWGi+LKj4h0uPPoxmmry9hX+yI4UnV9kEtRAVhCW+HjTi20w2kEJGBGhkRJ6B+6azrDZOXyzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=PvgD56ON; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f9d9ee2ec2so1197268a91.1
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Feb 2025 21:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738735006; x=1739339806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns0GvBmqZ/ALUPGbyiEvtLecO6r/ScOTIN440LsR8U0=;
        b=PvgD56ON9ydeM2frr0Pss/6EhwfrpkPotumZZBi9t9hWG23SK+BTxTll+89eVAGSWd
         3kmqGfQQG0d0BGoqKYHmLzz9iqIEa6sGy4dvpTjTVP3xJzK8zMtOv/rsUbL76G/lX9eO
         K4I4KiRMbd22Pg1ak/CvdWT7PFzyXidj9qDpOFNzrnwap0X6vHzzfgnP59LB4o73WZ/W
         F9JpdZZLDEfN/hifDXy7onJtBq7PLxkJvbE38gScAFOXSRrJND2D9PrRjJQHdZNo9ZXR
         7/fmohklHSn72E9v+U91y1cJK86brk1XM/gCJh7YKcAyWfBxVNXzbbUqYurCyj9i68wW
         JZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738735006; x=1739339806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns0GvBmqZ/ALUPGbyiEvtLecO6r/ScOTIN440LsR8U0=;
        b=FWtwrFm7gJk1uwEHYq28ASDzVXiE/LsQHlvJxTsVRGpYGUWbfC9+kvMvG62LKEZht6
         nJSw2GvtQiZJPnGrnhVI3rGCPnRcxkoX96iNX+0dyC0iOhPhjy+fAuBq2xqtPjZDd8Ag
         wtlLJ720qiLAbJ0U/vH44KG3HZZzeMJGDtGxW1RwNf2pONt0fiyYhOMTbGa2BpTc6lgm
         Z7XJWAGhVHotO5PsBp0+MUEILhfuB0S6Y/94xwfYNQciHxdQjKjR2yrloU4nEi9KeH2p
         Zbn21aSw6t29M/Pdiw/pgFrbrCiseHa9S+D3jsxDCk4Hr1lt/sPkqI1cyJ6ICmoaOJDI
         H/BA==
X-Gm-Message-State: AOJu0Yx8TshyGG5Y7DXdice6SLcOtVYhnQmmS4siuHL362fL+ZypMNUu
	u5TVHAwKL3KwXbde9XHqhz07nO0WCd1a5lZzFpYHRocVvBx4tcupCpLtfHIf+m8=
X-Gm-Gg: ASbGncsvSs5nqhbxK0yhkTPMRnYrAgQJ26CaTl3Cplocj9aPNirsfiJMzyO+tnYXtr/
	QR3replWV8HL0vHMaoTJ97RWzh6JEeJ/uQVettI4NFoiLa2irNl+kaffOX3jNmZ7EUUEa88omXz
	LFeg2KRH1tpT9i4gfF0nvfG9aqnlG5fAcIZTH4YlEN+Fkvx6tAe3xMLP3gyVIcgc4OH9/HC0Yvm
	ivA0r/Per9smomJn8uhd52MZ/uJsrTbGnruDxs6Qe4CjDW4yXdem2blJGEx1DZP/5NRt+2/ZO2I
	zBr6U9iRJS6VmGJrhfIHMgcT3Pzc1QyZFe/ZQRaEsn1gzeKvqdFZpSbKFFSmJ2AWN5+3
X-Google-Smtp-Source: AGHT+IG04CF5Qx7s6xBWVy3NG/NTiwTMF528huN8sMDzFrqgklOtDQvD8VpkkKg5ZaYCNCuNQm5zHg==
X-Received: by 2002:a05:6a00:4642:b0:72d:8fa2:99ac with SMTP id d2e1a72fcca58-730351255c8mr2340033b3a.13.1738735006329;
        Tue, 04 Feb 2025 21:56:46 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a18cb1sm11561432b3a.169.2025.02.04.21.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 21:56:45 -0800 (PST)
Date: Tue, 4 Feb 2025 21:56:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Long Li <longli@microsoft.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH 2/2] hv_netvsc: Use VF's tso_max_size value when data
 path is VF
Message-ID: <20250204215643.41d3f00f@hermes.local>
In-Reply-To: <1738729316-25922-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1738729257-25510-1-git-send-email-shradhagupta@linux.microsoft.com>
	<1738729316-25922-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Feb 2025 20:21:55 -0800
Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:

> On Azure, increasing VF's TCP segment size to up-to GSO_MAX_SIZE
> is not possible without allowing the same for netvsc NIC
> (as the NICs are bonded together). For bonded NICs, the min of the max
> segment size of the members is propagated in the stack.
> 
> Therefore, we use netif_set_tso_max_size() to set max segment size
> to VF's segment size for netvsc too, when the data path is switched over
> to the VF
> Tested on azure env with Accelerated Networking enabled and disabled.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Since datapath can change at anytime (ie hot remove of VF).
How does TCP stack react to GSO max size changing underneath it.
Is it like a path MTU change where some packets are lost until
TCP retries and has to rediscover?

