Return-Path: <linux-hyperv+bounces-7600-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B950C5F5C2
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 22:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B74D6354F67
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5A43557E6;
	Fri, 14 Nov 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XBRab1Gz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB11355050
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Nov 2025 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155629; cv=none; b=BOTFqMyI/4xQfEsbciqBr4PZUbZ3cVlLClakbAcqxFiNswXoBAVx7OcePOQBptVEyKhRxnZysnOZdA/qhDZl8LAPUo4vyoSMdMtpFBGOlVQvJB0gXHsSbMPPGbvVvckC3xs8XlOhaH1IiIvG+xmrmB8fKeEVz/6dLFkXlfgWJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155629; c=relaxed/simple;
	bh=QG4Es2w8z9zPw3criN/guc3OygUp38fxeJgv/o1q7ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyI+1gFBCN4boflas87t+2pEqwxY+BeN5LmPVSCYNNWpeIz9J/ovakCdddZ0Ukjwp/aXqJM20RKLFwPvZrydkp9HZLOoD+DdurcGFT/WJaOlNkUnWmdJEIe6vcLTRbkxMA/cCFW+bO50aHcJc13tMT8ew0sZlg6fI8zUzmWtyxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XBRab1Gz; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88054872394so29760166d6.1
        for <linux-hyperv@vger.kernel.org>; Fri, 14 Nov 2025 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763155626; x=1763760426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG4Es2w8z9zPw3criN/guc3OygUp38fxeJgv/o1q7ZA=;
        b=XBRab1Gz2RfOIXR7tBrgmh3nGbWB9nD53agu2Ftb7dJ+E6ujGcekcqNz/WfGQcElR1
         JPoshaM3z33zraDvGJ+ACFiukA08zFTEaR0xfndM9gUSUHg9Zs5BQpPQmCn+rlRr5RoL
         +HbcMVTNFh9NUnQ8QYgXpxTd00G1onwclWFt+mTdURK3IQPhRknMwrisGKHWi/MsFWXy
         jA5NpNvuuFz+muixpaYsuX6DT0cS1CY3lOcwFFL0Rq74qeEvPO9xATprJVc6zzJKQAj7
         tPwVb5dyHeWDIbeDVck87WCY/yneLJlXgxVw6dyllbnhJfH75kBVX6IFj+p+Zg+TClod
         lucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763155626; x=1763760426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QG4Es2w8z9zPw3criN/guc3OygUp38fxeJgv/o1q7ZA=;
        b=foxP899AmKfV/42i94DmPmo6SyBwCVovZnocM/KP2aEMPWEiQt/4WcrUaak002CxLr
         HUmHsqQ8hTAIePe7THJa9zFa50yv2R/UF0iTZOx+l4A93wIHgPerM5ZXpxHp5VCoWbjy
         MlD7haGtueGERIgIrSTF+tHiEqNLUn8HbXy2UfhXB5pcD+Siunop64dVdYm1XqkL2+0f
         FzegI0GQVnK4g7W8c8TL7v7joFb3C472G3cBhXhsnGepfBqeUfacPcj/AXUaFo4ZoJb7
         Z9UmefraOHKb5JoGAwinhIgLFE9aML+k8ZbhQLwPv5fWQqXk9JNDDUjRiwHArW6fefS3
         pUGw==
X-Forwarded-Encrypted: i=1; AJvYcCXU2jGVTTaFtSODVfdbQu/Jaz0tv6vM1+tYaNPO3TCBpj2iRsdim+JChJDqKwXeYkszEtfqVRRYiUcpSb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcRr1uAdj+KC1D/W/pLgZZIm3Mf2l/E705V4M8Yp/+zTb2Y/Ve
	EbdZLo9kGOwYRdTDl7HXCcfU/M7lxkTolSGhvU/bjOU9ZlNKueK6KIHbfQsAY9m7Zov4QxBIaSL
	ZtcPAKa8ZG7dxwsDIBdyommFLpJXhJf3Vu5QFo9Fw
X-Gm-Gg: ASbGnctMgqA8EHi2AxEQTztEbzXrkwIdq9sy+2XjdRXN9K6hZIEeV6fJV4HR0D3CRla
	LwZbHIv9gAuB5LMsvNbML/WAcxZ6h2A1Fl4g5oHUORQz4xnnSacBpg84/cuehUt1SSrVOOpXIjH
	vh0zJVj0F6Wms/zlQTrmPzOOCGmLnMEBz64J0NCvPdOXrs+mOqmf2w5oZcngAuhC5d567RsL61T
	kyu9mDsRGzbibpyENaQ/ypxC0Z5OfyNc7AAg8aAJi18TAJ/eHq59PsAVhwFdA99QJWqMpmj+hUd
	1EXh
X-Google-Smtp-Source: AGHT+IF3yLklavyN8Pcb94PUlW9cqsca5TJcoW99dOtMjSKrJX8ajAa8K+KxtyAU6uN1Vxy/12p9PoNJt7YaZeBzonE=
X-Received: by 2002:a05:622a:11d2:b0:4ed:6601:f46 with SMTP id
 d75a77b69052e-4edf214c22bmr65252631cf.82.1763155626264; Fri, 14 Nov 2025
 13:27:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1763155003-21503-1-git-send-email-gargaditya@linux.microsoft.com> <1763155003-21503-2-git-send-email-gargaditya@linux.microsoft.com>
In-Reply-To: <1763155003-21503-2-git-send-email-gargaditya@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Nov 2025 13:26:55 -0800
X-Gm-Features: AWmQ_bkfwU3Z_aDo9USrVKl7Sexf58jA89bz0HEBOPCB70sLve8OaRqjFD38xwU
Message-ID: <CANn89iJotxTiQQwEJbtRbkAa0XYkuyv4z_La7WjYHQDvon-miw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com, 
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com, leon@kernel.org, 
	mlevitsk@redhat.com, yury.norov@gmail.com, sbhatta@marvell.com, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	gargaditya@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:19=E2=80=AFPM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
> per TX WQE. Exceeding this limit can cause TX failures.
> Add ndo_features_check() callback to validate SKB layout before
> transmission. For GSO SKBs that would exceed the hardware SGE limit, clea=
r
> NETIF_F_GSO_MASK to enforce software segmentation in the stack.
> Add a fallback in mana_start_xmit() to linearize non-GSO SKBs that still
> exceed the SGE limit.
>
> Also, Add ethtool counter for SKBs linearized
>
> Co-developed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

