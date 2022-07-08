Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0AA56C029
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jul 2022 20:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbiGHQZl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Jul 2022 12:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbiGHQZL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Jul 2022 12:25:11 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10096.outbound.protection.outlook.com [40.107.1.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8137C186;
        Fri,  8 Jul 2022 09:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKC3fTeFQu5FjXFKaGcRAhYbp0Mo5+MN0scGs0imndcJDep6CYreYQeIfe0WZaPOfE3HRLdWemutx3oyNu/CnqOAsW0hG1LWdhv3kicELL++OOe6G6/p1ay5MAGw7MQYZM/MzmgsbMVMMpu/nVTPa+PrZdTon43G2bxvEbRvL//caFy/+QMg5JfZp82XdnZRhidZfyDdhlgnIuS9zsSP7y26JV5rpANJnQN+Sat8HcYjWNYZ5GeYn4zM9QHAwt2VY28ZScYwL6yNyvJErriA5jR831zQbLHD/nnL9WmpH8QvHUAfpDVjG6RXG7mUjDfFkKGkjQLoXo6jNQM6llxexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txMYpc4RpQ1lICc1lPatZhdlTgopPWXqhPHjplaiJkA=;
 b=f1bI1e+9icX5W2xhotJoi6sAcCZlQKGpb9l9cjWFODcbhvPMIOY6W7+vKoVsKlq5z58/uh1AFGtigtYN0BkoRzTp/Gp9VAPhzyRw5eewuc7q9sIbZvxhlHxXgmOH5Yj+1z/oyTJY02bm05fFwqkFcyx726N+3oat18dQqyDYsxeOXJDP7tpdaFmartM7uaALrFF0cbjUr305Mn/vFQDoAB272bX7G7QhJ7bx2Yv4BztW/SNnFFoZwV29fkWbgVNNrUpWiSpm2E1BFWDXnvPyE+EDc6iK/ZJMSOqHdRRNATM7GMV0ZjC38rr4cgmntsuzcLXo3Ss0Xnrztgmh/wOxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txMYpc4RpQ1lICc1lPatZhdlTgopPWXqhPHjplaiJkA=;
 b=E6wel/zCdNn9ECDeXYw7UaK9LIugaC/4u/gmhA1lpDUul5E/FFxklx0ezMYxgT3EKEOtjf52cDtWpl1LHInM2ow6kkVEXyMhCMhzBApl2y4v1KGrIJr1nte4iUeaonlVB3jS+fqDujHIbog1O9RY7PnZ6qLVvitebk0wal0ekis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by VI1PR08MB3424.eurprd08.prod.outlook.com (2603:10a6:803:88::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Fri, 8 Jul
 2022 16:24:16 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2d53:2023:e29a:cf48]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2d53:2023:e29a:cf48%6]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 16:24:16 +0000
Message-ID: <c560498f-d036-3ba3-aa65-07ef20c67f6b@virtuozzo.com>
Date:   Fri, 8 Jul 2022 19:24:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 1/1] Create debugfs file with hyper-v balloon usage
 information
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     "kernel@openvz.org" <kernel@openvz.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220705094410.30050-1-alexander.atanasov@virtuozzo.com>
 <PH0PR21MB3025D1111824156FB6B9D0DCD7819@PH0PR21MB3025.namprd21.prod.outlook.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <PH0PR21MB3025D1111824156FB6B9D0DCD7819@PH0PR21MB3025.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9364e59e-10e1-42a6-5c03-08da60fe4d7b
X-MS-TrafficTypeDiagnostic: VI1PR08MB3424:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pbv3AxdWSOjiKfyTsJo2WBHiSI+ogmS3LAnbenuhNTRpx/xr12NDcNovfmzlqqu7Sl30uWrdwf1mz07Lt1A5PxOLcHwCFg2/o6+x4fmfCl5PpR7jYMWH85dPE24Yy9d50Sgb8XCWp6mqgKURQkY3Cop+PAYOojzfY2SX0HPCRAp0aQmn57krL3TbN8tv9K0LK7ZZ8kf2a3pWYlRdCdfodkrcNa77AAHmZF+GdMKTnMrIcc0TTiAHleif29YNvwocmeDLqNstVfZa2OhH8vHWsnQCFCENnob33EZnIcmLvVinqGWamqRuT0gdKofwvu+S5OtHhPU9MRJs+AudqPXhbQFrbr0KI8pGGy3g50E8CXrs+gZPRXSBEWPZLpqvujuwtgViX0eU5BJcpATp4gH/2Isj3kiQOmG50dKn4syAA8o9u38sRu2eD4msF4U8LFEEGjYWEouKURuEcNhpmENmJ3wJIR0mp3eCkfXMZpz/DfrWcYSfWleKs+FKN1zAGZ68dQu981qfop3LzjNx+Fwz2JFmKqjMFLWaI0SvQ11dT14zy/G8NTAGI/0B5CARQ7EiOba3hao0R77F7jallyfpd1JzY/WV/0CEjY3E9BZ2i1h4D8Wygjx4mkmQpXjpX+5gXaIeWf+oswt16H4XElCDQFeU1IdpuVhy9h/niBsuMoLPxlOEIxgL/8qNQ5ye2L5Qa6izNzkA00k5hq4sfQAZ/IwToefvoQfIU2qYfLuxsQEcGQvFJCnEbWHOKmDlE2rmhO6DeyRZ+Abd6YX6hSu5zabwZnNGeJkDIuE1Z6cKD4N/LATfx70//fRJDdOmp+bTwBgrMXbpPtm1yG0hUY6iAX5vcGh6JY14ngG+ae0jzOMhIYQyCGAMvZb70PLvwZ4n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39840400004)(366004)(346002)(136003)(31696002)(83380400001)(2616005)(66946007)(38100700002)(86362001)(316002)(38350700002)(66556008)(36756003)(2906002)(44832011)(110136005)(66476007)(6486002)(5660300002)(31686004)(8936002)(54906003)(4326008)(6512007)(52116002)(478600001)(186003)(26005)(6506007)(53546011)(41300700001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHUxTXNyTzVoakR5bUtQc3BHWitmRTE5ZGYydWYvYUh2Um8zWGN5QkZ1RmU2?=
 =?utf-8?B?M09ET1Z1ZWlIZVhqYzF0WkZPSHlialRFM0pCcUNoY0xaaE5lUXdhWStsZU5U?=
 =?utf-8?B?T2NhVk4zbHZrWjlCUHI1RXhZUlAvQ3ZSVkdmUG16QXQrRno3UWJRVXFKTXlR?=
 =?utf-8?B?cStSdVJLeFBKTUVQa3pIQ0RadWU5UXNoQVRGdTc2Mk9FaVhJaWdwNHlIMklz?=
 =?utf-8?B?WGxHRHhIK2JzM2MzWEJxTjdaV1JVeFlJc21qY2tHd0tmNWhOZlkxbnp5K0h4?=
 =?utf-8?B?SVB2cEh4U3hkSXB2WmFRV0YzclZZWEROcFRLOEFVM1NPTlBoaVFiOTRPa09j?=
 =?utf-8?B?WFg0dmpnamErUFBYVjFvUCtabGNjZXY1Nm1PaStQbGx4dTc2MHU1d1BKQ3dz?=
 =?utf-8?B?dzhvV0d5aFpZdkc2UTdsSnh0bHVxQjhJRy9oY3JVcURQOHdLNDB1ZDNUdE8x?=
 =?utf-8?B?U1Vsd3VNbTA5T1NzMm1vVVcxZXRJOTZnc2NnSGNEaDRLUTljTXZ1VWV1Y1J6?=
 =?utf-8?B?dkJKeS9hYkxmM0NXRG13UXV3bnJuZUl5RGo0c2hlNTBNSWRmN0VGV1Nnb1F4?=
 =?utf-8?B?ZThocjdzaTN6dU51TVg3VEJhN0tDUFEvZmFOcTJUN2NpZ1NncllTTnZSWlEx?=
 =?utf-8?B?Q08vbEJEQWRxWGx6UVJMSHpiWnl2dFdqVE9zRGtWMDNSbk9lQjNqZlp4RkFs?=
 =?utf-8?B?UGw0dHA0Nkg5MGx4aUJHSlFIWXJCaFVVK0hubFo3b0JJUE01VVhrZVFDVmxv?=
 =?utf-8?B?YWFhV2gvSTJpZTdzMk5xcjNId29tSHowY1l6NDhrSTBZRldRaTAwQlB3RUdp?=
 =?utf-8?B?V3JadU9PY2lRVU1wQzY4YktacjZWT29oNXJ0VWgzQzNBZzlBV1hqUFUrNXhx?=
 =?utf-8?B?d2ttMU1weFRGZEhKQWg2ZkU5dzdXdEM1SE5aZkNzVVNheWttaWk4dkRrNFpW?=
 =?utf-8?B?dU8xYkxGNzJiWTFMVUpibVd3TDZyYUNxUkQwSHJtMHkvRTNvVXlIazRrcXQ4?=
 =?utf-8?B?dUY2M1hMZE5zUk13NDJSVXp0SzYrQWQvMFliRDVta09vd0ZldmVTNzI5Slhh?=
 =?utf-8?B?UUtxeFQ2cG5sQVR6Z0ZRZkNMRkhlVmZiNnB5TWh3N0J0cmpMUllLeFpCZ3V4?=
 =?utf-8?B?eDdpV3FOSzYrR0N0S3lqdUNuZkR0ZDZrS0VoU1ZCTGtab0gzY0t0NDZjNERy?=
 =?utf-8?B?T25pbFZhbGtoOFZ0c3Yvc0dPMVNxOFlBbndZaFdtUW5VeFhPU3lxUDZBeFIx?=
 =?utf-8?B?WTNlUWRLODRkSnF3bXZtajZVSUoyMWJJd04wNThlUjg2U3Vlc3JCZ1U4Q3BM?=
 =?utf-8?B?ZXNyTzhHSkMwYU9Obnc0SE0wZmkxZjhrclhpZ0ErR1BPN05zblJpN3dPYUlG?=
 =?utf-8?B?d0QrM09xdisxSDRpV2NuVFlhemtzOUFRM21FclIyOE9sUERLQzNxbzF3bURO?=
 =?utf-8?B?QnhwRmMxNnlpTDNqQTZOM0FNY1BZcnJvdUdWU3RFWGhwSnVKSENYbVo2Vm5w?=
 =?utf-8?B?VTdETkYyeStWNmU3RU03UTZxZGJIb0RMellaRDNKNzUrTUxEY0VmU2p1Ny9L?=
 =?utf-8?B?Y0ZoK3M4b3M1eElkVW1seDZCeWE1MmFDU084ZDVhVHUzd2dVVkdzMVJVRkdU?=
 =?utf-8?B?WkVNR2xPa21iNGNjNXgrcnB4cmR1UnFwQU9INmRGNjEvd0JJOVg3RTlFR2dY?=
 =?utf-8?B?dUw5MmY5ZElVRGxnbTJHemVNb2k1K3oyUjgxNWxHMk15MjlzK1AxN1h6Z0tm?=
 =?utf-8?B?TFEyZ1Q3aTFyRi9ZOXRtSGZQcHl0SnhwVE04eVhnczBQaERXeThYeFgwNzIy?=
 =?utf-8?B?dU9Wb2V1a1RiMm9Ta1B2cE95amJqU1JSZnkwcGhZZHZFUXkrYnd3Ung0STdP?=
 =?utf-8?B?d3dwVEgrSTdoV3FQbjZtenFxdGs5aUJvbHVHMVV3NkFHQUc1cHBpRkFuQllV?=
 =?utf-8?B?REJua3NSdXFLV0dmRFU2OWwyTWY0OU40L1cyUVlwTEJWS1RDZVBrWlJiWkc2?=
 =?utf-8?B?QVRxZUdhQWdWL3YyZmZXRTByMlBHMCtjbWJ1Rk5aQ0J6UC9Cei9LaE4wQ2tz?=
 =?utf-8?B?cE15L2Z1c1Z1VERUWlVDQUowNmRVTys3RTRpVEJCY2ZyYVNLL3V6UVNzWXJ1?=
 =?utf-8?B?WnBVbnptcDcxajJjM0hTQTBsT2l1TXArRG5kcWttcWh1S0Vwb3FpSFBxOVRX?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9364e59e-10e1-42a6-5c03-08da60fe4d7b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:24:16.5798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMhxYcNrKmWJwTpuf5tRPQbfH3k5+DE1glncbOL+5Lms/pRNtYHOG4pOFnSsvrvop+EzzHGpLH86QOj9GzWkkkF+HcRU4SZyKkTxPy+j6JV/GLFFis/YUX/U0OOODxjr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3424
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

On 05/07/2022 20:12, Michael Kelley (LINUX) wrote:
> From: Alexander Atanasov <alexander.atanasov@virtuozzo.com> Sent: Tuesday, July 5, 2022 2:44 AM
>> Allow the guest to know how much it is ballooned by the host.
>> It is useful when debugging out of memory conditions.
>>
>> When host gets back memory from the guest it is accounted
>> as used memory in the guest but the guest have no way to know
>> how much it is actually ballooned.
>>
>> Expose current state, flags and max possible memory to the guest.
> Thanks for the contribution!  I can see it being useful.  But I'd note
> that the existing code has a trace function that outputs pretty much all
> the same information when it is reported to the Hyper-V host in
> post_status() every 1 second.  However,  the debugfs interface might be
> a bit easier to use for ongoing sampling.  Related, I see that the VMware
> balloon driver use the debugfs interface, but no tracing.  The virtio
> balloon driver has neither.  I'm not against adding this debugfs interface,
> but I wanted to make sure there's real value over the existing tracing.


Yes it is reported to the host but this is for the guest. The value is 
that the user space can track more accurate the memory pressure.

For example userspace cache size calculation based  on total and used 
ram can came out very wrong without balloon into account. If you have a 
nested virtualization/containers things can get confusing too.

VMWare have it already.  Virtio patches are waiting for response.


> See also some minor comments below.

Sorry, i missed the email.

>
> Michael
>
>> While at it - fix a 10+ years old typo.
>>
>> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
>> ---
>>   drivers/hv/hv_balloon.c | 127 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 126 insertions(+), 1 deletion(-)
>>
>>
>> Note - no attempt to handle guest vs host page size difference
>> is made - see ballooning_enabled.
>> Basicly if balloon page size != guest page size balloon is off.
>>
>> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>> index 91e8a72eee14..b7b87d168d46 100644
>> --- a/drivers/hv/hv_balloon.c
>> +++ b/drivers/hv/hv_balloon.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/jiffies.h>
>>   #include <linux/mman.h>
>> +#include <linux/debugfs.h>
>>   #include <linux/delay.h>
>>   #include <linux/init.h>
>>   #include <linux/module.h>
>> @@ -248,7 +249,7 @@ struct dm_capabilities_resp_msg {
>>    * num_committed: Committed memory in pages.
>>    * page_file_size: The accumulated size of all page files
>>    *		   in the system in pages.
>> - * zero_free: The nunber of zero and free pages.
>> + * zero_free: The number of zero and free pages.
>>    * page_file_writes: The writes to the page file in pages.
>>    * io_diff: An indicator of file cache efficiency or page file activity,
>>    *	    calculated as File Cache Page Fault Count - Page Read Count.
>> @@ -567,6 +568,14 @@ struct hv_dynmem_device {
>>   	__u32 version;
>>
>>   	struct page_reporting_dev_info pr_dev_info;
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +	/*
>> +	 * Maximum number of pages that can be hot_add-ed
>> +	 */
>> +	__u64 max_dynamic_page_count;
>> +#endif
>> +
>>   };
>>
>>   static struct hv_dynmem_device dm_device;
>> @@ -1078,6 +1087,9 @@ static void process_info(struct hv_dynmem_device *dm,
>> struct dm_info_msg *msg)
>>
>>   			pr_info("Max. dynamic memory size: %llu MB\n",
>>   				(*max_page_count) >> (20 - HV_HYP_PAGE_SHIFT));
>> +#ifdef CONFIG_DEBUG_FS
>> +			dm->max_dynamic_page_count = *max_page_count;
>> +#endif
> Arguably, you could drop the #ifdef's in the above two places, to reduce the code
> clutter.  The extra memory and CPU overhead of always saving max_dynamic_page_count
> is negligible.  What I don't know for sure is if the compiler or other static checking
> tools will complain about a field being set but not used.

Ok, i will drop them. If the tools complain i will have to fix it.

There is also a min dynamic memory size in the Hyper-V setup , which is 
interesting but the driver doesn't know about it.

>
>>   		}
>>
>>   		break;
>> @@ -1807,6 +1819,115 @@ static int balloon_connect_vsp(struct hv_device *dev)
>>   	return ret;
>>   }
>>
>> +/*
>> + * DEBUGFS Interface
>> + */
>> +#ifdef CONFIG_DEBUG_FS
>> +
>> +/**
>> + * virtio_balloon_debug_show - shows statistics of balloon operations.
>> + * @f: pointer to the &struct seq_file.
>> + * @offset: ignored.
>> + *
>> + * Provides the statistics that can be accessed in virtio-balloon in the debugfs.
>> + *
>> + * Return: zero on success or an error code.
>> + */
>> +static int hv_balloon_debug_show(struct seq_file *f, void *offset)
>> +{
>> +	struct hv_dynmem_device *dm = f->private;
>> +	unsigned long num_pages_committed;
>> +	char *sname;
>> +
>> +	seq_printf(f, "%-22s: %u.%u\n", "host_version",
>> +				DYNMEM_MAJOR_VERSION(dm->version),
>> +				DYNMEM_MINOR_VERSION(dm->version));
>> +
>> +	seq_printf(f, "%-22s:", "capabilities");
>> +	if (ballooning_enabled())
>> +		seq_puts(f, " enabled");
>> +
>> +	if (hot_add_enabled())
>> +		seq_puts(f, " hot_add");
>> +
>> +	seq_puts(f, "\n");
>> +
>> +	seq_printf(f, "%-22s: %u", "state", dm->state);
>> +	switch (dm->state) {
>> +	case DM_INITIALIZING:
>> +			sname = "Initializing";
>> +			break;
>> +	case DM_INITIALIZED:
>> +			sname = "Initialized";
>> +			break;
>> +	case DM_BALLOON_UP:
>> +			sname = "Balloon Up";
>> +			break;
>> +	case DM_BALLOON_DOWN:
>> +			sname = "Balloon Down";
>> +			break;
>> +	case DM_HOT_ADD:
>> +			sname = "Hot Add";
>> +			break;
>> +	case DM_INIT_ERROR:
>> +			sname = "Error";
>> +			break;
>> +	default:
>> +			sname = "Unknown";
>> +	}
>> +	seq_printf(f, " (%s)\n", sname);
>> +
>> +	/* HV Page Size */
>> +	seq_printf(f, "%-22s: %ld\n", "page_size", HV_HYP_PAGE_SIZE);
>> +
>> +	/* Pages added with hot_add */
>> +	seq_printf(f, "%-22s: %u\n", "pages_added", dm->num_pages_added);
>> +
>> +	/* pages that are "onlined"/used from pages_added */
>> +	seq_printf(f, "%-22s: %u\n", "pages_onlined", dm->num_pages_onlined);
>> +
>> +	/* pages we have given back to host */
>> +	seq_printf(f, "%-22s: %u\n", "pages_ballooned", dm->num_pages_ballooned);
>> +
>> +	num_pages_committed = vm_memory_committed();
>> +	num_pages_committed += dm->num_pages_ballooned +
>> +				(dm->num_pages_added > dm->num_pages_onlined ?
>> +				dm->num_pages_added - dm->num_pages_onlined : 0) +
>> +				compute_balloon_floor();
> Duplicating this calculation that also appears in post_status() is not ideal.  Maybe
> post_status() should store the value in a field in the struct hv_dynmem_device, and
> this function would just output the field.  Again, there's the potential for a code
> checker to complain about a field being written but not read.  Alternatively,
> the calculation could go into a helper function that is called here and in
> post_status().  I'm not sure if it is more useful to report the last value that
> was reported by the Hyper-V host, or the currently calculated value.  There is a
> trace point that records the values reported to the host, so maybe the latter
> is more useful here.

I will extract it in a function. The calculation is cheap and 
considering that the debugfs file will be rarely read it is better with 
function.

It came out this way because i initially tried to add calculations of 
page sizes in the case where balloon and host have different page sizes.

But later on i figured out that in that case the balloon is not working. 
This can of course be improved.

-- 

Regards,
Alexander Atanasov

