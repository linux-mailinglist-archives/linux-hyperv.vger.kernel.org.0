Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6C73B675E
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Jun 2021 19:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhF1RPi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Jun 2021 13:15:38 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57105 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhF1RPh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Jun 2021 13:15:37 -0400
Received: from [192.168.1.155] ([77.9.21.236]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MmU9R-1lXxnP12NF-00iRY3; Mon, 28 Jun 2021 19:12:42 +0200
Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
To:     longli@linuxonhyperv.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>, Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, linux-doc@vger.kernel.org
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <ff05bb0d-bcad-8445-d410-7756e7502352@metux.net>
Date:   Mon, 28 Jun 2021 19:12:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0+AMa/kSErV2OmQGfSr1RuyogIWsgnB+fX7o/AnCiCMg2R7VASN
 +sHgE0HSoXr6mZVWeJ4/O9y8FVVZAi2kF3pxSVPt32g1nXQk37qSq7GEFTArjPcIrvfrCKt
 OSe8qhT8dZThIk/87Tm4UO9CbEBRIVD9keS4WGcRQFjnjHyf48jyyLxW3uIX1dED4h09+kM
 YGeE09eON/GhDzYDG0YPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0I24CmwgILU=:wiWSa+j+RfnuHDhya9LBWI
 zNHcjXhBMCFDhRf8puFmO44aR3QOAA1evtkv3APGwUP1KzK6GCbn1mppvTtfZqHWc7z0f3ggw
 F3P4hrYJ7s4RRlVd3McqLg72wBQHOp5fJQDGlkHhzK7Q3/BMsq1/eJ1YASJCJHM21DiqWqjTv
 OgeKCaT3MlT/4xPjaQwXxHVQA/y6mKEnC6SKAqU8Pr54ixuujl5IXWu9YNpkjPf4R1JRY5sD7
 uNvTHgENYQ+PDk9bcDBDop8fjAtQzduDHF77ftTsDrsDsqEX9tZ/niI2naRoYDJpZ2wktxPLy
 zZ7ewbDHdZnxqj9oPTV55LeAyLquIJg8shRkmALQiHLYJZYZJ25kYef4DLg4PYE7DysOdDeoc
 X6LA3U7lIQAp/OauH9zB6Yif6QVAdZp3Qn39ISjIiepPwUFUp7PLIHnZbEB8RooFsamQ5perY
 E/fdF/IBxt8YyUXfEkUqloqIORsSpEAsN47FPgXgFhNIIZ2R2qQrOuDGmwRyF0/unbKOsAIVF
 p+V1Gbv8F02Bhei7+sKmxkB0fBQ3fY3AWQKrmEEskLjwFxS4FSgc2JBhxbNsNbySlVYAnrDmq
 gGW2s3SAd125H/NxPmmGq0mwxH2no1/A/4KcwhbDI/5kThfM/P7GhmsLNoMjzLlZozN1ScK4c
 BBRFete9lMav22pdO75SdW9Eqg5NVDpT9tzhs+3E1YuGFTSg/XFzBNCxlifPL9CMjBuVh4xy6
 ILuk+HZNhJTCo1+EW1ohddOqrci7wS79oqTCNsdpR0Sx8nUKzSz9gDI64liR8B3B2WHHW8sSK
 bTI1ozOoQB+q4H1wzUoay04ucvG13hbfW/bYFCFhQa5D41EimycoSDT5OfCF8oZysFxmrav
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 26.06.21 08:30, longli@linuxonhyperv.com wrote:

Hi,

> From: Long Li <longli@microsoft.com>
> 
> Azure Blob storage provides scalable and durable data storage for Azure.
> (https://azure.microsoft.com/en-us/services/storage/blobs/)

It's a bit hard to quickly find out the exact semantics of that (w/o 
fully reading the library code ...).  :(

> This driver adds support for accelerated access to Azure Blob storage. As an
> alternative to REST APIs, it provides a fast data path that uses host native
> network stack and secure direct data link for storage server access.

I don't think that yet another misc device with some very specific API
is a good thing. We should have a more generic userland interface.

Maybe a file system ?

OTOH, I've been considering adding other kind of blob stores (eg. venti
and similar things) and inventing an own subsys for that, so we'd have
some more universal interface. Unfortunately always been busy with other
things.

Maybe we should go that route instead of introducing yet another device
specific uapi.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
