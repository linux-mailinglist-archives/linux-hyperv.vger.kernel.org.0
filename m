Return-Path: <linux-hyperv+bounces-8095-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E101BCE9E9C
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 15:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA4A830351E2
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FEF2737F6;
	Tue, 30 Dec 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xzICqaiE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B0230BDB;
	Tue, 30 Dec 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767104344; cv=none; b=EKlnQacMu5CQp3HIPDaRQbklhOhmv8I0MZPc3OWaoOZ8aD+jDaLqawo9b8sdrfl06W9XNEPxROuVsyWEtQXHe7FsxVjhVjpM/kj6ju5WQ4nOVWKB3THBmdJkqXGb1hnyXHy0i8+vvVYOhUD+iUCTrFrp05LbYMYfqLjkSpK2+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767104344; c=relaxed/simple;
	bh=rKFcZYIOSRQEljLZ2ZBVcrOvhPRlspiwRuIG7WMsOhQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aDJElepyGh1WNFhBJxVA9Do2iToCqh87IUVA7abYac5cZ7Te3BpIzJ39tF6CCi39rCoKtTQS8YBYSLozqdWQamdtgXWWqSbMAebh+W13jJ9X7l+9A8pKIfaEJISxim1JBEQRLHf7KaMpeIhE+fQ0raEVhtkaA1c0ra0ABP97Hkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xzICqaiE; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dgZvk3QYcz9sxM;
	Tue, 30 Dec 2025 15:18:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1767104338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Me2Mdzk++Wkevd7TvsQ/aUQOMALuJOeq7xO2ZphjiHA=;
	b=xzICqaiE0j5M/BAdYnrAbOO6k6LCR9XBJXNfbI9g3D8Alz8TzkBFcuKlAhH7WD1K/E4FgO
	fTQ0ALxvWJ8ncrOKwJgDbPPkTI2+hflMsGXRAhxpb57PDA7tryPWlY9lilpaFADUEkRw5d
	ZbGfpR0vxC8++Vy+C17SJi9Xd+GhPESnO0Kuty6ApRLlJNlkhvxf8YdBHOTmS5CE29tOg8
	Z0ElIHXvzdF6xHLuxZO3aoatH+Hy+Qhck6h+dnIm8Izn8X0RVg5Q2mU3DXyKWqy0b8/VcE
	HICYHeGo0gvHnDB+UWLUcopXDkSdy3rjA9RuBk9AwXfR9sqNfgbSDS1aixSV/Q==
Date: Tue, 30 Dec 2025 06:18:54 -0800 (PST)
From: vdso@mailbox.org
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: yunbolyu@smu.edu.sg, kexinsun@smail.nju.edu.cn, ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>
Message-ID: <1647289009.63012.1767104334567@app.mailbox.org>
In-Reply-To: <20251230141414.94472-1-Julia.Lawall@inria.fr>
References: <20251230141414.94472-1-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] Drivers: hv: vmbus: fix typo in function name reference
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-META: 3dz6hfw4n8yro8o5nnx141ega54965i6
X-MBO-RS-ID: 4d588195b6dd7b070ed


> On 12/30/2025 6:14 AM  Julia Lawall <julia.lawall@inria.fr> wrote:
> 
>  
> Replace cmxchg by cmpxchg.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 

Reviewed-by: Roman Kisel <vdso@mailbox.org>

> ---
>  drivers/hv/hyperv_vmbus.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index b2862e0a317a..cdbc5f5c3215 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -375,7 +375,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
>  		return;
>  
>  	/*
> -	 * The cmxchg() above does an implicit memory barrier to
> +	 * The cmpxchg() above does an implicit memory barrier to
>  	 * ensure the write to MessageType (ie set to
>  	 * HVMSG_NONE) happens before we read the
>  	 * MessagePending and EOMing. Otherwise, the EOMing

