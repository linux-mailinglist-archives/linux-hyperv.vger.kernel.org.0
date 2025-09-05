Return-Path: <linux-hyperv+bounces-6747-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFA2B45C5F
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 17:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E553AC3C8
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2154B1EFF80;
	Fri,  5 Sep 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5BQrRHI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850EF31B835;
	Fri,  5 Sep 2025 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085645; cv=none; b=qUnBnlAirKI/u8GCrJ+Cg+sn/re9oaEEpFQ02Q517ReVvQzvBlXRnM8oz580Sj10JKwe8aSvcRO7AlutP7M/nakjtNoUrv+bXCYmqdDWn8ti7h44MFHt1x1v8AvC46kuh81ckgy5w5u5Fw30w8pt1QrDPF6DSYTh5p7sMyH5wZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085645; c=relaxed/simple;
	bh=LEQ/FRPs34gvlTGlxwo2s0S1CaURq1iIbGbEBKv+JWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUKcvXIaCm5olgZ5c6xFUD4ZeC8oOE6O/AFevS3NM5kV3q/m++qsUXiuEwdJVfP0lZNWglUZM03MZzzE3XGin2CBj0ZoeUJecAG/Er6MUvn3t0y5gX3ngV3EPvbvmq112B1EwxGwFebdXI8CosPxnr2JT6o7wBJ0zrvySPUiScM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5BQrRHI; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30ccebab736so1898987fac.3;
        Fri, 05 Sep 2025 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757085642; x=1757690442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHc9VdpqeetzzHFVCkUDEKJRsjgBr66oVPzgKsPNA4E=;
        b=Q5BQrRHIAnu0saUoGy5vhGH9aspV5PiQoI+ngGdFvUQpVS05LyYJa7mbHSw8m5/8Vi
         39WPWADCOofHOlhxGzoeRpJZ8xcg52GChjQIlEo8NGGFoUj+3LLTvYBIHf2f031ZRpIT
         zqMfGBx9IfV1nqtl7Z7nagDpfueJjupivDECVA16o705Xptsb6yh9oAtnMO4Mu/7asVY
         t7OkP/KR5h5hBH9IE4rwI/rlWWKDuvhXG7IlsJ1yKjF7wpDlw1zFW0IE7gtSD8nv8vze
         0vAGgcLrprl2ZCfTG3879dUrPqufSpu45pNcfSELSyww41V0PjPZLqpaGQHPCOU+JG3j
         WyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085642; x=1757690442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHc9VdpqeetzzHFVCkUDEKJRsjgBr66oVPzgKsPNA4E=;
        b=AhljImYt7y6+NOfkeb5A0Dqdnkr5ikvPUQPFcArUPpWxxgrbb9TQ20I3RokTzi7roO
         P826x+xefvpcie8ewTUW7+eYDQblYUGirrRPZ27kOBIEmCMX8Y4cOJkbU1M0CCC++t/E
         CdTccg/9noFGlQInSA2EnTye1yRj1qdHQDkrWFL6ckQhMNwew7i9sMj+4LYA0rzyG8H+
         eHSYowIWS3SKtmYd9nMosE/Mg7u+x2WryVVtsJBMGmQEcZkc/DcXSp3cbwEwKg8RqjzG
         AU+vuvTlx2m+T7DTi43YRXusFA7d9dBA30J/zyrrP/Ct85w7mqXXWa+h0ioFb04e+5bS
         hpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzBDKSfVKqi9LMx5rHrhPLMtu0BCypvASogoDJHOLTcLq0RLSV281rib8EQeWxugzvQr648Uc3fPs8k49P@vger.kernel.org, AJvYcCXXsVq/dgdvHA6d+VCv9bq/O+GL+nuzX5HwdJKVsb43/4OMyO0jByJIqu15hPQChiznBbPliRmdbHldOww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbOcVY5xeNcZqPp0OvGNYzg42xrc6BR6fzc1ogYspvWAxKwwFL
	NlpNHGucCa8HZkKZnZVQAqr+5cN4GZd52VF6V6igaysmlVYIALhZyY01
X-Gm-Gg: ASbGncvq1fpRAbQ5efiLUrcx9TIkRSonBQC3liJe2lVXGj6YqilbWqypfWe5pdr1y+X
	giifxhQlCU/Jyjy0XLD7km+TBcvn/Iww83lcyJQmDp0UjhoUe4E7PFFEYsCqnTUnxdjWstXmueu
	2h+SPVQpJiNZkA6kasbIIROMaDdW9awhipmZ3dxOlM4H9wI8I3UeSl+iCwTc14+XRJXqpkmjc+4
	rBDopz3idxfsKO3OcNDjLKCyYb/MSOhSqm3oYzO0/fh/TnPLeQsrgMjqjZM32/klIhGlr7k48b6
	V+pQGeei8Id95f/bGIieDZlcAGM4YMxsp2QY/5NjhIBy40blICDF90s7GNM44yuDwfaFgGJobtD
	35JmC+BuYS1ssr3XvbKIckLjP/ZBMF7Wn4eVX7hYbKvNg2hPb+wI7
X-Google-Smtp-Source: AGHT+IGHYtZc/6qY+cWiPVA7MRmwvRaqgY1NzSqQLshmwrXkpAKZD2YIlKKpFVNPrsHU8o8gLhnEaA==
X-Received: by 2002:a05:687c:4d:10b0:31a:70c2:9a21 with SMTP id 586e51a60fabf-31a70c34130mr5178032fac.38.1757085642439;
        Fri, 05 Sep 2025 08:20:42 -0700 (PDT)
Received: from ?IPV6:2603:8081:c640:1::1007? ([2603:8081:c640:1::1007])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745743cdea4sm4304446a34.39.2025.09.05.08.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:20:41 -0700 (PDT)
Message-ID: <e18af534-cf48-4e0b-8a14-37268dfc2c80@gmail.com>
Date: Fri, 5 Sep 2025 10:20:39 -0500
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mshv: Only map vp->vp_stats_pages if on root
 scheduler
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-2-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Praveen K Paladugu <praveenkpaladugu@gmail.com>
In-Reply-To: <1756428230-3599-2-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/28/2025 7:43 PM, Nuno Das Neves wrote:
> This mapping is only used for checking if the dispatch thread is
> blocked. This is only relevant for the root scheduler, so check the
> scheduler type to determine whether to map/unmap these pages, instead of
> the current check, which is incorrect.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>   drivers/hv/mshv_root_main.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index e4ee9beddaf5..bbdefe8a2e9c 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -987,7 +987,11 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>   			goto unmap_register_page;
>   	}
>   
> -	if (hv_parent_partition()) {
> +	/*
> +	 * This mapping of the stats page is for detecting if dispatch thread
> +	 * is blocked - only relevant for root scheduler
> +	 */
> +	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT) {
>   		ret = mshv_vp_stats_map(partition->pt_id, args.vp_index,
>   					stats_pages);
>   		if (ret)
> @@ -1016,7 +1020,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>   	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
>   		vp->vp_ghcb_page = page_to_virt(ghcb_page);
>   
> -	if (hv_parent_partition())
> +	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
>   		memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
>   
>   	/*
> @@ -1039,7 +1043,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>   free_vp:
>   	kfree(vp);
>   unmap_stats_pages:
> -	if (hv_parent_partition())
> +	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
>   		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
>   unmap_ghcb_page:
>   	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available()) {
> @@ -1793,7 +1797,7 @@ static void destroy_partition(struct mshv_partition *partition)
>   			if (!vp)
>   				continue;
>   
> -			if (hv_parent_partition())
> +			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
>   				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
>   
>   			if (vp->vp_register_page) {

Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>

