Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A23269879E
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Feb 2023 23:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBOWHP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Feb 2023 17:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOWHO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Feb 2023 17:07:14 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAE2142BC5;
        Wed, 15 Feb 2023 14:07:13 -0800 (PST)
Received: from [192.168.0.5] (unknown [71.212.161.12])
        by linux.microsoft.com (Postfix) with ESMTPSA id F37C220F9E28;
        Wed, 15 Feb 2023 14:07:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F37C220F9E28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676498833;
        bh=S6RXdRVGXa+bnxkUwhXNefXH4bN0NRj17zh5vaZdffQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UO1cRP6pG8+HRYeFKxom4oEvitg1stIt2S/cJLlNwAkIebmPLq6uFeTFhZosD05LF
         w4jL+8ZVvyDAIKeXBY/n/8ciz4aA7ALF8ADHOYMrrR3DE2v4t7ImRK7nRINm07+NN1
         e6d8EeSn7kW/eDatoy3Mnh6gJQKwodlCXdzl0mfE=
Message-ID: <26f3cf0e-a95f-0a94-5179-ad7ae7cf47f1@linux.microsoft.com>
Date:   Wed, 15 Feb 2023 14:07:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] x86/hyperv: Fix hv_get/set_register for nested bringup
Content-Language: en-US
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, mikelley@microsoft.com, kys@microsoft.com,
        Tianyu.Lan@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
References: <1675980172-6851-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y+pJDbMu8WEPFnEm@liuwe-devbox-debian-v2>
 <45ca8d38-34f4-2d17-bcd6-f62c1b7f0c3a@linux.microsoft.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <45ca8d38-34f4-2d17-bcd6-f62c1b7f0c3a@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/15/2023 8:35 AM, Jinank Jain wrote:
> The patch looks good to me, apart from the comments from Wei regarding styling.
> 
[..]
> On 2/13/2023 7:58 PM, Wei Liu wrote:
>>
>> I can fix these issues too if you don't end up sending a new version due
>> to other issues.
>>

Wei, feel free to fix the issues when you commit the patch.

Thanks
Nuno
