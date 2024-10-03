Return-Path: <linux-hyperv+bounces-3105-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF1698EC53
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 11:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB06A1C21932
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C8A1465B1;
	Thu,  3 Oct 2024 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akXV1s/O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3062813DBB1
	for <linux-hyperv@vger.kernel.org>; Thu,  3 Oct 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727948097; cv=none; b=sLHTOy3i0NiMaUNkacJj1tbWtPAhn711i324hWvHFoeooYmQ7WGetiqw6ooyO6lVVKQEpQLaUt2JZ+aUIH8j/GGjVqO4CDqpq1HFq3lL/iYNt/3RlJOCR216mgrRAjEZoTbByU8s90nqZ35apFKGSt315xQyRHu+5b2rhnhXaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727948097; c=relaxed/simple;
	bh=8PNWb8f5FF5xUid5MxaKNsCFti1xv+NLEa0wWHyNbBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTZpWXa2cyYzQhuam4qGvRuZXCwLftuUvWQpoLJJHeHlOJCAuwzNmEBHavhKZsbedMJ5kU1W8KlqBiNwgBUSPfKV5exXFznm7a9sAV9dVkDS7e3mhx6U4sKhY4pHR3dYDefYswJmK7GPgo8LPdeLGR/63wr01ImoOD3wEY4p9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akXV1s/O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727948095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXMpAb3wF74PmmdRNbw2eEeLnsh8xWYLhJFUtS51lww=;
	b=akXV1s/OXdxs0FMV/AkF+P5IKBUN7jLraCfcyPYDGZVNMLiZq6MKcxz94as/DnE9uxwSx7
	qvA7Aw1o+h4bgHlt84+3CXfJBSm9xreaQisvNLkljqPLEx3VjTP8kLeBhyHkFxLTB+alCw
	ZahHVtysX9U+jvSvDbhs/lCBOa69ZJs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-rMmS1qLdM1mUNiLCMmKxSQ-1; Thu, 03 Oct 2024 05:34:54 -0400
X-MC-Unique: rMmS1qLdM1mUNiLCMmKxSQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb5f6708aso3889785e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 03 Oct 2024 02:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727948092; x=1728552892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXMpAb3wF74PmmdRNbw2eEeLnsh8xWYLhJFUtS51lww=;
        b=SHFxos2xwq4nTZilIXFmc+W7uU85fOjXZbUnQB21NUBUEYXHR9ynBzSNniDSFxGIXz
         LG/C+osy3CSF01MNxuGMUxQU44ZvzgBehn/hN/Dj//t7fGqN+VWkf7ztcV3g6hzGbH3G
         I0877XUI8g4Ks9OpYxu9ziZHx+xH/DjPGSWxb8WB79Q7lo3m6B/0QixSxgtK2C2l82L0
         7Hbt8iPJqaUnltQhgeAlsHUvZgG74Amjyt50NVbS36Qj5/vTZeRJaVHHWzILEt0Z13em
         7Q71XzSork9lQit+wpDL0YqaRFEl7dOFbGaD1fGGCkdbGazmQ9FvkcsodhRDIdzbcZh/
         5anw==
X-Forwarded-Encrypted: i=1; AJvYcCUywxww/MtvBnMpazPih4+tPlHKAGz4hSGvIWP2gweMxbi/CyppdLwthOTIKzJCMu7cPXN2Af+rN/4rAGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgT9uI1tqhT66SuU223IR9kEd1k6c/vQhGKnRBerDkY+ge+UY
	psafq1wh1l4fkNuJTzY7OtME28phKydx5Chtqs19mMT7yh8fz/CpP5OeRAsL+oPZvR/QoCKsdu8
	V84C7ETQx3Q9JY1wpIrnNp/hwvLLMOmKG/Rps3mvE9rgFv+7rU+Dg4nAZ0hQ65aVlEG3CKh//
X-Received: by 2002:a05:600c:3510:b0:426:6ed5:d682 with SMTP id 5b1f17b1804b1-42f777bfa85mr41752605e9.12.1727948092124;
        Thu, 03 Oct 2024 02:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBowI5zhEycK9k+WgMuHJJtTO0OTPJ5Pur5BI9oIv9qrWES3L7uxAbpAFQkDhtkECemtMfmQ==
X-Received: by 2002:a05:600c:3510:b0:426:6ed5:d682 with SMTP id 5b1f17b1804b1-42f777bfa85mr41752385e9.12.1727948091654;
        Thu, 03 Oct 2024 02:34:51 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79d8d3edsm39844885e9.7.2024.10.03.02.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 02:34:51 -0700 (PDT)
Message-ID: <a96b1e00-70e3-46d8-a918-e4eb2e7443e8@redhat.com>
Date: Thu, 3 Oct 2024 11:34:49 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] hv_netvsc: Fix VF namespace also in netvsc_open
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
Cc: kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 edumazet@google.com, kuba@kernel.org, stephen@networkplumber.org,
 davem@davemloft.net, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1727470464-14327-1-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1727470464-14327-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 22:54, Haiyang Zhang wrote:
> The existing code moves VF to the same namespace as the synthetic device
> during netvsc_register_vf(). But, if the synthetic device is moved to a
> new namespace after the VF registration, the VF won't be moved together.
> 
> To make the behavior more consistent, add a namespace check to netvsc_open(),
> and move the VF if it is not in the same namespace.
> 
> Cc: stable@vger.kernel.org
> Fixes: c0a41b887ce6 ("hv_netvsc: move VF to same namespace as netvsc device")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

This looks strange to me. Skimming over the code it looks like that with 
VF you really don't mean a Virtual Function...

Looking at the blamed commit, it looks like that having both the 
synthetic and the "VF" device in different namespaces is an intended 
use-case. This change would make such scenario more difficult and could 
possibly break existing use-cases.

Why do you think it will be more consistent? If the user moved the 
synthetic device in another netns, possibly/likely the user intended to 
keep both devices separated.

Thanks,

Paolo


