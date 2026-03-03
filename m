Return-Path: <linux-hyperv+bounces-9106-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLD5MBe/pmlDTQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9106-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 11:59:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 744421ED38A
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 11:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1BCB30451D9
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 10:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951673CE492;
	Tue,  3 Mar 2026 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyNR9zUU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tJ7L5XIw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9839526B
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535400; cv=none; b=U4e3nbqQFY1RAP20PZBYWL7hkWGdSr4z0c3kKa1xsLgM3/FG8KYCF8fd+/8rWHgRps5MfvRLF/NB+l1dOlBQfAd79JOMStUyKA1oT02UbvHf2l+ZfI2LZeNMNy7zRb5LHvJOFtsNdODFyscZIq2eI7M+rIxeCTQf5gMEEn6d8i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535400; c=relaxed/simple;
	bh=sxxVfVpOS6gefLhTyaSzi6d8tpJBgjZuKKmC8M1vrOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tbMYldbmzxz/MDl+5yJQj7TTy86+M2IXrYzXbxAzCt/chrw8ji0B57GqBQVUhkwuSp4oh80IBCVE0Nt3q3Et5YZDN940KvRRf9p7xWxQT/WVwHL55zo2i0CQBEv2CqXqYRhdEqJU2U9K6kKXAL+TairrUsURo/mmFgbOJbsAdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyNR9zUU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tJ7L5XIw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772535394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unnFcg3oz6A6y1pxfDBz1S5V10XOha7AqEFUFjOVM58=;
	b=YyNR9zUUpccpsFUaTj732mTcfyJHgW2+rfD/cOqa5aCc7iYzUCHlCBCcHiINOohp6EtGFB
	gcSSCRFQ489N3QUlXlZxORXnfy9FVQvtv5kqfn/pu2x01eKmXdsl8WwJKqb5izK/iNo1lM
	O0+TWj+EX2l86aA2/Wwn4fAnrpHsQZ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-LHtwmRPHPiWUAmUO5MiHoQ-1; Tue, 03 Mar 2026 05:56:33 -0500
X-MC-Unique: LHtwmRPHPiWUAmUO5MiHoQ-1
X-Mimecast-MFC-AGG-ID: LHtwmRPHPiWUAmUO5MiHoQ_1772535392
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836fbfa35cso29905875e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 02:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772535392; x=1773140192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=unnFcg3oz6A6y1pxfDBz1S5V10XOha7AqEFUFjOVM58=;
        b=tJ7L5XIwnOWSLAs/1WjlOmuHEMBX48JwdwZ97rzru1iDBmQpWs9G6fAVSVuWr/Jukl
         8W8VAP9woRjyHkodR4XzR3zHT4bilT3dO8Mtv4iFkEgSFT7y+WxlwzweDgopWsi6dRbV
         5DFKgefDAijxCtDAlMNPd4e8fzVpK70a++aWpxNF2oU7u8xKGj8/6dVMXVLraOfwZfHW
         hq9Mx6Rf84hYYfgiB4uL2HN6S/ZQ58K6kzPzxR/GPQBIcFoFO0L8Zv2+OGoYIHHZqjWL
         k5BHksItHA564XnFhL1fQoqvtN1O5AV8by5ncYm05U6EX+T1XR+BuP5O49T14SwiLk6Q
         CIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772535392; x=1773140192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unnFcg3oz6A6y1pxfDBz1S5V10XOha7AqEFUFjOVM58=;
        b=mBy2+xq++PRv1P2FKr3jXDsggCOBqK9i5tzPC0VhKI2iQ3eekJ6qfrj6EMCWTOewom
         uei05LhxLSzYviZ0sLd9g/0JI42COLNquZRZbkQUn9baFZ0XSixM9iRidBUvwlWNMtbt
         40qAqtuL6uChm9XA4TfHAcXbVLoD4mC2oBYzNONqDCu6VOURTptDWX2RGoBOEtrLJBue
         0csRLGIuuqnXThmHDssmVpY8d+HMV5AYiw4I5v/cO6RFrLdXxFRDAvT9HlbUhLBxJVDV
         nGf+72ryHLstY3PAgyNg8xt+zirXRuizgLUkSZEN7uT8NlN+ubk8619LS21TkpKpU39J
         H0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUuLNxyRVQruvaICkZ57jw3EBgBN8YzU6sfXKemHhmUhlf6icR+Z0J1HNEsT4HGP/sTK541k7yiV0xfeCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqCTz1kstbsFyVZwnozVFpFoN9SEKrAVZ+fJGNGIjcQWihepi
	BI3EDAl4tiL7fEQHHlUi3QDy273PMfPmMKyXqAkPjNUlY1TGf8WPoFY907z9FswDAfYqv1P+Ikm
	Kg2EVxaSxcEnKaP27DqjMl7QsH0jVNsR4sIeNz3Qt37b7RI9CqzOJpGVEwY0cbPxvcw==
X-Gm-Gg: ATEYQzwVAC5EG8U6gtT3NffqKZ2KY4oLOMW2Y/VgdHDFG8JJS9cQYJ0+lmmc7E6vAFo
	GH9bjJRYhfbRcTay8s2EMecS3vVY89iPnLllP9jfzmCuVKHq33egzC3u+HJEmq9RC7uX0f8qC/J
	s8pSJViA8fCkgEhxAcac06dTaEUyIdVr/Me3SNdG2sTsm0lqXZnnFZiVULeP2mq3vrd6OvcLzVB
	Evr+ani/yHwyGaJFSSdC50RpB1+hF4o/aSBQRfYEFgMU6Wo+2lPeYUMp8Hj7ORlbRX+1WD0+D6l
	zs7MtISVR3LYYdZ0VSJWu/Mi3oKfR6TkZ44ZQWB1xBODWsefFFGJ05PQQfZFluu4CoAlXJQ00ZG
	D8WNv6eal0oDGtppADEnd9Xq9
X-Received: by 2002:a05:600c:6812:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-483c9ba3af1mr238405765e9.6.1772535391876;
        Tue, 03 Mar 2026 02:56:31 -0800 (PST)
X-Received: by 2002:a05:600c:6812:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-483c9ba3af1mr238405265e9.6.1772535391377;
        Tue, 03 Mar 2026 02:56:31 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750701sm492414275e9.11.2026.03.03.02.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 02:56:30 -0800 (PST)
Message-ID: <81b7e296-0cfe-4c24-ac97-7f6c712aa0e9@redhat.com>
Date: Tue, 3 Mar 2026 11:56:29 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: Force full-page RX buffers for 4K
 page size on specific systems.
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, dipayanroy@microsoft.com
References: <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 744421ED38A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9106-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2/27/26 11:15 AM, Dipayaan Roy wrote:
> On certain systems configured with 4K PAGE_SIZE, utilizing page_pool
> fragments for RX buffers results in a significant throughput regression.
> Profiling reveals that this regression correlates with high overhead in the
> fragment allocation and reference counting paths on these specific
> platforms, rendering the multi-buffer-per-page strategy counterproductive.
> 
> To mitigate this, bypass the page_pool fragment path and force a single RX
> packet per page allocation when all the following conditions are met:
>   1. The system is configured with a 4K PAGE_SIZE.
>   2. A processor-specific quirk is detected via SMBIOS Type 4 data.
> 
> This approach restores expected line-rate performance by ensuring
> predictable RX refill behavior on affected hardware.
> 
> There is no behavioral change for systems using larger page sizes
> (16K/64K), or platforms where this processor-specific quirk do not
> apply.
> 
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 120 ++++++++++++++++++
>  drivers/net/ethernet/microsoft/mana/mana_en.c |  23 +++-
>  include/net/mana/gdma.h                       |  10 ++
>  3 files changed, 151 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 0055c231acf6..26bbe736a770 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -9,6 +9,7 @@
>  #include <linux/msi.h>
>  #include <linux/irqdomain.h>
>  #include <linux/export.h>
> +#include <linux/dmi.h>
>  
>  #include <net/mana/mana.h>
>  #include <net/mana/hw_channel.h>
> @@ -1955,6 +1956,115 @@ static bool mana_is_pf(unsigned short dev_id)
>  	return dev_id == MANA_PF_DEVICE_ID;
>  }
>  
> +/*
> + * Table for Processor Version strings found from SMBIOS Type 4 information,
> + * for processors that needs to force single RX buffer per page quirk for
> + * meeting line rate performance with ARM64 + 4K pages.
> + * Note: These strings are exactly matched with version fetched from SMBIOS.
> + */
> +static const char * const mana_single_rxbuf_per_page_quirk_tbl[] = {
> +	"Cobalt 200",
> +};
> +
> +static const char *smbios_get_string(const struct dmi_header *hdr, u8 idx)
> +{
> +	const u8 *start, *end;
> +	u8 i;
> +
> +	/* Indexing starts from 1. */
> +	if (!idx)
> +		return NULL;
> +
> +	start   = (const u8 *)hdr + hdr->length;
> +	end = start + SMBIOS_STR_AREA_MAX;
> +
> +	for (i = 1; i < idx; i++) {
> +		while (start < end && *start)
> +			start++;
> +		if (start < end)
> +			start++;
> +		if (start + 1 < end && start[0] == 0 && start[1] == 0)
> +			return NULL;
> +	}
> +
> +	if (start >= end || *start == 0)
> +		return NULL;
> +
> +	return (const char *)start;

If I read correctly, the above sort of duplicate dmi_decode_table().

I think you are better of:
- use the mana_get_proc_ver_from_smbios() decoder to store the
SMBIOS_TYPE4_PROC_VERSION_OFFSET index into gd
- do a 2nd walk with a different decoder to fetch the string at the
specified index.

/P


