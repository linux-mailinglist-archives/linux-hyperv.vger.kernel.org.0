Return-Path: <linux-hyperv+bounces-6778-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A1FB48DD5
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 14:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055783A198A
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 12:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4F62EC566;
	Mon,  8 Sep 2025 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnyZZKH7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926B9147C9B;
	Mon,  8 Sep 2025 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335411; cv=none; b=Y26pITfIUqQvYo+2tGDSW5+J1xgEOkmzy7jY3D8FLkcyjkimaZs32nT43FtMt6RGEKoU9469+A9RyIjWzWehjm1OW0xLxD5WwL56OqamLN5EeL9qLVlKCScqowdtdHGnLCAqnebUIfcubq78u8FgjuHUOD4aiWT+mB21l8sdM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335411; c=relaxed/simple;
	bh=hCZzQzXTqDQPsdfkFKi7HNFa74pKEkCdhxSkeUYipyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLBY++u2uKz4l6U+1S2g49Iv1R05bXYiX+gr8Uu96DCwyOkPdYEAV4LGBUp6NpQjD1NuC3Sj+BFghrZzGsTD1Usya3ncLG7Q50kZUwhE9jKQx0d8g9vEoLASOO5xgdLsEiZHTQp2ibEjDStxUK6IOdMITpDOOKY67tzII805xtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnyZZKH7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so28996785e9.3;
        Mon, 08 Sep 2025 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757335408; x=1757940208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Vg0GNEeuU43g45pQCnqO0Jnldu9YfZ3lQZTRTHWzUE=;
        b=mnyZZKH7+Yv7vl3R80JstR07HNE/Ssuc8VXWTwnrVZjvjjfObjc0/sWmQVAxZBS5RZ
         ZZi/0FDjijpbYJVsG+RGQLZXWGSZAVNhd7ioz1WiTrwwxRm2G3tkrGRiT2EQXiE1fSMc
         gOI3pkyko0a/bUZCr56YWFLIrkn+/02GAJ/M+szxx/Dl6V2wMjAJDtoE21OCUObjiUtU
         A1DpaGTHTeOvNA6nX4gupOZ8iLzLUGZha0yeeUOp9sJBBem9XpkAdi/h+SHJSek6iQE5
         KPbveRTSRTTxaX2tDhOTa8KW3vEliiKty8J/jiQvOdKpde+n/4QxmBU24z79Jjb+HXWK
         uObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757335408; x=1757940208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Vg0GNEeuU43g45pQCnqO0Jnldu9YfZ3lQZTRTHWzUE=;
        b=M1ygHDXDA6twQExkTB2hW10GG3ia4q2v06zmNtX3lUpGtBWUbg0jZZGTnogGBPI55e
         3cBIg0B8xaug9rnhMhdgyKitnQrIxmA41sp3VTYyS5UrZfKzFKyR78puc5OJABL4vC+E
         waL0GzCqyhDx7Lecdw68E59lYGLwGPy9lqAtwy5jnR6TCSnGu8dKRoEst+ioEmDmnCro
         XBmP3UU0bRL7JG6JhN0CUTGQnIxekfjNI7mFK9NYud6Y2MhTrEw7OC7/MAD/yiSH3eRi
         BI59R62g5OQkIndlZ46kXCXcfK/oQ9W/G2zv1MaqSbpWJnpJLMGjm6hzqkekusftSvXP
         7tWg==
X-Forwarded-Encrypted: i=1; AJvYcCVh7NBhFXWtgf1iZMYTFFw2N8n++JjXns8iDqyNx5VK+up0j6tgaD5kfTvEEzqoMTeKrTaQj0g5@vger.kernel.org, AJvYcCVoR8s7JmahdJy+UPDpSauawDhfDvh2YmS+7zjA39YmPMb8O/w/3p5W8OugMnUIfWao+Ye1F0Y6iqPM//w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyja2Hq/G4v1oSozAavFlI2VBYFMo7AoE7ctIx0SR7i1foKuhO8
	fi6v+ehWWwwbkd7ieb4+PW4tJlam9MJGAH4/CcmHpDLJd0pva6kyUCR0
X-Gm-Gg: ASbGnctsnGh8lm+XCN9JfnSor0ZsM+b0Pp9jQBo46KyfGPqpkzhvukrFe0M6hAd2Pxp
	uOH4L1jhRPCHI3SRVJbw8nvc2ThMOb50r9HNePnDA8/1Xd6oV2yY+VTFyHX1VeVPrdeJ7wxo5mq
	FD2+T5gIV46PR5oRg9chDw1F3z/77y5SPxGP1/NXMdDLsOdlCIAQDlCARrfoa8W9bxB2hYXM7+n
	l5WAMqLI12/oP18m+2JcVz1s8695eU9VJmcc7ttMYsqze3ebOKlPET1kzDVZTjH5DVjJPs2rcsd
	x6+kIrmjx0k9qIJ2xx4BM/4byEGeojc1RMfOxbbAGnk08F7hBtZlp50isEK/lGXykWSK1Q2ehKt
	YvS4Ff0V9KUZRi/QcuQSBhwOK1gqcZxkKUDe0WeWl/v+vZu6KQnNptw==
X-Google-Smtp-Source: AGHT+IEt6VZ1UvFJW697LTeVzoEhMryjNa7nQmEERcDQ9zZ1SOxfk7VPPhBwquSNBfmWIdnecVE8RQ==
X-Received: by 2002:a05:600c:3596:b0:45d:d6fc:2509 with SMTP id 5b1f17b1804b1-45dddeb00bfmr81306645e9.6.1757335407547;
        Mon, 08 Sep 2025 05:43:27 -0700 (PDT)
Received: from [10.158.36.109] ([72.25.96.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f2d3c88sm309254095e9.19.2025.09.08.05.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:43:26 -0700 (PDT)
Message-ID: <25e5b405-09bf-40ac-8f45-5f3a0bbed8f5@gmail.com>
Date: Mon, 8 Sep 2025 15:43:25 +0300
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Not returning mlx5_link_info table when
 speed is unknown
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Li Tian <litian@redhat.com>,
 netdev@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Benjamin Poirier <bpoirier@redhat.com>, Carolina Jubran
 <cjubran@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
References: <20250908085313.18768-1-litian@redhat.com>
 <877by9fep2.fsf@redhat.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <877by9fep2.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/09/2025 12:58, Vitaly Kuznetsov wrote:
> Li Tian <litian@redhat.com> writes:
> 
>> Because mlx5e_link_mode is sparse e.g. Azure mlx5 reports PTYS 19.
>> Do not return it when speed unless retrieved successfully.
>>
>> Fixes: 65a5d35571849 ("net/mlx5: Refactor link speed handling with mlx5_link_info struct")

++

Adding author and reviewer of offending patch.

>> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Signed-off-by: Li Tian <litian@redhat.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/port.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
>> index 2d7adf7444ba..a69c83da2542 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
>> @@ -1170,7 +1170,11 @@ const struct mlx5_link_info *mlx5_port_ptys2info(struct mlx5_core_dev *mdev,
>>   	mlx5e_port_get_link_mode_info_arr(mdev, &table, &max_size,
>>   					  force_legacy);
>>   	i = find_first_bit(&temp, max_size);
>> -	if (i < max_size)

Keep an empty line before comment.

>> +	/*

Can have the comment text starting from the first line.
>> +	 * mlx5e_link_mode is sparse. Check speed
> 
> The array is either 'mlx5e_link_mode' or 'mlx5e_ext_link_info' but both
> have holes in them.
> 

You mean 'mlx5e_link_info' and 'mlx5e_ext_link_info'.
I wouldn't say they are sparse. They have holes indeed.


>> +	 * is non-zero as indication of a hole.
>> +	 */
>> +	if (i < max_size && table[i].speed)
>>   		return &table[i];
>>   
>>   	return NULL;
> 


