Return-Path: <linux-hyperv+bounces-6253-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99307B058BD
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 13:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C2F561850
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 11:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F552D9482;
	Tue, 15 Jul 2025 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+WlqW+u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E82D878C
	for <linux-hyperv@vger.kernel.org>; Tue, 15 Jul 2025 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578831; cv=none; b=bk2Lo3xU5Ubvgi5+1cbytdGbCOTRm/LtvS7m0OQsR7sX42S9hqwI5QMMbgVlZ7GcODyCe6bBOuySxgABWh2WV4b6Xyt80FstL75QiWNBpzB8c+0gytZT4EbSH1IShxqN7YzJCzUUaraVrLP3DZdy13W0f13YTNMC6L0rD8CiYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578831; c=relaxed/simple;
	bh=8GyYQty1c4kD0SAqerD56wWPksO2YDSVbq8ZQGGgau8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOicFukPyfjlD5Xqt4L2/uCAu/rb/5KOA66hWa5GfnH1qh1chvPD8wx38RXyQI4AhZVueFFtet741Jt2RTZ5uv9e+UP/mJ4028r852RkQNMoJIhMUl0jbo8wN4Eyvc8sgX2HWc6TGGuqal8U78BGBfwfPe0B4Dx1OQuB3vpBDbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J+WlqW+u; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so3507004f8f.0
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Jul 2025 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752578828; x=1753183628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jRBkEKn77W7oaouJdcpr1rdaj69fH31GtcALoRiVZ0o=;
        b=J+WlqW+usqYA9XgF+xS6yg8XSIG4KtCyF5zAyEsrdvcD1hb4E2IAr/sUdxNrWoQPXg
         4f/IKeeM255PNYx5RHya/Keh0zWlC8qoGyvJ7FPAt7uHTbGqngvn8rGdTDowm/atcES0
         j8Q+FPVP32clfvPD2niF8JmVZ5eO27ydjLm6kDX1DPnZ2ueE3J1E7XiSEejbCc/8gGsz
         nJ/DhuF3k5QUT3bIu8e4VGPgYrlwnrG0k9q94eHr1tOYzCWnxreo5XMGTmY71WTaHu9s
         bCwIWFRllXhp5GiMeN2k8IU/+/NkLm+JYWdjKW8HKvtHD8DjfZBc+lRwQ+j7RB6dmvUs
         BGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578828; x=1753183628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRBkEKn77W7oaouJdcpr1rdaj69fH31GtcALoRiVZ0o=;
        b=DaVp6Zkb1L+gwhwIpb5Rq8tbca8sQnu8+6Mzy4xpL2mOXkP3G8Yv9hb0LaDF51wAwM
         p7+aBgLMXlYfaSN80/eQDEiNi5h51UMKIvrSgwfq/KtwNqnu2YH2c8HeQ77+c+nu03Qp
         K+mhgIy5N2tZ8sByB6H633ObMFVQtuUFmUWj2FBlONqPIie1preUa1wqxtTmKzRuW1wd
         qmKKTWx0cBQGYupONbaYkvR1qL+sRZxPn8WkkKrDvjrGAb2HyH9/V8EpOTRhxgqJF5/H
         vhEVY/71eUGr6KenvXGEfCT1X/yBwGMwBGIMh0iQC8m9TdmPIQ5WG43LSVP5LQ+gHMeF
         OmUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXxM91EZP2RCXbTLC5stH15iZQG/lh7oUqEQLQRLDwRGMjWY0gVauHwLa8pYDGwlnLro/ghojWkBAQUtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPEa8nWnjZxCmzJ9fyhO0nhQb/PEBtszA6PcYkFMEtZCP/fP+M
	uwpeCiB305Tr3dhNVp3VU5Em6tfp2/QDNktt+tAvn74McSx1Xq66SQ3BJ1IiuTY9zSk=
X-Gm-Gg: ASbGnctEckXZr7q1LPt+TPnNqn7PcY8c7UhYYnVYeAPFvPTMQfCxNngVRhd/GSWTJqH
	fGyQWl8l/BwE7UwN0d/0YmH5jbmMkGdCF747X1GsWmvCPWn3AXghcyXRbg6IbHRIW1g3AllOOGf
	8uZb/SeX4w9AN2RiQoMzRON2F9B5uupm8t/7FSgox4ia8KJppyFcFdfj1ejsxEKvZliO2lI9mLY
	WQdimZRnHzaPb655EED09baCDDdZhsarPYKakaPQ1lzjjJHQ+nxBnrAJsrFDIGcnplDTXLH0Ad+
	PHW1w5qQO12wp5LP/pGQJS+axX2nRFVtQyC+P6vS5CaMj8manl7WS8MkekXgiXIF++sJcHlfS9J
	KIbV8sflewh82+txIRskb6OtVC94+HcgvfTvX6wVURQ4M0IFefU3ODR+mPajg
X-Google-Smtp-Source: AGHT+IHN+NlXgbEjZOyHhgFjTHMZ1I2MGPeH7berVKrfkCXW7+OC0PeJHvmOwpe6Pg5LCPNt2eEmZg==
X-Received: by 2002:a05:6000:2307:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3b609544322mr2365139f8f.27.1752578827815;
        Tue, 15 Jul 2025 04:27:07 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d4b5sm15115966f8f.53.2025.07.15.04.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:27:07 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:27:04 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>, Long Li <longli@microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/6] clocksource: hyper-v: Fix warnings for missing
 export.h header inclusion
Message-ID: <aHY7CKL--DDnWXT7@mai.linaro.org>
References: <20250611100459.92900-1-namjain@linux.microsoft.com>
 <20250611100459.92900-5-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611100459.92900-5-namjain@linux.microsoft.com>

On Wed, Jun 11, 2025 at 03:34:57PM +0530, Naman Jain wrote:
> Fix below warning in Hyper-V clocksource driver that comes when kernel
> is compiled with W=1 option. Include export.h in driver files to fix it.
> * warning: EXPORT_SYMBOL() is used, but #include <linux/export.h>
> is missing
> 
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/clocksource/hyperv_timer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 09549451dd51..2edc13ca184e 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -22,6 +22,7 @@
>  #include <linux/irq.h>
>  #include <linux/acpi.h>
>  #include <linux/hyperv.h>
> +#include <linux/export.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> -- 
> 2.34.1
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

