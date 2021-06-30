Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615163B8642
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Jun 2021 17:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhF3PcQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Jun 2021 11:32:16 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37441 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhF3PcQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Jun 2021 11:32:16 -0400
Received: from [192.168.1.155] ([95.114.41.241]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MjPYI-1lWSLb3WkU-00kxwg; Wed, 30 Jun 2021 17:29:21 +0200
Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     longli@linuxonhyperv.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, Long Li <longli@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
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
 <YNq8p1320VkH2T/c@kroah.com> <0391b223-5f8e-42c0-35f2-a7ec337c55ac@metux.net>
 <YNsPqJNb1lAafi7U@kroah.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <47232217-bbbf-0c52-b6e7-789fa72d44fe@metux.net>
Date:   Wed, 30 Jun 2021 17:29:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNsPqJNb1lAafi7U@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gdi8jj78Ow4dFif+/Rc/B55loqdhRJuapiZp5YQL7dDufjlMut+
 b9kF+d8BgF1S4T10cJ4fs/7W9St8bh0N9d0U87ie7PyekFx4IEpLXN1STrlGIfqgqK6qc5q
 nH0ccm4y1IabjT4kBGDD8U8R5DP4BLni06kOyuNJptuKeMv7DaOA106s62aphTkp+BqdET0
 d21wj1Irow/2NAtPAeOGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2qNHiJHnECQ=:nS0SmZGOBL7dA8Ml0ZLsje
 bHBLj/i6dHKJ9QqIve223FcgrbAJdSJSONHCRGr23u28RAXJdCcxtRq4GCK8/BBhFXO/aPbq7
 HbeAvIG8wSY0YxtkqpZtHFkhksgXIzsoCjoH9sB2JUqf5ID9GmElE+H2coINgLpxynnSPPTtk
 V4PXtuRAyOP9tP46YaJkENghiOGE9hyZOxAypB7ArA1R2hkx1fP2SLE1a84bamOsm2AFGDcTr
 wOK4jNt/8MTWbAkVzsrweBeCatF4b1jxjmKjGa5aV4K06O+8grioA1X4azpThS2R9E5jzpQz9
 HyxHTLP2WgOjutpZRgSxgqStbOZFSNNkUD2i/Z3sXwv7dc/LfHqrO87y3VdT6wqAkoJNeY4G7
 hrIVPAcg65jyw2WgNBHN0I1MgblFPBaYU87b+YpjzBHVDbgZWjaeWPFL2JQNUaSiqkMOJMJPu
 wRto5ma6l7fZA/qtkn5xM4SeyChKLLkSZn1UPYuLKAkfYKISC3bNOPQQX2RRtJ1c9K5SKI0iT
 MJ4p6VEqUdmXGgytkKU7BxECkWsVENdHtFKjVXLOd3ea0mY/ON1TKSAu6Ex9SjEQtlHGsw4Qa
 n9BuX3LVjF2TacF7hPP4iIUtfccehGW4WmL9t1pucAOLZurT7RknvwmLcD7uVpkUuiE6jAVQ1
 xqj39rVgMycOUUjJ+MgcqdPlWVq5RV7TTXorF4ArvWdXnZKeoqCA/L+4rBw7jVWLV3GMuM+/g
 RgX3VNP2oBZbh9YpZD5MBZIn8esTeQxH+trKfrBW7qc3D/Pu8VGf9hwnhZsNcx5HZ5wJ4s0Ku
 WCXBV/c+sZYNcoNCGYSQnyLCx7gAmVZME5YV7atQKZoqzqouIEtx5ehqvSjr3eeS6O87ttv
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 29.06.21 14:18, Greg Kroah-Hartman wrote:
> On Tue, Jun 29, 2021 at 12:41:49PM +0200, Enrico Weigelt, metux IT consult wrote:
>> On 29.06.21 08:24, Greg Kroah-Hartman wrote:
>>
>> Hi folks,
>>
>>> Again, no.
>>>
>>> Just use dev_dbg(), dev_warn(), and dev_err() and there is no need for
>>> anything "special".  This is just one tiny driver, do not rewrite logic
>>> like this for no reason.
>>
>> Maybe worth mentioning that we have the pr_fmt macro that can be
>> defined if some wants to do things like adding some prefix.
> 
> No, no driver should mess with that, just use dev_*() calls instead
> please.

Well, I've been referring to some scenario where you *really* want some
*additional* prefix over the whole file. But you're right, the good use
cases for that are very rare - dev_*() usually should already put enough
information into the message.


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
