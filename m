Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362D03B70E0
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jun 2021 12:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhF2Kou (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Jun 2021 06:44:50 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhF2Kor (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Jun 2021 06:44:47 -0400
Received: from [192.168.1.155] ([95.114.16.105]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McY4R-1lO11G3vW1-00cvib; Tue, 29 Jun 2021 12:41:52 +0200
Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        longli@linuxonhyperv.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Long Li <longli@microsoft.com>,
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
 <YNq8p1320VkH2T/c@kroah.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <0391b223-5f8e-42c0-35f2-a7ec337c55ac@metux.net>
Date:   Tue, 29 Jun 2021 12:41:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNq8p1320VkH2T/c@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OSO02HYPMM+5Jqyg47RIhNF3Zn3nmEOfvvMXGJA3mWbUTDMKie8
 cc7U9UfweWNq0MHlXks+LPpmkk5Lf0xVzdcbxuM3WgjPWRljYNow1TvEOKp1WOpw8kCefWM
 hkas3XnsjcgVsqIaa/VxyFAopsMKFA6cTU3K3iLViyFYdghlU326FpzPYRwCeZWCDA8cbfN
 bUinZ1aMa3Yoe4ijsVCpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xpO6/AKkyxs=:fGpAGXbAKUYd6WDlpMOSS0
 uT3+xR6ozpDuhMGPEe1KNXqxiLMzJmHFLPLHcXFMQ9NFyyXuKk83nfGH4GzHQDXsxmaM4G5qb
 nDZIaC6MF/tvkmNJETh2zrSGbMiwH5MZQnjo9kVArIk71mdXigWLgXf5MXWgSxX+WJ09h4f2W
 Q7mZJHTKibesVyihMoEKLuIWg+bMGEExjMBr3GIhHiRh9Qy0Q8Izb2Y/j/6CEj0M2UYpSbfhK
 Y9Jj+Uv9UotFFS0wfCbBsrV0qOH8TUQdiOkJJN9Vt+Xiss1lcduJgk5fe+9sMDCTShUX6D6bf
 KVgTEbgtpkYtmosn8p+lGDQTshjtrlaFFBXbbrKLsK+bbOIEYNazmbt2ikngqu/V7iSn8HsXe
 7tEh/ao6DmU9412pVRZN0F5sK9GToSi/m7bXWMEwrpcmy3S5tXBP7dUbgzCYu5q83t7M4letS
 0eqim23FJW9lXZ858PXzG5eBmLJ21uKXrUO6We5aCqqs1pX+QaFyGpPmbYrOW8W6GaYuIt34z
 gHPcfkm0epjbbY3jd4A4c0=
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 29.06.21 08:24, Greg Kroah-Hartman wrote:

Hi folks,

> Again, no.
> 
> Just use dev_dbg(), dev_warn(), and dev_err() and there is no need for
> anything "special".  This is just one tiny driver, do not rewrite logic
> like this for no reason.

Maybe worth mentioning that we have the pr_fmt macro that can be
defined if some wants to do things like adding some prefix.

> No need to ever check any debugfs calls, please just make them and move
> on.

In this case a failed attempt to create debugfs files/dirs should not be
treated as some actual error, but a normal situation, therefore there
shouldn't be an error message.  (see debugfs.h)


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
