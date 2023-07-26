Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EAD763656
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jul 2023 14:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGZMbw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Jul 2023 08:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjGZMbv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Jul 2023 08:31:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2130.outbound.protection.outlook.com [40.107.92.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EA912C;
        Wed, 26 Jul 2023 05:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAb08+emvXd9syzKTs3c510kLK6lfb5VMsn+v1r4W2iMgOTBc3lahJ9Z9ggYShtEcbFfJ7NeVa5KR1RU/tXyj7LKjfRcJCMfEqIgxMe4Pq4C2b1ZHpNIktGJRyeeUDMPfJibaLMfez9/R6S9c3MiNgXM/l3MhJ7aTJIE34BYqf4f8M8kB0KCZsB/qgL+Skl79AB2ggqSGR7cckzq8H3RaQJKfIbG4VBJONd9mstAgMIWx9MMrj6Tl+9FopxTROEJ+bIdu3ylH7iKu+SUSiPqupADrl36lRAsvyJobvdSI6WvOe0lhRsfMeBk3Hf3+CXJHHVcldV7ePLgCB7h8u4ZgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UwF5lT5cHsHi/+MGSLJlxcbQjXiTtDGKA3i/wh4/fM=;
 b=oEAbOZ8bl8qOpv99EgoH6mq/GtVaQ2f9LQ34PS26VLonCTwpSQ2XzVJwqt3hJiPYwY1NpvTpKFlFn5BA26+PfjMrMsUl8Dk1HqDiogufAycwQEPbM/tmIWtx/7hdIX8N9vLdslaCdN0jQX54Tp8Wlld/ZKxkCZNqRpM0bdzs/CzGMUp8PotGPbL0MlkdOTQs/QipcpPy65VTYhKQ1c5aHVBUmdb7zic6jEBxpfmMTEsZqmlVtfRoDOLMzRH2wnu5N0WsrUwNSvKiyZbsMu15NNrXtY3c6aZhwjgonJm2fxVREy1+MywbqBtKXRsDWvz8IGLWYW3EYuzm3v6QpAYmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UwF5lT5cHsHi/+MGSLJlxcbQjXiTtDGKA3i/wh4/fM=;
 b=KDp15JUqAZoZfAjyTubX2bNQoWdXgJ6HjU044xtry4iyZHI7E0p2gZ7Hz+OYxr2U0hLicdjx+vgtLqEfsYJ3fc5w973Y1s5jDwLS4bWsWtq2EW1szMA8GqbmCeM+Ix0nOrbuAhU05bd7i3GAW5krB7KbNW8/fmPQO6n6VOhszlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5568.namprd13.prod.outlook.com (2603:10b6:510:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 12:31:47 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 12:31:47 +0000
Date:   Wed, 26 Jul 2023 14:31:41 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     sharmaajay@linuxonhyperv.com
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [Patch v2 5/5] RDMA/mana_ib : Query adapter capabilities
Message-ID: <ZMESLQsNgTGnD2j/@corigine.com>
References: <1690343820-20188-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1690343820-20188-6-git-send-email-sharmaajay@linuxonhyperv.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690343820-20188-6-git-send-email-sharmaajay@linuxonhyperv.com>
X-ClientProxiedBy: AS4P190CA0038.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5568:EE_
X-MS-Office365-Filtering-Correlation-Id: de71dce9-781c-4530-74cf-08db8dd44774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McRD/wnROA42ZvJP9oeTxII+4Q/EmgtWnudiOmAnTqDLd05dXS8fORB1BqGg26Jn4GLvNxd9WFjr8/s0xWhtPcAKdap4+YE+HKjdpKPz/Ic85WiSZPO6XjJd/Pso2z2lruOFRwYTxTsmv1yy6u4Po5mou+5/NnIY7sw8Lv+pU6FcYmTlPl7XWopNuc3OdSwgpqWR20+7I54vjpLmrjHvW+maaLkDTraz/TdtU3abK6S/UOHEXSpF2+Oe4REsD92cK3DXeyHZVQWFGxbpDL5qvawPDX7A2SwP7UhnpLTuDMExPszeemPxqU6G4+C3ldwE36EOkGN5BYY+t0lE/VL7FUYIzQWSfBjRU4FO8bJQT8o/O39xEoXV/E15tJ8mPA5hu6Hz6JNIYcDbavVwPOof5V0QeWtrcfr80kK+Z1VFfNYAqRrPF9Q8q1rK2zAOF30qkjVDjm8Pc4dQJe6w89L4bB7AMOty8tSt689TeD/ogAPUOWbKAzB3bCEK6dA9Ocba9tw/VhKPgIgZHulvhH2lqY7zuVcJyxu+zFLCvmQ/hhLilQ8LzTM1kWbxaVQ3R6k8yRpNsWWah9o5UaL4xHeONX6xRmbm4bRMqQIqQ8LODgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39840400004)(451199021)(6512007)(6486002)(478600001)(54906003)(6666004)(83380400001)(86362001)(2906002)(2616005)(4326008)(6506007)(5660300002)(186003)(66476007)(36756003)(38100700002)(44832011)(8676002)(41300700001)(66556008)(8936002)(66946007)(316002)(7416002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b3eU6ZfwJ+Cht+4GrrKHH5G9JA9QCq2GAE8jIaUfE9Fg2WVz/WbE8swzNsmc?=
 =?us-ascii?Q?801mTO9KER8JW15olE3yo6KHKLuUNpqFXne6yumcYfyVkOnJc5FtLC4Azqup?=
 =?us-ascii?Q?sGHRIWB5cPlPe0pway2ngDaa+ifvpcW/scfaeXhErGv55mvyp96FAnIDzg8P?=
 =?us-ascii?Q?W6s/9o/VkdYJVrZfmnDDpqt89k5mLtLc7G5YoULlsc3A/7xe9upPFKl5DZSV?=
 =?us-ascii?Q?73EwpppC2vDJkJfqpU3Ewx7LFi9AAPpa3trRTOuAldiCMflA+CoptZdMuEFX?=
 =?us-ascii?Q?IDSnFB76WeheD5BHDs+RCXeUuvgjdvGlfSLeAGdE12MV7j4pxthHuZNSrulT?=
 =?us-ascii?Q?al85f/oUEPjsbvTXHeY3hDOX/Yl+6CelqyxbKPRnOMU4aahL/XRy475pljBC?=
 =?us-ascii?Q?VCoAxCP0XTjqG6LaykmswnsjmMVmvrbIi6OP5oJGlZenC8R7RugUFIl9bnob?=
 =?us-ascii?Q?v8VZQvd+baDgC0ygnv/Htrn25zQ/IAmgelz1/5xG32hZlXlhhMje6TfLeOlZ?=
 =?us-ascii?Q?mRygRBoqFs1FeT/jpfTCBP734JI51pYkqlV0+Wp6Pfmj3Ps5RyVoSJrUoBT+?=
 =?us-ascii?Q?ZmUoHblSBBnw2k7P6P7Y+vVyEkCBD//ATy1E7aDCV42kdz9mHl9yug/Tc2R/?=
 =?us-ascii?Q?jcjB+RW83qKj/roUhX0s+F5Py5PlLZDWkFhLFXhSM4jSgE0vQK64EMBwI+yI?=
 =?us-ascii?Q?C/ApW/5u7QKxElVRQBIC+C4gTGWLvt8C+sD27Oqpgn8ihan3IlvDLubj/7bI?=
 =?us-ascii?Q?kRSu+g3U7DaBfIfMIeXcPigdPIaIs/TTDHaAroDguuQH/Y00x0BFuGB1NiJ9?=
 =?us-ascii?Q?dldKsbYUEb6MU7ipe6tPp+s9ypcqRSTyPlWWtsge1mYvkUUel/KuFr6VRqGt?=
 =?us-ascii?Q?q4mK6Xh1unarfUgL7rrT4WwdSQ35vD838yV0/0/FEhLjRd6Sr3CP88NJt2B3?=
 =?us-ascii?Q?zQO6hNX61nh63Uj3fPoaww6Kam1chMexNj2AgJYvm4KM2n30jXZVWfBZ4KXY?=
 =?us-ascii?Q?B4l9PZ6Cko+e8AtUzG2DLNVuE35ufwDEb0pFfLWPAbkqL8hh2n98aUFgwrdQ?=
 =?us-ascii?Q?4NXxwZrkbveyDiK7tqVPA9R2PrHH7K8QFFZyF+p6VY5eXlJ8MmcQqOD5cazp?=
 =?us-ascii?Q?8ZwbrHe7kYhDNqRqzvnEJ1rt00snUwoSqFSq8t0T36DGXRr1v7skZHIp5fuO?=
 =?us-ascii?Q?zXXRTQ80PA3fkfX4MbhVp04V+ryH1edsQYDR5eVuFaCT0gq8mcBwYgWFc+sE?=
 =?us-ascii?Q?VbkTqVor8ruNj6XHgan8pMkHQpekORlRDiohN5pAPPaP1x0IFcPxcTxW0jFq?=
 =?us-ascii?Q?Z93t3wPLmbyQvxR0b5GgECQYoZwSH8HFJaCi0BQX1kcCJko86w2/ekIgMOa8?=
 =?us-ascii?Q?52SFJ2GqLuGApNmYrkrk11OGPsWXPI4sYjnooAc/oMsHIh6zJD3FvBmJtOac?=
 =?us-ascii?Q?Tai0ggvs3Yjlgd5++haKEnD7XkLIT01l25yhhUWjbafQtkNdtpPzb5DCrCqV?=
 =?us-ascii?Q?AjebhsWEvaxzJiiALNoUJErRMe+COMyFQptcbDON2vlifeSkzJ43juNzSWcP?=
 =?us-ascii?Q?LFmeuiAG1lHQqC6f4PgD0kuJigBzwz+pmEwqI7OXWuwaNZDNQ6j23UbcLVTT?=
 =?us-ascii?Q?jWRsTumdNDcLCXdsVkMB2uPryDMjPO6NFR0+Qq0AO+lvzSPVSHfKjm3EFKEQ?=
 =?us-ascii?Q?SH9Kxw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de71dce9-781c-4530-74cf-08db8dd44774
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:31:47.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEwAl6wdSzlPUUDc5ucCwsSym6IrahA08+D6YIzI7aBfO0pCvQx8fGKCaklu68sSeActFfJKMRjlHMdKh4z/mr32sj4ZaHMkPKqc2B1Iu/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5568
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 25, 2023 at 08:57:00PM -0700, sharmaajay@linuxonhyperv.com wrote:

...

> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c

...

> +int mana_ib_query_adapter_caps(struct mana_ib_dev *mib_dev)
> +{
> +	struct mana_ib_query_adapter_caps_resp resp = {};
> +	struct mana_ib_query_adapter_caps_req req = {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_IB_GET_ADAPTER_CAP, sizeof(req),
> +			     sizeof(resp));
> +	req.hdr.resp.msg_version = MANA_IB__GET_ADAPTER_CAP_RESPONSE_V3;
> +	req.hdr.dev_id = mib_dev->gc->mana_ib.dev_id;
> +
> +	err = mana_gd_send_request(mib_dev->gc, sizeof(req), &req,
> +				   sizeof(resp), &resp);
> +
> +	if (err) {
> +		ibdev_err(&mib_dev->ib_dev, "Failed to query adapter caps err %d", err);
> +		return err;
> +	}
> +
> +	memcpy(&mib_dev->adapter_caps, &resp.max_sq_id,
> +			sizeof(mib_dev->adapter_caps));

Hi Ajay,

The indentation of the line above is off.

	memcpy(&mib_dev->adapter_caps, &resp.max_sq_id,
	       sizeof(mib_dev->adapter_caps));

But, perhaps more importantly, an x86_64 allmodconfig W=1 build with gcc-12
yields:

 In file included from ./include/linux/string.h:254,
                  from ./include/linux/bitmap.h:11,
                  from ./include/linux/ethtool.h:16,
                  from ./include/rdma/ib_verbs.h:15,
                  from drivers/infiniband/hw/mana/mana_ib.h:9,
                  from drivers/infiniband/hw/mana/main.c:6:
 In function 'fortify_memcpy_chk',
     inlined from 'mana_ib_query_adapter_caps' at drivers/infiniband/hw/mana/main.c:626:2:
 ./include/linux/fortify-string.h:592:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
   592 |                         __read_overflow2_field(q_size_field, size);
       |

> +	return 0;
> +}

...
