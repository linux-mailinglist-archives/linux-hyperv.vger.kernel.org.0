Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D357C749995
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jul 2023 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjGFKlM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jul 2023 06:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGFKlK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jul 2023 06:41:10 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2125.outbound.protection.outlook.com [40.107.117.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4DF19B7;
        Thu,  6 Jul 2023 03:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnTqcQAlX6pqBhOBKCMjz3PHKTznHRSl2nsAznNr/s0d+d1W5faIl4ZaUbF9yK14k0dxreYKJAi121r521vRD5GFBFMyZ48WUBre6iHN/xAjl3JArNfxVJe+NeNbFN3qjiENxw4HRuAy48DC1aKu8Lme9KR9CeeO9VPsMCglj59St99Tfq85v6tw//czqwQkp0D03HWBdiSDTANR943K4XFEM39iN33z6twoAmOVAtSwml++WJUJIQ3yiqFoegKQWW9rMj0xQVB2BJ33LXs4AVtiT0ZKJ8DakIobF2cchNhcVpalFxVpMNzDhRpj5Xs6avEKD8DR2j4CmBcp8NEl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIZSLwMvWmd+Qt2ocuHV8IS7hq3GVYww9fWcCSC1Uk8=;
 b=PZ6z/I3LqEn/HyoFOFCuts89O8cGWGXsuqShXobRYV+XvkBG3VVWAAOQ7Au01lG8CO3e3ht86n0/NzHNvsnyA5ADRPvLmHECLfaAI9jcsfYoiPk8sV0YpqlRFmbafBCw0DFfErSLzaiG4WIjynmZxygryGHi/T3/Y0x73XErCDwoAA5/Y1KFD5UHVnVLPXKHkjlIKl+oPs3GM/PhEW5LKxQJFXLeR70mV8s7wEsQII5SwAIOvflpwvwyo6Ef7V0xewAkyQtmI4brljVkZ48q5d9gQrz7G5UgulEU4Ht7AGhMV9nPP6ce6so+3TVMOrhUWokQIW/neO+05dTOsrBoVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIZSLwMvWmd+Qt2ocuHV8IS7hq3GVYww9fWcCSC1Uk8=;
 b=IKGH+NPd20b86w5P34d3pT6Tqbsl5xiFB5qqRnhnbypY1GkkaPks7w60VqckpbJNwGhZBsZ7Ff64Bvuh2/bIxUwOZLs0Rq22UzMbjbP6ho+0tD/u+pZ4OZ3Q0+iYJRYp1lPA8bulIR34h7xawDnM/yIeeSzj9lEJQhT3ulyY76w=
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fc::10)
 by KL1P15301MB0465.APCP153.PROD.OUTLOOK.COM (2603:1096:820:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.12; Thu, 6 Jul
 2023 10:41:03 +0000
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::d752:54e0:7b75:4dc7]) by PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::d752:54e0:7b75:4dc7%6]) with mapi id 15.20.6588.010; Thu, 6 Jul 2023
 10:41:03 +0000
From:   Souradeep Chakrabarti <schakrabarti@microsoft.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        souradeep chakrabarti <schakrabarti@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload when
 host is unresponsive
Thread-Topic: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload when
 host is unresponsive
Thread-Index: AQHZrYtPYuWMOmYHY0O7H4YU8qW43q+oQRyAgAAkWPCAAttngIABTiXA
Date:   Thu, 6 Jul 2023 10:41:03 +0000
Message-ID: <PUZP153MB0788A5F92E65AC9A98AF03AFCC2CA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References: <1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
 <83ef6401-8736-8416-c898-2fbbb786726e@intel.com>
 <PUZP153MB07880E6D692FD5D13C508694CC29A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <7e316b51-be46-96db-84cb-addd28d90b0f@intel.com>
In-Reply-To: <7e316b51-be46-96db-84cb-addd28d90b0f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e419cbea-31f4-4c14-af00-57a30577b2f7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-06T10:31:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0788:EE_|KL1P15301MB0465:EE_
x-ms-office365-filtering-correlation-id: 8f1d7e81-6380-41c3-0d1d-08db7e0d7eda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzMn6Jw5kmiD51Tdw+ptuB9yu4JbSlWK3GOkqVBA8PrT3rTqt4bh5ETpjzuPXvzoZFmpGmpJ5UDK564zDOgQDCpdtUoXCk2Wmj5E7OBYlV8GkGdf+fzUXvLAjDzyKVn8ZG9tL4LtUTdGE5dCIUHlzZrrbXibQ/R0rODhYSpetP0ppiumHvRnX1JdFGhXgX1iU4amKQMfPX2ojnMEIKhzY8PFLAoWR/VcxghXr2DacW7sZl+Q/aFQP8ecn4aM58oaFctaEMhD1bCuYPghbgzHD/HhDU4Dmtt/NQtcTenrFbb4+kUV8pplqEAW3lmWrMulfOdpRqbyATlIpSAbq8vDwRW3bH3TVvaCPd8O0QMBjYZDaYlaL/P2BHJIZDs01Bny7ElEYHTgRiydB3OzmjEjcRVhviS4bVr26sRn4DTLUimpP1iVIWCc+Fxryg2V6KRJKqcfj3NvWcoMN53r7HA3ZmjPl4pNW9EMsQ6eC4P7QtHs9wEHwye606DhM7UlU6rYC3iG4LjH4wY1Qim3LJcCBF56vctgugvDe4b0hp76X/yCtDHU7S5eU8xMKalECwwFC7lUw4r8tMViZm/fcbYPVSpIg8qSVJKtjSCN3ABeoJtRjpxYVDdv3ZMS23bH5kAdxxNepSWrGcT9bDlRsp62WM0n0HRxiN6RMy8euFodzu4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0788.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(6506007)(10290500003)(186003)(83380400001)(66946007)(9686003)(26005)(71200400001)(478600001)(122000001)(38100700002)(76116006)(54906003)(4326008)(82960400001)(82950400001)(966005)(7696005)(110136005)(66476007)(316002)(66446008)(64756008)(66556008)(52536014)(5660300002)(2906002)(7416002)(86362001)(8990500004)(66899021)(38070700005)(8936002)(41300700001)(8676002)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TyQzWMiGp/C3XRkivJ9z9IM7mPasTt333qnJkj/J1HAFiASno+kvfnNuhK+Q?=
 =?us-ascii?Q?SWn3yXgx7ivY/mgRl9RiwkOl9Wtxgy8ruE6zr4IUrT4J0uL86OmTeeZeCeJR?=
 =?us-ascii?Q?3mBZOUuxH9sLLeLfKR/3Vfq2Z/q0xktvuo7KCkv7URJTQ8IWy7A1G8zuWBsR?=
 =?us-ascii?Q?lCE4tffOP0cqhICxKIdM3ClZBVpaDSlCTaE8cCY3t/8H6YGQ1z9Mod57VkjO?=
 =?us-ascii?Q?DH+l7f6ozcLzyLKT0H1t6RSlPOrkbcuDdYc+m2+AW6IQRvRDsI8IcVM42k/r?=
 =?us-ascii?Q?cN+Mvjd7ggRMBClmRVjqLeB38P/Qs8KLT9X9daYHbe6HBzUBMDOO1lLqEFL0?=
 =?us-ascii?Q?KZmo8jVPY/59s0z5fSr9/RzA/RfDrWJaBbFI5sSSbJeOxNird9UCwqkssfG0?=
 =?us-ascii?Q?01rke7GGcMwfvzXkMgwnrko26rUOlRzK1eOz7v/WNZFYHEUR3T6k0CXVaLul?=
 =?us-ascii?Q?2hC3L7i0Fyxw//S5WC3u0dQE3KhCHJOlAhbGU3CzELpR3Et72Jc/nwXzVamP?=
 =?us-ascii?Q?3dWNZ2yNDJmUTgC4iyvrsYMsFlBYhWstqpf9JcG3lG1tEG/Rm12GpRaDhuMt?=
 =?us-ascii?Q?anp0Y7wBd4PLXqJ6cXGl5twpaTZTXYiR1In1bF3LgfmDNSXcrA2dBKOTLMvI?=
 =?us-ascii?Q?Vc/f2og3ADlYY+QDKkvckoSIdH7vqywoF9i2ppB4Cuk/dQHh+7g0CRy9NQZp?=
 =?us-ascii?Q?DtwsTpWxgaryExlOTvZcgnl1y6YA2ejQhbSHqsaG9qeKm72vurJ1NFp/o61F?=
 =?us-ascii?Q?M4DQv+Np1dL20ArV1Z8pbXRTr35YQAXho70QG2mJMRyOACkO8ueaUDsx0moI?=
 =?us-ascii?Q?37SUeT4fW4osUJq7NZr2ye2wJnn14XIsI21E2k71qyL4XyCU7vZ+2KywOPQr?=
 =?us-ascii?Q?XZE8XtQR14SLsjv7tzTDbc/farEvP39IGbJuCXdofjLa0cgnSjQJDvgikait?=
 =?us-ascii?Q?pD+pNwDeH0zJtZeWvieNg3HTDsw4CqfTWyfch4po3ndx0euBbU9D7Wa9YS0h?=
 =?us-ascii?Q?I6mfO/lRPZ8AfXKVYQMxJn7PBXrgfDNeGlfBYNAWlxJvTBuUJSB5BjAsKijl?=
 =?us-ascii?Q?X8TrXNj0chZWVJ6JjlZ73GvAk4+dr8F93HzeWi14eZ69FMen0xY3j5txMULe?=
 =?us-ascii?Q?ZYmrhor5C15Lhej9m0SQAkgfGIDPHf7RGc7CKRLTUNX5dpnQXMuLaGKCr7dC?=
 =?us-ascii?Q?RnyAhf9VPSd9evFPoqN5OJg6fI+MwX/hVYO/Oyo5ynlVeSep233rJB021YOe?=
 =?us-ascii?Q?eae3uKn9paUudxblNw2CigN+Dc2vqH+ZuQ36lHGDf43cIjMxttswbyrtRF9M?=
 =?us-ascii?Q?O8M6ng+x09A2qx38bBYrpJIiXeuamVqafijeHohxuo9exgeaNAGnzIFHE/Br?=
 =?us-ascii?Q?vic26MLceDCm0mNAN4n5wYAb8S1yxy4CjjbHrNQ32f6FgZR2/iDTfdbiVv5u?=
 =?us-ascii?Q?K/saYhdj6E7x94D6ruiXZhVJhYst9aZcvafy+p2AVMNUwZmoiKkzEAR4XY5R?=
 =?us-ascii?Q?rC9AAAv1WsmMnYN+BDa1wFPd+OAONap7J3TD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1d7e81-6380-41c3-0d1d-08db7e0d7eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 10:41:03.0531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pW6uJ60z7POQg5Ti5BxSif9zU447Oi1rnOcrbsi3TeWexxAhqY5pZySXpuEScwtcCI0zojlgxBX9s1sjwlM9Alm/FmZ67NHPGXZOWmuR3io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0465
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



>-----Original Message-----
>From: Alexander Lobakin <aleksander.lobakin@intel.com>
>Sent: Wednesday, July 5, 2023 8:06 PM
>To: Souradeep Chakrabarti <schakrabarti@microsoft.com>; souradeep
>chakrabarti <schakrabarti@linux.microsoft.com>
>Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
>kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Ajay
>Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
>cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com;
>tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org;
>linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org;
>stable@vger.kernel.org
>Subject: Re: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload
>when host is unresponsive
>
>[You don't often get email from aleksander.lobakin@intel.com. Learn why th=
is is
>important at https://aka.ms/LearnAboutSenderIdentification ]
>
>From: Souradeep Chakrabarti <schakrabarti@microsoft.com>
>Date: Mon, 3 Jul 2023 19:55:06 +0000
>
>>
>>
>>> -----Original Message-----
>>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> Sent: Monday, July 3, 2023 10:18 PM
>
>[...]
>
>>>>     for (i =3D 0; i < apc->num_queues; i++) {
>>>>             txq =3D &apc->tx_qp[i].txq;
>>>> -
>>>> -           while (atomic_read(&txq->pending_sends) > 0)
>>>> +           while (atomic_read(&txq->pending_sends) > 0 &&
>>>> +                  time_before(jiffies, timeout)) {
>>>>                     usleep_range(1000, 2000);> +            }
>>>>     }
>>>
>>> 120 seconds by 2 msec step is 60000 iterations, by 1 msec is 120000
>>> iterations. I know usleep_range() often is much less precise, but still=
.
>>> Do you really need that much time? Has this been measured during the
>>> tests that it can take up to 120 seconds or is it just some random
>>> value that "should be enough"?
>>> If you really need 120 seconds, I'd suggest using a timer / delayed
>>> work instead of wasting resources.
>> Here the intent is not waiting for 120 seconds, rather than avoid
>> continue checking the pending_sends  of each tx queues for an indefinite=
 time,
>before freeing sk_buffs.
>> The pending_sends can only get decreased for a tx queue,  if
>> mana_poll_tx_cq() gets called for a completion notification and increase=
d by
>xmit.
>>
>> In this particular bug, apc->port_is_up is not set to false, causing
>> xmit to keep increasing the pending_sends for the queue and
>> mana_poll_tx_cq() not getting called for the queue.
>>
>> If we see the comment in the function mana_dealloc_queues(), it mentions=
 it :
>>
>> 2346     /* No packet can be transmitted now since apc->port_is_up is fa=
lse.
>> 2347      * There is still a tiny chance that mana_poll_tx_cq() can re-e=
nable
>> 2348      * a txq because it may not timely see apc->port_is_up being cl=
eared
>> 2349      * to false, but it doesn't matter since mana_start_xmit() drop=
s any
>> 2350      * new packets due to apc->port_is_up being false.
>>
>> The value 120 seconds has been decided here based on maximum number of
>> queues
>
>This is quite opposite to what you're saying above. How should I connect t=
hese
>two:
>
>Here the intent is not waiting for 120 seconds
>
>+
>
>The value 120 seconds has been decided here based on maximum number of
>queues
>
>?
>Can cleaning the Tx queues really last for 120 seconds?
>My understanding is that timeouts need to be sensible and not go to the ou=
ter
>space. What is the medium value you got during the tests?
>
For each queue each takes few milli second, in a normal condition. So
based on maximum number of allowed queues for our h/w it won't
go beyond a sec.=20
The 120s only happens rarely during some NIC HW issue -unexpected.
So this timeout will only trigger in a very rare scenario.
>> are allowed in this specific hardware, it is a safe assumption.
>>>
>>>>
>>>> +   for (i =3D 0; i < apc->num_queues; i++) {
>>>> +           txq =3D &apc->tx_qp[i].txq;
>>>> +           cq =3D &apc->tx_qp[i].tx_cq;
>>>
>>> cq can be just &txq->tx_cq.
>> mana_txq  structure does not have a pointer to mana_cq.
>
>Sorry, misread, my bad.
>
>>>
>>>> +           while (atomic_read(&txq->pending_sends)) {
>>>> +                   skb =3D skb_dequeue(&txq->pending_skbs);
>>>> +                   mana_unmap_skb(skb, apc);
>>>> +                   napi_consume_skb(skb, cq->budget);
>>>
>>> (you already have comment about this one)
>>>
>>>> +                   atomic_sub(1, &txq->pending_sends);
>>>> +           }
>>>> +   }
>>>>     /* We're 100% sure the queues can no longer be woken up, because
>>>>      * we're sure now mana_poll_tx_cq() can't be running.
>>>>      */
>>>
>>> Thanks,
>>> Olek
>Thanks,
>Olek
