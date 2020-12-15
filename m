Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E88B2DB005
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Dec 2020 16:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgLOP15 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Dec 2020 10:27:57 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:51457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbgLOP15 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Dec 2020 10:27:57 -0500
Received: from [192.168.1.155] ([95.118.67.37]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M5gAG-1kj8il3gV8-007FzC; Tue, 15 Dec 2020 16:25:10 +0100
Subject: Re: [PATCH v3 00/17] Introducing Linux root partition support for
 Microsoft Hypervisor
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        sameo@linux.intel.com, robert.bradford@intel.com,
        sebastien.boeuf@intel.com
References: <20201124170744.112180-1-wei.liu@kernel.org>
 <227127cf-bfea-4a06-fcbc-f6c46102e9e6@metux.net>
 <20201202232234.5buzu5wysiaro3hc@liuwe-devbox-debian-v2>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <87d94c39-e801-fbc6-8f7f-1f1b00fa719d@metux.net>
Date:   Tue, 15 Dec 2020 16:25:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201202232234.5buzu5wysiaro3hc@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:u1FUT+54OkFRaBGDWRBAw5zbqE2K/I5TZFTPkGUh/dd7cH1jFTj
 mUhmDEpGb91fCVtcwxUvoZIaZCKp3lkWXxShpLH/S/12kOxvjabVx/2foRSZW+42Z1JQKC6
 AjyXjUj84pw11oNIyUgNTSKhWbqtZoTC1lscxxIgb9/VWwOujwoHiCxlMcCO4ebh+NpBPf7
 b/wMkrH4xp6EizCpzQEBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AUUkvsgxnOI=:Wrxhtq575KoVIqZbSXmKiv
 q+DXEPY7m1Acl63rhzq36kEl0fmUDG+qf8lD+K6u06yxMMQ5KLdX7PskE1XZAp5hekiU2FaxW
 4KTz4cr0Ig3FyBImDKuRXgsbn6OjQTt1vbMlMeA69uQhZ9D6tUg07tsEp7g4vVvgHqh2sRUNx
 f1/0niKMVl2MsbzQAJsTCNzSvBUdqj2rBZULV/mPNt7MPs9E/ygTCQMHPgrqdmwT5FzurNr3h
 AMwckzFxxVsX45TA1HKFdV4jU5gTpiWToh8u+ovXWl+5qtJs2+shTkNHXI3Z90sLQkuPNT5VR
 V/bbuCvu2+BS+GeySOoQOL/yH0utTeVAc2L92V+8BmGCcPZ55R3lH/ZuB0GaBn30CYMiSPLJ4
 7fE/jQXulYt2+59ncoEScmYVLbnzDpsm9QLZerfG5Bv9pRa8ngDPZXrM0mlEF
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 03.12.20 00:22, Wei Liu wrote:

Hi,

> I don't follow. Do you mean reusing /dev/kvm but with a different set of
> APIs underneath? I don't think that will work.

My idea was using the same uapi for both hypervisors, so that we can use
the same userlands for both.

Are the semantis so different that we can't provide the same API ?

> In any case, the first version of /dev/mshv was posted a few days ago
> [0].  While we've chosen to follow closely KVM's model, Microsoft
> Hypervisor has its own APIs.

I have to admit, I don't know much about hyperv - what are the main
differences (from userland perspective) between hyperv and kvm ?


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
