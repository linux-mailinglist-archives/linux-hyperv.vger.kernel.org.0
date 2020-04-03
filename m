Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC2A19D0CF
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2020 09:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbgDCHHy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Apr 2020 03:07:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24600 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730550AbgDCHHy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Apr 2020 03:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585897672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6XkVKL4skcBI9I3qnEHa0ueL+rxPTyXtnrcDFqwnTr4=;
        b=hB2NCel44wQX4kZ9UQxJRzBm/YQddky9J8WD027dC4a1uyjkYJ/Fe5kL4OTHfFny3x0DtO
        Juo+JeOUKg1iE8Odmfxo6Q2vN70r+GYoa+F4SYQHprUDM2b2oUQyfivvbE8iVz9zPA50yI
        JGb70yJmA4/Athml5aa70MInHMYKJnw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-7rI74PDHPYiJhu0qUfe6_Q-1; Fri, 03 Apr 2020 03:07:50 -0400
X-MC-Unique: 7rI74PDHPYiJhu0qUfe6_Q-1
Received: by mail-wm1-f69.google.com with SMTP id o5so2393525wmo.6
        for <linux-hyperv@vger.kernel.org>; Fri, 03 Apr 2020 00:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6XkVKL4skcBI9I3qnEHa0ueL+rxPTyXtnrcDFqwnTr4=;
        b=jnpo7YcpmNFCdeiC7+6qsixRC/DBA2XAgrMuGI8Gqx3m0emlXOdhy1mYEkavhhm4+n
         AMSmatFaNqIOlrL9FRkdRCXZyL/w8Tz8dkBUFHsGqbiG215q4GJ5yZK+PYvkA/QmuG9F
         yv82gX32v3kSrGpLZuiSfFbfXlk5jO2uwJ7vUAQkJ3v6LF4tenyAyVhCFhfiZAdoMDPK
         aseYPbhHKTKMAGL1YSeEaGcSPVWOthI4Dffc3Ikxp/Xm5vNLyjsiXiJURJQwIWNbQdWn
         ynumFooSdnrnYxiVt4dthIT/Cb9X+KMp9Z6QtC2dwv+PePLyHjlhmUterHEQvhx8GCdV
         7YHg==
X-Gm-Message-State: AGi0PuacCFkMjSmdTTXT5K5VXCAcqv2H3k0FQCzKRb2USs4DfBC4EXXk
        tpZ5QFY8Z4zGWG16ce0aruX9cTi8ZIuWfPVwjXnqrVEghMwhJmNsL+2GM+a8y4H+IDnyvA4vs5Q
        12nrvTxNUES29Ef2oBKD1r1IU
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr7325856wrp.230.1585897669657;
        Fri, 03 Apr 2020 00:07:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypKj00MKc2lrco4DtzMzrre8ASngvPTRlJYQu6MPCyFkbxQQEZUm4rZj/EV1GW2sYRctom4M+w==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr7325834wrp.230.1585897669459;
        Fri, 03 Apr 2020 00:07:49 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u13sm11316556wru.88.2020.04.03.00.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 00:07:48 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri \(Microsoft\)" <parri.andrea@gmail.com>
Subject: RE: [PATCH 5/5] Drivers: hv: check VMBus messages lengths
In-Reply-To: <MW2PR2101MB1052E7B2458F489E0123C1D9D7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com> <20200401103816.1406642-1-vkuznets@redhat.com> <20200401103816.1406642-2-vkuznets@redhat.com> <MW2PR2101MB1052E7B2458F489E0123C1D9D7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
Date:   Fri, 03 Apr 2020 09:07:47 +0200
Message-ID: <87369lyrlo.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Wednesday, April 1, 2020 3:38 AM
>> 
>> VMBus message handlers (channel_message_table) receive a pointer to
>> 'struct vmbus_channel_message_header' and cast it to a structure of their
>> choice, which is sometimes longer than the header. We, however, don't check
>> that the message is long enough so in case hypervisor screws up we'll be
>> accessing memory beyond what was allocated for temporary buffer.
>> 
>> Previously, we used to always allocate and copy 256 bytes from message page
>> to temporary buffer but this is hardly better: in case the message is
>> shorter than we expect we'll be trying to consume garbage as some real
>> data and no memory guarding technique will be able to identify an issue.
>> 
>> Introduce 'min_payload_len' to 'struct vmbus_channel_message_table_entry'
>> and check against it in vmbus_on_msg_dpc(). Note, we can't require the
>> exact length as new hypervisor versions may add extra fields to messages,
>> we only check that the message is not shorter than we expect.
>
> This assumes that the current structure definitions don't already
> include extra fields that were added in newer versions of Hyper-V.  If they did,
> the minimum length test could fail on older versions of Hyper-V.  But I
> looked through the structure definitions and don't see any indication that
> such extra fields have been added, so this should be OK.
>

Yes, my understanding as well. When we decide to extend some of these
structures for newer VMbus version we'll have a choice: keep the require
length minimal or implement a more somplex check (e.g. add a 'length
check' function pointer to vmbus_channel_message_table_entry() -- or
pass 'length' to all message handlers and handle it ther). But as we
currently have no such cases this will definitely look over-engineered
so I decided to go the easiest way.

>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  drivers/hv/channel_mgmt.c | 54 ++++++++++++++++++++++-----------------
>>  drivers/hv/hyperv_vmbus.h |  1 +
>>  drivers/hv/vmbus_drv.c    |  6 +++++
>>  3 files changed, 37 insertions(+), 24 deletions(-)
>> 
>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>

Thanks!

-- 
Vitaly

