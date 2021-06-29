Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884E43B7663
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jun 2021 18:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhF2QW0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Jun 2021 12:22:26 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48616 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbhF2QWZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Jun 2021 12:22:25 -0400
Received: from [192.168.86.36] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id 69EDB20B7178;
        Tue, 29 Jun 2021 09:19:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 69EDB20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624983598;
        bh=UGuCmY2gPMYQ9bMiW0tOwbjM4PjROH2J1POM9wWOptw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TBc3pWLxoG23SAWp+BADgnsv+ueyd/uIWg1s8zucmtRGgeKp20svoXBv3KKDjqAVW
         9xG9bWAuNOhAOUnGT/XcOQOiGiFhZXwYIuLcfc9pp6T62gs6ceNfEYxZItcT3HmK6Q
         vKAIGLikOZCXStOCC/mVjgec9c7K27jTjtmY1cOE=
Subject: Re: [PATCH 06/17] mshv: SynIC port and connection hypercalls
To:     Wei Liu <wei.liu@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <cover.1622654100.git.viremana@linux.microsoft.com>
 <3125953aae8e7950a6da4c311ef163b79d6fb6b3.1622654100.git.viremana@linux.microsoft.com>
 <87v96lykrz.fsf@vitty.brq.redhat.com>
 <20210629125519.27vv3afwhjoobekf@liuwe-devbox-debian-v2>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <5ab6720c-d44f-e9ff-5b0e-47d65d210e3b@linux.microsoft.com>
Date:   Tue, 29 Jun 2021 12:19:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210629125519.27vv3afwhjoobekf@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 6/29/2021 8:55 AM, Wei Liu wrote:
>
>>> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
>>> +			pr_err("%s: %s\n",
>>> +			       __func__, hv_status_to_string(status));
>>> +			ret = -hv_status_to_errno(status);
>> In Nuno's "x86/hyperv: convert hyperv statuses to linux error codes"
>> patch, hv_status_to_errno() already returns negatives:
> Yes, this needs to be fixed otherwise one of the following patch has the
> error handling check reversed.
Sorry I missed replying to this. Thanks Vitaly and Wei, I will have this 
fixed in the
next iteration.

~Vineeth
