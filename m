Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0EF5ACE78
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Sep 2022 11:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbiIEI7o (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Sep 2022 04:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiIEI7j (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Sep 2022 04:59:39 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10117.outbound.protection.outlook.com [40.107.1.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC8AA448;
        Mon,  5 Sep 2022 01:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEsohMb27fVEQkSryYILz+W2uyHvXDG17TO0ZnCNpzjJ3pkUdc0jwV3lV8hTe6xN/chu1xBJH4OEep+BU5yUyzfVwXxJG+Qg6bKBV5p3UaQWUZIfpEftGLWggQWVl6LUA2hp2DbkaCDpHo02m1eW6lI7Z0FmQjEBGrej9QhE7PeRfBLtA9R0T4WH8BZFHvUgBL2IPX/rDUQYcZJbJeJh7rppra/d6XWjDNpxrZBJN2eS+e1TvEuA2QAtXDMlCuxdxJkrdiCTMK7LCsJXwlMoTkbx+XCMAPVPBKssqQ4r3o9UxQ2A0y9i9XtdZz8SnpSoAr3yJMKNxDMSCfap7D7tJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E07Sad6LuuSxRVdlbLyA13Txd7yI5J6qnNm0QXcslDg=;
 b=LcT6TlFaRxvoZXQxmAQQeTyinupANT7eOXPQrrr/D+RyjFCzNJMero5cqAI0j6Hp3AD82uTl3Zg8vBh7oR2UVaBtlPwEJpSxTPhoDcBOOVXk+gPkfbHp3L+MSUVe/XBgZekC2aV25QLEmOLEpdwEO/AJEULXqnZEtOZN5PWI+mmNTn3kZCiAvPNMT1kIcFh0IyeIUkr09VpUtYNWEKu70KwOQYNbqjoVF2BhEG3HDnX/1KkICPKTJlPGHRMaDnsk3XgnHmcSdEIpkBsngB66upSM09WlNkF9u7B8WT/Sl1q2t0zR49zBlSJb6gU1QTsUGL9KFJiqpyPodgPmW3iImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E07Sad6LuuSxRVdlbLyA13Txd7yI5J6qnNm0QXcslDg=;
 b=O9vRuZODuHXZtgAycMDP+2Ra5qYGmtE9jdZVsuVNhMij6Aowzr/zLcXoP3vVfEQbK06hc35ysMStHATqY9CVbDbga/yQ9zTU97N1bcYVB2dQxejowC1+BzEgIgLOSsbHTJSYXl7C4Gi6y3ZLi/Oo2EhMGzEME3o4vKhXg17+GJypM2jFYPpq6kuBBaQP8fUxZOmms4arQ9sr0hkQ0C0RsEgK14x9WJAcODlKGmlyTHk57lERGC3MRZGSaY3D8daVwqSVD/DnHhdYoaLA6TL1oUzKi5heciWpKBDgsnn/cjfCu/oHjoHRQA/cNMY3vJGRJQD+Q0VquiZRCWR+ugKQEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB8222.eurprd08.prod.outlook.com (2603:10a6:20b:52a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 08:59:34 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::5593:9fae:255d:ee6]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::5593:9fae:255d:ee6%4]) with mapi id 15.20.5588.016; Mon, 5 Sep 2022
 08:59:34 +0000
Message-ID: <483cf471-6c12-51e0-4075-72d290055f47@virtuozzo.com>
Date:   Mon, 5 Sep 2022 10:59:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/1] Create debugfs file with hyper-v balloon usage
 information
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "kernel@openvz.org" <kernel@openvz.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <PH0PR21MB3025D1111824156FB6B9D0DCD7819@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220711181825.52318-1-alexander.atanasov@virtuozzo.com>
 <BY3PR21MB30335CDAD39F927427DEF4EAD7869@BY3PR21MB3033.namprd21.prod.outlook.com>
 <20220713151927.e6w5gcb67ffh4zlx@liuwe-devbox-debian-v2>
 <BYAPR21MB1688312AED65BEE290CF6C52D77D9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <BYAPR21MB1688312AED65BEE290CF6C52D77D9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0017.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::29) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84819cfc-a182-4a6c-1a63-08da8f1cf40b
X-MS-TrafficTypeDiagnostic: AS8PR08MB8222:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoS+hMVl/ak0aCx/Fe5zClrhSF/sdFhfxNaz3+deA8u2JVfd6P3oL45HfFVdRGWpW37yQSyCT5IEjnlbUy/YHN8GWDw9bB8W8zg/ZWzW1SW1odNgEJa9HY7P0tjRgQlbN3i8L66IghpMiYyWjJVfQc9KGlyIy+IvF5VuuMaMBztETaRFRCIvBRhAQEOFvkzDvCovzBBf2Ow2WK/vKWnfcMV9JLy/oR7AkaVPYmxfL7Zbo8na7h+D76BqbsK8IbzIas3Ta6+YNpaleBVFDL9iP125CkI48uLqYWuVCx9tQsfYhPZTCGbFnFzFJOICWHmLFNoNZOZ0hIgmRvGV447/bCIjkbqg+g/ValG7llAo48IS6kPv1/UvjE5zPcgpbn9xMnuqAHNdjqPMHcRYX2fNYZO5cQt4gJeFeWKy48myDmSX2z6mUkIFPIt/3rnIAKQ4d+Y/+Wff6KIKFqXXaIRuaOqJ2D+fZLAzN/PFuwshkupxhvR9u/umZKcCzXKNozXYsV2doClbGqAOWdDJWRq93zVFk6QCkzndcsTIVajbDOQdp/p6G/b+4+P3znRecIbnGRCFd5jMiQlwcjW/AtW1U+O29CkuFHEGlSz54JxkJ3sXXfB5CkX+Ky9y/OxqYjyj4Mo2l2e7mvsIsuI5uL1egIIGQHRVmc+der0xvUfXp3S1WuHHg4/0WapamP5A55lBDhQf+52i7uv6hvJ/lPT3gOQtKrl+MP7mf/XNGumP4A4PP/GV/ITd26zZIWjb8+YTlzHoGonEswpuEl4ozaphKdeQBBjIm5CEkWaQ+tjYQ3TyvMPjBG23brzVymkyCr4gXiLcP5H/mYg+gh2clVpniA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6956.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(366004)(396003)(39850400004)(6486002)(83380400001)(31696002)(86362001)(186003)(31686004)(38350700002)(38100700002)(8936002)(5660300002)(66556008)(66476007)(6506007)(8676002)(6512007)(66946007)(2906002)(52116002)(53546011)(41300700001)(26005)(36756003)(6636002)(316002)(2616005)(110136005)(4326008)(54906003)(478600001)(45080400002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFFXZ3VLUUV2ZHJ1NXJ3OUZpbEx6cGxGUWxaczF1Ym42UDBmYkdXSEZtVVRJ?=
 =?utf-8?B?a0ZONXZOSTdSVlpsTFVucnNGRnlQejNTNExuODdWMmlWQ2dUb3BFcS96ZWp0?=
 =?utf-8?B?bXJuQ0p5MDE5bURULzBNWFF0SG9uRU1rK1Z2UFBMN09aMjhjektPWis1L3N1?=
 =?utf-8?B?Q2IxdVVidzNCWUhOYWZVOURqdlpTOGIyNExwVmV3RG1VcDhTNFRDakZlVTQy?=
 =?utf-8?B?WE9FZE0rUlE5SS9TMXpWYUd1YjRzU25mcGhiMktZb2ZCTEl0dHFzZXdWcjZV?=
 =?utf-8?B?dzIzR3BadjhWYnhQN0tLUUJ5dUpUTC9VYzUwOHhYZ1ZtYXU5bHRnMGxMV2dE?=
 =?utf-8?B?Z2V2U0x0SmpMTmZlWWdsbkg4NVdtZXJ4bG5yN1B1TmoycjdzUmdPUlU5Rk5B?=
 =?utf-8?B?NkpXZUFPbDJjMGJhdU5qOVJSVkt5Ri8wVU9tUDRubGdjNGlkZGRxdTNCKzFu?=
 =?utf-8?B?MEpLTEZ3L2syWTV4OXVlaXdjTWRkbnloV2YxWkJRazdmOXhUNTkzZU8xWjVL?=
 =?utf-8?B?OVF5aWxYaWcxVEdrZXZVMFM4eDZxaGw1bWZsekhweHkyLy9Cc2x6L0Urak5C?=
 =?utf-8?B?UUQzMDhvSlQ4VkFJWTJyRTR3Z1NJYUpBS3htMUErQ0JRNGtDRFdydEpUR3Fm?=
 =?utf-8?B?RnRjTEwwcEJEUXJOWFhWY00wR04yK2pFTXlWeW5LWlRTNjZQY3NYTkRNQnhv?=
 =?utf-8?B?YVRrMmhFVUhBRFBpY3UxNEU1V0NRVmZjRUxBc2ZYb2Njd2locEI3TkpYS1hu?=
 =?utf-8?B?cXZzMEQwSk1EbnNBanpYbWQyTzZGMDRoOHNWRHRZWmk1NENvamdUZ2NLeG5r?=
 =?utf-8?B?UTBkSFJmc1lrMXdWQXFxVHk2QldHb2JTY1B3MlVjNU1kT3BDVWx0b2hjSVMz?=
 =?utf-8?B?eUdvZVFtOHEyTXkxbFdobU9UMkRSODRtRXdGcUVCYzNxODhud1YxY0ZFYktM?=
 =?utf-8?B?cFJGZm9KNGJaWFk4YkhOTmJLYjlISi8vRCswNnhPeHJKZmN2dmNhL0FVVk9O?=
 =?utf-8?B?eTk3YmFpeFVKNlM4Q1V6b2ViVjZRQnlLdkFKWUFjVHRKNFZ4czF0Z25VaEJm?=
 =?utf-8?B?TzM0d1hzcm1uUDV2OTl1SGFTZHRlWFRWZDlma0FwLy9vditndmlzbFZYVWYv?=
 =?utf-8?B?dGU3RHpjTkdSVFExVVRmN1ZnOU5obHR1YktFQXN0Wlp6cER5di8zRFZGNkhl?=
 =?utf-8?B?M2dHMnhjZ2pjaGcyT1dkNzV2S3FRRGxDNXZIMjBDTEYzSTY3NVlzaDk2TzJG?=
 =?utf-8?B?QVVrWTA4TFdyakFoZzNEMEVtRUlYektDZE5TK0xVVXlYUDRjSUk5OW04Y2lP?=
 =?utf-8?B?NTZrWER2dVVRSys5cVVySlUyZ3BhS21qaDMvTGtsWGlUMC94NkV4SFhzcFZz?=
 =?utf-8?B?a0xmZzRrN0J4K1pGQVJ5QW9Ka1lhUXdmSlFCUFJMcEtvWDV2RU5tQTZONld2?=
 =?utf-8?B?R0NrZ3VZQ2ZyZXliUWtrTWhxS1o5aGI1N0Y1Sk9VZDMzemNSVnRjN0xVYWRS?=
 =?utf-8?B?RDExZk1OcEVUVFB1eGRjc21XblFuSitGdnJTNWltK1kwVk41TTdCM01CcHZK?=
 =?utf-8?B?NWQybmwyenJQZlRvdGhYdXFMejVTWFFDT08wRnFDWHdnSUlONUsxeG1ia09O?=
 =?utf-8?B?UnNmQVZGejlYSlZtRUdKZGxLQmpsdXNsRWUwM0FZZGZEL1JHSmhmeDI2OWRB?=
 =?utf-8?B?MFo3cmRWQWZxUmlWRjUxdERWWXZEc1ZMdzZEUHF5TGFTblUveEkzMDV1amNH?=
 =?utf-8?B?TXJ6R0wvY25qNFg4KzBZNThHeUp1VlFqenBUVWZXQTV1ZkJsYnFWVW9JYXgw?=
 =?utf-8?B?RCtaSFVEZWtJNndpaC9HWkhpa08rQUIrL1RIbFBITDYrUGZCQldiTmM1WUJQ?=
 =?utf-8?B?UC9RS2YrOWV5dTFONFdVNWUxcVVZN3JBTmkxOHg5ZXh0YTVHSThnQU9zakg3?=
 =?utf-8?B?TUd6SVk4T0laWG1LTjROdHVucXhURDFxOWx4V0hMK25rekYyUDA5eU9FLzFX?=
 =?utf-8?B?NWp2OEJkZitVWkdKTHdhTlZKWmFDQmtmRkY3QUxGaWNCQ3NRNDB4ZjVqUlF0?=
 =?utf-8?B?TUVtVms0SW5XS0hkeGhGSTRRSWhSdlhBYzRoTEdWRS8zeHVQbEZmUlVzWHRv?=
 =?utf-8?Q?yuzJ1LfwHQAPvaP+L+UAk9CGK?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84819cfc-a182-4a6c-1a63-08da8f1cf40b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 08:59:34.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUAKyNRtRgt06WfDA6LPunMSSNgU21VFiE5oTjrGXKUIV3hdtYv9yu8uOzTRIF/6vuRgN34Y6Yu2Mj3XyIZ5Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8222
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 03.09.2022 06:37, Michael Kelley (LINUX) wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, July 13, 2022 8:19 AM
>> On Tue, Jul 12, 2022 at 04:24:12PM +0000, Michael Kelley (LINUX) wrote:
>>> From: Alexander Atanasov <alexander.atanasov@virtuozzo.com> Sent: Monday, July
>> 11, 2022 11:18 AM
>>>> Allow the guest to know how much it is ballooned by the host.
>>>> It is useful when debugging out of memory conditions.
>>>>
>>>> When host gets back memory from the guest it is accounted
>>>> as used memory in the guest but the guest have no way to know
>>>> how much it is actually ballooned.
>>>>
>>>> Expose current state, flags and max possible memory to the guest.
>>>> While at it - fix a 10+ years old typo.
>>>>
>>>> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
>>>> ---
>> [...]
>>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>> I added "Drivers: hv:" prefix to the subject line and applied it to
>> hyperv-next. Thanks.
> Alexander -- I finally caught up on the long discussion of balloon
> driver reporting that occurred over much of August.  I think your
> original plan had been for each of the balloon driver to report
> useful information in debugfs.  But as a result of the discussion,
> it looks like virtio-balloon will be putting the information in
> /proc/meminfo.  If that's the case, it seems like we should
> drop these changes to the Hyper-V balloon driver,  and have
> the Hyper-V balloon driver take the same approach as
> virtio-balloon.
>
> These Hyper-V balloon driver changes have already gone
> into 6.0-rc1.  If we're going to drop them, we should do
> the revert before 6.0 is done.
>
> Thoughts?
>
> Michael
VMware balloon still has debugfs binging. I'd better keep something outside
of meminfo as here we could keep much more useful information.

Den
