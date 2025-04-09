Return-Path: <linux-hyperv+bounces-4851-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6579EA82F06
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 20:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F0D464CB6
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 18:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3A327780B;
	Wed,  9 Apr 2025 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z138jOEi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yGcKX4VE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A726277803;
	Wed,  9 Apr 2025 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744223897; cv=none; b=KMcY427w+RiygYqcDUkC0E78eZ/JMXtuCh26TFunHhxt/RgOPfsbr/JhNFuEmg4pq88ERO06fDqwNCfRNTc/mJelJKkDWNzXP786d3/HMqhZJ15sRp7QCQMOEDWf/tCSvSw27N8+AxpVjR0JHq3qp0PTjsaJC6cmdunA6fk5T28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744223897; c=relaxed/simple;
	bh=wkJmQ0LHsCsUtHI9UBEPI0vhuLCrr2rxuBjR9icIQcs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cZjABaYnF7UnlHFPVsXkGrC+JEvJL8FZ76uVWt/ugJVu/m/oa6RuwsiSVnrE9dQXbWng+QHtUsergYTjeHWt6C0ZdQhGpF3J1cG2jQu+y6i5Is2DXmh1P1MLvG8SdvsMqimPLLdIIy0JexM+9Cht586PNAzJhsCQllx3WcH5iYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z138jOEi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yGcKX4VE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744223894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49q1a+kYKWjSd8TWGs4RO1IJ6caZ6fyRNIBslPhdoRE=;
	b=Z138jOEioFdI1qI0m5UY85wvk5npoGL10CAA4PvItQJcktamR4PXp4YhWkOXlFkTdNNDHD
	fkt5D6QzDYfns2L2PJECZM1FKoF75MdHW+PMVzAL7HOi/4bRjWjMozFQXJ2HuU1HmPGK4c
	uC0R1lUn8LEoP09J1qq39oM2ZvSDzy/Ttt6T1vklq3I2Bw/+Jo8fOmyooYZBqbi3YTaWeg
	GTiEzTJW4yUj2xBCsfnNVmhl4oPFW9jKIIcO82xZVdpzZX63KtCTHDL3Z8v73LPUb22rxE
	yVBw4SbZxyi44eojIHy2GKOM+oj5HBPX1uKZQQbijNdi8Wy2/Gxyghty1yNPXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744223894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49q1a+kYKWjSd8TWGs4RO1IJ6caZ6fyRNIBslPhdoRE=;
	b=yGcKX4VE8nKbLL6+B5iTAPSW724cfBG33dhEGD21zWglG5VWvjasvE63YXu8IQe6Ht61xH
	yy52wE3e4pt5XKBA==
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Bert Karwatzki
 <spasswolf@web.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 Jonathan.Cameron@huawei.com, allenbh@gmail.com, d-gole@ti.com,
 dave.jiang@intel.com, haiyangz@microsoft.com, jdmason@kudzu.us,
 kristo@kernel.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
 logang@deltatee.com, manivannan.sadhasivam@linaro.org,
 martin.petersen@oracle.com, maz@kernel.org, mhklinux@outlook.com,
 nm@ti.com, ntb@lists.linux.dev, peterz@infradead.org, ssantosh@kernel.org,
 wei.huang2@amd.com, wei.liu@kernel.org
Subject: Re: commit 7b025f3f85ed causes NULL pointer dereference
In-Reply-To: <00f865af59f3bc3b31164d9105a75c01666a8f55.camel@HansenPartnership.com>
References: <20250408120446.3128-1-spasswolf@web.de> <87iknevgfb.ffs@tglx>
 <87friivfht.ffs@tglx>
 <f303b266172050f2ec0dc5168b23e0cea9138b01.camel@web.de>
 <87a58qv0tn.ffs@tglx>
 <00f865af59f3bc3b31164d9105a75c01666a8f55.camel@HansenPartnership.com>
Date: Wed, 09 Apr 2025 20:38:13 +0200
Message-ID: <87r021tc2y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09 2025 at 08:49, James Bottomley wrote:
> On Tue, 2025-04-08 at 22:46 +0200, Thomas Gleixner wrote:
> [...]
>> -	retain_ptr(dev);
>> =C2=A0	msix_update_entries(dev, entries);
>> +	retain_ptr(dev);
>> =C2=A0	return 0;
>
> Heh, well, that scores -6 on the Rusty scale "the name tells you how
> not to use it" because retain_ptr would commonly be read to mean the
> pointer retains its value.  It would be nice if KASAN had compile time
> markers that would cause a use after free build failure for this, but,
> apparently, it doesn't.  The cleanup annotations don't let us remove
> the scope free function, which would otherwise let us match the use to
> the name, so I think the name might have to change to something like
> retain_and_null_ptr().

Yeah. When I saw it I immediately rumaged for a brown paperbag :)

