Return-Path: <linux-hyperv+bounces-2891-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C7996249E
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 12:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3912286779
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4529A16C448;
	Wed, 28 Aug 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTgxcQBq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085F16BE3A;
	Wed, 28 Aug 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840338; cv=none; b=cFh2h5gHnQ1xWpp68aI0EBB4XEF5++XdmAWnv2nGKENbTSfCUPLvrTNCo1W1XeaZKUL3HUk8KXUQUXp8ExB7CV+dy1nmR4RG9GlQn7WFBzpIxncAgaUQWSxDvM8r+x3Agt5L4aQDmdQPWbQjGXCq8BGbBBy3m4aHc+U+xA8MRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840338; c=relaxed/simple;
	bh=UoN/UyiYug66uLlCk0UnTmfexCWdDKkn94NFkBOoF0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYshj+gfWpX6HCadkfUiwIOoqto1+AZvq0NdTX9S1eeTA5jXlVwt0zIDynxkQb4EMALu8lDZWDYM4KP8tnJU0B69wUd0n68AxPFsM5xGzkopPnHO2Vj3NReCPZzkCIGQis7e45C0ikrhvV0RbOkVkiCB8/M+jGvhcAqe8nVBkbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTgxcQBq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2020ac89cabso60782845ad.1;
        Wed, 28 Aug 2024 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724840336; x=1725445136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4W3IP20CGimPLVV7RyZx6e0WZ7znTW6N+Ub+VJ1Yfo=;
        b=ZTgxcQBqtA96ny8+blNpXx9k4F+XpslMx6I3NS6YJkAFVIsVTRPYmHf0QXwuQBZ79j
         sKN0lmZwguOOK9oQ7wOngFYQ9vU4d1KyYMMRAa5mVd6ywkXh+DgHcF6pzUUysu5rMj1/
         icH6LK8awxlvkCNrNGqAsKtexk6SxINTkgolJCy33KifbBCciXS50f2KjLPpfp7w/L8Q
         +SMJMd7+2HlIdwnfAhbz+FRxCDs/fkSBjz8Op3GNDgQKvQDZQgpgsXf7Ec5c0WIQ726G
         mSe23ztxBFplf8M1Bpc9lZwrazRDpkTPl4NuhrLTJJ7UscUuG+jq7mLQdZibRI5gSfUE
         O/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724840336; x=1725445136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4W3IP20CGimPLVV7RyZx6e0WZ7znTW6N+Ub+VJ1Yfo=;
        b=sMB0B5OPkHlOSxNZWQyQfrZhSpt+Wem3uuidoyvBTHGycFlWamL1QYpZ5o7gFQvWKC
         +TABEhIZq+Yd/3YwwGZsUmeMNS3SKyBYVCEY/x7qD8QN7HepMDMPCnKmK4EUoUQ7mq4r
         B+WZnukVkvNhxKzrXOo1BJ/Q/KL9dvdnPrtSJMTHP2TK6Oo6j/tfoAo/6KDbr+tgWpVN
         zQa6+Osi7h+1UurNZls5YWmxH6aTaPutgNHUNJPr4nqO4GhYkx1cSHmmUV96M+vIjRry
         GWor/OXZOKQ+XnHk9TFblUpFSWfHMIleqGAuquVPgMCULSy0V36NTux6OffYWQQhj0gF
         fxYw==
X-Forwarded-Encrypted: i=1; AJvYcCWS1ithLKPUWu4wzs4lf7LNcR8R2HVsxYBPtisql2X/7b/Po9jr6PgzzWhqiPHbBqW79AXpJZUAJZCrtAU=@vger.kernel.org, AJvYcCWmUSbHto0RKrMQvITSPX76TGw0HmaE8LZ8dgdAPJyb+aGhDbJoj2gVSzYVEhtPflUtcwGlli1WZ6pxw/Pw@vger.kernel.org
X-Gm-Message-State: AOJu0YxpHLn4MPDOb+3+wPycTHsG56R8akEHIk5oMqzD/tnoWTXTqF8l
	IUVrXiZ5NP9sh1LbXQmdSMofcjfx942v6dq79xnvTIgOPhhoZwze
X-Google-Smtp-Source: AGHT+IFn3LHCdIMyLvynP/kjAYe5D7ghddtHqXvyS9zOiS1PDErtG8cCYDtyf8zK+7xHvOaKspLqmw==
X-Received: by 2002:a17:903:2352:b0:201:f065:2b2c with SMTP id d9443c01a7336-2039e4fbbe2mr160778575ad.55.1724840335822;
        Wed, 28 Aug 2024 03:18:55 -0700 (PDT)
Received: from [192.168.1.240] ([223.185.130.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fcff06sm96439215ad.308.2024.08.28.03.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 03:18:55 -0700 (PDT)
Message-ID: <d95656fd-cd64-4386-a22f-689a70d8327c@gmail.com>
Date: Wed, 28 Aug 2024 15:48:50 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/hv: Add memory allocation check in hv_fcopy_start
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, kys@microsoft.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240828100031.3833-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Praveen Kumar <kpraveen.lkml@gmail.com>
In-Reply-To: <20240828100031.3833-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/08/24 15:30, Zhu Jun wrote:
> Added checks for `file_name` and `path_name` memory allocation failures,
> with error logging and process exit on failure.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/hv/hv_fcopy_uio_daemon.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
> index 3ce316cc9f97..2efdf8d28e9c 100644
> --- a/tools/hv/hv_fcopy_uio_daemon.c
> +++ b/tools/hv/hv_fcopy_uio_daemon.c
> @@ -295,6 +295,10 @@ static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
>   
>   	file_name = (char *)malloc(file_size * sizeof(char));
>   	path_name = (char *)malloc(path_size * sizeof(char));
> +	if (!file_name || !path_name) {
> +		syslog(LOG_ERR, "Can't allocate memory!");

Probably, you may want to cleanup memory here in case either of one is 
successful allocation.

> +		exit(EXIT_FAILURE);
> +	}
>   
>   	wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
>   	wcstoutf8(path_name, (__u16 *)in_path_name, path_size);


