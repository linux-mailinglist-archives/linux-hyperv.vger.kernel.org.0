Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89D4D192B16
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 15:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCYO2w (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 10:28:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27994 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727580AbgCYO2v (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 10:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585146530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JqpwltFL/SwS1UhlcIi0MOoODF8Cpbq1cMt7ik4CiTE=;
        b=DwAtTY5FeL0l8g+pWuXvopKrrWYucGwQwduc1nrTtQ7hq6MspeALe2jGt6nVSw8qaYyb9K
        ynUd0CYmDS2h3vCjpFRhJeOex/BfNvmOWD6bkl/6GbbKsREAF1yXrgHu0AK2BRWP1/GPvY
        QPCJc3XcoxB2PUzEq+tApe7GKI40wDE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-f2Yi36SIPoqF5IrmnpfLjw-1; Wed, 25 Mar 2020 10:28:49 -0400
X-MC-Unique: f2Yi36SIPoqF5IrmnpfLjw-1
Received: by mail-wm1-f70.google.com with SMTP id 2so957631wmf.1
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Mar 2020 07:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JqpwltFL/SwS1UhlcIi0MOoODF8Cpbq1cMt7ik4CiTE=;
        b=Pz48DXrEngjv439YH0xo7Ys+f/9C+gBzipQ2aS5nkWp+dKoKInyWrU90zwTEnaa3TD
         qGOEp7eusHaF7eNALpXkfhob5RzhCguKDcpK6lkvAiiaDAwpko87shPj+tXoq41CB9R6
         3ufazYU1NVyLg0O/41Xzhl24C543Fxqj9SPEl+4orWgssNWt9ngSftZsOsSsSfDJU5Mm
         CKgXzNEkw5PCasVCbbdJyValT8JMoJYKhnUmU9j9eCSIoKkKz+4Oowk2AZ7Wa40x+BQV
         yIJDt5lmDpYX7Wfx8WoNoTDIdqQJf4MIUMuc7yE+86XpaUggN3RQ3R4DQzvIy5g0r2kT
         v4Jg==
X-Gm-Message-State: ANhLgQ0cSkVYnaTdDh5YTkWg0tfTCgxG5xrekgPMs4JzlQs1WgudZ/f+
        bX06YrCAW+HyZ6t+e4amC85uw/YNxuq9Ec9LOTW5QYAp8is04CCTrytUgI+d7W6nA3ArFhjGk4G
        7LG75R02njwneHxwctHN8Zo7g
X-Received: by 2002:a7b:c050:: with SMTP id u16mr4024616wmc.68.1585146527996;
        Wed, 25 Mar 2020 07:28:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtps1lqlEjeVqhmoxqx06a7QnIYlVTNWJazZkk/ssQW3dTzHNkG7M+s2wksPvvsb7XCMHkt2A==
X-Received: by 2002:a7b:c050:: with SMTP id u16mr4024590wmc.68.1585146527811;
        Wed, 25 Mar 2020 07:28:47 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v7sm9590018wml.18.2020.03.25.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:28:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Yubo Xie <yuboxie@microsoft.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        michael.h.kelley@microsoft.com
Subject: Re: [PATCH] x86/Hyper-V: Fix hv sched clock function return wrong time unit
In-Reply-To: <039e126f-f00d-d7e1-aa92-c049c9e3333b@gmail.com>
References: <20200324151935.15814-1-yuboxie@microsoft.com> <87ftdx7nxv.fsf@vitty.brq.redhat.com> <039e126f-f00d-d7e1-aa92-c049c9e3333b@gmail.com>
Date:   Wed, 25 Mar 2020 15:28:45 +0100
Message-ID: <87lfno5x0i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

>>> @@ -398,7 +399,8 @@ static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
>>>   
>>>   static u64 read_hv_sched_clock_msr(void)
>>>   {
>>> -	return read_hv_clock_msr() - hv_sched_clock_offset;
>>> +	return (read_hv_clock_msr() - hv_sched_clock_offset)
>>> +		* (NSEC_PER_SEC / HV_CLOCK_HZ);
>>>   }
>> 
>> kvmclock seems to have the same (pre-patch) code ...
>
>
> kvm sched clock gets time from pvclock_clocksource_read() and
> the time unit is nanosecond. So there is such issue in KVM code.
>

Ah, true, kvmclock is always 1Ghz so it's reading 'naturally' converts
to ns.

-- 
Vitaly

