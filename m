Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97FC138C9E
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2020 09:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgAMIHy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jan 2020 03:07:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22043 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728757AbgAMIHx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jan 2020 03:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578902872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/erZ8RnYKJRFY+c1GhVERMG1XNVgTxXo2w1hrK27Sb8=;
        b=RG0Wi7LXMbHj7Ex9SwF8FPhXKYwM7Dh8Ssy9aSU0pv1nt6CVLHtz6bFtEz9mZO5TblqtX+
        LsODUHyc0gKIUvby7awqIcd4jzVDc6J9hQ+x/SQZMluYgawD/NgIWhD1HcTYvBzFU7yB8z
        8yxYh0vdXa+z7U/elJi1ByQVWPuAAQE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-m7vfy-K-PKSqSkFrk8sdIQ-1; Mon, 13 Jan 2020 03:07:48 -0500
X-MC-Unique: m7vfy-K-PKSqSkFrk8sdIQ-1
Received: by mail-wr1-f72.google.com with SMTP id d8so4617009wrq.12
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jan 2020 00:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/erZ8RnYKJRFY+c1GhVERMG1XNVgTxXo2w1hrK27Sb8=;
        b=AKcVYA8ZHTReSviPlzoLROmXCCFgj/uiEzaJ0EaR8FBI09OFx/XktEz3Qswptnyd/+
         yGd7YqDpLgAdd+z0iI1fZN+b4y7JFj+ZFYh527yuDEjWq0Rom0bld1/iF9WP3RzaKR/Q
         ePIfDeqY4gqSlyjhLZfvD+4ragfsUOgc18vMDvax5z14VlljBKPYBZdRC57Ug3cCrvwB
         3KSqwz2furgKxyCBwu2jymB2v8g5lKz3DfLLEFdyoadMqxpy5XTUJPH7rLdBhr/FrlX9
         EwRaww7o7peO7I763+NalzV6gZITfeX8HyW19nQrIhIXbZj9GUzFS3fd2z9iywFQkVc4
         T4bA==
X-Gm-Message-State: APjAAAVWLopg1FFYgfxFUgcMCzg2LmcZ+NM05ana90Y1DX2QaoLLYkaP
        61QnScEdH1MM7wms2o+OJSIIIUaITPaHf9X7W7Ko2x7KDVmDQsSx71PvXbd7OG/g6i3gak6P22F
        LyLZeGYgqRTBNbJHsKZWJ0cN3
X-Received: by 2002:a5d:6748:: with SMTP id l8mr1396181wrw.188.1578902867669;
        Mon, 13 Jan 2020 00:07:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0QAjNUB/O8hGuT0Ik18PvHdQ1W7LOxSNRFjlfRDriRbr61B/AAKzt1NZh7J71GOTzCEVtdA==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr1396158wrw.188.1578902867410;
        Mon, 13 Jan 2020 00:07:47 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u7sm13323951wmj.3.2020.01.13.00.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:07:46 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Chen Zhou <chenzhou10@huawei.com>
Cc:     "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chenzhou10\@huawei.com" <chenzhou10@huawei.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>
Subject: RE: [PATCH] x86/hyper-v: remove unnecessary conversions to bool
In-Reply-To: <MW2PR2101MB1052B01B542F0C0A576928CBD73A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200110072047.85398-1-chenzhou10@huawei.com> <875zhjr074.fsf@vitty.brq.redhat.com> <MW2PR2101MB1052B01B542F0C0A576928CBD73A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
Date:   Mon, 13 Jan 2020 09:07:45 +0100
Message-ID: <87tv4zpyni.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, January 10, 2020 4:00 AM
>> 
>> 
>> I'd suggest we get rid of bool functions completely instead, something
>> like (untested):
>
> Just curious:  Why prefer returning a u16 instead of a bool?  To avoid
> having to test 'ret' for zero in the return statements, or is there some
> broader reason?

Basically to preserve hypercall failure code and not hide it under 'false'.

>> -				     ipi_arg.cpu_mask);
>> -	return ((ret == 0) ? true : false);
>> +	return (u16)hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
>> +					   ipi_arg.cpu_mask);
>
> The cast to u16 seems a bit dangerous. The hypercall status code is indeed
> returned in the low 16 bits of the hypercall result value, so it works, and
> maybe that is why you suggested u16 as the function return value.  But it
> is a non-obvious assumption.  

This is not obvious, I agree, and we can create a wrapper for it but we
more or less must convert it to 'u16': uppper bits don't indicate a
failure (e.g. 'reps complete').

-- 
Vitaly

