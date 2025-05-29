Return-Path: <linux-hyperv+bounces-5691-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE294AC7921
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 08:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FC617E4B8
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 06:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272602561CC;
	Thu, 29 May 2025 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPf7xsKz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AA3205513
	for <linux-hyperv@vger.kernel.org>; Thu, 29 May 2025 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500888; cv=none; b=a1oGj/5evjAhs92g+SuI4uLi8gaoxS+s1WH1JQq9ZFNjMj5y7f19ndDAXdMvd2bY6kaV3zvXY1WDmP7SBmzPbGLrWDOWewjlEyTuFyRCPdw0188oxx7MIZnmKsD8//OvBLbAxKc880OCgjigjxweZwtSbId8b1yjiodIsnf5p5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500888; c=relaxed/simple;
	bh=uo6zWtMJAmsChlsFAzrq8E9fCgS8gXBxbYq/eth/kWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfvPa0+OThfqR9wYvztVzQKSfGz3nN9h4rLRzyaQzl+bHriyXZSD0gX/komFG/ZF6HVDanQKehn4q4jLOnROB4+G+N/5nJTSHC+eOYb/2eoztYr4Gp9LimLQXbx4UhKCmuG9xRiR/HxcBprYus/UnhZ+dBV4oY8YX73F1Mn+Ljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPf7xsKz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748500885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gZ8u/vWknXqeMvhMYoZse25X6ebh82JRFp9N4VCxqk=;
	b=UPf7xsKzYABpkxeUyDePSTbs6E9MnkX2E0KJ5mjhVZxqOftdxPBMkMczr0yoA+dbMZwJj7
	NlnsaEwoLhUp3ZsdEJWGrjAg2j3WEVvENMHjKibWKiWK6dhNvZvEay6vVGQVl7Q76kQaHF
	izTqssu8Sp2P8ZKPPNmJcF6DiNReRsE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-kR7P48geNiqXMuf-8inv2w-1; Thu, 29 May 2025 02:41:23 -0400
X-MC-Unique: kR7P48geNiqXMuf-8inv2w-1
X-Mimecast-MFC-AGG-ID: kR7P48geNiqXMuf-8inv2w_1748500882
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eee72969so345042f8f.3
        for <linux-hyperv@vger.kernel.org>; Wed, 28 May 2025 23:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748500882; x=1749105682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gZ8u/vWknXqeMvhMYoZse25X6ebh82JRFp9N4VCxqk=;
        b=SKmPRAAQRkW2fTsAN9u2NtJfWKlV3n44Z7UhI4Ap8z0/KEjkVvl+Qcu4d1jc43Gj1n
         eSQbMuEeiUqJl13c1zvZlIbFv2mZ05hRwm3K6XeDGcBwh93vudstu35xbOLlpJ6IugSB
         iee1XW18qcKnOZoH/b9qc/Qed0EegYOPFs1jcqwMGNSEnBiu48hawxDWuFpMNuMwwJIC
         3nOo4EnBVbl7vQ3bIxlGTzgX9NKYh6bCxj7WeZSPZga3T7WtEN17oFqewgNckfjYu7bj
         wPU5MW1xdX0uc8zd2xdGsVYr1ql/ACVkZ/NjBXrDGMnui60MIZ+89ea8T9dJGaTOrtvV
         kxYg==
X-Forwarded-Encrypted: i=1; AJvYcCUI6vQ7/FZuDvdAyjONMZoFfFndIn5o1jjarwCuBrHh8x/hvGfyG4nz6nMog8htHb99JiNm3kxh86O9h3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6mywO/e74uy3mdwN0JXRowOEkf7H/St+Yr7A7mAFncJxOyeMK
	ZeS6tebNU6z7d+sLO24zWPIYrmtRrGCv5gPt4jEAOVn3oEtakfSgbZpcGnFPBfEPOL7PUNMdPBP
	Lqb1u63txDugqAuGZ5p3eJUOTpqocKy9YPyUEqFAWD4RJD+PCe1Sh4A29jZ30lbxVMQkNt8LRLA
	==
X-Gm-Gg: ASbGncsBHDqqHeZO4pYg6Nn22sqVItHgxEA4ZCS1LBMfg4BMMEYJh8jFzeOJX1rzZzE
	8LW/SHiOLJIsANJHKB9JIW1DHddtsGoiiDPZ6Yp//YRMMtsI2wUz9h5f72RuaM21PobcmEBV+Af
	ZSsji/rRB4bX9siEcz4XpCKAtyr9+d78uankEE4/H2vUU7iz4P0fPb9q3llfSfrfTRvgsyOKR2m
	NO9qf2DWx3IJAw22TGNZ6pxTDj3khjCgxp8t0tPn0Xdyp5cWNQqbUQMkUdOWtw8AMHesiMvvqmM
	pbehuBGD7p5cv0Au5oBga9YvC0FAi571JKGWigq0zbaGErjvkPJTp0MweXo=
X-Received: by 2002:a05:6000:381:b0:3a4:e4ee:4c7b with SMTP id ffacd0b85a97d-3a4f358f0camr603434f8f.15.1748500881770;
        Wed, 28 May 2025 23:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4WDum86fTnMvRYqch6MR+ztEYQ2eZPtIMANK31N5JRpHf3kQXQ5zQS9pHaQJE0QCeX7DRPw==
X-Received: by 2002:a05:6000:381:b0:3a4:e4ee:4c7b with SMTP id ffacd0b85a97d-3a4f358f0camr603408f8f.15.1748500881399;
        Wed, 28 May 2025 23:41:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4? ([2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00971efsm1015064f8f.62.2025.05.28.23.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 23:41:20 -0700 (PDT)
Message-ID: <21c1b2d9-1b94-4caa-aa68-8abbb6562446@redhat.com>
Date: Thu, 29 May 2025 08:41:18 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,v6] net: mana: Add handler for hardware servicing
 events
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
Cc: decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
 paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
 davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
 kotaranov@microsoft.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <1748382166-1886-1-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1748382166-1886-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 11:42 PM, Haiyang Zhang wrote:
> To collaborate with hardware servicing events, upon receiving the special
> EQE notification from the HW channel, remove the devices on this bus.
> Then, after a waiting period based on the device specs, rescan the parent
> bus to recover the devices.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.


