Return-Path: <linux-hyperv+bounces-2810-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5295BEF3
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 21:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69E61F236EA
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 19:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803591D1726;
	Thu, 22 Aug 2024 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Q80JPWcP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D5D1D0DC7;
	Thu, 22 Aug 2024 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354971; cv=none; b=huMud2LxsW7IhzfRbFShc7ppl3ZG/tNvLct4aLGxH/4Ms/t39QDw9XTEVYjEMFq0uegmHRc/3DXm3sAYOOwGMCLHmw4gD3Tpbi8MON5r6tRBfdjJ5nlukCWmOzhR3zUNP83x2gcDTAngRfyi2OliElVQPCpZQULOim0uxIuBl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354971; c=relaxed/simple;
	bh=9ZEgusTWJU2HXLnzHir15+nHfQOEL9J2dmjPlBk4gZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kDgVgdBAyWKK2gVCJqtJJfHOWDkG2juaVCeYCuug5TytmDhz1CaxzBZKh7UsN8htL10qWQNTMFyigTYKaKPH21HBBS85PMAiqtAJpeNQAWCqsJX4UzqegmqdtJFL4ylqVeRMA6I3oq3loY2AGGkjTQZHG62zPBbbgWbUhOFlhiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Q80JPWcP; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WqYDT0MPfzlgVnK;
	Thu, 22 Aug 2024 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724354964; x=1726946965; bh=9ZEgusTWJU2HXLnzHir15+nH
	fQOEL9J2dmjPlBk4gZ4=; b=Q80JPWcPlkv2CO7rMQcOBV9cJQj4CxnH8yk4cRxO
	1nfR9UrEJAzCs41yxpGZg2MZWpK6InAbCRglO7WakUDR4dP6dMVqJMlaIINenVTD
	rGn+PuDbqf59N9yxrvJq0CyK9ZHs3XK2tYrmI9RKb70tVcS0t0cUwRx/dy1/rvZq
	Laar2dL9MOWAc4J5YUs/zfBnhh49UdXKCAIymaCND9Kba2legHFyDhYRbFUfCF4h
	c/w3qL6ZtGV7m5jA3NroU3bHhypV41Wshg8HYHB/+b1Ngm5XpizUduyPJgd2pz8W
	UNIB+/2P3SWRDWs+ITC9BqqXG0o0j1UgeU+KWsWuZTJ6yg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id itsm-lJJiOpf; Thu, 22 Aug 2024 19:29:24 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WqYDL0lXRzlgVnF;
	Thu, 22 Aug 2024 19:29:21 +0000 (UTC)
Message-ID: <f8bb65ed-cdf2-4d23-b794-765ce0b48a4b@acm.org>
Date: Thu, 22 Aug 2024 12:29:21 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
To: mhklinux@outlook.com, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com, petr@tesarici.cz, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20240822183718.1234-1-mhklinux@outlook.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 11:37 AM, mhkelley58@gmail.com wrote:
> Linux device drivers may make DMA map/unmap calls in contexts that
> cannot block, such as in an interrupt handler.

Although I really appreciate your work, what alternatives have been
considered? How many drivers perform DMA mapping from atomic context?
Would it be feasible to modify these drivers such that DMA mapping
always happens in a context in which sleeping is allowed?

Thanks,

Bart.

