Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FEF5675CB
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jul 2022 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiGERbp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jul 2022 13:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiGERbm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jul 2022 13:31:42 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50095.outbound.protection.outlook.com [40.107.5.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330ECE0A;
        Tue,  5 Jul 2022 10:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcgxPXV0+B++/72XGIPNoYBi85KJAnm0BpQEj1faAkznM9TxuZ0Y4fpbs5i1JwyIFJYCKf2buLduIVMjXoMsgY5nqVbDhV2GWytvsdrwnN2TBZkUBXJqun1uk3wUtMFu4VhzqU4lZdkcOBadu/UMh2EyYgK0uLTq3rcm4T5gG70Yzs9lSehJaSDEwizgTJY1jMBPzS/720rdEAfA2iLtBI+5Z+RLdcXLoF5OOOu9USsFfElP1jFhxXbW9RvME0XHutdIrfiTwKU43i4QxqHmFAe9wu8mrcWU4nOhIrdypj5APfYU07o3tL3pa3qec80733i6UfwocYRefbjNt86dhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=566LnLhKP5PQOXq+OZRVRveRzi+dX2pqYkEbp65N2uY=;
 b=oWjJztoLvHZmioGT0n6FdpUC07TjjV5SqYqYgAP2eGQgKaXoVVVss02iqPn4n64z6v9UW4OtnTgNGQ+TEiXWmmVaqlfzDhwE2OIe3pl/cUYx8qfAkzmXBKoBaAy0Nom8LKlWUAkc4a1z0MMIq3U33bDeWYSKWjnEw8UXx6adhVw5P1f4J/faLLkVEYeiZ4aRqbPT7TR89BXJq8wxeSNw6Ho1dDaTXp8AXhajvr8d4Pgif+HDTeC/nI6N6hmjIGcy64DNahj6t69cHURj9JQKpEMh7+k17A1o3mLWM5fHTFM4Q4VlzeSuYI0VaPPPuo6+3BYPWuYs9H3n1aQRkABPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=566LnLhKP5PQOXq+OZRVRveRzi+dX2pqYkEbp65N2uY=;
 b=i5U1UhRBhZ1HzzW5aWm3qgbQLIS8UdKm2/rzcaXf64ItVA3l/9iSUZvaHs1qbvvQiUcYfJM2aaGvsmKuayNxMykNH0+vy3MWzo98ybWHQSpW7hWrXKzM9HLVM7T2ei/X4WdIjOFNl3dyF34pPPZucWpF9BQW/Idyli6+VGuRwuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AM6PR08MB4866.eurprd08.prod.outlook.com (2603:10a6:20b:c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 17:31:38 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::604f:10ce:cb80:5c5]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::604f:10ce:cb80:5c5%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 17:31:38 +0000
Message-ID: <1d035bf7-47f3-277b-e26e-9cd0291cbd8a@virtuozzo.com>
Date:   Tue, 5 Jul 2022 19:31:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 1/1] Create debugfs file with hyper-v balloon usage
 information
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     "kernel@openvz.org" <kernel@openvz.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220705094410.30050-1-alexander.atanasov@virtuozzo.com>
 <PH0PR21MB3025D1111824156FB6B9D0DCD7819@PH0PR21MB3025.namprd21.prod.outlook.com>
From:   "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <PH0PR21MB3025D1111824156FB6B9D0DCD7819@PH0PR21MB3025.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0601CA0035.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::45) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bde6a5eb-3d7c-48ec-4a9a-08da5eac374d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4866:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8vJcyVxxzibtx7y5wIsE0mu6NsUONMUGbLAspT97AKHqLgu5Y0aWsUExMgT9tAD9L03M6Xqn4y2jkh8uQ5NtnbLe7cip5udPLVWAS0C7Au4ZAl8kXzRDt5CoHMlFSQKCJuP/H8KP46e+shDBZ9z8XxR370fHM/Qdj+e5RGsaftDYVLxI3wqe1IEgypMOHeSOO1DRmijBtw9iQ356eP4lIzMI8QmH0tvzeEhVxfhPbvkhfyTKIG59nh8CK6HGDDdBjJlbjdi82bzT4C2LuTydudG3Xl15vtEQDnbINfs5GQvybWE/2Tl8akXAcAAoefYqMfM78g7n4Vu/Lm99UaKkZWdge0XkFSWw5jXMVLBNZU43CGZR8NOl3QVvQGfyva9NChjabjZxjWFF2IPzQNkJzbqGX2Yl5GfLXuDl8lI1c6Zw16Mb9fK4t1qyS6IpMpdQKhGo3MmRM+I2UUBBqubvZIORzchuhiyEBzb3yoZybl9sXc0uEDMAG8JdsdX+TMCNfnc4KskVvThFFV0LfOwdOcPXMndfafVTQOlWKs2SJqvmXcw2TZMhOiTuFuHqZTsJuzJmXVKBjg8WDos+4+xTIIUrI4heHTcwsgItYP+OEtELrWDAH5nl31qMe6FGjatpqpOWuT7L6CnCPSQCaHSiG40a/Ic11Zvti+KMIyRbmT81FSFH32PSrcmVhF3qFKMyqNzJi3LrXlN3Y0uzxGiiDrlv+3MFJrQX4Nc/CoGZ27swIauqrj5iIs44jdUNYPTo9cI06jyhrJd6Hy6JZkhFkaXFZVL7dsnSEv9Ol/h2E+JsWIBbUKSFPggNU5oX0IPTY9D9JdEUIXxtrUySiKf3bMz85aP9SCrVJNRjJdA9vq7/+Wm3KPyz5J3dz0h/NaMPKiCJmNaIWXKr8pbhEoiqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6956.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(396003)(136003)(366004)(346002)(4326008)(66476007)(8676002)(6506007)(66556008)(66946007)(966005)(41300700001)(110136005)(316002)(54906003)(6486002)(478600001)(8936002)(5660300002)(2906002)(31686004)(38100700002)(38350700002)(36756003)(86362001)(31696002)(186003)(2616005)(83380400001)(6512007)(26005)(52116002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVBTNS8wZjVpNFdianFGMllPNnZidGtjcENKT0RCL1hWZDJlK1FoNUNGRkNX?=
 =?utf-8?B?dzl1RU5rc0FqTStnWngyaFM2YTlOcVIvaElVdVpOQ0dscXVpMlYyZnkrU0h1?=
 =?utf-8?B?QlpQTkR1ejdVL0h1U2k3ZW9oZ2t0RjNsTG5qTkxKRlVjUlFieXJCcEFuSWRj?=
 =?utf-8?B?MDBCY0Z6U05kRmhZaW1YdDRPVXRVOE5Hbko5d08rUVRhc0IwZFlkUDRTMzJr?=
 =?utf-8?B?b3Ywd1FiS2dEMkFtaTQ3UHFYQmNlUmN1Ukx4cWdtZWZPOXc0cTVMTElDdWtR?=
 =?utf-8?B?YWo1aFhkMnJiamthNm9meHZUa1hvWkpOaENEWGFNcDg2K1JGQ2l0VXFXbkMw?=
 =?utf-8?B?YUJRVUxzVUdvbE8zYzlWM1JiaVdyLy9iMjU2ZThYYWhyWWFYRi8ySFZyb3B3?=
 =?utf-8?B?ditUTXNHKzNYWDVNaTJjc0dqdlQwQmQxN1V5bkZIRlE4bDlHWG5INDZUTlp3?=
 =?utf-8?B?bUpKK3JqTUJsaTBKQW55S0VBRlJmOWtLbWVLZmhGWnRieGRkN0doT1IwVXVT?=
 =?utf-8?B?MGRGbW92MTRDajJQYXJLb0E2cjZ3OG9SeG5qMDdhMWJEZ0hPYmJaOWdjYTdp?=
 =?utf-8?B?SFNIcHl2d3ZXc2x5ZDh6cktwWmlXejhrTWprRVZXWVZ0bTZmUDhpY1lPVEZY?=
 =?utf-8?B?NHMrTmhCZFN1R0xINHNPRmNZNkVjSmc0bzdmZDhVTEV3NWl6MXJzaHJEVEpP?=
 =?utf-8?B?RE5XMGZkdmw5V2JUMHh3Y0N0Sk9WNWhBNDJyZEpQU290OXBnVlgvZ2hLYWln?=
 =?utf-8?B?V0xzZDBEQm55UUovRmpGR2RhV0R3T3JvWGtkT0NjMENEdkRrUUxNK0d6cjRC?=
 =?utf-8?B?ZEdWOXdONzJZM2lxdUhvUzZCOTBVS3FQOVQwUVVWRU8yNENVaDUwc09PVnpT?=
 =?utf-8?B?cGZjNXJtT3YvVXkyYkxsbjlJeUIzdklWTFJmbTkrRlFDZHNWMTZiVjZUVUlE?=
 =?utf-8?B?WWcxZUhGU2Q5M2NmY1o5eEpabWdtNGpxSUozTkVwK3ZiK1hhd2pJbUUyQ2tD?=
 =?utf-8?B?WFVzVFVzTTcxRzRyV20zZUo0LzM2bjZjS3pNZkl6TUlST1hFWTBkVEhNUXpZ?=
 =?utf-8?B?MFZGVTVxWXBaMFhwQ2FLeG1JUTJpQ1BFNUw5WVIvQklTK2Zra21YNW9Ncit4?=
 =?utf-8?B?eXJIMFRMcTFZU1dsY0dSc0VHUWtNNG5FQVBvMUhaRVZxMzIxS2dhQjFxQ01V?=
 =?utf-8?B?S1JpeGdncFNEY28vTUhFTzZSL2s2ajcwYVNFNHFWZjdiREdCL1M1Tit2MVp0?=
 =?utf-8?B?ckQzV1BSa241bXdLQlFYVjE1V1h5K0hUalRtS2x0RklJZkFoMzFOcXJmaGN6?=
 =?utf-8?B?TG5UWGdTOVdER3dMRE9rSERyRVRoMElObUlXYlFNaDV0bk1UYndsRklncHp3?=
 =?utf-8?B?UUdzSWU5SGZkazhoU1lPMTM0S3VqcDc1OFdGazFiK1l6aW9wQ3Q1bHhvRDBk?=
 =?utf-8?B?M043QWlqcnJNSnpSODhiVk9pMU8vSWxsVVRwQjFNRHFiZDcwTFlHQWswYlVT?=
 =?utf-8?B?Y2pwc1pla3pwcWExcEZMQlJiNjFGZVJUeUtDelRBa3JleWcxUzIwOVl1SEdS?=
 =?utf-8?B?bGFQbmJyUDduU21sYml0R2piVXJKbEpIMnNiTUhmRE5GNUVGeGZJd0c5TDU0?=
 =?utf-8?B?KzIzaC9mVUVSRFB0eWsrSmF2WEljanpZeHBhWTI1THZOVVF2b0xGdzZxUmls?=
 =?utf-8?B?Y2U5YnVpS1ZUMmFEdEo2S1BqeDZmSUViYytrUWFxQlc4UjkxYkZSSWdQOUhM?=
 =?utf-8?B?b25iN3JteVZwSFFlRE5TMHNzZFVmZ3BWWUNyYW5EN0hNZmpiNUd6S1VnVHhi?=
 =?utf-8?B?UUxkMGtkcEk5Qzg4RVJ4R2RwMzk2YlVYUjlrTDQvL1JhZWNrVWxhdGN4UU5z?=
 =?utf-8?B?MXdROHpJOXQ4TGY4UEJjNkkyMU5ZS2xIdmZieGl2d01sRVE4QnNoeFUvS2JS?=
 =?utf-8?B?WTdnaEJJWFZHYkwzL0ZCeEV2VDNOa2J6T0E5RHQzRERoWnd3aWlYQ3hSbVhJ?=
 =?utf-8?B?eDZlUzlVYnlqbnBkRFAwREYxZW55S2JjVU5lbmhxRWlFcVVTMm5WS1ZjYkRr?=
 =?utf-8?B?bU5sQ0sxVXFBVUd6bkJ1djZ1WW94aXkzWm9OejJFOGVkbzlFc3g3eTdwbVk2?=
 =?utf-8?Q?/Rczy31kZKZcfywfw3xurv9ry?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde6a5eb-3d7c-48ec-4a9a-08da5eac374d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 17:31:38.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trfBlOBcTYFBN/4YixwsHAo0pymUcCmOcyZURw6RR2SCYyFFDF/yipjx30K1gE2drmWPam8FDIbo1EPS1P6huA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4866
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 05.07.2022 19:12, Michael Kelley (LINUX) wrote:
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
>
> See also some minor comments below.
virtio efforts:
https://www.spinics.net/lists/kernel/msg4425155.html

In general balloon information is always reported to the host, that is why
balloon is invented. Though the information inside the guest is not
always available and it is hard to track/guess.

We have had a lot of trouble to convince our customers that the
memory was taken by host being inside virtual machine. Thus debugfs
interface is good for such rare checks especially keeping in mind
that this would be the same for most frequently used by us
balloons.

Den
