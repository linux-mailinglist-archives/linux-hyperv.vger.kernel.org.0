Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA635604F4B
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Oct 2022 20:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJSSEE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Oct 2022 14:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJSSED (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Oct 2022 14:04:03 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60122.outbound.protection.outlook.com [40.107.6.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3761BB966
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Oct 2022 11:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqwuEVImSTpQhPDLQMmxbw0yeXTUuqVJ0E2WAwjMtaVqZa0aUl+UFapy5XTbbspT8OYNMPhRvn6jOwVuE+QSuorlqv1bMV79ofAZzGt2rZO0sVD9aarlyZgOcLF05Rkct/d4ms6pneA75ipoJRFxfh/wOPxHSy1tViOxgUuMkJGBL/WcBgKskteL6hBDOtB0OigckNuqLSDBhLdCkmUGnptLrLGPrnsztUkXAitIaTbrOpYjjFcG4uiRsAg2Zs+4/Pb/zaS5dVMl95pdUGky4EIwKX4KzUwNwpV1D4IDHoH19Opsv3oYlit8RVOP0xhMNXTOwshCypVz8raee4XvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs+FhT6DfVlbo1rRgiKciFrQ4G+cKMyMKx+ZTDrqppg=;
 b=EXgBZ8QSBM4tIhZUYw8dCY1055q4vilkFG9EXugt4ErK4P+b+9Wzbk+2apb4L6dmagk/ak/4eUPzny+IvxbkEwYNPtCK/OTuP/il9GPE0L0+X5c2/VCoxnwbdX0gZce+KAn7LPYtjz3pceL9LTJ/2ZMtAP/SCfd091/AZL9AbjAxTb6ICK8dCcT8GrlnneP/SsmxqJt7DnUw5t1jZ5xFExzy87Xd/DL2AiogZ1PhxHW64cWVzbRuoTW4+y878CNDOEV5VkrN1d6NCrMc5kR0JUNsNBq0LIHBrmLx1KJLp0u8MKY0kkpLU7l1tQAuoAMpfwIPH8Dsc90MXQAdAaNRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs+FhT6DfVlbo1rRgiKciFrQ4G+cKMyMKx+ZTDrqppg=;
 b=BuSEmh9nGARu45P88rDRbFsSp1/B1Qpd9h3vdG9AqBsE+JfFsvSG8KsAilXzjJwtCnmE7naIXPYIlkESJFTy59Er2MCDvu07u9h8bERFrf/YtTGRsGV8z7sbrxZFCjvLLHg1dvEEr+UlD6v1xxOv9b7rBhJt0WW4o7X3Lry8ssH1i4csZMa+ZbrpuFG8hIfJ+E4AZibd+8dr77hv8jeLYz6uJQ0kvi3AjQUdTjEcff9hBy/qjuW7SqnbvPky7BZfpVPppTBCaOm+0cJmuw6btju6nf1Z6SDf4zLHTdOhA1zUPoyJ4qM+LP0RTSxX6HQuagXmaXF6HJSdQhcudPBsBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by GVXPR08MB8235.eurprd08.prod.outlook.com (2603:10a6:150:16::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 18:03:53 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a%7]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 18:03:52 +0000
Message-ID: <022ee579-9347-cf82-d31c-c40d2f5efe12@virtuozzo.com>
Date:   Wed, 19 Oct 2022 21:03:50 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [RFC PATCH v5 0/8] Make balloon drivers' memory changes known to
 the rest of the kernel
To:     Konstantin Khlebnikov <koct9i@gmail.com>,
        "Denis V. Lunev" <den@virtuozzo.com>
Cc:     kernel@openvz.org, kernel test robot <lkp@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Wei Liu <wei.liu@kernel.org>, Nadav Amit <namit@vmware.com>,
        pv-drivers@vmware.com, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
References: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
 <CALYGNiONv3au6hbAva60jWurwkU5ancWo-o2v7tpSzwguqzD9g@mail.gmail.com>
 <1c69ff97-831d-ece3-7a52-bb7659fc8dd4@virtuozzo.com>
 <CALYGNiMMo7aqgQrcHBWaoU7O9Lpk1qCD2CmRJ5mw+-pFJwFajQ@mail.gmail.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <CALYGNiMMo7aqgQrcHBWaoU7O9Lpk1qCD2CmRJ5mw+-pFJwFajQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|GVXPR08MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f097a35-2691-40bd-505b-08dab1fc4819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+88ox2ErcbzznNIKVqOa2QnVyKVOk3NafSDrj7NY8217n8Ki7u9WaZ8mzUxotnLUkN0yAvnLkehA0LIr9G6WQ5pHMB500J0EBi5yJaBfPe6j6DO0WbF5eDBwvLb8oKXEHrQ0aKiReJmnvoUPNIbHfNpGYED6l52vwUvWqB9pWv//3uAEFB0o+sL9WWYLjVEqyJDz2me0XMvruXEyCCG34BMFJeXky0OdwKpTwv9mqAAdwXa5r/ZMmq6w2/PjonvXGeBl43ckHUK2jU213B+3uL9yrZ4x9nXrztr7QJuwwn98sUE/k/zdtZImBkG59BblQ3Dr0Uw/N5JE/QZooxYApD8+M6vHP3fBWgfPTvIq6XgCEPH38yCIDw7LrnUNiyTcqbUSoarMeiHt+ZZbYQ+pWPWX8gbBdN1+wGprcGXWY+zWMqyqSnsxGSJpmC1v7LZdxJbpoYEky8wuPy9A7lTfRAp1scPv8XVf6B3S32CCT0GmaCVYszkZdpMWXp6o67rTh7/qkyKcmakTpptKBNfJzbcJzD1VIoJMuSNflNCotVC878rtehhAtUlLmseCPCtF4/2LD7hobiBHGxtN+WzHyl//jbKXDSD7qnzHpTf67q8Kas5NY/fX5ioKI70Vx0vgmP2IHpzub1rYtHYfQuXxX/fvLzZXKiNsUzKUdH1Z2VawZx8bnPpp2PIWKDEwnX84Y2xHFGOCdTJsXPqahuJKz696IsjCfhV+UMPBgDi4g3e8Watq73NYkW8fYuENXJ7pLxjlGA0m1lBZt3dBCSrdsKXpkYSQyY8KbjAu2kGRXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(39850400004)(376002)(451199015)(41300700001)(6506007)(54906003)(6636002)(110136005)(316002)(5660300002)(8936002)(86362001)(36756003)(186003)(7416002)(2616005)(44832011)(31696002)(8676002)(4326008)(66556008)(6512007)(66946007)(26005)(66476007)(2906002)(53546011)(31686004)(38100700002)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGNINHZrZU10ajZPVHF2Vm5XVkJuNXozdmRvNjVrUXdidHZqTmxrS3A4WWdh?=
 =?utf-8?B?OTdQM3RLajBJNTRObGh2bkJoNnNRS0d0N2ppVWJKRmZrZU9RUjk2NndnYi8w?=
 =?utf-8?B?SGRydDdEYVU5OG1xVk5WbGZNendYejlMdFJjcmxoR0dZVXZRbUdVdDhKWEg3?=
 =?utf-8?B?UHhNZ2FIYmRTWC81enJ6N3JBbkpxTERVaUhJRUcrblhiOVIyNkxKdUl0Zlpi?=
 =?utf-8?B?T3U1K0R0WmZYZHhNbFVtcjN6K0lweUMvemROQnd4UWdEU2xIY3pNNXgvaHYx?=
 =?utf-8?B?cWlXT2s5ZHlCeVVOelpNRXdMT2FaQXFGM1NZRUF3VHJZOXZvZjUrbG0yRmdO?=
 =?utf-8?B?RmszMlNlTnYxQ1NicSs5WUFvMmJBNnZ1cXR5aDQ2TWNkaGNhWnZaeVhrS29P?=
 =?utf-8?B?ZWYxb3lBd3lsVWpoVG1rTHlkTGxpMkdyWk05akI0dmtFLzVCcGxBTnJUYXg0?=
 =?utf-8?B?NGZ5Y1BqZG1tYU5lVlU1ajdnVnlYUEMxZ3Z3Qi9vVWZ0Ujd2Q2ROLzczZE9U?=
 =?utf-8?B?RlFKam9rUldwbTBhakxyRHZPUlJhUzZYSVpBT1RzOWVpWHBwWVBqWFZuV2w3?=
 =?utf-8?B?WnpFemVUY05kdlZoOFpVcXVxT0daTUtYTE11bHpyYWMvRENwUEhwNXFPWmdS?=
 =?utf-8?B?Yi9CSzJLb1FoQlNMeTR2MFA5UVloVlEvWWxmNWx0ZVdlbTZNUFdqRDl4aUpW?=
 =?utf-8?B?SXVQZElESEx4MC9VRVUvbXhQMXZUeFRMbEJyTkVFQUgvYXFuK0JDa2dZL1FV?=
 =?utf-8?B?czV4OURGUDVzU1lyL2dNQXJTR2pZNXVuT0pZckwyMVFrdTBaSEdkL2RGV0hO?=
 =?utf-8?B?eWlUeWp2SnRJbElQWHBOOURzOUxnNk82U2NzR1ZlU2FOcjJoaVQ2TmZ3NGpP?=
 =?utf-8?B?SWdibjFjMStvUGdObnREUzJMcEZSSVVoaERGSGNkQjY5NWNESzhVNjc4VXAy?=
 =?utf-8?B?SmIvV1gzaDh1VkZvUW92dVkzWE5Fb1BIMW1Ya0w2a3YweDNqR2t3Y1NHV1Vr?=
 =?utf-8?B?b1l6T0huSTFVRVh1eDhqb2Jqdm5pZm9uVWwvUG5ZZVJIZFhzU0hyMEVWZjFN?=
 =?utf-8?B?WHJDSFJtL2VDK0JqUG5oSFFKRHdsakx2d0JjUzF5eG9FcDZSNjhySHVNTVps?=
 =?utf-8?B?dzVwZFUyRHFtaXlma0lReWk1ZnA4UkRVWlpUcVZ0aVZ6VFhUbkszQnRrdUh2?=
 =?utf-8?B?S01tR2I0ZXdQNXcwakZQd2kvZ1lLd1RiL2lrZ0NHVGcrcUMxU05jVFF4cWZq?=
 =?utf-8?B?WUhRUlhTenpEeUluZjVqR2xsL0V5UXAwczBHZE56SS9VSkk4L2xPcnlPak9z?=
 =?utf-8?B?dlFtakhFNDRFSVVLTG43TU5HcXJJMHVBK1R2VTNlVDdCdldPbDRycEVqSHRn?=
 =?utf-8?B?cVBxTFdIWGV2akhVMXdNNUxGRFBzbWZRU2h1Q21XQmVpYVZPVjZVVzlFUk1w?=
 =?utf-8?B?cUN0K3p6MVhZUzVrLzYySVlrZkJsQ29oVElIK1RmZjVDUCtIbHVBUXhQSVB0?=
 =?utf-8?B?ZnEyOWhsSS9oWC9EMnlWeWdYRG8ydUJTZEFzd044Q0d6ZTJENk9VNmFFU21Y?=
 =?utf-8?B?SDl1dDhWbDRZN2JXWkpqc2IwRWdaU3NiR1pTSGNLVVZoWFc3N2RMVVR2ZEJM?=
 =?utf-8?B?WThYUUVtYWRGdUFEQ1NCMm8wTFFEYTE0aGtkK2NnZVg3WGxnSDgrdGg2ZnpF?=
 =?utf-8?B?SXdaZ0hqSG1vSEw5aUV5K1NPV1hOZkxIMGhlOGY2VmFOWFg4NWZwd3I5blIy?=
 =?utf-8?B?eVJETWd0K0FsVEpKTUJQenA4Rmd4a2MwcytYNlpPSGloVUxUUnF3M0RyVUhF?=
 =?utf-8?B?VWNSaHZGQXd4SjkrZDR2L3lmSmhINmZiejBCNlBTZ0xuT2UyTStXV3hkWVB3?=
 =?utf-8?B?azcrdGdpbmZGUkJJVDArc3BvQ0tFN1A0ZGN6L0dmZFdpbEY2UUtLSnB5ZkVE?=
 =?utf-8?B?QVg4cVlNSGxnVUYwcUVtcVRSeDV0SkZRbUNhSExrZXhiR2NVd09vQ1JxbExJ?=
 =?utf-8?B?aXo1VTMrTmd1S2lOSFFIelI3elJtaTA0YVJmMmJYZFVtT3gyRlF2UC80YVlx?=
 =?utf-8?B?Zm8zYmtNOXNRQ2lpc0xqSFVWb0loNDYwSmlycEtwWk0wSFFQK3Y5RVVra0hD?=
 =?utf-8?B?cXR6YUxhWDZ0MTB0NDRRMWdIY2tjbjZTaVRDNmMvSVBzb3BZbzFxUVN1V0Qz?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f097a35-2691-40bd-505b-08dab1fc4819
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 18:03:52.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXLACakV7ixiNk09rriJ2OUBOckTu8+icagmOL+fDmZraY1odd+7KKtLrgwaK76yqU3xHj+4C607pinQeAYCfvh2cTtBZXh1+u0fiZYPBSHnoxfLSWmMQLzPgRGE5FmI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB8235
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 19.10.22 18:39, Konstantin Khlebnikov wrote:
> 
> 
> On Wed, 19 Oct 2022 at 14:06, Denis V. Lunev <den@virtuozzo.com 
> <mailto:den@virtuozzo.com>> wrote:
> 
>     On 10/19/22 12:53, Konstantin Khlebnikov wrote:
>      > On Wed, 19 Oct 2022 at 12:57, Alexander Atanasov
>      > <alexander.atanasov@virtuozzo.com
>     <mailto:alexander.atanasov@virtuozzo.com>> wrote:
>      >
>      >     Currently balloon drivers (Virtio,XEN, HyperV, VMWare, ...)
>      >     inflate and deflate the guest memory size but there is no
>      >     way to know how much the memory size is changed by them.
>      >
>      >     Make it possible for the drivers to report the values to mm core.
>      >
>      >     Display reported InflatedTotal and InflatedFree in /proc/meminfo
>      >     and print these values on OOM and sysrq from show_mem().
>      >
>      >     The two values are the result of the two modes the drivers work
>      >     with using adjust_managed_page_count or without.
>      >
>      >     In earlier versions, there was a notifier for these changes
>      >     but after discussion - it is better to implement it in separate
>      >     patch series. Since it came out as larger work than initially
>      >     expected.
>      >
>      >     Amount of inflated memory can be used:
>      >      - totalram_pages() users working with drivers not using
>      >         adjust_managed_page_count
>      >      - si_meminfo(..) users can improve calculations
>      >      - by userspace software that monitors memory pressure
>      >
>      >
>      > Sorry, I see no reason for that series.
>      > Balloon inflation adjusts totalram_pages. That's enough.
>      >
>     no, they are not at least under some circumstances, f.e.
>     virtio balloon does not do that with VIRTIO_BALLOON_F_DEFLATE_ON_OOM
>     set
> 
> 
>      > There is no reason to know the amount of non-existent ballooned
>     memory
>      > inside.
>      > Management software which works outside should care about that.
>      >
>     The problem comes at the moment when we are running
>     our Linux server inside virtual machine and the customer
>     comes with crazy questions "where our memory?".
> 
> 
> Ok. In this case balloon management is partially inside VM.
> I.e. we could report portion of balloon as potentially available memory.
> 
> I guess memory pressure could deflate balloon till some threshold set by 
> external hypervisor.
> So, without knowledge about this threshold there is no correct answer 
> about size of available memory.
> Showing just size of balloon doesn't gives much.

You need the current and the adjustment to get the absolute top.
If you check only totalram_pages() it is the current. To get the 
absolute maximum you need to know how much the balloon adjusted it.

The drivers that do not adjust totalram_pages() and leave the inflated 
memory as used assume that this memory can be reclaimed at anytime.
But that assumption is not completely true and provides the system with 
false totalram value. Why - VMWare does not have oom_notifier at all (it 
is possible to have sone other mechanism, i do not know), Virtio balloon 
reclaims 1MB on OOM _if_ it can.

-- 
Regards,
Alexander Atanasov

