Return-Path: <linux-hyperv+bounces-3878-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ABBA2F5EE
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 18:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D212C165C0B
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 17:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636B52566C4;
	Mon, 10 Feb 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDBkQNeS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71DA255E24
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Feb 2025 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209989; cv=none; b=ujrf3863InEZpRDdpJinEqMWPSCcwSIrgwRZxK52tjjfrlvtlBiT2CHf143z7iTnjJylkbfd0Bybzf1kDan24y9SjoHSBf1/zIzbfKHEaICaYkNOMG/c0cuw31pzYtWY/OlzQlWMiXp+P+liQqsxKk0E5W1utRt1Ojkk+3QY3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209989; c=relaxed/simple;
	bh=U+YQ5PhZVcxOIzhFI+20sedITuhk+41a7YpPgwQM7HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3/qXU4m8PgagLjlsAe6jdplUqvPGmGBULtA5HQxnzerlV1HXt7iB3KAUTP1JL/ZTPBuRL/hzLvMzJu6X2myyHuyrj41x0j3yui4HHjxFtwxSLQDIs+A9qgpKiV/SNLwET/FuENmJT4Ez2ddCjflrPHh9+llXB2kTjMDnzw5SIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KDBkQNeS; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa8ada664fso1371740a91.3
        for <linux-hyperv@vger.kernel.org>; Mon, 10 Feb 2025 09:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739209987; x=1739814787; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LGsMNA7hkuFPRoTb9bXf92iX6DhOUuWxNMoqTKxh3jw=;
        b=KDBkQNeS3QfNzmRGRZsNWvNWBJiQhiBPXYbbiF9ipG2ZPXAh5CZ3hmbytZ+4eX8SYp
         xLZRE1sh+aJkqb075+yIxx+7UR43dWa/pyknWkf6MkJe80QzMumX3ky33M8v4P7AiwQ5
         QQ4o/AYvthZCSwKis7OmhBy4Pm2iZ+Dxil2u7p/fKSdMgqwsO21ypPrDa6wxpBui7AeA
         TH0lSsyQq7QCIcNw4IXTwzHJsHz+kZbfEbAnivhM45xpKHP2WBGjJBjcoxOEHpifbWM6
         YYpNjvzBxGybdovKXZD1Sq/4QWHYLGKxb0S4RIso/hsOtzQzE3C+N+h5TZ8F9b0YfFMg
         Z0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209987; x=1739814787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGsMNA7hkuFPRoTb9bXf92iX6DhOUuWxNMoqTKxh3jw=;
        b=ObapBfqpx+B8UyYXjNCP+TMmSh6sMQP3BInMmxo7hnsFVZUNJ5iOBwF4HCN5V0CnEK
         vlzwNxjo7gy6KgHXxm4ybi5225XH++Ir7cQaPSijvsN+eFnXkzjqsp6qVr7/Q7iw2iEE
         BsGLEJbW8+ptD+p1Q4zGYQfNnqqm57tjdKgD1HO+O2SrEb6IlcUGOvDTCDIBuu6Ljres
         8rPbhOj2t1Q19qvAWG8Azw64RaULQ8T9AAJg8qIOL7Lgc8Mt7FqOlSfpXau7EPjupi2q
         yRnw5TZ1inXERwqd3+bXp/6lFtN+9R0gN2V6f/kFJhwlskU2oLu9d7AcPf/qzpKRrgVL
         Xz9A==
X-Forwarded-Encrypted: i=1; AJvYcCXI7Wf/3IRpboEbXLoGogF5ooY3gD13lzEe93kHX5Yl3tAWZHAh+yEmCY9HKBvoA14x1v8e9y9cywgpPg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFCSmKapLzJReArUPYLYD/cBBZiwCwsNjmzX2OiIa4qJ32en+O
	j6OUO4Oo382pzknRDNbhIQIxbYg6XMimbtkWTbfXRAUoI59btsZu9pr6xI0DKA==
X-Gm-Gg: ASbGncuC3A1hNEB9p6Roog4YH50ITKwbgekN/s8DOwav+363b81/h718pgkHlJ+Mm7H
	hhHO7vUSoweUtwBV+U5YBZgaKoA9FhYsMgOFhkNZrHuMnpx/oJafHr7Vg2VXmAtZ0CbqcbwyJ1g
	0rQfGmM0bYkFECjFcJ9ztAwP5MO4Vp6XkRJS8AtxU9VgG7Gf3wvjEty+uLoy+QWPVj6b8VB8sNi
	8AjGV91MY9XB1Wc+Qp9YeKPe05zApEKY/5BNYsGjzs8zXCvWCjV7hsVQOc0gJ6DqWnnsK5sFBzp
	blJanqOWBPU76IhfHaXy+uViRMbv
X-Google-Smtp-Source: AGHT+IGXtPEY3mjc1Vv3Gaj+GWe5Fs2qY7xOB5/6dE0Jux/iJmgud1Xfm7AdIWKZQ7mORD5U/TLpnw==
X-Received: by 2002:a17:90b:3e8a:b0:2ee:d96a:5816 with SMTP id 98e67ed59e1d1-2fa24062e1fmr23566047a91.10.1739209986903;
        Mon, 10 Feb 2025 09:53:06 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa099f4d6asm9079409a91.6.2025.02.10.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:53:06 -0800 (PST)
Date: Mon, 10 Feb 2025 23:22:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Hyper-V/Azure@thinkpad.smtp.subspace.kernel.org,
	CORE@thinkpad.smtp.subspace.kernel.org,
	AND@thinkpad.smtp.subspace.kernel.org,
	DRIVERS@thinkpad.smtp.subspace.kernel.org,
	"status:Supported"@thinkpad.smtp.subspace.kernel.org,
	PCI@thinkpad.smtp.subspace.kernel.org,
	NATIVE@thinkpad.smtp.subspace.kernel.org,
	HOST@thinkpad.smtp.subspace.kernel.org,
	BRIDGE@thinkpad.smtp.subspace.kernel.org,
	ENDPOINT@thinkpad.smtp.subspace.kernel.org,
	SUBSYSTEM@thinkpad.smtp.subspace.kernel.org
Subject: Re: [PATCH v2] PCI: hv: Correct a comment
Message-ID: <20250210175258.pwaqr3dqxstcjmui@thinkpad>
References: <20250207190716.89995-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207190716.89995-1-eahariha@linux.microsoft.com>

On Fri, Feb 07, 2025 at 07:07:15PM +0000, Easwar Hariharan wrote:
> The VF driver controls an endpoint attached to the pci-hyperv
> controller. An invalidation sent by the PF driver in the host would be
> delivered *to* the endpoint driver by the controller driver.
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---

Where is the changelog?

- Mani

>  drivers/pci/controller/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 6084b38bdda1..3ae3a8a79dcf 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1356,7 +1356,7 @@ static struct pci_ops hv_pcifront_ops = {
>   *
>   * If the PF driver wishes to initiate communication, it can "invalidate" one or
>   * more of the first 64 blocks.  This invalidation is delivered via a callback
> - * supplied by the VF driver by this driver.
> + * supplied to the VF driver by this driver.
>   *
>   * No protocol is implied, except that supplied by the PF and VF drivers.
>   */
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

