Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B47519C704
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2020 18:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbgDBQ06 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Apr 2020 12:26:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48361 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731689AbgDBQ06 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Apr 2020 12:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585844817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i1hPxQZ7Mm/qEFVQDP8poIUxCGgiGUs8Gv2myvdE6Zk=;
        b=OpsyYHBm8Low6hS3O3HJvj2DABwmuUHX07gWnbMbv+KKFOqj91isWhhCzKlC+qc3LdzmJk
        vSDMooPp7kZBukvwqrj9mR6IzvoBD2QfSjejEz5id3aeAXEMhvnBxoTeRCUiCuFoHYiQeo
        ap0mS4hAy+jN+wzQUqVDhfXS+S95AWI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-YPvpSMZwNvmvkCA_j8U0QQ-1; Thu, 02 Apr 2020 12:26:55 -0400
X-MC-Unique: YPvpSMZwNvmvkCA_j8U0QQ-1
Received: by mail-wr1-f69.google.com with SMTP id k11so1695254wrm.19
        for <linux-hyperv@vger.kernel.org>; Thu, 02 Apr 2020 09:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=i1hPxQZ7Mm/qEFVQDP8poIUxCGgiGUs8Gv2myvdE6Zk=;
        b=TAq290PLrqARy3z6xHdCoyaN/JjEMXXD7G2tegc7l5qCqJhP1xce2eNFrc2mzUkCyC
         O+a3thbN/wvmu+S+OI2rji3Jaxjm87eATfw4qk61HkdmvVibCoqsPwL99b7ntoj3uoXI
         gr1a8hMWcx2KEIYzHGACkFVA40bw+3lGypEi4+gyXjQLAzekLSoDYxIj6DGi1mat3p+y
         mcJrSTkcKFHI28PZAaWMue3Wagk6z+vMxKXccPZzM1iV3yPSk7y+aZIHQQ7KA2/5gtDY
         is5FREhqZSkuSHh7WlcAhnKtPlm3b/VTkY27kJw5ID//9x251uuF4AVj5jyn4PVd95fz
         uiJQ==
X-Gm-Message-State: AGi0Pub4AUc27hiQFQ2+hf7AIfSX6mil8anWWBYGIUNbXAr0koDkxNWA
        SpNLBJHE2v5cjyCmktD/DAQ1XzD84H9fWs/SLypclksz33L21/DJNa9T2/6BCgXNlUU/f6HfZGJ
        CPGVZ/1CpafztCV5C+bdZ47aA
X-Received: by 2002:a1c:b7c2:: with SMTP id h185mr4308586wmf.67.1585844814129;
        Thu, 02 Apr 2020 09:26:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypJj8MtdbkTrtF/6xim1pBMiG2j2Ba38Z0fdoGdU9XGR5GAwyAOga8h+SKPWJjJ8EakD3pf1ZA==
X-Received: by 2002:a1c:b7c2:: with SMTP id h185mr4308564wmf.67.1585844813859;
        Thu, 02 Apr 2020 09:26:53 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o67sm7971904wmo.5.2020.04.02.09.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 09:26:53 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     163 <freedomsky1986@163.com>, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri \(Microsoft\)" <parri.andrea@gmail.com>
Subject: Re: [EXTERNAL] [PATCH 1/5] Drivers: hv: copy from message page only what's needed
In-Reply-To: <3ed15a02-0b86-0ec1-6daf-df94f8fc6ba5@163.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com> <20200401103638.1406431-2-vkuznets@redhat.com> <3ed15a02-0b86-0ec1-6daf-df94f8fc6ba5@163.com>
Date:   Thu, 02 Apr 2020 18:26:52 +0200
Message-ID: <87a73tzwdv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

163 <freedomsky1986@163.com> writes:

> On 4/1/2020 6:36 PM, Vitaly Kuznetsov wrote:
>> Hyper-V Interrupt Message Page (SIMP) has 16 256-byte slots for
>> messages. Each message comes with a header (16 bytes) which specifies the
>> payload length (up to 240 bytes). vmbus_on_msg_dpc(), however, doesn't
>> look at the real message length and copies the whole slot to a temporary
>> buffer before passing it to message handlers. This is potentially dangerous
>> as hypervisor doesn't have to clean the whole slot when putting a new
>> message there and a message handler can get access to some data which
>> belongs to a previous message.
>> 
>> Note, this is not currently a problem because all message handlers are
>> in-kernel but eventually we may e.g. get this exported to userspace.
>> 
>> Note also, that this is not a performance critical path: messages (unlike
>> events) represent rare events so it doesn't really matter (from performance
>> point of view) if we copy too much.
>> 
>> Fix the issue by taking into account the real message length. The temporary
>> buffer allocated by vmbus_on_msg_dpc() remains fixed size for now.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>   drivers/hv/vmbus_drv.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 029378c27421..2b5572146358 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -1043,7 +1043,8 @@ void vmbus_on_msg_dpc(unsigned long data)
>>   			return;
>>   
>>   		INIT_WORK(&ctx->work, vmbus_onmessage_work);
>> -		memcpy(&ctx->msg, msg, sizeof(*msg));
>> +		memcpy(&ctx->msg, msg, sizeof(msg->header) +
>> +		       msg->header.payload_size);
>>   
>
> Hi Vitaly:
>       I think we still need to check whether the payload_size passed from
> Hyper-V is valid or not here to avoid cross-border issue before doing
> copying.

Sure,

the header.payload_size must be 0 <= header.payload_size <= 240

I'll add the check.

-- 
Vitaly

