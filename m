Return-Path: <linux-hyperv+bounces-2515-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC5491E9BA
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 22:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF64DB22330
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 20:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68EB16F8F7;
	Mon,  1 Jul 2024 20:41:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B26118635
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jul 2024 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866464; cv=none; b=QRy1OQajr0kH9lG5ePkswHbJR00SSdVMhdJDmzr5F+WxAEmYURLR19aNUyNbGgjhN5445g9+f291GDo61F89cNbhxRIqtzYCWesl11cANVjCDVodIrvj4lpT33NDEbLi2AmssjG3fPmQW2ecuQrQLq69SP4Na7sp+HoohsJznZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866464; c=relaxed/simple;
	bh=d46KvdNM1JqGAES5GIMyGyhljx64kguHblTlHidsmt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Enl4zv6e0/UxUSiTQH+1cpZ4KYftgeOv7adN+t41HIlI5bf1U4pm/QTAoJbMVjDly/y7KM7Pq497NL7Q6itUys2bevJOmhbscHIH80g5JgYk9XRBxJDiAnM+/HJIVEoNI/67K/GQD5czUpWO/GZQOsW+N6qTOqrm81ZmJ/h9IJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70683d96d0eso1996549b3a.0
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Jul 2024 13:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719866463; x=1720471263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2bKCHCIU9uxRjmtNJcMwwC/C0BsqQ7ts3T7Rf4hcL0=;
        b=VEf3+HQY4/ygWhf796yxEceUnjtkaLlZ1oRNCkSwUI2JUfzGI5VOZ6u5Ye366rCPca
         ux9mUhvG0dkhqXSxgL6sX1RDgW/5KzhQVrG2RfrgYbuUx1BTOKjxmERdfe4YuHC6Co34
         uHURUuR9zGKe1lkBeSjPPFhyPvbqhvmEeN4pJA4ysThOHbJZ+1bOtL9ke3b7K9EuCX4Y
         C+D+TB1vj+ApHOTmWmvcovoj1J01PWz6nShFyN4KydW1JuiQaOFV18Wwdu23acD71+VO
         Hbs0ArJU+VgM664OZy4lTdlfDt8keMjD33kwf8FRqHBxuP9WMigkqRfTxyKAK5qE7htD
         fhrQ==
X-Gm-Message-State: AOJu0Yzrisq7Vqgu62MSj654Sj3NzEXAkTFHFvh1zL5QNptwwiurQ3nF
	2kavCIOiEiKfSe0MECBOVQZGMWzZ3a1XYRdh/BB52bSSH2TUQD55
X-Google-Smtp-Source: AGHT+IHbyUvmjUyoXxmt0Hsroe+PxUVESJqm0VS3IY7BFzdBRPrbKlIO9mwZVcJFaRypkZ0d/kJCXA==
X-Received: by 2002:a05:6a00:1901:b0:706:65f6:3ab9 with SMTP id d2e1a72fcca58-70aaad6dd26mr5768973b3a.20.1719866462761;
        Mon, 01 Jul 2024 13:41:02 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8da7a4sm5502423a12.30.2024.07.01.13.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:41:02 -0700 (PDT)
Date: Mon, 1 Jul 2024 20:40:52 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anthony Nandaa <profnandaa@gmail.com>
Cc: linux-hyperv@vger.kernel.org, decui@microsoft.com, mhklinux@outlook.com,
	kys@microsoft.com, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] tools: hv: lsvmbus: change shebang to use python3
Message-ID: <ZoMUVE2cuHDkcdbs@liuwe-devbox-debian-v2>
References: <20240701083554.11967-1-profnandaa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701083554.11967-1-profnandaa@gmail.com>

On Mon, Jul 01, 2024 at 08:35:55AM +0000, Anthony Nandaa wrote:
> This patch updates the shebang in the lsvmbus tool to use python3
> instead of python. The change is necessary because Python 2 has
> reached its end of life as of January 1, 2020, and is no longer
> maintained[1]. Many modern systems do not have python pointing to
> Python 2, and instead use python3.
> 
> By explicitly using python3, we ensure compatibility with modern
> systems since Python 2 is no longer being shipped by default.
> 
> This change also updates the file permissions to make the script
> executable, so that the script runs out of the box.
> Also, similar scripts within `tools/hv` have mode `755`:
> 
> ```
> -rwxr-xr-x 1 labuser labuser   930 Jun 28 16:15 hv_get_dhcp_info.sh
> -rwxr-xr-x 1 labuser labuser   622 Jun 28 16:15 hv_get_dns_info.sh
> -rwxr-xr-x 1 labuser labuser  1888 Jun 28 16:15 hv_set_ifconfig.sh
> ```
> 
> Before fix, this is what you get when you attempt to run `lsvmbus`:
> ```
> /usr/bin/env: ‘python’: No such file or directory
> ```
> 
> [1] https://www.python.org/doc/sunset-python-2/
> 
> Signed-off-by: Anthony Nandaa <profnandaa@gmail.com>

Have you checked if the scripts are compatible with python3?

Thanks,
Wei.

> ---
>  tools/hv/lsvmbus | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 => 100755 tools/hv/lsvmbus
> 
> diff --git a/tools/hv/lsvmbus b/tools/hv/lsvmbus
> old mode 100644
> new mode 100755
> index 55e7374bade0..23dcd8e705be
> --- a/tools/hv/lsvmbus
> +++ b/tools/hv/lsvmbus
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  # SPDX-License-Identifier: GPL-2.0
>  
>  import os
> -- 
> 2.33.8
> 
> 

