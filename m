Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63022CC743
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 20:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgLBTya (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 14:54:30 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:35391 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgLBTya (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 14:54:30 -0500
Received: from [192.168.1.155] ([77.7.48.174]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MWRmF-1khPtM2VP1-00XquI; Wed, 02 Dec 2020 20:51:43 +0100
Subject: Re: [PATCH v3 00/17] Introducing Linux root partition support for
 Microsoft Hypervisor
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        sameo@linux.intel.com, robert.bradford@intel.com,
        sebastien.boeuf@intel.com
References: <20201124170744.112180-1-wei.liu@kernel.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <227127cf-bfea-4a06-fcbc-f6c46102e9e6@metux.net>
Date:   Wed, 2 Dec 2020 20:51:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201124170744.112180-1-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FDj+XlqsEiQwf6kKcNyGz6HylFiO49Ux9hA8YaPOZ1DCUh68xtn
 fvX2e/AjS8Dg+rDhaz4qtH61rxR6oY+fxjM9Bm+4mGuAdWdGLMcfqk9n898Ls0PIBIy84Ob
 DmUdaFVDl1Pd99tGagx21wa4AxgnElbTzF9H4IHFAAzpzsc/motLBbvakvx/XracfNf+EFq
 lFK5aQKq7xBuyBGi+SrGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fca7Z5IC6so=:9d2pDF6trxzpKm7G2jxhz8
 ODnPoOHC5brmQrZH8mhMhEH7VoI55ihmTV+ucLMG5SEaxeTds1ALoevp2A7cMHpOK5OvSNCLa
 Wdcrv/V6h3rU25ikcsvV2vg1wscc6sLBwG26ej/1/gzCEhmcUK97YxC+2R8tPr+rK3ckrCUdm
 d5HnRN35MLxgZHyPKyhMiu/YbF7y5LXEk7LxC9JXNdogExhpGAgyejkG8DleClIL8PfkSG0QJ
 7WSH3xSp6mOTtQJxMfPsIPac+86JckBWpdQEaEWuBc9NV2Dmnqvac9zttZltChm5HTpC2CwgM
 AL0XpoPZX3AccJ70BfcOwE/ueieV2rMUzK8Xhsv9/+Gk7eH5sEV5jRgmIdhttxW2EEQSyiYha
 j58pkXm/zvPlwnSq0swOJhgkPewa76k/jFB4cqs0TcbFmsHumfHL2kmX9E5ut
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 24.11.20 18:07, Wei Liu wrote:

Hi,

> There will be a subsequent patch series to provide a
> device node (/dev/mshv) such that userspace programs can create and run virtual
> machines. 

Any chance of using the already existing /dev/kvm interface ?

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
