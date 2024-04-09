Return-Path: <linux-hyperv+bounces-1946-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E1489E0F3
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Apr 2024 19:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBDB1C227CD
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Apr 2024 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EF5153824;
	Tue,  9 Apr 2024 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiOTYIXu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEBF13E3E3;
	Tue,  9 Apr 2024 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682105; cv=none; b=t5Qi2phtKjoYWc0zSdHiWxQNn7JWc38S9zwvIA/GMaIVfowbTSvu8LDcrgzb2Nqz5A+/Wm/6nmtR+Y4U4aDeCVT0hfl0X85pr0CN/jkekuxVNABLxJjF4DYuj1tVPcuOA7MWanrndGudn216s55fpwKdT0zG7YdYDOeTJ/l+8gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682105; c=relaxed/simple;
	bh=lftnbDb228AtGqRmKG1GruD9Tdr0r/t4M1ad2PBgPI0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rVU4Isdw3oUOfj6eaPqGmnzBPEbq3YelMor1SCZpWY8qjDU3wjGDRcMrHgN1cL37UOKSZGFAh0kEQxidFA2SvosXDqvyckoJa9v1CMVKRJhdANqgrYwSledPQECrOfcXCCarvtdQKe7e/UP4SyMwiAPmgLwv6t0fbUE5JzeiW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiOTYIXu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4165caf9b2dso26806845e9.1;
        Tue, 09 Apr 2024 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712682102; x=1713286902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GsMNEF3lUCa87J+AsjZLBs3nM/4xYgj2UZQkqon9I0=;
        b=BiOTYIXu2TLP2gHl4EZzzZLlQ1nQ2bB56cBV1K2u06aT0qZaYJF1Lu/XUjEsEI/UO7
         7UheVc2e8xE4gC+JuAinsYOtq1H2FPXIUsWukW8jb/8UaN5qZf5c+or5Pm19BdJtt6ro
         NmAhj2aIOBYYImzl52lh5HFxyI24Tb0a0f0/ojY/YBMAELLrrXTREDEyTO2sQYKTJoCb
         U/AaQaPTnaCmOJIw4BBQdrUD1r7H7M4QB2zxFCDnPLuvzPFdhP7pb0czI3ziGWGSTcx0
         JZoy27zUciPTVW5kFdtzOHd9J495QrLetE6vlx/U01gJS6Y28fssNSUUja2eDuZ1ylSn
         /hJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712682102; x=1713286902;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GsMNEF3lUCa87J+AsjZLBs3nM/4xYgj2UZQkqon9I0=;
        b=P5mJG6RveXWWek2UG80GNmYUl4A7z3MClv2f2De2noGigbseGwBJYagkm4xB1CTzpN
         ZbRzdYd+LKi4hxjoL2pm+XhI6Z3ixmJU9aeqBbqHQ2T4NJWjdwsjPVW62KJ7NNCnLs4b
         0GaLaV2c8XHuYllfy07uFJ0cWwDD+judXpuObP3w6/PVsFPA13qNKlUpWM8il4hFoJUE
         DPu08rd4xufnVvI37Bwnqw3/OX4Ugcbam4kkVAtn3lM+5Y46xEMoiHRpeYshydNfb7ep
         vznLAh5RZBfNfpNw27Z6jYk9dZw7uS1UVtO79ptWPGqQPhhpe+h6QEMz4jdUMFvVO4/N
         nNwg==
X-Forwarded-Encrypted: i=1; AJvYcCXPnEcR3z/VHFtbHPnNxUwNoUYZsTg868Hb/0ghXbzh5iN1qK4QD5rf1yTynR6QLhO11kfcpTd4isR+MgQAd0+NHtO4prVdC+CBrYyR7WOLaZ6f/gpKnmy3tNN9lJglXHaSRcZaLuWnxGg/8Xtb6FB6nQ/JPZX8C6NNCprcX4KO9i11aDy88OLms8NvVDdQ155KAQnjY5KzS7alGQlBrltKey2GOEpjKQa/2ZXwFtiA9WMWmH0VTEwE0DskZciLPQ==
X-Gm-Message-State: AOJu0YwdXAqvUHVwOTj0OqVFhovnU9Ik7XJWfXlwmHlrEnd47qbDNPXV
	RU729cXaocD6f6MCGu0ihQGVd8SJ86MI8vp2Fqd4hvLrOGO2W0xg
X-Google-Smtp-Source: AGHT+IElBhBg+n7nv1ufKcp4gnBNnHktsGfVzpiFGSrsNs4iqAFH5OsrMWEV2AOFNAmH/WjJusDm8g==
X-Received: by 2002:a05:600c:198c:b0:416:6b95:c631 with SMTP id t12-20020a05600c198c00b004166b95c631mr244269wmq.6.1712682102085;
        Tue, 09 Apr 2024 10:01:42 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id o34-20020a05600c512200b0041627ab1554sm21366717wms.22.2024.04.09.10.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 10:01:41 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] RDMA/mana_ib: Add flex array to struct
 mana_cfg_rx_steer_req_v2
To: Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>, Long Li <longli@microsoft.com>,
 Ajay Sharma <sharmaajay@microsoft.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Konstantin Taranov <kotaranov@microsoft.com>, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
References: <AS8PR02MB72374BD1B23728F2E3C3B1A18B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <20240408110730.GE8764@unreal> <20240408183657.7fb6cc35@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <ca8a0df8-b178-31ff-026f-b2d298f3aa84@gmail.com>
Date: Tue, 9 Apr 2024 18:01:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240408183657.7fb6cc35@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/04/2024 02:36, Jakub Kicinski wrote:
> On Mon, 8 Apr 2024 14:07:30 +0300 Leon Romanovsky wrote:
>> Jakub, do you want shared branch for this series or should I take
>> everything through RDMA tree as netdev part is small enough?
> 
> Shared branch would be good. Ed has some outstanding patches 
> to refactor the ethtool RSS API.

For the record I am extremely unlikely to have time to get those
 done this cycle :(
Though in any case fwiw it doesn't look like this series touches
 anything that would conflict; mana doesn't appear to support
 custom RSS contexts and besides the changes are well away from
 the ethtool API handling.

-e

