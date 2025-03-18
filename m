Return-Path: <linux-hyperv+bounces-4573-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB7CA66EA0
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 09:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE0F1887196
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 08:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B459F1F5822;
	Tue, 18 Mar 2025 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GVpkqIjj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Z3jihJq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934F1F09BF;
	Tue, 18 Mar 2025 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287251; cv=none; b=tiYeBfVoznuOK0bApp1g/FGNtWuXaxuHmdr1v6HYfUtxSPI9AefGlGmz7jMiksG+bhm6DUsvAus9MZF6Qh2FQTbwuMKz3N4/7c0zLKY8SNEgOtDR3mfqd4K/4LnNlX43nvWNOROmd8uc8nT97RHBSDuSPcFASjB6rlV7Glp+SY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287251; c=relaxed/simple;
	bh=00oO4NJygkGCwvYi+iixq/x2rxibsNa7ZjTK2XrnEVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WV0baxHZ3cXetGiaUPUG+lSn24i8FrNylqjejIlosvLSRNllsWCtmbe5CKbgEWWiX5S3ay9mvrtbM17bZqMzZz7i2Qq60la7aCgLMoZpZYC+HWFBZj0Ep5Iqsl5s3y8JxKU/UwyyecNEel4WvabwWg7U1xuW3tFtMuFXcYM7Vo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GVpkqIjj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Z3jihJq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742287248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6tlA+JIwmYuDSDTpt3KpVNqXfTV+Xj+SxXbNDkR7Eo=;
	b=GVpkqIjjN6pplIKKz3DtpUrvXd6vng+yCYaUQV0qtCh2wquejtcTVEz5qY0Up+suyNBS8U
	EH7R9fjjbPpGEev+5eVaFDYXi2GzXGaOAckMZaB2Y97TO5oX+nALkZL4We8Y3mawQAuO9y
	zWvQhoIARQbbWJfeE53s8ByfQ/4A/mbvbLx758CUGZE9h0cdgUzFAORuYFXSBV6GjoUcsN
	/suYjaoKU/qRbWli9uUZeK2bqtU0RRX750Q8f1R56n4m9RkoVCvELRBxPtYCowQXUe4HnX
	xTmJ5KO+3HH081prjXYP/W4gTTYfgvUiRrFNTtXCmBR0VUo8VohPKnT1fsqqWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742287248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6tlA+JIwmYuDSDTpt3KpVNqXfTV+Xj+SxXbNDkR7Eo=;
	b=9Z3jihJqufUIje0s3LxBI2+XpLO6aDR57YFV9aliuzjtdSgdEGdtRQCUWAfKBLIJZdj6Ma
	NQzw2N8u24dR5eBg==
To: James Bottomley <James.Bottomley@HansenPartnership.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Nishanth Menon
 <nm@ti.com>, Dhruva Gole <d-gole@ti.com>, Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Logan Gunthorpe
 <logang@deltatee.com>, Dave Jiang <dave.jiang@intel.com>, Jon Mason
 <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Michael
 Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org, Wei Huang
 <wei.huang2@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [patch V3 09/10] scsi: ufs: qcom: Remove the MSI descriptor abuse
In-Reply-To: <609eeb873fdef6171c71f3beda289d799cb7172c.camel@HansenPartnership.com>
References: <20250317092919.008573387@linutronix.de>
 <20250317092946.265146293@linutronix.de>
 <609eeb873fdef6171c71f3beda289d799cb7172c.camel@HansenPartnership.com>
Date: Tue, 18 Mar 2025 09:40:41 +0100
Message-ID: <87o6xy4tpy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17 2025 at 12:26, James Bottomley wrote:
>> =C2=A0	nr_irqs =3D hba->nr_hw_queues - hba-
>> >nr_queues[HCTX_TYPE_POLL];
>> +	qi =3D devm_kcalloc(hba->dev, nr_irqs, sizeof(*qi),
>> GFP_KERNEL);
>> +	if (qi)
>
> Typo causing logic inversion: should be !qi here (you need a more
> responsive ! key).

Duh.

>> +cleanup:
>> +	for (int idx =3D 0; qi[idx].irq; idx++)
>> +		devm_free_irq(hba->dev, qi[idx].irq, hba);
>> +	platform_device_msi_free_irqs_all(hba->dev);
>> +	devm_kfree(hba->dev, qi);
>> =C2=A0	return ret;
>> =C2=A0}
>
> This does seem to be exactly the pattern you describe in 1/10, although

True.

> I'm not entirely convinced that something like the below is more
> readable and safe.

At least the cleanup wants to be in a C function and not hideously
hidden in the DEFINE_FREE() macro.

Let me respin that.

Thanks,

        tglx

