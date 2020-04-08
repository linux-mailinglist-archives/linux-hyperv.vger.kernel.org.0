Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1DF1A294E
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2020 21:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgDHTYR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Apr 2020 15:24:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20078 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727717AbgDHTYQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Apr 2020 15:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586373855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rM2AllpyXY7ShvICsraKiOxw2/YebeJ26YLqQzcyXQw=;
        b=ReZ4cE6cJ4/BNr/RqQjpVtZ+B6m7RoUh9O8jcolgsc4niEfTrMOgSN7C8+pun+hPxEPUsK
        3qcHN6GRXSYqnOhrkstBfObk5dPAvE2qjTdaLh9n9Y6k2tZYqsvUvPh1ryC7CWRgiq/PzI
        /C5NmFcxpekFYb7XFs0wRVZooWm+RzM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-jJnK_nupMcW9T6w4KDggWA-1; Wed, 08 Apr 2020 15:24:11 -0400
X-MC-Unique: jJnK_nupMcW9T6w4KDggWA-1
Received: by mail-wm1-f70.google.com with SMTP id o26so748302wmh.1
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Apr 2020 12:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rM2AllpyXY7ShvICsraKiOxw2/YebeJ26YLqQzcyXQw=;
        b=aZDGVLuEnluFl5KC+vfRmf9oHfnaGjqneuqhvkTrQK4syk0ekI+wuU8b+9jvqJIHcQ
         TMPplQQAHZhBYswkhd6exG4nMMQqCFnzS5Q7wls5aLPL61smuSqwLxzMucJWbeAakLJp
         TWg53hyS7WEj3ITbap8SQ3ibAH6Ssc4kSvcW7JclZkWYsgoSTfVYGHs8/pvTyrmx4HrP
         0bYytHq8O2P5r0y3008cuVCtN5sNrZ0yuRhmmWPUzXGhNzDXx29qZZ0A3zuyzus/seyo
         IdfTWUtNBGruLMEgrn2o1wNbgB/Ve4jeCpPNAxqJzM/VAQcamWy/HoWlN/tKbd/YwmAE
         Ltig==
X-Gm-Message-State: AGi0PuYm/uH4/kFJIrF0OHprtx+mmm/gUJ3Bxt0TXcRBqGTSHUsMTlxX
        0MfXX7/d8hx5Y+Jm70L03dbis2ZOOYMacVhTgT9oK/9CUWSPurUywC4adimT1rmCB95r39t9W07
        tILaUa2yPsQd5XDZEiAgEe5y7
X-Received: by 2002:adf:8364:: with SMTP id 91mr171156wrd.36.1586373850397;
        Wed, 08 Apr 2020 12:24:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypKfyGuZhDcTX+fHc7e6x22wsZaM/1C+4qfhQ39ZVNXxi1OJc96DRxiwyLQO/tjF1Q/pTjfrrQ==
X-Received: by 2002:adf:8364:: with SMTP id 91mr171130wrd.36.1586373850160;
        Wed, 08 Apr 2020 12:24:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f4sm19680766wrp.80.2020.04.08.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 12:24:09 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu\@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Disallow the freeze PM operation
In-Reply-To: <HK0P153MB02732CCBDFA879FCE5CA48C7BFC00@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1586296907-53744-1-git-send-email-decui@microsoft.com> <877dyq2d4p.fsf@vitty.brq.redhat.com> <HK0P153MB02732CCBDFA879FCE5CA48C7BFC00@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
Date:   Wed, 08 Apr 2020 21:24:08 +0200
Message-ID: <87v9m9233b.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

>> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Sent: Wednesday, April 8, 2020 8:47 AM
>> > IMO 'freeze' in a Linux VM on Hyper-V is not really useful in practice,
>> > so let's disallow the operation for both Gen-1 and Gen-2 VMs, even if
>> > it's not an issue for Gen-1 VMs.
>> 
>> Suspend-to-idle may not be very useful indeed, however, it worked before
>> and I think we can just fix it.
>
> How can we fix Suspend-to-idle for a Gen-2 VM, in which no device can work
> as wakeup devices? Note: in the case of Suspend-to-idle, now all the vmbus
> devices including the synthetic keyboard/mouse are suspended completely.
>
> Are you suggesting hv_vmbus should distinguish Suspend-to-idle from
> hibernation, and for the former hv_vmbus should not suspend the synthetic
> keyboard/mouse?

Yes, basically.

>  This should be doable but IMO this is not a very trivial
> effort, and I'm trying to avoid it since IMO Suspend-to-idle is not really 
> useful in practice for a Linux VM on Hyper-V. :-)

Well, to me it's equally (not) useful in all other cases :-) I think we
should Cc: linux-pm@vger.kernel.org and someone will describe a real
world usecase to educate us, we'll then see if there is any Hyper-V
specifics.

>
>> In particular, why do we need to do
>> anything when we are not hibernating?
>
> Are you suggesting hv_vmbus should not suspend the vmbus devices at all
> in the case of Suspend-to-idle?

That what we were doing prior to the hibernation series, right? AFAIU
suspend-to-idle is basically 'no processes are scheduled' mode but we
don't really need to do anything with devices.

>
>> > +/*
>> > + * Note: "freeze/suspend" here means "systemctl suspend".
>> > + * "systemctl hibernate" is still supported.
>> 
>> Let's not use systemd terminology in kernel, let's use the ones from
>> admin-guide/pm/sleep-states.rst (Suspend-to-Idle/Standby/Suspend-to-RAM/
>> Hibernation).
>> --
>> Vitaly
>
> Thanks! I'll use the accurate terms.
>
> Thanks,
> -- Dexuan
>

-- 
Vitaly

