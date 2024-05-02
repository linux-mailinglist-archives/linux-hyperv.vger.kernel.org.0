Return-Path: <linux-hyperv+bounces-2059-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5B18B9511
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 May 2024 09:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB7F5B22393
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 May 2024 07:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0A728DC9;
	Thu,  2 May 2024 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJzRc3BI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F3249EB
	for <linux-hyperv@vger.kernel.org>; Thu,  2 May 2024 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633572; cv=none; b=B4Ffiqjuwtw/nnzduz1lwZjRxVQrHLwGQvs9ECca/fRukGviLmozB2RAVIVOvsyvMhlPvgxF9So2lMNz4NA/w51BF1WK1IXBnEyWOYD3wcOUpAT4zKWsC1H/PEC6jOVw9aW9zh8OYY/88ZPdvY6yTpkGCVtqZtjFKiBKKtBUCHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633572; c=relaxed/simple;
	bh=SB62APbq3iH0ch9xM+8WuyA+92QlwsDLbgFkacggKmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iQ7gQviYMS8iiBWCcDT8qSgezi3SBhapT5wtfsCu3rgsi5WBu3RGz0TDFFic0uUCZ+uZNduzu/T6x5hwVLFz9HeUbJIxxaSxrz4w1pn/7Hjur+a2DhXyIvTClWviUWBnEZnMGVMnkn6fsfKKnfQcBR5Yzpw0hy1r7Ej3h+U+tCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJzRc3BI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714633569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y/d4yuyVkisorATTW5TLptiRR8w+kLvhe+ZUaPi7E/w=;
	b=dJzRc3BIVh9/vbibuU8ep1TjgmbWFwthUTyaroH9AilrvXvjiAK1GbXAfy3A+5tgdHoIMD
	2etLCAYqHtafAcO519Cjv+R3Q713XZR6olRzme4oyI5Yb9iITNGUFlrbtv3CwFVE1Pcf3r
	qrH6JAQ+GroDhfW8g7so26BmBWwovtM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-sejzWSoeMtWKLCFSpBvU_A-1; Thu, 02 May 2024 03:06:07 -0400
X-MC-Unique: sejzWSoeMtWKLCFSpBvU_A-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-51c7abe8da8so5185350e87.1
        for <linux-hyperv@vger.kernel.org>; Thu, 02 May 2024 00:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714633566; x=1715238366;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/d4yuyVkisorATTW5TLptiRR8w+kLvhe+ZUaPi7E/w=;
        b=bsM/fzLqhtUygcCUMa6KXNSoO/lkAtGm2WFlaSFZSaV2gRNstYlfl/o/QCBtSM052s
         3UEEpr9BHhCByiiStWmkU9NvtZs3VMWZi2rbHKfX2Xkl4qoj+iYoGcU/03A/BiQuPJ7h
         ZEwMR6VYfrQHnBiSm/NiNvkKXXvv9sMZbfWAkdpuJfPvjAKv5UU+xTNasrttXu9vKHlQ
         SqPukcbdPhJyoOcQa9S76i0e93duk6+cdF0crxum6bTClsRzPGjR/BYLB/a2/OYs0SCX
         0eKpFkLkuE8x5Mhbtqh51B9FoxWXGCoKOpcOOLeYd6rYKw7qGIiJ6fw0JvtKRQxpuKaj
         wnLg==
X-Forwarded-Encrypted: i=1; AJvYcCX9RAUwlApFLlX1QHuhT5GqJSJMKY/DV+TCTu8em3vLuPxUbu+3osfan3a72+BBgMdpbJ5r0eNXcPQxMm4UnTUFD0Okx4xDbcEvLV9w
X-Gm-Message-State: AOJu0YxbQ8rbUrGX/tyjT9b4pTX52qj+jlFy1WOLcOwkGeoPzs/oq5Ea
	bg5xl4zEQwqBMtO4pOqkE4nAw++z9qep0xhDFtaJSvAxqPva/nPTWQo8JLZjrHsFQ6BZg3HRnjt
	lntOHf9RztVCbmn8o/b/jNrmZobockcMAOuCI6RVYF/Ik5tPM0duV14UsE0vsNg==
X-Received: by 2002:ac2:5bc7:0:b0:51c:b47b:31a2 with SMTP id u7-20020ac25bc7000000b0051cb47b31a2mr528093lfn.60.1714633566167;
        Thu, 02 May 2024 00:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5JnK9oLZpoyYve9PjlgsaPu5zW1OGd6EtGAeV1NYEpEuuB65NwNf4RokoCTPAkGcquhv+mg==
X-Received: by 2002:ac2:5bc7:0:b0:51c:b47b:31a2 with SMTP id u7-20020ac25bc7000000b0051cb47b31a2mr528079lfn.60.1714633565720;
        Thu, 02 May 2024 00:06:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676? (p200300cbc71ebf00eba13ab9ab0fd676.dip0.t-ipconnect.de. [2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676])
        by smtp.gmail.com with ESMTPSA id d18-20020adfef92000000b0034c71090653sm486732wro.57.2024.05.02.00.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:06:05 -0700 (PDT)
Message-ID: <2ff54327-b387-4ede-9858-049b20ca8118@redhat.com>
Date: Thu, 2 May 2024 09:06:04 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hv_balloon: Use kernel macros to simplify open
 coded sequences
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20240501151458.2807-1-mhklinux@outlook.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240501151458.2807-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.05.24 17:14, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Code sequences equivalent to ALIGN(), ALIGN_DOWN(), and umin() are
> currently open coded. Change these to use the kernel macro to
> improve code clarity. ALIGN() and ALIGN_DOWN() require the
> alignment value to be a power of 2, which is the case here.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> Changes in v2:
> * No changes. This is a new patch that goes with v2 of patch 2 of this series.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


