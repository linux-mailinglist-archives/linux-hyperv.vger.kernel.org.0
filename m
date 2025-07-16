Return-Path: <linux-hyperv+bounces-6272-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 792F5B07E69
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 21:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988A258291A
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161A429B20A;
	Wed, 16 Jul 2025 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="KSdN5iHS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43474287504
	for <linux-hyperv@vger.kernel.org>; Wed, 16 Jul 2025 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695532; cv=none; b=C+xPq+5G1567rxXWhdihwNIqUMhljANMEst3NAQV2pdptOgkFetP9ysJFSqYr8hIzJT7JrANN5u+Mru9TS8YfxaL7Hsq7FsAbMrqyZ5kF4aN6yE8uCzuGztoUOGah1tbABsH3B2uQjZCfwFI1MjpYXER2fk2nWW/an4XA+Q5bmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695532; c=relaxed/simple;
	bh=THJNPOJI+8yk3e7ji9GKoObOrORfiNfsXOXESwcVKpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YrvpdzIm9xidqo4Mp0hZQ+KXlxDvUiQBQkFTfKQpr1EJBj0y1vagOL8nEwE2qEIPtDnxrs5R5440InBc3GLSaVMCtO6ObHKvBoPR0DylThCtY+TmrsngW3fDNWxc1LP04Bm2OVg588FBPVYuktJ5jMgvsBRjqu5fqhVGF4GrprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=KSdN5iHS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae3b336e936so38747566b.3
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Jul 2025 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1752695529; x=1753300329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WylwH9udkWEirydfFpUxcOPjDX2jBvnP9PP0c6bnys4=;
        b=KSdN5iHSwfqGXXeJKJuQauO//biaEQAeGFvXFbcBnma7BoTg0ZNRmnEhWga1naFHjI
         hNrDJX1F5KMLM1YnNRqKWYCyBoWyNp0s9u7KEyUnEeovlk+WfOGvdWK/N4syc7ZeOUsi
         xJrUeuKAIr5WbX24rtZIo0TrSlhlE+ImnCQrDwsmcFU9WlRU8JZDQGrEU3ue6yNzF7pI
         O3iUfvZP/iBQk0vaDtDJBZm0u55zmFgRytU65fnTV+zaujdXIPfz7BaVOSsONOurEJp6
         PpM4SLcnQOrjBwNMorqDVeqYKKIX9DGe0ReRUp3Xe0dDNT0sddf3fGR8OVnibncE57sO
         3Ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752695529; x=1753300329;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WylwH9udkWEirydfFpUxcOPjDX2jBvnP9PP0c6bnys4=;
        b=TG+WtXOWf0FwLjikcUZR4YzW2l2YNYfgSYXWS4yzEp4nuuWReX671iYAuGSmmESVIp
         KT0aMyf3yswk6hOrkk2dZ0xjl5V7B5vy2v7zzuJ/a3p1ZW74nV0V0IUnc+C4jFB8cp1s
         Rh79Jwwg7WsHeeUQW2QWGjVXgeqjlTW/YyV5q6nb9FL/YsZVb+H1zfS3/ZK22SmB1u1L
         cre022ZWHS5fBKMh7w1hnKp9IriIz19I8lJwPF12an6VnZbY951jiHf65m3mF5glj6wW
         47wr92Zj9dlesl3Ol+k0f+xRMbX24vI5iwOi8GJa/qygHNd47f7jHKfx3Iqbt/qrADFe
         cvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw4AleqoJbF7/hnU9FMx8RcKSl1aNfQj1QnsCe198joJJAXQ6M6C6tPvKv5kw4FjWzq8rErA2RkIdXD1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9kJme6aqlXiStfu908Q33EzhoFXhjzUMv/SZYJb98spUOHChA
	PbUV0gUoDKhhzyLDQTXFKp9eXO1CDFDWlXKacBRURxxlNLo14qX2Iy3WY3ZtgRvs1pw=
X-Gm-Gg: ASbGnctJkSVrZipViHv2gDg8QR6jesy3pjMvWLiiNS78DQ72Grfr4PFpS/qd6CztcpA
	uEDB1WiIOZnv8zwM0WX5pIt96sNc5YxgaTERKXjU3W2pOqZBz9dFQNAGdnCa0arfgg80uZKA8+a
	mx5K21c9+5VutlNh59P2WXLdVUXiVkE3BIDmTgCGRAFJIoO5wANwzJbCQzBAaDdOMg39K7r0MaH
	G2FJ/WtFCAXvqOeUH09BfqIRz/DDO4R6tewkDRpLFMPiidnbWf1O31QO8LidkF7BcRu0irEY2Pi
	12n3YlVZ9PFDmCspdDtKZD/j03fBjXfSqfOl4JEDxO1DhoDq855tSBjRS9IRgBIz4zbk96P97Xc
	aPR+UCEcKAiMRbbfAlIh0kZ3lAm4Ob+qVSVm+s76GqHQVEU4wwGD5ZpOUg5Sh/xqWdVcULk2vOg
	==
X-Google-Smtp-Source: AGHT+IGygX1TQGdl5nkgUTMKIPJDS7d+3SCAT5BWxK31nx9sZBIZYAxyDokvqQUYUkXglqscKniUyQ==
X-Received: by 2002:a17:907:983:b0:ae0:54b9:dc17 with SMTP id a640c23a62f3a-ae9cdd8605amr388186566b.11.1752695528420;
        Wed, 16 Jul 2025 12:52:08 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:a864:eb02:add4:d64a? ([2001:67c:2fbc:1:a864:eb02:add4:d64a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e9105csm1233073666b.20.2025.07.16.12.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 12:52:07 -0700 (PDT)
Message-ID: <7d8cfcf5-08db-4712-a98f-2cbfb9beeb85@mandelbit.com>
Date: Wed, 16 Jul 2025 21:52:05 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] PCI: vmd: Switch to msi_create_parent_irq_domain()
To: Nam Cao <namcao@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Joyce Ooi <joyce.ooi@intel.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Jianjun Wang <jianjun.wang@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Michal Simek <michal.simek@amd.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org
References: <cover.1750858083.git.namcao@linutronix.de>
 <de3f1d737831b251e9cd2cbf9e4c732a5bbba13a.1750858083.git.namcao@linutronix.de>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <de3f1d737831b251e9cd2cbf9e4c732a5bbba13a.1750858083.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nam,

On 26/06/2025 16:48, Nam Cao wrote:
[...]
> -static void vmd_msi_free(struct irq_domain *domain,
> -			struct msi_domain_info *info, unsigned int virq)
> +static void vmd_msi_free(struct irq_domain *domain, unsigned int virq, unsigned int nr_irqs)
>   {
>   	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
>   
> -	synchronize_srcu(&vmdirq->irq->srcu);
> +	for (int i = 0; i < nr_irqs; ++i) {
> +		synchronize_srcu(&vmdirq->irq->srcu);
>   
> -	/* XXX: Potential optimization to rebalance */
> -	scoped_guard(raw_spinlock_irq, &list_lock)
> -		vmdirq->irq->count--;
> +		/* XXX: Potential optimization to rebalance */
> +		scoped_guard(raw_spinlock_irq, &list_lock)
> +			vmdirq->irq->count--;
>   
> -	kfree(vmdirq);
> +		kfree(vmdirq);
> +	}

By introducing a for loop in this function, you are re-using vmdirq 
after free'ing it.

I can't send a patch because I am not faimliar with this API and I don't 
know how to fix it.

However, the issue was reported today by Coverity.

Any idea? :-)

Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


