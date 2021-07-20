Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253D23CFD95
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbhGTOtL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 10:49:11 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:35341 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbhGTOgO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 10:36:14 -0400
Received: by mail-pf1-f171.google.com with SMTP id d12so19855359pfj.2;
        Tue, 20 Jul 2021 08:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FxHKIA6d476YSwGem4oYqSqtuJwfzxZyIwIAv3Y/bLc=;
        b=cNWLJLJguton8860X+8Yfy8TPhGNLPdE+Ur2H/KNUTa0G/4TOgtQE5adQ9T1jxiONA
         O+/XAiOGuUCWqPcFXr330V8B8BXsnEui5hFfPId9sRkCYBt1ng+u7ccIlvrky4nf83Ot
         z/U32vnwus+Vb8Gh7SOoKPiLLD4kPxqF/eRkMNFyK0QMe7MAEWCAyG1wP6MnKz5g6+dd
         qD6CW8XO1dGtTT2v3E+O685Xx04rvZjeXTaP9e2JYTqX20HaBEpcrO2L4l8Y+3Kr2JjW
         5YyjDYPo4gMI1OFq+XRFHuy8G+3NHx7SiBg7oY/mwZP4rpBBK75FdJNaafH5KQh80BwJ
         PGJA==
X-Gm-Message-State: AOAM533h/TRUindxCnjylgoLD32VB01eWWfnLznrfyx/Y2ShXQAjJhAB
        Hko/w99dJxZcJCeO3MzsiMQ=
X-Google-Smtp-Source: ABdhPJy9ELkMjd5dPxR/F99Bfm30AEv+7kHZdDzhtxub0LmnQYuoV9ZE9dN82yJxawaDDQZBuJfcsA==
X-Received: by 2002:a63:3dcb:: with SMTP id k194mr31004732pga.202.1626794133080;
        Tue, 20 Jul 2021 08:15:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:9fa9:39d2:8b59:76ce? ([2601:647:4000:d7:9fa9:39d2:8b59:76ce])
        by smtp.gmail.com with ESMTPSA id n12sm25307625pgr.2.2021.07.20.08.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 08:15:32 -0700 (PDT)
Subject: Re: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
To:     Long Li <longli@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-fs@vger.kernel.org" <linux-fs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <82e8bec6-4f6f-08d7-90db-9661f675749d@acm.org>
 <YPZmtOmpK6+znL0I@infradead.org>
 <DM6PR21MB15138B5D5C8647C92EA6AB99CEE29@DM6PR21MB1513.namprd21.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <115d864c-46c2-2bc8-c392-fd63d34c9ed0@acm.org>
Date:   Tue, 20 Jul 2021 08:15:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR21MB15138B5D5C8647C92EA6AB99CEE29@DM6PR21MB1513.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 7/20/21 12:05 AM, Long Li wrote:
>> Subject: Re: [Patch v4 0/3] Introduce a driver to support host accelerated
>> access to Microsoft Azure Blob
>>
>> On Mon, Jul 19, 2021 at 09:37:56PM -0700, Bart Van Assche wrote:
>>> such that this object storage driver can be implemented as a
>>> user-space library instead of as a kernel driver? As you may know vfio
>>> users can either use eventfds for completion notifications or polling.
>>> An interface like io_uring can be built easily on top of vfio.
>>
>> Yes.  Similar to say the NVMe K/V command set this does not look like a
>> candidate for a kernel driver.
> 
> The driver is modeled to support multiple processes/users over a VMBUS
> channel. I don't see a way that this can be implemented through VFIO? 
> 
> Even if it can be done, this exposes a security risk as the same VMBUS
> channel is shared by multiple processes in user-mode.

Sharing a VMBUS channel among processes is not necessary. I propose to
assign one VMBUS channel to each process and to multiplex I/O submitted
to channels associated with the same blob storage object inside e.g. the
hypervisor. This is not a new idea. In the NVMe specification there is a
diagram that shows that multiple NVMe controllers can provide access to
the same NVMe namespace. See also diagram "Figure 416: NVM Subsystem
with Three I/O Controllers" in version 1.4 of the NVMe specification.

Bart.


