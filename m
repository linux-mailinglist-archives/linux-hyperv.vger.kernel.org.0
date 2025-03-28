Return-Path: <linux-hyperv+bounces-4720-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C83A74C07
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Mar 2025 15:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E1D164936
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Mar 2025 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8693E189B8C;
	Fri, 28 Mar 2025 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cuElf3qy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xDRiVtjh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078AF188596;
	Fri, 28 Mar 2025 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743170719; cv=none; b=mmVor3o3HiZaqac6U+pltuZ/UJqJ2rzDbvgChgZWIg1SpDhGCtcEq9AeshmnWOjEJXPk4SfbF8/elk1ewnhmnhHJg+rnSbm7isqBvKEbYPS1MIBu9pNFzj6etrG6tCu1Q2XwxB6ZuJSRt+dAmzA7BNYDdKpj0cyX1Yp8sMjsA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743170719; c=relaxed/simple;
	bh=5cWOUCJIB4lTLougmiAzw9dNcnD4w2lCeNgwbw7TZlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YQYQj+RM8/D3iLSdvVbL17dwI5fFuW1vu4YpKrmy/SjwTd8K2o/kPFU6U80wn4xH4kpvKPB2fSJxlNTua9hx4oSL29Ky0rkRUWFojp/YQZfB74lWYeaT5dQYt7i0laomxPNEKoS0hF/P6NXxG/4mPoA5tYsfgbqVWBlxIHSHbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cuElf3qy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xDRiVtjh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743170716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I6YPLumZITzzLekUQIrMxuZMrWTUi05abn63fn/MC7I=;
	b=cuElf3qyttvW4wTy4V6qJdF5j5h+TM5XurS3EXAepHolGiOyFnpWcic30E36tT4Z/+Gqjd
	kLXpq9Q3DotesvCWbw/tjgTxdDR+XYIKga+cWXwhQ8G2ZNLWU1e2O25yt4cl1eIl8Gos0i
	231Oaao887seYBxeYMLMRFpkGDsHl7HVtWVHhzdAEAGkJFfyazP52KCNxcWSHbOcZ/C4lw
	RZdqMZDdoDd/9/hraP0cCAU/WQBqaiFwC4hiz7Cfj3fllvnAEdqgvoitLrOg9yJvfEVH3Q
	3g3dB6oB6Rz0VbE6+zQOYqNKZ3NjyBrQVTdrSsEUu80VLNxzl22jTV043eZWpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743170716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I6YPLumZITzzLekUQIrMxuZMrWTUi05abn63fn/MC7I=;
	b=xDRiVtjhHlcJcTl1CHzPR82ZJR7hGxj3A1wnsDyEc1fjIarLfVZHyZxJ13IgBYnEhnGD6b
	IhVV1V4MUT/mmWAQ==
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "James E.J.
 Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Nishanth Menon <nm@ti.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Dhruva Gole <d-gole@ti.com>, Tero Kristo
 <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Logan
 Gunthorpe <logang@deltatee.com>, Dave Jiang <dave.jiang@intel.com>, Jon
 Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>, Wei Liu
 <wei.liu@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 linux-hyperv@vger.kernel.org, Wei Huang <wei.huang2@amd.com>, Jonathan
 Cameron <Jonathan.Cameron@huwei.com>
Subject: Re: [patch V2 09/10] scsi: ufs: qcom: Remove the MSI descriptor abuse
In-Reply-To: <f0df759f-42b2-450c-90c6-25953093e244@stanley.mountain>
References: <20250313130212.450198939@linutronix.de>
 <20250313130321.963504017@linutronix.de>
 <f0df759f-42b2-450c-90c6-25953093e244@stanley.mountain>
Date: Fri, 28 Mar 2025 15:05:15 +0100
Message-ID: <87tt7dw8ro.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 28 2025 at 13:00, Dan Carpenter wrote:
> On Thu, Mar 13, 2025 at 02:03:51PM +0100, Thomas Gleixner wrote:
>> @@ -1799,8 +1803,7 @@ static irqreturn_t ufs_qcom_mcq_esi_hand
>>  static int ufs_qcom_config_esi(struct ufs_hba *hba)
>>  {
>>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> -	struct msi_desc *desc;
>> -	struct msi_desc *failed_desc = NULL;
>> +	struct ufs_qcom_irq *qi;
>>  	int nr_irqs, ret;
>>  
>>  	if (host->esi_enabled)
>> @@ -1811,47 +1814,47 @@ static int ufs_qcom_config_esi(struct uf
>>  	 * 2. Poll queues do not need ESI.
>>  	 */
>>  	nr_irqs = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
>> +	qi = devm_kcalloc(hba->dev, nr_irqs, sizeof(*qi), GFP_KERNEL);
>> +	if (qi)
>
> This NULL check is reversed.  Missing !.

Duh. I'm sure I've fixed that before.

