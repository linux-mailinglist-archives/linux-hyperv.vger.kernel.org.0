Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8CC397ADE
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jun 2021 21:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhFATyj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Jun 2021 15:54:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56916 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhFATyj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Jun 2021 15:54:39 -0400
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3900520B7178;
        Tue,  1 Jun 2021 12:52:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3900520B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622577177;
        bh=BO8+uDFANyDwxb1lOmLhq93F1Sm+u2bcLEGetwi6260=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MYT51VBAaoks+ThNiNYBDov8kdSMbV9b5tbxiMT4j/whoj+UiG/EEoAWvoCpAxNbS
         IQ1QCy6Ak9ry6QK9emFse9gEpPN7x4PvyxT+u6AZ/WbRHRE6WLDPkK8bEnGrL6AxeR
         d3/9zv0WqSLolPMfbImxXeHAiUFz3Y9IALFX/CB4=
Subject: Re: [PATCH 06/19] drivers/hv: create, initialize, finalize, delete
 partition hypercalls
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        vkuznets@redhat.com, ligrassi@microsoft.com, kys@microsoft.com
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1622241819-21155-7-git-send-email-nunodasneves@linux.microsoft.com>
 <20210601075951.2ssgwaajo53x2tna@liuwe-devbox-debian-v2>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <612dbeb1-3edc-a46f-46d2-01acc622c307@linux.microsoft.com>
Date:   Tue, 1 Jun 2021 12:52:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210601075951.2ssgwaajo53x2tna@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 6/1/2021 12:59 AM, Wei Liu wrote:
> On Fri, May 28, 2021 at 03:43:26PM -0700, Nuno Das Neves wrote:
> [...]
>> diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-tlfs.h
>> index 72150c25ffe6..8a5fc59bb33a 100644
>> --- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
>> @@ -101,7 +101,7 @@ union hv_partition_processor_features {
>>  		__u64 fsrep_stosb:1;
>>  		__u64 fsrep_cmpsb:1;
>>  		__u64 reserved_bank1:42;
>> -	};
>> +	} __packed;
>>  	__u64 as_uint64[HV_PARTITION_PROCESSOR_FEATURE_BANKS];
>>  };
>>  
>> @@ -111,7 +111,7 @@ union hv_partition_processor_xsave_features {
>>  		__u64 xsaveopt_support : 1;
>>  		__u64 avx_support : 1;
>>  		__u64 reserved1 : 61;
>> -	};
>> +	} __packed;
>>  	__u64 as_uint64;
>>  };
>>  
>> @@ -119,6 +119,6 @@ struct hv_partition_creation_properties {
>>  	union hv_partition_processor_features disabled_processor_features;
>>  	union hv_partition_processor_xsave_features
>>  		disabled_processor_xsave_features;
>> -};
>> +} __packed;
> 
> These hunks should have been squashed to the previous patch. They don't
> belong here.
> 
> Wei.
> 
Yes, I applied these to the wrong patch...oops!
