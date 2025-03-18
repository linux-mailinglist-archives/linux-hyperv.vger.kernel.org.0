Return-Path: <linux-hyperv+bounces-4574-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB00BA670E2
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 11:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FE53AC677
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 10:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8468514A4F9;
	Tue, 18 Mar 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoMk7LnY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4341FECA7
	for <linux-hyperv@vger.kernel.org>; Tue, 18 Mar 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292809; cv=none; b=jRgc2aB3KfecaaHfX79zg6AMj/opCBxQWgBrvnCBwtLKoQSknvw48Dzncd7RudkMyqjNauVikoh1Bn8FFUHmbcvZvwWU9a18vg2h3lmPDch3KaoXl93Bum39p5qP3GxLTcI94/9yRGlg3UtCVbhceQdI52FTDiTrHkov4LPhaSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292809; c=relaxed/simple;
	bh=bTXyPUX/nTogcTrzO4w+0DnzKj6GcEsE6zMX5lpp/T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRRD+Mrb87PAge4goUPB3eYhG3Zzyv5p5qf/YVX/2EFo8/r+eIhQUzxc1Ete6dFS+S80zDUVg7STUI6HLiwao7avma2Zd+wiEItgRCubXrOrohTHQX20Ui9KlSgCBXW11CyH/wLoLSwSWIK3rYNy3DlKB3tckrymFGrHa72OVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EoMk7LnY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742292806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTXyPUX/nTogcTrzO4w+0DnzKj6GcEsE6zMX5lpp/T8=;
	b=EoMk7LnY6HviS1hDW6XZDFYDt1YdckxHrPa+MYlCKB2n/XRCkj+eDHidbzU61JeNhA7cPo
	doVOenADe9JZfYwC/n+ngBoW3kxUXMTfwM7dXCd7OMSKwtMwUWOj/T4+Fn0RNrYQiDmuo6
	li02BtoXfr8xLB4oiEQo7rNBcriPKNI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-BtjdBmz1On20biau_QlekQ-1; Tue, 18 Mar 2025 06:13:25 -0400
X-MC-Unique: BtjdBmz1On20biau_QlekQ-1
X-Mimecast-MFC-AGG-ID: BtjdBmz1On20biau_QlekQ_1742292804
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so15410935e9.2
        for <linux-hyperv@vger.kernel.org>; Tue, 18 Mar 2025 03:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742292804; x=1742897604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTXyPUX/nTogcTrzO4w+0DnzKj6GcEsE6zMX5lpp/T8=;
        b=EhISKnNoi28rbIOfkJD12HD+DM9Gqip3MyobpI7D7qSAUwRF4t71Vg+x7M3iti6n/t
         0b54ArdPYFV1fiMuZ/kd/vydHDtnk7gy/7/3gurQaiktI8LvIItOzP7TjESIV7B3Gq/m
         YwvpM5Q0fmoSvhnIHL4hq8EIDp6diwObSTTmHzdusDmLR3FGrTw6b0nKOUBZhN+ggu4v
         e2WDpzJmjfKbK5iPsgvi+nvwH4fEcGF7IlwxKWYlG8kL5sRtdtTfj9KnAZct36fUzn1F
         kE1fB6qlkQCSsLFO/6Lx4UGXxWch6dAa3bGOvJEpnq3Bf05rEbIQ6ypsNMBf7CTWpOHn
         IcKA==
X-Forwarded-Encrypted: i=1; AJvYcCXVfpu/XEKNHq39PyPfwj+p+p05ijDtus/BxhWSN+wV9kVy22LSaHBTOnXuLwnG1BWyq/2hWl6ou4TVQtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmGdO9ajbK2KpkVxUFzepe9EB1dWmgIveSpo8a8YMklvtd/t/
	iOM+p/9IsYGg6A0uLb6H3svubidF1a8mrqda0MNhJlYfd0L+Zbth0KHaczq0Cp42oyUT3Tb6EbI
	HjFzy8y0zaoDF/rOQnkgvIj3bgRaFe17JaT5X2i24TKCk40ov+AJfmsAUKYBtgw==
X-Gm-Gg: ASbGnct3//SI/kfx3VH6MWXXF4ImEsLb6A9Sq1y4tgTAwI2ItJD2QhY8RpJWBkrKo6f
	VzvMVL2VhK4eK0OrYrRq+5AhgSuU10VjWmIiQ4bpXvDg8BAlkIdB/O8aInt1/CXRgRNtiYsYX/M
	2vBvYTqjSFYfVqaH5nUdqgvIe0TK4KtR0ZG9hiBhYoZU6HSKiz5uqmH7CR2rIQy7LzDAzPCvr4z
	2G0IjYs/f9Fo2YUK9w1AoEmZnXzE6XnfZVDdKzs2Wws3mOxpOxMr+YXkmuMCeDyBMBDYN33cGBq
	I/PdQsC4J0vPIOEaPpFCYtYeLQ0LLHgMYdc1qdKxjqR7hA==
X-Received: by 2002:a05:600c:5112:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-43d3b9cd704mr14645065e9.19.1742292804460;
        Tue, 18 Mar 2025 03:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa2x79C78ENEoyzPPniqeGCkHBce2M9I0jdc1yv0/RSaEENBZYufXun9PO4beIARs4YqnHHQ==
X-Received: by 2002:a05:600c:5112:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-43d3b9cd704mr14644695e9.19.1742292804010;
        Tue, 18 Mar 2025 03:13:24 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe609dasm129105475e9.28.2025.03.18.03.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:13:23 -0700 (PDT)
Message-ID: <6259af5f-f518-4f88-ada9-31c3425ce6ed@redhat.com>
Date: Tue, 18 Mar 2025 11:13:20 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] net: xdp: Add missing metadata support for
 some xdp drvs
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org
References: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 1:18 PM, Lorenzo Bianconi wrote:
> Introduce missing metadata support for some xdp drivers setting metadata
> size building the skb from xdp_buff.
> Please note most of the drivers are just compile tested.

I'm sorry, but you should at very least report explicitly on per patch
basis which ones have been compile tested.

Even better, please additionally document in each patch why/how the
current headroom is large enough.

Thanks,

Paolo


