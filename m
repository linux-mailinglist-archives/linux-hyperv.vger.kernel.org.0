Return-Path: <linux-hyperv+bounces-2056-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9F38B6D81
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Apr 2024 10:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3481F21F2B
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Apr 2024 08:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21909199E9B;
	Tue, 30 Apr 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tky1BCLf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E447194C9F
	for <linux-hyperv@vger.kernel.org>; Tue, 30 Apr 2024 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467178; cv=none; b=ICC5vD+xOxjDzNzd19dZeubYmkZFZC0OXRql8RYspZer9LkvH0b+oQkIB5/4SyW5IgjhyIVAQmprFSSo2eU6/DGHE4051CIMDnRYZX2REwoIa0O5I+bv9460XDSvaCDYUvAvta9dqR+rPDAhZNC44btmgEPMC6uasCsrmLDhN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467178; c=relaxed/simple;
	bh=FMYtqdX7LBrGeycIwufcBfemDYQ/h2L76qvKvdaCp+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T0x6lB8F66JbHPKchv92B01jYz1+Aj1sk5DVlGyIjtfK4xXqwR1Aodfiwdvhcqieqh4Gf0ho86XuTiYYF/PPnhG85VSBc8tA0rHUqUW3n/YJkD0VylJL1am/IE/ZOATfWmYVKqdwT5tThMJajrEW63ebFZtM0lS+E4XKoyIL4XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tky1BCLf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714467175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4RGAMSRvGmFBURPdPPDKTgQXlqXHnKZVqOJq0Gtgi5s=;
	b=Tky1BCLfQwpaGd5ib9Sak//zp2JnFOswX6VfWCcKUxPvWNJg4ySsqw5Ly0xZDww+cG1HxU
	qSIUfhUa6Meb7KQguio7eHYnCNtNYR9RGdnvFHo42oaWTsQipje7WQ8yQ7RYwW+uczMDaO
	zwVTW6rgpz5Zl3PVpGH+iJD6s2pNYwk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-OBkrouwbN1OV-ldYoOQkmg-1; Tue, 30 Apr 2024 04:52:53 -0400
X-MC-Unique: OBkrouwbN1OV-ldYoOQkmg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-418f18458a0so28163505e9.0
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Apr 2024 01:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714467172; x=1715071972;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RGAMSRvGmFBURPdPPDKTgQXlqXHnKZVqOJq0Gtgi5s=;
        b=s9HS7dOZOBFyYGwedsTmJAdOQrMtwuMasvwWwtUhuTJ7qCkh/2Rh7JsD8gHLQhp7iD
         uOnqEXa3x93pTLh9Ego8a9itoQN1J9G7CEj9IXeXy43BImZJ+20ktkZP8rFDSmnuUGQH
         oH3jL1Nv/wiVoA2CyErN8e1MCaenH5+ntgiXW9c35KBuyMd6t2UHh/r3uc5XlBjab4Ue
         KQMfZkpU8FKFv/Qz+na6bSb/4PHR3caPZqBIedMvMBFi/0VAOrzkEldcMgyIRGF6iSEp
         mYeKTJRYERooRfIS1qnlJUrPcqcuc914Kr1QA+KVWpiPlwFVZMIQnofgND/KsrA+lzQB
         F2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLySDD1DPjDh7l6OCV6SzQ1aceVtPpI1V0v0jwkm8mqZ9dab4KVTMPQvF1c7xIZ/TsQk1lG/wJheqz6hmxuw9y9OR0d4xi05CvptN7
X-Gm-Message-State: AOJu0YzXkRN0FvCeKmRLLHh5TW286gEIU16k3WHIcRsUPPGPTHGo0zlb
	qhNsvTerjdjWnbe5hh7FPeGxYC7YqZV98et3x6pNPcYLYupI7oyiSlx9ytGO2BOHdYE7Kk0h48B
	36lKGg2TPFJ5AVQ3NR5S0DnPqtz5Gc/3oVrCaprjMJbzcWyAln8tDown6JpEvAw==
X-Received: by 2002:a05:600c:154b:b0:416:9b7f:7098 with SMTP id f11-20020a05600c154b00b004169b7f7098mr10267756wmg.24.1714467172335;
        Tue, 30 Apr 2024 01:52:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaK0DC9JY5CABrF0rmDmhJGegKoXKpgkcqasi4Ije0f/QAtIFvXUi/TqPAi4fh0cnhKDT/kQ==
X-Received: by 2002:a05:600c:154b:b0:416:9b7f:7098 with SMTP id f11-20020a05600c154b00b004169b7f7098mr10267738wmg.24.1714467171892;
        Tue, 30 Apr 2024 01:52:51 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id a18-20020adffad2000000b0034c9b7d406dsm8372883wrs.75.2024.04.30.01.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 01:52:51 -0700 (PDT)
Message-ID: <c911ab92-1bec-4e5d-9bc8-5a6044f4948b@redhat.com>
Date: Tue, 30 Apr 2024 10:52:50 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hv_balloon: Enable hot-add for memblock sizes > 128
 Mbytes
To: Michael Kelley <mhklinux@outlook.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20240311181238.1241-1-mhklinux@outlook.com>
 <30d66f75-60c8-4ebf-8451-839806400dd4@redhat.com>
 <SN6PR02MB41571838C410EB52F328A461D4162@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157D5BB1C140D229875AB50D41B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <SN6PR02MB4157D5BB1C140D229875AB50D41B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.24 17:30, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com> Sent: Friday, April 26, 2024 9:36 AM
>>>> @@ -505,8 +505,9 @@ enum hv_dm_state {
>>>>
>>>>    static __u8 recv_buffer[HV_HYP_PAGE_SIZE];
>>>>    static __u8 balloon_up_send_buffer[HV_HYP_PAGE_SIZE];
>>>> +static unsigned long ha_chunk_pgs;
>>>
>>> Why not stick to PAGES_IN_2M and call this
>>>
>>> ha_pages_in_chunk? Much easier to get than "pgs".
>>
>> OK.  I was trying to keep the new identifier short so that
>> mechanically substituting it for HA_CHUNK didn't blow up
>> the line length.
>>
>>>
>>> Apart from that looks good. Some helper macros to convert size to chunks
>>> etc. might make the code even more readable.
>>
>> I'll look at this.  Might help the line length problem too.
>>
> 
> I didn't see any particular complexity in converting size to chunks. But
> this slightly opaque sequence is repeated in three places:
> 
> 	new_inc = (residual / HA_CHUNK) * HA_CHUNK;
> 	if (residual % HA_CHUNK)
> 		new_inc += HA_CHUNK;
> 
> If HA_CHUNK (or the new memblock size based variable) is a
> power of 2, then these can become:
> 
> 	new_inc = ALIGN(residual, HA_CHUNK);
> 
> which is a lot better.  I'll make that change, and a couple of other
> changes where things are open coded that could be existing
> kernel macros.

Cool! Make sure to CC me on v2.

> 
> Question:  Is memblock size guaranteed to be a power of 2?  It looks
> to be so in the x86 code, but I can't tell on s390 and ppc.  For safety,
> I'll add a check in the Hyper-V balloon driver init code, as the
> communication with Hyper-V expects a power of 2.

Yes, in memory_dev_init() we make sure that the size is a power of 2, 
and if it is not, we would panic().

-- 
Cheers,

David / dhildenb


