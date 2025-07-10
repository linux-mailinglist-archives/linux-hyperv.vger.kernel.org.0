Return-Path: <linux-hyperv+bounces-6180-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AD9B002FE
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 15:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7F55C3C06
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192602DA743;
	Thu, 10 Jul 2025 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZL3Anwk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4FC2D3ED2
	for <linux-hyperv@vger.kernel.org>; Thu, 10 Jul 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153104; cv=none; b=Egv+JiNcMaBxQ8a+zC8pPBY4zsYd1QM7FUvbPX6PFVy5ricYEQqP2JJFXrXdzGPGDAsi+l+l89R7eu5sz0oqh3he4TJmqHuFrUjXpZ0nAZ9Qhtz8LBPD7y3+154sEnDgQ+kRO/u1siiQ0tWmrXXsLjFx+jZoLBMAKyYwe4rElXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153104; c=relaxed/simple;
	bh=Iiea9t5x3kjnX+xENFLY7HpPQMuYYdsyW/bgyV/bz0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHvZM6O/R7vl6Q6wD75Sw5gDMkLE9lqPD9LQI/ICpgVCeVp10gD9u1ZnW+kos03w2csR/KNeEOAh6ML7qBG75g5gce2t3w/hKPYDTLb3CLycRkj/Ijc78lfl4vqJk4oe4AlC8WtsrY4I9F4QXNLHI7Ix01KDl39XdWG1iVjnGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZL3Anwk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752153102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETlJFlO+CzrUz2FuFvJ9e728NgJmwVRGWH0k5Mr9prY=;
	b=ZZL3AnwkcM7roFKxhmJPpUZ0B7iJJlafRvVJ5eXzA28wXawVtpHklRn2UBKhgijvHEOeoF
	PYRhR0AE/s00Lrwv44dNF6q0d5ewMkCrp3RKc/klAyvzZAHUj9S6ib4y+/zB9WW5VeDFbT
	BdIu2LkVdOyskfzpumVahL+pABMw0Y4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-kyMiE_qoOPiS_eMNk9v9vA-1; Thu, 10 Jul 2025 09:11:41 -0400
X-MC-Unique: kyMiE_qoOPiS_eMNk9v9vA-1
X-Mimecast-MFC-AGG-ID: kyMiE_qoOPiS_eMNk9v9vA_1752153100
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-454c2c08d36so7365455e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 10 Jul 2025 06:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752153100; x=1752757900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETlJFlO+CzrUz2FuFvJ9e728NgJmwVRGWH0k5Mr9prY=;
        b=Im6NAol+gBpiwF6x5ywjdA91cUucfhS0SU8aNLDDEs96EpgRmH6wJce3X6hErBZcHK
         whiVQIMpkdJuOS/vJL5+orRvVWwmMw4YUdXdtLR0Dwis9NuSlA5F2Fmw8fdTx3Qu2Kcb
         tZbUyzzZnWJBuFL00OLnTwpgVd/yfg5wjq21mHU50r4ibXzPp+FaaPgx9X2TWGU8BEHM
         AZInjs3WnJAXuJH5aGW/PHVUoGbWidUxvKEv6v0nx1i28eiL0roo6HGtdQu/vBrwFyNW
         Pv0MxWA1A+dadKKGbY0bpyq8XLu6eww9Ch5zNi3V6ztpqMueAmtTZtT8jLts3Cf65Grb
         /r4A==
X-Gm-Message-State: AOJu0Yxsuj4zUtRRV/GSxFWw4hXf8mA1rQ5y856tTe1YU1uaE++WbtZ/
	lX3eMyfLfGN+yL+fZUC6xjxpaisCD4+Opqdigv7TBUvpheul2WueKyUKrNdFjduSC/hGlbNIQYX
	WM2mztmxNa/cd0iMFgN/dQTSx0HxRDvOthcG9rGK7x1hiJpixn+csSYAnBeOVvvIBsnBwfsP2z8
	GC4fYv156Z4CA2bv+K73YH6wZQZADy+IlAITSC2Acci6ZhX8o=
X-Gm-Gg: ASbGncsTwOmJ4nG+KEnAqvEklL1CrMD2zabB1idxLyIyu3bQWYIlXukabvY7Df86xfG
	EZQGXeIcCHz3UWeQPQsnMokJ1uCZafqtnN1JjhzyIrFKgST0ASl6RHcJXD/0i6wzOqU9hEkkvao
	1C+kxidifvA+1BfUMGm55PLnUEsnDO/U8YdtFSkWzqeV0c0kA75nIv7ZOXcodBqLLBnIc5Xu7ow
	ForHzYgdfPui60ZHdQR34PIP8RNc0wxckuTwQLk9jGXK7UHZLDg5IV9AMxYlfUdtuMeSd+aA2y3
	NJvDxsNRpox5b0kNBh1lrasy+Q7Ge+fUWBKX8ffeX8rGXQfK6Oid8akJmGRyhKA0wAC9Fw==
X-Received: by 2002:a05:600c:4f47:b0:43d:aed:f7d0 with SMTP id 5b1f17b1804b1-454dd2efdaamr19766465e9.28.1752153099746;
        Thu, 10 Jul 2025 06:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF1ZpgfSTR11mwv1AOnDNuhaLvwqaP9AOUkt/tw3gz9xvMPGeQpqux7MyiVPuC8LvG2a9Dcw==
X-Received: by 2002:a05:600c:4f47:b0:43d:aed:f7d0 with SMTP id 5b1f17b1804b1-454dd2efdaamr19765775e9.28.1752153099070;
        Thu, 10 Jul 2025 06:11:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1ee1sm1828361f8f.23.2025.07.10.06.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 06:11:38 -0700 (PDT)
Message-ID: <505fa40f-ba51-4f6e-9517-af3e7596a1cb@redhat.com>
Date: Thu, 10 Jul 2025 15:11:36 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-netdev v2 2/2] PCI: hv: Switch to
 msi_create_parent_irq_domain()
To: "open list:Hyper-V/Azure CORE AND DRIVERS"
 <linux-hyperv@vger.kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Michael Kelley <mhklinux@outlook.com>,
 Nam Cao <namcao@linutronix.de>, Simon Horman <horms@kernel.org>,
 Marc Zyngier <maz@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1751875853.git.namcao@linutronix.de>
 <7b99cca47b41dacc9a82b96093935eab07cac43a.1751875853.git.namcao@linutronix.de>
 <SN6PR02MB41577987DB4DA08E86403738D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <SN6PR02MB41577987DB4DA08E86403738D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/25 8:49 PM, Michael Kelley wrote:
> From: Nam Cao <namcao@linutronix.de> Sent: Monday, July 7, 2025 1:20 AM
>>
>> Move away from the legacy MSI domain setup, switch to use
>> msi_create_parent_irq_domain().
>>
>> While doing the conversion, I noticed that hv_compose_msi_msg() is doing
>> more than it is supposed to (composing message). This function also
>> allocates and populates struct tran_int_desc, which should be done in
>> hv_pcie_domain_alloc() instead. It works, but it is not the correct design.
>> However, I have no hardware to test such change, therefore I leave a TODO
>> note.
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
> 
> [Adding linux-hyperv@vger.kernel.org so that the Linux on Hyper-V folks
> have visibility.]

I think this series could go via netdev, to simplify the later merge,
but it would be better to have explicit ack from Hyper-V people.

Adding more Microsoft folks.

/P


