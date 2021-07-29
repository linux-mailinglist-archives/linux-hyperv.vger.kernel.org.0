Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC113DA4C0
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jul 2021 15:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhG2Nw4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jul 2021 09:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237759AbhG2Nwz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jul 2021 09:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627566771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F9YNVgi5mjssjfgte6PpoqdRDsA/3HAmopsrreQAnbE=;
        b=EK90hgRhs7wdeWITfWV4nrj19fh7vQCIyc78si9W9LuvPqOCiLpH9vOYD1kgtjO8Nr/bG2
        9yTARbsSiuOgGgFNAAOJXm2gIQdrIT9SYgevuh4btKza3LeRJiJO4kMwqPKBHQQ1EMLJwo
        HAVSwius/v2bfVjcPZc+1DXld/KEJt0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-8FhTCtrtMj66G8KRU8ikvw-1; Thu, 29 Jul 2021 09:52:49 -0400
X-MC-Unique: 8FhTCtrtMj66G8KRU8ikvw-1
Received: by mail-ed1-f71.google.com with SMTP id a23-20020a50ff170000b02903b85a16b672so2987688edu.1
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Jul 2021 06:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=F9YNVgi5mjssjfgte6PpoqdRDsA/3HAmopsrreQAnbE=;
        b=aCzPXuoImXpHLraNgLX+vM0bimrMghDnA7ekfWyL4lbfFbG93W+4RHvqRBnPKC4qxc
         bEAVx5tMw4nJWIL3hM0Y3ETrYpPSHYSU5JDGwoxiAbexld8mRxnjmw13Hvn+to6zw9+o
         2O7fSJQqSbOkfZHIgBt+dCyN3j/CuZD+9W+U40m14wiLO1n4b7f57RLlml6dh3lg7pOm
         cz8TwYtnjCyv0PWi1TwI/0cSImURMdPvUPKT3xQFg8z+Irw1YRjD99E3w0CDY/rOqk+k
         oVC1KJ+vxxqRpKgIZp4bfqsBEazsPYWxeFvMywlvIRxeQUtb+MQftU8xV+/LaEUpMUp4
         6Icg==
X-Gm-Message-State: AOAM532v6J63cfCd9HbWmVd+YMRMKCt+O02UWNOgGtQ5M5G+zq0KstM/
        apnTIys8IvB6o6MsAh3HekG5CY7XMezb0hnHG/sS5OgYWB/FwO/eyUPxsBV+bfSOYmyDnal0tCF
        LrhopPp+oGxZecN44cma8X5GE
X-Received: by 2002:a17:906:bc81:: with SMTP id lv1mr4787766ejb.413.1627566768634;
        Thu, 29 Jul 2021 06:52:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqOF3756d5z9BpPEe1R5UkZM63tlBPUSRiR/awLNseHBVxJ+51SrSEdODNARBBiPFD76nRaw==
X-Received: by 2002:a17:906:bc81:: with SMTP id lv1mr4787745ejb.413.1627566768412;
        Thu, 29 Jul 2021 06:52:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r18sm1249309edv.62.2021.07.29.06.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 06:52:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     Siddharth Chandrasekaran <sidcha.dev@gmail.com>,
        Liran Alon <liran@amazon.com>,
        Ioannis Aslanidis <iaslan@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic/hyperv: Fix struct hv_message_header ordering
In-Reply-To: <20210729133702.11383-1-sidcha@amazon.de>
References: <20210729133702.11383-1-sidcha@amazon.de>
Date:   Thu, 29 Jul 2021 15:52:46 +0200
Message-ID: <87eebh9qhd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Siddharth Chandrasekaran <sidcha@amazon.de> writes:

> According to Hyper-V TLFS Version 6.0b, struct hv_message_header members
> should be defined in the order:
>
> 	message_type, reserved, message_flags, payload_size
>
> but we have it defined in the order:
>
> 	message_type, payload_size, message_flags, reserved
>
> that is, the payload_size and reserved members swapped. 

Indeed,

typedef struct
{
	HV_MESSAGE_TYPE MessageType;
	UINT16 Reserved;
	HV_MESSAGE_FLAGS MessageFlags;
	UINT8 PayloadSize;
	union
	{
		UINT64 OriginationId;
		HV_PARTITION_ID Sender;
		HV_PORT_ID Port;
	};
} HV_MESSAGE_HEADER;

> Due to this mix
> up, we were inadvertently causing two issues:
>
>     - The payload_size field has invalid data; it didn't cause an issue
>       so far because we are delivering only timer messages which has fixed
>       size payloads the guest probably did a sizeof(payload) instead
>       relying on the value of payload_size member.
>
>     - The message_flags was always delivered as 0 to the guest;
>       fortunately, according to section 13.3.1 message_flags is also
>       treated as a reserved field.
>
> Although this is not causing an issue now, it might in future (we are
> adding more message types in our VSM implementation) so fix it to
> reflect the specification.

I'm wondering how this works for Linux-on-Hyper-V as
e.g. vmbus_on_msg_dpc() checks for mininum and maximum payload length:

        payload_size = msg_copy.header.payload_size;
        if (payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT) {
                WARN_ONCE(1, "payload size is too large (%d)\n", payload_size);
                goto msg_handled;
        }

        entry = &channel_message_table[msgtype];

	if (!entry->message_handler)
		goto msg_handled;

	if (payload_size < entry->min_payload_len) {
                WARN_ONCE(1, "message too short: msgtype=%d len=%d\n", msgtype, payload_size);
                goto msg_handled;
        }

Maybe it's vice versa, the header is correct and the documentation is wrong?

>
> Signed-off-by: Siddharth Chandrasekaran <sidcha@amazon.de>
> ---
>  include/asm-generic/hyperv-tlfs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 56348a541c50..a5540e9b171f 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -284,9 +284,9 @@ union hv_port_id {
>  /* Define synthetic interrupt controller message header. */
>  struct hv_message_header {
>  	__u32 message_type;
> -	__u8 payload_size;
> -	union hv_message_flags message_flags;
>  	__u8 reserved[2];
> +	union hv_message_flags message_flags;
> +	__u8 payload_size;
>  	union {
>  		__u64 sender;
>  		union hv_port_id port;

-- 
Vitaly

