Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B723CF398
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 06:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348430AbhGTEBT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 00:01:19 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:35572 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347437AbhGTD5W (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jul 2021 23:57:22 -0400
Received: by mail-pj1-f41.google.com with SMTP id gp5-20020a17090adf05b0290175c085e7a5so1226350pjb.0;
        Mon, 19 Jul 2021 21:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UuFXwQNY/mN4t/E3n/ofLi3p4GNt3VYtvsh7leO3MBk=;
        b=K/CvLIZc5igxgZ1XwZEEyEMUVvryVb65SGp0klHNkDmrJKJCkaG0XXo+sbLIc5/APv
         QSswyFzfTqIa0mKkypB0dG5cjLF/hUsJPIFEyssz1GTZ1I8eFtmn34HZJ2m7eX6BdXn8
         4rP+GtvDBbxcNsh3h6vwDIH3INX9HN/zM0qA/OSKthAZehxv3y1s2s2+91ZmjKtpo23I
         1eqdeI5ipnSG/R8buD72M08Yejf5ed0xoWJ2IWi6M9hEYqyqMImXU8/Ek9n9XtdyUKnJ
         eKqXT2H8YwqAz9HmEjuJT/TGS+5aKuJ0SZCOuTIviFxDoY4aFzFxAZMJp1fpbgg2qBoC
         QLpw==
X-Gm-Message-State: AOAM531WRuHoJlQojlJu/B4ysKmytt2Bf0yX1CQ8+Ffa79BiapGbxe6G
        qi97viuXuCvhi2RMBb3FtJM=
X-Google-Smtp-Source: ABdhPJwghXuAtRgwfuKMsWiX0/I4sQpP6yUDq/43HEyffI2/FALbrl6Buza/NqHT0VhhuSmduOFdeQ==
X-Received: by 2002:a17:90a:bc83:: with SMTP id x3mr27733053pjr.17.1626755879221;
        Mon, 19 Jul 2021 21:37:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:3cca:2c81:f459:847a? ([2601:647:4000:d7:3cca:2c81:f459:847a])
        by smtp.gmail.com with ESMTPSA id n32sm21455123pfv.59.2021.07.19.21.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 21:37:58 -0700 (PDT)
Subject: Re: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
To:     longli@linuxonhyperv.com, linux-fs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <82e8bec6-4f6f-08d7-90db-9661f675749d@acm.org>
Date:   Mon, 19 Jul 2021 21:37:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 7/19/21 8:31 PM, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Microsoft Azure Blob storage service exposes a REST API to applications
> for data access.
> (https://docs.microsoft.com/en-us/rest/api/storageservices/blob-service-rest-api)
> 
> This patchset implements a VSC (Virtualization Service Consumer) that
> communicates with a VSP (Virtualization Service Provider) on the Hyper-V
> host to execute Blob storage access via native network stack on the host.
> This VSC doesn't implement the semantics of REST API. Those are implemented
> in user-space. The VSC provides a fast data path to VSP.
> 
> Answers to some previous questions discussing the driver:
> 
> Q: Why this driver doesn't use the block layer
> 
> A: The Azure Blob is based on a model of object oriented storage. The
> storage object is not modeled in block sectors. While it's possible to
> present the storage object as a block device (assuming it makes sense to
> fake all the block device attributes), we lose the ability to express
> functionality that are defined in the REST API. 
> 
> Q: You just lost all use of caching and io_uring and loads of other kernel
> infrastructure that has been developed and relied on for decades?
> 
> A: The REST API is not designed to have caching at system level. This
> driver doesn't attempt to improve on this. There are discussions on
> supporting ioctl() on io_uring (https://lwn.net/Articles/844875/), that
> will benefit this driver. The block I/O scheduling is not helpful in this
> case, as the Blob application and Blob storage server have complete
> knowledge on the I/O pattern based on storage object type. This knowledge
> doesn't get easily consumed by the block layer.
> 
> Q: You also just abandoned the POSIX model and forced people to use a
> random-custom-library just to access their storage devices, breaking all
> existing programs in the world?
> 
> A: The existing Blob applications access storage via HTTP (REST API). They
> don't use POSIX interface. The interface for Azure Blob is not designed
> on POSIX.
> 
> Q: What programs today use this new API?
> 
> A: Currently none is released. But per above, there are also none using
> POSIX.
> 
> Q: Where is the API published and what ensures that it will remain stable?
> 
> A: Cloud based REST protocols have similar considerations to the kernel in
> terms of interface stability. Applications depend on cloud services via
> REST in much the same way as they depend on kernel services. Because
> applications can consume cloud APIs over the Internet, there is no
> opportunity to recompile applications to ensure compatibility. This causes
> the underlying APIs to be exceptionally stable, and Azure Blob has not
> removed support for an exposed API to date. This driver is supporting a
> pass-through model where requests in a guest process can be reflected to a
> VM host environment. Like the current REST interface, the goal is to ensure
> that each host provide a high degree of compatibility with each guest, but
> that task is largely outside the scope of this driver, which exists to
> communicate requests in the same way an HTTP stack would. Just like an HTTP
> stack does not require updates to add a new custom header or receive one
> from a server, this driver does not require updates for new functionality
> so long as the high level request/response model is retained.
> 
> Q: What happens when it changes over time, do we have to rebuild all
> userspace applications?
> 
> A: No. We don’t rebuild them all to talk HTTP either. In the current HTTP
> scheme, applications specify the version of the protocol they talk, and the
> storage backend responds with that version.
> 
> Q: What happens to the kernel code over time, how do you handle changes to
> the API there?
> 
> A: The goal of this driver is to get requests to the Hyper-V host, so the
> kernel isn’t involved in API changes, in the same way that HTTP
> implementations are robust to extra functionality being added to HTTP.

Another question is why do we need this in the kernel? Has it been
considered to provide a driver similar to vfio on top of the Hyper-V bus
such that this object storage driver can be implemented as a user-space
library instead of as a kernel driver? As you may know vfio users can
either use eventfds for completion notifications or polling. An
interface like io_uring can be built easily on top of vfio.

Thanks,

Bart.

