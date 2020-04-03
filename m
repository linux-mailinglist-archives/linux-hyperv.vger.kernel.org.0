Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E041819D0BF
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2020 09:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbgDCHDf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Apr 2020 03:03:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59456 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730550AbgDCHDf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Apr 2020 03:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585897413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f1qqB1lJcxaOIJdybFP2nmQlGVmtCZINAz0JQfogkUI=;
        b=EVz3WfpEF0gnPvhk9FdxWq1ABPA8mDm/fUqIMitLu0RerevJQJxvPR/CoTR2i8slrqY5Z/
        CqjUhjpoOpE/bxz+plgK9eljZWVZysw/Iu3bQE6iiW7gzVAlVCCznu2ltAdjlx9ruFD96F
        Zb8oARh1vLteUTNpzg7dNoPnx/jcy7I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-tbhmMix7OJiJz2uWhkzsMQ-1; Fri, 03 Apr 2020 03:03:30 -0400
X-MC-Unique: tbhmMix7OJiJz2uWhkzsMQ-1
Received: by mail-wm1-f72.google.com with SMTP id u6so1681507wmm.6
        for <linux-hyperv@vger.kernel.org>; Fri, 03 Apr 2020 00:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f1qqB1lJcxaOIJdybFP2nmQlGVmtCZINAz0JQfogkUI=;
        b=hCyy4mxVo3Y/f2X8Ne41SUJ6BtssvW2rFyyH9+62ht/JD2a/6bAzjgdfb9Xj9Tch7o
         P8P8BTPAJ9Ag5GMyoZ7AU7IW6MUntFuj9sNdUMlkjO05r+vmeNM+1JKKmCMW5fy8OSbf
         ucJBTb+r8IZWYgBrkZh772zCTDYIY2S4O3WkN5eGYBmAQOXuaLw25Va3FPTOUdpo3qLi
         kF28jxJUpyh1CLof3bGVgMAqlmp6pJsAwNrhKXjalhhdUXys1MXcrozQu6rOL4ovF/Nw
         Kz6nbBOv57YtGIjdmmOcTLyODcF+H8XNBx6etTQH31h/HDY3RB0AaaFOuiN5yiWSDg5D
         leGg==
X-Gm-Message-State: AGi0PuaPrILRZMZ14pO03S9PKhrksciMQBqNVGTYr3r5VhXA963QfFdQ
        IYurCCOwyjnIH/z6V91qX43myY/+QxO9+RoIPswgC0NqrEJc1Ekv+dBNoUSMHaVpXGOCQubdnJt
        OhCJ6CtwedhBmtok62vgUtyQs
X-Received: by 2002:adf:9168:: with SMTP id j95mr7050289wrj.145.1585897409145;
        Fri, 03 Apr 2020 00:03:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypI9ApfdigOp/bpV3TSNlmrxc6hlVZfZJsgIPls3WO5f8QCC1uQMAwtm+TFeAzJrg1He2meKww==
X-Received: by 2002:adf:9168:: with SMTP id j95mr7050260wrj.145.1585897408903;
        Fri, 03 Apr 2020 00:03:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 9sm10024793wmm.6.2020.04.03.00.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 00:03:28 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri \(Microsoft\)" <parri.andrea@gmail.com>,
        163 <freedomsky1986@163.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/5] Drivers: hv: copy from message page only what's needed
In-Reply-To: <MW2PR2101MB1052836B9357770FBE0C3825D7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com> <20200401103638.1406431-2-vkuznets@redhat.com> <3ed15a02-0b86-0ec1-6daf-df94f8fc6ba5@163.com> <87a73tzwdv.fsf@vitty.brq.redhat.com> <MW2PR2101MB1052836B9357770FBE0C3825D7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
Date:   Fri, 03 Apr 2020 09:03:26 +0200
Message-ID: <875zehyrsx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Thursday, April 2, 2020 9:27 AM
>> 
>> 163 <freedomsky1986@163.com> writes:
>> 
>> > On 4/1/2020 6:36 PM, Vitaly Kuznetsov wrote:
>> >> Hyper-V Interrupt Message Page (SIMP) has 16 256-byte slots for
>> >> messages. Each message comes with a header (16 bytes) which specifies the
>> >> payload length (up to 240 bytes). vmbus_on_msg_dpc(), however, doesn't
>> >> look at the real message length and copies the whole slot to a temporary
>> >> buffer before passing it to message handlers. This is potentially dangerous
>> >> as hypervisor doesn't have to clean the whole slot when putting a new
>> >> message there and a message handler can get access to some data which
>> >> belongs to a previous message.
>> >>
>> >> Note, this is not currently a problem because all message handlers are
>> >> in-kernel but eventually we may e.g. get this exported to userspace.
>> >>
>> >> Note also, that this is not a performance critical path: messages (unlike
>> >> events) represent rare events so it doesn't really matter (from performance
>> >> point of view) if we copy too much.
>> >>
>> >> Fix the issue by taking into account the real message length. The temporary
>> >> buffer allocated by vmbus_on_msg_dpc() remains fixed size for now.
>> >>
>> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> >> ---
>> >>   drivers/hv/vmbus_drv.c | 3 ++-
>> >>   1 file changed, 2 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> >> index 029378c27421..2b5572146358 100644
>> >> --- a/drivers/hv/vmbus_drv.c
>> >> +++ b/drivers/hv/vmbus_drv.c
>> >> @@ -1043,7 +1043,8 @@ void vmbus_on_msg_dpc(unsigned long data)
>> >>   			return;
>> >>
>> >>   		INIT_WORK(&ctx->work, vmbus_onmessage_work);
>> >> -		memcpy(&ctx->msg, msg, sizeof(*msg));
>> >> +		memcpy(&ctx->msg, msg, sizeof(msg->header) +
>> >> +		       msg->header.payload_size);
>> >>
>> >
>> > Hi Vitaly:
>> >       I think we still need to check whether the payload_size passed from
>> > Hyper-V is valid or not here to avoid cross-border issue before doing
>> > copying.
>> 
>> Sure,
>> 
>> the header.payload_size must be 0 <= header.payload_size <= 240
>> 
>> I'll add the check.
>> 
>
> With this change,
>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>
> FWIW, all of this VMbus code, as well as the drivers for the VMbus
> synthetic devices, make the fundamental assumption that Hyper-V
> is trustworthy and doesn't send any malformed messages.  However,
> starting this summer we will be submitting changes to "harden" all
> of the interactions with Hyper-V to no longer make that assumption.
> All relevant fields will be checked before being used so that incorrect
> memory references aren't made.  This patch is one small step in that
> direction. :-)

What about 'alternetive' Hyper-V implementations? :-)

On a more serious note, my understanding is: if your hypervisor
misbehaves it's 'game over' for you (as a guest), the only question is
how hard is it going to be to figure out what happened. In this
particular case if hypervisor send us garbase we probably want to fail
immediately and not try to handle it as a valid message.

Thank you for your review!

-- 
Vitaly

