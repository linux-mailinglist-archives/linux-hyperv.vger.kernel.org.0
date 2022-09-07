Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C8F5AFEBE
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Sep 2022 10:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIGIPh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Sep 2022 04:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiIGIPd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Sep 2022 04:15:33 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50116.outbound.protection.outlook.com [40.107.5.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C7826562;
        Wed,  7 Sep 2022 01:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1yMj8oiypuKMe75mMaAX49fkN4Was+EHwv8hccE8uY/DQfdYxaxjPUTVtJ9X97Pv4G6wviDaJ9R8q2tuaakTHIOp9rHQI7VRB2da7SIPkpgL4qFBiSFi4K6TRjxCRYDkVyfftQgB2S2rC3o94JBwizb+wJ/AqdVpbBViwXD7BvSvBflUTtFznwM5BFRKv6auxqz2oO2ayIUxQ4qnlY32BMbunG5NUHGbK+BRnHW7eNl8spP3ugG9J/gYugQvLkDbvmC7JKDPbLwowuR6GIxjAI/3fugJbJ4pu1mOiqOKFumwUYIghusepnRa0b7DH00wgHMTmMTMYzuJQJF/WMWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVNmdMk2b3Xq/re9XJoBTiQd0eT9KSVm0rYvTGNGTbc=;
 b=CZLF8flW/Je5o9mU7ZBsjQoonFRZbD9IAHomVUyIsr4y0DXqJeVawmQOsMozPJAXeUShCn+unFWjSBshLMNuSqgVbQQZMsiNXEwD1tddK6qq1b90P85LdKhP7Hqth7UsozC8qS5QtOXUT3OFMC497giEnwezYAXSAMYWMuvg5kxaV3F7RU7lYxQw00PpZzV1Wa+WqOvjpp8uKsomXl4NJR+tANN6MI5EHbqGUINM0Vahk33vj31LrPbfAMl1uObUrjsxhIueMX2BiDOMABYlpV82y44PD9BicENcuohqQxNplBglPMjGV70gtH8i9xTFd5ohtI1Z2i9dErCvbOwgFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVNmdMk2b3Xq/re9XJoBTiQd0eT9KSVm0rYvTGNGTbc=;
 b=b37zB7KbtX6DHIFBXaZSow8HaUs+URYSTW3c6hFneIdlc0BqwIR/q+JT9slUtAZEncRzmmzffa+5DWrtcpQ3vw4Lk6+4qMSYVBVCdSdW9iBB9VMIX1SOJLliKol2Nwq07BY/VBG1Umr3eGEl1pwU7OjxRhLoj8ihdKltfcAm75KLarbPS+WTvvnhXZ3agRSEkrEFTX4LApOfv7+p0IoEkwgXDjnPvDeDO+7RmiRGCm7/+OZFk597Z+LbPix42i1F5MJIJPjz6tLkYWExvmREsdwakFU4N540Qu34fiDWRO+4KsHCu8iD8RIINvAHjRLsBwT963DAG3PaZs9aV2knAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by AM8PR08MB5763.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.13; Wed, 7 Sep
 2022 08:15:30 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2846:1df0:88bb:451f]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2846:1df0:88bb:451f%3]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 08:15:30 +0000
Message-ID: <e3f418a9-97c4-0e8c-4446-b85fefd2cad8@virtuozzo.com>
Date:   Wed, 7 Sep 2022 11:15:28 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH v3 1/1] Create debugfs file with hyper-v balloon usage
 information
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
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
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <BYAPR21MB1688312AED65BEE290CF6C52D77D9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0084.eurprd09.prod.outlook.com
 (2603:10a6:802:29::28) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|AM8PR08MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: a9985f6f-4d3f-4dab-3f09-08da90a920cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLJ5tkE/696hIPep4/MSblh+A5qjTQi+F/xt4dwMMC6+FpMpH/Aj3zRi3XKMvANyMu/60VdMVZG5ojQEWbhvtI4IhBAyaNqDfQN2e3pTgRppdzE/K89KpGRYv2kQBPQhN522Bjgv9kWL0rl+S1EZmMHV561yO9Zfafl7t/6Mu//+DC1Mu3WZl+miMoih0WtgbYG11JatoM7vn1to4MkCcUD13MHJM4DY+FL5jD4xQxzIGJEBp1rXVC18mF9GKRTWBv2ksmB5XrIofbgQaT1yghjonkmyiLoZJCPltyBaLAoLYe9mezCLpA6Wv5QFcZpibOy9lvAKZLGDsHbhzsXGip5SADLhEqrLCi0TmGEXgBRtNJL6enFK+ZcKQ8PRkSWVXKIO7xILTnOnhYP1IQlt0oXsyQUKokQN/E7zaPIlI7lkkDG+C1nt7q84o1ShrIXkg1uI4rhEz0dJz037PPoDVe6F1WoiR1oBZ7o7ATkS2dqWw0/MsTU/X8/CNByVtRFOCgmgVmDp6yGDQr5FxdWIlHTsc0Zg0nzaMNQTrIKqtVb2JQRBB0pEx0Y4D7IteUcrGO+xNMsPXXRGBnRo9SuHsDncoCwMTljMQTc3nmgpa1onms8iqYrtHgiNpel86xYVDxHCxYG5wrciAqFCGBd0lt9Ok9oueqYovYnFc6mEIPK/Zjf/WdpkmN62+D1mbslizE/jO+SjYAOpTa3P3cwhE6EVrGxscgbEd7mcMEV1Rfz7bYhVJACRfcN6IAihrHj3Orayh4e4P2Qto2UGUCr3/V21rMeTYcF8RAza1Y3W1olaMx8uVqqyhG3OUr9qRCTj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39850400004)(136003)(396003)(366004)(53546011)(6512007)(86362001)(2616005)(31696002)(6506007)(478600001)(6486002)(52116002)(41300700001)(26005)(38350700002)(38100700002)(5660300002)(2906002)(54906003)(31686004)(316002)(8936002)(4326008)(110136005)(44832011)(186003)(36756003)(66476007)(66556008)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDQxbFFlaXE4aktRUnN1aEZBajdHWllpc1VDamkySUVHbURYRWJ0UXBXemcw?=
 =?utf-8?B?ZlZnMjNMT2wyKzRpQWM1Nm1kVVNwd0ZVZFFMQnVGR0xJUTZtZTVVZzN6eEdj?=
 =?utf-8?B?VFUyKzBuWXpiVk9sWlZIejNrOElNejNhUXVXbGRYbW9FcnNocHZTMWRLYitB?=
 =?utf-8?B?ajVLbTM4SlQ2YndWN01Vd1BXWjRLTHVHY3lIWkJjQkJMSHd6MFA5UlFOeVBE?=
 =?utf-8?B?ZWVwV09TakNIOEx4ZS85bk42SGRRTzhNVE1MRVlBN0xTVldPMGN6MjhNbHpk?=
 =?utf-8?B?dFVRaDBjU1B3ZC9kQVVnb01IWjU0bE9sSCtsZ3BCZ3M0cEZ1QVR4TjF3RGpl?=
 =?utf-8?B?RTcvWU5PQVBpeTBIOStJUnAzM2VqZzFYdEpVODJsMTZtUDZUYjRyaS84dkoy?=
 =?utf-8?B?RU05bHlETzVPYzZqMzFTeUFvV3M1TmtvaXRWazBqT2JtcDFWSXpiVUtGS0d4?=
 =?utf-8?B?UXpQUHZDTldET2JTZVY2TzlCejBvN1lRcm9FS2VxUnBFRUZwOCs4R1Z5ak5H?=
 =?utf-8?B?bFdMR2dMRzlQZWtnVFJDeUxKNG1yT0h6c0F0aE9lZHphWHlNQURYVnUzS3pS?=
 =?utf-8?B?ZmZqOWJZaVhvM21ZQXczR0YzNW84b2traFJIQTl1VU5GZ1ZQUG5wOUxTVmpK?=
 =?utf-8?B?eGxrSUJCa0VvS09QVnJWNEx5WjYyWlBtRGdFYjExQ2JHNWpiUERCTE1CbDdi?=
 =?utf-8?B?UGtXaXU0QmZBek9pUDFCZUJ0TyttcWh2ZkRrcmxuWURkS0NlelgwMFU3Zmhm?=
 =?utf-8?B?QWtWTCszeXRaWGtsQXpuQy9FcktSUHluRmNGd2RJQ0RRYXBFelR2eHo0MVNJ?=
 =?utf-8?B?K3gzRHZoMmk5OEZiMDVobHppdld3TTBzQjN3QlVuNjJJbUU3cW04c3lXWEdH?=
 =?utf-8?B?cHprN2RkbWI2VlE2M3FxNDZLbkxCSFpla09jTC9Xd2ZnVVFaVDlKQ2h3blJR?=
 =?utf-8?B?SDRsMis5WHptWjhCSnptRkVuemQrNGVtVVJjcTFlemphQ3R3SS8zWGR3Yndm?=
 =?utf-8?B?cVpZaXNScW5aQjJNd0JpMGJvMnNvRSszSXY0NVZLdmU0STFUa1FIWTBlVlI5?=
 =?utf-8?B?V0NMNGRVZHYyYWpGbXhGMWZpUi9pNjM0aG1heVhtbE1BYlNTNVFKcVBFSmMw?=
 =?utf-8?B?U0FnMHBhQUpGZm9CNVJFU2VxSTE5VEVIaWk5VzJOVkZjbUp2elVLLzhCbHZO?=
 =?utf-8?B?aTdGS2E4dFNZeHpFTVhOYjRncDZhMTl2c0IwdmViUi9jYzJSdUYvZ1Y5d0F4?=
 =?utf-8?B?TUhUQ0lDcmNJVTRtWkJ3YmwyUXVyNndyRFQ3VkxDbG1EZUVpUHpkSjMrM1RJ?=
 =?utf-8?B?N29zWTZjdy9ZU25YVVFadlJENWlmSWUvOElYZkFETjcvY09sakFPWUJ6bmZP?=
 =?utf-8?B?bVFhcFdSLzRxaDVnM0c1N3hqbHFyOGpJbHZkLytiQndxa0kxc2MxL1lQNHEx?=
 =?utf-8?B?bzd3NlNqd05QRWxsYmVCckxBUEJiaWZyN0RraUJQcWZiaVFhN3ZMV2lPNXZm?=
 =?utf-8?B?ZzRvUFZJVStuc2cvVVFNbjB5clNwRDRSZWZBdTZ5NzRKL25IaXh0c3JaMlB0?=
 =?utf-8?B?dVE0OUMwUDRuSkZIYkxNU0JsQ2FlZ1ZrNUowZ1R2Sm5jWlBEQ2ltdkh1TTRE?=
 =?utf-8?B?U2dFNnJLNXZjOHZyVjgwd204SGd1RVpnUU9vc05rMmNBWStYZGdYM21TT25t?=
 =?utf-8?B?U2xESTlsVGJqbGFNV0pQZFpBWkQrc0M1b040bFp6YndmWVBaeEc4am8rcTJk?=
 =?utf-8?B?TEFBemdlbm13OEE3RlQyZGhoeWtZank3ODc4UWEwejFrRzl6YThNOG5OSStQ?=
 =?utf-8?B?MmNwL1d1U1FDbjNia0pHbWZnczdQenJCMlFPWlIyWTNXVTViWXppcjNNS25T?=
 =?utf-8?B?YlRzOC9aa3VQWG1TemxncDlOdHp0S0VDQkpWUyt5djJXTnZ0ZTg2QVdKaFlO?=
 =?utf-8?B?WWpRaXRFa3FrSmRkQ0IvZlVBTkw1RW9CZFl3SjdlaE1PWC9DS3BlZGdZSE1N?=
 =?utf-8?B?dWdPWUlMNHBSQ29JVm40Mi9uY2lEQ082QzZreFJIengzOUMzajgwSkRCWGRY?=
 =?utf-8?B?clQzRGFKUFlxaENSZ0huTThMekxJTDNNNlN5c3ppSGV4Vlp0SjdyeDVGZllo?=
 =?utf-8?B?MDJiT1FkMyt4RUZONWRTWVBXSnFpRjl2RXZrMjRsYmVlTGo3UWhCcXI2NTVY?=
 =?utf-8?Q?A4vZn41NfEMPLsxOIu4JHw4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9985f6f-4d3f-4dab-3f09-08da90a920cf
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 08:15:30.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clL5yn8Ud//zu3NxIx6fN0+3ac7vwrjpHUfz56280RhHska9M44YIPdLm/98fFoQIbcAcrlgpSP11wNDc3XO6LeGgk07i9I9B0ksabq1gOGer2uLO7mRV60zLB1UPJuF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5763
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello,

On 3.09.22 7:37, Michael Kelley (LINUX) wrote:
> 
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


There is a lot of information that would not go into /proc/meminfo.
vmware have only one file with all, virtio have separate file for 
features to expose. HV doesn't have other files so i think file is still 
useful. Only the memory in kB will go into the /proc/meminfo - 
pages/page sizes would not. But i am not sure how to handle the 
situation since i guess it will take time for the MM guys to decide - 
there is currently only one Ack on the series.



-- 
Regards,
Alexander Atanasov

