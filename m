Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014CE1FAE8B
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 12:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgFPKuq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 06:50:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48466 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726052AbgFPKup (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 06:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592304644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Vs0qBJGF5Skn7e+ab03WoozZDmoJ3wPcLfeh/kmlAk=;
        b=N36N90szDLVU3v0W0oDci0GxFYLKJTx7kfAvVSu1oBl2nBhZjWYmyFn8jwQAi8rC0ec95Y
        NycY4FiyI88PNJVJq6vqJxLs4DEIrpzrkNAFBNDv86VGBaOPjsg7FC4h/1LQ11lVZ9xBMk
        sWG5TzZFcWiRpgmE8ncd3eZiq4hwTIA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-f1kw6I1ROn-fCRZKFluAvg-1; Tue, 16 Jun 2020 06:50:36 -0400
X-MC-Unique: f1kw6I1ROn-fCRZKFluAvg-1
Received: by mail-ed1-f69.google.com with SMTP id b100so5995615edf.2
        for <linux-hyperv@vger.kernel.org>; Tue, 16 Jun 2020 03:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9Vs0qBJGF5Skn7e+ab03WoozZDmoJ3wPcLfeh/kmlAk=;
        b=bLUFMctJUju7q+s1mKCEyYQZrUDszh3wjZp94AimLZYuGk2WDKhEXy5zLj3ONV+AEx
         vaSW52iYbehhAqP7geq6KpBUBmqnsB+mxpVckISAKo8vW+NhUsYgTaEjg4pI+Sd2hSln
         luvdWz1SPrXQ7lWppt8FXvmWpcMuzknbshZsr4x4GzSaBlWnyBNNXR5kBiZk1nbg/zKS
         xG0nULC0YJ85lv8eeaZWej+pRes4CUhigmPHKqrktPxf6q5iIsHu/L0+7ODqi0BXWxRN
         ZIjVp4He5y8G8+LLphQYqh7NEiajEYFsiGlypH5dKRo/SnsaktcGbxZgq/XeyXCFNp4R
         bXbw==
X-Gm-Message-State: AOAM5329vpGd1LeH8qelLAQHM7/rnq2G4VW+gX6HbT/HxqXhGIbw8cwj
        PB+ilQUnGVPnOWQFOFcLl+YKiTfAnDFUEOaIEG+qVDlMPo5E5mUbRjUUXDLOJgJ6D6/lBtnDaBq
        JeOwGWjFJVgMtrLuS12fGY8dZ
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr2101712ejx.479.1592304635674;
        Tue, 16 Jun 2020 03:50:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw87a28bFg8pZEku0ADK2i6m0pm5nzZqm2/cOZe9pSBkcaMlR+rMQluhXBQnviYJv6Z+sbDlQ==
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr2101700ejx.479.1592304635422;
        Tue, 16 Jun 2020 03:50:35 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id lx26sm10821467ejb.112.2020.06.16.03.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 03:50:34 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dexuan Cui <decui@microsoft.com>, Christoph Hellwig <hch@lst.de>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: hv_hypercall_pg page permissios
In-Reply-To: <20200616100810.GA28973@lst.de>
References: <20200407073830.GA29279@lst.de> <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net> <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87y2ooiv5k.fsf@vitty.brq.redhat.com> <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87blljicjm.fsf@vitty.brq.redhat.com> <20200616093341.GA26400@lst.de> <20200616095549.GA27917@lst.de> <20200616100810.GA28973@lst.de>
Date:   Tue, 16 Jun 2020 12:50:33 +0200
Message-ID: <878sgni8sm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Tue, Jun 16, 2020 at 11:55:49AM +0200, Christoph Hellwig wrote:
>> Actually, what do you think of this one:
>

I see Peter has some concerns but if vmalloc_exec() used to work then
open-coding it with the right flags should do. I've also tested your
patch with Hyper-V, it works, so:

Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com> 


> Plus this whole series to kill of vmalloc_exec entirely:
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/vmalloc_exec-fixes
>

FWIW, the vmalloc_exec() doing W+X allocation is misleading indeed, thus
killing it makes perfect sense.

-- 
Vitaly

