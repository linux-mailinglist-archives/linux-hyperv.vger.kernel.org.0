Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF86044A6
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Oct 2022 14:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiJSMLB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Oct 2022 08:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiJSMJl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Oct 2022 08:09:41 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70092.outbound.protection.outlook.com [40.107.7.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16F860C97
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Oct 2022 04:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwG5SIKcNgX7/zR8X5Wj5zq7ZPJFZut2NcgkYCAeJINDTMa3+gd1nsM5FFtutWVaFN60Xurcc+3JrIz77/xb0SQQ6q/3KhSsVaWJT89kuRT8fyp4T2RSI9YCOcoey30MlVdV2QgISI9LdX6kz+QhaPL+mYkLR3Czws+hzTDTimGr3MynYNP256rqbTWr8gmKVjjIXYabfc17K1bi0TdMzK1LEuHQgVF5VFq3H8m6eOn18BH5f99LAwYYI6tnKsFVZAHYeA4vDuoBloXCxqOmwbWnFcKlHA7P60H3BU2Nr1KeeAT54PD93dpQqRGTv5wuAm1msOCzZrHNNTTPPs6rrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPflqNVTjcIJi0I6gleyxBPiVTz6DIBxSfsAWHMsG/E=;
 b=D5+DW4LP5A2aZfCk+0XBPatUqq2BHMY9Nnl9rWp+r15cmv6U/vaeu2XHuk0MER0pOqf8fns6MO/oatiUj3mlhpzFgkJWPfdA8K66096NrWre9C2o6NLautovYm2CvWApCIYWTb7QwVdOripnrjWArmPc+uSrRsJncXo3l31DnOVpr5x74VfcfCDJo4rQ2C+5QJZyhALDZ78tNWixov/xgQsSpeG+yHYg53rgM4f+3HJRA7I5bANn2KBkc9IICC3tCngEvYXSr28utVCvG9mGr6QaJI61b+OsREMf1SWwikAjG3BnQ0KzvU9JoTegbrXU2YSpml2AQnEj1r5DTnCfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPflqNVTjcIJi0I6gleyxBPiVTz6DIBxSfsAWHMsG/E=;
 b=NNWz33lBNmMHsqtf7OGHCbe6h2h+bLbCWKDEYHxXzeEvnkOtp9bAkynlHvSgz4wz97E5qCvO+KSgij63Uyft/37SU1BlLngR8Bq1O8CfmjisXMCzuiyP8er6NFT3O+5Wr1peaNduY+uL2qDBSndE6KWqvBNNCKvbUrn/nhBbkFnzjqrPXwkzgNRWTVYr1WqSvWMxvCrFQ5tZOjSxdehYijz6Ituv+tInRNEZeEZLoR8Yu1ZFl7fuTvAMgrrbtonuis2kwuafPxe8gboEio6tIqq6WOeKPuKEWiVvr8WGmA7XhMWtUOZqEL9WwqNRLflRvW14N+DcAQkUav7qbv27CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by AS8PR08MB5943.eurprd08.prod.outlook.com (2603:10a6:20b:23e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 11:44:48 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a%7]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 11:44:47 +0000
Message-ID: <2c87f6a7-47ae-4d9d-292a-0ed5702e82d1@virtuozzo.com>
Date:   Wed, 19 Oct 2022 14:44:45 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [RFC PATCH v5 0/8] Make balloon drivers' memory changes known to
 the rest of the kernel
To:     Konstantin Khlebnikov <koct9i@gmail.com>
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
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <CALYGNiONv3au6hbAva60jWurwkU5ancWo-o2v7tpSzwguqzD9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0601CA0032.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::42) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|AS8PR08MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5251ca-a004-4e19-b493-08dab1c75320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agZ2/hSAMs9VNhd8mAKDSs0krEg+PGD72pAbdnKhiIQWIgUrtSIipuP+4K7NT0IVpBgy2OEuKt1Dkjj60wwKCFKGEqY1tbk7mebZyEOT/8ytKHinTk486Ihsm4JKJp4zswyBLP+mIXRUmxczFXc0wx4FaEhnh0q9BYLrOScEOWUGp2x/gXKb+VQCOheFBRA5zQCxNHOJsOI+/snIqhGrbeeyYyntO1/kHoNs0xCvs3b2sJOPkV3QWfybyJ9elwW/bup67GpNfjA2Bq2fLG8bZSS2zEVlaWiPH5UDJpy8oO3PheYqYAk4u4CSqZsqtw+VnxneS34eY8JbKe+oxRszI4zX6/HyaPsm47abZh6zC6fOnqgs1F8B2abd3yKjxttur5ehNBrYV/RPJZhmhbHKC7QGi0F9E4qD6BSRsIVLC3BJxCjY3PDE45KDmwH66WHtn+xoYqJrNDC8ii2HpHKoY2KCkhx4y3PxYPRh+Jg31IOw3MGBOrik0YhWvu56XXwDPL03PzLIOtj0P07Cbmtp1wyf0WWo8AUnEh6ONzezx/wiJGOwNJaCb00KO0L0U3sJjqFBGMjD6jcr9zDv1EhXwTPw9iFbM8BD95M8FDqNVgbaMqT6lFhlw4YE8xLjdIlW0n947In7NaHLKaMeKml4Bi89S1Fc4RooMRXrUBS8IEOVpWzkfY6VFR2lPRWLKY6NyAxt+3eYD/TEWaNiHumD5fqr8UIEDdZ837GZGBESL/IRDGGwSTVkZVyaqEEFVAhP5JRFEOPraH8viMHO1IZ5AYJublovESQ4h9Bwfr3oVWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39850400004)(366004)(451199015)(45080400002)(38100700002)(86362001)(31696002)(6512007)(5660300002)(8936002)(41300700001)(53546011)(6506007)(66476007)(66946007)(66556008)(26005)(4326008)(8676002)(44832011)(7416002)(2906002)(186003)(54906003)(6916009)(2616005)(316002)(36756003)(31686004)(6486002)(478600001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1puRmRPQlFKa0x5VStpeGpBZVlIenNpTWFISUhxM2hoUHNMS09LSnh2Q0Yw?=
 =?utf-8?B?YzlPeXNmYnBvUnd5d1NxNVZWNEF1M3c2TktWOS84RlkvZUlPR0RWLzYwbFc5?=
 =?utf-8?B?czhuYXlzL0hiN2lUcHhSdXU1TitxUGF0V1VmSER5VUU4Yk1pWEU1aHNvUWlz?=
 =?utf-8?B?d3IzTFNPbElaenkvMUc0Y0FlWEdzSGdBbzgwTWMwZVVEU2E4TTQyWEh0TlFN?=
 =?utf-8?B?ci96SEFhS2hzMWlVTzRBMHZhTVE2NW1lZlQybkxvdkM5ZVRwbUZDNDl0U2J3?=
 =?utf-8?B?MlB2ZWttY0RCa0pSbW9saHBlY2ZCT1AvVnhjZDVUYkdkUzZQRGZjaEpFd2tC?=
 =?utf-8?B?RW13ckovMnIwSW5PbWtiZ0hTUjJJbVlFeDFHa0RNOVZYenI4Ri9QL1NqK3Vh?=
 =?utf-8?B?WVVjUCtkRC9Xc21IdjhkQitycW44Z1Q0TTRDRHlndC8vNFVsdHFhdHhzU3hC?=
 =?utf-8?B?N0dKTlROWmxyajViV3BsRVMweXdDUGo4NVBydE45NjFIaVhTWkRlb3hTcWcy?=
 =?utf-8?B?cTduTE0yeWoxZ3dBMSt3dkluRlEwSVNucEZackpuM0JjL2NKMmRXRlkzYW8r?=
 =?utf-8?B?SkJnYWdFY3VvbFB4VkQvcVpWMUZFYUxVUWZVMDhqeE96SktUVGZGejRqNHpu?=
 =?utf-8?B?aEVEWXJvMHFtdFpCaXNFTzBHWWd3cm1ab3ZleFBXT2p4RlR4TitoVENpZ0hL?=
 =?utf-8?B?b016NDBNUG9OdlpzcjVid1dPSTlJMGFucFlLNUlmYkRiR01UMzN2ak03ZHVv?=
 =?utf-8?B?RHlsbmVzcnF6TWd1aEpuWWZ2a0VDM1Z2VHdIZjZLTEd0WkRoNXpRZWF2Nzc2?=
 =?utf-8?B?QnQ1TUo3UEJvVXFveEFXUWV3amw2RkZ5WVVIK2lxYUwzVEZMTi8vYTc3Y21w?=
 =?utf-8?B?NHdadmxVd2lBd29KNEE0cklxNlB1TjBMUTlUdk85ZHk5WGRkbnJnL1J2Mmxk?=
 =?utf-8?B?cG9hbGFBUXRZYXhPNG9pMWdISHB1Mkpod0tZUmE3YnVQWXYrL2d2MzBwRW5X?=
 =?utf-8?B?MVBJMlI2NHZ1S0xoZmtCSkkzWklvYmM3Y0xHbnJGZkM1Rmw4dS9vYldXSkhr?=
 =?utf-8?B?TzlXY0poQUVCcFI1bC91aDhzY3VEYzJEalZ6TzQwa0doOC9LTlFkdUdnS2xa?=
 =?utf-8?B?NnJiNERGSjJMRUJRSnZJQWVURnV5ZGRQblE4TlZSUzFNOUJFbUNlSHhoczRa?=
 =?utf-8?B?dmI1Yk0rQUcyM0JEZllMZ294VjRDMjcrR29qMXVwVlNBR1RFbmc3aVh0eFVM?=
 =?utf-8?B?aWJ4WmFSdlVhWGRMUTVUSzlkQzIvREtnOENxQmQ3NDNrU3V5TGhWWkh5Mnh6?=
 =?utf-8?B?SGVON2ROYzlkbGJMMnk4WjloazlnK0lwNXVSWVdhcVhVWE9QYzMwVkZGckxP?=
 =?utf-8?B?ZVpueGNZT0QxeHlzOHZkSjRjNDAycWJrL0Y2Mml2eldvWjJxY0Zzbk50VTB5?=
 =?utf-8?B?OWFjWDlwNGE0MjJKcGVTNFRrUzE3ZXlENWhnS3lPYmNMRjByWERnUGNJRDFW?=
 =?utf-8?B?VFBXZ2NLbGNoSTQ0V3o5N2tBYnNYc0dzM2VDWUV4c2N4VWx1czNqblJqU092?=
 =?utf-8?B?YmdKUWVLUkpHajJBQ0lUU1N1ZGhEWVdSWG1uaENrTytLWStsZEMwWDllZnl2?=
 =?utf-8?B?N2RBc3dKUXQ2NDVZa2o1RCs5bm5rSG1EcmViTzdrMEpqTlVXNWNBTzVSd2s4?=
 =?utf-8?B?Tnk1Y01sVlhvV3FhQ1R6eFJPdUpHdWNITU5KOEdzWW41d0N4MW8xbDVQTFo0?=
 =?utf-8?B?ajBLSEdvbVQwbyt4ZHVITmQzVzhZSFVHbmwwTkRrVDFpVE9XaUtkSmhqajVr?=
 =?utf-8?B?U2duNSsxV3pKdnJWU3lyZkN5ZFN3c0M1eXVlcVk3N3VGa05ZSEIzOWVwY2N4?=
 =?utf-8?B?aGNYOEhDaE5ScmIrOWZwZTJIU3RLa2Z3SEU3TWR6dlZDRFlxVm5LeUtaaE82?=
 =?utf-8?B?S2F1bVZrcTV1TG9TVDY0cDBacHBFZ0M2N09DL1ZTWTM5RHRRS1JwbTg0V3d6?=
 =?utf-8?B?Y1FzMURSeHFicyt5NGlhMFZKZU56NFFvQkVEdE1SR1lGTHlZbUVuMkpSOFAx?=
 =?utf-8?B?aUtDY2Q1TnNuOG9OUktIdU81NUNyaGh2TDFYbkMxREhuNk5zdDdVZ0RMQmpL?=
 =?utf-8?B?bUwyWTZybS9rbmphOGlTNDVLN2J1TFMvTlhZSTZNdm9pNzg0alF1bXoxR1RP?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5251ca-a004-4e19-b493-08dab1c75320
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 11:44:47.8700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0cdBuHWekT9SSi3UPT9gNw/93FkKojGb/rDdUqW6eFcLMeq/W5W9CbfNs72Xezpuowyj2JOrTMTwBSJvQSzETgsuj7mbxlCl6F+i28MIIl2RDIrtduUsc9HmlnJkdlE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5943
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 19.10.22 13:53, Konstantin Khlebnikov wrote:
> On Wed, 19 Oct 2022 at 12:57, Alexander Atanasov 
> <alexander.atanasov@virtuozzo.com 
> <mailto:alexander.atanasov@virtuozzo.com>> wrote:
> 
>     Currently balloon drivers (Virtio,XEN, HyperV, VMWare, ...)
>     inflate and deflate the guest memory size but there is no
>     way to know how much the memory size is changed by them.
> 
>     Make it possible for the drivers to report the values to mm core.
> 
>     Display reported InflatedTotal and InflatedFree in /proc/meminfo
>     and print these values on OOM and sysrq from show_mem().
> 
>     The two values are the result of the two modes the drivers work
>     with using adjust_managed_page_count or without.
> 
>     In earlier versions, there was a notifier for these changes
>     but after discussion - it is better to implement it in separate
>     patch series. Since it came out as larger work than initially expected.
> 
>     Amount of inflated memory can be used:
>       - totalram_pages() users working with drivers not using
>          adjust_managed_page_count
>       - si_meminfo(..) users can improve calculations
>       - by userspace software that monitors memory pressure
> 
> 
> Sorry, I see no reason for that series.
> Balloon inflation adjusts totalram_pages. That's enough.

That is not true in all cases - some do some do not.

> 
> There is no reason to know the amount of non-existent ballooned memory 
> inside.

Why? Memory managment is becoming more and more dynamic - to make it 
easy and accurate you need to know that amount. The kernel itself
on boot pre-allocates caches and sets limits based on total ram at boot 
time when balloon steals half of the memory these initial calculations 
become very wrong. To redo them correctly these amounts need to be 
known. The idea of doing this is thru a notifier chain in a separte series.

> Management software which works outside should care about that.
> 
> For debugging you could get current balloon size from /proc/vmstat 
> (balloon_inflate - balloon_deflate).

Currently you can do that only if using VMWare balloon.

> Also (I guess) /proc/kpageflags has a bit for that.
> 
> Anyway it's easy to monitor balloon inflation by seeing changes of total 
> memory size.

Not all drivers do that - VMWare and virtio (in one case) for example do 
not. I proposed to unify them but since it can break existing users it 
was NAKed.

> 
>     Alexander Atanasov (8):
>        mm: Make a place for a common balloon code
>        mm: Enable balloon drivers to report inflated memory
>        mm: Display inflated memory to users
>        mm: Display inflated memory in logs
>        drivers: virtio: balloon - report inflated memory
>        drivers: vmware: balloon - report inflated memory
>        drivers: hyperv: balloon - report inflated memory
>        documentation: create a document about how balloon drivers operate
> 
>       Documentation/filesystems/proc.rst            |   6 +
>       Documentation/mm/balloon.rst                  | 138 ++++++++++++++++++
>       MAINTAINERS                                   |   4 +-
>       arch/powerpc/platforms/pseries/cmm.c          |   2 +-
>       drivers/hv/hv_balloon.c                       |  12 ++
>       drivers/misc/vmw_balloon.c                    |   3 +-
>       drivers/virtio/virtio_balloon.c               |   7 +-
>       fs/proc/meminfo.c                             |  10 ++
>       .../linux/{balloon_compaction.h => balloon.h} |  18 ++-
>       lib/show_mem.c                                |   8 +
>       mm/Makefile                                   |   2 +-
>       mm/{balloon_compaction.c => balloon.c}        |  19 ++-
>       mm/migrate.c                                  |   1 -
>       mm/vmscan.c                                   |   1 -
>       14 files changed, 213 insertions(+), 18 deletions(-)
>       create mode 100644 Documentation/mm/balloon.rst
>       rename include/linux/{balloon_compaction.h => balloon.h} (91%)
>       rename mm/{balloon_compaction.c => balloon.c} (94%)
> 
>     v4->v5:
>       - removed notifier
>       - added documentation
>       - vmware update after op is done , outside of the mutex
>     v3->v4:
>       - add support in hyperV and vmware balloon drivers
>       - display balloon memory in show_mem so it is logged on OOM and on
>     sysrq
>     v2->v3:
>       - added missed EXPORT_SYMBOLS
>     Reported-by: kernel test robot <lkp@intel.com <mailto:lkp@intel.com>>
>       - instead of balloon_common.h just use balloon.h (yes, naming is hard)
>       - cleaned up balloon.h - remove from files that do not use it and
>         remove externs from function declarations
>     v1->v2:
>       - reworked from simple /proc/meminfo addition
> 
>     Cc: Michael S. Tsirkin <mst@redhat.com <mailto:mst@redhat.com>>
>     Cc: David Hildenbrand <david@redhat.com <mailto:david@redhat.com>>
>     Cc: Wei Liu <wei.liu@kernel.org <mailto:wei.liu@kernel.org>>
>     Cc: Nadav Amit <namit@vmware.com <mailto:namit@vmware.com>>
>     Cc: pv-drivers@vmware.com <mailto:pv-drivers@vmware.com>
>     Cc: Jason Wang <jasowang@redhat.com <mailto:jasowang@redhat.com>>
>     Cc: virtualization@lists.linux-foundation.org
>     <mailto:virtualization@lists.linux-foundation.org>
>     Cc: "K. Y. Srinivasan" <kys@microsoft.com <mailto:kys@microsoft.com>>
>     Cc: Haiyang Zhang <haiyangz@microsoft.com
>     <mailto:haiyangz@microsoft.com>>
>     Cc: Stephen Hemminger <sthemmin@microsoft.com
>     <mailto:sthemmin@microsoft.com>>
>     Cc: Dexuan Cui <decui@microsoft.com <mailto:decui@microsoft.com>>
>     Cc: linux-hyperv@vger.kernel.org <mailto:linux-hyperv@vger.kernel.org>
>     Cc: Juergen Gross <jgross@suse.com <mailto:jgross@suse.com>>
>     Cc: Stefano Stabellini <sstabellini@kernel.org
>     <mailto:sstabellini@kernel.org>>
>     Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com
>     <mailto:oleksandr_tyshchenko@epam.com>>
>     Cc: xen-devel@lists.xenproject.org
>     <mailto:xen-devel@lists.xenproject.org>
> 
>     base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
>     -- 
>     2.31.1
> 

-- 
Regards,
Alexander Atanasov

