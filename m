Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F874568B35
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiGFO3V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 10:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiGFO3U (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 10:29:20 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7DD72658;
        Wed,  6 Jul 2022 07:29:19 -0700 (PDT)
Received: from [192.168.1.87] (unknown [122.171.17.200])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8CB0920DDC9F;
        Wed,  6 Jul 2022 07:29:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8CB0920DDC9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657117759;
        bh=PFSLHpgWMBD62kPT/Dh5GcD1zjQveXoTA7H8jWtS0Rg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jVZr9LrBR+IQGvZ5v0LFYRVWxc1CeuB0lMfFdHnt8C13yOgKFb1e72XpViMLqryKn
         p/V7BnBEwX7D8eTdxSh5EbmPxRA2LHEWM9N6nRP1Tl3YSgTpuU8FJ8lAGmzUGTKruO
         S+gW/SgtBRBLdxC7zGczPfmLf1iEG6MZSnaCQhtQ=
Message-ID: <1c4bc0cf-6665-3fe6-28d8-8e9613e3f9d4@linux.microsoft.com>
Date:   Wed, 6 Jul 2022 19:59:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scsi: storvsc: Prevent running tasklet for long
Content-Language: en-US
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com, mikelley@microsoft.com
References: <1657035141-2132-1-git-send-email-ssengar@linux.microsoft.com>
 <b4fea161-41c5-a03e-747b-316c74eb986c@linux.microsoft.com>
 <20220706095358.GA3320@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <20220706095358.GA3320@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 06-07-2022 15:23, Saurabh Singh Sengar wrote:
> On Wed, Jul 06, 2022 at 02:44:42PM +0530, Praveen Kumar wrote:
>> On 05-07-2022 21:02, Saurabh Sengar wrote:
>>> There can be scenarios where packets in ring buffer are continuously
>>> getting queued from upper layer and dequeued from storvsc interrupt
>>> handler, such scenarios can hold the foreach_vmbus_pkt loop (which is
>>> executing as a tasklet) for a long duration. Theoretically its possible
>>> that this loop executes forever. Add a condition to limit execution of
>>> this tasklet for finite amount of time to avoid such hazardous scenarios.
>>>
>>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>>> ---
>>>  drivers/scsi/storvsc_drv.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
>>> index fe000da..0c428cb 100644
>>> --- a/drivers/scsi/storvsc_drv.c
>>> +++ b/drivers/scsi/storvsc_drv.c
>>> @@ -60,6 +60,9 @@
>>>  #define VMSTOR_PROTO_VERSION_WIN8_1	VMSTOR_PROTO_VERSION(6, 0)
>>>  #define VMSTOR_PROTO_VERSION_WIN10	VMSTOR_PROTO_VERSION(6, 2)
>>>  
>>> +/* channel callback timeout in ms */
>>> +#define CALLBACK_TIMEOUT		5
>>
>> If I may, it would be good if we have the CALLBACK_TIMEOUT configurable based upon user's requirement with default value to '5'.
>> I assume, this value '5' fits best to the use-case which we are trying to resolve here. Thanks.
> 
> Agree, how about adding a sysfs entry for this parameter
> 

Sounds good to me. Thanks.

Regards,

~Praveen.
